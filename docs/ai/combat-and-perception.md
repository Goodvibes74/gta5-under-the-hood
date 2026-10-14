# Combat and AI (first pass)

How GTA V's peds decide to fight, flee or ignore: relationship groups, perception, the event and decision-maker system, combat profiles, accuracy, health, melee and takedowns, and how scripts set up a fight. Roadmap topic **R3.2** in the [roadmap](/ROADMAP.md). NPC AI as one system (architecture, navigation, driving, ambient life) is area R17; this guide is the combat side and feeds it.

**How it was made.** The vanilla AI data files were read from `common.rpf\data\` and `update\update.rpf\common\data\` (the newer copy wins) with `tools/rpf-cw.ps1`. Native use was counted in the build-3725 decompile. Values and counts are **Verified**; what the engine does with a field is **Known** unless stated. `pedpersonality.ymt` is a binary PSO file and was not decoded in this pass.

## 5.1 Short version

- **Who fights whom is data.** `relationships.dat` defines about 40 relationship groups (player, civilians, cops, army, gangs, animals, eight `MISSION` groups) and their attitudes: companion, respect, like, neutral, dislike, hate. Peds with no hate relationship toward you won't start a fight unless an event pushes them.
- **Peds react to events.** The engine raises events (73 types in `events.meta`: shots fired, bullets whizzing by, explosions, a dead body, a car crash, someone aiming at them). Each ped has a **decision maker** (about 25: `PLAYER`, `COP`, `SWAT`, `GANG`, `DEFAULT`, animals ...) that maps each event to a response task: cower, flee, hands up, turn to face, investigate, threaten, combat. 219 responses in all.
- **What a ped can sense** comes from its perception profile: by default it sees 60 m in a 180-degree arc (narrow field of gaze 60 degrees), hears 60 m, and notices people closer than 25 m.
- **How a ped fights** comes from its combat profile in `combatbehaviour.meta` (16 in vanilla: `DEFAULT`, the three players, `GANG`, `GRUNT`, `CAPTAIN`, `COP`, `SWAT`, `ARMY`, `SECURITY`, animals): advance or hold, ability (poor, average, professional), range, accuracy, fire rate, firing pattern, cover use and a list of behaviour flags.
- **Hitting is a roll, not aim.** AI accuracy (`WeaponAccuracy` 0.18 for most NPCs, 1.0 for the player characters) is scaled by global modifiers in `pedaccuracy.meta`: AI is twice as accurate at 5 m as at 15 m, and much less accurate against targets that are running, rolling, in cover, in the air or driving fast.
- **Melee is a table.** The action tables (`action\definitions.meta` and its partners: 342 named actions, 504 results, 451 branches, 162 homing rules, 24 damage types) list every punch, counter, stealth kill and takedown, and when each one is allowed.
- **Scripts set up fights by hand.** Missions use `SET_PED_COMBAT_ATTRIBUTES` (7,614 calls), relationship natives (about 6,000), defensive areas, accuracy and firing patterns, then hand the ped a task (`TASK_COMBAT_PED`, `TASK_COMBAT_HATED_TARGETS_AROUND_PED`) and stop ambient events from interrupting it (`SET_BLOCKING_OF_NON_TEMPORARY_EVENTS`, 7,232 calls).

## 5.2 Relationship groups

`common.rpf\data\relationships.dat` lists the groups first and then each group's attitudes (**Verified**). The 38 listed groups are `PLAYER`, `CIVMALE`, `CIVFEMALE`, `COP`, `SECURITY_GUARD`, `PRIVATE_SECURITY`, `FIREMAN`, `GANG_1`, `GANG_2`, `GANG_9`, `GANG_10`, nine `AMBIENT_GANG_*` (`LOST`, `MEXICAN`, `FAMILY`, `BALLAS`, `MARABUNTE`, `CULT`, `SALVA`, `WEICHENG`, `HILLBILLY`), `DEALER`, `HATES_PLAYER`, `HEN`, `WILD_ANIMAL`, `SHARK`, `COUGAR`, `NO_RELATIONSHIP`, `SPECIAL`, `MISSION2` to `MISSION8`, `ARMY`, `GUARD_DOG`, `AGGRESSIVE_INVESTIGATE`, `MEDIC`, `CAT`; the rules also use `PRISONER`, `DEER` and `DOMESTIC_ANIMAL`.

The defaults are friendly or neutral almost everywhere. Selected rules:

| Group | Attitudes |
| --- | --- |
| `COP` | Respect `MEDIC`, `FIREMAN`, `COP`, `ARMY`; like `SECURITY_GUARD` |
| `ARMY` | Like `ARMY`; respect `COP` |
| Each `AMBIENT_GANG_*` | Like its own gang and `GUARD_DOG`; **no rule against other gangs** |
| `PRISONER` | Like `PRISONER`; hate `PLAYER` |
| `HATES_PLAYER`, `AGGRESSIVE_INVESTIGATE` | Hate `PLAYER` |
| `WILD_ANIMAL`, `DEER`, `COUGAR` | Hate the player and most human groups |
| `DOMESTIC_ANIMAL`, `CAT` | Hate `PLAYER`, like the rest |

So gang wars and cops versus gangs are not in the data: vanilla gangs are neutral to each other and to cops, and the hostility the player sees comes from events (being shot at, a gun drawn in their territory) and from scripts. Mods that want permanent feuds set `SET_RELATIONSHIP_BETWEEN_GROUPS` themselves, as Rockstar's missions do 4,251 times. The levels are numbers in the natives: 0 companion, 1 respect, 2 like, 3 neutral, 4 dislike, 5 hate, 255 "pedestrians" default (**Known**; `trevor1` uses 5 and 255 for the bikers and the cops, [guide 3](/docs/gameplay/missions/mission-anatomy.md#34-the-main-loop)).

## 5.3 Perception

`pedperception.meta` has 6 profiles in vanilla: `DEFAULT_PERCEPTION`, `BARNYARD_PERCEPTION`, `BIRD_PERCEPTION`, `SHARK_PERCEPTION`, `FISH_PERCEPTION`, `LARGE_FISH_PERCEPTION` (**Verified**). The default one:

| Field | Value |
| --- | --- |
| `SeeingRange` | 60 m |
| `SeeingRangePeripheral` | 5 m |
| `HearingRange` | 60 m |
| Visual field | -90 to +90 degrees sideways, -75 to +60 vertically |
| `CentreFieldOfGazeMaxAngle` | 60 degrees (the cone where the ped really looks) |
| `EncroachmentRange` / `EncroachmentCloseRange` | 25 m / 4 m (someone walking up to them) |

Scripts change it per ped: `SET_PED_SEEING_RANGE` (524 calls), `SET_PED_HEARING_RANGE` (393), `SET_PED_VISUAL_FIELD_CENTER_ANGLE` (211) and `PERIPHERAL_RANGE` (37). Stealth missions narrow the field of view of guards; chases widen the seeing range of cops.

## 5.4 Events and decision makers

`events.meta` (`update.rpf` copy, **Verified**): 1,095 items, of which 25 decision makers and 219 decision responses, covering 73 event types. The most-handled events are `EVENT_SHOT_FIRED` (12 responses), `EVENT_SHOT_FIRED_WHIZZED_BY` (10), `EVENT_ENCROACHING_PED` (10), `EVENT_SHOT_FIRED_BULLET_IMPACT` (9), `EVENT_SHOCKING_INJURED_PED` (9), `EVENT_EXPLOSION` (9), `EVENT_SHOCKING_SEEN_MELEE_ACTION` (8), `EVENT_SHOCKING_CAR_CRASH` (8), `EVENT_SHOCKING_SEEN_PED_KILLED`, `EVENT_SHOCKING_PED_RUN_OVER`, `EVENT_SHOCKING_DEAD_BODY` and `EVENT_DAMAGE` (6 each).

The decision makers are named by role: `PLAYER`, `COP`, `FIREMAN`, `MEDIC`, `OFFDUTY_EMT`, `Security`, `SWAT`, `EMPTY`, `BASE`, `DEFAULT`, `GANG`, `FAMILY`, the animals (`GULL`, `HEN`, `RAT`, `FISH`, `Shark`, `HORSE`, `DomesticAnimal`, `DOG`, `WildAnimal`, `Cougar`, `SmallAnimal`, `Cat`, `Rabbit`). The responses they point to are tasks: `RESPONSE_TASK_COWER`, `_FLEE`, `_HANDS_UP`, `_TURN_TO_FACE`, `_COMBAT`, `_THREAT`, `_DUCK_AND_COVER`, `_ESCAPE_BLAST`, `_AGITATED`, the shocking-event family (`_SHOCKING_EVENT_WATCH`, `_STOP_AND_STARE`, `_HURRY_AWAY`, `_BACK_AWAY`, `_SHOCKING_POLICE_INVESTIGATE`) and `RESPONSE_POLICE_TASK_WANTED` / `RESPONSE_SWAT_TASK_WANTED`, which is how cops join a wanted-level chase.

**Agitation** is a second, smaller system for people being annoyed rather than threatened: `agitatedtriggers.meta` (bumping, loitering near, following, intimidating, entering their territory: `AT_Intimidate`, `AT_Loitering`, `AT_Following`, `AT_TerritoryIntruded`), `agitatedresponses.meta` and `agitatedpersonalities.meta` decide whether a ped confronts, insults, threatens or fights.

A script that wants a ped to ignore all of this sets `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` (7,232 calls), so only its own tasks run. Scripts also raise events: `ADD_SHOCKING_EVENT_FOR_ENTITY` (122 calls) makes bystanders react to something the script staged.

## 5.5 Combat profiles

`combatbehaviour.meta` (`update.rpf` copy, 16 `CCombatInfo` profiles, **Verified**):

| Profile | Movement | Ability | Range | Accuracy | Fight proficiency | Fire rate | Behaviour flags |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `DEFAULT` | Will advance | Average | Medium | 0.18 | 0.5 | 1.0 | 13 |
| `MICHAEL`, `FRANKLIN`, `TREVOR` | Will advance | Average | Medium | 1.0 | 0.5 | 1.0 | 9 |
| `GANG` | Will advance | Average | Medium | 0.18 | 0.8 | 1.0 | 16 |
| `GRUNT` | **Stationary** | Poor | Far | 0.18 | 0.5 | 0.8 | 11 |
| `CAPTAIN` | Will advance | Professional | Near | 0.18 | 0.75 | 1.2 | 13 |
| `COP` | Will advance | Professional | Medium | 0.18 | 0.75 | 1.0 | 14 |
| `SWAT`, `ARMY` | Will advance | Professional | Medium | 0.18 | 0.8 | 1.4 | 18, 17 |
| `SECURITY` | Will advance | Average | Medium | 0.18 | 0.5 | 1.0 | 11 |
| `CHOP`, `ROTTWEILER`, `COUGAR`, `SCARED_ANIMAL`, `SCARED_ANIMAL_IN_WATER` | | | | 0 to 0.18 | | | 1 to 13 |

Every profile uses `FIRING_PATTERN_BURST_FIRE` and a 55 m `AttackWindowDistanceForCover`. The behaviour flags are named in the file (`BF_CanUseCover`, `BF_CanUseVehicles`, `BF_CanDoDrivebys`, `BF_CanLeaveVehicle`, `BF_UseProximityFiringRate`, `BF_CanTauntInVehicle`, `BF_CanUsePeekingVariations`, `BF_MaintainMinDistanceToTarget`, `BF_CanUseDynamicStrafeDecisions` ...). These are the same flags scripts set by number with `SET_PED_COMBAT_ATTRIBUTES`; the first ones match their order in the file (0 use cover, 1 use vehicles, 2 drive-bys, 3 leave vehicle; **Known**). Rockstar's scripts most often set attribute 1 off (753 calls: stay out of vehicles), 3 on (589), 50, 17, 2, 53, 52, 46 and 5.

Other per-ped fight settings scripts use: `SET_PED_ACCURACY` (1,112 calls; most common values 1, 5, 100, 10), `SET_PED_COMBAT_MOVEMENT` (855), `SET_PED_SHOOT_RATE` (490), `SET_PED_TARGET_LOSS_RESPONSE` (402), `SET_PED_COMBAT_ABILITY` (401), `SET_PED_FIRING_PATTERN` (382), `SET_PED_COMBAT_RANGE` (274), and defensive areas (`SET_PED_SPHERE_DEFENSIVE_AREA` 1,263, `SET_PED_ANGLED_DEFENSIVE_AREA` 348) that keep a ped inside a zone while it fights.

## 5.6 Accuracy

`pedaccuracy.meta` is a single block of global modifiers (**Verified**, vanilla):

| Modifier | Value | Meaning (**Known**) |
| --- | --- | --- |
| `AI_GLOBAL_MODIFIER` | 2.0 | All AI accuracy doubled |
| `AI_DISTANCE_FOR_MAX_ACCURACY_BOOST` / `MIN` | 5 m / 15 m | Full close-range bonus within 5 m, none beyond 15 m |
| `AI_TARGET_WALKING_MODIFIER` | 0.6 | |
| `AI_TARGET_RUNNING_MODIFIER` | 0.3 | Running makes you much harder to hit |
| `AI_TARGET_IN_AIR_MODIFIER`, `AI_TARGET_DRIVING_AT_SPEED_MODIFIER` | 0.3 | |
| `AI_TARGET_IN_COMBAT_ROLL_MODIFIER` | 0.2 | |
| `AI_TARGET_IN_COVER_MODIFIER`, `AI_TARGET_COMING_OUT_OF_COVER_MODIFIER` | 0.4 | |
| `AI_BLIND_FIRE_MODIFIER` | 0.3 | |
| `AI_HURT_MODIFIER` / `AI_HURT_ON_GROUND_MODIFIER` | 0.5 / 0.1 | Wounded shooters miss more |
| `AI_PROFESSIONAL_PISTOL_VS_AI_MODIFIER` | 2.5 | Professionals with pistols are deadly against other AI |
| `PLAYER_RECOIL_MODIFIER_MIN` / `MAX`, `PLAYER_RECOIL_CROUCHED_MODIFIER`, `PLAYER_BLIND_FIRE_MODIFIER_MIN` / `MAX`, `PLAYER_RECENTLY_DAMAGED_MODIFIER` | 0.8 / 1.0, 0.5, 2 / 4, 0.3 | The player's own spread |

## 5.7 Health and melee

**Health profiles** (`pedhealth.meta`, **Verified**): `Strong` 200, `Average` 175, `Weak` 150, `Animal` 150, plus `Armour`, `GULL`, `Fish`, `Rat`, `Shark`, `Humpback`. Each sets the thresholds where a ped becomes fatigued, hurt (limps, writhes), injured and dying, and where a dog can take it down. GTA health counts from 100 (dead) upward, so an "Average" ped has 75 points to lose (**Known**).

**Melee** is driven by the action tables in `common\data\action\` (**Verified** counts): `definitions.meta` (4,945 items, 342 named actions such as `ACT_hitby_stealth_kill_a` to `_d`, `_knife`, `_bat`, `_small_wpn`, `ACT_hitby_failed_takedown_front`), `results.meta` (504), `branches.meta` (451), `homings.meta` (162, how an attacker closes in), `damages.meta` (24: `DAR_counter`, `DAR_dodge`, `DAR_shove`, `DAR_heavy`, `DAR_dog_bite`, `DAR_shark_bite`, `DAR_cougar_attack` ...), `interrelations.meta` (60) and `strike_bones.meta` (19 bone sets). Brawling styles (`pedbrawlingstyle.meta`) give each character and animal its own set: `BS_MICHAEL`, `BS_TREVOR`, `BS_FRANKLIN`, `BS_AI` and 16 animal styles.

## 5.8 How scripts run a fight

The usual recipe in Rockstar's missions (**Verified** natives and counts; the pattern is ours):

1. Create relationship groups for the sides (`ADD_RELATIONSHIP_GROUP`, 455 calls) and set them to hate each other (`SET_RELATIONSHIP_BETWEEN_GROUPS`), then put each ped in its group (`SET_PED_RELATIONSHIP_GROUP_HASH`, 1,742).
2. Set health and armour (`SET_PED_MAX_HEALTH` 410, `SET_PED_ARMOUR` 147), whether the ped dies when injured or writhes (`SET_PED_DIES_WHEN_INJURED` 483) and takes headshots (`SET_PED_SUFFERS_CRITICAL_HITS` 477).
3. Set the combat profile: attributes, movement, range, accuracy, firing pattern, defensive area, flee attributes (`SET_PED_FLEE_ATTRIBUTES` 1,744).
4. Give weapons ([guide 4](/docs/gameplay/weapons/weapons.md#47-what-scripts-do-with-weapons)) and block ambient events while the fight is scripted.
5. Start it: `TASK_COMBAT_PED` (1,010), `TASK_COMBAT_HATED_TARGETS_AROUND_PED` (832) or `_IN_AREA` (231), or a scripted sequence (`OPEN_SEQUENCE_TASK` 4,151, `TASK_PERFORM_SEQUENCE` 3,202) of cover, aim and shoot tasks (`TASK_PUT_PED_DIRECTLY_INTO_COVER` 270, `TASK_AIM_GUN_AT_ENTITY` 352, `TASK_GO_TO_COORD_WHILE_AIMING_AT_*` 447, `TASK_SHOOT_AT_*` 340).
6. Keep the task when the script lets go (`SET_PED_KEEP_TASK` 2,280).

`SET_PED_CONFIG_FLAG` is the most used ped native of all (36,119 calls); flags 427, 184, 36, 398 and 34 make up most of them (flag names are community knowledge, e.g. 32 "can fly through windscreen", 184 "don't shuffle to driver's seat"; **Known**).

## 5.9 How mods change it

All of the files above are plain data, so police and realism overhauls replace them wholesale: more combat profiles (federal agents, mercenaries, heavily armoured units, K9), lower NPC accuracy with stronger weapons, wider perception, new loadouts. When a mod replaces `events.meta` or another file with a copy from an older game build, it also silently removes the event types and fields added since; compare by name before installing.

## 5.10 What this means for modders

- **Feuds must be set up in code.** Vanilla gangs are neutral to each other; gang-war mods, faction mods and any AI-player system must create their own groups and hatreds, and put them back on cleanup.
- **Use profiles, not single natives.** A data combat profile (in an add-on pack) or a helper that sets the whole recipe of 5.8 at once gives consistent fighters; scattering individual attribute calls is what makes mod NPCs behave oddly.
- **Block events only when scripting.** Leaving events on is what makes an NPC react naturally; blocking them is for set pieces. Forgetting to unblock leaves "zombie" NPCs that ignore gunfire.
- **Set accuracy explicitly.** Police and realism mods often replace the combat profiles and `pedaccuracy.meta`, so the same profile can hit five times less often on another player's install. Spawners that set `SET_PED_ACCURACY` themselves behave the same everywhere.
- **Perception sets fairness.** 60 m sight and hearing is the default; a mod enemy that should notice the player farther away needs `SET_PED_SEEING_RANGE`, not a smaller distance check in script.

## 5.11 Open questions

| Question | Where it goes |
| --- | --- |
| Names of the common combat attributes (50, 17, 53, 52, 46) and config flags (427, 36, 398, 34), checked in game | R3.2 second pass |
| Decode `pedpersonality.ymt` (binary PSO): personalities, bravery, driving ability | R17.3 |
| Cover: how cover points are found and scored, `TASK_SEEK_COVER_*` | R17 |
| How aim assist and lock-on work for the player | R3.2 second pass |
| The full meaning of `taskdata.meta` and `scriptedguntasks.meta` | R17.1 |
| Whether the modded `events.meta` really drops gunfight reactions, in game | Test card |
