# AI cost and level of detail

How the game keeps AI affordable: the hard limits on peds, vehicles, tasks, events and routes, the "MaxTotalPeds" and vehicle update budgets, low-detail locomotion and timeslicing for peds far from the player, how Rockstar's scripts force or relax updates, and safe limits for mods that spawn peds and cars. Roadmap topic **R17.9** in the [roadmap](/ROADMAP.md). Builds on [memory, pools and limits](/docs/core/memory-and-pools.md) (R1.4: the pools), [CPU](/docs/performance/cpu.md) (R18.4: why the main thread is the limit) and [physics cost](/docs/performance/physics-cost.md) (R2.7).

**How it was made.** `update\update.rpf\common\data\gameconfig.xml` (pool sizes and population caps) and `x64\data\tune\motiontasks.ymt` (`CTaskMotionBasicLocomotionLowLod`) of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md). Native counts from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Sizes and counts are **Verified**. How the engine chooses which peds get full updates (timeslicing, low LOD, dummies) is **Known**; per-frame costs on a low-end PC are proposals until measured (R18.1).

## 37.1 Short version

- **Hard caps** (`gameconfig.xml`): 256 peds, 300 vehicles, 8,192 tasks (a second `CTask` pool of 2,100), 950 events, 1,024 navmesh routes, 10,010 dummy objects, 2,300 objects ([R1.4](/docs/core/memory-and-pools.md)).
- **The population is capped lower than the pools:** `MaxTotalPeds` 200 (`_Base` 70), so ambient peds never fill the 256-ped pool and scripts keep room for mission peds.
- **Vehicles are timesliced:** at most 10 vehicle AI updates per frame (`VehicleTimesliceMaxUpdatesPerFrame`; base value 4). *Known*: the rest wait their turn, and far-away cars become cheap "dummy" or "super-dummy" vehicles that follow road nodes without full physics.
- **Peds far away use low-detail locomotion** (`CTaskMotionBasicLocomotionLowLod`): a simpler clip set and faster heading changes (`LowLodWalkHeadingLerpRate` 3 against 1 for high detail); animation timeslicing is skipped when a heading change is above 4–5° and within 55 m for shadows (`NoAnimTimeslicingShadowRange`).
- **Scripts override the savings when it matters:** `FORCE_PED_AI_AND_ANIMATION_UPDATE` (552 scripts, 4,119 calls) and `FORCE_ENTITY_AI_AND_ANIMATION_UPDATE` (340) for peds the player must see react right now; `SET_PED_LOD_MULTIPLIER` (304) to keep a ped detailed farther away; `SET_PED_HIGHLY_PERCEPTIVE` (148).
- **And they trim when they can:** `SET_REDUCE_PED_MODEL_BUDGET` (47) and `_VEHICLE_` (49), population budgets and density multipliers ([R17.8](/docs/ai/ambient-life.md)), and `IS_ENTITY_ON_SCREEN` (316 scripts) to skip work for unseen entities.

## 37.2 Limits that matter for AI

| Pool or cap | Size | Note |
| --- | ---: | --- |
| `Peds` (and `PedIntelligence`) | 256 | Every ped, including the player and cutscene peds |
| `MaxTotalPeds` / `_Base` | 200 / 70 | Population cap below the pool |
| `Vehicles` | 300 | |
| `CTask` | 8,192 (and 2,100) | Running AI tasks; complex peds run several at once |
| `CEvent` | 950 | Events waiting to be handled ([R17.2](/docs/ai/perception-and-events.md)) |
| `NavMeshRoute` | 1,024 | Routes being planned or followed ([R17.5](/docs/ai/navigation.md)) |
| `ScenarioPoint`, `ScenarioPointWorld`, `ScenarioPointEntity` | 900, 1,400, 350 | |
| `CTaskUseScenarioEntityExtension` | 256 | |
| `ObjectIntelligence` | 120 | AI for objects |
| `Dummy Object` | 10,010 | Cheap stand-ins for far objects |
| `VehicleTimesliceMaxUpdatesPerFrame` / `_Base` | 10 / 4 | Vehicle AI updates per frame |

