# How Rockstar's scripts drive AI

A pattern library: how missions and Online content set up enemies, guards and patrols, hostages, escorts and buddies, waves, heist crews and the scripted peds of Online venues, with the natives each pattern uses, how often, and a worked example read from the scripts. Roadmap topic **R17.10** in the [roadmap](/ROADMAP.md). The engine side is in [the AI architecture](/docs/ai/ai-architecture.md) (R17.1) and its guides: [combat and perception](/docs/ai/combat-and-perception.md) (R3.2: attributes and profiles), [relationships and groups](/docs/ai/relationships-and-groups.md) (R17.4), [driving AI](/docs/ai/driving-ai.md) (R17.6: chases and helicopters), [ambient life](/docs/ai/ambient-life.md) (R17.8); mission structure is in [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) (R5.2).

**How it was made.** Native counts from [native usage](/scripting/native-usage.md) (build 1.0.3725.0, decompile commit `6c18d3e8b`). Examples read in the same decompile: `docks_setup` (patrols), `re_rescuehostage` (a hostage), `agency_heist3b` (enemy groups), `rural_bank_heist`, `finale_heist2b` and `jewelry_heist` (heist crews), `main` (the crew table), `fm_survival_controller` (waves and difficulty), `am_mp_peds`, `am_casino_peds` and `am_mp_nightclub` (venue peds). Patrol routes were counted with `git grep` over all scripts. Counts and values are **Verified**; why Rockstar does something is **Known** or marked *probable*.

## 44.1 Short version

- **Every scripted enemy is built the same way:** create, relationship group (`SET_PED_RELATIONSHIP_GROUP_HASH`, 438 scripts), combat attributes (360 scripts, 7,614 calls), accuracy (249), a defensive area (185), then a task (`TASK_COMBAT_PED` 268, `TASK_COMBAT_HATED_TARGETS_IN_AREA` 136), with ambient events blocked and `SET_PED_KEEP_TASK` (486) so it survives release.
- **Guards patrol on short looped routes:** 97 scripts build patrol routes (`OPEN_PATROL_ROUTE` ... `TASK_PATROL`); route names start `miss_`; 67 of 71 literal nodes play `WORLD_HUMAN_GUARD_STAND` and wait a random 0.5 to 6 s at each node. The stand-guard tasks are almost unused (`TASK_GUARD_CURRENT_POSITION` 4 scripts).
- **Stealth is perception tuning plus checks:** scripts narrow a guard's senses (seeing range, vision cone, hearing) and test `CAN_PED_SEE_HATED_PED` (38 scripts) or `IS_PED_IN_COMBAT` (219) themselves, then switch relationships to hate and hand out combat tasks to the whole group.
- **A hostage is a synchronized scene with a trigger:** in `re_rescuehostage` the captor holds the hostage in a scene, sees in a 240° cone out to 40 m with almost no hearing (1.5 m); being seen, aimed at or making noise plays the execution scene, then the captor fights.
- **Buddies and escorts join the player's group:** `SET_PED_AS_GROUP_MEMBER` (191 scripts) with the player's own group; only 1 script calls `CREATE_GROUP`. Fixed routes use waypoint recordings (`TASK_FOLLOW_WAYPOINT_RECORDING`, 49 scripts).
- **Heist crews are a 13-person table** in `main`: role, cut and four skill stats each (gunmen: health 200 to 800, accuracy 35 to 91, shoot rate 28 to 90). Missions read them straight into `SET_PED_MAX_HEALTH`, `SET_PED_ACCURACY` and `SET_PED_SHOOT_RATE`.
- **Online content scales enemies by the job's difficulty:** accuracy 10, 30 or 45 with combat ability 0, 1 or 2 and 0, 50 or 100 armour; survival waves add a per-wave accuracy from the content data.
- **Online venue peds are scripted actors:** `am_mp_peds`, `am_casino_peds` and the nightclub scripts dress freemode-model peds and run them on animation and synchronized-scene tables (`am_mp_peds`: 77 `TASK_PLAY_ANIM`, 33 sequences); they do not use combat AI.

## 44.2 The hostile ped recipe

The order Rockstar uses, with how many scripts use each step (**Verified** counts; order **Known** from reading missions):

