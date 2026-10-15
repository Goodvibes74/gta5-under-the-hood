# Replay, director mode and the Rockstar Editor

Three systems that share the word "replay" and are easy to mix up: the **mission replay** (`replay_controller`: the fail screen, retry and skip), the **clip recorder** behind the Rockstar Editor (engine-side; scripts only mark moments and block recording), and **director mode** (`director_mode`: play as any actor, set the weather and time, travel to 27 preset locations, then record). Roadmap topic **R5.8** in the [roadmap](/ROADMAP.md). Builds on [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) (the retry screen in detail) and [runtime scripts](/docs/core/runtime-scripts.md) (how `director_mode` is started).

**How it was made.** Read in the build-3725 decompile (commit `6c18d3e8b`): `replay_controller` (112,112 lines) and `director_mode` (172,346 lines); the labels they use were looked up in the American `global.gxt2`. Native use from the [RECORDING](/scripting/native-usage/RECORDING.md) and [REPLAY](/scripting/native-usage/REPLAY.md) usage pages; the arguments scripts pass to `REPLAY_RECORD_BACK_FOR_TIME` and `REPLAY_START_EVENT` counted with one `git grep -o`. Build 1.0.3725.0 Legacy. Counts and script behaviour are **Verified**; the editor's internals and the community patch are **Known**.

## Short version

- **`replay_controller` is the mission replay, not the Rockstar Editor.** Its labels are the fail screen's (`REPLAY_RETRY`, `REPLAY_RESTART`, `REPLAY_SKIPS`, `REPLAY_SKIPM`, `REPLAY_EXIT`, `REPLAY_AYS` "are you sure") and it owns the replay state global described in [mission anatomy](/docs/gameplay/missions/mission-anatomy.md). Most of its 112,000 lines are shared helper code for outfits and tattoos that it uses to restore the player's look on a retry.
- **Clip recording is the engine's.** Only `selector` (the character wheel script; **Known**: it also handles the record controls) starts, saves or cancels a recording: `START_REPLAY_RECORDING`, `SAVE_REPLAY_RECORDING`, `CANCEL_REPLAY_RECORDING`, one script each.
- **Missions mark and protect moments.** `REPLAY_RECORD_BACK_FOR_TIME` (126 scripts, 1,246 calls) saves the last few seconds as an automatic clip at a big moment, most often 5 s back and 5 s ahead (86 calls); `REPLAY_START_EVENT` / `REPLAY_STOP_EVENT` (107 / 110 scripts) mark a set piece; `REPLAY_PREVENT_RECORDING_THIS_FRAME` (276 scripts) blocks recording during menus, the phone camera and some cutscenes; `STOP_REPLAY_RECORDING` (143 scripts) ends a recording when a mission starts.
- **Director mode is a story-mode script** started on the mission stack. It offers actors in groups, a shortlist, gender, outfits and props, vehicles, weapons, weather and time, and **quick travel to 27 preset places** (`LS International Airport`, `Fort Zancudo`, `Mt. Gordo` ...) plus 2 user locations.
- **Director mode has rules, written as warnings:** no shortlist selection in water, airborne, in a vehicle, in a train, while being arrested, while recording, or in the prison (`CM_WARN01` to `07`); no travel while arrested, recording, in a vehicle or in the air (`CM_WWARN*`); no vehicles in water (`CM_GARWATER`).
- **Director mode opens the editor itself:** its menu calls `ACTIVATE_ROCKSTAR_EDITOR(3)` after making the player invincible; the pause menu's editor entry comes through `maintransition` (the only other caller).
- **NoEditorRestrictions** is a community patch that lifts the editor's built-in limits (**Known**: chiefly how far the free camera may move from the player). It changes the executable, not these scripts; nothing in the decompile refers to it.

## The mission replay (`replay_controller`)

**Verified:** the fail screen and its choices are covered step by step in [mission anatomy, 3.6](/docs/gameplay/missions/mission-anatomy.md). What this page adds:

