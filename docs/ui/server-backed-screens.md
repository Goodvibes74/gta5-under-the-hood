# Server-backed Online screens

Which Online screens depend on Rockstar's servers, which server service each one uses, how the screens wait for it (busy spinners, warning screens, validity checks), and what a local, offline replacement would have to supply. Roadmap topic **R8.5** in the [roadmap](/ROADMAP.md). Builds on [pause and Online menus](/docs/ui/pause-menu.md) (R8.1), [stats and tunables](/docs/online/stats-and-tunables.md) (R7.3: what the server owns), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2), the [job lobby](/docs/online/job-lobby.md) (R7.5) and [interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10).

**How it was made.** For 16 UI-side scripts of build 1.0.3725.0 (decompile commit `6c18d3e8b`), calls to each family of server natives were counted with `grep` (UGC content, Social Club, crews, cloud files, leaderboards, the transaction server `NET_GAMESERVER_*`, stats). Script-wide counts come from [native usage](/scripting/native-usage.md); the engine-filled pages from `pausemenu.xml` ([R8.1](/docs/ui/pause-menu.md)). Counts are **Verified**. What each service returns and what an offline mode needs is **Known** or *probable* (inferred from the natives), as marked.

## 25.1 Short version

- **Seven server services stand behind the Online UI:** Rockstar Online Services credentials and sign-in, cloud files, UGC (jobs and creations), Social Club (presence, profanity checks, messages), crews (`NETWORK_CLAN_*`), leaderboards, and the transaction server (`NET_GAMESERVER_*`: catalogue, prices, baskets, checkout). Stats sit on top of all of them ([R7.3](/docs/online/stats-and-tunables.md)).
- **The heaviest screens** by server calls: `fmmc_launcher` (the job lobby: 250 UGC, 100 crew, 93 leaderboard, 124 transaction calls), `appinternet` (519 transaction calls, of which 328 check catalogue items and 42 read prices), `pausemenu_multiplayer` (328 UGC), `appmpjoblistnew` (110 UGC, 50 transaction), `am_pi_menu` (88 leaderboard, 65 transaction, 41 crew).
- **Some Online pages need no server at all:** `mp_awards`, `mp_unlocks` and `mp_weapons` only read stats (4 to 7 stat calls each), so they work from local stat values.
- **Pages filled by the engine from the network** (no script to replace): friends, Online friends, crews and crew details, party, players, the store tab and six corona invite lists ([R8.1](/docs/ui/pause-menu.md)).
- **Screens wait with spinners and warnings:** `BEGIN_TEXT_COMMAND_BUSYSPINNER_ON` in 169 scripts (805 calls), `BUSYSPINNER_OFF` in 317; `SET_WARNING_MESSAGE_WITH_HEADER` in 328 scripts (3,015 calls) for "unavailable" and error screens.
- **Every server action is guarded:** `NETWORK_HAS_VALID_ROS_CREDENTIALS` (613 scripts), `NETWORK_IS_SIGNED_ONLINE` (590), `NET_GAMESERVER_IS_SESSION_VALID` (362 scripts, 3,163 calls), `NETWORK_IS_CLOUD_AVAILABLE` (259). Without the servers these are false, and the screens show their warning instead of content.

## 25.2 Server calls per screen

Calls in each script (**Verified**):

| Script | Screen | UGC | Social Club | Crews | Cloud | Leaderboards | Transactions | Stats |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `fmmc_launcher` | Job lobby and corona | 250 | 18 | 100 | 6 | 93 | 124 | 87 |
| `appinternet` | In-game websites | 0 | 22 | 24 | 2 | 0 | 519 | 85 |
| `pausemenu_multiplayer` | Online pause pages | 328 | 13 | 10 | 5 | 0 | 7 | 8 |
| `appmpjoblistnew` | Phone job list | 110 | 0 | 18 | 5 | 0 | 50 | 20 |
| `am_pi_menu` | Interaction menu | 0 | 14 | 41 | 1 | 88 | 65 | 25 |
| `maintransition` | Character select, joining | 6 | 26 | 36 | 18 | 1 | 57 | 404 |
| `appbusinesshub` | Business computer | 0 | 0 | 17 | 0 | 0 | 55 | 20 |
| `sctv` | Spectator TV | 2 | 0 | 23 | 0 | 0 | 46 | 20 |
| `appsecuroserv` | CEO office computer | 6 | 0 | 2 | 1 | 0 | 23 | 5 |
| `am_contact_requests` | Phone contact services | 0 | 8 | 8 | 1 | 0 | 18 | 19 |
| `ingamehud` | Online HUD | 9 | 15 | 17 | 1 | 0 | 5 | 99 |
| `appmpemail` | Online email | 0 | 19 | 0 | 0 | 0 | 0 | 1 |
| `pausemenu_map` | Map page | 7 | 0 | 0 | 0 | 0 | 0 | 4 |
| `mp_awards`, `mp_unlocks`, `mp_weapons` | Awards, unlocks, weapons pages | 0 | 0 | 0 | 0 | 0 | 0 | 7, 4, 7 |