| Step | Natives | Scripts |
| --- | --- | ---: |
| Create and own it | `CREATE_PED`, `SET_ENTITY_AS_MISSION_ENTITY` | |
| Side | `ADD_RELATIONSHIP_GROUP` (225), `SET_RELATIONSHIP_BETWEEN_GROUPS` (340, 4,251 calls), `SET_PED_RELATIONSHIP_GROUP_HASH` | 438 |
| Fighting style | `SET_PED_COMBAT_ATTRIBUTES` (7,614 calls), `SET_PED_COMBAT_MOVEMENT` (233), `SET_PED_COMBAT_RANGE` (90), `SET_PED_COMBAT_ABILITY` (188) | 360 |
| Skill | `SET_PED_ACCURACY` (249), `SET_PED_SHOOT_RATE` (174), `SET_PED_FIRING_PATTERN` (159), `SET_PED_CHANCE_OF_FIRING_BLANKS` (21) | |
| Senses | `SET_PED_SEEING_RANGE` (185), `SET_PED_HEARING_RANGE` (151), `SET_PED_HIGHLY_PERCEPTIVE` (148), vision-cone natives (27) | |
| Where it fights | `SET_PED_SPHERE_DEFENSIVE_AREA` (185, 1,263 calls), `SET_PED_ANGLED_DEFENSIVE_AREA` (122), `REMOVE_PED_DEFENSIVE_AREA` (131) | |
| Toughness | `SET_PED_SUFFERS_CRITICAL_HITS` (197: off means no one-shot head kills), max health, armour | |
| What to do | `TASK_COMBAT_PED` (268), `TASK_COMBAT_HATED_TARGETS_IN_AREA` (136), `_AROUND_PED` (67), `TASK_SHOOT_AT_ENTITY` (127), `TASK_AIM_GUN_AT_ENTITY` (162), cover tasks (33) | |
| Keep it on task | `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` ([R17.1](/docs/ai/ai-architecture.md)), `SET_PED_TARGET_LOSS_RESPONSE` (195), `SET_PED_KEEP_TASK` (486) | |

`SET_PED_CONFIG_FLAG` (694 scripts, 36,119 calls) is set around all of this; the attribute and flag numbers most used are in [combat and perception](/docs/ai/combat-and-perception.md).

## 44.3 Guards and patrols

**Patrol routes** (**Verified**). 97 scripts build routes, mostly through shared code compiled into many Online `fm_content_*` scripts and story missions such as `docks_setup`, `docks_heista`, `assassin_construction` and `re_prison`. A route is built and started in one go:

1. `DELETE_PATROL_ROUTE(name)` then `OPEN_PATROL_ROUTE(name)`: the name is built as `"miss_"` plus a tag and the guard's index (`miss_merc0`, `miss_Tower_05` ...).
2. `ADD_PATROL_ROUTE_NODE(id, scenario, position, look-at, wait ms)` for 3 or 4 nodes. In `docks_setup` every node is `WORLD_HUMAN_GUARD_STAND`, the first waits 500 to 1,500 ms and the others 1,000 to 6,000 ms (`GET_RANDOM_INT_IN_RANGE`), so guards drift out of step.
3. `ADD_PATROL_ROUTE_LINK(1, 2)`, `(2, 3)`, `(3, 4)`, `(4, 1)`: a closed loop.
4. `CLOSE_PATROL_ROUTE`, `CREATE_PATROL_ROUTE`, then `TASK_PATROL(ped, name, 0, true, true)`.

Across all scripts the literal node scenarios are `WORLD_HUMAN_GUARD_STAND` (67) and `StandGuard` (4). Guards that should not move get a scenario (`TASK_START_SCENARIO_IN_PLACE`, 342 scripts) or a defensive area instead; the dedicated guard tasks are nearly unused: `TASK_GUARD_CURRENT_POSITION` 4 scripts, `TASK_GUARD_SPHERE_DEFENSIVE_AREA` 4, `TASK_GUARD_ASSIGNED_DEFENSIVE_AREA` 3, `TASK_STAND_GUARD` 1.

**Enemy groups and alerts** (`agency_heist3b`, **Verified** structure, *probable* intent). Enemies sit in an array of 20-field structs. Each frame the script checks groups: when any member is in combat (`IS_PED_IN_COMBAT`) or a counter of noticed events passes 3, it gives the other members of that group combat tasks. The engine's own "inform friends" (`SET_PED_TO_INFORM_RESPECTED_FRIENDS`, 20 scripts) is used less than this hand-made spreading.

## 44.4 Stealth and being seen

Scripts change a guard's senses rather than relying on defaults (**Verified** counts): seeing range 185 scripts, hearing range 151, highly perceptive 148, identification range (`SET_PED_ID_RANGE`) 39, the vision cone (`SET_PED_VISUAL_FIELD_*`) 27, alertness 20. Then they decide "spotted" themselves:

- `CAN_PED_SEE_HATED_PED` (38 scripts, 139 calls): the engine's line of sight inside the ped's cone and range. Used by the stealthy missions (`agency_heist3b`, `finale_heist_prepb`, `docks_prep2b`, `exile2`, `michael1`) and many random events.
- `HAS_ENTITY_CLEAR_LOS_TO_ENTITY` (188) and `_IN_FRONT` (39): a cheaper ray test.
- Player actions: aiming at or targeting the ped (`IS_PLAYER_FREE_AIMING_AT_ENTITY`, `IS_PLAYER_TARGETTING_ENTITY`), being inside an angled area, shooting nearby.

