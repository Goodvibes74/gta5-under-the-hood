# Ambient life

What the world's peds do when nobody is directing them, and how Rockstar's scripts steer it: wandering, scenarios, idle clips and chats, looking at things, ambient speech and reactions, animals (birds, fish, land animals), and how the crowd is thinned or emptied. Roadmap topic **R17.8** in the [roadmap](/ROADMAP.md). Most of the data has its own guide; this page joins them and adds the ambient task tunables. Extends [scenarios and ambient life](/docs/entities/spawning/scenarios.md) (R4.2: 111,898 scenario points) and builds on [population](/docs/entities/spawning/population.md) (R4.1), [perception and events](/docs/ai/perception-and-events.md) (R17.2) and [speech and dialogue](/docs/audio/speech-and-dialogue.md) (R9.2).

**How it was made.** `update\update.rpf\x64\data\tune\defaulttasks.ymt` and `motiontasks.ymt` of build 1.0.3725.0 (extracted with [`tools/rpf-cw.ps1`](/tools/README.md)): the `CTaskWander`, `CTaskWanderInArea`, `CTaskChat`, `CAmbientLookAt`, `CTaskAmbientClips`, `CTaskFlyingWander` and `CTaskSwimmingWander` tunables. Native counts from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Values and counts are **Verified**; how the engine chooses what a ped does next is **Known**.

## 36.1 Short version

- **An ambient ped's life is a loop of tasks** (**Known**): spawn from a scenario point or a population zone ([R4.1](/docs/entities/spawning/population.md), [R4.2](/docs/entities/spawning/scenarios.md)), wander or use a scenario, play idle clips, look at interesting things, chat with a nearby ped, react to events ([R17.2](/docs/ai/perception-and-events.md)), and despawn when far from the player.
- **Idle clips** play every 4 s by default, with a 50% chance of standing while moving; after a gunshot peds skip idles for 40 s (20 s near the player); peds argue between 10 and 15 m apart (`fArgumentDistanceMinSq` 100, `MaxSq` 225).
- **Looking around** (`CAmbientLookAt`): peds scan 15 m for things to look at, look for 2 s at a time, and score peds, vehicles and objects (0.5, 0.5, 0.25); the player looks at something new every 2 to 5 s.
- **Wandering:** when rain starts, 8 peds per 3-second period switch to rain behaviour (`CTaskWander`); peds wandering in an area wait 3 to 6 s between moves; chats wait up to 30 s for the partner to face them within 5°.
- **Animals** are 41 ped models of type animal ([peds](/docs/entities/peds/peds.md)); birds fly-wander toward targets 15 m wide within 35 m (`CTaskFlyingWander`), fish keep 3 m deep and steer away from obstacles with an 18 m probe every 2 s (`CTaskSwimmingWander`).
- **Scripts thin or quiet the world:** `CLEAR_AREA_OF_PEDS` (456 scripts), `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME` (158), `SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME` (105), `SET_PED_NON_CREATION_AREA` (86), `SET_PED_MODEL_IS_SUPPRESSED` (74), `SET_PED_POPULATION_BUDGET` (70), `SET_SCENARIO_TYPE_ENABLED` (52).

## 36.2 Ambient task tunables

From `defaulttasks.ymt` and `motiontasks.ymt` (**Verified**):

| Tunables | Values |
| --- | --- |
| `CTaskAmbientClips` | Idle every 4 s; 50% stand while moving; no idles for 40 s after a gunshot (20 s near the player); hang-outs near the player end after 7 to 12 s within 8 m; hang-out chat within 2 m; arguments 10 to 15 m apart; no idles in a vehicle above 5 m/s (bike 0.5 m/s); counts as wet 10 s after leaving water |
| `CAmbientLookAt` | Threshold 4; world-centre distance 30 m (60 m extended); scan 15 m; look 2 s; AI retry after 1 to 1.5 s failure; player looks every 2 to 5 s, at its own vehicle every 5 s; scenario scan every 5 s, 15 m ahead, 12 m radius; scores: ped 0.5, vehicle 0.5, object 0.25, behind a ped ×0.75 |
| `CTaskWander` | 8 peds per 3 s switch to rain behaviour |
| `CTaskWanderInArea` | Wait 3 to 6 s |
| `CTaskChat` | Face within 5°; wait up to 30 s |
| `CTaskFlyingWander` | Range offset 35 m; target radius 15 m; heading change about 0.56 rad |
| `CTaskSwimmingWander` | Surface skimmers 2 m deep, others 3 m; avoidance probe 18 m every 2 s, steer 60° |
| `CTaskBirdLocomotion`, `CTaskFishLocomotion` | Movement tuning for birds and fish |

