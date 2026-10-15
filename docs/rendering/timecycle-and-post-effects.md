# Timecycle and post effects

How GTA V decides what a scene looks like: the timecycle (light, fog, sky, colour grading and screen effects, keyed by weather and time of day), timecycle modifiers that bend it for a place or a moment, and the animated screen effects (`ANIMPOSTFX_*`) that scripts play for drugs, deaths, mission passes and transitions. Roadmap topic **R13.2** in the [roadmap](/ROADMAP.md). Builds on [native usage](/scripting/native-usage.md) and [archives and content](/docs/core/archives-and-content.md); the weather side (which timecycle file goes with which weather) is roadmap topic R2.6, time, weather and wind.

**How it was made.** Data files extracted with CodeWalker's library (the same way [`tools/rpf-cw.ps1`](/tools/README.md) does) from `common.rpf` and `update\update.rpf`: the `w_*.xml` weather timecycles and the four `timecycle_mods_*.xml` files in `common:/data/timecycle/`, and `update:/x64/data/effects/animpostfx.ymt` converted to XML. Hashed names in the converted file were matched against every string literal in the decompile and every name in the extracted XML (Jenkins one-at-a-time hash, lower case). Every DLC pack's `content.xml` was read with [`tools/dlc-scan.ps1`](/tools/README.md). Native use from the [GRAPHICS](/scripting/native-usage/GRAPHICS.md) usage page; effect and modifier names used by scripts counted with one `git grep -o` over every decompiled script (literal string arguments only). Build 1.0.3725.0 Legacy, decompile commit `6c18d3e8b`. Counts and file contents are **Verified**; what the renderer does with them is **Known** unless stated.

## Short version

