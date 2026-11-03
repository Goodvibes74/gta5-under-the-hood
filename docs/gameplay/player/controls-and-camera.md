# Controls and camera

How input reaches the game: the control actions (`INPUT_*`) and their IDs, where keyboard, mouse and pad bindings are defined, the three control groups, how Rockstar's scripts disable, check and claim controls every frame, and how the camera view mode (first person and the third-person distances) is read and forced. Roadmap topic **R6.4** in the [roadmap](/ROADMAP.md). Builds on [key codes and control IDs](/docs/gameplay/player/keycodes-and-controls.md) (the numbers mods use for keys and buttons) and [native usage](/scripting/native-usage.md). Script cameras, shakes and the director system are R13.5.

**How it was made.** Every file in the vanilla archives was listed with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and the control files read: `common:/data/control/*.meta` (base and update copies) and `update:/x64/data/control/` (bindings, keyboard layouts, mouse settings). Every call of the `PAD` natives that take a control group and a control ID was collected with one `git grep -o` over the decompile (commit `6c18d3e8b`; 663,645 call sites with literal numbers) and counted per control and per script. Control names in the first pass came from the `GTA.Control` enum in ScriptHookVDotNet 3 (read from its assembly's metadata; it names IDs 0 to 364). The second pass found that this list no longer matches build 3725's scripts above ID 256 and renamed those rows (see [the numbering changed in build 3717](#the-numbering-changed-in-build-3717-second-pass)). Native use from the [PAD](/scripting/native-usage/PAD.md) and [CAMERA](/scripting/native-usage/CAMERA.md) usage pages. Build 1.0.3725.0 Legacy. Counts are **Verified**; how the input system works inside is **Known** unless stated.

## Short version

- **Controls are actions, not keys.** A script asks about `INPUT_ATTACK` (ID 24), not the left mouse button or RT. The bindings file maps keys and buttons to actions; `update:/x64/data/control/default.meta` binds 192 different `INPUT_*` actions for keyboard and mouse.
- **The IDs run 0 to 401, and from 257 up they changed in build 3717.** Rockstar inserted the 37 `INPUT_CREATOR_*` controls at 257 to 293, so every older control from `INPUT_ATTACK2` (was 257, now 294) to `INPUT_VEH_SHIFT_GEAR_DOWN` (was 364, now 401) moved up by 37. ScriptHookVDotNet 3, FiveM's control list and older trainers use the old numbers (**Verified** in the scripts, second pass).
- **Three control groups:** 0 the player (616,769 of the literal calls), 2 the frontend and menus (46,262), 1 the camera (614).
- **Disabling is the main use.** `DISABLE_CONTROL_ACTION` is in 706 scripts with 601,543 calls, more than every other `PAD` native together. It has to be called every frame. Scripts disable 258 different controls; the most widely disabled are light melee (`MeleeAttackLight`, 527 scripts), the vehicle cinematic camera (507), the weapon wheel (`SelectWeapon`, 503), vehicle weapons (`VehicleAttack`, `VehicleAttack2`, `VehicleAim`, about 495 each), leaving a vehicle (488), heavy melee (484), attack (453), jump (438) and aim (432).
- **Checking is mostly the context button and menu keys:** `IS_CONTROL_JUST_PRESSED` on `Context` (E / D-pad right, 331 scripts), brake and accelerate (267, 255), `ContextSecondary` (254), `FrontendAccept` and `FrontendCancel` (250, 209), the cursor buttons (157, 151) and `SkipCutscene` (155).
- **Claiming a control:** `SET_INPUT_EXCLUSIVE` (404 scripts, 13,486 calls) makes a control count only for the script that claims it this frame, so menus and minigames don't trigger game actions.
- **Keyboard and pad differ:** `IS_USING_KEYBOARD_AND_MOUSE` is in 519 scripts; scripts swap button prompts with `GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING` (379) and switch to PC layouts with `INIT_PC_SCRIPTED_CONTROLS` (69).
- **View modes are per context.** `GET_CAM_VIEW_MODE_FOR_CONTEXT` (609 scripts) and `SET_CAM_VIEW_MODE_FOR_CONTEXT` (415) read and force first person or a third-person distance for on foot, car, bike, boat, aircraft, heli and sub.

## Where it lives

| Files | What they hold | Count (build 3725) |
| --- | --- | --- |
| `common:/data/control/*.meta` | Pad layouts: `standard`, `southpaw`, `trigger_swap` and their first-person, third-person, alternate and scripted variants; accept/cancel and duck/handbrake swaps; `gestures`, `common`, `settings` | 27 in `common.rpf`, 23 replaced or added by `update.rpf` |
| `update:/x64/data/control/default.meta` | Keyboard and mouse bindings (`INPUT_NEXT_CAMERA` to `KEY_V` ...) | 192 actions bound |
| `update:/x64/data/control/keyboard layout/*.meta` | Per-language keyboard layouts (`en`, `en-gb`, `de`, `fr`, `es`, `es-mx`, `it`, `pl`, `pt`, `pt-pt`, `ru`, `ja`, `ko`, `zh`) | 14 |
| `update:/x64/data/control/` (others) | `dynamic`, `fixed`, `gamepad`, `settings`, `standard_mouse`, mouse steering and flying presets (`mouse_vehicle_car_scaled`, `inverted_mouse_vehicle_fly_*` ...) | 11 more |
| `common:/data/ui/controls.xml` | The controls list the settings menu shows (**Known**) | 1 |
| The player's own bindings | Saved in the game's settings outside the archives (**Known**) | |

**Known (engine):** the game reads the pad layout the player chose (standard, southpaw, trigger swap) from these files, then the player's own keyboard rebindings on top; each action has one or more sources (`IOMS_KEYBOARD`, `IOMS_MOUSE_WHEEL`, `IOMS_PAD_*` ...).

## How scripts use controls

### The PAD natives

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `DISABLE_CONTROL_ACTION` | 706 | 601,543 | Turn an action off for this frame |
| `IS_CONTROL_JUST_PRESSED` / `IS_CONTROL_PRESSED` / `IS_CONTROL_JUST_RELEASED` | 640 / 588 / 348 | 14,168 / 11,289 / 1,961 | Read an enabled action |
| `IS_DISABLED_CONTROL_PRESSED` / `_JUST_PRESSED` / `_JUST_RELEASED` | 517 / 432 / 375 | 5,578 / 3,531 / 1,187 | Read an action the script has disabled (so the game ignores it but the script still sees it) |
| `IS_USING_KEYBOARD_AND_MOUSE` | 519 | 6,293 | Which prompts and layout to use |
| `SET_INPUT_EXCLUSIVE` | 404 | 13,486 | Claim an action for this script this frame |
| `GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING`, `GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING` | 379, 256 | 4,166, 643 | The button icon for a prompt |
| `GET_CONTROL_NORMAL`, `GET_DISABLED_CONTROL_NORMAL`, `GET_DISABLED_CONTROL_UNBOUND_NORMAL`, `GET_CONTROL_VALUE` | 305, 228, 321, 323 | | Analogue values (sticks, triggers, mouse) |
| `HAVE_CONTROLS_CHANGED` | 301 | 814 | The player switched between pad and keyboard |
| `ENABLE_CONTROL_ACTION` | 209 | 7,657 | Turn one back on after `DISABLE_ALL_CONTROL_ACTIONS` |
| `DISABLE_ALL_CONTROL_ACTIONS` / `ENABLE_ALL_CONTROL_ACTIONS` | 161 / 52 | 312 / 93 | Everything off for a group (cutscenes, menus) |
| `SET_CONTROL_SHAKE`, `STOP_CONTROL_SHAKE` | 181, 270 | 739, 341 | Pad vibration |
| `INIT_PC_SCRIPTED_CONTROLS` / `SHUTDOWN_PC_SCRIPTED_CONTROLS` | 69 / 69 | 78 / 90 | Load a PC layout for a minigame or vehicle (the `*_scripted.meta` files) |
| `SET_CONTROL_VALUE_NEXT_FRAME` | 99 | 309 | Fake an input (rare; tutorials, assisted moves) |
| `SET_CONTROL_LIGHT_EFFECT_COLOR` | 17 | 64 | The PS4 light bar |

### What scripts disable

Literal control IDs passed to `DISABLE_CONTROL_ACTION` (scripts that disable each; 258 distinct controls):

| ID | Control | Scripts | Calls |
| ---: | --- | ---: | ---: |
| 140 | `MeleeAttackLight` | 527 | 13,886 |
| 80 | `VehicleCinCam` | 507 | 1,796 |
| 37 | `SelectWeapon` (weapon wheel) | 503 | 7,889 |
| 69, 70, 68 | `VehicleAttack`, `VehicleAttack2`, `VehicleAim` | 497, 496, 493 | about 13,500 each |
| 75 | `VehicleExit` | 488 | 12,878 |
| 141 | `MeleeAttackHeavy` | 484 | 13,598 |
| 114 | `VehicleFlyAttack` | 476 | 13,592 |
| 74 | `VehicleHeadlight` | 474 | 12,905 |
| 81, 82 | `VehicleNextRadio`, `VehiclePrevRadio` | 467, 467 | about 7,000 each |
| 72, 71 | `VehicleBrake`, `VehicleAccelerate` | 466, 465 | about 2,490 each |
| 24 | `Attack` | 453 | 13,563 |
| 389 | `VEH_FLY_BOOST` (old 352) | 451 | 574 |
| 22 | `Jump` | 438 | 7,130 |
| 294 | `ATTACK2` (old 257; the first pass read this as `ScaledLookLeftOnly`) | 435 | 13,485 |
| 25 | `Aim` | 432 | 13,503 |
| 23 | `Enter` | 407 | 6,825 |
| 200 | `FrontendPauseAlternate` | 363 | 12,551 |
| 142 | `MeleeAttackAlternate` | 361 | 13,434 |

The same handful of controls is disabled in hundreds of scripts with almost the same call count (about 13,500) because Rockstar compiles shared helpers into most scripts; the next section lists them.

### The shared disable helpers (second pass)

**Verified** (second pass): every run of four or more `DISABLE_CONTROL_ACTION` calls in a row was collected from all 1,145 decompiled scripts and identical runs were grouped. Names below are the build-3725 `INPUT_*` names without the prefix; the helper names are ours, since the decompile has none.

| Helper (our name) | Scripts | Copies | What it blocks |
| --- | ---: | ---: | --- |
| Block combat and vehicle weapons | 247 (all Online) | 4,696 | 30 controls: `VEH_HYDRAULICS_CONTROL_TOGGLE`, `WEAPON_SPECIAL`, `WEAPON_SPECIAL_TWO`, `DETONATE`, the five melee attack controls and `MELEE_BLOCK`, `ATTACK`, `ATTACK2`, `AIM`, `VEH_GUN_LEFT/RIGHT/UP/DOWN`, `VEH_ATTACK`, `VEH_ATTACK2`, `VEH_AIM`, `VEH_FLY_ATTACK`, `VEH_SELECT_NEXT/PREV_WEAPON`, `VEH_JUMP`, `VEH_ROCKET_BOOST`, `VEH_BIKE_WINGS`, `VEH_HEADLIGHT`, `VEH_MELEE_HOLD/LEFT/RIGHT` |
| Block weapon selection | the same 247 | 6,425 | `SELECT_WEAPON` (the wheel) and the nine `SELECT_WEAPON_*` category keys |
| Block pause, exit and enter | the same 247 | 989 | `VEH_SHUFFLE`, `FRONTEND_PAUSE_ALTERNATE` (groups 0 and 2), `VEH_EXIT`, `ENTER` |
| Block vehicle movement | 321 (story and Online) | 327 | `VEH_ACCELERATE`, `VEH_BRAKE`, `VEH_HANDBRAKE`, `VEH_DUCK`, `VEH_MOVE_LR`, `VEH_MOVE_UD` |
| Block vehicle extras, flight and sub controls | the same 321 | 321 | 28 controls: horn, headlight, radio, bicycle pedal and brake, every `VEH_FLY_*` control (throttle, roll, pitch, yaw, gear, weapons, targets, VTOL, boost) and every `VEH_SUB_*` control |
| Freeze the player for a lead-in | 85 (story: launchers, strangers, rampages) | 86 | `SPRINT`, `SELECT_WEAPON`, `AIM`, both light and heavy melee, `ATTACK`, `ATTACK2`, `JUMP`, `ENTER` |

The 247 Online scripts use the three combat helpers together (the larger runs are these helpers back to back, with `VEH_ROOF`, `COVER`, `DUCK` and the radio controls added). Copies × length, the first three helpers alone are about 210,000 of the 601,543 disable calls.

**Known:** the phone, the pause menu, the weapon wheel and script menus all want the same buttons. Rockstar's scripts handle it by disabling the game action (`SelectWeapon`, `Phone`, `FrontendPauseAlternate`) while their own UI is up, reading the disabled control with `IS_DISABLED_CONTROL_JUST_PRESSED`, and checking `IS_PAUSE_MENU_ACTIVE` (616 scripts) before acting.

### The numbering changed in build 3717 (second pass)

**Verified** in the decompile history: Rockstar's scripts disable `INPUT_ATTACK2` together with `INPUT_ATTACK` in their combat helpers. `base_heist_seats` passes 257 for it in every sampled build from 2944 to 3586 (2944, 3095, 3407, 3504, 3570, 3586) and 294 in builds 3717 and 3725. In 3725 no script outside the creators uses 257 to 293 any more (below), so all the scripts carry the new numbers.

The new order comes from an engine enum dump of build 3889 (community, **Known**): IDs 0 to 256 are unchanged, 257 to 293 are 37 `INPUT_CREATOR_*` controls the old lists left out, and 294 to 401 are the old 257 to 364. The build-3725 scripts confirm the shift at every point checked (**Verified**):

- The vehicle transform checks (`TRANSFORM_TO_SUBMARINE` / `TRANSFORM_TO_CAR`) read 394 (`VEH_TRANSFORM`, old 357).
- Freemode reads 398 and 399 only while the weapon wheel HUD component (19) is open: `EAT_SNACK` and `USE_ARMOR` (old 361 and 362), Online's snack and armour shortcuts on the wheel.
- IDs 257 to 293 appear only in the six creator scripts (`fm_race_creator`, `fm_deathmatch_creator`, `fm_capture_creator`, `fm_lts_creator`, `fm_survival_creator`, `public_mission_creator`), 6 to 13 calls each (`CREATOR_MENU_DELETE`, `CREATOR_ROTATE_LEFT/RIGHT`, `CREATOR_MENU`).
- The heavily used high IDs are vehicle-weapon controls disabled by the Online combat helper: 319 to 322 (`VEH_GUN_LEFT/RIGHT/UP/DOWN`, about 12,970 calls each), 374 (`VEH_HYDRAULICS_CONTROL_TOGGLE`, 11,981), 382 to 384 (`VEH_MELEE_HOLD/LEFT/RIGHT`, about 13,000), 388 (`VEH_ROCKET_BOOST`, 7,528), 391 (`VEH_BIKE_WINGS`, 5,796).

Controls 365 to 401 in build 3725 (old number in brackets; scripts and calls counted over the `PAD` natives that take a control, so not the shake natives):

| ID | Control | Scripts | Calls |
| ---: | --- | ---: | ---: |
| 365 to 367 | `REPLAY_PREVIEW_AUDIO`, `VEH_DRIVE_LOOK`, `VEH_DRIVE_LOOK2` (328 to 330) | 0 | 0 |
| 368 | `VEH_FLY_ATTACK2` (331) | 12 | 12 |
| 369, 370 | `RADIO_WHEEL_UD`, `RADIO_WHEEL_LR` (332, 333) | 5 | 23 each |
| 371 to 373 | `VEH_SLOWMO_UD`, `VEH_SLOWMO_UP_ONLY`, `VEH_SLOWMO_DOWN_ONLY` (334 to 336) | 0 | 0 |
| 374 | `VEH_HYDRAULICS_CONTROL_TOGGLE` (337) | 250 | 11,981 |
| 375 to 380 | `VEH_HYDRAULICS_CONTROL_LEFT`, `_RIGHT`, `_UP`, `_DOWN`, `_LR`, `_UD` (338 to 343) | 6 to 10 | 6 to 16 |
| 381 | `SWITCH_VISOR` (344) | 4 | 20 |
| 382 to 384 | `VEH_MELEE_HOLD`, `VEH_MELEE_LEFT`, `VEH_MELEE_RIGHT` (345 to 347) | 251 | about 13,000 each |
| 385, 386 | `MAP_POI`, `REPLAY_SNAPMATIC_PHOTO` (348, 349) | 0 | 0 |
| 387 | `VEH_CAR_JUMP` (350) | 263 | 535 |
| 388 | `VEH_ROCKET_BOOST` (351) | 284 | 7,528 |
| 389 | `VEH_FLY_BOOST` (352) | 451 | 574 |
| 390 | `VEH_PARACHUTE` (353) | 6 | 7 |
| 391 | `VEH_BIKE_WINGS` (354) | 251 | 5,796 |
| 392, 393 | `VEH_FLY_BOMB_BAY`, `VEH_FLY_COUNTER` (355, 356) | 4, 5 | 6, 10 |
| 394 | `VEH_TRANSFORM` (357) | 254 | 2,141 |
| 395, 396 | `QUAD_LOCO_REVERSE`, `RESPAWN_FASTER` (358, 359) | 2, 1 | 2, 3 |
| 397 | `HUDMARKER_SELECT` (360) | 0 | 0 |
| 398, 399 | `EAT_SNACK`, `USE_ARMOR` (361, 362) | 1 (`freemode`) | 1 each |
| 400, 401 | `VEH_SHIFT_GEAR_UP`, `VEH_SHIFT_GEAR_DOWN` (363, 364) | 7 (Online race and deathmatch controllers) | 30 each |

**What it means:** a mod or trainer that passes a control number of 257 or more taken from an old list may now be pointing at a different control. Below 257 nothing changed. Whether the engine maps old numbers for old code is the open question GP-091 (test card 4).

## The view mode (first and third person)

**Verified (counts):** `GET_CAM_VIEW_MODE_FOR_CONTEXT` 609 scripts (6,203 calls), `SET_CAM_VIEW_MODE_FOR_CONTEXT` 415 (1,589), `GET_CAM_ACTIVE_VIEW_MODE_CONTEXT` 339 (808), `DISABLE_ON_FOOT_FIRST_PERSON_VIEW_THIS_UPDATE` 134 (307), `GET_FOLLOW_PED_CAM_VIEW_MODE` 122, `SET_FOLLOW_PED_CAM_VIEW_MODE` 47, `SET_FOLLOW_VEHICLE_CAM_VIEW_MODE` 41.

**Verified (second pass), from the scripts' own checks:** a help-text helper compiled into many story scripts (read in `abigail2`) picks the context from the vehicle type: `IS_PED_IN_ANY_BOAT` → context 3, `IS_PED_IN_ANY_HELI` → 6, `IS_PED_IN_ANY_PLANE` → 4, `IS_PED_IN_ANY_SUB` → 5, `IS_PED_ON_ANY_BIKE` → 2, otherwise the car view (`GET_FOLLOW_VEHICLE_CAM_VIEW_MODE`). In every branch it treats modes 3 and 4 alike (it hides help text in the cinematic and first-person views). Context 7 is used only by `heli_gun` (the helicopter turret) and the two race controllers. Mode 4 is first person: the code after `GET_FOLLOW_PED_CAM_VIEW_MODE() == 4` or `GET_CAM_VIEW_MODE_FOR_CONTEXT(0) == 4` calls the `SET_FIRST_PERSON_*` aim-limit natives.

| Context | Meaning | `GET_CAM_VIEW_MODE_FOR_CONTEXT` calls | Forced to first person (`SET_…(n, 4)`) |
| ---: | --- | ---: | ---: |
| 0 | On foot | 1,289 | 314 |
| 1 | Car (the follow-vehicle view) | 186 | 55 |
| 2 | Bike | 697 | 45 |
| 3 | Boat | 692 | 45 |
| 4 | Plane | 690 | 46 |
| 5 | Submarine | 654 | 0 |
| 6 | Helicopter | 716 | 45 |
| 7 | Turret | 1 | 2 |

The other forced mode is 1 (medium third person): on foot 105 times, helicopter 14, car 4. Mode 0 is forced 24 times on foot.

**Known:** modes 0 to 2 are third person near, medium and far, 3 cinematic. The game remembers a mode per context; the `INPUT_NEXT_CAMERA` action (`V`, ID 0) cycles it. Missions read the mode, force one for a scene, and put the player's choice back.

## What this means for modders

- **Block an action** by calling `DISABLE_CONTROL_ACTION(0, id, true)` every frame while you need it; it lasts one frame only. Read your own hotkey with `IS_DISABLED_CONTROL_JUST_PRESSED` if you also disabled it, so the game doesn't act on it too.
- **Avoid clashes:** check `IS_PAUSE_MENU_ACTIVE`, the phone (`IS_PHONE_ONSCREEN`, **Known**) and `IS_PLAYER_CONTROL_ON` before reacting to a key. Claim a control with `SET_INPUT_EXCLUSIVE` while your menu is open.
- **Use actions, not keys,** so the player's rebinding and the pad both work: `INPUT_CONTEXT` (51) for "interact", `INPUT_FRONTEND_ACCEPT` (201) and `INPUT_FRONTEND_CANCEL` (202) for menus. Show the right icon with `GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING`.
- **Check your control numbers on build 3717 and later.** IDs below 257 are unchanged. From 257 up, the scripts use the old number + 37 (`ATTACK2` 294, `MELEE_ATTACK1` 300, `VEH_ROCKET_BOOST` 388, `VEH_TRANSFORM` 394). Libraries built on older lists (ScriptHookVDotNet 3's `Control` enum, FiveM's list) give the old numbers. Whether the natives still accept the old numbers hasn't been tested (test card 4).
- **Force first person** for a scene with `SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)`, after saving `GET_CAM_VIEW_MODE_FOR_CONTEXT`, and restore it when done.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| How `SET_INPUT_EXCLUSIVE` and `DISABLE_CONTROL_ACTION` interact when two scripts disagree | In-game test |
| Whether the PAD natives on build 3717+ still treat an old ID (257 to 364) as the old control (GP-091) | In-game test (test card 4) |

Answered in the second pass: the names of controls 365 to 401 (GP-041, [the numbering](#the-numbering-changed-in-build-3717-second-pass)), the shared disable helpers (GP-042, [the helpers](#the-shared-disable-helpers-second-pass)), the context and mode numbers (GP-044, [view mode](#the-view-mode-first-and-third-person)).

## Test cards

1. **One-frame disable.** Call `DISABLE_CONTROL_ACTION(0, 24, true)` only once. Expected: you can still shoot next frame. Call it every frame: you can't.
2. **Disabled but readable.** Disable `INPUT_CONTEXT` (51) every frame and log `IS_DISABLED_CONTROL_JUST_PRESSED(0, 51)`. Expected: pressing E logs true but opens no doors or shops.
3. **View mode.** Save the on-foot mode, `SET_CAM_VIEW_MODE_FOR_CONTEXT(0, 4)` for 5 s, then restore. Expected: first person for 5 s, then the player's own view.
4. **Old or new numbers (build 3717 or later).** On foot with a melee-capable weapon, log `IS_CONTROL_JUST_PRESSED(0, 263)` and `IS_CONTROL_JUST_PRESSED(0, 300)` every frame and press the light melee key (`R` by default, `INPUT_MELEE_ATTACK1`). Expected if the natives take the new numbers: 300 logs true and 263 (now `INPUT_CREATOR_MENU_DELETE`) stays false. If 263 logs true, the engine still maps the old number. Write down which one fires.
