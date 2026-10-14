# Character switching

How the story mode's switch between Michael, Franklin and Trevor works: the character wheel (`selector`), the script that performs the switch (`player_controller_b`), the swoop camera natives, the arrival scenes (`player_timetable_scene` and the `player_scene_*` scripts), and the wheel's way into Online. Roadmap topic **R6.1** in the [roadmap](/ROADMAP.md). Builds on [runtime scripts](/docs/core/runtime-scripts.md) and [streaming](/docs/core/streaming.md) (the switch streams the destination).

**How it was made.** `selector` (108,607 lines), `player_controller_b` (126,591), `player_controller` (112,143) and `player_timetable_scene` (156,812) read in the build-3725 decompile (commit `6c18d3e8b`); launches from the [script launch graph](/scripting/script-launch-graph.md); native use from [native usage](/scripting/native-usage.md). Function and global numbers are decompiler names for this build only. Switch types and flag meanings are NativeDB's (**Known**); the script logic is **Verified**. First pass: what each character's saved state holds (position, outfit, weapons, vehicle, money) is only outlined (9.6).

## 9.1 Short version

- **Four scripts share the job.** `selector` (started by `main_persistent`) draws the character wheel and handles the choice; `player_controller_b` (started by `main`, 5,050 stack) performs the switch; `player_timetable_scene` (started by `player_controller_b`) stages what the arriving character is doing; 13 `player_scene_*` scripts play special arrival scenes. `player_controller` (started by `initial`) handles each character's outfits and character-specific state.
- **The swoop is an engine feature driven by natives:** `START_PLAYER_SWITCH(from, to, flags, type)` starts it; `GET_IDEAL_PLAYER_SWITCH_TYPE(from, to)` picks long, medium or short by distance (type 3, short, gets its own path); `SET_PLAYER_SHORT_SWITCH_STYLE`, `SET_PLAYER_SWITCH_ESTABLISHING_SHOT`, `ALLOW_PLAYER_SWITCH_DESCENT` and `ALLOW_PLAYER_SWITCH_OUTRO` shape it; `CHANGE_PLAYER_PED` swaps control at the right moment.
- **Before the swoop** `player_controller_b` checks `IS_SAFE_TO_START_PLAYER_SWITCH`, turns player control off and makes **both** characters invincible, then builds the flags (bits 1, 2, 4, 8; bit 2 when a camera or establishing shot is given).
- **The streaming happens during the swoop:** the camera goes up, the destination streams in, then it descends; scripts check `IS_PLAYER_SWITCH_IN_PROGRESS` (736 scripts) and `GET_PLAYER_SWITCH_STATE` (556) to stay out of the way.
- **Arrival scenes come from a table:** 42 entries in `player_controller_b` map situations to 13 scene scripts (Trevor's `bbfight` 9 entries, `insult` 7, `park` 6; Michael's `kids` and `shopping` 4 each ...), started on a 2,050 stack beside `player_timetable_scene` (passed a 120-value argument block on a 5,050 stack).
- **231 scripts check whether `player_timetable_scene` is running** before they act, so ambient events, missions and triggers don't fight the arrival scene.
- **The wheel's Online slot** is in `selector`: it requests `MainTransition`, waits, and starts it on the 8,032 stack ([story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)).

## 9.2 The scripts

| Script | Started by | Stack | Role |
| --- | --- | ---: | --- |
| `selector` | `main_persistent` | 1,424 | The character wheel (`HUD_SHOWING_CHARACTER_SWITCH_SELECTION`), availability, the Online slot (starts `MainTransition`) |
| `player_controller` | `initial` | 1,424 | Per-character state: outfits, tattoos, character-specific behaviour |
| `player_controller_b` | `main` | 5,050 | Performs switches: the swoop, `CHANGE_PLAYER_PED`, starting arrival scenes |
| `player_timetable_scene` | `player_controller_b` | 5,050 | Places the arriving character in a scene that fits the time of day (the "timetable") |
| `player_scene_*` (13 named in the table, 14 in the release) | `player_controller_b` | 2,050 | Special arrival scenes: `f_lamtaunt`, `f_taxi`, `ft_franklin1`, `m_cinema`, `m_fbi2`, `m_kids`, `m_shopping`, `mf_traffic`, `t_bbfight`, `t_chasecar`, `t_insult`, `t_park`, `t_tie` (plus `f_lamgraff`) |
| `family_scene_m`, `_f0`, `_f1`, `_t0`, `_t1` | Brains and controllers | | Ambient family scenes at the safehouses |

## 9.3 One switch, step by step

From `player_controller_b` (function numbers are build-3725 decompiler names):