## 37.3 Level of detail for AI (Known)

| Distance from the player | Peds | Vehicles |
| --- | --- | --- |
| Near and on screen | Full AI, physics, high-detail animation | Full physics and AI |
| Middle | Timesliced AI and animation, low-detail locomotion | Timesliced AI |
| Far | Very low update rate; despawned by the population code when out of view | Dummy and super-dummy: follow road nodes, no full physics |

The values that are in the files (**Verified**): low-detail walk heading rate 3 (high detail 1), low-detail pitch approach 0.1 (high detail 0.6), no animation timeslicing if the heading differs by more than 5° (disabled above 4°), and full animation for shadow casters within 55 m.

## 37.4 What scripts do

| Native | Scripts | Calls | Effect |
| --- | ---: | ---: | --- |
| `FORCE_PED_AI_AND_ANIMATION_UPDATE` | 552 | 4,119 | Update this ped fully this frame (after a teleport or task change) |
| `FORCE_ENTITY_AI_AND_ANIMATION_UPDATE` | 340 | 2,579 | Same for any entity |
| `IS_ENTITY_ON_SCREEN` | 316 | 1,090 | Skip work for unseen entities |
| `SET_PED_LOD_MULTIPLIER` | 304 | 865 | Keep a ped in high detail farther away |
| `SET_ENTITY_LOD_DIST` | 266 | 1,017 | Draw distance |
| `SET_PED_HIGHLY_PERCEPTIVE` | 148 | 277 | Full perception even when far |
| `SET_REDUCE_PED_MODEL_BUDGET`, `_VEHICLE_` | 47, 49 | 101, 108 | Fewer model variations during heavy scenes |
| `SET_PED_POPULATION_BUDGET`, `SET_VEHICLE_POPULATION_BUDGET` | 70, 76 | 291, 361 | Ambient budgets 0 to 3 |

## 37.5 Safe limits for mods (proposed)

Until measured on a low-end PC (R18.1), keep to Rockstar's own set pieces ([physics cost](/docs/performance/physics-cost.md), [CPU](/docs/performance/cpu.md)):

| What | Proposed limit | Why |
| --- | ---: | --- |
| Script-made peds with combat AI at once | 20 to 30 | Combat runs several tasks per ped and many events; heists rarely exceed this |
| Peds in total (ambient plus script) | under 150 | Leaves room under `MaxTotalPeds` 200 and the 256 pool |
| Script-made vehicles driving with AI | 10 to 15 | Matches the 10 full vehicle updates per frame |
| Ragdolling at once | 4 | [R2.7](/docs/performance/physics-cost.md) |
| Forced updates | only on the frame you need them | Each forced update skips the timeslicing saving |

And lower the ambient population (`SET_PED_DENSITY_MULTIPLIER_THIS_FRAME`, budgets) when a mod adds many of its own.

## 37.6 What this means for modders

- **Spawning dozens of armed peds** is the quickest way to stall the main thread; reduce ambient density at the same time and keep fighters within the numbers above.
- **After teleporting or re-tasking a ped,** call `FORCE_PED_AI_AND_ANIMATION_UPDATE` once, as Rockstar does in 552 scripts, or it may pop on the next timesliced update.
- **Don't raise the pools to get more peds;** `MaxTotalPeds` and the budgets are the real caps, and the CPU is the limit after that.

## 37.7 Open questions

| Question | Where it goes |
| --- | --- |
| The distances where ped AI LOD changes | In-game test, or engine reverse engineering |
| Measured frame time per combat ped on a low-end PC | R18.1 measuring, test card 1 |
| What the second `CTask` pool (2,100) is for | Second pass with R1.4 |

## 37.8 Test cards (story mode, a script mod)

1. **Combat cost.** Spawn 10, 20, 40 armed hostile peds in an empty area and note the frame time each time ([measuring](/docs/performance/measuring.md)). Expected: the frame time grows faster than linearly past about 20.
2. **Forced update.** Teleport a walking ped and check its pose on the next frame with and without `FORCE_PED_AI_AND_ANIMATION_UPDATE`. Expected: without it, a frame or two of the old pose.
