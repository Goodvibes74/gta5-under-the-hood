# Peds

How a ped model is defined: its entry in `peds.ymt` (type, relationship group, personality, combat and decision data, animations, voice, special ability), the personality and health it gets from other files, the component and prop data that dresses it, the naming of the 1,109 ped models, and how scripts create, dress and set up peds. Roadmap topic **R14.2** in the [roadmap](/ROADMAP.md). Builds on [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (health configs through personalities), [population](/docs/entities/spawning/population.md) (ped groups) and [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) (the player's components). AI behaviour is R17.

**How it was made.** `update:/x64/data/peds.ymt` and `update:/x64/data/metadata/pedpersonality.ymt` extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and converted to XML; each DLC pack's `peds.meta` extracted the same way (25 files); hashed names matched against the decompile's string literals. The ped asset files (`.ydd` models, `.ytd` textures, `.ymt` component data) counted in a listing of every vanilla archive. Native use from the [PED](/scripting/native-usage/PED.md) and [TASK](/scripting/native-usage/TASK.md) usage pages (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; what each field does in the engine is **Known** unless stated.

## Short version

- **1,109 ped models:** 683 in the base `peds.ymt`, 426 added by DLC packs.
- **The name prefix says what a ped is:** `a_` ambient (266), `ig_` in-game story characters (258), `s_` service and uniformed (152), `csb_` cutscene characters reused in game (132), `u_` unique one-offs (96), `cs_` cutscene-only (91), `g_` gang members (62), `mp_` Online (41), `player_` the three story characters (3).
- **Ped type** (`Pedtype`) is coarse: civilian male 765, civilian female 279, animal 41, cop 11, army 7, one each for the three players, medic, fireman and SWAT.
- **Behaviour comes by reference.** Each ped names a relationship group (civilian male 690, civilian female 275 ...), a personality (119 different; `streamed_male` and its variants 264, `SERVICEMALES` 130, `fitnessmale` 61), a combat info (`default` 969, `gang` 59, `SCARED_ANIMAL` 26), a decision maker (`default` 982, `gang` 52, `COP` 13) and perception, navigation, motion and task data sets.
- **Special abilities sit on the model:** `AbilityType` is `SAT_NONE` for 1,105 peds, `SAT_CAR_SLOWDOWN` for Franklin, `SAT_RAGE` for Trevor and `SAT_BULLET_TIME` for Michael (`Player_Zero` and `P_Michael_02`).
- **Clothes are data per model:** each ped has a component `.ymt` (723 distinct across the archives) listing which drawables and textures exist for head, hair, torso, legs and the other slots; the models and textures fill archives such as `streamedpeds_mp.rpf` (2,993 textures, 828 models), `streamedpeds_players.rpf` (1,909, 499) and `cutspeds.rpf` (1,071, 899).
- **Scripts set peds up heavily:** `SET_PED_COMPONENT_VARIATION` in 628 scripts with 100,960 calls, `SET_PED_CONFIG_FLAG` 694 scripts (36,119), `CREATE_PED` 618, `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` 627, `SET_PED_RELATIONSHIP_GROUP_HASH` 438, `SET_PED_COMBAT_ATTRIBUTES` 360.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `update:/x64/data/peds.ymt` (base `common:/data/peds.meta`) | Ped model entries (`CPedModelInfo__InitData`) | 683 |
| DLC packs → `common:/data/peds.meta` (`PED_METADATA_FILE` in `content.xml`) | More ped models | 426 in 25 files |
| `update:/x64/data/metadata/pedpersonality.ymt` | Personalities: health config, bravery, driving, how they react (R17.3) | 96 in the base file; DLC packs add more (`PED_PERSONALITY_FILE`, 23 entries) |
| `common:/data/pedhealth.meta` | Health configs a personality points to ([R3.8](/docs/gameplay/player/health-armour-death.md)) | 10 |
| `common:/data/ai/combatbehaviour.meta` and the combat info data | Combat infos named by `CombatInfo` | R17.3 |
| `common:/data/relationships.dat` | Default relationships between groups | R17.4 |
| Per-ped `.ymt` in the ped archives | Component and prop variations for one model | 723 distinct |
| `x64/models/cdimages/streamedpeds_*.rpf`, `cutspeds.rpf`, `pedprops.rpf` and the DLC equivalents | `.ydd` drawables, `.ytd` textures, props | thousands |

### One ped entry

A ped's entry (Franklin, `Player_One`, as the example) names:

| Field | Example | What it links to |
| --- | --- | --- |
| `Pedtype` | `PLAYER_1` | The coarse type (`GET_PED_TYPE`) |
| `RelationshipGroup` | `civmale` | Default relationship group (R17.4) |
| `Personality` | `franklin` | `pedpersonality.ymt` entry (health, bravery, driving) |
| `CombatInfo`, `DecisionMakerName` | `franklin`, `default` | Combat and event-response data (R17.3) |
| `PerceptionInfo`, `NavCapabilitiesName`, `MotionTaskDataSetName`, `DefaultTaskDataSetName` | `default_perception`, `standard_ped`, `player_one`, `standard_ped` | Seeing and hearing, navigation, movement and default tasks |
| `MovementClipSet`, `StrafeClipSet`, `DefaultGestureClipSet`, `FacialClipsetGroupName` | `move_p_m_one` ... | Animations (R13.4) |
| `PedVoiceGroup` | (hashed) | Ambient speech voice (R9.2) |
| `Radio1`, `Radio2` | `RADIO_GENRE_MODERN_HIPHOP`, `RADIO_GENRE_CLASSIC_HIPHOP` | The radio genres the ped tunes to when driving |
| `DefaultBrawlingStyle`, `DefaultUnarmedWeapon` | `bs_franklin`, `weapon_unarmed` | Melee |
| `AbilityType` | `SAT_CAR_SLOWDOWN` | Special ability |
| `PedComponentSetName`, `PropsName` | `player`, `Player_One_p` | Which component and prop data to use |
| `SuperlodType` | `SLOD_HUMAN` (1,058 peds) | The very-low-detail stand-in far away |
| `AmbulanceShouldRespondTo`, `CanSpawnInCar`, `CanRideBikeWithNoHelmet`, `IsHeadBlendPed` | flags | Engine rules for the model |

## How scripts use peds

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_PED_CONFIG_FLAG` | 694 | 36,119 | Hundreds of per-ped switches (can't be dragged out of cars, no helmet, keep weapon ...) |
| `SET_PED_COMPONENT_VARIATION` | 628 | 100,960 | Dress a ped: component slot, drawable, texture, palette |
| `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` | 627 | 7,232 | Stop a ped reacting on its own (mission actors) |
| `CREATE_PED`, `CREATE_PED_INSIDE_VEHICLE`, `CREATE_RANDOM_PED` | 618, 344, 12 | 5,469, 883, 12 | Spawn |
| `DELETE_PED` | 594 | 7,781 | Remove |
| `SET_PED_PROP_INDEX`, `CLEAR_PED_PROP` | 558, 539 | 6,520, 5,508 | Hats, glasses, earrings, watches |
| `GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS` | 556 | 1,385 | How many options a slot has |
| `SET_PED_KEEP_TASK` | 486 | 2,280 | Keep the task after the script releases the ped |
| `SET_PED_HEAD_BLEND_DATA`, `SET_PED_HEAD_OVERLAY` | 439, 439 | 2,206, 822 | Online character faces and make-up |
| `SET_PED_RELATIONSHIP_GROUP_HASH`, `SET_PED_AS_ENEMY` | 438, 339 | 1,742, 1,142 | Friend or foe |
| `SET_PED_DEFAULT_COMPONENT_VARIATION`, `SET_PED_RANDOM_COMPONENT_VARIATION` | 413, 66 | 3,594, 123 | Default or random outfit |
| `SET_PED_COMBAT_ATTRIBUTES`, `SET_PED_FLEE_ATTRIBUTES`, `SET_PED_ACCURACY` | 360, 268, 249 | 7,614, 1,744, 1,112 | Combat set-up (R3.2) |
| `GET_PED_TYPE` | 126 | 527 | The ped type |

**Known:** a ped spawned with `CREATE_PED` uses its model's defaults from `peds.ymt` (relationship group, personality, combat info) until a script overrides them; Rockstar's missions almost always override the relationship group, combat attributes and the block on events.

## What this means for modders

- **Spawning a usable ped:** `REQUEST_MODEL`, wait, `CREATE_PED`, then set what the model's defaults don't give you: `SET_PED_RELATIONSHIP_GROUP_HASH`, `SET_PED_COMBAT_ATTRIBUTES`, `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` if it should ignore the world, then `SET_MODEL_AS_NO_LONGER_NEEDED`. `SET_PED_DEFAULT_COMPONENT_VARIATION` gives the model's standard look.
- **Pick models by prefix:** `a_` for crowds, `s_` for uniforms (police, paramedics, workers), `g_` for gangs, `ig_` and `csb_` for named characters, `mp_m_freemode_01` / `mp_f_freemode_01` for fully customisable characters.
- **An add-on ped** needs a `peds.meta` entry (copy a similar model's and change the name), its `.ydd`, `.ytd` and component `.ymt`, and a `PED_METADATA_FILE` line in your pack's `content.xml`. Point `Personality`, `CombatInfo` and `RelationshipGroup` at existing entries.
- **Change how a kind of ped behaves** by editing the referenced data (a personality, a combat info) rather than every ped: many models share each entry.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The 23 personality hashes and relationship groups that didn't resolve | Second pass |
| What each `SET_PED_CONFIG_FLAG` number does (the ones Rockstar sets most) | Second pass: count flag numbers in the decompile |
| The component `.ymt` format (slots, drawables, restrictions) | R6.3, R14.2 second pass |

## Test cards

1. **Defaults.** Spawn `s_m_y_cop_01` and `a_m_y_hipster_01` with `CREATE_PED` and shoot near them. Expected: the cop fights (`COP` combat and decision data), the hipster flees.
2. **Ability.** Switch Franklin's model with Trevor's (`SET_PLAYER_MODEL`) and press the special ability. Expected: the ability of the model (`SAT_RAGE`), not of the save's character (**Known**).
3. **Components.** For `mp_m_freemode_01`, loop slot 11 (tops) through `GET_NUMBER_OF_PED_DRAWABLE_VARIATIONS`. Expected: hundreds of tops from the base game and DLC.
