# Scenarios and ambient life

How GTA V fills the world with people doing things (smoking outside offices, jogging, fishing, parked cars that drive off, rabbits eating): the 111,898 scenario points spread over 145 region files, the scenario types they use, how scenario groups switch whole sets on and off, and how scripts start, block and read scenarios and ambient speech. Roadmap topic **R4.2** in the [roadmap](/ROADMAP.md). Builds on [population](/docs/entities/spawning/population.md) (scenario peds have their own caps in `popcycle.dat`) and [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md). Ambient behaviour as AI (wandering, reactions) is R17.8; speech is R9.2.

**How it was made.** The scenario region files (`x64a.rpf` → `levels/gta5/scenario/*.ymt`, 143 files, and 62 newer copies and additions in `update\update.rpf`) were extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does), converted to XML and their points counted by type (the `update` copy wins). The update copy of `common:/data/ai/scenarios.meta` was read for the scenario definitions. Native use from the [TASK](/scripting/native-usage/TASK.md), [AUDIO](/scripting/native-usage/AUDIO.md) and [MISC](/scripting/native-usage/MISC.md) usage pages; scenario names scripts start by literal counted with `git grep -o` (commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; how the engine runs scenarios is **Known** unless stated.

## Short version

- **111,898 scenario points** in 145 region files (named by area: `chumash_hills` 3,254 points, `countryside_sw` 2,978, `reservoir` 2,866, `east_ls_hills` 2,659, `pork_whistle_farm` 2,589).
- **210 scenario types are placed.** Animals dominate by count: `WORLD_RABBIT_EATING` 18,944, `WORLD_RABBIT_FLEE` 10,758, `WORLD_COYOTE_WANDER` 2,391, `WORLD_MOUNTAIN_LION_WANDER` 1,529, `WORLD_DEER_GRAZING` 1,175, gulls, rats, fish and cormorants. People: `WORLD_HUMAN_SMOKING` 8,087, `WORLD_HUMAN_HANG_OUT_STREET` 5,467, `WORLD_HUMAN_STAND_MOBILE` 4,715, `WORLD_HUMAN_DRINKING` 2,989, `WORLD_HUMAN_JOG` 1,919, `WORLD_HUMAN_HIKER` 1,623. Vehicles: `WORLD_VEHICLE_DRIVE_SOLO` 2,245, `WORLD_VEHICLE_EMPTY` 2,183, bicycles 2,632, parking 681. Chained driving and walking routes (`DRIVE` 12,017, `Walk` 10,914) link points into paths.
- **`scenarios.meta` defines the types:** 178 play-animation scenarios, 47 vehicle scenarios, 12 wandering, 4 flee, 4 vehicle parking, 1 look-at and 1 jogging, with 2,988 conditional clip sets (which animation to play by sex, prop, time) and over 2,000 conditions (male or female, has a prop, model, reaction to events).
- **Scripts switch groups of points:** `SET_SCENARIO_GROUP_ENABLED` (290 scripts, 44 different group names by literal), `SET_SCENARIO_TYPE_ENABLED` (52), and block areas with `ADD_SCENARIO_BLOCKING_AREA` (321 scripts).
- **Missions also use scenarios as animations:** `TASK_START_SCENARIO_IN_PLACE` (342 scripts) and `TASK_START_SCENARIO_AT_POSITION` (166); the types started most by literal are `WORLD_HUMAN_CLIPBOARD` (106 calls), `CODE_HUMAN_MEDIC_KNEEL` (84), `WORLD_HUMAN_SMOKING` (61), `WORLD_HUMAN_STAND_MOBILE` (50).
- **Ambient speech** comes with it: `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE` (370 scripts), `PLAY_PED_AMBIENT_SPEECH_NATIVE` (291).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `x64a.rpf` → `levels/gta5/scenario/<area>.ymt` and newer copies in `update.rpf` | Scenario point regions: points (position, type, model set, time window, probability, flags), chaining graphs (routes), entity overrides, cluster spheres | 145 regions, 111,898 points |
| `common:/data/ai/scenarios.meta` | Scenario type definitions, conditional animations, conditions | 247 type definitions |
| `common:/data/ai/scenariotriggers.meta` | Triggers that start scenarios from events | |
| `x64/levels/gta5/sp_manifest.ymt` | The manifest of scenario regions and groups (**Known**) | |
| `common:/data/ai/ambientpedmodelsets.meta`, `vehiclemodelsets.meta`, `propsets.meta` | Model and prop sets points can ask for | |
| `common:/data/levels/gta5/popcycle.dat` | Scenario ped caps per area and time (`#Scenario`, median 40) | [Population](/docs/entities/spawning/population.md) |

### A scenario point

**Verified (fields in the region files):** each point stores its position and direction, a type index into the file's `TypeNames` list, a model set, a group, a time window (hours it is active), a probability, an availability flag (story, Online or both), an interior and required map data, and flags. Points can be chained so a ped or vehicle moves from one to the next.

**Known (engine):** when the player is near, the population code picks free points whose time window, probability, group and model set allow it and spawns a ped (or vehicle) to use the point, up to the scenario caps of the area. Peds leave scenarios when disturbed (an event, the player bumping them) and play an exit animation.

## How scripts use scenarios

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE`, `PLAY_PED_AMBIENT_SPEECH_NATIVE` | 370, 291 | 1,121, 642 | Ambient lines ("Hi", "Watch it") |
| `TASK_START_SCENARIO_IN_PLACE`, `TASK_START_SCENARIO_AT_POSITION` | 342, 166 | 1,037, 542 | Make a ped play a scenario (smoke, lean, kneel by a body) |
| `ADD_SCENARIO_BLOCKING_AREA`, `REMOVE_SCENARIO_BLOCKING_AREA(S)` | 321, 258, 81 | 730, 549, 117 | No scenario peds in a box (mission sets) |
| `SET_SCENARIO_GROUP_ENABLED`, `IS_SCENARIO_GROUP_ENABLED`, `DOES_SCENARIO_GROUP_EXIST` | 290, 266, 264 | 894, 808, 809 | Whole groups on or off |
| `IS_PED_ACTIVE_IN_SCENARIO`, `IS_PED_USING_ANY_SCENARIO`, `PED_HAS_USE_SCENARIO_TASK` | 256, 124, 84 | | Checks |
| `SET_PED_SHOULD_PLAY_IMMEDIATE_SCENARIO_EXIT` | 153 | 477 | Make a ped drop its scenario at once |
| `SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME` | 105 | 172 | Fewer or more scenario peds |
| `DOES_SCENARIO_EXIST_IN_AREA`, `TASK_USE_NEAREST_SCENARIO_TO_COORD(_WARP)` | 55, 44, 32 | | Use a placed point |
| `SET_SCENARIO_TYPE_ENABLED` | 52 | 190 | One type on or off everywhere |

## What this means for modders

- **Animate a ped cheaply:** `TASK_START_SCENARIO_IN_PLACE(ped, "WORLD_HUMAN_SMOKING", 0, true)` gives it the full scenario (props, idle variations, exits) without loading animations yourself.
- **Clear an area of loiterers** with `ADD_SCENARIO_BLOCKING_AREA` for your scene and remove it after; density multipliers only thin them.
- **Add life to a place:** new scenario points go in a region `.ymt` (CodeWalker can edit them); ship it in your own pack. Scenario peds count against the area's `#Scenario` cap.
- **Turn off whole kinds of life** with `SET_SCENARIO_TYPE_ENABLED("WORLD_RABBIT_EATING", false)` and friends; give them back when your mod stops.
- **Cost:** scenario peds are real peds with AI; dense new points raise CPU cost like any population ([CPU](/docs/performance/cpu.md)).
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The 44 scenario groups scripts toggle and what each controls | Second pass |
| How the time window and probability combine with the `#Scenario` cap | Test card 1; R17.8 |
| How many of the 111,898 points are Online-only | Second pass: the availability field |
| The chaining graph format and how vehicles follow it | R17.6 |

## Test cards

1. **Time windows.** Visit a business district at 13:00 and 03:00. Expected: many `WORLD_HUMAN_SMOKING` and `STAND_MOBILE` peds by day, few at night.
2. **Blocking area.** Add a scenario blocking area over a plaza. Expected: loiterers stop appearing there.
3. **Scenario as animation.** Start `WORLD_HUMAN_CLIPBOARD` on a spawned ped. Expected: the ped holds a clipboard and idles naturally.
