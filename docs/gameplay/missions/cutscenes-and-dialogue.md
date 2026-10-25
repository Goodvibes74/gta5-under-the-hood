# Cutscenes and dialogue

How GTA V loads, stages, plays, skips and cleans up its motion-capture cutscenes, how scripts dress the actors and hand them back afterwards, how Online cutscenes put the player's own character in, and how scripted conversations are built and played by one central script. Roadmap topic **R5.6** in the [roadmap](/ROADMAP.md). Builds on [guide 3](/docs/gameplay/missions/mission-anatomy.md) (where cutscenes sit in a mission).

**How it was made.** Counted across the build-3725 decompile (all 1,145 scripts); one complete cutscene traced in `armenian1` (its intro, showroom and ending cutscenes); `dialogue_handler` read for conversations. Counts are **Verified**; what a flag value means is **Known** (community names) unless the scripts make it clear.

## 6.1 Short version

- **420 scripts play cutscenes** through 54 different `CUTSCENE` natives. At least 289 cutscenes are requested by a literal name (`armenian_1_int`, `mp_intro_mcs_8_a1`); many more are built from variables (`mp_intro_mcs_10_a` + a number).
- **The sequence is always the same:** request → dress the actors while assets load → wait for `HAS_CUTSCENE_LOADED` → register the script's entities under the cutscene's handle names → `START_CUTSCENE` → watch the time for scripted beats and `WAS_CUTSCENE_SKIPPED` → take each actor and the camera back with the **exit states** → `REMOVE_CUTSCENE`.
- **Actors are dressed, not swapped.** Before the cutscene loads, scripts call `SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED` (527 calls) or set each component (819 calls) and prop (306) by handle, inside a `CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY` window (652 calls). That is how Lamar wears his current clothes in the cutscene.
- **Exit states hand control back.** `CAN_SET_EXIT_STATE_FOR_REGISTERED_ENTITY` (1,116 calls) becomes true for one actor at the moment the cutscene releases it; the script then gives it a task, puts it in a car or freezes it. `CAN_SET_EXIT_STATE_FOR_CAMERA` (225) is the moment to restore the gameplay camera. This is how cutscenes blend into play without a fade.
- **Online cutscenes use the handles `MP_1` to `MP_4`** for the players (564 registrations of `MP_1` alone) and `MP_Male_Character` / `MP_Female_Character` for gender-specific scenes, wrapped in `NETWORK_SET_IN_MP_CUTSCENE` (4,845 calls) and `SET_NETWORK_CUTSCENE_ENTITIES` (816).
- **Every scripted conversation is built by one script, `dialogue_handler`.** Mission scripts only fill in a request (the conversation root, the speakers and their voices) and check `IS_SCRIPTED_CONVERSATION_ONGOING` (2,507 calls); `dialogue_handler` loads the text block, looks up up to 70 lines (`<root>_1A`, `<root>_2A` ...), and plays them. Of all 1,145 scripts, only `dialogue_handler` and `nigel3` ever call `CREATE_NEW_SCRIPTED_CONVERSATION`.

## 6.2 The natives that matter

Most used (**Verified** call counts):

