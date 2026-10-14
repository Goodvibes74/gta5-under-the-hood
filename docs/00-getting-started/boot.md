# Boot and script control: from launch to control, and between story and Online

What happens from the moment `GTA5.exe` starts until the player can move, how a new game differs from a loaded one, where the mods come in, and how the game moves from story mode to Online and back. Roadmap topic **R1.2** in the [roadmap](/ROADMAP.md). [Guide 1](/docs/core/runtime-scripts.md) has the cards for each script named here and the boot diagram; [guide 2](/scripting/script-vm.md) explains threads, stacks and force cleanup.

**How it was made.** **Verified** from the build-3725 decompile, the script headers and the logs of one measured launch of a modded install. **Known** marks community knowledge not checked here.

## 3.1 Short version

1. **Engine and loaders (about 70 s on a low-end test PC (integrated graphics)).** The ASI loader and ScriptHookV load while the engine loads the game data. No script runs yet.
2. **`startup`** (the engine's first script) registers 14 global blocks and the Online save, starts `standard_global_init` (defaults, script brains, the story mission table) and `standard_global_reg` (the story save, 38,592 values), and ends.
3. **`standard_global_reg`** places the player if needed (`startup_positioning`) and starts **`main_persistent`**, which starts the ten shared scripts (HUD, phone, character wheel, shops ...).
4. **`initial`** sets up a new or loaded story game, starts the story controllers and ends; **`main`** waits for it and then runs for the rest of the session.
5. **Mods start** once Rockstar's scripts are running: ScriptHookV calls each mod's `main()`, SHVDN loads the .NET scripts (about 13 s on the test install), and the player can move about 14 s after the .NET scripts start.
6. **Online and back:** `selector` is the only script that starts `MainTransition`, even when the game was launched straight into Online. Going back to story mode shuts the session down with `SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME`, which starts story mode again through the boot (**Verified** call; **Known** that the whole boot reruns).

## 3.2 The timeline of one launch

One measured launch of a modded install with about 30 ASI and .NET mods on a low-end test PC (**Verified** from `asiloader.log`, `ScriptHookV.log`, `ScriptHookVDotNet.log` and a small monitoring script):

| Clock | Seconds after start | What happens |
| --- | --- | --- |
| 04:20:07 | 0 | `GTA5.exe` starts |
| 04:20:15 | 8 | ScriptHookV starts, checks the version (`VER_1_0_3717_0`) and registers the ASI scripts as the loader loads them |
| 04:20:36 | 29 | ScriptHookV extends four pools and finds the script thread table (size 189) |
| 04:20:41 | 34 | DirectX hooked (Menyoo and the trainers draw through it) |
| 04:21:15 | 68 | ScriptHookV creates its threads and waits for the game's scripts |
| 04:21:29 | 82 | `main()` of Lua and Menyoo |
| 04:21:30 | 83 | `main()` of SHVDN; it loads its APIs and the `scripts/` folder (04:21:31 to 04:21:44) |
| 04:21:40 | 93 | The .NET scripts are constructed  |
| 04:21:44 | 97 | First .NET tick; `main()` of TrainerV |
| 04:21:54 | 107 | The player can move and the screen is faded in |

On that PC the engine's part (0 to 68 s) is the loading screen; the mods' part (68 to 107 s) includes a few mods that take 1 to 3 s to start. Other launches of the same install took 57 to 140 s to playable.

## 3.3 Inside the boot scripts

**`startup`** (**Verified**):

1. Marks itself safe for network games; turns off director mode and animal form; removes the prologue's distant-lights IPLs.
2. Checks whether the game was launched straight into Online (`LOBBY_AUTO_MULTIPLAYER_FREEMODE`, `LOBBY_AUTO_MULTIPLAYER_MENU`, or a launch from the console live area) and, if so and it isn't the benchmark, commits the loading screen to that choice.
3. Requests and starts the 14 registration scripts in order: `mp_registration`, `mp_fm_registration`, `tunables_registration`, `sc_lb_global_block`, `mp_save_game_global_block`, `mp_prop_global_block`, `mp_prop_special_global_block`, `title_update_registration`, `title_update_registration_2`, `globals_fmmc_struct_registration`, `globals_fmmcstruct2_registration`, `globals_fmmcstruct3_registration`, `sp_dlc_registration` (after `title_update_registration_2`) and `sp_pilotschool_reg` (after `sp_dlc_registration`).
4. Starts `standard_global_init`, waits a frame, sets a global flag, then starts `standard_global_reg`.
5. Waits for three ready bits: bit 0 from `sp_dlc_registration`, bit 1 from `sp_pilotschool_reg`, bit 2 from `standard_global_reg` (startup presets 0 and 1, so in practice it waits for `standard_global_reg` to finish registering the story save).
6. Registers the save version (`fSaveVersion` 1.7) and the Online save block (`g_savedMPGlobals`, 5,575 values) and checks the save sizes.
7. Starts the store (commerce) data fetch if needed, stops prologue path nodes from streaming, fills the tunnel interior table, and ends.

**`standard_global_init`** sets default values in global block 0, registers the 146 script brains, and builds the **story mission table**: 95 entries, 68 with a script name, each with an id, the script, a short code (`PRO1` for `prologue1`, `TRV1` for `trevor1`, `RH2` for `rural_bank_heist`) and numbers that R5.1 will decode. This table is how `flow_controller` later finds which script to start for a mission (**Verified**).

**`standard_global_reg`** registers the story save: one `START_SAVE_DATA` block over the story globals with **38,592** values (1,041 individual registrations plus structs and arrays). It reads a flag inside that save to tell a loaded game from a new one (2 below), sets the matching stats, toggles the `BLIMP` scenario group from the save, starts `startup_positioning` (on the `SHOP` stack) when the player needs placing, then starts `main_persistent` and enables script brain set 1, unless the benchmark is running (**Verified**).

**`sp_dlc_registration`** registers a single save value (`aFakeSavedInt`) and sets its ready bit; **`sp_pilotschool_reg`** does the same for the story Pilot School. Their job is to reserve save space for content added after release (**Verified** content; the purpose is **Known**).

**`landing_pre_startup`** is empty in this build: an entry function with only default locals (**Verified**).

## 3.4 New game or loaded game

- The story save holds a flag (a bit in the flow flags) that `standard_global_reg` copies into `Global_1`, and sets for the next save. `startup` uses `Global_1` to keep the loaded save's version, and `initial` uses it to run four extra setup steps for a loaded game (**Verified** that the flag comes from the save and gates these steps; "set once a game has been started" is our reading).
- `initial` skips one setup step when `GET_INDEX_OF_CURRENT_LEVEL` is 5. Level 5 is checked 215 times across the scripts, mostly in Online content (level 1 is checked 6 times, around trains and the main map). Which level 5 is stays open.
- On a new game the first mission, `prologue1`, comes from the mission table above through `flow_controller`, like every other story mission (**Verified** that `prologue1` is entry 53 and that no script starts it by name; the exact first-start path is R5.1).

## 3.5 Launching into Online

There are two ways in, and both end in the same place (**Verified**):

- **From story mode:** the player picks Online on the character wheel. `selector` requests `MainTransition`, waits up to 20 s for it to load and for a free `TRANSITION` stack (8,032), starts it and stays with it until it finishes.
- **Straight from the launcher or landing page:** `startup`, `standard_global_reg`, `main_persistent`, `main` and `selector` all read the auto-multiplayer flags (`LOBBY_AUTO_MULTIPLAYER_FREEMODE` and friends) and change their behaviour, but the transition itself is still started by `selector`. No other script starts `MainTransition` by name.

`MainTransition` then raises force cleanup bit 2 (every story controller ends), restarts `InGameHud`, starts `spawn_activities` and the cloud and UGC helpers, and starts `freemode` on the `MP_LAUNCH_SCRIPT` stack (35,250).

**Back to story mode:** `MainTransition` (and `InGameHud`, when the game needs a new session but can't start one) calls `SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME`; when the game was launched straight into Online, `MainTransition` first clears the auto-multiplayer flag. The boot in 3.3 then runs again (**Verified** calls; **Known** that the whole script set restarts, to check by listing running scripts after a round trip).

**Kicks and restarts:** `SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE` is used for something else. `MainTransition` calls it in its two "background script kick" paths (logged as `BG_SCRIPT_KICK`), one of which first sets auto-multiplayer on so the game reloads straight back into Online; `benchmark` uses it to restart after the benchmark run (**Verified**).

## 3.6 Other boot paths

| Path | What changes (**Verified**) |
| --- | --- |
| Benchmark (`-benchmark` command line or the settings menu) | `startup` doesn't commit the auto-Online choice; `standard_global_reg` doesn't start `main_persistent` or enable brain set 1; the `benchmark` script raises force cleanup 8 and 64 |
| Rockstar Editor replay | When the replay system asks for a script cleanup, `main` raises force cleanup 8, 64 and 1, deletes trains, blocks invites and reports back that scripts are clean |
| Director mode | `main` starts `director_mode` on the `MISSION` stack after a fade; `director_mode` raises bit 128 when ready |

## 3.7 What this means for modders

- **Mods start late, and that's fine.** By the time any SHVDN or Lua script runs, `startup` has ended and `main_persistent` and `main` are running. A mod that needs story state should still wait until `initial` has ended (`GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH` of `initial` is 0), as `main` does.
- **Mods load before the player can move.** About 14 s on a low-end test PC. Heavy constructors stretch this; keep constructors light and do setup on the first ticks.
- **An offline Online mode has to choose its boot path.** The Rockstar path goes `selector` → `MainTransition` → `freemode` with force cleanup 2. The alternative some mods use is calling the enter-MP native from story mode, which freezes the game for 1 to 22 s ([script VM](/scripting/script-vm.md)). This guide shows which boot steps such a mode has to reproduce and which it can skip.
- **The way back restarts story mode.** Anything mods keep in memory is lost when Online returns to story mode, so state must be saved to file before the transition.
- **The story save is fixed-size.** 38,592 values in one block, plus small blocks reserved for DLC. Mods keep their own save files rather than writing into it (R1.7).

## 3.8 Test cards

1. **Script list at boot.** List the running Rockstar script threads once the player can move (a small SHVDN script can do it; [script VM](/scripting/script-vm.md) section 2.9). Expected: `main`, `main_persistent`, `selector`, `ingamehud`, `cellphone_controller`, `shop_controller`, `flow_controller`, one `mission_triggerer_*`; not `startup`, `initial` or `standard_global_reg`.
2. **Round trip.** If a launch goes to Online and back (an offline-Online mod or the character wheel), compare the script lists before and after.

## 3.9 Open questions

| Question | Where it goes |
| --- | --- |
| Which level index 5 is | R1.6 or R4.6 |
| The exact path from a new game to `prologue1` | Partly answered: it is strand 27, switched on at a new game ([core guide 2](/docs/gameplay/missions/story-flow.md#25-the-32-strands)); the switch itself is R5.2 |
| What the numbers in the story mission table mean | Answered in [core guide 2](/docs/gameplay/missions/story-flow.md#22-the-mission-table) |
| Whether the return to story mode restarts every script (test card 2) | R7.2 |