Columns are name families: UGC = `UGC_*` and `DATAFILE_UGC_*`; Social Club = `SOCIALCLUB` namespace and `SC_*`; Crews = `NETWORK_CLAN_*`; Cloud = `CLOUD_*`, `NETWORK_IS_CLOUD_*`, `DATAFILE_*CLOUD*`; Leaderboards = `LEADERBOARDS*`; Transactions = `NET_GAMESERVER_*`; Stats = `STAT_*`.

**The websites are a shop front:** of `appinternet`'s 519 transaction calls, 328 are `NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID`, 42 `NET_GAMESERVER_GET_PRICE`, 22 `_IS_SESSION_VALID`, 22 `_IS_SESSION_REFRESH_PENDING` and 13 `_BASKET_IS_FULL`: each item on a site is checked against the server's catalogue and priced by it.

## 25.3 How screens wait

| Mechanism | Natives | Scripts | Calls |
| --- | --- | ---: | ---: |
| Busy spinner | `BEGIN_TEXT_COMMAND_BUSYSPINNER_ON` / `END_`, `BUSYSPINNER_OFF`, `BUSYSPINNER_IS_ON`, `PRELOAD_BUSYSPINNER` | 169, 317, 266, 141 | 805, 1,362, 429, 151 |
| Pause menu spinner | `PAUSE_MENU_SET_BUSY_SPINNER` | 4 | 23 |
| Warning screens | `SET_WARNING_MESSAGE_WITH_HEADER`, `SET_WARNING_MESSAGE`, `_WITH_HEADER_AND_SUBSTRING_FLAGS` | 328, 83, 26 | 3,015, 169, 224 |
| Credentials | `NETWORK_HAS_VALID_ROS_CREDENTIALS`, `NETWORK_IS_REFRESHING_ROS_CREDENTIALS` | 613, 35 | 1,273, 38 |
| Sign-in and privileges | `NETWORK_IS_SIGNED_ONLINE`, `NETWORK_HAVE_ONLINE_PRIVILEGES` | 590, 106 | 1,555, 482 |
| Transaction session | `NET_GAMESERVER_IS_SESSION_VALID` | 362 | 3,163 |
| Cloud | `NETWORK_IS_CLOUD_AVAILABLE` | 259 | 318 |
| Buying | `NET_GAMESERVER_BASKET_START`, `NET_GAMESERVER_CHECKOUT_START` | 291, 362 | 291, 581 |

The pattern (**Verified** in the scripts above): check the guard, show the spinner, start the request, poll each frame until it finishes, then fill the page or show a warning.

## 25.4 What a local replacement would need

*Probable*, from the calls each screen makes:

| Service | Screens that need it | What a local stand-in must answer |
| --- | --- | --- |
| Credentials and sign-in | All | "Signed in, valid credentials, privileges granted" |
| Transaction server | Websites, business computers, interaction menu, lobby, spectator TV | A catalogue (item keys valid), prices, basket and checkout results, and a session that stays valid |
| UGC | Job lobby, job list, Online pause pages | Job lists and job files (local `.ugc` files exist for some, [R7.4](/file-formats/ugc-json.md)) |
| Crews | Lobby, interaction menu, character select, many | Crew membership (or "no crew") |
| Leaderboards | Lobby, interaction menu | Empty or local boards |
| Social Club | Email, presence, profanity checks | Pass-through answers |
| Engine-filled pages | Friends, crews, party, players, store, invites | Not replaceable by script; they stay empty |

Pages that read only stats (awards, unlocks, weapons) need nothing but stat values.

## 25.5 The ONLINE tab, entry by entry

