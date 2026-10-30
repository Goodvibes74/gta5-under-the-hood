# Saves: what the story save holds and how scripts write it

How the game's save works from the script side: the story save is one global structure that a single script registers field by field, with names, before the game can load or write it; the smaller save blocks next to it; the Online equivalent; and where a mod should keep its own data. Roadmap topic **R1.7** in the [roadmap](/ROADMAP.md). Builds on the [global map](/docs/core/global-map.md) (block 0 holds the story save) and [runtime scripts](/docs/core/runtime-scripts.md) (`startup`, `standard_global_reg`). The scripts that trigger saves (`autosave_controller`, `savegame_bed`, `save_anywhere`, completion) are topic R5.3.

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `standard_global_reg` (108,777 lines), `startup`, `sp_dlc_registration`, `sp_pilotschool_reg`, and the save calls in `autosave_controller`, `savegame_bed` and `save_anywhere`. The save natives were found with `git grep` and counted from the [native usage](/scripting/native-usage.md) tables. Names, sizes and counts are **Verified**; what the engine does with the registered layout (the file format, where it writes) is **Known**. **Second pass (2026-10-30):** the whole registration tree was walked by a script that follows every call with its arguments (15.4), and the upgrade function in `startup` was read (15.5.1).

## 15.1 Short version