| Native | Calls | Role |
| --- | --- | --- |
| `IS_CUTSCENE_PLAYING` / `IS_CUTSCENE_ACTIVE` | 3,182 / 1,290 | Guards (active covers loading and the exit) |
| `REGISTER_ENTITY_FOR_CUTSCENE` | 2,344 | Give a script entity to the cutscene under a handle name |
| `CAN_SET_EXIT_STATE_FOR_REGISTERED_ENTITY` | 1,116 | The cutscene has released this actor |
| `HAS_CUTSCENE_LOADED` / `HAS_THIS_CUTSCENE_LOADED` | 934 / 101 | Ready to start |
| `REMOVE_CUTSCENE` | 838 | Unload |
| `GET_CUTSCENE_TIME` | 830 | Time beats inside the cutscene (milliseconds) |
| `SET_CUTSCENE_PED_COMPONENT_VARIATION` / `_FROM_PED` / `SET_CUTSCENE_PED_PROP_VARIATION` | 819 / 527 / 306 | Dress the actors |
| `REQUEST_CUTSCENE` / `REQUEST_CUTSCENE_WITH_PLAYBACK_LIST` | 802 / 245 | Load all, or only some sections |
| `START_CUTSCENE` / `START_CUTSCENE_AT_COORDS` | 724 / 56 | Play (at its own position, or moved) |
| `CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY` | 652 | The window in which dressing calls are accepted |
| `SET_CUTSCENE_MULTIHEAD_FADE` / `IS_MULTIHEAD_FADE_UP` | 602 / 601 | Fades on multi-monitor setups |
| `GET_ENTITY_INDEX_OF_REGISTERED_ENTITY` / `GET_ENTITY_INDEX_OF_CUTSCENE_ENTITY` | 550 / 257 | Grab an entity the cutscene created |
| `SET_CUTSCENE_ENTITY_STREAMING_FLAGS` | 415 | Ask the cutscene to stream an actor's model early |
| `GET_CUTSCENE_TOTAL_DURATION` / `GET_CUTSCENE_END_TIME` | 294 / 47 | |
| `STOP_CUTSCENE` / `STOP_CUTSCENE_IMMEDIATELY` | 233 / 132 | End early (failure, skip, restart) |
| `CAN_SET_EXIT_STATE_FOR_CAMERA` | 225 | The cutscene has released the camera |
| `HAS_CUTSCENE_FINISHED` | 209 | |
| `WAS_CUTSCENE_SKIPPED` | 195 | The player skipped it |
| `SET_CUTSCENE_FADE_VALUES` | 183 | Which fades the cutscene does by itself (in and out, on skip) |
| `SET_CUTSCENE_ORIGIN` / `_AND_ORIENTATION` | 82 / 27 | Play a cutscene somewhere else (reused scenes) |
| `SET_CUTSCENE_CAN_BE_SKIPPED` | 42 | |

## 6.3 The sequence, step by step

From `armenian1` and the patterns across all scripts (**Verified**):

