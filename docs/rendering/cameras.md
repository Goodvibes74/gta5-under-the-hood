# Cameras

How GTA V's cameras are organised (directors, gameplay and cinematic cameras, script cameras, shakes), where their settings live, and how Rockstar's scripts create, move, shake and hand back cameras in missions, cutscenes and the phone. Roadmap topic **R13.5** in the [roadmap](/ROADMAP.md). Builds on [native usage](/scripting/native-usage.md) and [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md). Controls and the first-person view as a player setting are R6.4.

**How it was made.** `update:/x64/data/metadata/cameras.ymt` extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and converted to XML (6 MB); hashed names matched against every string literal in the decompile and the extracted data (Jenkins one-at-a-time hash, lower case). Native use from the [CAMERA](/scripting/native-usage/CAMERA.md) usage page (248 natives); camera and shake names passed to `CREATE_CAM`, `CREATE_CAM_WITH_PARAMS`, `SHAKE_CAM`, `SHAKE_GAMEPLAY_CAM` and `SHAKE_CINEMATIC_CAM` counted with one `git grep -o` over every decompiled script (commit `6c18d3e8b`; literal names only, case folded, counted once per script). Build 1.0.3725.0 Legacy. Counts are **Verified**; how the camera system works inside is **Known** unless stated.

## Short version

- **One file defines every camera:** `cameras.ymt` holds 1,545 named settings of 127 metadata types: 211 mounted cinematic cameras (the in-car and on-vehicle views), 73 follow-vehicle cameras, 71 third-person aim cameras, 18 follow-ped cameras, 99 camera shakes made from 362 oscillators and 232 envelopes, 44 depth-of-field settings.
- **10 directors decide which camera renders:** gameplay, cinematic, synced scene, anim scene, script, switch (the character switch), cutscene, replay, debug and marketing. **Known:** each frame the director with the highest priority that has a camera wins; script cameras win over gameplay while `RENDER_SCRIPT_CAMS(true)` is set.
- **Scripts make 4 kinds of camera:** `DEFAULT_SCRIPTED_CAMERA` (418 scripts by literal name), `DEFAULT_ANIMATED_CAMERA` (78), `DEFAULT_SPLINE_CAMERA` (61) and `DEFAULT_SCRIPTED_FLY_CAMERA` (9). `CREATE_CAM` is in 430 scripts, `CREATE_CAMERA` (the same by hash) in 367.
- **The busiest camera natives are fades.** `IS_SCREEN_FADED_OUT` (731 scripts), `DO_SCREEN_FADE_IN` (607) and `DO_SCREEN_FADE_OUT` (558) sit in the CAMERA namespace; then `RENDER_SCRIPT_CAMS` (563 scripts, 11,933 calls) and `DOES_CAM_EXIST` (543).
- **Shakes are named presets.** Scripts use 20 different shakes by name; the most widespread are `HAND_SHAKE` (407 scripts, the handheld look on script cameras), `SMALL_EXPLOSION_SHAKE` (257), `MEDIUM_EXPLOSION_SHAKE` (252 on the gameplay camera), `JOLT_SHAKE` (249) and `DRUNK_SHAKE` (about 67 on each camera kind).
- **Hints point the gameplay camera.** `SET_GAMEPLAY_ENTITY_HINT` (237 scripts) and `SET_GAMEPLAY_COORD_HINT` (88) turn the player's camera toward something ("look here" in missions); `STOP_GAMEPLAY_HINT` (276).

## Where it lives

`update:/x64/data/metadata/cameras.ymt`, by metadata type (the biggest groups):