*Second pass (2026-10-25).* The pause menu's ONLINE tab (screen `MENU_UNIQUE_ID_MISSION_CREATOR`, [pause menu 23.5](/docs/ui/pause-menu.md#235-the-full-tree-menu-versions-tabs-and-panes)) is filled by `pausemenu_multiplayer`. Read in the decompile (commit `6c18d3e8b`; function names are build-specific): the script walks 22 entry numbers, asks one function (`func_1780`) whether each is shown, takes its name from another (`func_1886`), and fills the right-hand pane with a title and a description label per entry. **Verified** names (English text from `global.gxt2`) and conditions.

| # | Entry | In Online | In story mode |
| ---: | --- | --- | --- |
| 0 | Jobs (`PM_JOBS`) | Yes | No |
| 1 | Character Transfer (`PM_MIGRATE`) | No | Yes, unless a tunable or a check turns it off |
| 2 | Join Friends (`PM_FRESES`) | Yes | Yes |
| 3 | Join Crew Members (`PM_CRESES`) | Yes | Yes |
| 4 | Playlists (`PM_PLAYLISTS`) | Yes | No |
| 5 | Players (`PM_PLYRS`) | Yes | No |
| 6 | Crews (`PM_CREWS`) | Yes | Yes, except in one mode (below) |
| 7 | Party (`PM_PARTY`) | Only on platforms with parties (Xbox 360 and one other check) | No |
| 8 | Creator (`PM_MISS_CREATOR`) | Yes | Yes, except in one mode |
| 9 | Swap Character (`PM_SWAP_CHAR`) | Yes | No |
| 10 | Character Transfer (second entry) | Unless a tunable turns it off | No |
| 11 | Purchase Shark Cards (`PM_GOTO_STORE`) | Only when the store is open to the user and not in an activity session | No |
| 12 | Criminal Enterprise Starter Pack (`PM_CESP`) | Unless a tunable turns it off, and only with the store | No |
| 13 | Safety and Alerts (`PM_SAFEALERT`) | Unless a tunable turns it off | No |
| 14 | Options (`PM_MP_OPTIONS`) | Yes | No |
| 15 | Find New Session (`UI_FLOW_OP_NEWSESH_M`) | Yes | No |
| 16 | Leave GTA Online (`PM_QUIT_MP`) | Yes | No |
| 17 | Choose Character (`PM_CHOOSE_CHAR`) | No | Yes |
| 18 | Play GTA Online (`PM_ENTER_MP`) | No | Yes |
| 19 | Credits & Legal (`UI_FLOW_OP_CL`, or Credits or Legal alone) | Picked by a tunable (`Global_262145.f_9321`; −1 hides it) | Only in the one mode |
| 20 | Account Picker (`PM_PANE_PICK`) | Only on the platform that has one | No |
| 21 | Quit Game (`PM_EXIT_GAME`) | PC only | No |

"In Online" means a network game is running; the "one mode" is a state the script's own check (`func_307`) returns 2 for, which hides most entries in both lists (**Known**, not traced further). **Options** opens the Online settings the script fills itself (labels `PM_SETTING_*`): quickplay actions on foot and in a vehicle, enable or disable Passive Mode, spawn location (with choices such as "Hotel" and "Bunker"), matchmaking, player rank title, betting odds format, kill yourself, player overhead display, allow spectators, joint celebration, remain host after the next-job vote, filter quick-join content, join next mode from the spectator box, player text messages, and the GTA Online version. **Jobs** and **Playlists** open lists of UGC content (Rockstar, Rockstar Verified, My Jobs, Bookmarked, Recently Played) by type (Missions, Races, Stunt Races, Deathmatches, Last Team Standing, Capture, Versus, Survivals, Parachuting, King of the Hill, Arena War ...), each with its own "There are no ... available" message when the server returns nothing; that is where most of the script's 328 UGC calls go.

## 25.6 What this means for modders

- **Single player only.** These screens are Online; don't run mods in GTA Online to explore them, and never call the transaction or UGC natives.
- **For research,** the table in 25.2 says which scripts to read for each service; the guards in 25.3 are where a screen gives up when the server is missing.
- **Story-mode mods are mostly unaffected:** the story UI (pause menu, phone, map) works without these services (**Known**); only Social Club features such as Snapmatic uploads need them.

## 25.7 Open questions

| Question | Where it goes |
| --- | --- |
| Which screens still work, partly, when signed out (an offline test is Online-adjacent; read-only analysis only) | Second pass from the guards |
| The full list of transaction calls per business app | R7.7 |
| Leaderboard IDs read by each screen | Second pass |

## 25.8 Test cards

None: these screens are Online only.
