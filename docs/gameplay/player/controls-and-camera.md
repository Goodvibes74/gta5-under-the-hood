# Controls and camera

How input reaches the game: the control actions (`INPUT_*`) and their IDs, where keyboard, mouse and pad bindings are defined, the three control groups, how Rockstar's scripts disable, check and claim controls every frame, and how the camera view mode (first person and the third-person distances) is read and forced. Roadmap topic **R6.4** in the [roadmap](/ROADMAP.md). Builds on [key codes and control IDs](/docs/gameplay/player/keycodes-and-controls.md) (the numbers mods use for keys and buttons) and [native usage](/scripting/native-usage.md). Script cameras, shakes and the director system are R13.5.

**How it was made.** Every file in the vanilla archives was listed with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and the control files read: `common:/data/control/*.meta` (base and update copies) and `update:/x64/data/control/` (bindings, keyboard layouts, mouse settings). Every call of the `PAD` natives that take a control group and a control ID was collected with one `git grep -o` over the decompile (commit `6c18d3e8b`; 663,645 call sites with literal numbers) and counted per control and per script. Control names come from the `GTA.Control` enum in ScriptHookVDotNet 3 (read from its assembly's metadata; it names IDs 0 to 364), whose names match the game's `INPUT_*` names without the prefix. Native use from the [PAD](/scripting/native-usage/PAD.md) and [CAMERA](/scripting/native-usage/CAMERA.md) usage pages. Build 1.0.3725.0 Legacy. Counts are **Verified**; how the input system works inside is **Known** unless stated.

## Short version

- **Controls are actions, not keys.** A script asks about `INPUT_ATTACK` (ID 24), not the left mouse button or RT. The bindings file maps keys and buttons to actions; `update:/x64/data/control/default.meta` binds 192 different `INPUT_*` actions for keyboard and mouse.
- **The IDs run to at least 401.** ScriptHookVDotNet 3 names 0 to 364; build 3725's scripts also use 365 to 401 (controls added in later updates), some heavily: 382, 383 and 384 about 13,000 calls each, 374 about 12,000, 388 7,528.
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
| 389 | (unnamed, a newer control) | 451 | 574 |
| 22 | `Jump` | 438 | 7,130 |
| 294 | `ScaledLookLeftOnly` | 435 | 13,485 |
| 25 | `Aim` | 432 | 13,503 |
| 23 | `Enter` | 407 | 6,825 |
| 200 | `FrontendPauseAlternate` | 363 | 12,551 |
| 142 | `MeleeAttackAlternate` | 361 | 13,434 |

The same handful of controls is disabled in hundreds of scripts with almost the same call count (about 13,500) because Rockstar compiles shared "disable combat", "disable vehicle weapons" and "block the pause key" helpers into most scripts.

**Known:** the phone, the pause menu, the weapon wheel and script menus all want the same buttons. Rockstar's scripts handle it by disabling the game action (`SelectWeapon`, `Phone`, `FrontendPauseAlternate`) while their own UI is up, reading the disabled control with `IS_DISABLED_CONTROL_JUST_PRESSED`, and checking `IS_PAUSE_MENU_ACTIVE` (616 scripts) before acting.

## The view mode (first and third person)

**Verified (counts):** `GET_CAM_VIEW_MODE_FOR_CONTEXT` 609 scripts (6,203 calls), `SET_CAM_VIEW_MODE_FOR_CONTEXT` 415 (1,589), `GET_CAM_ACTIVE_VIEW_MODE_CONTEXT` 339 (808), `DISABLE_ON_FOOT_FIRST_PERSON_VIEW_THIS_UPDATE` 134 (307), `GET_FOLLOW_PED_CAM_VIEW_MODE` 122, `SET_FOLLOW_PED_CAM_VIEW_MODE` 47, `SET_FOLLOW_VEHICLE_CAM_VIEW_MODE` 41.

**Known:** contexts are 0 on foot, 1 in a vehicle, 2 on a bike, 3 in a boat, 4 in an aircraft, 5 in a submarine, 6 in a helicopter, 7 in a turret; modes are 0 third person near, 1 medium, 2 far, 3 cinematic and 4 first person. The game remembers a mode per context; the `INPUT_NEXT_CAMERA` action (`V`, ID 0) cycles it. Missions read the mode, force one for a scene, and put the player's choice back.

## What this means for modders

- **Block an action** by calling `DISABLE_CONTROL_ACTION(0, id, true)` every frame while you need it; it lasts one frame only. Read your own hotkey with `IS_DISABLED_CONTROL_JUST_PRESSED` if you also disabled it, so the game doesn't act on it too.
- **Avoid clashes:** check `IS_PAUSE_MENU_ACTIVE`, the phone (`IS_PHONE_ONSCREEN`, **Known**) and `IS_PLAYER_CONTROL_ON` before reacting to a key. Claim a control with `SET_INPUT_EXCLUSIVE` while your menu is open.
- **Use actions, not keys,** so the player's rebinding and the pad both work: `INPUT_CONTEXT` (51) for "interact", `INPUT_FRONTEND_ACCEPT` (201) and `INPUT_FRONTEND_CANCEL` (202) for menus. Show the right icon with `GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING`.
- **IDs above 364** exist in build 3725; libraries built on older lists (ScriptHookVDotNet 3's `Control` enum) don't name them. Cast the number if you need one.
- **Force first person** for a scene with `SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)`, after saving `GET_CAM_VIEW_MODE_FOR_CONTEXT`, and restore it when done.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The names of controls 365 to 401 | Second pass: the game's own control list (`controls.xml`, settings menu text) |
| Which shared helpers produce the near-identical disable counts, and what each blocks | Second pass |
| How `SET_INPUT_EXCLUSIVE` and `DISABLE_CONTROL_ACTION` interact when two scripts disagree | In-game test |
| The context and mode numbers, read from the scripts' own constants | Second pass |

## Test cards

1. **One-frame disable.** Call `DISABLE_CONTROL_ACTION(0, 24, true)` only once. Expected: you can still shoot next frame. Call it every frame: you can't.
2. **Disabled but readable.** Disable `INPUT_CONTEXT` (51) every frame and log `IS_DISABLED_CONTROL_JUST_PRESSED(0, 51)`. Expected: pressing E logs true but opens no doors or shops.
3. **View mode.** Save the on-foot mode, `SET_CAM_VIEW_MODE_FOR_CONTEXT(0, 4)` for 5 s, then restore. Expected: first person for 5 s, then the player's own view.
