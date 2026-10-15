# The AI architecture

How a ped's behaviour is put together: the task system (what a task is, primary and secondary tasks, how events interrupt them), how scripts hand out tasks (single tasks, sequences, blocking events, keeping tasks after release), what a ped does when no script is in charge, and where each part is tuned. Roadmap topic **R17.1** in the [roadmap](/ROADMAP.md). This page is the map; each part has its own guide: [perception and events](/docs/ai/perception-and-events.md) (R17.2), [decisions and personalities](/docs/ai/decisions-and-personalities.md) (R17.3), [relationships and groups](/docs/ai/relationships-and-groups.md) (R17.4), [navigation](/docs/ai/navigation.md) (R17.5), [driving AI](/docs/ai/driving-ai.md) (R17.6), [ambient life](/docs/ai/ambient-life.md) (R17.8), [AI cost](/docs/ai/ai-cost-and-lod.md) (R17.9) and [combat and perception](/docs/ai/combat-and-perception.md) (R3.2).

**How it was made.** The task tuning files in `update\update.rpf\x64\data\tune` of build 1.0.3725.0 (extracted with [`tools/rpf-cw.ps1`](/tools/README.md)) were counted by tunables block; task pool sizes from `gameconfig.xml` ([R1.4](/docs/core/memory-and-pools.md)); script use of the `TASK` namespace from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Counts are **Verified**. How the engine runs the task tree is **Known** (community research and the task class names in the tuning files).

## 40.1 Short version

- **Everything a ped does is a task.** A task is a small state machine (`CTask...`): walk somewhere, use a scenario, enter a vehicle, fight, ragdoll. Tasks nest: a high-level task runs sub-tasks (a combat task runs movement, aiming and cover tasks) (**Known**). The task pool holds 8,192 running tasks at once ([R1.4](/docs/core/memory-and-pools.md)).
- **A ped has a primary task tree and secondary tasks** (**Known**): the primary tree decides where it goes and what it does; secondary tasks layer on top (holding a phone, an upper-body animation, looking at something). Scripts clear the secondary layer with `CLEAR_PED_SECONDARY_TASK` (164 scripts).
- **Events interrupt tasks.** A ped senses an event ([R17.2](/docs/ai/perception-and-events.md)); its decision maker ([R17.3](/docs/ai/decisions-and-personalities.md)) picks a response task (flee, fight, watch) that takes over until it ends. Scripts stop that with `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` (627 scripts).
- **119 task classes are tuned** in the tune files: 53 in `combattasks`, 23 in `vehicletasks`, 21 in `physicstasks` (ragdolls), 16 in `movementtasks`, 10 in `defaulttasks`, 8 in `motiontasks`, plus event and dispatch tuning.
- **Scripts use the `TASK` namespace a lot:** 313 natives, 185,285 calls. The most called: `GET_SCRIPT_TASK_STATUS` (732 scripts, 51,559 calls), `GET_IS_TASK_ACTIVE` (372, 16,544), `TASK_LEAVE_ANY_VEHICLE` (504, 16,239), `CLEAR_PED_TASKS` (638), `TASK_SYNCHRONIZED_SCENE` (440), `TASK_PLAY_ANIM` (554).
- **Sequences chain tasks:** `OPEN_SEQUENCE_TASK` / `CLOSE_SEQUENCE_TASK` (543 scripts), `TASK_PERFORM_SEQUENCE` (317), `CLEAR_SEQUENCE_TASK` (282), repeat with `SET_SEQUENCE_TO_REPEAT` (64).
- **When no script is in charge**, ambient peds run default tasks (wander, scenarios, idle clips, reactions) ([R17.8](/docs/ai/ambient-life.md)); a released mission ped keeps its last task only if `SET_PED_KEEP_TASK` (486 scripts) was set.

## 40.2 The layers

| Layer | What it does | Tuned in | Guide |
| --- | --- | --- | --- |
| Perception | What the ped can see and hear | `pedperception.meta` | [R3.2](/docs/ai/combat-and-perception.md) |
| Events | Things that happened nearby, with ranges and lifetimes | `shockingevents.ymt`, `generalevents.ymt`, `weaponevents.ymt` | [R17.2](/docs/ai/perception-and-events.md) |
| Decisions | Which response an event gets, by personality | `events.meta` (decision makers), `pedpersonality.ymt` | [R17.3](/docs/ai/decisions-and-personalities.md) |
| Relationships | Who is a friend or an enemy | `relationships.dat` | [R17.4](/docs/ai/relationships-and-groups.md) |
| Tasks | Doing it: move, fight, drive, use a scenario | the tune files (119 task classes) | this page |
| Movement and navigation | Routes, climbing, cover | navmeshes, `movementtasks.ymt` | [R17.5](/docs/ai/navigation.md) |
| Motion and animation | Walk cycles, clips, ragdolls | `motiontasks.ymt`, `physicstasks.ymt` | [R2.3](/docs/entities/peds/ragdoll.md), R13.4 |
| Level of detail | Who gets full updates | `gameconfig.xml`, `motiontasks.ymt` | [R17.9](/docs/ai/ai-cost-and-lod.md) |

