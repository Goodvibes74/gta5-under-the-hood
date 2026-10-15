# Saves: what the story save holds and how scripts write it

How the game's save works from the script side: the story save is one global structure that a single script registers field by field, with names, before the game can load or write it; the smaller save blocks next to it; the Online equivalent; and where a mod should keep its own data. Roadmap topic **R1.7** in the [roadmap](/ROADMAP.md). Builds on the [global map](/docs/core/global-map.md) (block 0 holds the story save) and [runtime scripts](/docs/core/runtime-scripts.md) (`startup`, `standard_global_reg`). The scripts that trigger saves (`autosave_controller`, `savegame_bed`, `save_anywhere`, completion) are topic R5.3.

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `standard_global_reg` (108,777 lines), `startup`, `sp_dlc_registration`, `sp_pilotschool_reg`, and the save calls in `autosave_controller`, `savegame_bed` and `save_anywhere`. The save natives were found with `git grep` and counted from the [native usage](/scripting/native-usage.md) tables. Names, sizes and counts are **Verified**; what the engine does with the registered layout (the file format, where it writes) is **Known**.

## 15.1 Short version

- **The story save is one structure, `Global_114904`, 38,592 values long.** `standard_global_reg` registers it between `START_SAVE_DATA(&Global_114904, 38592, true)` and `STOP_SAVE_DATA()`.
- **Every saved field is registered by name:** 1,062 registrations (602 ints, 198 bools, 150 enums, 85 floats, 27 text labels) inside 108 structures and 347 arrays, with 828 distinct literal names plus names built at run time for array elements (`fSaveVersion`, `BitsetCharacterStoryUnlock`, `GOLF_iBestRound`, `OFFROAD_Race5Best` ...).
- **Only 4 scripts register save data:** `standard_global_reg` (the story save), `startup` (a version check and the Online block), `sp_dlc_registration` and `sp_pilotschool_reg` (one dummy value each).
- **The save has a version:** the first field is `fSaveVersion`. `startup` reads it on its own first, then sets it to **1.7** and runs an upgrade function when a loaded save has another version.
- **The layout is checked:** after registering, scripts compare `GET_SIZE_OF_SAVE_DATA` with the size they expect (5,575 for the Online block, 1 for the DLC block).
- **The big sections:** the flow (`FLOW_STRUCT`, 931 values), emails (`EMAIL_DATA`, 3,867), vehicle purchases (`BUY_VEC_SAVED`, 1,252), director mode (`DIRECTOR_SAVED_STRUCT`, 1,617), communications (`COMM_CONTROL_DATA_STRUCT`, 925), the shooting range (814), plus one structure per side activity (golf, darts, taxi, towing, triathlon, races, shop robberies, random events ...).
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

Named top-level sections, by position in `Global_114904` (offset, size; **Verified**):

| Section | Offset | Values |
| --- | ---: | ---: |
| `HEIST_DATA_STRUCT` | 1 | 242 |
| `COMPONENTS_ARRAY` (ped components) | 2,370 | 493 |
| `COMM_CONTROL_DATA_STRUCT` (calls, texts) | 7,695 | 925 |
| `CODE_CONTROL_DATA_STRUCT` | 8,620 | 472 |
| `FLOW_STRUCT` (the mission flow) | 9,092 | 931 |
| `FLOW_CUSTOM_STRUCT` | 10,023 | 33 |
| `SAVED_RANDOM_CHARACTERS` (strangers and freaks) | 18,581 | 379 |
| Activities: `BASEJUMP`, `DARTS`, `GOLF`, `OFFROAD`, `TAXI`, `SHRINK`, `ASSASSIN`, `TOWING`, `TRAFFICKING`, `TRIATHLON`, `SEA_RACE`, `STREET_RACE`, `COUNTRY_RACE`, `BAIL_BOND` (each `_SAVED_STRUCT`) | 18,974 to 25,080 | 2 to 50 each |
| `SHOOTING_RANGE_SAVED_ARRAY` | 19,154 | 814 |
| `SHOPROBBERIES_SAVED_STRUCT` | 20,042 | 82 |
| `SPECIALPED_SAVED_STRUCT` | 20,124 | 1 |
| `FLOW_HELP_STRUCT` (help messages shown) | 20,417 | 154 |
| `EMAIL_DATA` | 21,044 | 3,867 |
| `RANDOM_EVENTS_SAVED` | 25,002 | 78 |
| `RP_PLAYER` | 25,091 | 6 |
| `BUY_VEC_SAVED` (vehicles bought) | 25,189 | 1,252 |
| `DIRECTOR_SAVED_STRUCT` (director mode unlocks) | 26,441 | 1,617 |

The rest of the 38,592 values (properties, garages, the characters' clothes and weapons, collectables, stats bookkeeping) sit in structures whose names are built at run time or nested deeper; the table lists the named ones at the top level only.

## 15.5 When it is written

- **Autosave:** `autosave_controller` calls `DO_AUTO_SAVE` (its only caller) after the flow marks a save point, then clears replay stats (`CLEAR_REPLAY_STATS`). Scripts ask for an autosave through the flow globals rather than calling the native themselves. `IS_AUTO_SAVE_IN_PROGRESS` is checked in 18 scripts; `GET_IS_AUTO_SAVE_OFF` (the player's setting) in 3.
- **Manual save:** `save_anywhere` opens the save menu with `SET_SAVE_MENU_ACTIVE(true)`; `savegame_bed` (sleeping in a safehouse) closes it again.
- **Mission replays:** `QUEUE_MISSION_REPEAT_SAVE` and `QUEUE_MISSION_REPEAT_LOAD` save and restore around a replayed mission (`mission_repeat_controller`).
- **Where the player wakes up:** `SET_SAVE_HOUSE` (12 scripts, 217 calls).

Which events trigger an autosave, and completion percentage, are R5.3.

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
| The full tree of nested and run-time-named sections, with offsets | Second pass: walk every registration function |
| What the upgrade function does for older save versions | Second pass, `startup` `func_21` |
| The save file's on-disk format and how names map to it | Reverse engineering, outside the scripts |
| What triggers an autosave, and completion | R5.3 |

## 15.9 Test cards

1. **Version.** In story mode, read the first value of the story save global with a script and print it. Expected: 1.7.
2. **Autosave flag.** Watch `IS_AUTO_SAVE_IN_PROGRESS` while finishing a mission. Expected: true for a moment after the mission-passed screen.
