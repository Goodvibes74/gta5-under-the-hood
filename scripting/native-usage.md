# Native usage: which scripts call which natives

Every game script imports the natives it calls through a native table. This guide turns those tables into names and counts, so any native family (`NET_GAMESERVER_*`, `STAT_*`, `TASK_*`, `CUTSCENE_*`) can be traced to the scripts that use it, and any script's whole native list can be printed. Roadmap topic **R0.3** in the [roadmap](/ROADMAP.md). Builds on the [script VM](/scripting/script-vm.md) (what a native table is) and feeds every later topic that asks "who uses this native?".

**How it was made.** The read-only tool [`tools/native-usage.ps1`](/tools/native-usage.ps1). It reads the 1,145 `native_tables/<script>.txt` files and every `NS::NAME(` and `unk_0x<hash>(` call in `decompiled_scripts/` from the decompile clone at commit `6c18d3e8b` (build 3725) with `git grep`, joins the hashes with NativeDB's `natives.json` (a copy saved from alloc8or's [gta5-nativedb-data](https://github.com/alloc8or/gta5-nativedb-data), 6,701 natives), and resolves the decompiler's own names to hashes script by script. All counts below are **Verified** from that run; what a native does is NativeDB's description (**Known**). Generated reference: the [native usage index](/scripting/native-usage-index.md) and one page per namespace in [`scripting/native-usage/`](/scripting/native-usage/), each native linked to its NativeDB entry.

## 9.1 Short version

- **The native tables already hold NativeDB hashes.** `abigail1`'s first entry is `812595A0644CE1DE`, which is `DLC::IS_DLC_PRESENT` in NativeDB. No per-build crossmap is needed to name a script's natives; the "crossmap" of R0.3 is a straight lookup (**Verified** on all 6,575 imported hashes; 6,573 are in NativeDB).
- **1,013 scripts** have a non-empty native table (the other 132 of the 1,145 table files are empty: scripts with no code in this release). Together they import **6,575 distinct natives** and make **12,297,752 native calls**. Every one of those calls resolves to an imported hash; no imported native is left uncalled.
- **Scripts use almost the whole API:** 6,573 of NativeDB's 6,701 natives (98%). The 128 they never import: 54 in `MONEY` (Online earn and spend), 25 in `NETWORK`, 17 in `SOCIALCLUB`, 10 in `SCRIPT` (the nine `BG_*` background-script natives and `TRIGGER_SCRIPT_EVENT`) and 22 others; 29 of the 128 are natives NativeDB lists from a newer build (3889) (9.6).
- **The busiest natives are bookkeeping, not gameplay:** `PLAYER_ID` alone is called 1,580,237 times, `PLAYER_PED_ID` 859,465, and `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG` 790,263 (the clothing menus). `WAIT` is imported by 995 scripts, `TERMINATE_THIS_THREAD` by 989.
- **Online dominates by size:** the four largest importers are `fm_mission_controller_2020` (3,166 natives), `public_mission_controller` (3,090), `fm_mission_controller` (3,029) and `freemode` (2,798). A story mission such as `abigail1` imports 351.
- **The decompiler's names are not NativeDB's names.** It uses older namespaces (`CAM`, `PATHFIND`, `SYSTEM`, `APP`, `ITEMSET`, `MOBILE` for NativeDB's `CAMERA`, `PATH`, `BUILTIN`, `APPS`, `ITEMSETS`, `GTA`), writes 105 newer natives as `unk_0x<hash>` (37,382 calls), and gives five natives a name that NativeDB uses for a different hash (9.5). A name-based `git grep` over the decompile therefore misses or mixes up some natives; the tool and the reference pages do not.
- Since build 323 (launch), NativeDB records 1,414 natives added in later builds that the scripts use; build 3717 (this update's native set) added 22.

## 9.2 Where native names come from

| Source | What it holds | Count (build 3725) |
| --- | --- | --- |
| `native_tables/<script>.txt` (decompile repo) | One NativeDB hash per line, in the order the script's code indexes them | 1,145 files, 641,762 lines, 6,575 distinct hashes |
| `decompiled_scripts/<script>.c` | Calls written as `NS::NAME(...)`, or `unk_0x<hash>(...)` when the decompiler has no name | 12,297,752 calls |
| NativeDB `natives.json` | Hash, namespace, name, parameters, first build | 6,701 natives in 46 namespaces |

The number of distinct natives a script calls equals the length of its native table for every script once the decompiler's names are resolved (checked: `abigail1` 351 and 351, `main` 913 and 913, `freemode` 2,798 and 2,798). So the table is exactly "natives this script calls", with no unused imports. The table order is not the order of first use in the decompiled text (checked on `abigail1`).

## 9.3 The namespaces in numbers

Sorted by calls. "In NativeDB" is the namespace size; "Used" is how many of them at least one script imports. Full table with links: [native usage index](/scripting/native-usage-index.md).

| Namespace | In NativeDB | Used | Calls | Busiest native (scripts importing it) |
| --- | ---: | ---: | ---: | --- |
| PLAYER | 252 | 250 | 2,717,364 | `PLAYER_PED_ID` (952) |
| MISC | 334 | 334 | 1,385,448 | `SET_BIT` (932) |
| ENTITY | 192 | 189 | 1,343,097 | `DOES_ENTITY_EXIST` (929) |
| EXTRAMETADATA | 49 | 49 | 1,197,818 | `IS_CONTENT_ITEM_LOCKED` (630) |
| PED | 617 | 615 | 1,117,450 | `IS_PED_INJURED` (903) |
| BUILTIN | 26 | 26 | 728,414 | `WAIT` (995) |
| VEHICLE | 779 | 779 | 690,064 | `IS_VEHICLE_DRIVEABLE` (698) |
| PAD | 50 | 50 | 684,241 | `DISABLE_CONTROL_ACTION` (706) |
| NETWORK | 882 | 857 | 563,274 | `NETWORK_IS_GAME_IN_PROGRESS` (905) |
| HUD | 522 | 519 | 357,932 | `CLEAR_HELP` (724) |
| GRAPHICS | 409 | 401 | 185,939 | `CASCADE_SHADOWS_INIT_SESSION` (566) |
| TASK | 313 | 313 | 185,257 | `GET_SCRIPT_TASK_STATUS` (732) |
| STREAMING | 122 | 122 | 183,683 | `HAS_MODEL_LOADED` (739) |
| CAMERA | 248 | 248 | 182,785 | `IS_SCREEN_FADED_OUT` (731) |
| OBJECT | 166 | 166 | 122,128 | `GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS` (564) |
| AUDIO | 281 | 281 | 119,553 | `STOP_SCRIPTED_CONVERSATION` (822) |
| DATAFILE | 57 | 57 | 102,116 | `DATAFILE_IS_SAVE_PENDING` (180) |
| STATS | 336 | 333 | 78,578 | `STAT_GET_INT` (792) |
| DECORATOR | 12 | 12 | 67,286 | `DECOR_EXIST_ON` (571) |
| SCRIPT | 37 | 27 | 52,547 | `TERMINATE_THIS_THREAD` (989) |
| INTERIOR | 45 | 45 | 48,896 | `GET_INTERIOR_FROM_ENTITY` (569) |
| WEAPON | 124 | 123 | 45,701 | `GET_CURRENT_PED_WEAPON` (730) |
| CUTSCENE | 56 | 56 | 19,216 | `IS_CUTSCENE_PLAYING` (628) |
| NETSHOPPING | 41 | 41 | 17,628 | `NET_GAMESERVER_USE_SERVER_TRANSACTIONS` (550) |
| MONEY | 359 | 305 | 8,035 | `NETWORK_CAN_SPEND_MONEY` (321) |

The other 21 namespaces (PATH, FIRE, SHAPETEST, CLOCK, DLC, LOCALIZATION, RECORDING, GTA (the phone), PHYSICS, WATER, SOCIALCLUB, BRAIN, LOBBY, EVENT, ZONE, APPS, SECURITY, ITEMSETS, REPLAY, SAVEMIGRATION) make fewer than 12,000 calls each.

Two surprises:

- **`EXTRAMETADATA` is the fourth-busiest namespace** with only 49 natives. It's the shop and clothing metadata API (`GET_SHOP_PED_COMPONENT`, `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG`, `IS_CONTENT_ITEM_LOCKED`), called from huge generated lookup functions in 569 to 630 scripts. Anything that dresses a ped from the shop catalogue goes through it.
- **`MONEY` is the least-used big namespace:** 359 natives, 8,035 calls. Each Online purchase or payout has its own native (`NETWORK_SPEND_*`, `NETWORK_EARN_*`), most called from one or two places, and 54 of them are never called at all (9.6).

## 9.4 The families named in the roadmap

| Family | Natives | Calls | Scripts importing any |
| --- | ---: | ---: | ---: |
| `NETSHOPPING::NET_GAMESERVER_*` (server-side transactions) | 41 | 17,629 | 552 |
| `STATS::STAT_*` (stat get and set) | 83 | 28,308 | 825 |
| `STATS::PLAYSTATS_*` (telemetry) | 158 | 6,508 | 615 |
| `TASK::TASK_*` (ped tasks) | 150 | 70,018 | 788 |
| `CUTSCENE::*` | 56 | 19,223 | 714 |
| `NETWORK::NETWORK_*` | 596 | 405,828 | 940 |
| `DATAFILE::*` (UGC and JSON data files) | 57 | 102,116 | 323 |
| `MONEY::*` | 305 used | 8,035 | 372 |

Every script that touches the Online economy imports `NET_GAMESERVER_USE_SERVER_TRANSACTIONS` (550 scripts), the switch between the server-checked and the local transaction paths ([how Online works](/docs/online/01-how-online-works.md)).

`CUTSCENE::START_CUTSCENE` is imported by 400 scripts (724 calls; busiest `finale_heist2a` with 12), which agrees with the 420 cutscene-playing scripts counted for [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (53 scripts start one with `START_CUTSCENE_AT_COORDS` instead).

## 9.5 Names: NativeDB vs the decompiler

The tool matches a decompiled call to a hash in four steps, inside each script:

1. `unk_0x<hash>(` matches that hash directly. 105 natives appear only this way (37,382 calls), all named in NativeDB since the decompiler's list was made: for example `_NETWORK_CAN_TEXT_FROM_GAMER_BE_VIEWED` (306 scripts), `_NETWORK_HAS_PLAYER_PASSED_CHECK_TYPE` (56), `_IS_XBOXPC_VERSION` (39).
2. A learned alias (step 4) matches next.
3. Otherwise the name without namespace and leading underscore is compared with NativeDB's name for each hash the script imports. Ignoring the namespace is needed because the decompiler uses older namespace names.
4. If a script is left with exactly one unmatched name and one uncalled hash, they are paired and the pair is learned as an alias; the pass repeats until nothing new is learned.

Five aliases were learned (the tool writes them to `aliases.tsv`):

| Decompiler name | Hash | NativeDB name |
| --- | --- | --- |
| `NETWORK_CAN_COMMUNICATE_WITH_GAMER` | `0x8F5D1AD832AEB06C` | not in NativeDB (185 scripts) |
| `NETWORK_CAN_TEXT_CHAT_WITH_GAMER` | `0xA150A4F065806B1F` | `NETWORK_CAN_COMMUNICATE_WITH_GAMER` |
| `NETWORK_DOES_COMMUNICATION_GROUP_EXIST` | `0xDBDF80673BBA3D65` | `_NETWORK_DOES_COMMUNICATION_GROUP_HAVE_PERMISSION` |
| `NETWORK_IS_AMERICAS_VERSION` | `0x0292BD7F3766CEBC` | `_0x0292BD7F3766CEBC` |
| `SET_NITROUS_IS_ACTIVE` | `0x465EEA70AF251045` | `_SET_NITROUS_IS_VISIBLE` |

The first two rows are the trap: the decompile's `NETWORK_CAN_COMMUNICATE_WITH_GAMER` is **not** NativeDB's native of that name. Searching the decompile for that name finds calls to a different hash. Use the reference pages (hash-based) when a count matters.

Two imported hashes are not in NativeDB at all: `0x8F5D1AD832AEB06C` (185 scripts, the gamer-communication check above) and `0x0F7082C60FB479EF` (1 script, `public_mission_creator`).

## 9.6 Natives no script uses

128 NativeDB natives appear in no native table:

| Group | Count | What they are |
| --- | ---: | --- |
| `MONEY` | 54 | Online earn and spend natives for content that was cut or replaced (`NETWORK_BUY_SMOKES`, `NETWORK_SPENT_PLAYER_HEALTHCARE`, `NETWORK_EARN_FROM_WAREHOUSE` ...) and old wallet queries (`NETWORK_GET_PVC_BALANCE`) (3 of them build 3889) |
| `NETWORK` | 25 | Mostly reporting and cheat-detection hooks (`REMOTE_CHEATER_PLAYER_DETECTED`) and unused session helpers (4 of them build 3889) |
| `SOCIALCLUB` | 17 | Social Club features the scripts don't call |
| `SCRIPT` | 10 | The nine `BG_*` background-script natives (for the cloud-delivered `bg_` scripts, **Known**) and `TRIGGER_SCRIPT_EVENT` |
| Others | 22 | All marked build 3889 in NativeDB, newer than 3725 (`_DRAW_CAPSULE_LIGHT`, `_IS_ENTITY_FIXED`, `SET_PLAYER_STEALTH_SPEED`, `_PLAYSTATS_HEIST5_*` ...), in `GRAPHICS` 8, `ENTITY` 3, `HUD` 3, `STATS` 3, `PED` 2, `PLAYER` 2, `WEAPON` 1. They are probably not in this build at all; a mod that calls one on 3725 needs a check |

**`TRIGGER_SCRIPT_EVENT` is never used by the game.** Rockstar's scripts send script events only through `_SEND_TU_SCRIPT_EVENT_NEW` (since build 3095; 435 scripts, 6,982 calls). Mods that still send events with `TRIGGER_SCRIPT_EVENT` use a path the game itself abandoned (relevant to [freemode's 381 script events](/docs/online/07-freemode.md)).

## 9.7 Using it

```powershell
# Every script that imports a native, busiest first (regex on NS::NAME)
powershell -NoProfile -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Native "CUTSCENE::START_CUTSCENE$"

# One script's natives with call counts
powershell -NoProfile -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Script armenian1

# Regenerate the reference pages (about two minutes), then copy the .md files into scripting\
powershell -NoProfile -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Out <scratch folder>
```

`-NativesJson` is NativeDB's `natives.json`, saved by hand from [gta5-nativedb-data](https://github.com/alloc8or/gta5-nativedb-data). `-Repo` points at the decompile clone (default `..\GTA-V-Decompiled-Scripts`) and `-Commit` at the build ([decompiled scripts](/docs/00-getting-started/decompiled-scripts.md)). The `-Out` run also writes `native-usage.tsv` (12 MB, one row per native with its full script list) and `script-natives.tsv` (46 MB, one row per script and native). They stay in the scratch folder; the Markdown pages are what this repo keeps. How the tool works: [tools](/tools/README.md#native-usageps1-which-scripts-call-which-natives).

## 9.8 What this means for modders

- **Before using a native, see who else does.** If no game script imports it, it's either new (check its build against 3725), cut content, or engine-only. If 500 scripts do, the decompile has 500 worked examples: `-Native` lists them.
- **Search by hash when it matters.** The decompile's names lag NativeDB and five of them point at the wrong native. The reference pages here and SHVDN (`Function.Call(Hash.X)`) use NativeDB names.
- **Don't send script events with `TRIGGER_SCRIPT_EVENT`** in an Online-style mod; the game uses `_SEND_TU_SCRIPT_EVENT_NEW` (and a single-player mod should send no network events at all; [surviving updates](/docs/core/surviving-updates.md)).
- **Shop clothing is metadata-driven.** `EXTRAMETADATA` (49 natives, 1.2 million calls) is how the game reads the clothing catalogue; a mod's own clothes shop should read it the same way instead of hard-coding component lists.
- **The update check (R11.2)** can now diff two builds' native tables: new hashes are new natives, and a script whose table changed has changed code.

## 9.9 Open questions

| Question | Where it goes |
| --- | --- |
| What `0x8F5D1AD832AEB06C` and `0x0F7082C60FB479EF` do (not in NativeDB) | [Inbox](/ROADMAP.md#inbox); read their call sites in `freemode` and `public_mission_creator` |
| Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` style check from a mod, or ScriptHookV's native table) | In-game test with a small C++ check |
| A story-only vs Online-only split of every native (which natives story mode never needs) | R0.8 namespace coverage map, using the script groups from R0.1 and the Online catalog |
| What the table order is (not first use; maybe first use in compiled code order) | Second pass, compare with a YSC dump |

## 9.10 Test cards

None needed: everything here is read from files. The open question on build-3889 natives needs one (above).