1. **Request.** `REQUEST_CUTSCENE(name, 8)`: the flag `8` is used in 963 of about 1,050 requests (**Known**: "play with the default fade"). `REQUEST_CUTSCENE_WITH_PLAYBACK_LIST(name, sections, 8)` loads only some sections of a long cutscene; the most common masks are 14, 2, 6, 5 and 3 (bit 0 is the first section). A mod that wants only part of a "concat" cutscene (several scenes joined, like `arm_1_mcs_2_concat` or `mp_intro_concat`) uses this.
2. **Dress the actors while it loads.** Each frame, while `CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY()` is true, set each actor's look by handle name: from a live ped (`SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED("Lamar", lamarPed, 0)`), or component by component for actors that don't exist yet. Optionally `SET_CUTSCENE_ENTITY_STREAMING_FLAGS` so the model streams in early.
3. **Wait until loaded.** `HAS_CUTSCENE_LOADED()`. On PC, `armenian1` uses a helper that also notes when loading was not instant, and also waits for any conversation to end first (a cutscene never starts over dialogue).
4. **Register the script's entities** with `REGISTER_ENTITY_FOR_CUTSCENE(entity, handle, mode, model, flags)`. The modes seen: `0` (1,418 calls: animate this existing entity), `1` (117: the cutscene creates the entity, so pass 0 and the model) and `3` (113: keep the entity but leave it out of the cutscene, used to hide what shouldn't be seen) (**Known** names). The last argument is `0` (1,522) or `64` (756); `64` is used for the player and crew (**Known**: "don't let the cutscene delete it"). Props (doors, a shirt, a gate) are registered the same way as peds and cars.
5. **Start.** `START_CUTSCENE(0)` in 586 calls; `2048` (48), `256` (12), `1024` (6) and `4` (8) are other flag sets (**Known** meanings vary; one keeps the player's weapon hidden, one keeps the vehicle). `START_CUTSCENE_AT_COORDS` plays a cutscene at a new place (the Online first-death beach scene).
6. **While it plays.** The mission's stage function runs every frame: beats keyed to `GET_CUTSCENE_TIME()` (in `armenian1`'s ending: 21.5 s and 26.7 s trigger set dressing), `SET_CAN_DISPLAY_MINIMAP_DURING_CUTSCENE_THIS_UPDATE` for the radar, and `WAS_CUTSCENE_SKIPPED()`, which in a mission moves the stage to its skip step ([guide 3](/docs/gameplay/missions/mission-anatomy.md#35-stages-and-steps)) and sets `SET_CUTSCENE_FADE_VALUES(false, false, false, false)` so the script controls the fade.
7. **Exit states.** As each actor's last shot ends, `CAN_SET_EXIT_STATE_FOR_REGISTERED_ENTITY(handle, model)` turns true once; the script gives that actor its next task right then (Lamar walks to the car, the closet doors freeze), and `CAN_SET_EXIT_STATE_FOR_CAMERA` is when the gameplay camera is set behind the player. Done right, play resumes mid-motion with no fade.
8. **Remove.** `REMOVE_CUTSCENE()` once it has finished, and release the models.

## 6.4 Online cutscenes and the player's character

- **Handles.** Online cutscenes have actor slots named `MP_1` to `MP_4` for up to four players, plus scene-specific names (`MP_Lamar_Car`, `MP_Plane`, `MP_Car_generic`) and gender-specific scenes with `MP_Male_Character` / `MP_Female_Character` (**Verified** handle counts in 6.1).
- **Dressing the freemode character.** The player's customised freemode ped is dressed for the cutscene with `SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED("MP_1", PLAYER_PED_ID(), model)` in the asset window, then registered with mode 0 and flags 64.
- **Network side.** `NETWORK_SET_IN_MP_CUTSCENE(true, ...)` before and `false` after (4,845 calls); `SET_NETWORK_CUTSCENE_ENTITIES(true)` so cutscene-created entities are networked (816); `NETWORK_IS_IN_MP_CUTSCENE` is checked 17,147 times, mostly by systems that must pause during cutscenes (HUD, events, spawning).

## 6.5 Dialogue

**One script plays every conversation.** `dialogue_handler` (5,185 lines, always running) is where every scripted conversation is created (**Verified**: `CREATE_NEW_SCRIPTED_CONVERSATION` appears only in `dialogue_handler` and `nigel3`). The flow (**Verified** from `dialogue_handler` and `armenian1`):

1. A mission sets up speakers in a small structure: speaker index, ped, voice name (`armenian1` adds Franklin as speaker 0 with voice `"FRANKLIN"` at start-up).
2. It asks for a conversation by **text block and root**, for example block `ARM1AUD` and a root label, through a shared helper that writes the request into `dialogue_handler`'s globals.
3. `dialogue_handler` loads the text block into an additional-text slot (6, or 14 and 15 for DLC text), then builds the conversation: for line numbers 1 to 70 it checks that the label `<root>_<n>A` exists, gets the audio file with `GET_FILENAME_FOR_AUDIO_CONVERSATION`, and adds the line with its speaker. Phone calls go through the same path (the `CELL_*` labels).
4. The mission only watches `IS_SCRIPTED_CONVERSATION_ONGOING` (2,507 calls) and stops or pauses with `STOP_SCRIPTED_CONVERSATION` (3,942) and `RESTART_SCRIPTED_CONVERSATION` (1,040).

**Ambient speech** is separate: one-off lines from any ped with `PLAY_PED_AMBIENT_SPEECH_NATIVE` (642) or `_WITH_VOICE_NATIVE` (1,121), using speech names such as `GENERIC_INSULT_HIGH`, `GENERIC_CURSE_MED` and `CAR_CRASHES_01` (all seen in `armenian1`), plus `PLAY_PAIN` (123).

**Subtitles** come with the conversation: the line text is the label itself, so a conversation and its subtitles can't drift apart.

### Subtitles and phone calls (second pass)

*Second pass (2026-10-25).* Read in `dialogue_handler` and `armenian1` (commit `6c18d3e8b`; global and function names are build-specific pointers). **Verified** unless marked.

**Two switches decide whether a line is shown.** The player's setting is `PREF_SUBTITLES` ("Subtitles", on the Display page of the settings, [pause menu](/docs/ui/pause-menu.md)); the engine applies it to every conversation (**Known**). Each request also carries its own two flags: show subtitles, and add the lines to the Brief page's dialogue history. Every script that talks has the same small helper (`func_360` in `armenian1`) that writes the request: it copies the mission's speaker list, a fixed number (145), the text block name, the two flags (passed in as "off" switches, so 0 means show and 0 means add to the brief) and one more flag. `dialogue_handler` copies the flags into the conversation it builds and passes them to `START_SCRIPT_CONVERSATION` (show subtitles, add to brief, and two more flags; NativeDB names them clone and interruptible, **Known**). So a mission can play a line with no subtitle at all, whatever the setting.

**Missions read the setting to keep the screen tidy.** `IS_SUBTITLE_PREFERENCE_SWITCHED_ON` is called 381 times in 86 scripts. In `armenian1` it sits in the check that decides whether an objective may be printed now: with subtitles on, the objective waits until no message is on screen and the current conversation has finished, so the two never overlap at the bottom of the screen; with subtitles off it can print over speech.

**Phone calls take the same road with a different start.** A call is built in `dialogue_handler` like any conversation (same request globals, same lines from `<root>_<n>A` labels, same speakers), then preloaded with `PRELOAD_SCRIPT_PHONE_CONVERSATION` and started with `START_SCRIPT_PHONE_CONVERSATION`, which takes only the two flags (show subtitles, add to brief). Face-to-face lines use `PRELOAD_SCRIPT_CONVERSATION` / `START_SCRIPT_CONVERSATION`. That one choice is what makes a call sound like a call (the phone filter and the phone on screen are the engine's side, **Known**). Missions check `IS_MOBILE_PHONE_CALL_ONGOING` (821 scripts, 1,920 calls) before starting anything that would talk over a call.

**The request globals** (question GP-007, the parts read here): the copy of the speaker list, the block name (24 characters), the two display flags with their "off" twins, the extra flag, and the root and a priority (clamped so that 8 to 11 become 7), which the helper hands to the queueing function. `dialogue_handler` keeps the built conversation in one block (`Global_22602` in this build), whose fields 368 to 370 hold the three flags and whose lines and speakers sit in arrays of six values each. Field-by-field naming of the rest is left to the global map (R0.4).

## 6.6 What this means for modders

- **Copy the sequence, including exit states.** A mod cutscene that fades out, plays and fades in works, but the seamless version is: dress in the asset window, register, start, and use `CAN_SET_EXIT_STATE_FOR_REGISTERED_ENTITY` and `CAN_SET_EXIT_STATE_FOR_CAMERA` to hand each actor and the camera back mid-motion.
- **Dress the player with natives, not memory.** Rockstar puts a customised freemode ped into `MP_1` with `SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED` during `CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY`. Some mods instead swap the player's model hash in memory at fixed offsets so the cutscene accepts the freemode ped; that breaks on any game update (R11.5), and the native route makes it unnecessary.
- **Load only what you play.** `REQUEST_CUTSCENE_WITH_PLAYBACK_LIST` with a section mask (for example masks 31 and 103 for different parts of `mp_intro_concat`) cuts load time on long concat cutscenes.
- **Never start a cutscene over dialogue.** Wait for `IS_SCRIPTED_CONVERSATION_ONGOING()` to be false first, as the missions do.
- **Conversations: ask, don't build.** A mod can play Rockstar's own dialogue by building a conversation from an existing text block and root (labels `<root>_1A` ...), or play single ambient lines on any ped, without shipping audio.
- **Pause ambient systems during cutscenes.** Zombie, gang and police mods should check `IS_CUTSCENE_ACTIVE()` (and `NETWORK_IS_IN_MP_CUTSCENE()` in Online mode) and stop spawning, as Rockstar's systems do 17,000 times over.

## 6.7 Open questions

| Question | Where it goes |
| --- | --- |
| How many cutscene files ship (`.cut` in the `x64` archives and DLC packs) and how they are organised | R0.7 atlas, R13.4 animation |
| Exact meanings of the `START_CUTSCENE` and `REGISTER_ENTITY_FOR_CUTSCENE` flag bits | Second pass, in-game tests |
| The layout of `dialogue_handler`'s request globals (speakers, root, block, flags) | Partly answered in [6.5](#subtitles-and-phone-calls-second-pass) (the flags, block, root and priority); the rest of the conversation block is R0.4 |

Answered in the second pass: how subtitles are hidden or shown, and how phone calls differ from face-to-face lines ([6.5](#subtitles-and-phone-calls-second-pass)).
