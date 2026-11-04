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

## Availability, chains and aircraft (leftovers pass)

**Verified** (Every `.ymap`, `.ytyp`, `.ymf`, `.ynd`, `.ynv` and scenario `.ymt` in the vanilla archives loaded with CodeWalker's library by a read-only scan, build 1.0.3725.0 Legacy; one copy per file name, the update's winning over DLC over base). Counting each region file once, the update's copy where it has one, gives **144 region files with 109,198 points** (the earlier count of 111,898 in 145 files counted differently; this one is per file name).

**Availability.** Each point has a byte that CodeWalker reads as both / story only / Online only (**Known** meaning of the values):

| Value | Points | Mostly |
| --- | ---: | --- |
| 0, both | 57,779 | People, vehicles, everything not split |
| 1, story mode only | 50,331 | **Animals**: rabbits 29,236, coyotes, mountain lions, deer, gulls, rats, fish, sharks, dolphins, orcas; plus 6,016 `Walk` and 643 `DRIVE` route points |
| 2, Online only | 1,088 | Street hangers-on, smokers, drug dealers, prostitutes, 95 police cars, Lost MC clubhouse and drug-field workers (`island_drug_fields` 171 on Cayo Perico) |

So the answer to "how many are Online-only" is 1,088, and the big split is the other way: half the points (the wildlife) exist only in story mode.

**Chaining graphs.** 140 region files have a chaining graph: **45,372 nodes, 40,907 edges, 4,697 chains**. A node is a position with a scenario type (`DRIVE` 12,071, `Walk` 10,949, `WORLD_VEHICLE_DRIVE_SOLO` 2,221, joggers, hikers, bicycles, animals); an edge joins two nodes with an action (`Move` 40,474, `MoveFollowMaster` 431), a way to travel (`Direct` 24,689, `NavMesh` 14,530, `Roads` 1,688) and one of 16 speeds; a chain is a list of edges. A ped or vehicle that starts on a chained point follows the chain from node to node (**Known**).

**Where ambient aircraft and boats come from.** Not from a special system: they are vehicle scenario points (`WORLD_VEHICLE_DRIVE_SOLO`, `_DRIVE_PASSENGERS`) whose vehicle model set is a plane, helicopter or boat set, on chains. The plane routes are in four files of their own, `ng_planes`, `ng_planes_city`, `ng_planes_north` and `ng_planes_south` (360 points, 58 chains), plus the airports and coast:

| Model set | Points | Where |
| --- | ---: | --- |
| `AIRPORT_PLANES`, `AIRPORT_PLANES_SMALL` | 220 | `ng_planes*`, Vespucci coast, LSIA |
| `PLANE_COUNTRYSIDE`, `PLANE_CROPS` | 169 | `ng_planes`, Great Ocean Highway, the hills, crop dusters over the north-east farms |
| `PRIVATE_HELI`, `POLICE_HELI`, `ARMY_HELI`, `LIFEGUARD_HELI`, `SWIFT_DLC_HELI` | 128 | Vespucci, Vinewood, LSIA, South LS, `ng_planes`, the beaches |
| `BLIMP` | 14 | `downtown` |
| `COASTGUARD_BOAT`, `BOATS_LUXURY`, `BOATS_SALTON`, `JETSKI` and other boat sets | about 410 | Zancudo, Paleto Bay, Cape Catfish, the west coast, the Alamo Sea, the reservoir |

### The scenario groups scripts switch (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in the build 1.0.3725.0 decompile. Scripts name **43 scenario groups** in `SET_SCENARIO_GROUP_ENABLED` calls. Most calls pass the group in a variable instead: 742 such calls come from shared code in 248 scripts. The groups and the scripts that name them:

