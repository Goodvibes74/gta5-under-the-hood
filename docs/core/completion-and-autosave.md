# Completion, autosave and achievements

How story mode decides when to save and how much of the game you've done: the 320 completion entries and the weights that make 100%, the controller that adds them up and reports them, the autosave controller and how scripts ask it to save, the save bed and save-anywhere scripts, and the achievement controller. Roadmap topic **R5.3** in the [roadmap](/ROADMAP.md). Builds on saves (R1.7) and [story flow](/docs/gameplay/missions/story-flow.md) (R5.1).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `standard_global_reg` (the completion entries and weights), `completionpercentage_controller` (31,293 lines), `autosave_controller` (93,637), `save_anywhere`, `savegame_bed`, `achievement_controller` (17,700). Launchers from the [script launch graph](/scripting/script-launch-graph.md); script counts with `git grep`; native counts from [native usage](/scripting/native-usage.md). Numbers and names are **Verified**. The text behind the completion labels (`M_ARM1`, `SC_MG_GOLF` ...) wasn't found in the text files read, so what each label names is inferred from its prefix (*probable*). *Second pass (2026-10-25):* the labels were looked up in every American text block of the base game and the DLC packs ([text labels](/docs/ui/text-labels.md#naming-the-labels)); 199 of the 320 have text, all in `global.gxt2`, and the 121 others have none anywhere ([16.3](#163-the-completion-list)).

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

**One entry's 12 values** (*second pass*: read in the registration call `func_699` of `standard_global_reg`, the controller and the shared "mark done" helper; **Verified**):

| Value | Holds | Set by |
| ---: | --- | --- |
| 0 to 3 | The text label (16 characters) | Registration |
| 4 | Weight | Registration |
| 5 | Done flag | The "mark done" helper |
| 6 | Group (0 to 14, table below) | Registration |
| 7 | "Heist choice" flag: 1 on 7 entries (`M_AH3a`, `M_FH2a`, `M_DH2A`, `SC_JWL_P_CHOICE`, `SC_FINP1_CHOICE`, `SC_FINP2_CHOICE`, `SC_FIN_K_CHOICE`). The mission they point to is resolved through the approach the player chose (the flow's heist int IDs), so either approach completes the entry | Registration |
| 8 | Two 7-bit IDs packed together: the low 7 bits are what the entry is (the mission number in the mission table for groups 1 and 2, the activity number for groups 3 to 6, the stranger-or-freak mission number for groups 7 and 8), the next 7 bits a variant (the course or round: `SC_MG_OFF1` to `6` are activity 4, variants 0 to 5; the shooting range is activity 11). 127 means "none" | Registration |
| 9 | Unused (always 0) | Registration |
| 10, 11 | X and Y of where the entry was completed, for the JSON summary (`x`, `y`) | The "mark done" helper |

Two registration arguments are always 0 in this build (unused flags). The "mark done" helper (in 147 scripts) sets the done flag, stores the X and Y it is given and sets the packed-stat bool `891 + entry`; its 478 calls pass 0, 0 except the strangers-and-freaks pass code, which gives Tonya 3 and 4 the fixed point 406.38, -1,635.86 (Strawberry) and Mrs Philips 2 the point 1,973.84, 3,814.89 (Sandy Shores), and random-event code, which passes the event's own position (13 of the 38 `re_` scripts in the same form). So the map numbers are a completion position, not a blip.

**The sum** (`func_153` in the controller, **Verified**): for each counted group it adds the weights of completed entries; if every entry of the group is done it sets the group to its full share instead (55, 10, 0, 10, 5, 15, 5). Random events add four times their weight and are set to the full 5% once 14 are done (the needed count, `14`, is set next to the list). The seven group totals are added into the save's total.

**The text of the labels** (*second pass*, **Verified**). 199 of the 320 labels have English text in `global.gxt2`: every story mission (`M_ARM1` "Franklin and Lamar", `M_FAM1` "Father/Son", `M_MIC4` "Meltdown"), every counted stranger and freak (`SC_RC_EPS3` "Assuming The Truth"), every minigame (`SC_MG_TRI1` "Triathlon 1: Trailer Park", `SC_MGPS11` "Flight School - Skydiving") and every misc entry. The 121 without text exist in no American text file, base or DLC, so they are internal names the game never shows as text: all 60 random events (`RE*`), the 42 tracked-only entries of group 0 (taxi `OJTX*` and trafficking `OJDG*` odd jobs, extra random-event variants, `SC_FR_ARRACT`), 11 in group 6 (air and ground trafficking `OJDA*`, `OJDG1` to `5`, hunting `OJHU`), 7 in group 1 (the five assassinations `ASS1` to `5`, `FHPB`, `DHP1`) and 1 in group 4 (`MGSP`).

**The misc and friend groups** name these activities (the `SC_MSC_` prefix shortened to its last part):

| Group | Counts toward 100% | Labels and their text |
| ---: | --- | --- |
| 11 | Yes, 15% | `SC_CO_UFOP1` Collect Omega Spaceship Parts, `SC_CO_DLS1` Collect Dreyfuss Letter Scraps, `STJ` Stunt Jumps, `BRG` Under The Bridge, `KFT` Knife Flights, `CIN` Cinema Visit, `PPY` Property Purchase, `VEH` Online Vehicle Purchase, `CHP` Walk and Play with Chop, `BOO` Booty Call, `HKR` Hooker Hire, `HLD` Shop Hold Up |
| 12 | No (tracked only) | `DIV` Diving Pickups, `SON` Sonar Collections, `YOG` Yoga, `CAB` Cable Car Ride, `WSH` Car Wash, `FRG` Fairground Visit, `CLT` Clothes Purchase, `MOD` Car Mod Purchase, `BRB` Get a Haircut, `TAT` Get a Tattoo, `GUN` Weapon Purchase, `WTV` Watch TV, `STK` Deal in Stocks |
| 13 | Yes, 5% | `SC_FR_BAR` Friends: Bar Visit, `SC_FR_CIN` Cinema Visit, `SC_FR_DAR` Play Darts, `SC_FR_STR` Strip Club Visit |
| 14 | No | `SC_FR_GOL` Friends: Play Golf, `SC_FR_TEN` Play Tennis |

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

### 16.5.1 How a save is asked for, and when it is refused (second pass)

**The request** (`Global_102468`, 11 values in build 3725; **Verified** in `autosave_controller` and the shared request helpers):

| Value | Meaning |
| ---: | --- |
| 0 | "Don't save" flag: when set, the controller drops the request |
| 1 to 4 | The controller's progress: request picked up, `DO_AUTO_SAVE` called, the save started, request finished |
| 5, 6 | Bookkeeping: the request had no type; the "autosave is off" message has been shown once |
| 7 | Request type set by the caller (0 or 1) |
| 8 | "Save behind a faded screen": the controller skips its wait for the screen to fade in and tells the engine not to fade in after a load (`SET_FADE_IN_AFTER_LOAD(false)`) |
| 9 | Game timer when the request was picked up |
| 10 | How many requests are queued. A caller adds 1 only if none is queued (two with value 8 set); a second request in the same moment is dropped |

**Who asks** (counted with `git grep`: the shared helper that adds to value 10 is called in **220 scripts**): `flow_controller` after a story mission passes and after a completion recount; the 63 strangers-and-freaks mission scripts; 34 random events; the heist controllers and preps (12); shops and mod shops (23, including every `*_carmod` script and the wardrobes); taxi jobs (11); activities (golf, tennis, darts, triathlon, off-road races, flight school, the shooting range, stunt planes, bail bonds, assassinations, towing, trafficking, hunting, yoga, the fairground, the cable car ...); collectables (letter scraps, spaceship parts, the diving and sonar pickups, for-sale signs, bridges, the photography challenges); and the controllers `main`, `player_controller`, `vehicle_gen_controller`, `social_controller`, `code_controller`, `mission_repeat_controller`, `mission_stat_watcher` and `director_mode`. Eight `_mp` scripts carry the same code but don't run in story mode.

**Missions that don't autosave when they pass:** the flow skips the request when bit 0 of the mission's flag value (the last argument of its mission-table entry, `f_15`) is set. Nine missions have it: `prologue1`, `michael4`, `finale_intro`, `finale_heist2_intro`, `finaleA`, `finaleB`, `finaleC1`, `finaleC2` and `finale_credits`. It also skips the request while a mission marks itself running (`Global_65010`, set in 92 scripts).

**When the controller refuses** a request (it marks it finished without saving): the game is in a transition (`Global_80280`); the story flow hasn't started, or the prologue strand isn't active; the current character isn't a valid story character; the player stands in an area where saving is blocked; or the "don't save" flag is set. **When it waits** (tries again next frame): the player is injured, a save or a memory-card operation is already running, a mission is being set up, the player isn't playing, a character switch is in progress, the phone is busy (unless `apptrackify` runs), or the screen isn't faded in (unless value 8 is set). Then it records which flow strands need a fade-in after a load, calls `CLEAR_REPLAY_STATS` and `DO_AUTO_SAVE`, and shows `SAVE_OFF` once if the player has autosave turned off (**Verified**).

## 16.6 Achievements

`achievement_controller` polls conditions every frame and awards achievements that aren't tied to a single mission (**Verified**): 23 achievement IDs are tested directly with `HAS_ACHIEVEMENT_BEEN_PASSED`; it reads stats (`STAT_GET_INT`, 15 calls), DLC weapon components and profile settings. Missions award their own: `GIVE_ACHIEVEMENT_TO_PLAYER` appears in 409 scripts through a shared helper, and progress achievements use `SET_ACHIEVEMENT_PROGRESS` / `GET_ACHIEVEMENT_PROGRESS` (240 scripts each).

**The 23 IDs the controller checks** (*second pass*). The condition is **Verified** from the controller; the name is **Known** (the game's text files don't hold achievement names; they come from the platforms' lists, and each condition below matches its name's description). The first seven rows are story-mode conditions, IDs 29 to 49 are checked in the Online part of the script, and ID 50 adds both modes:

| ID | Name (**Known**) | Condition in the controller |
| ---: | --- | --- |
| 12 | Solid Gold, Baby! | 70 gold medals in story missions (progress in `num_gold_medals_obtained`) |
| 14 | San Andreas Sightseer | 97.5% of the map uncovered (`GET_MINIMAP_FOW_DISCOVERY_RATIO`), story mode only |
| 17 | Multi-Disciplined | Gold in all 6 disciplines it checks (progress in `num_discipline_gold_earned`) |
| 22 | Show Off | 50 stunt jumps (`GET_NUM_SUCCESSFUL_STUNT_JUMPS`) |
| 24 | Three Man Army | A wanted level of 3 or more, outside a mission, with the other two characters, kept for the time the controller counts |
| 25 | Out of Your Depth | Attacked (the shark attack animation) or killed by a tiger shark (`a_c_sharktiger`) in the water |
| 27 | A Lot of Cheddar | The three characters' `MONEY_TOTAL_SPENT` add up to $200,000,000 (progress in `num_cash_spent`) |
| 29 | Pimp My Sidearm | A weapon check on the player, every 5 seconds |
| 33 | Off the Plane | An Online check in its own function |
| 34, 35, 36 | Three-Bit Gangster, Making Moves, Above the Law | Online rank 25, 50, 100 |
| 37 | Numero Uno | An Online check in its own function |
| 38 | The Midnight Club | 5 custom races won (`mpply_total_custom_races_won`) |
| 39 | Unnatural Selection | An Online stat (index 48) reaching 10 |
| 40 | Backseat Driver | An Online stat (index 52) above 0 |
| 41 | Run Like The Wind | A bit in the Online player data |
| 43 | Decorated | An Online stat (index 756) reaching 30 |
| 44 | Stick Up Kid | An Online stat (index 14) reaching 20 |
| 45 | Enjoy Your Stay | An Online check in its own function |
| 48 | Dialling Digits | An Online contact-service check (index 11) |
| 49 | American Dream | An Online check in its own function |
| 50 | A New Perspective | 15 hours in first-person view, story and Online added together (`first_person_cam_time`, `mp_first_person_cam_time`) |

The controller also shows `CHEAT_ACHIEVE` (`CHEAT_TROPHIE` on PlayStation) when cheats are switched on. Every other achievement is awarded by the mission or activity that earns it.

## 16.7 What this means for modders

- **A mod can't add a completion entry:** the list is fixed at 320 and registered by Rockstar's script at start-up (saves (R1.7)).
- **To read completion,** read the `num_*_completed` and `num_*_available` stats; they are refreshed by the controller and don't depend on global addresses.
- **Don't call `DO_AUTO_SAVE` from a mod.** Rockstar routes every save through one controller that checks the flow first; a save at the wrong moment can store a half-finished state. Saving in story mode is safest from the game's own save points.
- **Mod effects that change saved globals become permanent at the next autosave.** Undo them before a mission passes, or keep them in the mod's own file (saves (R1.7), 15.7).

## 16.8 Open questions

| Question | Where it goes |
| --- | --- |
| What each completion entry's flags and map numbers mean | Answered in [16.3](#163-the-completion-list) (one entry's 12 values) |
| Every autosave trigger, from the request fields | Answered in [16.5.1](#1651-how-a-save-is-asked-for-and-when-it-is-refused-second-pass) |
| Which 23 achievements the controller awards, by name | Answered in [16.6](#166-achievements) (conditions **Verified**, names **Known**) |
| The Online achievement checks that sit in their own functions (IDs 29, 33, 37, 45, 48, 49) and the stats behind indexes 14, 48, 52 and 756 | With the Online stat list (R7.3) |

## 16.9 Test cards

1. **Completion stats.** In story mode, read `num_missions_completed` and `num_missions_available`. Expected: available is 69.
2. **Autosave.** Pass a mission with autosave on and watch `IS_AUTO_SAVE_IN_PROGRESS`. Expected: true briefly after the pass screen.
