# The job lobby (`fmmc_launcher`)

How GTA Online gets a player from freemode into a job and back: the `fmmc_launcher` script and its 11 top-level states, the activity table that turns a job type into a script name, how the job's controller is picked and started, the lobby ("corona") screens and their options, the helper scripts it starts, and where the end-of-job screens live. Roadmap topic **R7.5** in the [roadmap](/ROADMAP.md). Builds on [inside freemode](/docs/online/07-freemode.md) (who starts the launcher), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2), [UGC mission files](/file-formats/ugc-json.md) (R7.4) and [Rockstar Creator internals](/docs/online/creator-internals.md) (R7.11, job types).

**How it was made.** `fmmc_launcher` of build 1.0.3725.0 (decompile commit `6c18d3e8b`, 828,893 lines, 2,122 distinct natives) read at its entry function, its state setter and the functions named below. A call graph of the script (built with `awk` over the decompile) gave, for each top-level state, the natives and text reachable from it alone. Text labels were hashed and looked up in the American `.gxt2` files (8,905 of the script's 26,836 strings are labels). Script copies of the activity table were counted with `git grep`. Names, numbers and transitions are **Verified**; the role of a state is **Verified** where its code says so and *probable* where it is inferred from what it reaches. Function and global numbers are decompiler names for this build only. Nothing was tested in game: everything here runs in GTA Online only.

## 13.1 Short version

- **`freemode` starts `fmmc_launcher`** with a stack of 28,000 words. It runs for the whole Online session and owns everything between "I walked into a job marker or picked a job" and "the job's own script is running".
- **One state per player, 11 values.** The state lives in each player's broadcast data (`Global_1845250[player].f_96` in this build), so every player can see where everyone else is in the lobby. One setter function writes it, from 38 call sites with a fixed target state.
- **An activity table names the script for every activity:** 270 activity numbers, 260 distinct script names (92 `fm_content_*`, 68 `gb_*`, 70 `am_*`, 10 arcade games and 27 others). The same table is compiled into **266 scripts**.
- **A job type becomes an activity, then a script:** type 0 Mission → activity 251 → `fm_mission_controller_2020` (content version 2 or later), `fm_mission_controller` (older content) or `Public_Mission_Controller` (subtype 14); type 1 → `fm_deathmatch_controler`; 2 → `FM_Race_Controler`; 3 → `FM_Survival_Controller` or `FM_Horde_Controler`; 8 (Parachuting) → `fm_Bj_race_controler`; 6 (Gang Attack) → `fm_hideout_controler`.
- **Controllers get 89,500 words of stack** and a 21-value argument block (`START_NEW_SCRIPT_WITH_ARGS`), after a check that the same script isn't already active for that instance (`NETWORK_IS_SCRIPT_ACTIVE`).
- **The lobby is the "corona":** options such as weather, traffic, rounds, difficulty, teams and cash wager (`FM_ISC_*` labels), buying ammo and armour (`FM_COR_*`), invites, a ready count ("~1~ of ~1~ Ready") and "Launching Job".
- **Helpers it starts:** `net_cloud_mission_loader` (2,050), `FMMC_PlayList_Controller` (8,344), `FM_Maintain_Transition_Players` (2,050), `FM_Impromptu_DM_Controler` (64,500) and the heist planning boards `gb_casino_heist_planning` and `gb_gang_ops_planning` (64,500).
- **The end-of-job screens are not in the launcher:** the like/dislike rating and "next job" vote (`FM_NXT_*`) are shared code inside each controller.

## 13.2 Where it lives

| Script | Started by (stack) | Role |
| --- | --- | --- |
| `fmmc_launcher` | `freemode` (28,000) | The lobby and job start, all session long |
| `net_cloud_mission_loader` | `fmmc_launcher`, `freemode` (2,050) | Loads a job's file from the cloud into the FMMC globals |
| `FMMC_PlayList_Controller` | `fmmc_launcher` (8,344) | Runs a playlist (a series of jobs) |
| `FM_Maintain_Transition_Players` | `fmmc_launcher` (2,050) | Keeps the job's players together through the transition |
| The job controllers | `fmmc_launcher` (89,500) | Play the job: race, deathmatch, mission, survival ... |
| `AM_MP_PROPERTY_INT` | `fmmc_launcher` (10 calls) | Property interiors used as lobby or job start points |

What the launcher shares with the rest of Online, by global block ([global map](/docs/core/global-map.md)): player broadcast data (`Global_1845250`, 880 values per player: the lobby state and launch flags), the job lobby state (`Global_2685150`), the job transition state (`Global_2686090`) and the loaded job (`Global_4718592`, the FMMC structure). These numbers are for build 3725.

## 13.3 The 11 top-level states

The entry function runs once (sets up the activity session flag, clears followers, sets state 1), then loops: each frame it updates the shared data, lets the script host run host-only work (`NETWORK_IS_HOST_OF_THIS_SCRIPT`), and calls the function for the player's current state (**Verified**).

| State | Moves to | What it does |
| ---: | --- | --- |
| 0 | 1 | Reset: sets state 1 |
| 1 | 2 | Start-up: reads session invites (`NETWORK_SESSION_WAS_INVITED`, `_GET_INVITER`) and where the player was, then goes idle |
| 2 | 4, 5, 8, 9, 10 | Idle in freemode, watching for a job to join. *Probable* from its exits: 4 when the player is joining a lobby, 8 when a job list or quick job is requested, 9 when a job is already set up, 10 for one other case |
| 3 | 5 | Waits; goes to cleanup when one player check passes (*probable*: the player has left or finished the job) |
| 4 | 5, 9 | **The lobby.** Hides HUD and feed, plays the `MenuMGHeistIn` screen effect, draws the corona screens, handles vehicle, outfit and property entry (the largest state: about 5,200 functions reachable) |
| 5 | 3 | Cleanup after a job or a cancelled lobby (`func_9459`, `func_9451`) |
| 6 | 2 | After a fade: deletes the loaded data file (`DATAFILE_DELETE`), fades in and goes idle |
| 7 | | A two-function state; not settled |
| 8 | 4, 5, 9 | **Finding a job**: the UGC queries (`UGC_QUERY_MY_CONTENT`, `_BY_CATEGORY`, `UGC_GET_BOOKMARKED_CONTENT`, `_MOST_RECENTLY_PLAYED_CONTENT`, `_CREW_CONTENT` ...), privilege checks, activity groups (`NETWORK_JOIN_GROUP_ACTIVITY`), and the series names ("Stunt Series", "Community Race Series", "Cayo Perico Series" ...) |
| 9 | 5 | **Running the job**: launches the controller (13.5) and waits for it; random trains are turned off for the job (`DELETE_ALL_TRAINS`, `SET_RANDOM_TRAINS`) |
| 10 | 5 | Another job path (`func_26`), *probably* a job started from a property or planning board |

The state setter is called with a fixed state 38 times; the busiest source is the idle logic (`func_13037`, 14 calls to states 4, 5, 8, 9 and 10).

## 13.4 The activity table

One function (`func_3628` here) maps an activity number to a script name (**Verified**). It is shared header code: the same table is in 266 scripts, so freemode events, the phone, the interaction menu and the lobby all name scripts the same way.

| Group | Numbers (examples) | Scripts |
| --- | --- | --- |
| Freemode events | 1, 32 to 47 | `AM_HOLD_UP`, `AM_JOYRIDER`, `AM_PLANE_TAKEDOWN`, `AM_KILL_LIST`, `AM_TIME_TRIAL`, `AM_PENNED_IN`, `AM_HUNT_THE_BEAST` ... |
| Boss and biker work | 48 to 126 | `GB_DEATHMATCH`, `GB_CONTRABAND_SELL`, `GB_BIKER_*`, `GB_GUNRUNNING`, `GB_SMUGGLER`, `GB_CASINO_HEIST`, `BUSINESS_BATTLES` ... |
| Newer content | 127 to 222 | 92 `fm_content_*` scripts: `fm_content_island_heist`, `_payphone_hit`, `_security_contract`, `_vehrob_*`, `_acid_lab_*`, `_daily_bounty`, `_pizza_delivery`, `_survival` ... |
| Ambient and services | 3 to 31, 223 to 240 | `AM_CRATE_DROP`, `AM_backup_heli`, `AM_airstrike`, `AM_PI_MENU`, `AM_TAXI`, `am_rollercoaster`, `am_ferriswheel`, `AM_DAILY_OBJECTIVES` ... |
| Minigames | 241 to 246, 255, 256 | `AM_ArmWrestling`, `AM_Darts`, `golf_mp`, `Range_Modern_MP`, `tennis_network_mp`, `Pilot_School_MP` |
| **Job controllers** | 247 to 253 | `FM_Impromptu_DM_Controler`, `fm_Bj_race_controler`, `fm_deathmatch_controler`, `fm_hideout_controler`, the mission controller (251), `FM_Race_Controler`, survival or horde (253) |
| Arcade | 254, 257 to 262, 267 to 270 | `grid_arcade_cabinet`, `road_arcade`, `gunslinger_arcade`, `wizard_arcade`, `camhedz_arcade`, `puzzle` ... |
| Spectating | 271 | `SCTV` |

## 13.5 From job type to running controller

**Type to activity** (**Verified**, `func_8862`): job type 0 → 251, 1 → 249, 2 → 252, 3 → 253, 5 → 247 (impromptu deathmatch), 6 → 250, 8 → 248, 11 → 243 (golf), 12 → 245 (tennis), 13 → 244 (shooting range), 14 → 242 (darts), 15 → 241 (arm wrestling), 122 → 246 (flight school). Higher type numbers map to the `GB_` and `fm_content_` activities.

**Picking the mission controller** (**Verified**, `func_3630`):

1. Type 0 with subtype 14 (Mission Creator Content, [R7.11](/docs/online/creator-internals.md)) → `Public_Mission_Controller`.
2. Content version (`Global_4718592.f_192778`) 2 or higher → `fm_mission_controller_2020` (the newer heists).
3. Otherwise → `fm_mission_controller` (classic missions and heists).

Survival picks `FM_Survival_Controller` or `FM_Horde_Controler` from one flag of the loaded job.

**Starting it** (**Verified**, `func_9044` and `func_8939`):

1. The player's broadcast data records the job instance and activity, and a "launching" bit is set.
2. If that script is already active for this instance (`NETWORK_IS_SCRIPT_ACTIVE`), nothing is started.
3. The stack size comes from the activity: **89,500** for all the job controllers, minigames and the larger boss jobs; 8,344, 5,050, 2,050 or 1,424 for smaller events.
4. With the screen faded out where required, `START_NEW_SCRIPT_WITH_ARGS(name, args, 21, stack)` starts it with a 21-value argument block (the instance and the activity among them), then `SET_SCRIPT_AS_NO_LONGER_NEEDED`.

## 13.6 The lobby screens

The corona's text gives its options (**Verified**, labels used by `fmmc_launcher`):

| Area | Examples |
| --- | --- |
| Job details | "Created By", "Rating", "Players", "Teams", "Distance", "Personal Best", "Crew Best", "Leaderboard", "Survival Details" |
| Settings | "Select the weather.", "Set the level of traffic.", "Choose the Race round type.", "Set the difficulty of the Heist.", "Rounds are locked for this Race.", "Confirm Settings" |
| Money | "Cash Wager", "Betting Cash", "You can't afford this bet." |
| Shopping | "Purchase All Ammo", "Ammo purchased.", "Purchase ~a~" (armour), "You already have armor equipped.", "Browse your weapons." |
| Race grid | "Best Lap", "Race Time", "Driver", "Co-Driver", "Grid", "Random" |
| Players | "Invite Players", "Inviting players (~a~)", "~1~ of ~1~ Ready", "~a~ is host (~a~)", "Waiting on host" |
| Leaving | "The leader has left the lobby.", "You have been kicked from the Job.", "Previous transaction pending." |
| Start | "Waiting to launch", "Launching Job (~a~)", "Launching (~a~)", "Continuing (~a~)" |

Most of the clothing labels in the script (`TORSO_P`, `LEGS_P`, `FEET_P`, `PROPS_P`, `OUTFIT_P` and others, over 1,600) are *probably* for the outfit picker of team and adversary jobs ("Adversary Outfits", "The outfit is locked for this role.").

## 13.7 After the job

The launcher doesn't draw the end of a job. The like/dislike rating (`ES_HELP_TU`, `ES_HELP_TD`) and the "next job" screen (`FM_NXT_RAC`, `FM_NXT_DM`, `FM_NXT_MIS`, `FM_NXT_LTS`, `FM_NXT_CTF` ...) are shared code compiled into each controller (`fm_race_controler`, `fm_mission_controller`, `fm_deathmatch_controler` ...). The rating screen is also used by story-mode activities (`country_race`, `darts`, `triathlonsp`, the `rampage` scripts): 39 scripts contain one of these labels. Once the controller ends, the launcher's state goes to cleanup (5) and back to idle (**Verified**, transitions above).

## 13.8 What this means for modders

- **None of this runs in story mode.** `fmmc_launcher` waits on `NETWORK_IS_GAME_IN_PROGRESS` and the cloud. Don't run mods in GTA Online to drive it; accounts get banned.
- **The activity table is a ready-made index** of which script runs which Online activity (13.4). It's the place to start before reading any `am_`, `gb_` or `fm_content_` script.
- **An offline job player has to replace three things:** loading the job's file into the FMMC globals (`net_cloud_mission_loader`), the lobby settings it would have chosen (weather, traffic, rounds, teams) and the 21-value start arguments, before a controller can run. The controllers also expect a network session (see [story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)).

## 13.9 Open questions

| Question | Where it goes |
| --- | --- |
| The exact role of states 7 and 10, and which idle exits go to 4, 8 and 9 | Next pass, follow `func_13037`'s conditions |
| The meaning of each of the 21 start-argument values | Next pass, read a controller's entry function |
| How the corona's settings are stored and sent to the controller | Next pass, with `Global_2685150` |
| How playlists and series step from job to job (`FMMC_PlayList_Controller`) | Next pass |
| How a walk-in job marker in freemode hands over to the launcher | R7.1 second pass (`freemode`) |

## 13.10 Test cards

None: the lobby only runs in GTA Online.
