# Sessions and sync

How GTA Online keeps players' games in step at the script level: network scripts and their participants, host and player broadcast data, networked entities with owners and control requests, migration, the reservation limits for mission entities, script events, and session types. Roadmap topic **R15.1** in the [roadmap](/ROADMAP.md). Builds on [how Online works](/docs/online/01-how-online-works.md), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2: joining and the session natives), the [global map](/docs/core/global-map.md) (broadcast data blocks) and [Rockstar Creator internals](/docs/online/creator-internals.md) (R7.11: local versus networked props).

**How it was made.** Native counts from [native usage](/scripting/native-usage.md) (build 1.0.3725.0, decompile commit `6c18d3e8b`). Every `NETWORK_REGISTER_HOST_BROADCAST_VARIABLES` and `_PLAYER_` call with a literal size, and every `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT` call with a literal player count, was pulled with `git grep`. Counts and sizes are **Verified**; how the engine syncs (ownership, migration, update rates) is **Known**.

## 31.1 Short version

- **A network script is a script every participant runs together.** It declares itself with `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT` (423 scripts); 185 of the literal calls allow 32 players. Players are then "participants" of that script (`NETWORK_IS_PARTICIPANT_ACTIVE`, 402 scripts, 6,038 calls), and one of them is the **script host** (`NETWORK_IS_HOST_OF_THIS_SCRIPT`, 370 scripts).
- **Shared state is broadcast data:** each network script registers a block the host writes and everyone reads (`NETWORK_REGISTER_HOST_BROADCAST_VARIABLES`, 430 literal calls in 363 scripts) and a block per player that only that player writes (`_PLAYER_BROADCAST_VARIABLES`, 391). The largest host blocks belong to the job controllers (3,482 words for `fm_mission_controller_2020`, 3,481 for the race controllers); `freemode` registers 18 host blocks (14,097 words) and player blocks totalling 113,935 words (its main one, 28,161 = 32 players × 880 + 1).
- **Entities are networked and owned:** a script creates an entity on the network, converts between handles and network IDs (`NET_TO_VEH` 13,902 calls, `NET_TO_ENT` 9,574, `NET_TO_OBJ` 9,534, `NET_TO_PED` 8,643), and may change it only while it has control (`NETWORK_HAS_CONTROL_OF_ENTITY` 389 scripts, 43,169 calls; `NETWORK_REQUEST_CONTROL_OF_ENTITY` 312 scripts, 15,500 calls).
- **Mission entities are budgeted:** before creating, scripts reserve and check room (`RESERVE_NETWORK_MISSION_VEHICLES`, `_PEDS`, `_OBJECTS`; `CAN_REGISTER_MISSION_VEHICLES` 316 scripts, `_OBJECTS` 298, `_PEDS` 229).
- **Visibility is per player:** `NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS` (303 scripts), `SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES` (280), `SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER` (263), `NETWORK_CONCEAL_ENTITY` (247), and fades (`NETWORK_FADE_IN_ENTITY` 296, `_OUT_` 284).
- **Script events carry one-off messages** between players: sent with the decompiler's `_SEND_TU_SCRIPT_EVENT_NEW` (435 scripts, 6,982 calls) and read from the event queue (`GET_EVENT_DATA`, 263 scripts).

