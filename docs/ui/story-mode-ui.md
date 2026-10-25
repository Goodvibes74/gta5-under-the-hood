# Story-mode UI

The story mode's own screens and what draws them: the character wheel, the mission-passed screen and its stats and medal, the 206-stat Stats page in eight categories, the 100% checklist, the pause-menu pages story mode uses, and the phone. Roadmap topic **R8.6** in the [roadmap](/ROADMAP.md). Most pieces have their own guide; this page ties them together and adds the stats screen and the pass screen. Builds on [character switching](/docs/gameplay/player/character-switching.md) (R6.1), [completion, autosave and achievements](/docs/core/completion-and-autosave.md) (R5.3), [pause and Online menus](/docs/ui/pause-menu.md) (R8.1), [Scaleform movies](/docs/ui/scaleform.md) (R8.2) and [interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10).

**How it was made.** `update\update.rpf\common\data\ui\spstatssetupui.xml` of build 1.0.3725.0 extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and parsed with `awk` (comments removed); `selector` and `mission_stat_watcher` read in the decompile (commit `6c18d3e8b`) for their Scaleform movies and method names; text labels resolved from the American `.gxt2` files. Counts and names are **Verified**; what a screen looks like is **Known**.

## 26.1 Short version

- **The character wheel** is `selector` with three Scaleform movies: `PLAYER_SWITCH`, `PLAYER_SWITCH_PROLOGUE` and `PLAYER_SWITCH_STATS_PANEL`. It sets slots, the selected character, hints, damage and the stats panel (`SET_SWITCH_SLOT`, `SET_PLAYER_SELECTED`, `SET_SWITCH_HINTED_ALL`, `SET_PLAYER_DAMAGE`, `SET_STATS_LABELS` ...). The switch itself is in [R6.1](/docs/gameplay/player/character-switching.md).
- **The mission-passed screen** is `mission_stat_watcher` drawing `MP_BIG_MESSAGE_FREEMODE` (the same movie Online uses for big messages) with `SHOW_MISSION_PASSED_MESSAGE`, rows added with `SET_DATA_SLOT`, and roll-up and transition methods. Text: "Mission Passed" (`MISHPA`), "Heist Passed" (`HISHPA`), 210 mission stat labels (`MISHSTA_*`), "Medal", "Completion", and markers for skipped, retried-from-checkpoint, cheated and taxi-skipped runs.
- **The Stats page** is laid out by `spstatssetupui.xml`: **206 stats in 8 categories**: Skills (8), General (32), Crimes (23), Vehicles (46), Cash (45), Combat (9), Weapons (38) and 100% Checklist (5). 178 are always visible and 28 appear only after they first change.
- **Stats are typed for display:** `int` (95), `cash` (30), `time` (17), `bool` (15), `distance` (14), `fraction` (13), `bar` (8, the skill bars), `checklist` (5), `short_distance` (5), and one each of `percent`, `speed`, `namehash`, `carhash`. Some swap numbers for text with `ReplaceLabel` ranges (29 of them).
- **The 100% checklist** shows the completion groups ([R5.3](/docs/core/completion-and-autosave.md)) as `checklist` stats such as `NUM_MISC_COMPLETED`.
- **Story pause-menu pages** (map, brief, stats, settings, game, gallery, replays) are in [R8.1](/docs/ui/pause-menu.md); the phone and its apps in [R7.10](/docs/online/interaction-menu-phone-apps.md).

## 26.2 The Stats page

`spstatssetupui.xml` (**Verified**) lists stats by category; each line gives the stat name (matching the stat definitions), a display type, a visibility rule, an optional text label and whether it's per character. The file's own header documents the format (types `float`, `int`, `time`, `distance`, `date`; visibility `ALWAYS_VISIBLE`, `NEVER_VISIBLE`, `AFTER_INCREMENT`, `SPECIAL_EDITION`, `CONDITIONAL`; `ReplaceLabel` to show a word instead of a number; `fraction` and `checklist` types).