## 44.5 Hostages: `re_rescuehostage`

The random event where a man holds a woman at gunpoint in Paleto Bay (**Verified**, 6,400 lines):

1. **Set-up.** Three relationship groups (captor, hostage, player side). The captor gets seeing range 40 m, hearing 1.5 m, and a vision cone from −120° to 120° with a 40 m peripheral range and a 90° centre angle. Captor and hostage play a looping synchronized scene; the other two peds get combat attributes 11 and 17 on, 13 and 5 off.
2. **Trigger.** Each frame it checks: the player inside an 8.5 m-wide angled area by the scene *and* seen (`CAN_PED_SEE_HATED_PED`), or aiming at or targeting the captor while seen, or the captor ragdolling, or noise and other checks.
3. **Execution.** It starts the execution scene; at phase 0.1 the captor fires at the hostage's head bone (31086) with `SET_PED_SHOOTS_AT_COORD`; if the scene ends early the hostage is killed directly.
4. **Fight.** Relationships switch to hate (5) both ways, the captor gets `TASK_COMBAT_PED(captor, player)` and target-loss response 1.
5. **Rescue path.** If the player kills the captor first, the hostage flees (`TASK_SMART_FLEE_PED` and `_COORD`).

Across all scripts: `TASK_HANDS_UP` 123 scripts, `TASK_COWER` 188, `TASK_SMART_FLEE_PED` 229.

## 44.6 Buddies, escorts and set routes

- **Buddies join the player's group** (**Verified** counts): `SET_PED_AS_GROUP_MEMBER` 191 scripts (447 calls), almost always with `GET_PLAYER_GROUP(PLAYER_ID())`. Only one script calls `CREATE_GROUP` and one `SET_PED_AS_GROUP_LEADER`; formations (`SET_GROUP_FORMATION`) appear in 10. Group members follow, shoot at what the player fights and get in the player's vehicle on their own (**Known**, [R17.4](/docs/ai/relationships-and-groups.md)).
- **Escorts and follows** without a group: `TASK_GO_TO_ENTITY` (152 scripts), `TASK_FOLLOW_TO_OFFSET_OF_ENTITY` (28).
- **Scripted routes** that must look authored use waypoint recordings: `TASK_FOLLOW_WAYPOINT_RECORDING` 49 scripts (267 calls): `agency_heist3a`, `finale_heist2a` and `2b`, `rural_bank_heist`, `fbi5a`, `exile2`. Cars use vehicle recordings ([R17.6](/docs/ai/driving-ai.md)).
- **Sequences** chain the steps (`TASK_PERFORM_SEQUENCE`, 317 scripts, 3,202 calls).

## 44.7 Heist crews

Story heist crew members are a table in `main` (**Verified**; names from the `HC_FN_*` labels; cut and stats as stored):

| Id | Crew member | Role | Cut | Stat 1 | Stat 2 | Stat 3 | Stat 4 |
| ---: | --- | --- | ---: | ---: | ---: | ---: | ---: |
| 1 | Gustavo Mota | Gunman | 14% | 700 | 79 | 83 | 77 |
| 10 | Packie McReary | Gunman | 12% | 800 | 91 | 89 | 71 |
| 11 | Chef | Gunman | 12% | 675 | 86 | 78 | 90 |
| 2 | Karl Abolaji | Gunman | 8% | 275 | 40 | 28 | 52 |
| 3 | Hugh Welsh | Gunman | 7% | 300 | 35 | 32 | 48 |
| 4 | Norm Richards | Gunman | 7% | 250 | 39 | 40 | 44 |
| 5 | Daryl Johns | Gunman | 6% | 200 | 42 | 35 | 46 |
| 6 | Paige Harris | Hacker | 15% | 85 | 77 | 93 | 0 |
| 7 | Christian Feltz | Hacker | 10% | 59 | 59 | 43 | 0 |
| 12 | Rickie Lukens | Hacker | 4% | 36 | 45 | 39 | 0 |
| 8 | Eddie Toh | Driver | 14% | 72 | 91 | 86 | 0 |
| 13 | Taliana Martinez | Driver | 5% | 94 | 83 | 68 | 0 |
| 9 | Karim Denz | Driver | 8% | 60 | 54 | 24 | 0 |

