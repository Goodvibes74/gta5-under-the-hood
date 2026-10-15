# Animation

How animation is stored and played in GTA V: clip dictionaries (`.ycd`) and the archives that hold them, clip sets (the 4,526 named groups of clips peds use for movement, weapons and moods), move networks (`.mrf`, the state graphs the engine's tasks run), facial animation and expressions, get-up blend-outs, and how scripts play clips, synchronized scenes and move networks, with counts of what Rockstar's scripts actually use. Roadmap topic **R13.4** in the [roadmap](/ROADMAP.md). Builds on the [data file atlas](/file-formats/data-file-atlas.md) (R0.7: file counts), [streaming](/docs/core/streaming.md) (R1.5: loading dictionaries), [the AI architecture](/docs/ai/ai-architecture.md) (R17.1: tasks), [ambient life](/docs/ai/ambient-life.md) (R17.8: idle clips and scenarios) and [ragdoll](/docs/entities/peds/ragdoll.md) (R2.3).

**How it was made.** Data files from build 1.0.3725.0, listed and extracted with [`tools/rpf-cw.ps1`](/tools/README.md): `update\update.rpf\x64\data\anim\clip_sets\clip_sets.ymt` (converted to XML with CodeWalker's PSO reader in a scratch folder and counted), `common\data\ai\conditionalanims.meta`, `weaponanimations.meta`, `common\data\anim\facial_clipset_groups`, `pose_databases\nm_blend_out_sets.meta`, the base `common.rpf` copies and `data\common_anim.meta`; the move network and expression archives were listed by name. Script use: [native usage](/scripting/native-usage.md) counts, and all 7,340 `TASK_PLAY_ANIM` calls in the decompile (commit `6c18d3e8b`) parsed for their dictionary, blend times, duration and flags. Counts are **Verified**. Flag names and what the engine does with each file are **Known** (NativeDB and community research) unless stated.

## 43.1 Short version

- **24,692 clip dictionaries** (`.ycd`): 11,102 in the base archives, 88 in the update, 13,502 in DLC packs ([R0.7](/file-formats/data-file-atlas.md)). A dictionary holds clips; a script names both (`"amb@world_human_smoking@male@male_a@base"`, `"base"`).
- **Base clips live in 51 archives by name prefix:** `common_anim.meta` mounts `anim\ingame\clip_amb@.rpf`, `clip_move_.rpf`, `clip_miss.rpf`, `clip_weapons@.rpf` and so on, so a dictionary's first word tells you which archive holds it.
- **Clip sets name groups of clips** for the engine: `clip_sets.ymt` has **4,526 clip sets**, 4,052 dictionary entries with streaming rules (610 always resident in story and Online) and **22 memory groups** with budgets from 400 to 12,000. Peds' walk styles, weapon holds and moods are clip sets.
- **Move networks** (`.mrf`) are the state graphs behind tasks: 93 in the base `networkdefs.rpf` (`pedmotion`, `onfootaiming`, `taskinvehicle`, `taskscriptedanimation` ...), 31 patched or added by the update, 2 in DLC. Scripts drive a move network directly in only 32 scripts (arm wrestling, tennis, dancing, drilling, champagne, arcade games).
- **Scripts mostly play clips and synchronized scenes:** `TASK_PLAY_ANIM` in 554 scripts (7,340 calls), `REQUEST_ANIM_DICT` in 682, `CREATE_SYNCHRONIZED_SCENE` in 440, `GET_SYNCHRONIZED_SCENE_PHASE` 8,816 calls; Online uses the networked versions (`NETWORK_CREATE_SYNCHRONISED_SCENE`, 338 scripts).
- **How Rockstar calls `TASK_PLAY_ANIM`:** duration −1 (play the clip's length) in 96% of calls, blend 8/−8 (34%) or 1.5/−1.5 (22%), flag 0 in 52%. The flag bits used most: looping (1,658 calls), "not interruptible" 8 (1,346), bit 262144 (716), secondary task 32 (433), upper body 16 (362).
- **Faces:** 7 facial clip-set groups (generic male and female, each of the three leads, the mime, the zombie) with 9 moods each; scripts set a face with `SET_FACIAL_IDLE_ANIM_OVERRIDE` (129 scripts; `mood_sleeping_1` is the most used) and play one-off facial clips with `PLAY_FACIAL_ANIM` (263).
- **Ambient idles are data:** `conditionalanims.meta` has 48 groups with 139 conditional animations (wander 38, in-car 19, player idles 13), picked by conditions such as model, prop or time.

## 43.2 Where animation lives

| File | What it is | Count | Notes |
| --- | --- | ---: | --- |
| `.ycd` | Clip dictionary | 24,692 | `anim\ingame\clip_*.rpf` in the base game, `x64\anim\...` in DLC packs |
| `clip_sets.ymt` | Clip sets, dictionary streaming rules, memory groups | 4,526 / 4,052 / 22 | Update copy in `update.rpf\x64\data\anim\clip_sets`; 11 DLC patches add `clip_sets.xml` files in `dlc_patch\<pack>\common\data\anim\clip_sets` |
| `.mrf` | Move network | 93 base, 31 update, 2 DLC | `anim\networkdefs.rpf`; update copies in `x64\patch\anim\networkdefs.rpf` |
| `.yed` | Expression dictionary (face, body and hair controls) | 242 | `anim\expressions.rpf`; 12 replaced by the update |
| `expression_sets.xml` | Which expressions a ped model uses | 16 sets | `expr_set_ambient_male`, `_female_heels`, `_mp_m_freemode_01`, `_firemen` ... |
| `facial_clipset_groups.xml` | Facial idles and moods per group | 7 groups | `facials@gen_male@base` and its mood variations |
| `facial_anim_sets.meta` | Facial clips for actions | 3 sets | `AFAS_pain` (3 clips), `AFAS_effort`, `AFAS_knockout` |
| `conditionalanims.meta` | Ambient idle animations with conditions | 48 groups, 139 animations | Used by wander and scenarios ([R17.8](/docs/ai/ambient-life.md)) |
| `weaponanimations.meta` | Clip sets per weapon and ped type | 31 sets | `Default` 83 weapons, `FirstPerson` 41, `Ballistic` 18, `Fat` and `SuperFat` 18, `Female` 22, per-character sets |
| `nm_blend_out_sets.meta` | Get-up and blend-out from ragdoll | 103 sets, 752 items | Single clips (483), blends (130), directional blends (102) ([R2.3](/docs/entities/peds/ragdoll.md)) |
| `.ypdb` | Pose matcher database (matching a ragdoll pose to a get-up clip) | 56 | `anim\posematchers.rpf` |
| Filters | Bone masks (upper body, arms ...) | | `anim\filters.rpf` |

**The 51 base clip archives** (**Verified**, `common_anim.meta`): `clip_amb@` (ambient), `arrest`, `avoids`, `busted`, `cellphone@`, `clothing`, `combat@`, `cover@`, `creatures@`, `dam_`, `dam_ad`, `dead`, `doors@`, `explosions`, `facials@`, `friends@`, `gestures@`, `get_up@`, `guard_reactions`, `ladders`, `map_objects`, `melee@`, `mini@` (minigames), `miss` (missions), `move_`, `mp_`, `nm`, `nm@`, `oddjobs@`, `ped`, `pickup_object`, `ragdoll@`, `random@`, `rcm` (strangers and freaks), `re@` (random events), `reaction@`, `respawn@`, `safe@`, `save`, `shake_cam_`, `skydive@`, `special_ped@`, `stungun@`, `swat`, `swimming@`, `switch@`, `taxi_hail`, `timetable@`, `veh@`, `weapon@`, `weapons@`. Plus `clipmax.rpf`, `expressions.rpf`, `filters.rpf`, `networkdefs.rpf` and `posematchers.rpf`.

## 43.3 Clip sets

A clip set gives a name to a dictionary and lists the clips the engine may use from it, with playback flags and a priority; a fallback set can be named when a clip is missing (**Verified** structure; **Known** meaning). In the update's file:

| Field | Count | |
| --- | ---: | --- |
| Clip sets | 4,526 | 2,398 list no clips (the engine takes any clip in the dictionary); 1,401 name a fallback |
| Clip items | 5,150 | 3,011 with flags, 1,372 plain, 767 directional (a heading such as 1.5707 for left) |
| Item flags | | `APF_ISBLENDAUTOREMOVE` alone 2,380; looped 513; facial looped 119; upper body only 140 |
| Item priority | | Medium 3,067, low 479, face low 178, face medium 25, high 23, face high 6 |
| Dictionary entries | 4,052 | Streaming policy: streamed 3,416; resident in both story and Online 610; priority medium 3,847 |
| Memory groups | 22 | Budgets 400 (8 groups) to 12,000 (2 groups); the biggest group holds 1,325 dictionaries |

Names in the binary file are hashes; the strings are the clip set names scripts and data use (`move_m@drunk@verydrunk`, `move_ped_crouched`, `ANIM_GROUP_MOVE_BALLISTIC`).

**Movement styles are clip sets.** Each ped model names its `MovementClipSet`, `StrafeClipSet` and gesture set in `peds.ymt` ([R14.2](/docs/entities/peds/peds.md)); scripts swap them: `SET_PED_MOVEMENT_CLIPSET` (157 scripts), `RESET_PED_MOVEMENT_CLIPSET` (202), `SET_PED_STRAFE_CLIPSET` (16), `SET_PED_WEAPON_MOVEMENT_CLIPSET` (25), `SET_PED_ALTERNATE_MOVEMENT_ANIM` (28). The most set literal clip sets: `move_m@bag` (106 calls), `move_m@JOG@` (26), `ANIM_GROUP_MOVE_BALLISTIC` (23), `MOVE_M@BAIL_BOND_NOT_TAZERED` (16), `move_m@fire` (14), `move_ped_crouched` (9). A clip set must be loaded first (`REQUEST_CLIP_SET` / `HAS_CLIP_SET_LOADED`, 193 scripts; 34 distinct literal names).

## 43.4 Playing a clip from a script

The pattern in every script (**Verified** from the counts):

1. `REQUEST_ANIM_DICT` (682 scripts, 11,469 calls), then check `HAS_ANIM_DICT_LOADED` (677) without blocking ([R1.5](/docs/core/streaming.md)).
2. `TASK_PLAY_ANIM` (554 scripts) or `TASK_PLAY_ANIM_ADVANCED` (335: starts at a given position and rotation, used to line a ped up with an object).
3. Poll `IS_ENTITY_PLAYING_ANIM` (558 scripts, 9,070 calls), `GET_ENTITY_ANIM_CURRENT_TIME` (419) or `HAS_ANIM_EVENT_FIRED` (333: tags inside the clip, such as a hand reaching a door).
4. `STOP_ANIM_TASK` (59) or let it end; `REMOVE_ANIM_DICT` (575).

Props play clips with `PLAY_ENTITY_ANIM` (108) and cameras with `PLAY_CAM_ANIM` (277). `FORCE_PED_AI_AND_ANIMATION_UPDATE` (552 scripts, 4,119 calls) applies a new task the same frame so a warped ped doesn't pop.

**`TASK_PLAY_ANIM` as Rockstar calls it** (all 7,340 calls parsed, **Verified**):

| Parameter | What they pass |
| --- | --- |
| Dictionary | A literal in 4,431 calls (465 distinct dictionaries); the biggest families `amb@` (ambient, 1,823), `anim@` (729), `oddjobs@` (235), `random@` (137), `creatures@` (91), `special_ped@` (80), `mini@` (75) |
| Blend in / out | 8 / −8 in 2,530 calls, 1.5 / −1.5 in 1,638, 4 / −4 in 595, 2 / −2 in 581, 8 / −4 in 509; 1000 means "snap" |
| Duration | −1 (the clip's own length) in 7,055 calls (96%) |
| Flag | 0 in 3,789 calls (52%), 1 in 672, 10 in 289, 262144 in 271 |

**Flag bits** across the 7,043 calls with a literal flag. Names are the community's (**Known**):

| Bit | Name | Calls |
| ---: | --- | ---: |
| 1 | Looping | 1,658 |
| 2 | Hold last frame | 580 |
| 8 | Not interruptible (by events) | 1,346 |
| 16 | Upper body only | 362 |
| 32 | Secondary task (plays over the main task) | 433 |
| 512 | Turn off collision | 86 |
| 4096 | Extract initial offset | 50 |
| 8192 | Exit after interrupted | 72 |
| 131072 | Force start | 64 |
| 262144 | Use kinematic physics | 716 |
| 524288 | Use mover extraction | 84 |
| 1048576 | Hide weapon | 76 |
| 16777216 | Abort on weapon damage | 332 |

A looping upper-body secondary clip (1 + 16 + 32 = 49) is how scripts make a ped hold a phone or smoke while it walks; 49 appears in 101 calls and 48 (upper body, secondary, not looped) in 105.

## 43.5 Synchronized scenes

A synchronized scene plays clips on several peds, props and a camera on one shared clock at a fixed origin, so hands meet handles and doors open on cue (**Known**). Rockstar uses them in 440 scripts (**Verified**):

| Step | Native | Scripts | Calls |
| --- | --- | ---: | ---: |
| Create at a position and rotation | `CREATE_SYNCHRONIZED_SCENE` | 440 | 4,715 |
| Put peds in it | `TASK_SYNCHRONIZED_SCENE` | 440 | 7,957 |
| Put props in it | `PLAY_SYNCHRONIZED_ENTITY_ANIM` | 356 | 2,918 |
| Put a camera on it | `PLAY_SYNCHRONIZED_CAM_ANIM` | 338 | 1,010 |
| Attach to a vehicle or object | `ATTACH_SYNCHRONIZED_SCENE_TO_ENTITY` | 294 | 994 |
| Watch progress | `GET_SYNCHRONIZED_SCENE_PHASE` | 492 | 8,816 |
| Check it is running | `IS_SYNCHRONIZED_SCENE_RUNNING` | 482 | 6,758 |
| Loop, hold, speed | `SET_SYNCHRONIZED_SCENE_LOOPED`, `_HOLD_LAST_FRAME`, `_RATE` | 133, 130, 84 | |

The scene's phase (0 to 1) is the mission's clock: stages wait for a phase such as 0.95 before moving on. The Online versions (`NETWORK_CREATE_SYNCHRONISED_SCENE`, `NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE`, `NETWORK_START_SYNCHRONISED_SCENE`, 338 scripts) are created by the host and replayed on every machine; casino tables, apartments and heists rely on them.

## 43.6 Move networks

Every engine task that animates runs a move network: a graph of states and blends with named signals (**Known**). The base archive holds 93: locomotion (`onfoothuman`, `pedmotion`, `onfootlocomotion`, `onfootquad` for animals, `bird`, `fish`), combat (`taskaimgunonfoot`, `taskcover`, `taskreloadgun`, `taskmeleeactionresult`), vehicles (`taskentervehicle`, `taskinvehicle`, `taskexitvehicle`, `vehiclebicycle`), falls and ragdoll recovery (`taskfall`, `taskblendfromnm`, `taskdyingdead`), `taskscriptedanimation` (what `TASK_PLAY_ANIM` runs), `taskcutscene` and a few minigames (`minigame_benchpress`, `minigame_squats`, `minigame_tattoo_*`, `taskmotiontennis`). The update patches 31, among them `pedmotion`, `onfootaiming`, `taskinvehicle`, `taskparachute` and new Online ones (`dance_mini_game`, `champagne_drinking_mini_game`, `heist3_minigame_drill_vault`, `heist4_minigame_glass_cutting`).

**Scripts drive move networks directly in 32 scripts** (`TASK_MOVE_NETWORK_BY_NAME` 7, `..._ADVANCED_BY_NAME` 13, `..._WITH_INIT_PARAMS` 14): arm wrestling (`arm_wrestling_sweep_paired_a_rev4`), tennis (`SET_TENNIS_MOVE_NETWORK_SIGNAL_FLOAT`), the jewel heist guard (`HeistJewel_SecurityGuard2B`), the tattoo and drilling minigames (`minigame_tattoo_michael_parts`, `minigame_drilling`), and in Online the vault drill, dancing, champagne and arcade games. They send signals (`SET_TASK_MOVE_NETWORK_SIGNAL_FLOAT`, 30 scripts; the drill uses `Cutting`, `drill_force`, `SHAKE_INTENSITY`), ask for transitions (`REQUEST_TASK_MOVE_NETWORK_STATE_TRANSITION`) and read events (`GET_TASK_MOVE_NETWORK_EVENT`). A mod can only use networks that exist in the game's archives; building a new `.mrf` needs tools that don't publicly exist (**Known**).

## 43.7 Faces and expressions

- **Facial idles and moods** (**Verified**, `facial_clipset_groups.xml`): 7 groups (generic male and female, Michael, Franklin, Trevor, the mime, the zombie). Each has a base clip set and mood variations: normal, aiming, angry, excited, frustrated, happy, injured, stressed, talking, and for the generic groups dancing (low, medium, high, trance). Each variation has resident and playback times (for example 4 to 8 s).
- **Scripts** override the idle face with `SET_FACIAL_IDLE_ANIM_OVERRIDE` (129 scripts; literal moods: `mood_sleeping_1` 37 calls, `Mood_Normal_1` 25, `mood_happy_1` 5, `Mood_Angry_1` 4) and clear it with `CLEAR_FACIAL_IDLE_ANIM_OVERRIDE` (50); `PLAY_FACIAL_ANIM` (263 scripts, 2,028 calls) plays a one-off facial clip (*probably* mostly talking and reactions outside cutscenes).
- **Expressions** (`.yed`) drive face, body and cloth controls procedurally; `expression_sets.xml` gives 16 sets by body type (shorts, skirts, heels, high heels) plus `mp_m_freemode_01`, `mp_f_freemode_01`, `hc_gunman` and `firemen` (**Verified** names; **Known** purpose).

## 43.8 Ambient and scenario animation

Scenario peds play the clips their scenario type names ([R4.2](/docs/entities/spawning/scenarios.md)); idle clips while wandering come from `conditionalanims.meta` (**Verified** counts): 48 groups, 139 animations. The biggest: `WANDER` 38 (with props such as a clipboard, 6.5% probability), `IN_CAR_STANDARD` 19, `PLAYER_IDLES` 13, `BUDDY_AI_IDLES` 9, `IN_VAN` 8, `SHOCK_HURRY` 8. Each animation has conditions (998 condition blocks), a prop set, a probability and the time to the next idle. Scripts allow or stop these with `SET_PED_CAN_PLAY_AMBIENT_ANIMS` (493 scripts) and `SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS` (88), and start scenarios with `TASK_START_SCENARIO_IN_PLACE` (342).

## 43.9 What this means for modders

- **Find a dictionary by its prefix.** `amb@...` is in `clip_amb@.rpf`, `move_...` in `clip_move_.rpf`, `missfbi4` in `clip_miss.rpf`. OpenIV or CodeWalker can browse these; the decompile's string literals give working dictionary and clip pairs (465 dictionaries in `TASK_PLAY_ANIM` alone).
- **Copy Rockstar's defaults:** duration −1, blend 8/−8, and pick flags from 43.4: 1 to loop, 2 to hold, 49 for an upper-body loop while walking, 8 if events must not interrupt it. Use `TASK_PLAY_ANIM_ADVANCED` or a synchronized scene when the ped has to line up with an object.
- **Use a synchronized scene for anything with two actors or a prop**: it keeps them in step and gives you a phase to drive the mission from.
- **Release what you request** (`REMOVE_ANIM_DICT`, `REMOVE_CLIP_SET`), and request a stage early: loading a dictionary mid-play is a known hitch ([R1.5](/docs/core/streaming.md)).
- **Walk styles are one native:** request the clip set, then `SET_PED_MOVEMENT_CLIPSET(ped, "move_m@drunk@verydrunk", 0.25)`.
- **Add-on animations** go in a DLC pack's `x64\anim` archive as `.ycd`; new clip sets go in a pack's `clip_sets.xml` (11 of Rockstar's `dlc_patch` folders do exactly this) ([archives and content](/docs/core/archives-and-content.md)).
- **Move networks can only be reused, not made.** Arm wrestling, tennis and drilling show how scripts drive one with signals.

## 43.10 Open questions

| Question | Where it goes |
| --- | --- |
| The names behind the 22 memory groups and their budget unit | Next pass: hash the candidate names |
| Which clip sets the hashed entries are (resolving the 4,526 keys from script, `peds.ymt` and `weaponanimations.meta` strings) | Next pass |
| Exactly what each `TASK_PLAY_ANIM` flag bit does (262144 and 16777216 in particular) | In-game test |
| The clip archive layout in DLC packs and how many dictionaries each pack adds | With [R0.7](/file-formats/data-file-atlas.md) |
| The 12 expression dictionaries the update replaced and why | Next pass |
| Animation memory cost per dictionary | R18.3 (memory) |

## 43.11 Test cards

1. **Upper-body loop.** In a script, request `amb@world_human_smoking@male@male_a@base`, play clip `base` on the player with flag 49 and walk. Expected: the player smokes while walking. With flag 1 the player stops to smoke.
2. **Not interruptible.** Play a looped clip on a ped with flag 1, fire a gun nearby: the ped reacts and stops. With flag 9 it keeps playing.
3. **Walk style.** Request and set `move_m@drunk@verydrunk` on the player. Expected: a drunk walk until `RESET_PED_MOVEMENT_CLIPSET`.