| Category (label) | Stats | Examples |
| --- | ---: | --- |
| Skills (`SP_STATS1`) | 8 | `SPECIAL_ABILITY_UNLOCKED`, `STAMINA`, `SHOOTING_ABILITY`, `STRENGTH`, `STEALTH_ABILITY`, `FLYING_ABILITY`, `WHEELIE_ABILITY`, `LUNG_CAPACITY` |
| General (`SP_STATS2`) | 32 | `TOTAL_PLAYING_TIME`, `FIRST_PERSON_CAM_TIME`, `MISSIONS_PASSED`, `LAST_MISSION_NAME`, `NUM_HIDDEN_PACKAGES_0` to `_7`, `MANUAL_SAVED`, `TIMES_CHEATED`, `DEATHS`, `DIED_IN_EXPLOSION` / `_FALL` / `_FIRE` / `_ROAD` / `_DROWNING`, `TIME_SWIMMING` |
| Crimes (`SP_STATS3`) | 23 | |
| Vehicles (`SP_STATS4`) | 46 | |
| Cash (`SP_STATS5`) | 45 | |
| Combat (`SP_STATS6`) | 9 | |
| Weapons (`SP_STATS7`) | 38 | |
| 100% Checklist (`SP_STATS8`) | 5 | The completion groups |

The skills show as bars (the `bar` type, 8 stats); their meaning is in [skills and abilities](/docs/gameplay/player/skills-and-abilities.md).

## 26.3 The mission-passed screen

`mission_stat_watcher` (8,904 lines) watches the running mission's stats and, at the end, draws the pass screen (**Verified** method calls): `SHOW_MISSION_PASSED_MESSAGE` on `MP_BIG_MESSAGE_FREEMODE`, `SET_DATA_SLOT` per row (5 calls), `ROLL_DOWN_BACKGROUND` / `ROLL_UP_BACKGROUND`, `TRANSITION_UP`, `TRANSITION_OUT`, plus `instructional_buttons` for "Continue" and the rating prompts. The rows use 210 `MISHSTA_*` labels (one per tracked mission stat, the same set across the decompile), and the footer uses `MTPHPER` ("Completion") with notes for skipped (`MTPHPERSKI`), checkpoint (`MTPHPERRET`), cheats (`MTPHPERCHE`), taxi (`MTPHPERTAX`) and missed (`MTPHPERNOREC`).

### How a mission picks its stats and its medal

*Second pass (2026-10-25).* Read in `main` and `mission_stat_watcher` (commit `6c18d3e8b`; function names are build-specific pointers). **Verified** unless marked.

**The stat table.** At start-up `main` fills a table of **913 mission stats** (`Global_65235`, 13 values each) from one long switch (`func_1978`). Each entry has a type, a target, a flag that says whether lower is better, and the name of the stat it saves to (`ms_<mission>_<what>`: `ms_arm2_time`, `ms_trv1_no_survivors`, `ms_lam1_headshots`, `ms_exl1_accuracy`). 341 entries name a saved stat; the other 572 save nothing. 175 entries are "lower is better" (times, damage taken, falls). The types, read from the stat names that use them:

| Type | Entries | What it measures (examples, target) |
| ---: | ---: | --- |
| 1 | 85 | Mission time, lower is better (`ms_arm2_time` 390,000 ms) |
| 2 | 3 | A time on one task (`ms_sol3_news_heli_cam_time`) |
| 3 | 133 | A yes/no goal (`ms_arm2_petrol_fire`, `ms_trv3_not_detected`) |
| 4 | 92 | A timed task (`ms_fam2_fast_swim` 60,000 ms, `ms_mic2_mike_rescue_timer`) |
| 5 | 73 | Top speed (`ms_fam4_lorry_speed` 34) |
| 6 | 120 | Damage, lower is better (`ms_arm1_noscratch`) |
| 7 | 40 | Headshots (`ms_lam1_headshots` 10) |
| 8, 10 | 12, 103 | Counts (`ms_chi1_body_count` 32, `ms_fbi1_speckills` 4, `ms_mar1_fell_off_the_bike` at most 1) |
| 9 | 40 | Accuracy in percent (`ms_exl1_accuracy` 80) |
| 11 | 8 | Other percentages (`ms_pap2_face_recog_percent` 90, `ms_ah3a_oxygen_remaining` 40) |
| 12 | 24 | Damage in dollars (`ms_rh2_collateral_damage`, `ms_finpc1_mod_gauntlet`) |
| 15, 16, 17 | 43, 58, 79 | Bullets fired, innocents killed, special ability time (almost all unnamed) |

A mission lists which of the 913 it uses; `mission_stat_watcher` tracks only those while the mission runs and adds one pass-screen row per stat (at most 13 rows), each with its `MISHSTA_*` label.