| Group | Scripts that toggle it |
| --- | --- |
| `HEIST_ISLAND_PEDS` | `fm_bj_race_controler`, `fm_content_island_heist`, `fm_deathmatch_controler`, `fm_deathmatch_creator` and 15 more |
| `MP_POLICE` | `carsteal2`, `freemode`, `jewelry_prep1b`, `main_persistent` |
| `MOVIE_STUDIO_SECURITY` | `carsteal3`, `player_timetable_scene` |
| `LOST_BIKERS` | `code_controller`, `fbi5a` |
| `ARMY_GUARD` | `docks_prep2b`, `mission_triggerer_b` |
| `SANDY_PLANES` | `epsilon6`, `trevor2` |
| `GRAPESEED_PLANES` | `finale_heist2b`, `trevor2` |
| `SCRAP_SECURITY` | `finale_heist_prepb`, `mission_triggerer_d` |
| `SEW_MACHINE` | `jewelry_setup1`, `mission_triggerer_a` |
| `QUARRY` | `launcher_offroadracing`, `offroad_races` |
| `TRIATHLON_1_START` | `launcher_triathlon`, `triathlonsp` |
| `TRIATHLON_2_START` | `launcher_triathlon`, `triathlonsp` |
| `TRIATHLON_3_START` | `launcher_triathlon`, `triathlonsp` |
| `BLIMP` | `player_controller`, `standard_global_reg` |
| `CINEMA_TEXTILE` | `act_cinema` |
| `CINEMA_MORNINGWOOD` | `act_cinema` |
| `CINEMA_DOWNTOWN` | `act_cinema` |
| `FIB_GROUP_2` | `agency_heist3a` |
| `FIB_GROUP_1` | `agency_heist3a` |
| `ARMENIAN_CATS` | `armenian2` |
| `CHINESE2_LUNCH` | `chinese2` |
| `CHINESE2_HILLBILLIES` | `chinese2` |
| `ARMY_HELI` | `docks_prep2b` |
| `OBSERVATORY_BIKERS` | `extreme1` |
| `LSA_PLANES` | `extreme2` |
| `ALAMO_PLANES` | `fbi5a` |
| `POLICE_POUND1` | `freemode` |
| `POLICE_POUND2` | `freemode` |
| `POLICE_POUND3` | `freemode` |
| `POLICE_POUND4` | `freemode` |
| `POLICE_POUND5` | `freemode` |
| `HIPPIE_420_DLC_GROUP` | `freemode` |
| `COUNTRYSIDE_BANKS` | `freemode` |
| `CITY_BANKS` | `freemode` |
| `RAMPAGE1` | `launcher_rampage` |
| `KORTZ_SECURITY` | `michael3` |
| `ATTRACT_PAP` | `paparazzo1` |
| `DEALERSHIP` | `re_yetarian` |
| `SOLOMON_GATE` | `solomon1` |
| `PRISON_TOWERS` | `traffick_ground` |
| `TRIATHLON_1` | `triathlonsp` |
| `TRIATHLON_2` | `triathlonsp` |
| `TRIATHLON_3` | `triathlonsp` |

What each group holds (which scenario points) is in the scenario `.ymt` files. By name they cover mission set dressing (`FIB_GROUP_1`, `ARMENIAN_CATS`, `KORTZ_SECURITY`), activities (`TRIATHLON_*`, `CINEMA_*`, `QUARRY`), plane and blimp traffic (`SANDY_PLANES`, `GRAPESEED_PLANES`, `LSA_PLANES`, `ALAMO_PLANES`, `BLIMP`), guards (`ARMY_GUARD`, `SCRAP_SECURITY`, `PRISON_TOWERS`, `SOLOMON_GATE`) and Online areas (`HEIST_ISLAND_PEDS`, `POLICE_POUND1` to `5`, `CITY_BANKS`, `COUNTRYSIDE_BANKS`).

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
| The 44 scenario groups scripts toggle and what each controls | Mostly answered in [the scenario groups table](#the-scenario-groups-scripts-switch-leftovers-pass) (leftovers pass): 43 groups named in the scripts, with the scripts that switch each. Left: the points in each group (scenario files) |
| How the time window and probability combine with the `#Scenario` cap | Test card 1; R17.8 |
| How many of the 111,898 points are Online-only | Answered in [availability, chains and aircraft](#availability-chains-and-aircraft-leftovers-pass): 1,088; 50,331 are story-only |
| The chaining graph format and how vehicles follow it | Mostly answered in [availability, chains and aircraft](#availability-chains-and-aircraft-leftovers-pass): nodes, edges, chains and their fields; the 16 speed values are unnamed |

## Test cards

1. **Time windows.** Visit a business district at 13:00 and 03:00. Expected: many `WORLD_HUMAN_SMOKING` and `STAND_MOBILE` peds by day, few at night.
2. **Blocking area.** Add a scenario blocking area over a plaza. Expected: loiterers stop appearing there.
3. **Scenario as animation.** Start `WORLD_HUMAN_CLIPBOARD` on a spawned ped. Expected: the ped holds a clipboard and idles naturally.