1. **Ready?** `IS_SAFE_TO_START_PLAYER_SWITCH()` must be true, and neither ped injured.
2. **Freeze the moment:** if the current character sits in a vehicle, that vehicle is handled first; `SET_PLAYER_CONTROL(false)`; both peds `SET_ENTITY_INVINCIBLE(true)`; a global flag (`Global_99323` here) marks a switch in progress.
3. **Flags:** start from the caller's value, add 4 and 8 from two options, 2 when a camera or an establishing-shot name is given, 1 from a condition.
4. **Start:** `START_PLAYER_SWITCH(from, to, flags, type)`; optionally `SET_PLAYER_SHORT_SWITCH_STYLE`; the HUD effect for the outgoing character is stopped (`SwitchHUDMichaelOut`, `SwitchHUDTrevorOut`, `SwitchHUDOut`).
5. **Type:** `GET_IDEAL_PLAYER_SWITCH_TYPE(fromPos, toPos)`; type 3 (short, **Known** name) takes a separate path without the high ascent; otherwise an establishing shot can be set (`SET_PLAYER_SWITCH_ESTABLISHING_SHOT`).
6. **In the air:** the engine streams the destination ([streaming](/docs/core/streaming.md#104-streaming-focus-load-scenes-volumes-and-srls)); `player_controller_b` requests `player_timetable_scene` and the scene script.
7. **Swap:** `CHANGE_PLAYER_PED(PLAYER_ID(), newPed, ...)` gives control of the new character.
8. **Descent and outro:** `ALLOW_PLAYER_SWITCH_DESCENT`, `SET_PLAYER_SWITCH_OUTRO`, `ALLOW_PLAYER_SWITCH_OUTRO`; the scene scripts run; control returns.

## 9.4 Switch natives in the game

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `IS_PLAYER_SWITCH_IN_PROGRESS` | 736 | 9,738 |
| `GET_PLAYER_SWITCH_STATE` | 556 | 2,886 |
| `GET_PLAYER_SWITCH_TYPE` | 435 | 1,497 |
| `IS_SAFE_TO_START_PLAYER_SWITCH` | 295 | 472 |
| `START_PLAYER_SWITCH` | 291 | 567 |
| `STOP_PLAYER_SWITCH` | 296 | 653 |
| `SET_PLAYER_SWITCH_OUTRO` | 290 | 556 |
| `CHANGE_PLAYER_PED` | 60 | 62 |
| `SET_PLAYER_SWITCH_ESTABLISHING_SHOT` | 32 | 32 |

`START_PLAYER_SWITCH` in 291 scripts is the shared mission library (missions switch characters mid-mission, and Online uses the same swoop for joining: `SWITCH_TO_MULTI_FIRSTPART` and `SWITCH_TO_MULTI_SECONDPART` in 88 and 290 scripts). `CHANGE_PLAYER_PED` is called once by each of about 50 missions plus `main`, `flow_controller`, `replay_controller`, `mission_repeat_controller`, `maintransition`, `selector`, `player_controller_b`, `animal_controller` and `director_mode`.

## 9.5 What this means for modders

- **Check before acting:** don't spawn, teleport or start scenes while `IS_PLAYER_SWITCH_IN_PROGRESS()` or while `player_timetable_scene` is running (`GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("player_timetable_scene"))`), as 231 game scripts do.
- **A mod can use the swoop:** `START_PLAYER_SWITCH` between two peds gives the sky-camera transition and streams the destination for free; follow the 9.3 steps (control off, invincible, check safe, swap with `CHANGE_PLAYER_PED`).
- **The SHVDN player handle changes** after a switch: re-read `Game.Player.Character` every tick instead of keeping it.
- **For an Online-style mod:** the story `selector` stays running and its Online slot starts Rockstar's `MainTransition`; the mod must keep the wheel from offering that ([story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)) and can reuse the swoop for its own entrance (`SWITCH_TO_MULTI_*`), as Online does.

## 9.6 Open questions

| Question | Where it goes |
| --- | --- |
| What each character's saved state holds (position, outfit, weapons, vehicle, money) and where in the story save | Second pass, with R1.7 saves and the [global map](/docs/core/global-map.md) |
| The 42-entry scene table's conditions (time, place, mission state) | Second pass |
| The meaning of switch flag bits 1, 2, 4, 8 | NativeDB notes plus a test card |
| Who starts the `family_scene_*` scripts | R0.5 second pass (launch graph) |

## 9.7 Test cards

1. **Swoop types:** switch between two characters standing close (short switch) and far apart (long); note the camera path. With a frame-time log on ([measuring](/docs/performance/measuring.md)), note any hitch at the descent (streaming).
2. **Arrival scenes:** switch to Trevor several times at different times of day and note which scene plays; compare with the `t_bbfight`, `t_insult`, `t_park` entries.
