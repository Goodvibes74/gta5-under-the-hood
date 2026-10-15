# Rockstar services

Which of Rockstar's online services the game scripts talk to, through which natives and how often: sign-in and credentials, privileges, cloud files and tunables, cloud stat slots, UGC, crews, leaderboards, presence, Social Club text checks, and the store and transaction server. And what each script does when a service is missing. Roadmap topic **R15.2** in the [roadmap](/ROADMAP.md). Builds on [stats and tunables](/docs/online/stats-and-tunables.md) (R7.3), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2), [server-backed Online screens](/docs/ui/server-backed-screens.md) (R8.5: per-screen counts) and [sessions and sync](/docs/online/sessions-and-sync.md) (R15.1).

**How it was made.** Every named native in the [native usage](/scripting/native-usage.md) tables (build 1.0.3725.0, decompile commit `6c18d3e8b`) was assigned to a service by its name family and summed with `awk`: number of natives, total calls, and the most widely used native with its script count. Counts are **Verified**. What each service does on Rockstar's side and how the game behaves without it are **Known** or *probable*.

## 32.1 Short version

| Service | Natives | Calls | Most widespread (scripts) |
| --- | ---: | ---: | --- |
| Tunables (cloud settings) | 21 | 36,170 | `NETWORK_ACCESS_TUNABLE_INT_HASH` (21); most tunables are read in one script, `tuneables_processing` ([R7.3](/docs/online/stats-and-tunables.md)) |
| Store and transactions (`NET_GAMESERVER_*`) | 41 | 17,629 | `NET_GAMESERVER_USE_SERVER_TRANSACTIONS` (550) |
| Crews (`NETWORK_CLAN_*`) | 22 | 9,103 | `NETWORK_CLAN_PLAYER_IS_ACTIVE` (404) |
| Money (`MONEY` namespace) | 311 | 8,403 | `NETWORK_CAN_SPEND_MONEY` (321) |
| Leaderboards | 32 | 6,316 | `LEADERBOARDS_WRITE_ADD_COLUMN` (38) |
| Privileges | 19 | 4,674 | `NETWORK_HAS_ROS_PRIVILEGE_PLAYED_LAST_GEN` (610) |
| UGC (jobs and creations) | 95 | 4,367 | `UGC_IS_CREATING` / `_GETTING` / `_MODIFYING` (122 each) |
| Sign-in and credentials (ROS) | 16 | 2,559 | `NETWORK_HAS_VALID_ROS_CREDENTIALS` (613) |
| Presence | 26 | 1,515 | `PRESENCE_EVENT_UPDATESTAT_INT` (182) |
| Cloud stat slots | 12 | 1,154 | `STAT_SLOT_IS_LOADED` (463) |
| Social Club (`SOCIALCLUB` namespace) | 67 | 907 | `SC_PROFANITY_GET_CHECK_IS_PENDING` (60) |
| Cloud files | 12 | 397 | `NETWORK_IS_CLOUD_AVAILABLE` (259) |

- **Every service is behind a guard** that answers "no" without Rockstar's servers: `NETWORK_HAS_VALID_ROS_CREDENTIALS` (613 scripts), `NETWORK_IS_SIGNED_ONLINE` (590), `NET_GAMESERVER_IS_SESSION_VALID` (362), `NETWORK_IS_CLOUD_AVAILABLE` (259), `NETWORK_CLAN_SERVICE_IS_VALID` (402).
- **The transaction server is the most spread-out dependency:** 550 scripts ask whether server transactions are in use, 480 check catalogue items (`NET_GAMESERVER_CATALOG_ITEM_IS_VALID`, 1,718 calls), 473 read the session state.
- **Story mode uses almost none of this:** the families are concentrated in Online scripts; story scripts touch Social Club only for features such as photo uploads and the profanity check on custom text (**Known**).

## 32.2 The services