## 36.3 What scripts do

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `TASK_PLAY_ANIM` | 554 | 7,340 | Scripted idles and actions |
| `SET_PED_CAN_PLAY_AMBIENT_ANIMS`, `_BASE_ANIMS` | 493, 88 | 1,275, 275 | Stop a mission ped's idles |
| `CLEAR_AREA_OF_PEDS` | 456 | 781 | Empty a set piece |
| `TASK_LOOK_AT_ENTITY`, `_COORD` | 381, 167 | 2,302, 337 | Directed looks |
| `TASK_START_SCENARIO_IN_PLACE`, `_AT_POSITION` | 342, 166 | 1,037, 542 | Put a ped into a scenario |
| `TASK_SMART_FLEE_COORD`, `_PED` | 232, 229 | 490, 953 | Flee |
| `TASK_WANDER_STANDARD`, `_IN_AREA`, `_SPECIFIC` | 209, 105, 94 | 365, 111, 94 | Release a ped into the world |
| `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME`, `SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME` | 158, 105 | 321, 172 | Thin the crowd, every frame |
| `SET_PED_NON_CREATION_AREA` | 86 | 165 | No spawns in a box |
| `SET_PED_MODEL_IS_SUPPRESSED` | 74 | 233 | Keep a model from spawning |
| `SET_PED_POPULATION_BUDGET` | 70 | 291 | Overall ped budget (0 to 3) |
| `SET_SCENARIO_TYPE_ENABLED` | 52 | 190 | Switch scenario types off |
| `TASK_USE_MOBILE_PHONE` | 36 | 86 | |
| `TASK_CHAT_TO_PED` | 5 | 10 | Make two chosen peds chat (leftovers pass) |

*Leftovers pass (**Verified**):* scripts never pick chat partners. `TASK_CHAT_TO_PED` appears 10 times in 5 scripts (`taxi_gotyounow`, `taxi_clowncar`, `nigel2`, `franklin0`, `re_stag_do`, two calls each). Each time the script names both peds and gives each the other as partner, with flag 16 in 8 calls and 17 and 1 once each. So ambient chats, and who chats with whom, come from the engine's `CTaskChat` and the hang-out rules in `CTaskAmbientClips` (chat within 2 m).

The pattern for a mission set piece: clear the area, stop the scenarios and models that would wander in, lower the densities every frame, and give the mission's own peds tasks with ambient clips off; at cleanup put a released ped back with a wander task so it lives on as an ambient ped.

### 36.3.1 The animals and where they spawn (PC data pass)

**Verified** (`update:/x64/data/peds.ymt`, the DLC `peds.meta` files, `ambientpedmodelsets.meta`, `scenarios.meta` and `popgroups.ymt`, build 1.0.3725.0; hashed names in `peds.ymt` resolved with `joaat`).

