# Memory, pools and limits

How GTA V sizes its memory: the fixed pools in `gameconfig.xml`, the hard entity limits (peds, vehicles, objects), what the limit-adjuster mods change, how Rockstar's scripts stay under the limits, and what happens when a pool fills. Roadmap topic **R1.4** in the [roadmap](/ROADMAP.md). Extends the stack-pool table in [guide 1, section 1.4](/docs/core/runtime-scripts.md#14-script-stack-pools).

**How it was made.** `common\data\gameconfig.xml` was extracted from the vanilla `update\update.rpf` and from a modded `update.rpf` in OpenIV's mods folder with `tools/rpf-cw.ps1`, every pool and limit was pulled out with a short Perl script, and the two were compared value by value (137 differences in the base config). The sizes the game really used come from `PoolManager_Startup.log` (230 pools, written by the PoolManager plugin at start-up). The adjusters' settings come from their `.ini`/`.toml` files and `HeapAdjuster.log`; script usage of the budget natives from one `git grep -c` per native on the build-3725 decompile. **Verified** unless marked **Known**.

## 7.1 Short version

- **Almost every kind of thing in the game lives in a fixed-size pool** allocated at start-up: entities, tasks, events, streamed assets, scenario points, cameras, AI directors. There are about 230. The sizes come from `gameconfig.xml` (`PoolSizes`), or are built into the executable when the file doesn't name them.
- **The entity limits are small and fixed:** **256 peds**, **300 vehicles**, 2,300 objects, 8,192 AI tasks, set in `gameconfig.xml` and left alone even by the heavy modded copy (raising them is **Known** to destabilise the game, because dozens of per-ped and per-vehicle pools are sized to match). The population settings (`MaxTotalPeds` 200, `VehicleUpperLimit` 130) keep the ambient world well under them.
- **What the limit adjusters do:** `gameconfig.xml` raises pools (the test install's copy raises 137 values: streaming stores x2 to x7.5, scenario and AI pools x2 to x30, model-info limits to 5,000); **HeapAdjuster** raises the game heap from 478 MB to 1,950 MB; **PackfileLimitAdjuster** raises the archive count to 7,344; **WeaponLimitsAdjuster** raises weapon info files to 512 and weapon components to 1,024; the **DecalsLimit patch** raises decal definitions to 620 and a streaming box size to 6,000; **PoolManager** only logs.
- **When a pool fills, the game usually crashes** with no clear message (`ERR_MEM_POOLALLOC_ALLOC` style errors are **Known**); PoolManager's job is to write the pool's name to `PoolManager_Crash.log` first. Some systems fail softly instead: a new ped or vehicle simply doesn't spawn (the create native returns 0), a script can't start because its stack pool is empty.
- **Rockstar's scripts check before they create:** `CAN_REGISTER_MISSION_PEDS`/`VEHICLES`/`OBJECTS` (in 229 to 316 scripts), population budgets (`SET_PED_POPULATION_BUDGET` in 70), per-frame density multipliers (in 158 to 180), and `SET_MODEL_AS_NO_LONGER_NEEDED` (23,990 calls) after every `HAS_MODEL_LOADED`.
- **Bigger pools cost memory, not speed.** Raising a pool reserves memory at start-up for every slot; on a machine short of RAM, oversized pools leave less for streaming, which shows up as pop-in and freezes, not as a crash.

## 7.2 Where the limits come from

| Source | What it sets | Who can change it |
| --- | --- | --- |
| `gameconfig.xml` `PoolSizes` | Most pools by name (peds, vehicles, objects, stores, AI, scenarios, tasks, events) | Edit the file in the mods folder's `update.rpf` |
| `gameconfig.xml` `ConfigPopulation` | Ambient population caps and multipliers | Same |
| `gameconfig.xml` `ConfigModelInfo` | How many model definitions of each kind (peds, vehicles, weapons, interiors) can be registered | Same; add-on packs need these |
| `gameconfig.xml` `ConfigStreamingEngine` | Archive count (how many RPFs can be mounted), streaming buffers | Same, plus PackfileLimitAdjuster |
| `gameconfig.xml` `ConfigScriptStackSizes` | Script stack pools ([guide 1](/docs/core/runtime-scripts.md#14-script-stack-pools)) | Same |
| The executable | Pools the file doesn't name (per-ped intelligence and movement, cameras, incidents, script handlers), the game heap, weapon info and component arrays, decal definitions, some streaming structures | Only memory patches (the adjuster plugins) |

The file has one base block (`Build Any / Platforms Any`) and override blocks for debug, beta and non-final builds and for PS4 and Xbox One; on PC only the base block applies (plus one `x64` override) (**Verified**).

## 7.3 The pools that matter, vanilla vs modded vs used

"Used" is the size the game actually allocated, from `PoolManager_Startup.log`.

| Pool | What it holds | Vanilla | Modded file | Used |
| --- | --- | --- | --- | --- |
| `Peds` | Every ped (player, ambient, mission, cutscene) | 256 | 256 | **256** |
| `Vehicles` | Every vehicle | 300 | 300 | **300** |
| `PedIntelligence`, `CMovePed` | Per-ped AI and movement (same size as peds) | | | 256 |
| `Object` | Props created at run time | 2,300 | 2,300 | 2,300 |
| `Dummy Object` | Map props not yet turned into real objects | 10,010 | 15,000 | 15,000 |
| `Building` | Static map buildings | 60,000 | 66,000 | 66,000 |
| `CTask` | Running AI tasks | 8,192 | 8,192 | 8,192 |
| `CEvent` | AI events waiting to be handled ([combat guide](/docs/ai/combat-and-perception.md)) | 950 | 4,200 | 4,200 |
| `CCombatDirector`, `CCombatSituation`, `CTacticalAnalysis` | Group combat brains | 5, 6, 3 | 50, 60, 30 | 50, 60, 30 |
| `CScenarioInfo` | Scenario definitions | 250 | 885 | 885 |
| `ScenarioPoint` | Scenario points from map and scripts | 900 | 1,800 | 1,800 |
| `CCargen` | Car generators (parked cars) | 800 | 8,000 | 8,000 |
| `CRoadBlock` | Police roadblocks | 3 | 36 | 36 |
| `Incidents`, `Orders` | Dispatch incidents and orders | not in file | 204, 444 | 204, 444 |
| `DrawableStore`, `TxdStore`, `FragmentStore`, `DwdStore` | Streamed models and texture dictionaries (slots, not loaded assets) | 79,600, 80,000, 41,500, 20,500 | 161,965, 213,500, 299,000, 153,800 | same as modded |
| `MapDataStore`, `MapTypesStore` | `ymap` and `ytyp` files | 10,020, 1,700 | 50,000, 3,100 | same |
| `StaticBounds` | Collision files | 14,700 | 46,700 | 46,700 |
| `InteriorInst`, `InteriorProxy`, `PortalInst` | Interiors | 150, 1,195, 200 | 900, 9,200, 600 | same |
| `HandlingData` | Handling entries | 1,750 | 5,450 | 5,450 |
| `ScriptStore` | Compiled scripts that can be registered | 1,150 | 1,200 | 1,200 |
| `CGameScriptHandler`, `fwScriptGuid` | Running script handlers and script entity handles | not in file | 400, 3,072 | 400, 3,072 |
| `CWeapon`, `CWeaponComponent` | Weapon instances and their attachments | 1,024, not in file | 1,024, 440 | 1,024, 440 |
| `Wheels` | Vehicle wheels | not in file | 3,000 | 3,000 |
| `LightEntity` | Light sources | 4,750 | 6,550 | 6,550 |
| `PtFxAssetStore`, `PtFxSortedEntity` | Particle assets and particle-emitting entities | 400, 384 | 600, 1,000 | same |
| `CamBaseCamera` | Cameras | | | 27 |
| `ExplosionType` | Explosion types | | | 18 |

## 7.4 What the test install's modded `gameconfig.xml` changes

137 values differ from vanilla in the base block (**Verified**):

| Group | Change | Examples |
| --- | --- | --- |
| Streaming stores | x1.4 to x11 | `ActiveLoadedInfo` 3,000 to 24,000, `MaxLoadedInfo` 32,768 to 46,000, `FragmentStore` x7.2, `DwdStore` x7.5, `TxdStore` x2.7, `MapDataStore` x5 |
| Model info limits | x5 to x43 | `MaxVehicleModelInfos` 320 to 5,000, `MaxPedModelInfos` 725 to 5,000, `MaxWeaponModelInfos` 115 to 5,000, `MaxExtraVehicleModelInfos` 630 to 5,225 |
| AI and scenarios | x2 to x33 | `CombatMeleeManager_Groups` 3 to 100, `CombatMountedManager_Attacks` 1 to 30, `CCombatInfo` 16 to 170, `CCargen` x10, scenario points x2 |
| Map effects (2d effects) | x1.7 to x4 | `MaxAttrsDecal` and `MaxAttrsExplosion` 50 to 200, `MaxAttrsParticle` 2,500 to 5,000 |
| Population | Parked cars x1.3; base caps 40 to 50 | `VehicleParkedDensityMultiplier` 100 to 130, `VehicleUpperLimit_Base` 40 to 50 (ambient peds and `MaxTotalPeds` unchanged) |
| Archives | `ArchiveCount` 4,184 to 6,024 | (PackfileLimitAdjuster raises it further, to 7,344) |
| New entries | 40 pools the vanilla file leaves to the executable, named with their engine sizes | `cbullet` 60, `cplayerinfo` 132, `crelationshipgroup` 300, `tasksequenceinfo` 4,800 |
| Missing | `fwArchetypePooledMap` (64,000 in vanilla) | The game still used 65,521 (from the executable or another plugin) |

This is a "gameconfig for heavy mod packs" of the usual community kind, and like many community copies it is an older-build file (lowercase pool names, a missing entry). It is what lets large add-on packs and police or AI overhauls work without pool crashes.

## 7.5 The adjuster plugins

| Plugin | Setting here | Vanilla | What it does |
| --- | --- | --- | --- |
| `HeapAdjuster.asi` | `HEAP_SIZE = 1950` | 478 MB (from its log) | Raises the main game heap, where most run-time allocations go. Needed for big add-on packs; costs RAM up front |
| `PackfileLimitAdjuster.asi` | `packfile_list_size = 7344` | 4,184 (`ArchiveCount`) | Raises how many RPF archives can be mounted (every DLC pack mounts several) |
| `WeaponLimitsAdjuster.asi` | `CWeaponInfoBlob = 512`, `CWeaponComponentInfo = 1024` | **Known**: lower built-in arrays | Lets more `weapons.meta` files and weapon components load (add-on weapons) |
| `fwBoxStreamerVariable_DecalsLimit-Patch.asi` | `DecalDefs = 620`, `fwBoxStreamerVariableSize = 6000` | Minimums 512 and 1,048 (from its comments) | Decal definitions and a map streaming structure that add-on maps overflow |
| `PoolManager.asi` | `LogInitialPoolAmounts = 1`, usage warning off | | Logs every pool's size at start-up and the pool that overflowed on a crash. Changes nothing |

## 7.6 How the game's scripts stay under the limits

| Native | Calls in the decompile | Scripts | Use |
| --- | --- | --- | --- |
| `HAS_MODEL_LOADED` / `SET_MODEL_AS_NO_LONGER_NEEDED` | 18,764 / 23,990 | 739 / 697 | Every model request is released once the entity exists, so the model slot can be reused |
| `CAN_REGISTER_MISSION_PEDS` / `VEHICLES` / `OBJECTS` | 467 / 892 / 938 | 229 / 316 / 298 | Check there is room before creating mission entities |
| `CAN_REGISTER_MISSION_ENTITIES` | 265 | 50 | The same for a mix |
| `RESERVE_NETWORK_MISSION_PEDS`, `GET_NUM_RESERVED_MISSION_PEDS` | 289, 405 | 215, 311 | Online: reserve slots before creating networked entities |
| `SET_PED_POPULATION_BUDGET`, `SET_VEHICLE_POPULATION_BUDGET` | 291, 361 | 70, 76 | Lower the ambient population (0 to 3) during heavy missions |
| `SET_REDUCE_PED_MODEL_BUDGET`, `SET_REDUCE_VEHICLE_MODEL_BUDGET` | 101, 108 | 47, 49 | Use fewer different ambient models (frees streaming memory) |
| `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME`, `SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` | 321, 549 | 158, 180 | Thin out ambient peds and traffic each frame |
| `GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE` | 82 | 31 | Check a script stack pool before starting a script |
| `IS_MODEL_IN_CDIMAGE` | 474 | 159 | Check a model exists before requesting it |

So a heavy story mission typically: lowers the population budget, requests its models, checks `CAN_REGISTER_MISSION_*`, creates, releases the models, and restores the budget at cleanup ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).

## 7.7 What this means for modders

- **Count against 256 peds and 300 vehicles, not against "how much the PC can take".** The ambient world already uses some (a test session peaked at 33 peds and 82 vehicles in 10 minutes of free roam); a mod's spawn caps should leave room for the world and for missions. On a low-end PC the frame rate fails long before the pool does.
- **Do what Rockstar's scripts do:** check with `CAN_REGISTER_MISSION_PEDS`/`VEHICLES`/`OBJECTS` before a burst of spawns, release every model with `SET_MODEL_AS_NO_LONGER_NEEDED`, delete or mark as no longer needed every entity a mod made, and lower the population budget instead of spawning more on top of it.
- **A create native that returns 0 means "no room" or "model not loaded":** log it rather than retrying every frame.
- **Don't raise pools beyond what your mods need.** A heavy-mod `gameconfig.xml` plus HeapAdjuster already reserve far more than the vanilla game; more reservation leaves less RAM for streaming, especially on a 16 GB machine with integrated graphics, and shows up as pop-in and freezes.
- **When a modded `update.rpf` is rebuilt** ([surviving updates](/docs/core/surviving-updates.md)), start the new `gameconfig.xml` from the current vanilla file and re-apply the raised values, keeping `fwArchetypePooledMap`.
- **On a crash, read `PoolManager_Crash.log` first:** it names the pool that overflowed.

## 7.8 Test cards

1. **Pool crash log.** After any crash, open `PoolManager_Crash.log` and note the pool name and size; if a pool shows its vanilla size there, the modded `gameconfig.xml` was not in use for that launch.
2. **Spawn limit.** With a trainer, spawn vehicles until one fails; count them with an entity counter (SHVDN `World.GetAllVehicles().Length`). Expect a little under 300 including ambient traffic.

## 7.9 Open questions

| Question | Where it goes |
| --- | --- |
| A PoolManager crash log from the test install names `cscenarioinfo` at size 250, the vanilla value, while the start-up log shows 885: was the modded `gameconfig.xml` not loaded on that launch, or does the crash log print the vanilla size? | Test card 1 on the next crash |
| Real usage of the busiest pools in a heavy session (turn on PoolManager's usage warning for one launch) | Second pass |
| Memory cost of each raised pool (bytes per slot) | Second pass |
| The vanilla built-in sizes of the weapon arrays that WeaponLimitsAdjuster raises | Second pass |