## 40.3 Tuned task classes

From the tune files (**Verified**, tunables blocks per file):

| File | Blocks | Examples |
| --- | ---: | --- |
| `combattasks.ymt` | 53 | Combat, cover, aiming, melee, shooting, searching |
| `shockingevents.ymt` | 48 | Event tuning, not tasks ([R17.2](/docs/ai/perception-and-events.md)) |
| `vehicletasks.ymt` | 23 | Entering, exiting, driving, bikes, trains |
| `physicstasks.ymt` | 21 | Ragdolls and NaturalMotion behaviours ([R2.3](/docs/entities/peds/ragdoll.md)) |
| `movementtasks.ymt` | 16 | Falling, jumping, climbing, parachuting, swimming |
| `defaulttasks.ymt` | 10 | Wander, chat, ambient clips, look-at |
| `dispatchtuning.ymt` | 10 | Police search and spawning ([R17.7](/docs/ai/police-and-services.md)) |
| `motiontasks.ymt` | 8 | Locomotion, low-detail locomotion, birds, fish |
| `generalevents.ymt`, `weaponevents.ymt` | 7, 3 | Event delays |

119 of the blocks are `CTask...` classes.

## 40.4 How scripts give tasks

| Pattern | Natives | Scripts | Calls |
| --- | --- | ---: | ---: |
| Give one task | `TASK_*` (for example `TASK_GO_STRAIGHT_TO_COORD`, `TASK_COMBAT_PED`) | | |
| Check it | `GET_SCRIPT_TASK_STATUS`, `GET_IS_TASK_ACTIVE` | 732, 372 | 51,559, 16,544 |
| Chain tasks | `OPEN_SEQUENCE_TASK`, `TASK_*` calls, `CLOSE_SEQUENCE_TASK`, `TASK_PERFORM_SEQUENCE`, `CLEAR_SEQUENCE_TASK` | 543, 317, 282 | 4,151, 3,202, 3,253 |
| Repeat or track a sequence | `SET_SEQUENCE_TO_REPEAT`, `GET_SEQUENCE_PROGRESS` | 64, 68 | 142, 133 |
| Stop tasks | `CLEAR_PED_TASKS`, `CLEAR_PED_TASKS_IMMEDIATELY`, `CLEAR_PED_SECONDARY_TASK` | 638, 598, 164 | 8,701, 6,425, 339 |
| Keep the ped on task | `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS`, `SET_PED_KEEP_TASK` | 627, 486 | 7,232, 2,280 |
| Shape behaviour | `SET_PED_COMBAT_ATTRIBUTES`, `SET_PED_FLEE_ATTRIBUTES`, `SET_PED_RELATIONSHIP_GROUP_HASH`, `SET_PED_CONFIG_FLAG` | 360, 268, 438, 694 | 7,614, 1,744, 1,742, 36,119 |
| Wait | `TASK_STAND_STILL`, `TASK_PAUSE` | 105, 60 | 296, 236 |

The commonest check, `GET_SCRIPT_TASK_STATUS`, is called about 70 times per script that uses it: Rockstar's scripts give a task once and then poll it every frame until it's finished, rather than giving it again. `CLEAR_PED_TASKS_IMMEDIATELY` also cancels animations and vehicle entry at once (**Known**), which is why it's used for teleports and cutscene hand-overs.

## 40.5 When no script is in charge

Ambient peds run the population's default behaviour: spawn, wander or use a scenario, idle, react to events, despawn ([R17.8](/docs/ai/ambient-life.md)). A mission ped released with `SET_PED_AS_NO_LONGER_NEEDED` drops its task unless `SET_PED_KEEP_TASK` was set, and then joins the ambient population. Group members follow their leader ([R17.4](/docs/ai/relationships-and-groups.md)).

## 40.6 What this means for modders

- **Give a task once, then poll it:** `GET_SCRIPT_TASK_STATUS` each frame until it's done, the way 732 of Rockstar's scripts do. Re-giving a task every frame restarts it.
- **Chain steps with a sequence** instead of a hand-written state machine for simple orders (go there, wait, enter car).
- **Block events for peds that must obey,** and let them go with a wander task and `SET_PED_KEEP_TASK` so they don't freeze when released.
- **Tune behaviour in the right layer:** personality and events for how peds react, tasks for how they act ([40.2](#402-the-layers)).

## 40.7 Open questions

| Question | Where it goes |
| --- | --- |
| The full list of task classes the engine has (not only tuned ones) | Engine reverse engineering |
| Task status values and what each means, measured | In-game test |
| How primary and secondary task slots are numbered | Engine reverse engineering |

## 40.8 Test cards (story mode, a script mod)

1. **Poll versus re-give.** Give a ped `TASK_GO_STRAIGHT_TO_COORD` once and poll `GET_SCRIPT_TASK_STATUS` until done; then try re-giving it every frame. Expected: the second ped stutters or never arrives.
2. **Keep task.** Give a ped a wander task, release it with and without `SET_PED_KEEP_TASK`. Expected: without it, it stops; with it, it keeps wandering.