**The completion and the medal.** The footer's "Completion" percentage is `50 + 50 × (stats met ÷ stats listed)`, rounded up and capped at 100; meeting every stat gives exactly 100. So passing with no stat met still scores 50%. The medal follows from the percentage: **gold at 100%, silver above 50%, bronze at 50%**; a skipped mission is set to 50% (bronze). The colours are HUD colours 107, 108 and 109 (`HUD_COLOUR_BRONZE`, `_SILVER`, `_GOLD`, [HUD colours](/docs/ui/hud-colours-blips.md)). The best percentage is kept in the story save per mission, and the first time a mission reaches 100% a counter in the save goes up by one (the count of gold medals).

**`SHOW_MISSION_PASSED_MESSAGE`'s parameters.** The movie defines the method without named parameters (it reads its `arguments`), so the order comes from the one script that calls it with every value, `mission_stat_watcher`:

| # | Type | What the script passes |
| ---: | --- | --- |
| 1 | text label | The title (`MISHPA` "Mission Passed", `HISHPA` "Heist Passed" ...) |
| 2 | text label | The mission name |
| 3 | int | 100 in story mode, 150 when a network game is running (**Known**: the background height) |
| 4 | bool | Always `true` |
| 5 | int | The number of stat rows that follow (one fewer for one screen type) |
| 6 | bool | Passed in by the caller |
| 7 | int | 2 for two of the screen types, otherwise a value the caller sets, 69 by default |

`agency_prep2amb` is the only other caller; it passes a title, a name, 100, `true`, 0 and `true`.

**The minigame result screen.** `minigame_stats_tracker` and `minigame_ending_stinger` are named nowhere in the decompile, neither as a string nor as their `joaat` hash (2,005,372,777 and 128,858,001), so nothing starts them in build 3725; the minigames draw their own end screens.

### The full stat list

*Second pass.* Every stat in `spstatssetupui.xml`, by category and display type (**Verified**). `*` marks the 28 stats shown only after they first change (`AFTER_INCREMENT`); `°` marks the 52 shared by all three characters (`characterStat="false"`), the rest are kept per character.