The base `peds.ymt` has 32 `A_C_*` models. Their AI comes by reference (decision maker [R17.2](/docs/ai/perception-and-events.md#3341-from-event-to-response-decision-makers-pc-data-pass) / task data [R3.2](/docs/ai/combat-and-perception.md#581-task-data-sets-and-scripted-gun-tasks-pc-data-pass) / relationship group / combat info):

| Kind | Models | Decision maker / task data / relationship group |
| --- | --- | --- |
| Birds | `A_C_Chickenhawk`, `A_C_Crow`, `A_C_Cormorant`, `A_C_Pigeon`, `A_C_Seagull` | `GULL` / `animal` / `WILD_ANIMAL` |
| Hen | `A_C_Hen` | `HEN` / `animal` / `HEN` |
| Wild land animals | `A_C_Boar`, `A_C_Coyote`, `A_C_Deer` (group `DEER`), `A_C_Rabbit_01` (decision maker `RABBIT`), `A_C_Rat` (`RAT`) | `WildAnimal` / `animal` / `WILD_ANIMAL` |
| Mountain lion | `A_C_MtLion` | `COUGAR` / `animal` / `COUGAR`, combat info `COUGAR` |
| Farm animals | `A_C_Cow`, `A_C_Pig` | `DomesticAnimal` / `animal` / `DOMESTIC_ANIMAL` |
| Big dogs | `A_C_Retriever`, `A_C_Rottweiler`, `A_C_shepherd`, `A_C_Husky` | `DOG` / `DOG` / `GUARD_DOG`, combat info `ROTTWEILER` |
| Small dogs | `A_C_Poodle`, `A_C_Pug`, `A_C_Westy` | `SmallAnimal` / `DOG` / `DOMESTIC_ANIMAL` |
| Chop | `A_C_Chop` | `DOG` / `DOG` / `civmale`, combat info `CHOP` |
| Cat | `A_C_Cat_01` | `CAT` / `CAT` / `CAT` |
| Sea | `A_C_Fish` (`FISH`), `A_C_Dolphin` and `A_C_SharkHammer` (`LargeFish`), `A_C_KillerWhale` (`KILLERWHALE`), `A_C_Stingray` (`STINGRAY`), `A_C_HumpBack` (decision maker `EMPTY`, `Whale`), `A_C_SharkTiger` (decision maker `SHARK`, `TigerShark`) | Mostly `FISH` / own task data; all use combat info `SCARED_ANIMAL_IN_WATER` |
| Monkeys | `A_C_Chimp`, `A_C_Rhesus` | Ped type `civmale` and decision maker `DEFAULT`: treated like a civilian man |

DLC packs add `_02` variants (`mp2023_01`: boar, coyote, deer, mountain lion, pug; `mpchristmas3`: chimp, rabbit; `mpsecurity`: Chop; `mp2025_01`: rottweiler; `mp2025_02`: cat) and `A_C_Panther` (`mpheist4`).

**Where they spawn.** Two routes:
- **Population groups**, for birds and fish only ([population](/docs/entities/spawning/population.md#birds-and-fish-pc-data-pass)).
- **Scenarios**, for everything else: `ambientpedmodelsets.meta` has 34 animal model sets (`ANIMAL_DEER`, `ANIMAL_RABBIT`, `ANIMAL_DOG_SMALL` ...), and `scenarios.meta` ties 47 scenario types to them with `ForceModel`. `WORLD_DEER_GRAZING` uses `ANIMAL_DEER`; `WORLD_RABBIT_EATING` and `_FLEE` rabbits; `WORLD_COYOTE_HOWL`, `_REST`, `_WALK` and `_WANDER` coyotes; `WORLD_MOUNTAIN_LION_REST` and `_WANDER`; `WORLD_BOAR_GRAZING`, `WORLD_COW_GRAZING`, `WORLD_PIG_GRAZING`; `WORLD_CAT_SLEEPING_GROUND` and `_LEDGE`; `WORLD_DOG_BARKING_*` and `WORLD_DOG_SITTING_*` for `RETRIEVER`, `ROTTWEILER`, `SHEPHERD` and `SMALL`; `WORLD_HEN_FLEE`, `_PECKING` and `_STANDING`; `WORLD_CHICKENHAWK_`, `WORLD_CROW_`, `WORLD_GULL_` and `WORLD_PIGEON_` `FEEDING` and `STANDING`; `WORLD_CORMORANT_STANDING`; `WORLD_RATS_EATING` and `_FLEEING`; `WORLD_FISH_IDLE` and `_FLEE`; the `_SWIM` types for dolphin, orca, whale, stingray, hammerhead and (`WORLD_SHARK_SWIM`) tiger shark; and `PROP_BIRD_IN_TREE` (crow, pigeon) and `PROP_BIRD_TELEGRAPH_POLE` (crow, pigeon, seagull). How many points each type has is in [scenarios](/docs/entities/spawning/scenarios.md).

The husky appears only in `ANIMAL_DOG_RETRIEVER` (shared with the retriever); poodle, pug and westy only through `ANIMAL_DOG_SMALL`. No scenario type uses the chimp, the rhesus, Chop or any DLC animal, so those appear only when a script creates them.

## 36.4 What this means for modders

- **Release a ped properly:** `TASK_WANDER_STANDARD` then mark it no longer needed; a released ped without a task stands still.
- **Calm a scene** with the density multipliers every frame (they last one frame) and `SET_PED_NON_CREATION_AREA`; Rockstar does it in 158 and 86 scripts.
- **Busier streets** come from the population data ([R4.1](/docs/entities/spawning/population.md)) and scenarios ([R4.2](/docs/entities/spawning/scenarios.md)), not from these tunables; on a weak PC more ambient peds cost the most CPU of anything here ([CPU](/docs/performance/cpu.md)).
- **Idle and look-at tuning** in `defaulttasks.ymt` changes the whole world's mood (for example peds staying shaken longer than 40 s after gunfire).

## 36.5 Open questions

| Question | Where it goes |
| --- | --- |
| How far from the player ambient peds despawn | R17.9, in-game test |
| How peds pick partners for chats | Partly answered (leftovers pass, 36.3): no script picks them; the 10 `TASK_CHAT_TO_PED` calls pair two peds chosen by the script. Left: the engine's pairing rule (the executable, or a test) |
| The animal models by kind and where each spawns | Answered in [36.3.1](#3631-the-animals-and-where-they-spawn-pc-data-pass) |

## 36.6 Test cards (story mode)

1. **Shaken peds.** Fire a gun in a busy street and time how long until peds play idle clips again. Expected: about 40 s.
2. **Density.** Call `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(0)` every tick for a minute. Expected: no new ambient peds; the existing ones remain.
