# Completion, autosave and achievements

How story mode decides when to save and how much of the game you've done: the 320 completion entries and the weights that make 100%, the controller that adds them up and reports them, the autosave controller and how scripts ask it to save, the save bed and save-anywhere scripts, and the achievement controller. Roadmap topic **R5.3** in the [roadmap](/ROADMAP.md). Builds on saves (R1.7) and [story flow](/docs/gameplay/missions/story-flow.md) (R5.1).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `standard_global_reg` (the completion entries and weights), `completionpercentage_controller` (31,293 lines), `autosave_controller` (93,637), `save_anywhere`, `savegame_bed`, `achievement_controller` (17,700). Launchers from the [script launch graph](/scripting/script-launch-graph.md); script counts with `git grep`; native counts from [native usage](/scripting/native-usage.md). Numbers and names are **Verified**. The text behind the completion labels (`M_ARM1`, `SC_MG_GOLF` ...) wasn't found in the text files read, so what each label names is inferred from its prefix (*probable*).

## 16.1 Short version

- **Completion is a fixed list of 320 entries** (array of 321), registered by `standard_global_reg` with an index, a group, a weight and a label. It's part of the story save (`Global_114904.f_10201`, 12 values per entry, total at `.f_3853`).
- **Seven counted groups make 100%:** missions 55% (69 entries), minigames 10% (42), strangers and freaks 10% (20), random events 5% (59 entries, only 14 needed), two "misc" groups 15% (12) and 5% (4), and an odd-jobs group worth 0% with no entries. The other 113 entries are tracked but don't count.
- **Each group snaps to its full share when all its entries are done,** so rounding never leaves you at 99.9%. Random events count four times their weight and need only 14.
- **`completionpercentage_controller`** (started by `initial`) recounts on request, writes 12 stats (`num_missions_completed`, `num_missions_available` ...) and, at most every 5 minutes, builds a JSON summary (`tot_pc`, sections `mgc`, `msnc`, `ojc`, `rcc`, `revc`, `misc`, with each entry's map position) for Rockstar's services.
- **Autosave is one script with four states:** `autosave_controller` (started by `main` and `director_mode`, stack 1,424) is the only caller of `DO_AUTO_SAVE`. 269 scripts reference its request global, so missions ask for a save rather than saving.
- **Manual saves:** `save_anywhere` (started by `main`) opens the save menu (`SET_SAVE_MENU_ACTIVE(true)`); `savegame_bed` handles saving in a safehouse bed.
- **Achievements:** `achievement_controller` (started by `main_persistent`) checks 23 achievement IDs directly; `GIVE_ACHIEVEMENT_TO_PLAYER` is in 409 scripts through shared code, and `HAS_ACHIEVEMENT_BEEN_PASSED` is called 2,263 times.

## 16.2 Where it lives

| Script | Started by (stack) | Role |
| --- | --- | --- |
| `standard_global_reg` | `startup` | Registers the save and the 320 completion entries |
| `completionpercentage_controller` | `initial` | Adds up completion, writes the stats, builds the summary |
| `autosave_controller` | `main`, `director_mode` (1,424) | Performs autosaves |
| `save_anywhere` | `main` | The save menu |
| `savegame_bed` | a world-point brain (40 m), [strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) | Sleep to save |
| `achievement_controller` | `main_persistent` (1,424) | Watches achievement conditions |

## 16.3 The completion list

Each entry is registered by one call (`func_699` in this build) with: entry number, group, weight, a few flags, a text label and two numbers used for the map (**Verified**). The weight of a counted entry is the group's share divided by its entry count, set just before the group is registered:

| Group | Share | Entries | Weight each | Label prefix (examples) |
| ---: | ---: | ---: | --- | --- |
| 1 | 55% | 69 | 55 / 69 | `M_` story missions (`M_ARM1`, `M_FAM2`, `M_EXL3` ...) |
| 3 | 10% | 42 | 10 / 42 | `SC_MG_` minigames and activities (`SC_MG_GOLF`, `SC_MG_TENN`, `SC_MG_OFF1` to `6`, shooting range `SC_MG_SH*`) |
| 5 | 0% | 0 | | Odd jobs (`OJ*` labels sit in uncounted groups) |
| 7 | 10% | 20 | 10 / 20 | `SC_RC_` strangers and freaks (`SC_RC_OME1`, `SC_RC_PA1` ...) |
| 9 | 5% | 60 (59 in the formula) | 5 / 59, counted ×4 | `RE` random events (`RE8A`, `RE25`, `RE44B` ...) |
| 11 | 15% | 12 | 15 / 12 | `SC_MSC_` and `SC_CO_` misc (`SC_MSC_STJ`, `SC_MSC_BRG`, `SC_MSC_KFT`, `SC_CO_UFOP1` ...) |
| 13 | 5% | 4 | 5 / 4 | `SC_FR_` friend activities (`SC_FR_BAR`, `SC_FR_CIN`, `SC_FR_DAR`, `SC_FR_STR`) |
| 0, 4, 6, 8, 12, 14 | none | 44, 1, 20, 33, 13, 2 | | Tracked only: extra strangers and freaks (`SC_RC_EPS*`, `SC_RC_HUN*`), odd jobs (`OJDG*`, `OJTX*`) and others |

**The sum** (`func_153` in the controller, **Verified**): for each counted group it adds the weights of completed entries; if every entry of the group is done it sets the group to its full share instead (55, 10, 0, 10, 5, 15, 5). Random events add four times their weight and are set to the full 5% once 14 are done (the needed count, `14`, is set next to the list). The seven group totals are added into the save's total.

**What `SC_MSC_` likely covers** (*probable* from the labels): stunt jumps (`STJ`), under-the-bridge flights (`BRG`), knife flights (`KFT`), the cinema (`CIN`) and other one-off collections. Labels whose text is in a block not read here are an open question.

## 16.4 Reporting it

When asked (`Global_114638` in this build), the controller (**Verified**):

1. Recounts (16.3) and writes 12 stats: completed and available counts for missions, minigames, odd jobs, random people, random events and misc.
2. Updates presence stats (`PRESENCE_EVENT_UPDATESTAT_INT`, 25 calls), for example `num_rndevents_completed` once all needed random events are done.
3. At most once every 300,000 ms (5 minutes), builds a JSON file with `DATAFILE_CREATE`: `tot_pc` (the total) and a `Sect` dictionary with arrays `msnc` (missions), `mgc` (minigames), `ojc` (odd jobs), `rcc` (random characters), `revc` (random events) and `misc`, each item holding `nm` (label), `cmp` (done), `100` (counts toward 100%) and `x`, `y` (map position). *Known*: this is the story-progress summary shown on the Social Club website.

## 16.5 Autosave

- **The controller** has four states: set up, wait, save, finish (**Verified**, entry function). In the save state it checks the flow's pending items, then `CLEAR_REPLAY_STATS` and `DO_AUTO_SAVE`, and marks the request done.
- **Asking for a save:** 269 scripts reference the controller's request global (`Global_102468`, 10 fields in this build). Missions, the flow and activities fill a request instead of saving themselves; the controller decides when it is safe.
- **Player setting:** `GET_IS_AUTO_SAVE_OFF` (3 scripts) reads the "autosave off" option. `IS_AUTO_SAVE_IN_PROGRESS` (18 scripts) lets other scripts wait for a save to finish.
- **Replays:** `mission_repeat_controller` uses `QUEUE_MISSION_REPEAT_SAVE` and `_LOAD` to save before a replayed mission and restore after it (saves (R1.7)).

## 16.6 Achievements

`achievement_controller` polls conditions every frame and awards achievements that aren't tied to a single mission (**Verified**): 23 achievement IDs are tested directly with `HAS_ACHIEVEMENT_BEEN_PASSED`; it reads stats (`STAT_GET_INT`, 15 calls), DLC weapon components and profile settings. Missions award their own: `GIVE_ACHIEVEMENT_TO_PLAYER` appears in 409 scripts through a shared helper, and progress achievements use `SET_ACHIEVEMENT_PROGRESS` / `GET_ACHIEVEMENT_PROGRESS` (240 scripts each).

## 16.7 What this means for modders

- **A mod can't add a completion entry:** the list is fixed at 320 and registered by Rockstar's script at start-up (saves (R1.7)).
- **To read completion,** read the `num_*_completed` and `num_*_available` stats; they are refreshed by the controller and don't depend on global addresses.
- **Don't call `DO_AUTO_SAVE` from a mod.** Rockstar routes every save through one controller that checks the flow first; a save at the wrong moment can store a half-finished state. Saving in story mode is safest from the game's own save points.
- **Mod effects that change saved globals become permanent at the next autosave.** Undo them before a mission passes, or keep them in the mod's own file (saves (R1.7), 15.7).

## 16.8 Open questions

| Question | Where it goes |
| --- | --- |
| The text of each completion label (block not found) | Second pass, with every text block |
| What each completion entry's flags and map numbers mean | Second pass, `func_699` |
| Every autosave trigger, from the request fields | Second pass, follow `Global_102468` |
| Which 23 achievements the controller awards, by name | Second pass, with the achievement list |

## 16.9 Test cards

1. **Completion stats.** In story mode, read `num_missions_completed` and `num_missions_available`. Expected: available is 69.
2. **Autosave.** Pass a mission with autosave on and watch `IS_AUTO_SAVE_IN_PROGRESS`. Expected: true briefly after the pass screen.