- **Three layers decide the look.** The weather timecycle (one file per weather, 380 variables per region, 13 keyframes across the day) blended between the previous and next weather; then timecycle modifiers (named sets of overrides: 1,072 in build 3725) from the place you're in or from a script; then animated post effects (`ANIMPOSTFX_*`, 252 defined) on top.
- **Modifiers are partial.** A modifier changes only the variables it lists: 29 on average, from 1 to 136, out of 282 different variables used across all modifiers. The most common are bloom (`postfx_intensity_bloom`, in 620 modifiers), the bright-pass threshold (597), and the interior and natural ambient light multipliers (520 and 517).
- **Rockstar adds modifiers by editing one file set.** The base copy in `common.rpf` has 563 modifiers; the update copy has 1,072. No DLC pack registers a timecycle modifier file in its `content.xml` (0 of 90); every Online DLC's modifiers (`dlc_mp2025_*`, `mp_battle_*` ...) were merged into `update.rpf`.
- **An animated post effect is a stack of up to six timecycle modifiers,** each with an ease-in, hold and ease-out time and a loop mode. The 252 effects use 705 of their 1,512 layer slots and point at 192 different modifiers, all but one of which are in the timecycle files.
- **Scripts use post effects far more than raw modifiers.** `ANIMPOSTFX_PLAY` is in 466 scripts (2,350 calls), `SET_TIMECYCLE_MODIFIER` in 211 (1,882). Scripts play 142 of the 252 effects by literal name; the most widespread are `FocusOut` (142 scripts), `FocusIn` (135), `DeathFailMPIn` and `DeathFailMPDark` (83 each) and `CamPushInNeutral` (74).
- **Every modifier a script names exists in the base game's files:** all 117 literal names passed to `SET_TIMECYCLE_MODIFIER`, `SET_TRANSITION_TIMECYCLE_MODIFIER` and `PUSH_TIMECYCLE_MODIFIER` are in the update copy of the timecycle files.
- **For mods:** play an existing effect with `ANIMPOSTFX_PLAY(name, duration, looped)` and stop it with `ANIMPOSTFX_STOP`; set a look with `SET_TIMECYCLE_MODIFIER(name)` plus `SET_TIMECYCLE_MODIFIER_STRENGTH`, and always `CLEAR_TIMECYCLE_MODIFIER` when done. Graphics mods (ENB-like "visual" mods) are mostly edits to the `w_*.xml` and `timecycle_mods_*.xml` files.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/timecycle/w_<weather>.xml` | The weather timecycles: one `<cycle>` per weather with 2 regions (`GLOBAL`, `URBAN`), each with 380 variables, each a row of 13 keyframe values across the day | 14 base files plus `underwater_deep.xml`; the update copy replaces 11 and adds 3 Halloween ones |
| `common:/data/timecycle/timecycle_mods_1.xml` to `_4.xml` | Timecycle modifiers: `<modifier name numMods userFlags>` with one line per overridden variable, two numbers each | 1,072 distinct names in the update copy (635, 30, 125 and 295 per file, a few repeated); 563 in the base copy |
| `update:/x64/data/effects/animpostfx.ymt` | Animated post effects: 252 registered stacks, each with a layer blend and 6 layer slots | 252 effects, 705 layers used |
| `common:/data/visualsettings.dat` | Fixed renderer values that aren't per weather or time (rain, lights, tonemapping defaults) | Plain `key value` lines |
| Map data (`.ymap`) and interiors (`.ytyp`) | Timecycle modifier boxes and interior room modifiers that switch a modifier on when the camera is inside (**Known**) | R4.6 |

### The weather timecycle

**Verified:** each `w_<weather>.xml` has one cycle named after its weather with two regions, `GLOBAL` and `URBAN`. Every variable is a row of 13 numbers, one per keyframe across the day. Variables cover the sun and moon light (`light_dir_col_r`, `light_dir_mult`), ambient light, fog, the sky dome, clouds, water reflection, depth of field, bloom, exposure and tonemapping (`postfx_*`), and LOD and draw-distance multipliers (`lod_mult_slod` ...). **Known:** the game blends the two keyframes either side of the current time, then blends the previous and next weather by the weather transition (`GET_CURR_WEATHER_STATE`), and uses the `URBAN` region inside the city.

### Timecycle modifiers

**Verified:** a modifier lists only the variables it changes; each line holds two numbers (for `underwater`, `light_dir_col_r` is `0.004 0.900`). `numMods` is the number of lines. `userFlags` is 0 for 746 modifiers, 2 for 296, 1 for 23, and 16, 4 or 8 for a handful (meaning not settled; open question).

The names show what they are for (first part of the name, update copy): `mp_` 236, `dlc_` 103, `int_` 75 (interiors), `v_` 35 (story interiors), `ng_` 32 (added with the PS4/PC version), `water` 22, `hud_` 18, `phone` 16, `glasses` 13 (sunglasses tints), `tunnel` 12, `spectator` 10, `drug` 10, `casino` 9, `rply` 9 (Rockstar Editor filters), `lodmult` 8, `underwater` 4, `lightning` 4.

The variables modifiers change most (number of modifiers that set each, of 1,072):

| Variable | Modifiers | What it is (**Known**) |
| --- | ---: | --- |
| `postfx_intensity_bloom` | 620 | Bloom strength |
| `postfx_bright_pass_thresh` | 597 | Brightness above which bloom starts |
| `artificial_int_ambient_multiplier` | 520 | Ambient light from lamps indoors |
| `natural_ambient_multiplier` | 517 | Ambient light from the sky |
| `light_artificial_int_down_intensity`, `_up_intensity`, `_col_r/g/b` | 495 to 499 | Indoor lamp ambient, up and down |
| `postfx_bright_pass_thresh_width` | 459 | Bloom threshold softness |
| `ped_light_col_r/g/b`, `ped_light_mult` | 419 to 439 | The extra light on characters |
| `fog_start` | 430 | Where distance fog starts |
| `ssao_inten` | 391 | Ambient occlusion strength |
| `temperature` | 331 | White balance |
| `postfx_vignetting_intensity`, `_radius` | 291, 273 | Dark screen edges |
| `postfx_exposure` | 289 | Exposure |

### Animated post effects

**Verified:** `animpostfx.ymt` registers 252 effects. Each is an `FXStack` with:

- **6 layer slots** (`AnimatedPostFX`). A used slot names a timecycle modifier (`ModifierName`), an `AnimMode` (`POSTFX_IN_HOLD_OUT` 932 slots, `POSTFX_EASE_IN_HOLD_EASE_OUT` 290, `POSTFX_EASE_OUT` 221, `POSTFX_EASE_IN` 69), `StartDelayDuration`, `InDuration`, `HoldDuration` and `OutDuration` in milliseconds, a `LoopMode` (`POSTFX_LOOP_NONE` 919, `POSTFX_LOOP_ALL` 428, `POSTFX_LOOP_HOLD_ONLY` 165) and `CanBePaused`. 705 of the 1,512 slots are used.
- **A layer blend** (`LayerA`, `LayerB`, `Frequency`, `FrequencyNoise`, `AmplitudeNoise`, `Bias`) that wobbles between two of its layers: how drug effects pulse.
- **`GroupId`** (−1 for 245 effects, 1 for 3, 64 for 4) and an `EventType`.

Example: `DrugsMichaelAliensFight` holds `michealspliff` and `michealspliff_blend` for 100,000 ms with `POSTFX_LOOP_HOLD_ONLY` and blends between `michealspliff_blend` and `michealspliff_blend02` with a slow noise. So each "screen effect" is timecycle modifiers animated over time; there is no separate shader per effect.

The layers point at 192 different modifiers; 191 are in the timecycle files. 39 of the 252 effect names didn't match any string in the scripts or data, so they are probably unused or only reached by hash.

## How scripts change the look

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `ANIMPOSTFX_PLAY` | 466 | 2,350 | Play an effect by name, with a duration and a loop flag |
| `ANIMPOSTFX_STOP` / `ANIMPOSTFX_STOP_ALL` | 423 / 415 | 5,939 / 663 | Stop one or all |
| `ANIMPOSTFX_IS_RUNNING` | 350 | 5,131 | Check before starting or stopping |
| `ANIMPOSTFX_STOP_AND_FLUSH_REQUESTS` | 33 | 142 | Story missions: stop and drop pending effects at cleanup |
| `SET_TIMECYCLE_MODIFIER` / `CLEAR_TIMECYCLE_MODIFIER` | 211 / 330 | 1,882 / 1,018 | Set or clear the script modifier |
| `SET_TIMECYCLE_MODIFIER_STRENGTH` | 42 | 111 | Scale it from 0 to 1 |
| `SET_TRANSITION_TIMECYCLE_MODIFIER` / `SET_TRANSITION_OUT_OF_TIMECYCLE_MODIFIER` | 37 / 32 | 61 / 69 | Blend into or out of a modifier over N seconds |
| `GET_TIMECYCLE_MODIFIER_INDEX`, `GET_TIMECYCLE_TRANSITION_MODIFIER_INDEX` | 148, 42 | 306, 57 | Check which modifier is active (−1 for none) |
| `PUSH_TIMECYCLE_MODIFIER` / `POP_TIMECYCLE_MODIFIER` | 29 / 266 | 102 / 490 | Save the current modifier and put it back (the car mod shops) |
| `SET_NEXT_PLAYER_TCMODIFIER`, `SET_PLAYER_TCMODIFIER_TRANSITION`, `SET_CURRENT_PLAYER_TCMODIFIER` | 124, 33, 33 | 392, 40, 36 | A second, player-owned modifier layer (**Known**: used by Online transitions and the character switch) |
| `SET_EXTRA_TCMODIFIER` | 6 | 9 | A third modifier layer |
| `ADD_TCMODIFIER_OVERRIDE` / `CLEAR_ALL_TCMODIFIER_OVERRIDES` | 8 / 6 | 17 / 28 | Swap one modifier for another everywhere (for example an interior's lights-off look) |
| `TRIGGER_SCREENBLUR_FADE_OUT`, `IS_SCREENBLUR_FADE_RUNNING` | 268, 264 | 1,060, 518 | The pause and phone background blur |
| `SET_NIGHTVISION`, `SET_SEETHROUGH` | 315, 319 | 1,165, 1,192 | Night and thermal vision (shared helper code, so most scripts carry a call) |
| `SET_ARTIFICIAL_LIGHTS_STATE` | 8 | 29 | City blackout (Online missions) |

Counts are **Verified**; the Use column is **Known**, from the native names and the scripts that call them.

The post effects scripts play most (scripts that name each one, of 142 distinct names): `FocusOut` 142, `FocusIn` 135, `DeathFailMPIn` 83, `DeathFailMPDark` 83, `CamPushInNeutral` 74, `MinigameTransitionIn` 40, `SuccessMichael`, `SuccessFranklin` and `SuccessTrevor` 29 each (the mission-passed screen), `MinigameTransitionOut` 27, `MinigameEndNeutral` 24, `MP_Celeb_Preload_Fade` 20.

The modifiers scripts set most by literal name (117 distinct): `CAMERA_secuirity_FUZZ` 92 scripts and `CAMERA_secuirity` 41 (security camera views, spelled that way in the files), and the ten `spectator1` to `spectator10` looks in 70 scripts each (Online spectator cams). Most `SET_TIMECYCLE_MODIFIER` calls pass a variable, so these counts are a floor.

**Known (engine):** there is one script modifier slot (`SET_TIMECYCLE_MODIFIER` replaces whatever a script set before), separate from the modifier the map applies where you stand, the player modifier layer, and the extra layer; the game mixes all of them on top of the weather timecycle. Animated post effects run on top of that and several can play at once.

## What this means for modders

- **Use what exists.** 252 post effects and 1,072 modifiers are already in the game. Search `animpostfx.ymt` and `timecycle_mods_*.xml` (extract them with CodeWalker) for a look, then call it by name. The names are case-insensitive.
- **Clean up.** A modifier you set stays until something clears it, including after your script ends: always pair `SET_TIMECYCLE_MODIFIER` with `CLEAR_TIMECYCLE_MODIFIER`, and a looped `ANIMPOSTFX_PLAY` with `ANIMPOSTFX_STOP`. `respawn_controller` clears the script modifier after death or arrest, so re-apply yours after a respawn (R2.6).
- **Don't fight the game's own effects.** Missions, the phone camera, the car mod shops (`PUSH`/`POP`) and the character switch all use the same slot. If your mod keeps a modifier on, check `GET_TIMECYCLE_MODIFIER_INDEX` and back off while a mission or a shop owns it.
- **New looks are data edits.** Add a `<modifier>` to a copy of a `timecycle_mods_*.xml` from `update.rpf`, or edit a `w_<weather>.xml` row; replace the file through a `dlc_patch` or the mods folder. Rockstar ships new modifiers by growing the update copies, not through DLC packs; add-on packs can register their own file with a `TIMECYCLEMODS_FILE` entry in `content.xml` (**Known**: the type isn't used by any vanilla pack).
- **Cost:** modifiers that raise bloom, depth of field, motion blur or ambient occlusion cost GPU time; most only change numbers in a blend and cost nothing (**Known**). Visual mods that replace the weather timecycles with heavy depth of field and bloom are a common reason for lost frames on weak PCs.
- **Single player only.** The look of Online is the same files, but mods that change them must stay out of GTA Online.

## Open questions

| Question | Where it goes |
| --- | --- |
| What the two numbers on each modifier line mean (value and strength? value at two ends of a range?) | Second pass: test with a modifier that sets one variable |
| What `userFlags` 1, 2, 4, 8 and 16 do | Second pass: compare the modifiers in each group |
| The game hours of the 13 keyframes | Second pass: test card 2 |
| What the 39 unnamed post effects are, and whether anything plays them | Second pass: hash lists from other sources |
| How many timecycle boxes and interior room modifiers the map has | R4.6 (map data) |
| `GroupId` and `EventType` on post effects | Second pass |

## Test cards

1. **One modifier.** In a script, call `SET_TIMECYCLE_MODIFIER("underwater")` on land, then `SET_TIMECYCLE_MODIFIER_STRENGTH` from 0.0 to 1.0 in steps. Expected: the blue underwater look fades in with the strength; `CLEAR_TIMECYCLE_MODIFIER` removes it.
2. **Keyframes.** With `PAUSE_CLOCK(true)` and weather `EXTRASUNNY` locked, set each hour from 0 to 23 with `SET_CLOCK_TIME` and screenshot the same view. Expected: the sky changes in steps at the keyframe hours and blends between them.
3. **A post effect.** `ANIMPOSTFX_PLAY("DrugsMichaelAliensFight", 0, true)`, wait, then `ANIMPOSTFX_STOP`. Expected: the pulsing drug look from Michael's alien-fight scene, which stops cleanly.