- **Labels:** `REPLAY_RETRY`, `REPLAY_RESTART`, `REPLAY_SKIPS` (skip a section), `REPLAY_SKIPM` (skip the mission), `REPLAY_SKIP_S`, `REPLAY_SKIP_M`, `REPLAY_EXIT`, `REPLAY_AYS`, `REPLAY_YES`, `REPLAY_NO`, `REPLAY_OK`, `REPLAY_REJ`, `REPLAY_T`, `REPLAY_TMG`, and the audio scene `REPLAY_SCREEN_SCENE`.
- **Force cleanup:** on force cleanup it resets its state for causes 16 and 64 and runs its cleanup for causes 2 and 32 ([script VM](/scripting/script-vm.md) explains the causes).
- **Restoring the player:** on a retry it puts the player's outfit, props and tattoos back as they were at the checkpoint, which is why it carries the shop and apparel helpers (`DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG` 1,723 calls, `ADD_PED_DECORATION_FROM_HASHES` 194).
- **The pause-menu "Replay Mission"** is a third path: `pausemenu_sp_repeat` calls `REPLAY_CONTROL_SHUTDOWN` and `mission_repeat_controller` calls `SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE`; **Known:** together they run the chosen mission again from the start and put the save back afterwards.

## The clip recorder

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `REPLAY_PREVENT_RECORDING_THIS_FRAME` | 276 | 329 | No recording this frame (menus, phone camera, loading) |
| `REPLAY_CHECK_FOR_EVENT_THIS_FRAME` | 170 | 218 | Tell the recorder a named moment is happening |
| `IS_REPLAY_RECORDING` | 153 | 217 | Is a clip being recorded (director mode refuses some actions then) |
| `STOP_REPLAY_RECORDING` | 143 | 144 | End a recording (mission starts) |
| `REPLAY_RECORD_BACK_FOR_TIME` | 126 | 1,246 | Save an automatic clip around a big moment |
| `REPLAY_DISABLE_CAMERA_MOVEMENT_THIS_FRAME` | 113 | 234 | Lock the editor camera for this part of the clip |
| `REPLAY_START_EVENT` / `REPLAY_STOP_EVENT` | 107 / 110 | 364 / 424 | Bracket a set piece |
| `RECORD_GREATEST_MOMENT` | 16 | 29 | Online and car-mod highlights |
| `REPLAY_CANCEL_EVENT` | 13 | 27 | Drop a marked event |
| `START_REPLAY_RECORDING`, `SAVE_REPLAY_RECORDING`, `CANCEL_REPLAY_RECORDING`, `IS_REPLAY_AVAILABLE`, `IS_REPLAY_INITIALIZED`, `IS_REPLAY_RECORD_SPACE_AVAILABLE` | 1 each | | Only `selector` |
| `ACTIVATE_ROCKSTAR_EDITOR` | 2 | 2 | `director_mode`, `maintransition` |
| `REGISTER_EFFECT_FOR_REPLAY_EDITOR` | 1 | 10 | `startup` registers 10 post effects the editor may use |
| `REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP`, `SET_SCRIPTS_HAVE_CLEANED_UP_FOR_REPLAY_SYSTEM` | 6, 1 | 10, 1 | Scripts tidy up before the editor takes over (`main`, the taxi and friend scripts) |

**Verified (arguments):** `REPLAY_RECORD_BACK_FOR_TIME(back, forward, type)` is called most often with 5 s back and 5 s forward (86 calls), 3 and 2 (60), 5 and 10 (46), 3 and 5 (44), 0 and 10 (40). `REPLAY_START_EVENT` takes a type: 4 (274 calls), 1 (50), 3 (35), 0 (5). **Known:** these become the "Action Replay" and mission clips the editor offers without the player pressing record.