- **The story save is one structure, `Global_114904`, 38,592 values long.** `standard_global_reg` registers it between `START_SAVE_DATA(&Global_114904, 38592, true)` and `STOP_SAVE_DATA()`.
- **Every saved field is registered by name:** 1,062 registrations (602 ints, 198 bools, 150 enums, 85 floats, 27 text labels) inside 108 structures and 347 arrays, with 828 distinct literal names plus names built at run time for array elements (`fSaveVersion`, `BitsetCharacterStoryUnlock`, `GOLF_iBestRound`, `OFFROAD_Race5Best` ...).
- **Only 4 scripts register save data:** `standard_global_reg` (the story save), `startup` (a version check and the Online block), `sp_dlc_registration` and `sp_pilotschool_reg` (one dummy value each).
- **The save has a version:** the first field is `fSaveVersion`. `startup` reads it on its own first, then sets it to **1.7** and runs an upgrade function when a loaded save has another version: six fixes (and one empty step) for saves from versions 1.0 to 1.5 ([15.5.1](#1551-the-save-upgrade)).
- **The layout is checked:** after registering, scripts compare `GET_SIZE_OF_SAVE_DATA` with the size they expect (5,575 for the Online block, 1 for the DLC block).
- **67 top-level sections and 58 loose fields fill all 38,592 values** ([15.4](#154-whats-in-the-story-save)). **The big sections:** the flow (`FLOW_STRUCT`, 931 values), emails (`EMAIL_DATA`, 3,867), vehicle purchases (`BUY_VEC_SAVED`, 1,252), director mode (`DIRECTOR_SAVED_STRUCT`, 1,617), communications (`COMM_CONTROL_DATA_STRUCT`, 925), the shooting range (814), plus one structure per side activity (golf, darts, taxi, towing, triathlon, races, shop robberies, random events ...).
- **Saving itself is one native away:** `DO_AUTO_SAVE` (called only by `autosave_controller`) and `SET_SAVE_MENU_ACTIVE` (the save menu, from `save_anywhere`). The engine serialises whatever is in the registered globals at that moment.
- **Online keeps a separate block** (`g_savedMPGlobals`, `Global_2359296`, 5,575 values) and, above all, server-side stats ([stats and tunables](/docs/online/stats-and-tunables.md)).

## 15.2 Where it lives

| Block | Global (build 3725) | Values | Registered by | Notes |
| --- | --- | ---: | --- | --- |
| Story save | `Global_114904` | 38,592 | `standard_global_reg` | Everything about story progress |
| Save version | `Global_114904` (first value) | 1 | `startup` | Read alone first; current version 1.7 |
| Online save | `Global_2359296` (`g_savedMPGlobals`) | 5,575 | `startup` | Registered with the third argument `false`, the only one that is |
| Story DLC | `Global_2883692` | 1 | `sp_dlc_registration` | `aFakeSavedInt` |
| Pilot school (story) | `Global_3145728` | 1 | `sp_pilotschool_reg` | `PILOT_SCHOOL_DUMMY_DATA` |

The registration scripts set bits 0, 1 and 2 of one global (`Global_4525702`) when they're done, and `startup` waits for them before going on (**Verified**). The third argument of `START_SAVE_DATA` is `true` for every story block and `false` for the Online one; *probably* "story save" vs "Online save".

## 15.3 How a field gets into the save

`standard_global_reg` calls about 50 functions in a row, one per area of the game. Each opens a named structure or array, registers its fields and closes it (**Verified**):

1. `START_SAVE_STRUCT_WITH_SIZE(&field, size, "NAME")` or `START_SAVE_ARRAY_WITH_SIZE(&field, size, "NAME")`.
2. `REGISTER_INT_TO_SAVE(&field, "name")` and its siblings for bool, enum, float and text labels of 15, 23 and 63 characters. Array elements get names built at run time (a base name plus the index).
3. `STOP_SAVE_STRUCT()` / `STOP_SAVE_ARRAY()`.

The names are stored with the layout. *Known*: the save file keeps values by these names, which is why Rockstar could grow the save across updates without breaking old saves, and why the version field and upgrade function exist for the cases names can't solve.

## 15.4 What's in the story save

**How the tree was walked (second pass).** A small script read `standard_global_reg` and followed every call from the entry function between `START_SAVE_DATA` and `STOP_SAVE_DATA`, passing each function's arguments down (the address of the field and the section name), so sections registered through shared helper functions get their real offset and name. Each loop body was walked once, so a section repeated per array element is counted once, at its first element. It reached **580 section openings** (structures and arrays) up to 5 levels deep, plus **58 fields registered loose at the top level** next to `fSaveVersion`. The top level has **67 named sections**, and together with the loose fields they cover every value from 0 to 38,591 with no gap (**Verified**).

All 67 top-level sections, by position in `Global_114904` (offset, size, and how many named sections sit inside each; **Verified**):

| Section | Offset | Values | Inside it |
| --- | ---: | ---: | --- |
| `fSaveVersion` (loose float) | 0 | 1 | |
| `HEIST_DATA_STRUCT` | 1 | 242 | Choice and crew help flags, `HEIST_SELECTED_CREW_ARRAY` (one 6-value crew array per heist approach: `CREW_ARRAY_JEWEL_STEALTH` ... `CREW_ARRAY_FINALE_HELI`), crew active data, `HEIST_END_SCREEN_DATA_STRUCT` (one 23-value struct per heist with take, percentages, crew status) |
| `STRIP_CLUB_SAVED_ARRAY` | 243 | 425 | Per character: `STRIP_CLUBS`, `BOOTY_CALLS` |
| `SHOP_SAVED_DATA_STRUCT` | 668 | 1,327 | `SHOP_PROPERTIES`, `CARMOD_DATA` (one per character), `VIEWED_MODS` (1,225), `CONTENT_VEHICLES` |
| `PILOT_SCHOOL_SAVED_ARRAY` | 1,995 | 364 | `structPilotSchool_p0` to `_p2`, 121 each |
| `RAMPAGE_SAVED_ARRAY` | 2,359 | 11 | `structRampagePlayerData` |
| `COMPONENTS_ARRAY` | 2,370 | 493 | `SP0`, `SP1`, `SP2` (164 each): the characters' ped components |
| `TATTOOS_ARRAY` | 2,863 | 46 | `SP0` to `SP2`, 15 each |
| `PP_INFO_STRUCT` (player ped info) | 2,909 | 4,324 | 48 arrays: `VARIATIONS`, `WEAPONS` (1,432), `SNAP_WEAP`, `STORED_VEH_DATA` (1,181), `WARDROBE` (499), `NPC_VEH_DATA`, `LAST_KNOWN_*` position, heading, room, wanted level, `STAT_OFFSET_1` to `_7`, `SPECIAL_ABILITY`, `HEALTH_PERCENTAGE`, `ARMOUR`, `FBI4MASKS*`, `CLOUD_VEH` ... |
| Loose: `FRANKLIN_ORIGINAL_OUTFIT_ID`, `OVERRIDE_PED`, `PLAYER_PED_DATA_PATCH_BITSET` | 7,233 | 3 | |
| `RESPAWN_LOCATION_DATA` | 7,236 | 32 | `SAVEHOUSE`, `HOSPITAL`, `POLICE_STATION` |
| `BUILDING_SAVED_DATA_STRUCT` | 7,268 | 427 | `DOOR_STATES` (227), `BUILDING_STATES` (199) |
| `COMM_CONTROL_DATA_STRUCT` | 7,695 | 925 | Queued, missed and chat calls, queued and sent texts, queued emails, character priority |
| `CODE_CONTROL_DATA_STRUCT` | 8,620 | 472 | `CODE_CONTROL_RUNFLAG_ARRAY`, `CODE_CONTROL_EXECUTE_TIMER_ARRAY` (236 each) |
| `FLOW_STRUCT` | 9,092 | 931 | `MF_STRANDS_ARRAY` (`StrandDetails`, 3 values each), `MF_CONTROLS_STRUCT` (sync, flag, int and bitset IDs), `MF_MISSION_ARRAY` (`MF_MISSION_STRUCT_`, 6 values each) |
| `FLOW_CUSTOM_STRUCT` | 10,023 | 33 | Six 4-value override arrays (`MF_STRANDS_TO_OVERRIDE_ARRAY` ...) |
| `STUNT_JUMPS_SAVED_STRUCT` | 10,056 | 1 | |
| `PROSTITUTE_SAVED_DATA` | 10,057 | 89 | |
| `PROSTITUTE_SERVICES_ARRAY` | 10,146 | 4 | |
| Loose: hint flags, `BRIDGES_FLOWN_UNDER_FLAGS` (3), `WILDLIFE_PHOTOGRAPHY_FLAGS`, chase help, Epsilon car and robes, `EPSDESERT_DISTANCE_RUN`, `FOR_SALE_SIGN_DESTROYED_FLAGS`, hunting scores | 10,150 | 17 | |
| `CHALLENGE_FREE_MODE` | 10,167 | 4 | |
| Loose: `HUNTING_CHALLENGE_DISPLAYED`, `HUNTING_WEEK_TIMER`, `VEHICLE_REPAIR_*` (3), taxi help prompts | 10,171 | 7 | |
| `LETTER_SCRAPS_SAVED_STRUCT`, `SPACESHIP_PARTS_SAVED_STRUCT` | 10,178 | 3 + 3 | |
| Loose: `FIB4_GETAWAY_STATE` | 10,184 | 1 | |
| `WEBSITE_SUBSCRIPTION_ARRAY` | 10,185 | 4 | |
| Loose: `MURDER_MYSTERY_PROGRESS`, `NOIR_EFFECTS_STATUS` | 10,189 | 2 | |
| `PHOTOGRAPHY_MONKEY_FLAGS`, `PEYOTE_PICKUP_OF_TYPE_FOUND` | 10,191 | 3 + 5 | |
| Loose: `PEYOTE_ANIMAL_SEEN`, `PEYOTE_PROGRESSION_COMPLETE` | 10,199 | 2 | |
| `COMP_PERCENT_SAVED_ARRAY` | 10,201 | 3,857 | `struct_g_CompletionPercentage`: 12 values per completion entry |
| `CELLPHONE_SETTINGS_SAVED_ARRAY` | 14,058 | 90 | `struct_g_CellphoneSettings`, 20 values per character |
| `TEXT_MESSAGES_SAVED_ARRAY` | 14,148 | 3,641 | `struct_g_TextMessage`: `TextMsgIndex_` entries of 104 values |
| `GALLERY_IMAGES_SAVED_ARRAY` | 17,789 | 321 | `struct_g_GalleryImage`: `GalleryImgIndex_` entries of 32 values |
| `FRIENDS_SAVED_ARRAY` | 18,110 | 411 | `g_FriendData` (`Friend Sheet`, 29 values each), connections, groups, fail timers and messages, `g_FranklinLamarEndChat` |
| `FAMILY_SAVED_DATA` | 18,521 | 19 | `ePreviousFamilyEvent` |
| `PLAYER_SCENE_SAVED_DATA` | 18,540 | 41 | Last scene per character, scene queue, priority switch flags |
| `SAVED_RANDOM_CHARACTERS` | 18,581 | 379 | One 6-value entry per stranger or freak mission |
| Loose: `RC_EVENTS`, `iRCMissionsCompleted`, Epsilon payments and cash, `g_bFanatic*` (3), `g_bTriggeredHao1` ... | 18,960 | 11 | |
| `VISIBLE_IN_FOW` (fog of war) | 18,971 | 3 | |
| `BASEJUMP_SAVED_STRUCT`, `DARTS_SAVED_STRUCT` | 18,974 | 3 + 9 | |
| `GOLF_SAVED_STRUCT` | 18,986 | 37 | `GOLF_COURSE_`, rounds per character |
| `OFFROAD_SAVED_STRUCT` | 19,023 | 27 | Ranks, times, best places |
| `SPTT_DATA_SAVED_STRUCT` (time trials) | 19,050 | 54 | Ranks, times, course data |
| `TAXI_SAVED_STRUCT` | 19,104 | 50 | Missions, stats, runs |
| `SHOOTING_RANGE_SAVED_ARRAY` | 19,154 | 814 | One 271-value struct per character (`RANGE_SAVED_TREVOR` ...) with its rounds |
| `SHRINK_SAVED_STRUCT`, `ASSASSIN_SAVED_STRUCT`, `TOWING_SAVED_STRUCT` | 19,968 | 2 + 10 + 10 | |
| `TRAFFICKING_SAVED_STRUCT` | 19,990 | 28 | Times collected, drop locations |
| `TRIATHLON_SAVED_STRUCT` | 20,018 | 10 | Ranks, times |
| `TENNIS_SAVE_DATA` | 20,028 | 14 | |
| `SHOPROBBERIES_SAVED_STRUCT` | 20,042 | 82 | Four 20-value arrays: times robbed, last robbed, last robbed by the player, by whom |
| `SPECIALPED_SAVED_STRUCT` | 20,124 | 1 | |
| `SOCIAL_SAVED_DATA_STRUCT` (iFruit app) | 20,125 | 292 | `CAR_APP_DATA` and `CAR_APP_ORDER` (one per character), `DOG_APP_DATA` |
| `FLOW_HELP_STRUCT` | 20,417 | 154 | Help queue, priority, displayed bitsets |
| `FINANCE_SAVED_ARRAY` | 20,571 | 473 | Per-character stock arrays (`M_S_CI_AR`, `F_S_I_AR`, `T_S_OOT_AR` ...), `SPSPD_AR`, `SPSMAD_AR`, `SPSMID_AR`, account logs `PLR_ACNT_LGS` (208), filters |
| `EMAIL_DATA` | 21,044 | 3,867 | `EMI_AR`, `EMDT_AR` (1,422), `EMS_AR` (1,709), `EMB_AR` |
| `PROPERTIES_SAVED_DATA` | 24,911 | 72 | `OwnershipData` (16 properties, 4 values each), then bits and the income from the car lot, Sonar Collections, trafficking and towing |
| `SEA_RACE_`, `STREET_RACE_`, `BAIL_BOND_SAVED_STRUCT` | 24,983 | 3 + 7 + 9 | |
| `RANDOM_EVENTS_SAVED` | 25,002 | 78 | `RE_VAR_COMPLETE`, `RE_BLOCK_TIME` (35 each) |
| `COUNTRY_RACE_SAVED_STRUCT` | 25,080 | 11 | |
| `RP_PLAYER`, `RP_Vehicle` (replay) | 25,091 | 6 + 90 | |
| Loose: `Mission`, `eRCMissionToBlock` | 25,187 | 2 | |
| `BUY_VEC_SAVED` | 25,189 | 1,252 | `OWVEC_IND` (313 vehicle flags), `OWVEC_COL_M`, `_F`, `_T` (colours per character) |
| `DIRECTOR_SAVED_STRUCT` | 26,441 | 1,617 | Unlock bitsets, bookmarks, user locations, prop editor scene (positions, rotations, models, names) |
| `CHARSHEET_SAVED_ARRAY` | 28,058 | 4,699 | `struct_g_CharacterSheet`: one 29-value sheet per contact, with phone-book, missed-call and caller status arrays |
| `VEHICLE_GEN_SAVED_DATA_STRUCT` | 32,757 | 5,835 | Vehicle generator properties, `DYANMIC_DATA` (sic), `WEB_VEHICLES` (2,818), `HEIST_VEHS`, `IMPOUND_VEHS`, `NEXT_IMPOUND`, `SWITCH_IMP`, player vehicles |

One oddity: `SOCIAL_SAVED_DATA_STRUCT` is opened with a size of 292 but closed after its first 260 values; the last 32 (`bSingleplayeDataWiped`, `iGameUID`, the plate text, the `PED_UNLOCK`, `VEH_SENT`, `FIRST_ORDER` and `ORDER_COUNT` arrays ...) are registered after the close, so they are saved as top-level names even though they sit inside the structure in memory (**Verified**).

## 15.5 When it is written

- **Autosave:** `autosave_controller` calls `DO_AUTO_SAVE` (its only caller) after the flow marks a save point, then clears replay stats (`CLEAR_REPLAY_STATS`). Scripts ask for an autosave through the flow globals rather than calling the native themselves. `IS_AUTO_SAVE_IN_PROGRESS` is checked in 18 scripts; `GET_IS_AUTO_SAVE_OFF` (the player's setting) in 3.
- **Manual save:** `save_anywhere` opens the save menu with `SET_SAVE_MENU_ACTIVE(true)`; `savegame_bed` (sleeping in a safehouse) closes it again.
- **Mission replays:** `QUEUE_MISSION_REPEAT_SAVE` and `QUEUE_MISSION_REPEAT_LOAD` save and restore around a replayed mission (`mission_repeat_controller`).
- **Where the player wakes up:** `SET_SAVE_HOUSE` (12 scripts, 217 calls).

Which events trigger an autosave, and completion percentage, are R5.3.

## 15.5.1 The save upgrade

When a loaded save's `fSaveVersion` isn't 1.7, `startup` keeps the old value and calls one upgrade function with it (only for a game that has already been started, the `Global_1` flag from [boot](/docs/00-getting-started/boot.md)). The function is a list of fixes, each for the versions it applies to, run in this order (read in `startup`, build 3725; **Verified**):

| Applies to | What it fixes |
| --- | --- |
| Every older version | Each of the 16 property slots in `PROPERTIES_SAVED_DATA` whose owner isn't one of the three characters is set to 145 (*probably* "no owner") |
| 1.0 only | If the heist board int IDs 7 to 11 in the flow controls are set, it marks the matching heist setup missions done: `jewelry_setup1`, `docks_setup`, `rural_bank_setup`, `agency_heist2`, `finale_heist2_intro`. Then it moves completion-list entries 196, 197 and 198 down one place and entry 195 to the end (the list was re-ordered after 1.0) |
| 1.1 and older | Nothing: the step is empty in this build |
| Older than 1.5 | If any of the five Dr Friedlander sessions (`drf1` to `drf5`) is done, sets bit 6 of a `FLOW_CUSTOM_STRUCT` flag field |
| 1.5 and older | For each character, the owned-vehicle flags 171 to 198 in `BUY_VEC_SAVED` move up by 28 places (to 199 to 226): vehicles were inserted in the middle of the website list |
| 1.5 only | Subtracts the hangar vehicle count (stat `content_hanger_veh`) from the shop's `CONTENT_VEHICLES` count, if the hangar, marina and helipad stats all exist |
| Older than 1.7 | Clears `BitsetTravelLocationRevealed` in `DIRECTOR_SAVED_STRUCT` (director mode travel locations) |

So the save versions this build knows are 1.0, 1.1, 1.5 and 1.7 (and anything between). The upgrades fix values whose **meaning** changed (an index that moved, a list that was re-ordered); new fields need no step, because fields are matched by name.

## 15.6 Online

Online doesn't trust a local file. The 5,575-value `g_savedMPGlobals` block holds local Online state, but character progress lives in **stats** that the server checks: `STAT_SET_INT` in 774 scripts and `STAT_GET_INT` in 792, with cloud slot natives (`STAT_LOAD`, `STAT_SAVE`, `STAT_CLOUD_SLOT_SAVE_FAILED`) in the transition scripts. See [stats and tunables](/docs/online/stats-and-tunables.md) (R7.3).

## 15.7 What this means for modders

- **Don't add fields to the story save.** The layout is registered once at start-up by Rockstar's script and checked by size; a mod can't extend it, and changing `standard_global_reg` would break every existing save.
- **Reading story progress is safe:** the flow, unlocks and activity records are plain globals once loaded. Their addresses change with every build ([surviving updates](/docs/core/surviving-updates.md)), so look them up by the field names above, not by number.
- **Keep a mod's own data in its own file,** next to the mod (the script hooks give C#, C++ and Lua normal file access), keyed by the save slot if it should follow the player's progress. *Known* practice: an INI, JSON or XML file in the mod's folder under `scripts`.
- **Stats work in story mode too** (`SP0_`, `SP1_`, `SP2_` stats for the three characters are part of the save, **Known**), but they are a fixed list; a mod can't add its own.
- **Back up saves before testing save-related mods.** A bad value in a global that is saved at the next autosave stays in the save.

## 15.8 Open questions

| Question | Where it goes |
| --- | --- |
| The full tree of nested and run-time-named sections, with offsets | Answered in [15.4](#154-whats-in-the-story-save) (top level complete; deeper levels summarised) |
| What the upgrade function does for older save versions | Answered in [15.5.1](#1551-the-save-upgrade) |
| The save file's on-disk format and how names map to it | Reverse engineering, outside the scripts |
| What triggers an autosave, and completion | R5.3 |

## 15.9 Test cards

1. **Version.** In story mode, read the first value of the story save global with a script and print it. Expected: 1.7.
2. **Autosave flag.** Watch `IS_AUTO_SAVE_IN_PROGRESS` while finishing a mission. Expected: true for a moment after the mission-passed screen.