## 31.2 Network scripts and participants

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT` | 423 | 429 | Declare the script networked (max players, instance) |
| `NETWORK_GET_SCRIPT_STATUS` | 418 | 836 | Wait until the network script is set up |
| `NETWORK_IS_PARTICIPANT_ACTIVE`, `PARTICIPANT_ID_TO_INT`, `NETWORK_GET_NUM_PARTICIPANTS` | 402, 285, 220 | 6,038, 8,191, 645 | Who is in |
| `NETWORK_IS_HOST_OF_THIS_SCRIPT` | 370 | 5,616 | Host-only work |
| `NETWORK_GET_PLAYER_INDEX_FROM_PED`, `INT_TO_PLAYERINDEX` | 556, 436 | 49,017, 40,501 | Player lookups |

Literal player counts: 32 (185 calls), 4 (3), 2 (2), 6 (1); the rest pass a variable.

## 31.3 Broadcast data

The script hands the engine the address and size of a block; the engine copies it to the other participants (**Known**: the host's block from the host, each player's block from that player).

| Script | Host block (words) | Player blocks |
| --- | ---: | --- |
| `fm_mission_controller_2020` | 3,482 and 3,323 | 9,185 |
| `fm_race_controler`, `fm_bj_race_controler` | 3,481 | 7,201 |
| `public_mission_controller` | 3,274 | 8,481 |
| `fm_mission_controller` | 3,256 and 3,214 | 9,409 |
| `freemode` | 18 blocks, 14,097 in total (largest 2,757) | 28,161 (the 880-value per-player record, [global map](/docs/core/global-map.md)), 19,681, 14,977, 10,081 × 2, 8,225 ... (113,935 in total) |
| `fm_content_business_battles` | | 6,721 |

Player blocks are sized for all 32 players at once (32 × record + 1), which is why `freemode`'s main block is 28,161 words.

## 31.4 Networked entities

| Step | Natives | Scripts | Calls |
| --- | --- | ---: | ---: |
| Reserve room | `RESERVE_NETWORK_MISSION_VEHICLES`, `_PEDS`, `_OBJECTS` | 223, 215, 209 | 301, 289, 558 |
| Check room | `CAN_REGISTER_MISSION_VEHICLES`, `_OBJECTS`, `_PEDS` | 316, 298, 229 | 892, 938, 467 |
| Create and convert | `VEH_TO_NET`, `OBJ_TO_NET`, `PED_TO_NET` | 264, 297, 226 | 971, 1,140, 1,210 |
| Use | `NET_TO_VEH`, `NET_TO_ENT`, `NET_TO_OBJ`, `NET_TO_PED` | 272, 334, 292, 237 | 13,902, 9,574, 9,534, 8,643 |
| Control | `NETWORK_HAS_CONTROL_OF_ENTITY`, `_OF_NETWORK_ID`, `NETWORK_REQUEST_CONTROL_OF_ENTITY`, `_OF_NETWORK_ID` | 389, 342, 312, 257 | 43,169, 5,067, 15,500, 1,971 |
| Ownership moves | `SET_NETWORK_ID_CAN_MIGRATE` | 291 | 1,781 |
| Who sees it | `NETWORK_SET_ENTITY_ONLY_EXISTS_FOR_PARTICIPANTS`, `SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES`, `SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER`, `NETWORK_CONCEAL_ENTITY` | 303, 280, 263, 247 | 2,046, 1,418, 584, 1,051 |
| Appear and vanish | `NETWORK_FADE_IN_ENTITY`, `NETWORK_FADE_OUT_ENTITY` | 296, 284 | 1,553, 1,272 |
| Cutscenes | `SET_ENTITY_VISIBLE_IN_CUTSCENE`, `SET_NETWORK_ID_VISIBLE_IN_CUTSCENE` | 267, 227 | 7,542, 1,273 |

The rule the counts show: **ask before you change**. A script checks control (43,169 calls) far more often than it asks for it (15,500), and only the owner's changes are sent to the others (**Known**). The race creator shows both kinds side by side: static props are local objects on every machine, dynamic props are host-created networked objects ([R7.11](/docs/online/creator-internals.md)).

## 31.5 Script events and sessions

**Events:** a script sends a small array of values to chosen players (`_SEND_TU_SCRIPT_EVENT_NEW` in the decompiler, `SEND_TU_SCRIPT_EVENT` in NativeDB; 435 scripts, 6,982 calls). Receivers walk the event queue each frame (`GET_NUMBER_OF_EVENTS`, `GET_EVENT_AT_INDEX`, 265 scripts) and copy the data (`GET_EVENT_DATA`, 263 scripts, 3,275 calls). The first value is the event's type, which scripts switch on.

**Session types** checked by scripts: `NETWORK_SESSION_IS_PRIVATE` (182 scripts), `_IS_CLOSED_FRIENDS`, `_IS_CLOSED_CREW` and `_IS_SOLO` (174 each). Joining and hosting are in [R7.2](/docs/online/transitions-and-sessions.md).

## 31.6 What this means for modders

- **Single player only.** None of this is usable without a real session, and running mods in GTA Online gets accounts banned.
- **For story-mode research**, the patterns still teach: Rockstar never assumes it can change an entity, always checks its budget before creating, and keeps shared state in one block with one writer.
- **Reading Online scripts:** look for the broadcast registration near the start of a network script; its block layout is the script's shared state.

## 31.7 Open questions

| Question | Where it goes |
| --- | --- |
| The layout of the big broadcast blocks | Second pass, per controller |
| Event type numbers and what each does | Second pass, `freemode`'s event handler |
| How migration chooses a new owner and host | Engine reverse engineering |

## 31.8 Test cards

None: the session layer runs only in GTA Online.
