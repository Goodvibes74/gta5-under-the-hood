# Transitions and sessions

How the game moves between story mode and GTA Online: `maintransition`'s 70 named transition states and the paths through them (into freemode, into the creator, back to story), the session natives it calls, the character slots, what "network game in progress" switches on across the scripts, and what fails when there's no session. Roadmap topic **R7.2** in the [roadmap](/ROADMAP.md). Builds on [how Online works](/docs/online/01-how-online-works.md), [boot](/docs/00-getting-started/boot.md) (who starts the transition) and [inside freemode](/docs/online/07-freemode.md) (what runs after it).

**How it was made.** `maintransition` (376,686 lines, build 3725, decompile commit `6c18d3e8b`) read around its state setter and its state-name function; native use from [`tools/native-usage.ps1`](/scripting/native-usage.md) `-Script maintransition`; scripts reading the state global counted with `git grep`. The state names are Rockstar's own strings inside the script (**Verified**); `Global_1575018` and the function numbers are decompiler names for this build only. Session behaviour on Rockstar's servers is **Known**.

## 9.1 Short version

- **The transition is one state machine with 70 named states** (`TRANSITION_STATE_EMPTY` = 0 to `TRANSITION_STATE_SPAWN_INTO_PERSONAL_VEHICLE` = 69), set through one function that also reports each stage to the engine (`NETWORK_TRANSITION_ADD_STAGE`) and stores it in one global (`Global_1575018` in this build).
- **382 scripts read that global,** so most of the game knows which transition stage is running (selector, main_persistent, missions, startup).
- **Three destinations share it:** freemode (states 16 to 31), the content creator (32 to 38; what runs inside it: [Rockstar Creator internals](/docs/online/creator-internals.md)) and a "testbed" session for development (39 to 52); plus story mode on the way back (55, 56, 63, 64).
- **The usual way in:** `SP_SWOOP_UP` (the sky camera) → HUD checks → `PREJOINING_FM_SESSION_CHECKS` → `LOOK_FOR_FRESH_JOIN_FM` (matchmaking) → `CONFIRM_FM_SESSION_JOINING` → `WAIT_JOIN_FM_SESSION` → `PRE_FM_LAUNCH_SCRIPT` → `FM_TEAMFULL_CHECK` → `START_FM_LAUNCH_SCRIPT` (starts `freemode`) → `FM_TRANSITION_CREATE_PLAYER` → `IS_FM_AND_TRANSITION_READY` → `FM_SWOOP_DOWN` → `FM_FINAL_SETUP_PLAYER` → `MOVE_FM_TO_RUNNING_STATE`.
- **Sessions are made by the engine:** `NETWORK_SESSION_DO_FREEROAM_QUICKMATCH`, `_DO_FRIEND_MATCHMAKING`, `_DO_CREW_MATCHMAKING`, `_DO_ACTIVITY_QUICKMATCH`, or hosting with `NETWORK_SESSION_HOST`, `_HOST_CLOSED`, `_HOST_FRIENDS_ONLY` and **`_HOST_SINGLE_PLAYER`** (a solo session); leaving with `_NETWORK_SESSION_LEAVE_INCLUDING_REASON` (32 calls).
- **Before the player exists in Online the transition needs the servers:** privileges (`NETWORK_HAVE_ONLINE_PRIVILEGES`, `NETWORK_HAVE_ROS_MULTIPLAYER_PRIV`, platform subscription), cloud tunables (`NETWORK_REQUEST_CLOUD_TUNABLES`), the transaction server session (`NET_GAMESERVER_INIT_SESSION`, `_START_SESSION`, validity checks) and the character's stats (`STAT_LOAD`, 57 checks of `STAT_CLOUD_SLOT_LOAD_FAILED`). Retry states exist for each character slot (`RETRY_LOADING_SLOT_1` to `_4`).
- **There is an offline-mode branch:** one path logs `PLAYSTATS_STARTED_SESSION_IN_OFFLINEMODE` and moves on to `START_FM_LAUNCH_SCRIPT` (state 24) after `NETWORK_SESSION_VALIDATE_JOIN`; the other requires the cloud stats load not to have failed. What enables that branch (a function returning true) is open (9.6).
- **"Network game in progress" is the switch the rest of the game reads:** `NETWORK_IS_GAME_IN_PROGRESS` is checked in 905 scripts (108 times in `maintransition` alone). Without a real session it's false, and every Online script that needs it stops or waits ([how Online works](/docs/online/01-how-online-works.md)).