**Sign-in, credentials and privileges.** Rockstar Online Services (ROS) issues credentials when the player signs in; scripts check `NETWORK_HAS_VALID_ROS_CREDENTIALS` and refresh state (`NETWORK_IS_REFRESHING_ROS_CREDENTIALS`, 35 scripts). Privileges (multiplayer, user content, communication) gate whole features (`NETWORK_HAVE_ONLINE_PRIVILEGES` 106 scripts, user-content checks in the creators, [R7.11](/docs/online/creator-internals.md)).

**Tunables.** A cloud file of settings read at start-up (`NETWORK_REQUEST_CLOUD_TUNABLES`, 5 scripts) into one global block by `tuneables_processing` (28,502 tunables with defaults, [R7.3](/docs/online/stats-and-tunables.md)). The defaults in the script are what the game uses when the cloud file is missing.

**Cloud stat slots.** Online characters' stats load from cloud slots (`STAT_SLOT_IS_LOADED` 463 scripts, `STAT_LOAD`, `STAT_SAVE`, `STAT_CLOUD_SLOT_*`); [R7.2](/docs/online/transitions-and-sessions.md) shows the retry states when a slot fails.

**UGC.** Jobs and creations: query, get, create, modify, publish (95 natives). The creators and job lobby are the big users ([R7.11](/docs/online/creator-internals.md), [R7.5](/docs/online/job-lobby.md)).

**Crews.** Membership, descriptions, emblems (`NETWORK_CLAN_GET_EMBLEM_TXD_NAME` 329 scripts) and crew-only sessions; `NETWORK_CLAN_SERVICE_IS_VALID` (402 scripts) is checked first.

**Leaderboards.** Written after jobs (`LEADERBOARDS_WRITE_ADD_COLUMN` 3,075 calls in 38 scripts; `LEADERBOARDS2_WRITE_DATA`) and read in lobbies and menus.

**Presence.** What friends see (`NETWORK_SET_RICH_PRESENCE` 123 scripts), presence stat events (`PRESENCE_EVENT_UPDATESTAT_INT` 182, also used by story completion, [R5.3](/docs/core/completion-and-autosave.md)), and invite blocking.

**Social Club.** Mostly the profanity checks on player-entered text (`SC_PROFANITY_CHECK_STRING` 59 scripts, `_STRING_UGC` 49) and presence attributes; messages and emails in Online.

**Store and transactions.** Every purchase in Online goes through a basket and checkout with the transaction server (`NET_GAMESERVER_BASKET_START` 291 scripts, `_CHECKOUT_START` 362), against a server catalogue and prices ([R8.5](/docs/ui/server-backed-screens.md)). The `MONEY` namespace (311 natives) records spends and earnings by category.

## 32.3 When a service is missing

*Probable*, from the guards and the fall-back code:

| Service missing | What the scripts do |
| --- | --- |
| Credentials or sign-in | Online menus show a warning; the transition stops before joining ([R7.2](/docs/online/transitions-and-sessions.md)) |
| Tunables | Script defaults stay in force (every tunable has one) |
| Cloud stat slot | The transition retries the slot (`RETRY_LOADING_SLOT_1` to `_4`) and can't continue |
| Transaction server | Shops and websites refuse purchases; the session-validity check fails in 362 scripts |
| UGC | Job lists stay empty; creators can't save |
| Crews, leaderboards, presence | Features hide or show empty lists |

## 32.4 What this means for modders

- **These are Online services: don't call them from mods.** Calling transaction, stat-save or UGC natives from a modded game risks the account.
- **In research, the guards are the map:** search a script for the guard natives in 32.1 to find where it depends on the servers.
- **An offline Online would have to stand in for** credentials, tunables (defaults exist), stat slots, the transaction server and UGC at minimum (see [R8.5](/docs/ui/server-backed-screens.md), 25.4).

## 32.5 Open questions

| Question | Where it goes |
| --- | --- |
| The unnamed (`unk_`) tunable readers and which service natives they are | Second pass, NativeDB hashes |
| Which story-mode scripts call any service native, and why | Second pass, per script |
| The catalogue item keys and categories | R7.7 |

## 32.6 Test cards

None: these are Online services.