| Type | Count | What it is (**Known** from the type name and its fields) |
| --- | ---: | --- |
| `camOscillatorMetadata` | 362 | Sine and noise waves that shakes are built from |
| `camEnvelopeMetadata` | 232 | Attack, hold and release curves for shakes and blends |
| `camCinematicMountedCameraMetadata` | 211 | Cameras fixed to a vehicle: the first-person car interior, bonnet, wheel and side views |
| `camShakeMetadata` | 99 | Named shakes (`JOLT_SHAKE`, `HAND_SHAKE`, `SKY_DIVING_SHAKE`, `HIGH_FALL_SHAKE` ...; 50 names didn't resolve) |
| `camVehicleCustomSettingsMetadata` | 79 | Per-model overrides (which follow and mounted cameras a vehicle uses) |
| `camFollowVehicleCameraMetadata` | 73 | Third-person vehicle cameras: `DEFAULT_FOLLOW_VEHICLE_CAMERA`, `FOLLOW_BIKE_CAMERA`, `FOLLOW_BOAT_CAMERA`, `FOLLOW_KOSATKA_CAMERA` ... |
| `camThirdPersonPedAimCameraMetadata` | 71 | Aiming over the shoulder, per weapon type |
| `camControlHelperMetadata` | 52 | Look-around and zoom rules (mouse and stick) |
| `camCinematicMountedPartCameraMetadata` | 50 | Cameras on vehicle parts (turrets, arms) |
| `camDepthOfFieldSettingsMetadata` | 44 | Depth-of-field presets |
| `camThirdPersonVehicleAimCameraMetadata` | 36 | Aiming from vehicles (drive-bys, turrets) |
| `camFollowPedCameraMetadata` | 18 | On-foot third person: default, skydiving, prone, on a ladder, hanging upside down (Trevor's mission), on a rope |
| `camHintHelperMetadata`, `camCollisionMetadata` | 18, 18 | Hints and how cameras avoid walls |
| `camFirstPersonShooterCameraMetadata` | 2 | The on-foot first-person view |
| Director types | 10 | `camGameplayDirectorMetadata`, `camCinematicDirectorMetadata`, `camSyncedSceneDirectorMetadata`, `camAnimSceneDirectorMetadata`, `camScriptDirectorMetadata`, `camSwitchDirectorMetadata`, `camCutsceneDirectorMetadata`, `camReplayDirectorMetadata`, `camDebugDirectorMetadata`, `camMarketingDirectorMetadata` |
| Script camera types | 8 | `default_scripted_camera`, `DEFAULT_SCRIPTED_FLY_CAMERA`, `DEFAULT_ANIMATED_CAMERA`, `DEFAULT_SPLINE_CAMERA` and 2 more timed splines, a rounded and a smoothed spline |
| Switch helpers | 17 | The character-switch camera moves (`camLongSwoopSwitchHelperMetadata` 8, short zoom, translation and rotation helpers) |

The marketing director and its 5 cameras (free, orbit, mounted, sticky, A-to-B) are Rockstar's tools for trailers; the replay director and its cameras (5 presets, a free camera and a recorded camera) serve the Rockstar Editor (R5.8).

## How scripts use cameras

### Script cameras

**Verified (counts):**

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `RENDER_SCRIPT_CAMS` | 563 | 11,933 | Switch rendering to the active script camera, with or without an ease |
| `DOES_CAM_EXIST`, `DESTROY_CAM` | 543, 524 | 17,285, 9,331 | Housekeeping |
| `SET_CAM_ACTIVE` | 494 | 5,200 | Choose which script camera is live |
| `CREATE_CAM`, `CREATE_CAM_WITH_PARAMS` / `CREATE_CAMERA`, `CREATE_CAMERA_WITH_PARAMS` | 430, 84 / 367, 190 | 1,856, 461 / 3,866, 663 | Make one (by name / by hash) |
| `SET_CAM_PARAMS` | 385 | 4,491 | Position, rotation, FOV and an interpolation in one call |
| `PLAY_SYNCHRONIZED_CAM_ANIM`, `PLAY_CAM_ANIM` | 338, 277 | 1,010, 839 | Animated cameras from animation dictionaries (scripted scenes) |
| `SET_CAM_FOV`, `SET_CAM_DOF_STRENGTH`, `SET_USE_HI_DOF`, `SET_CAM_USE_SHALLOW_DOF_MODE` | 292, 291, 304, 270 | | Lens and depth of field (shops and showrooms use the shallow mode) |
| `SET_CAM_ACTIVE_WITH_INTERP` | 218 | 649 | Blend from one script camera to another |
| `ATTACH_CAM_TO_ENTITY`, `POINT_CAM_AT_ENTITY` | 162, 119 | 1,169, 668 | Follow or look at a ped or vehicle |
| `STOP_RENDERING_SCRIPT_CAMS_USING_CATCH_UP` | 141 | 219 | Hand back to the gameplay camera smoothly |
| `ADD_CAM_SPLINE_NODE`, `ADD_CAM_SPLINE_NODE_USING_CAMERA`, `..._USING_GAMEPLAY_FRAME` | 44, 47, 23 | 441, 414, 42 | Spline paths (the end credits, heist flyovers, golf) |

**The usual pattern (Known, the common shape in mission scripts):** `CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", false)`, set its position and rotation with `SET_CAM_PARAMS` or `SET_CAM_COORD` / `SET_CAM_ROT`, `SET_CAM_ACTIVE(cam, true)`, `RENDER_SCRIPT_CAMS(true, ease, time, ...)`; later `RENDER_SCRIPT_CAMS(false, ...)` or `STOP_RENDERING_SCRIPT_CAMS_USING_CATCH_UP`, then `DESTROY_CAM`. Two cameras and `SET_CAM_ACTIVE_WITH_INTERP` make a move from one shot to the next.

### The gameplay camera

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `GET_CAM_VIEW_MODE_FOR_CONTEXT`, `SET_CAM_VIEW_MODE_FOR_CONTEXT` | 609, 415 | 6,203, 1,589 | Read or force the view mode (third person near, mid, far, first person) for a context (on foot, car, bike, boat, aircraft, heli, sub) |
| `SET_GAMEPLAY_CAM_RELATIVE_HEADING`, `_PITCH` | 581, 566 | 5,021, 3,180 | Point the camera behind the player after a cut |
| `IS_AIM_CAM_ACTIVE`, `IS_FIRST_PERSON_AIM_CAM_ACTIVE` | 474, 313 | | Aiming checks |
| `SET_GAMEPLAY_ENTITY_HINT`, `SET_GAMEPLAY_COORD_HINT`, `STOP_GAMEPLAY_HINT` | 237, 88, 276 | 359, 111, 673 | Look-at hints |
| `GET_GAMEPLAY_CAM_COORD`, `GET_GAMEPLAY_CAM_ROT`, `GET_FINAL_RENDERED_CAM_COORD` | 264, 265, 377 | | Where the camera is |
| `DISABLE_ON_FOOT_FIRST_PERSON_VIEW_THIS_UPDATE` | 134 | 307 | No first person here (some missions and interiors) |
| `SET_THIRD_PERSON_CAM_RELATIVE_PITCH_LIMITS_THIS_UPDATE` and the heading and orbit limits | 54, 7, 14 | | Keep the camera inside a room (Online properties) |
| `SET_CINEMATIC_BUTTON_ACTIVE`, `SET_CINEMATIC_MODE_ACTIVE`, `IS_CINEMATIC_CAM_RENDERING` | 162, 44, 63 | 907, 187, 67 | The cinematic camera button (vehicle cinematic views) |
| `SET_FOLLOW_PED_CAM_VIEW_MODE`, `SET_FOLLOW_VEHICLE_CAM_VIEW_MODE` | 47, 41 | 119, 58 | Older view-mode natives |

### Shakes

**Verified:** shake names scripts pass by name (scripts that use each, case folded):

| Shake | `SHAKE_CAM` (script cameras) | `SHAKE_GAMEPLAY_CAM` | `SHAKE_CINEMATIC_CAM` |
| --- | ---: | ---: | ---: |
| `HAND_SHAKE` | 407 | | |
| `SMALL_EXPLOSION_SHAKE` | 257 | 22 | |
| `JOLT_SHAKE` | 249 | 4 | |
| `MEDIUM_EXPLOSION_SHAKE` | 6 | 252 | |
| `DRUNK_SHAKE` | 67 | 68 | 64 |
| `ROAD_VIBRATION_SHAKE` | 29 | 1 | |
| `SKY_DIVING_SHAKE` | 20 | 2 | |
| `LARGE_EXPLOSION_SHAKE` | 2 | 8 | |
| `VIBRATE_SHAKE` | 8 | | |
| Others (`CLUB_DANCE_SHAKE`, `HIGH_SPEED_VEHICLE_SHAKE`, `FAMILY5_DRUG_TRIP_SHAKE`, `PLANE_PART_SPEED_SHAKE`, `DRONE_BOOST_SHAKE`, `GAMEPLAY_EXPLOSION_SHAKE`, `GRENADE_EXPLOSION_SHAKE`) | 1 to 4 each | | |

`STOP_GAMEPLAY_CAM_SHAKING` is in 154 scripts and `STOP_CAM_SHAKING` in 310; `ANIMATED_SHAKE_CAM` (18 scripts) plays a shake from an animation instead. Explosions shake the camera by themselves through `camShakeName` and `camShake` in `explosion.ymt` (R2.5).

### Fades and borders

`IS_SCREEN_FADED_OUT` (731 scripts), `IS_SCREEN_FADED_IN` (672), `DO_SCREEN_FADE_IN` (607), `IS_SCREEN_FADING_OUT` (591), `DO_SCREEN_FADE_OUT` (558) and `SET_WIDESCREEN_BORDERS` (439, the letterbox bars) are camera natives too. Almost every mission start, cut and teleport goes through a fade.

## What this means for modders

- **A camera for a scene:** create `DEFAULT_SCRIPTED_CAMERA`, set position, rotation and FOV, `SET_CAM_ACTIVE`, `RENDER_SCRIPT_CAMS(true, false, 0, true, false, 0)`. Hand back with `RENDER_SCRIPT_CAMS(false, true, 1000, ...)` (an eased return) and `DESTROY_CAM`. Forgetting the hand-back leaves the player stuck in your camera.
- **Smooth moves:** two cameras and `SET_CAM_ACTIVE_WITH_INTERP(to, from, ms, 1, 1)`, or a `DEFAULT_SPLINE_CAMERA` with spline nodes for a path.
- **A handheld feel:** `SHAKE_CAM(cam, "HAND_SHAKE", 0.3)`, the shake Rockstar puts on most script cameras. Use the shake names from the tables; unknown names do nothing.
- **Force a view:** `SET_CAM_VIEW_MODE_FOR_CONTEXT(context, mode)` (for example first person in a car), and put the player's choice back when done (`GET_CAM_VIEW_MODE_FOR_CONTEXT` first).
- **Change a vehicle's camera** in data: a vehicle's `vehicles.meta` entry names its follow and mounted cameras (`cameraName`, `aimCameraName` ...), which must exist in `cameras.ymt` (**Known**). Add-on vehicles usually reuse an existing camera name.
- **Fades:** pair every `DO_SCREEN_FADE_OUT` with a `DO_SCREEN_FADE_IN`, and wait for `IS_SCREEN_FADED_OUT` before teleporting.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The director priorities and exactly when the cinematic director takes over | Second pass |
| The 50 shake names and other camera names that didn't resolve | Second pass with more name sources |
| Which `CREATE_CAMERA` hashes scripts use (the hashed form of `CREATE_CAM`) | Second pass: resolve the hashes in the decompile |
| The view mode contexts and modes as numbers | R6.4 |
| How the first-person car interior camera is chosen per vehicle (`camVehicleCustomSettingsMetadata`) | R14.1 |

## Test cards

1. **Script camera.** Create `DEFAULT_SCRIPTED_CAMERA` 10 m above the player looking down, render it for 5 s, then `RENDER_SCRIPT_CAMS(false, true, 2000, ...)`. Expected: a smooth 2-second glide back to the gameplay camera.
2. **Shakes.** On a script camera, try `HAND_SHAKE`, `JOLT_SHAKE` and `DRUNK_SHAKE` at amplitude 1.0. Expected: a gentle sway, a single bump, a slow roll.
3. **Hint.** `SET_GAMEPLAY_ENTITY_HINT` on a ped 30 m away for 3 s. Expected: the camera swings toward the ped and back.