| Category | Type | Stats | Names |
| --- | --- | ---: | --- |
| Skills (`SP_STATS1`) | `bar` | 8 | `SPECIAL_ABILITY_UNLOCKED`, `STAMINA`, `SHOOTING_ABILITY`, `STRENGTH`, `STEALTH_ABILITY`, `FLYING_ABILITY`, `WHEELIE_ABILITY`, `LUNG_CAPACITY` |
| General (`SP_STATS2`) | `time` | 6 | `TOTAL_PLAYING_TIME`, `FIRST_PERSON_CAM_TIME`°, `TIME_SWIMMING`, `TIME_UNDERWATER`, `TIME_WALKING`, `TIME_IN_COVER` |
|  | `int` | 12 | `MISSIONS_PASSED`, `LAST_MISSION_NAME`, `MANUAL_SAVED`, `TIMES_CHEATED`, `DEATHS`, `DIED_IN_EXPLOSION`, `DIED_IN_FALL`, `DIED_IN_FIRE`, `DIED_IN_ROAD`, `DIED_IN_DROWNING`, `NO_PHOTOS_TAKEN`, `LAP_DANCED_BOUGHT` |
|  | `fraction` | 9 | `NUM_HIDDEN_PACKAGES_0`*°, `NUM_HIDDEN_PACKAGES_1`*°, `NUM_HIDDEN_PACKAGES_2`*°, `NUM_HIDDEN_PACKAGES_3`*°, `NUM_HIDDEN_PACKAGES_4`*°, `NUM_HIDDEN_PACKAGES_5`*°, `NUM_HIDDEN_PACKAGES_6`*°, `NUM_HIDDEN_PACKAGES_7`*°, `NUM_DESTROYED_SIGNS_0`*° |
|  | `distance` | 3 | `DIST_SWIMMING`, `DIST_WALKING`, `DIST_RUNNING` |
|  | `short_distance` | 1 | `LONGEST_SURVIVED_FREEFALL` |
|  | `namehash` | 1 | `SP_MOST_FAVORITE_STATION`° |
| Crimes (`SP_STATS3`) | `int` | 20 | `KILLS_COP`, `KILLS_SWAT`, `NO_TIMES_WANTED_LEVEL`, `BUSTED`, `STARS_ATTAINED`, `STARS_EVADED`, `DB_KILLS`, `PASS_DB_KILLS`, `TIRES_POPPED_BY_GUNSHOT`, `HIGHEST_SKITTLES`, `NUMBER_STOLEN_CARS`, `NUMBER_STOLEN_BIKES`, `NUMBER_STOLEN_HELIS`, `NUMBER_STOLEN_PLANES`, `NUMBER_STOLEN_BOATS`, `NUMBER_STOLEN_QUADBIKES`, `NUMBER_STOLEN_BICYCLES`, `NUMBER_STOLEN_COP_VEHICLE`, `KILLS_SINCE_LAST_CHECKPOINT`, `KILLS_SINCE_SAFEHOUSE_VISIT` |
|  | `time` | 3 | `LAST_CHASE_TIME`, `LONGEST_CHASE_TIME`, `TOTAL_TIME_MAX_STARS` |
| Vehicles (`SP_STATS4`) | `time` | 8 | `TIME_DRIVING_CAR`, `TIME_DRIVING_BIKE`, `TIME_DRIVING_HELI`, `TIME_DRIVING_PLANE`, `TIME_DRIVING_BOAT`, `TIME_DRIVING_QUADBIKE`, `TIME_DRIVING_BICYCLE`, `TIME_DRIVING_SUBMARINE` |
|  | `distance` | 11 | `DIST_CAR`, `DIST_BIKE`, `DIST_HELI`, `DIST_PLANE`, `DIST_BOAT`, `DIST_QUADBIKE`, `DIST_BICYCLE`, `DIST_SUBMARINE`, `DIST_AS_PASSENGER_TRAIN`, `DIST_AS_PASSENGER_TAXI`, `LONGEST_DRIVE_NOCRASH` |
|  | `speed` | 1 | `FASTEST_SPEED` |
|  | `carhash` | 1 | `TOP_SPEED_CAR` |
|  | `short_distance` | 4 | `LONGEST_STOPPIE_DIST`, `LONGEST_WHEELIE_DIST`, `FARTHEST_JUMP_DIST`, `HIGHEST_JUMP_REACHED` |
|  | `int` | 17 | `NUMBER_CRASHES_CARS`, `NUMBER_CRASHES_BIKES`, `NUMBER_CRASHES_QUADBIKES`, `BAILED_FROM_VEHICLE`, `MOST_FLIPS_IN_ONE_JUMP`, `MOST_SPINS_IN_ONE_JUMP`, `THROWNTHROUGH_WINDSCREEN`, `NUMBER_NEAR_MISS`, `CARS_COPS_EXPLODED`, `CARS_EXPLODED`, `BIKES_EXPLODED`, `HELIS_EXPLODED`, `PLANES_EXPLODED`, `BOATS_EXPLODED`, `QUADBIKE_EXPLODED`, `NO_CARS_REPAIR`, `VEHICLES_SPRAYED` |
|  | `fraction` | 4 | `USJS_FOUND`°, `USJS_COMPLETED`°, `SP_UNDER_THE_BRIDGE_COUNT`°, `SP_KNIFE_FLIGHTS_COUNT`° |
| Cash (`SP_STATS5`) | `cash` | 30 | `TOTAL_CASH_EARNED`, `MONEY_TOTAL_SPENT`, `MONEY_MADE_FROM_MISSIONS`, `MONEY_MADE_FROM_RANDOM_PEDS`, `MONEY_PICKED_UP_ON_STREET`, `MONEY_SPENT_IN_COP_BRIBES`, `MONEY_SPENT_ON_HEALTHCARE`, `MONEY_SPENT_CAR_MODS`, `MONEY_SPENT_IN_BUYING_GUNS`, `MONEY_SPENT_IN_CLOTHES`, `MONEY_SPENT_ON_TATTOOS`, `MONEY_SPENT_ON_HAIRDOS`, `MONEY_SPENT_IN_STRIP_CLUBS`, `MONEY_SPENT_ON_TAXIS`, `MONEY_SPENT_PROPERTY`, `PROP_EARNED_BARHE`*°, `PROP_EARNED_BARHO`*°, `PROP_EARNED_BARPI`*°, `PROP_EARNED_BARTE`*°, `PROP_EARNED_CIND`*°, `PROP_EARNED_CINM`*°, `PROP_EARNED_CINV`*°, `PROP_EARNED_CMSH`*°, `PROP_EARNED_CSCR`*°, `PROP_EARNED_GOLF`*°, `PROP_EARNED_SOCO`*°, `PROP_EARNED_TAXI`*°, `PROP_EARNED_TOWI`*°, `PROP_EARNED_TRAF`*°, `PROP_EARNED_WEED`*° |
|  | `bool` | 15 | `PROP_BOUGHT_BARHE`°, `PROP_BOUGHT_BARHO`°, `PROP_BOUGHT_BARPI`°, `PROP_BOUGHT_BARTE`°, `PROP_BOUGHT_CIND`°, `PROP_BOUGHT_CINM`°, `PROP_BOUGHT_CINV`°, `PROP_BOUGHT_CMSH`°, `PROP_BOUGHT_CSCR`°, `PROP_BOUGHT_GOLF`°, `PROP_BOUGHT_SOCO`°, `PROP_BOUGHT_TAXI`°, `PROP_BOUGHT_TOWI`°, `PROP_BOUGHT_TRAF`°, `PROP_BOUGHT_WEED`° |
| Combat (`SP_STATS6`) | `int` | 8 | `SHOTS`, `HITS_PEDS_VEHICLES`, `KILLS`, `HEADSHOTS`, `KILLS_ARMED`, `KILLS_IN_FREE_AIM`, `KILLS_STEALTH`, `SUCCESSFUL_COUNTERS` |
|  | `percent` | 1 | `WEAPON_ACCURACY` |
| Weapons (`SP_STATS7`) | `int` | 38 | `PISTOL_KILLS`, `CMBTPISTOL_KILLS`, `PISTOL50_KILLS`*, `APPISTOL_KILLS`, `MICROSMG_KILLS`, `SMG_KILLS`, `ASLTSMG_KILLS`*, `ASLTRIFLE_KILLS`, `CRBNRIFLE_KILLS`, `ADVRIFLE_KILLS`, `MG_KILLS`, `CMBTMG_KILLS`, `PUMP_KILLS`, `SAWNOFF_KILLS`, `ASLTSHTGN_KILLS`, `BULLPUP_KILLS`*, `SNIPERRFL_KILLS`, `HVYSNIPER_KILLS`, `GRNLAUNCH_KILLS`, `RPG_KILLS`, `MINIGUNS_KILLS`, `GRENADE_KILLS`, `SMKGRENADE_KILLS`, `STKYBMB_KILLS`, `MOLOTOV_KILLS`, `KNIFE_KILLS`, `NIGHTSTICK_KILLS`, `CROWBAR_KILLS`, `HAMMER_KILLS`*, `BAT_KILLS`, `GCLUB_KILLS`, `UNARMED_KILLS`, `STUNGUN_KILLS`, `RHINO_ROCKET_KILLS`, `BUZZARD_BULLET_KILLS`, `BUZZARD_ROCKET_KILLS`, `LAZER_BULLET_KILLS`, `LAZER_ROCKET_KILLS` |
| 100% Checklist (`SP_STATS8`) | `checklist` | 5 | `NUM_MISSIONS_COMPLETED`°, `NUM_MINIGAMES_COMPLETED`°, `NUM_RNDPEOPLE_COMPLETED`°, `NUM_RNDEVENTS_COMPLETED`°, `NUM_MISC_COMPLETED`° |