## 9.2 The 70 states

| Group | States (number = name, minus `TRANSITION_STATE_`) |
| --- | --- |
| Idle and camera | 0 `EMPTY`, 1 `SP_SWOOP_UP`, 2 `MP_SWOOP_UP`, 3 `CREATOR_SWOOP_UP`, 7 `SP_SWOOP_DOWN`, 8 `MP_SWOOP_DOWN` |
| Checks before joining | 4 `PRE_HUD_CHECKS`, 5 `WAIT_HUD_EXIT`, 6 `WAIT_FOR_SUMMON`, 15 `WAIT_ON_INVITE`, 9 `CANCEL_JOINING` |
| Loading the character | 10 `RETRY_LOADING`, 11 to 14 `RETRY_LOADING_SLOT_1` to `_4`, 67 `WAIT_FOR_DIRTY_LOAD_CONFIRM` |
| Into freemode | 16 `PREJOINING_FM_SESSION_CHECKS`, 17 `LOOK_FOR_FRESH_JOIN_FM`, 18 `LOOK_TO_JOIN_ANOTHER_SESSION_FM`, 19 `CONFIRM_FM_SESSION_JOINING`, 20 `WAIT_JOIN_FM_SESSION`, 21 `CREATION_ENTER_SESSION`, 22 `PRE_FM_LAUNCH_SCRIPT`, 23 `FM_TEAMFULL_CHECK`, 24 `START_FM_LAUNCH_SCRIPT`, 25 `FM_TRANSITION_CREATE_PLAYER`, 26 `IS_FM_AND_TRANSITION_READY`, 27 `FM_SWOOP_DOWN`, 28 `POST_BINK_VIDEO_WARP`, 29 `FM_FINAL_SETUP_PLAYER`, 30 `MOVE_FM_TO_RUNNING_STATE`, 31 `FM_HOW_TO_TERMINATE` |
| Into the creator | 32 `START_CREATOR_PRE_LAUNCH_SCRIPT_CHECK`, 33 `START_CREATOR_LAUNCH_SCRIPT`, 34 `CREATOR_TRANSITION_CREATE_PLAYER`, 35 `IS_CREATOR_AND_TRANSITION_READY`, 36 `CREATOR_SWOOP_DOWN`, 37 `CREATOR_FINAL_SETUP_PLAYER`, 38 `MOVE_CREATOR_TO_RUNNING_STATE` |
| Testbed (development sessions) | 39 to 52: the same steps for a "testbed" session, including `LOOK_FOR_FRESH_HOST_TESTBED` and `LOOK_TO_HOST_SESSION_TESTBED` |
| Leaving and switching | 53 `QUIT_CURRENT_SESSION_PROMPT`, 54 `WAIT_FOR_TRANSITION_SESSION_TO_SETUP`, 57 `KICK_TERMINATE_SESSION`, 58 `TERMINATE_SESSION`, 59 `WAIT_TERMINATE_SESSION`, 60 `TERMINATE_SESSION_AND_HOLD`, 61 `TERMINATE_SESSION_AND_MOVE_INTO_HOLDING_STATE`, 62 `TEAM_SWAPPING_CHECKS`, 65 `WAITING_FOR_EXTERNAL_TERMINATION_CALL`, 66 `TERMINATE_MAINTRANSITION` |
| Story mode | 55 `TERMINATE_SP`, 56 `WAIT_TERMINATE_SP`, 63 `RETURN_TO_SINGLEPLAYER`, 64 `WAIT_FOR_SINGLEPLAYER_TO_START` |
| Extras | 68 `DLC_INTRO_BINK` (an update's intro video), 69 `SPAWN_INTO_PERSONAL_VEHICLE` |

How often each state is set in the code (a rough map of the busy paths): `WAIT_HUD_EXIT` 115 times, `PRE_HUD_CHECKS` 56, `TERMINATE_SESSION` 41, `PREJOINING_FM_SESSION_CHECKS` 20, `WAIT_JOIN_FM_SESSION` 16, `PRE_FM_LAUNCH_SCRIPT` 8; most other states once to six times.

## 9.3 What `maintransition` does at start

Before the state machine runs (**Verified**, entry function): marks itself network-safe, turns the big map off, makes itself unpausable, takes control away and freezes the player (or, in a vehicle, keeps the vehicle from stopping), clears timecycle modifiers, shows radar and HUD, blocks a few controls, stops the story score (`GTA_ONLINE_STOP_SCORE`), turns voice chat off and requests cloud tunables. On the story side `selector` has already started it ([character switching](/docs/gameplay/player/character-switching.md)) and the swoop up is the same switch camera Online uses for joining (`SWITCH_TO_MULTI_FIRSTPART` / `_SECONDPART`).

## 9.4 Sessions and the server

| Need | Natives in `maintransition` | Without Rockstar's servers |
| --- | --- | --- |
| Account allowed to play | `NETWORK_HAVE_ONLINE_PRIVILEGES` (6), `NETWORK_HAVE_ROS_MULTIPLAYER_PRIV`, `NETWORK_HAVE_PLATFORM_SUBSCRIPTION` (14), `NETWORK_HAVE_ROS_BANNED_PRIV` | Fails |
| A session | Quickmatch, friend, crew or activity matchmaking; host open, closed, friends-only or single-player; invites | Hosting a single-player session is local (**Known**), but everything after needs the rest of this table |
| Cloud tunables | `NETWORK_REQUEST_CLOUD_TUNABLES`, `NETWORK_IS_TUNABLE_CLOUD_REQUEST_PENDING`, `NETWORK_ACCESS_TUNABLE_*` | Defaults only |
| Transaction server | `NET_GAMESERVER_INIT_SESSION`, `_START_SESSION`, `_IS_SESSION_VALID` (7), `_IS_SESSION_REFRESH_PENDING` | Fails; no purchases |
| Character stats | `STAT_LOAD`, `STAT_LOAD_PENDING` (24), `STAT_CLOUD_SLOT_LOAD_FAILED` (57), `FORCE_CLOUD_MP_STATS_DOWNLOAD_AND_OVERWRITE_LOCAL_SAVE` | Load fails (`HUD_CLOUDFAILMSG`, retry states) |
| Cloud files | `CLOUD_CHECK_AVAILABILITY`, `NETWORK_IS_CLOUD_AVAILABLE` (11), `NETWORK_REQUEST_CLOUD_BACKGROUND_SCRIPTS` | Unavailable |
| Way back | `SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME`, `SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE` (kicks) | |

### 9.4.1 The offline branch, the slots, the way back and the testbed (second pass)

*Second pass, 2026-10-30.* **Verified** in `maintransition`, `freemode` and `freemode_clearGlobals`.

**The offline-mode branch can't be reached.** It is gated on one global flag. The only write to that flag anywhere in the build-3725 scripts sets it to 0, so the branch that logs `PLAYSTATS_STARTED_SESSION_IN_OFFLINEMODE` never runs on any platform. The normal path into state 24 is the other branch, which needs the cloud stat load to have succeeded.

**The retry states and the slots.** States 10 to 14 retry loading the player's cloud saves:

| State | Retries |
| ---: | --- |
| 10 `RETRY_LOADING` | Cloud save slot 0 (the account-wide `mpply_` stats) |
| 11 `RETRY_LOADING_SLOT_1` | Cloud save slot 1 (the first character) |
| 12 `RETRY_LOADING_SLOT_2` | Cloud save slot 2 (the second character) |
| 13, 14 | Wait on any stat load still pending (14 shows `MP_SPINLOADING` and falls back if the cloud is unavailable) |

Each one goes back to the HUD checks (4) when the load finishes, or to the waiting state (5) on failure. `HUD_SLOTONE` and `HUD_SLOTTWO` are the text "Slot 1" and "Slot 2". They label the two character saves in the warning screen shown when one or both failed to load. So there are two characters, plus the account-wide save.

**The way back to story mode.** `maintransition` asks for state 63 `RETURN_TO_SINGLEPLAYER` directly from several places. Session errors go first through 58 `TERMINATE_SESSION` and 59 `WAIT_TERMINATE_SESSION`, which route the player on. State 63 then:

1. Shows the "quitting" spinner (`HUD_QUITTING`).
2. Waits until `startup_positioning`, the transition helper and every creator script have stopped, and the session is not busy.
3. Ends the network game and clears the session data (UGC queries cancelled, invites and voice settings restored).
4. Waits for the player switch to be ready to descend, then calls `NETWORK_ON_RETURN_TO_SINGLE_PLAYER`.
5. Detaches and freezes the player ped, and moves to 64 `WAIT_FOR_SINGLEPLAYER_TO_START`, which keeps the spinner up until story mode takes over.

The other exit, 7 `SP_SWOOP_DOWN`, can't be taken: the check that picks between them always returns true in this build.

**The testbed session.** States 40 to 52 are entered only when `GET_INDEX_OF_CURRENT_LEVEL` is 5, the development level ([boot](/docs/00-getting-started/boot.md)). A release PC game loads level 1, so the testbed path is unused in release builds.

**What opens the creator.** The transition keeps a destination value next to the state. When the destination is 2, the "into the session" step moves to 32 `START_CREATOR_PRE_LAUNCH_SCRIPT_CHECK`, the first creator state (33 then starts the creator script).

**`freemode_clearGlobals`.** Only `freemode` starts it (stack 14,100), once, as one of its first steps; `main_persistent` and `FM_Maintain_Transition_Players` only preload it. `freemode` waits in a loop until the script reports it is done. The script runs 31 reset steps. Each step builds a default copy of one Online global block and writes it over the block: the player and session blocks, the interaction-menu and freemode local state (`Global_2733002`, the largest), the business, delivery and event blocks. So every session starts from clean defaults, whatever the previous session left behind.

## 9.5 What this means for modders

- **Read the transition state, don't guess:** a mod that must not act during a transition can check `NETWORK_IS_IN_TRANSITION` / `NETWORK_IS_TRANSITION_STARTED`; the state global itself moves every build ([global map](/docs/core/global-map.md)).
- **A real session can't be made offline** in a way that satisfies the stats, tunables and transaction steps, so an offline Online-style mod doesn't go through `maintransition` at all. Such mods stay in story mode and switch the map with `ON_ENTER_MP`; the transition state stays `EMPTY`, which is what the 382 scripts reading it expect in story mode.
- **Keep the story wheel from starting `MainTransition`** while a fake-Online mode runs ([story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)).

## 9.6 Open questions

| Question | Where it goes |
| --- | --- |
| What enables the offline-mode branch before `START_FM_LAUNCH_SCRIPT` (the function returning true), and whether it can be reached on PC | Answered in [9.4.1](#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass): it can't be reached in this build |
| What the four character "slots" in the retry states are (two characters plus?) and how `HUD_SLOTONE` / `HUD_SLOTTWO` relate | Answered in [9.4.1](#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass) |
| The order of states on the way back to story mode, step by step | Answered in [9.4.1](#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass) |
| What the testbed session is used for in release builds | Answered in [9.4.1](#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass): unused; only level 5 enters it |
| Which scripts outside `maintransition` ask for the return to story mode, and what retry state 13 waits for | Next pass, the callers of the state request |

## 9.7 Test cards

None: everything here is read from the script. Never test mods in real GTA Online.
