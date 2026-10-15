# Props, archetypes and doors

How props work beyond being placed in the map: what an archetype holds, static versus dynamic and breakable props, the scripted destruction ("rayfire") objects, and the door system with its 36 door tunings and 94 model assignments. Roadmap topic **R14.3** in the [roadmap](/ROADMAP.md). Builds on [map data](/docs/world/map-data.md) (R4.6: the 2,744 `.ytyp` files and how ymaps place archetypes), [physics cost](/docs/performance/physics-cost.md) (R2.7) and [particles and decals](/docs/rendering/particles-and-decals.md) (R13.3).

**How it was made.** `common\data\levels\gta5\doortuning.meta` (and its update copy) of build 1.0.3725.0 extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and counted with `grep`; rayfire object names from every `GET_RAYFIRE_MAP_OBJECT` call in the decompile (commit `6c18d3e8b`) with `git grep`; door registrations counted per script; native counts from [native usage](/scripting/native-usage.md). Counts and values are **Verified**. Archetype fields and what the engine does with each tuning value are **Known** (CodeWalker's archetype definitions and the field names).

## 30.1 Short version

- **An archetype is a model's definition:** name, texture and physics dictionaries, bounding box and sphere, LOD distance, flags and "special attribute", plus 2D effects (lights, particles, spawn points). Kinds: plain (`CBaseArchetypeDef`), time-dependent (`CTimeArchetypeDef`, lit windows at night) and interiors (`CMloArchetypeDef`). They live in the 2,744 `.ytyp` files ([R4.6](/docs/world/map-data.md)) (**Known** fields).
- **Static or dynamic is decided by the model:** a `.ydr` drawable with fixed bounds is static; a `.yft` fragment can move, break into pieces and fly apart. Scripts change it at run time with `FREEZE_ENTITY_POSITION`, `SET_ENTITY_DYNAMIC` (316 scripts) and `ACTIVATE_PHYSICS` (205).
- **Scripted destruction uses "rayfire" map objects:** 24 named in scripts, such as `DES_Showroom` (the Simeon showroom crash), `DES_FIB_Floor`, `des_finale_vault`, `des_finale_tunnel`, `DES_FarmHs`, `des_shipsink`, `DES_traincrash`, `des_tankerexplosion`, `DES_StiltHouse`, `DES_methtrailer`. They're driven by state with `GET_` / `SET_STATE_OF_RAYFIRE_MAP_OBJECT` (246 and 250 scripts).
- **The door system** registers doors by model and position (`ADD_DOOR_TO_SYSTEM`, 388 scripts, 1,466 calls) and sets their state (`DOOR_SYSTEM_SET_DOOR_STATE`, 405 scripts, 7,392 calls), open ratio (342 scripts) and hold-open (143). Missions register the most (`fbi5a` 26, `armenian3` 18, `agency_heist3a` 18, `fbi1` 16).
- **`doortuning.meta` holds 36 named door tunings** and maps 94 door models to them: `DefaultStandardLatchShut` (37 models), `LargeFenceGate` (16), `FenceGate` (9), `LargeGate` (4) and others; garages for Michael, Franklin, Trevor, gangs and the chop shop; barrier arms; sliding gates; `HeavyVaultDoor`.
- **Door tunings set** auto-open trigger boxes, who opens the door (SP vehicles with peds, MP players, law enforcement, all vehicles), whether vehicles can break it, mass, weapon impulse, rotation limits and latching.

## 30.2 Archetypes and props (Known)

| Field | Meaning |
| --- | --- |
| `name`, `textureDictionary`, `physicsDictionary` | The model, its textures, and its collision |
| `bbMin`, `bbMax`, `bsCentre`, `bsRadius` | Bounds used for culling and streaming |
| `lodDist`, `hdTextureDist` | Draw distances ([R13.1](/docs/rendering/rendering-and-visual-settings.md)) |
| `flags`, `specialAttribute` | Behaviour bits (for example "is a ladder", "has an animation", "dynamic", "static") |
| `extensions` | 2D effects: lights, particles, audio emitters, spawn points, ladders, door info |
| `assetType`, `assetName` | Drawable, fragment, or drawable dictionary |

A prop placed in a ymap is static until something wakes it (a hit, a script); a fragment prop (`.yft`) can lose pieces ("frags") and be broken by damage. Scripts stop that with `SET_DISABLE_FRAG_DAMAGE` (36 scripts) and `SET_DISABLE_BREAKING` (30) and check it with `HAS_OBJECT_BEEN_BROKEN` (43); `FREEZE_ENTITY_POSITION` is in 663 scripts (41,519 calls).

Script-created props (`CREATE_OBJECT` 508 scripts, 4,232 calls; `CREATE_OBJECT_NO_OFFSET` 379, 5,571) are positioned with `PLACE_OBJECT_ON_GROUND_OR_OBJECT_PROPERLY` (122 scripts) and made dynamic or frozen as needed; Rockstar's job creator shows the full set of steps for props that must behave ([R7.11](/docs/online/creator-internals.md)).

## 30.3 Rayfire destruction

Rayfire objects are pre-animated destruction scenes placed in the map (**Known**); a script finds one by position and name and moves it through states (start, animating, end) (**Verified** natives). The 24 names in scripts (calls in brackets): `DES_Showroom` (7), `DES_FIB_Floor` (5), `des_prologue_door`, `des_finale_vault`, `des_finale_tunnel`, `DES_FarmHs` (4 each), `des_tvsmash` (3), `des_shipsink`, `des_server`, `DES_methtrailer`, `DES_VaultDoor001`, `DES_StiltHouse`, `DES_FIBstair`, `DES_FIB_Door`, `DES_FIB_Ceil` (2 each), and once each `des_tankerexplosion`, `des_frenchdoor`, `DES_traincrash`, `DES_tankercrash`, `DES_hospitaldoors`, `DES_gasstation01`, `DES_Smash2`, `DES_Scaffolding`, `DES_FIB_Glass`. Their particle effects are matching `des_*` particle dictionaries (`des_vaultdoor`, `des_fib_door`, `des_french_doors`, `des_hospitaldoors`, `des_prologue_door` ...).

## 30.4 Doors

**Registration** (**Verified** counts):

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `DOOR_SYSTEM_SET_DOOR_STATE` | 405 | 7,392 |
| `DOOR_SYSTEM_FIND_EXISTING_DOOR` | 255 | 6,521 |
| `DOOR_SYSTEM_SET_OPEN_RATIO` | 342 | 4,505 |
| `DOOR_SYSTEM_SET_HOLD_OPEN` | 143 | 2,041 |
| `IS_DOOR_REGISTERED_WITH_SYSTEM` | 396 | 1,859 |
| `ADD_DOOR_TO_SYSTEM` | 388 | 1,466 |
| `DOOR_SYSTEM_SET_AUTOMATIC_DISTANCE` | 133 | 985 |
| `DOOR_SYSTEM_GET_OPEN_RATIO`, `_GET_DOOR_STATE` | 247, 166 | 804, 350 |
| `NETWORK_IS_DOOR_NETWORKED` | 121 | 155 |

A door is registered under a hash with its model and position, then locked, unlocked or forced open by state; the strangers-and-freaks controller alone keeps 40 doors ([R5.4](/docs/gameplay/missions/strangers-and-freaks.md)).

**Tunings** (`doortuning.meta`, **Verified**): 36 named tunings, 94 model mappings.

| Tuning | Models | Example settings |
| --- | ---: | --- |
| `DefaultStandardLatchShut` | 37 | Standard hinged door that latches |
| `LargeFenceGate` | 16 | |
| `FenceGate` | 9 | |
| `LargeGate` | 4 | |
| `BarrierArmCustomBox` | | Auto-opens for SP and MP vehicles with peds, trigger box 6 × 6 × 5.75 m, breakable by vehicles, mass ×0.01 |
| `ChopShopGarageCustomBox` | | Trigger box about 9 × 31 m, open rate 0.5 |
| `HeavyVaultDoor`, `HeavyWoodDoor`, `StandardHeavy` | | Heavier doors |
| `MichaelGarageCustomBox`, `FranklinGarage2`, `FranklinGarageCustomBox`, `TrevorGarageCustomBox`, `GangGarageCustomBox` | | Safehouse garages |
| `SlidingHorizontal*`, `SlidingVertical`, `TowTruckYardSlidingHorizontal` | | Sliding gates, some police-only |

Auto-open flags used: `AutoOpensForSPVehicleWithPedsOnly` (7), `AutoOpensForMPVehicleWithPedsOnly` (6), `AutoOpensForSPPlayerPedsOnly` (6), `DontCloseWhenTouched` (6), `IgnoreOpenDoorTaskEdgeLerp` (6), `DelayDoorClosingForPlayer` (4), `AutoOpensForMPPlayerPedsOnly` (3), `AutoOpensForAllVehicles` (1), `AutoOpensForLawEnforcement` (1).

## 30.5 What this means for modders

- **Lock or open a map door** by registering it (`ADD_DOOR_TO_SYSTEM` with the model and its exact position) and setting its state; check `IS_DOOR_REGISTERED_WITH_SYSTEM` first, since a mission may own it.
- **Make a garage or gate open for your car** by giving its model a tuning in `doortuning.meta` (a data-file edit) or by opening it from script when the player is near.
- **Don't trigger rayfire objects outside their mission:** the map piece stays in its end state until the game resets it.
- **A spawned prop that should stay put** needs `FREEZE_ENTITY_POSITION` (and breaking turned off for fragments); one that should be pushed needs `SET_ENTITY_DYNAMIC` and `ACTIVATE_PHYSICS`.

## 30.6 Open questions

| Question | Where it goes |
| --- | --- |
| Archetype flag bits counted across all `.ytyp` files | Second pass, with an XML export of the ytyps |
| Which map props are fragments (`.yft`) and how many break | Second pass with R4.6's model counts |
| Every rayfire object placed in the map, not only those named in scripts | Second pass, ymap entity extensions |

## 30.7 Test cards (story mode, a script mod)

1. **Door lock.** Register a shop door with `ADD_DOOR_TO_SYSTEM` and set its state to locked. Expected: it can't be pushed open.
2. **Dynamic prop.** Spawn a `.yft` prop (a barrier) frozen, then unfreeze it and call `ACTIVATE_PHYSICS`. Expected: it falls and can be pushed.