## 26.4 What this means for modders

- **Add a line to the Stats page** only by editing `spstatssetupui.xml` and using a stat that already exists; a mod can't define new stats ([saves](/docs/core/saves.md)).
- **Reuse the pass screen look** in a mod with `MP_BIG_MESSAGE_FREEMODE` and `SHOW_MISSION_PASSED_MESSAGE` ([Scaleform movies](/docs/ui/scaleform.md)); it works in story mode.
- **Hide the character wheel during a mod's scene** the way missions block switching ([R6.1](/docs/gameplay/player/character-switching.md)).

## 26.5 Open questions

| Question | Where it goes |
| --- | --- |
| Which of the 913 stats each mission lists, and what types 15 to 17 are for when they have no stat name | Next pass: the per-mission list (`Global_77106`) |
| What parameters 3, 6 and 7 of `SHOW_MISSION_PASSED_MESSAGE` change on screen | Next pass, the movie's ActionScript, or an in-game test with different values |

Answered in the second pass: the full stat list ([26.3](#the-full-stat-list)), how a mission picks its stats and the medal thresholds, and the parameters of `SHOW_MISSION_PASSED_MESSAGE` ([26.3](#how-a-mission-picks-its-stats-and-its-medal)).

## 26.6 Test cards (story mode)

1. **Stats page.** Open Pause → Stats. Expected: eight categories, Skills first with eight bars.
2. **After increment.** Check that a stat marked `AFTER_INCREMENT` (for example a rare death cause) is missing on a new save and appears after it happens once.