**Known (engine):** recording keeps a rolling buffer of the world's state (entity positions, animations, effects, sounds), not video; the editor replays it through the replay director and its cameras ([cameras](/docs/rendering/cameras.md)). Scripts don't run during playback, which is why the game asks scripts to clean up first.

## Director mode (`director_mode`)

**Verified:**

- **Start:** launched on the `MISSION` stack after a fade, with the player invincible and frozen while it loads ([runtime scripts](/docs/core/runtime-scripts.md)); it calls 1,049 different natives.
- **Menus (labels):** actor categories and the shortlist (`CM_BOOD` "Switch Actor", `CM_GEN` "Gender"), props and outfits, vehicles (`CM_VEHOPT`), weapons, settings, locations (`CM_LOCDE01` "Quick travel to a pre-defined location."), and the button to open the editor.
- **Locations:** `CM_LOC_0` and `CM_LOC_1` are the two user locations; `CM_LOC_2` to `CM_LOC_28` are LS International Airport, Docks, LS Downtown, Del Perro Pier, Vinewood Hills, Wind Farm, Sandy Shores, Stab City, Fort Zancudo, Canyon, Cable Car, Paleto Bay, The Lighthouse, Vineyard, Richards Majestic Studio, Golf Club, Altruist Camp, Power Station, Saw Mill, Quarry Pit, Dam, Storm Drain, Observatory, Radio Telescope Array, LSU, Cove and Mt. Gordo.
- **Rules:** the warnings above, plus `CM_DISABLEDE1` "Option is disabled for this actor." and `CM_DISABLEDE2` "Option is currently disabled." for options that don't fit the current actor or state.
- **World state:** it saves and restores the weather (`SET_CURR_WEATHER_STATE`, [time and weather](/docs/world/time-and-weather.md)), overrides the sea (`WATER_OVERRIDE_SET_*`) and switches all vehicle generators (`SET_ALL_VEHICLE_GENERATORS_ACTIVE`).

## What this means for modders

- **Let your mod's moments be recorded:** call `REPLAY_RECORD_BACK_FOR_TIME(5.0, 5.0, 4)` at a big moment, like Rockstar's missions, or bracket a sequence with `REPLAY_START_EVENT(4)` and `REPLAY_STOP_EVENT()`.
- **Keep your menus out of clips** with `REPLAY_PREVENT_RECORDING_THIS_FRAME()` every frame while a menu or a debug overlay is up.
- **Expect cleanup requests:** before the editor opens, scripts may be asked to clean up (`REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP`); a mod that keeps entities alive should release them then.
- **Don't drive `replay_controller`'s state** from a mod mission; keep your own retry logic ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).
- **Patches like NoEditorRestrictions** change the executable and break on game updates; link to their author's page rather than shipping them, and check them after every update ([surviving updates](/docs/core/surviving-updates.md)).
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| What exactly NoEditorRestrictions patches, and the vanilla limits it lifts (free camera distance, restricted areas) | Second pass with the executable; test card 3 |
| The meaning of `replay_controller` states 1 to 6 and 11 to 13 | Second pass (also open in mission anatomy) |
| The `REPLAY_START_EVENT` and `REPLAY_RECORD_BACK_FOR_TIME` type numbers | Second pass |
| Where director mode's restricted places (the prison and others) are defined | Second pass: the area checks in `director_mode` |
| The 10 post effects `startup` registers for the editor | R13.2 second pass |

## Test cards

1. **Automatic clip.** Call `REPLAY_RECORD_BACK_FOR_TIME(5.0, 5.0, 4)` after an explosion, then open the Rockstar Editor. Expected: a 10-second clip around the explosion.
2. **Blocked recording.** Start recording, then call `REPLAY_PREVENT_RECORDING_THIS_FRAME` every frame for 5 s. Expected: a gap in the clip.
3. **Editor limits.** In the editor's free camera, fly away from the player until it stops; note the distance, with and without the community patch.
4. **Director rules.** In director mode, open the shortlist while swimming. Expected: "Unable to select from shortlist while in water."