For gunmen the heist scripts use stat 1 as max health, stat 2 as accuracy and stat 3 as shoot rate when they spawn the crew member (`rural_bank_heist`, `finale_heist2b` and `jewelry_heist` share the function). Anyone spawned through it who isn't a gunman gets health 100, accuracy 25 and shoot rate 40 (**Verified**). Stats are packed two to an integer, 15 bits each. A shared function raises a stat by 25 (a quarter of its cap of 100) and clamps it at 100; crew members improve after heists they survive (**Known**). The crew's names for the other stats (hacking speed, driving) are **Known**, not read.

## 44.8 Waves and difficulty in Online content

Online missions and survivals don't hard-code enemy skill; it comes from the content data (**Verified**, the ped set-up shared by the mission and survival controllers):

| Job difficulty | Accuracy | Combat ability | Armour added |
| --- | ---: | ---: | ---: |
| Easy | 10 | 0 (poor) | 0 |
| Normal | 30 | 1 (average) | 50 |
| Hard | 45 | 2 (professional) | 100 |

Survival (`fm_survival_controller`) sets each enemy's accuracy from a table indexed by stage and wave, plus a per-wave bonus from the content, and its combat ability from a matching table; some special enemies are set to accuracy 3, 5 or 9 with ability 0, and get `TASK_COMBAT_PED` with flag 67108864. Health and armour are scaled by two more per-wave multipliers. Survival waves are counted and announced with labels such as `SC_WAVE_NUM` and `MP_WAVE_COMPLETE`.

Story missions have no wave system: each stage spawns its own enemies when the player reaches a trigger, and moves on when they are dead or a time passes ([R5.2](/docs/gameplay/missions/mission-anatomy.md)) (**Known** from reading missions).

## 44.9 Online venue peds

The casino, nightclubs, arcade, penthouse and other properties fill themselves with scripted actors (**Verified** counts): `am_mp_peds` (138,700 lines, most of it location and activity tables), `am_casino_peds`, `am_penthouse_peds`, `am_mp_arcade_peds`, plus the nightclub and island scripts. They create peds on the freemode models (`mp_m_freemode_01`, `mp_f_freemode_01`) or story models, dress them through the shared clothing code, set head blends (`SET_PED_HEAD_BLEND_DATA` in each) and run them on animation tables: in `am_mp_peds` 77 `TASK_PLAY_ANIM` calls, 33 sequences, 30 `TASK_FOLLOW_NAV_MESH_TO_COORD` and 12 synchronized scenes, polled with `GET_SCRIPT_TASK_STATUS` (99). They look like players but carry no combat set-up (*probable* design: they are crowd, not opponents).

## 44.10 What this means for modders

- **Copy the recipe in 44.2** for any enemy: side, attributes, accuracy, defensive area, task, events blocked, keep task. Skipping the relationship step is the usual reason a mod's enemies stand still.
- **Patrols:** name routes `miss_...`, use 3 or 4 nodes with `WORLD_HUMAN_GUARD_STAND` and random waits, link them in a loop, and call `TASK_PATROL`. Delete the route at cleanup.
- **Make "being seen" your own check:** narrow the guard's senses, then test `CAN_PED_SEE_HATED_PED` each frame and decide; spread the alert to the guard's group yourself.
- **Hostage or execution scenes:** use a synchronized scene so the timing is exact, and drive the shot from the scene's phase.
- **Buddies:** add them to the player's group (`GET_PLAYER_GROUP`) rather than creating a group.
- **Difficulty:** the Online table (accuracy 10, 30, 45; ability 0, 1, 2; armour 0, 50, 100) is a tested scale to reuse; Rockstar's elite heist gunmen sit at 79 to 91 accuracy.
- **Cost:** every scripted enemy runs full AI; [AI cost](/docs/ai/ai-cost-and-lod.md) has the limits.

## 44.11 Open questions

| Question | Where it goes |
| --- | --- |
| Where story missions keep enemy spawn tables (positions, triggers) and how many enemies a big shootout has alive at once | Next pass: `rural_bank_heist`, `finale_heist2b` |
| What hackers' and drivers' stats do in each heist | Next pass: the heist scripts |
| When the crew stat raise is called (every survived heist, or only some) | Next pass |
| The `TASK_COMBAT_PED` flag values (16, 67108864, 201326592) | In-game test |
| How `fm_content_*` scripts set up patrols from content data | R7.7, R7.9 |
| Buddy behaviour in vehicles (driver choice, drive-bys) | With [R17.6](/docs/ai/driving-ai.md) |

## 44.12 Test cards

1. **Hostage cone.** At the Paleto Bay hostage event, approach from directly behind the captor without aiming. Expected: you can get close without triggering the execution; from the front at 40 m it triggers.
2. **Patrol rhythm.** Watch the patrolling guards in the docks setup mission (`docks_setup`): each stops 1 to 6 s at every node and they fall out of step.
3. **Crew skill.** Take Packie and then Karl on the same heist: Packie survives more hits (800 against 275 health) and hits more often.
