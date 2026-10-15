# Natives as the engine API: kinds, contracts and costs

What a native can and can't do once you know its name: the kinds of native (questions, commands, create and delete, ask-then-wait, one-frame, deferred results, network), the contracts Rockstar's own scripts keep with the engine, which natives are slow or risky, and what each big family can't do at all. Roadmap topic **R1.3** in the [roadmap](/ROADMAP.md). Builds on [native functions](/scripting/natives.md) (guide 05: reading and calling a native), [native usage](/scripting/native-usage.md) (R0.3: who calls what) and the [native namespace map](/scripting/native-namespace-map.md) (R0.8: what each namespace covers). This page doesn't repeat those; it adds the rules for using natives well.

**How it was made.** The per-native tables of [native usage](/scripting/native-usage.md) (build 1.0.3725.0, decompile commit `6c18d3e8b`: 6,573 named natives, 12,297,197 calls in 1,013 scripts) were grouped by name pattern (`REQUEST_*`, `HAS_*_LOADED`, `*_THIS_FRAME`, `*_NO_LONGER_NEEDED` ...) and summed with `awk`. How Rockstar's scripts use a family was read in the scripts named below (the race creator and race controller, the job lobby; see [R7.11](/docs/online/creator-internals.md), R7.5). Counts are **Verified**. What a native does inside the engine (its cost, what happens if it's misused) is **Known**: community knowledge from NativeDB and modding practice, not measured here.

## 14.1 Short version

- **Seven kinds of native,** and the kind decides how to call it: questions (`IS_`, `GET_`, `DOES_`), commands (`SET_`), create and delete, **ask-then-wait** (`REQUEST_` then `HAS_..._LOADED`, 48 and 23 natives), **one-frame** (`*_THIS_FRAME`, 96 natives that last a single frame), **deferred results** (`START_SHAPE_TEST_*` then `GET_SHAPE_TEST_RESULT`), and network natives (857 in `NETWORK`).
- **Rockstar checks before it touches:** `DOES_*_EXIST` (25 natives) is called 361,843 times and `IS_ENTITY_DEAD` / `IS_PED_INJURED` 219,909 times: about 1 call in 21 of all native calls is a guard. `DOES_ENTITY_EXIST` alone is in 929 scripts.
- **Everything loaded is released:** `REQUEST_MODEL` (739 scripts, 19,952 calls) is matched by `HAS_MODEL_LOADED` (739 scripts) and `SET_MODEL_AS_NO_LONGER_NEEDED` (697 scripts, 23,990 calls). Animation dictionaries the same way (`REQUEST_ANIM_DICT` 682 scripts, `REMOVE_ANIM_DICT` 575).
- **Everything created is cleaned up:** `CREATE_PED` / `_VEHICLE` / `_OBJECT` (13,898 calls) against `DELETE_*` (25,506) and `SET_*_AS_NO_LONGER_NEEDED` (4,278 for peds, vehicles and objects).
- **One-frame natives must be called every frame:** the most used are `HIDE_HUD_COMPONENT_THIS_FRAME` (593 scripts), `HIDE_HUD_AND_RADAR_THIS_FRAME` (477) and `DISABLE_FRONTEND_THIS_FRAME` (306).
- **The few natives Rockstar treats as heavy are named for it:** `START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE` (218 scripts, 248 calls) against the deferred `START_SHAPE_TEST_*` family (4,523 calls); area scans (`GET_CLOSEST_*`, 3,697 calls; `CLEAR_AREA*`, 8,120) are used at set-up moments, not every frame.
- **Network natives are off-limits for mods:** `NETWORK` has 857 natives and 600,182 calls; `NETWORK_IS_GAME_IN_PROGRESS` alone is in 905 scripts. In story mode they answer "no session"; using the ones that act on Online services risks a ban.

## 14.2 The seven kinds

| Kind | How to recognise it | Natives | Calls | How to call it |
| --- | --- | ---: | ---: | --- |
| Question | `IS_`, `GET_`, `DOES_`, `HAS_` | most | | Any time, on the script thread; returns a value |
| Command | `SET_`, `CLEAR_`, `ENABLE_`, `DISABLE_` | most | | Changes state that stays until changed back |
| Create and delete | `CREATE_` (44), `DELETE_` (14) | 58 | 69,262 | Model loaded first; keep the handle; delete or release later |
| Ask, then wait | `REQUEST_` (48) with `HAS_..._LOADED` (23) | 71 | 104,819 | Ask, then check once per frame until loaded; never block in a loop without `WAIT(0)` |
| One frame | `*_THIS_FRAME` | 96 | 56,900 | Call every frame for as long as you want the effect |
| Deferred result | `START_SHAPE_TEST_*` (7) with `GET_SHAPE_TEST_RESULT` | 8 | 7,967 | Start one test, read its result on a later frame (result 2 = ready) |
| Network | `NETWORK_*` | 871 | 413,392 | Online only |

Counts are **Verified** sums over the named natives. "One frame" and "deferred" are named that way by Rockstar; the rule "call every frame" is **Known** and visible in the scripts (each call sits inside a per-frame loop).

## 14.3 Contracts Rockstar keeps

These pairs show up together across the scripts (**Verified**, scripts and calls):

| Step | Natives | Scripts | Calls |
| --- | --- | ---: | ---: |
| Ask for a model | `REQUEST_MODEL` | 739 | 19,952 |
| Wait for it | `HAS_MODEL_LOADED` | 739 | 20,953 |
| Check it exists first | `IS_MODEL_VALID`, `IS_MODEL_IN_CDIMAGE` | 481, 159 | 3,924, 474 |
| Release it | `SET_MODEL_AS_NO_LONGER_NEEDED` | 697 | 23,990 |
| Animations | `REQUEST_ANIM_DICT`, `HAS_ANIM_DICT_LOADED`, `REMOVE_ANIM_DICT` | 682, 677, 575 | 11,469, 11,746, 11,699 |
| Own what you make | `SET_ENTITY_AS_MISSION_ENTITY`, `IS_ENTITY_A_MISSION_ENTITY`, `DOES_ENTITY_BELONG_TO_THIS_SCRIPT` | 619, 572, 517 | 5,152, 5,638, 2,488 |
| Clean up | `DELETE_PED` / `_VEHICLE` / `_OBJECT` | 594, 538, 550 | 7,781, 6,130, 11,595 |
| Or hand back to the world | `SET_PED_` / `_VEHICLE_` / `_OBJECT_` / `_ENTITY_AS_NO_LONGER_NEEDED` | 324, 506, 246, 217 | |
| Child scripts | `REQUEST_SCRIPT`, `SET_SCRIPT_AS_NO_LONGER_NEEDED` | 311, 351 | 1,063, 1,644 |
| Be told to stop | `HAS_FORCE_CLEANUP_OCCURRED` | 508 | 515 |
| Time | `GET_GAME_TIMER` (milliseconds), `GET_FRAME_TIME` (seconds this frame) | 912, 466 | 39,354, 4,373 |

Thirteen `*_NO_LONGER_NEEDED` natives exist (models, peds, vehicles, objects, entities, scripts, scaleform movies, texture dictionaries, mission trains, network objects). What "no longer needed" means (**Known**): the engine may unload the asset or let the population code delete the entity when nothing else holds it; it doesn't happen at once.

**Why the guards matter.** A handle is a number. After the engine deletes an entity (despawn, cleanup by another script) the number is stale, and passing it to a command can do nothing, act on another entity that reused the slot, or crash (**Known**). Rockstar checks `DOES_ENTITY_EXIST` (929 scripts, 314,998 calls) and `IS_ENTITY_DEAD` (926 scripts) before using a handle, almost everywhere.

## 14.4 Slow, heavy or risky natives

| Native or family | Rockstar's use | Why to be careful (**Known** unless stated) |
| --- | --- | --- |
| `START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE` | 218 scripts, 248 calls | Runs the ray test at once and blocks the script; the creator's cursor uses it once per frame ([R7.11](/docs/online/creator-internals.md)). Prefer `START_SHAPE_TEST_LOS_PROBE` (171 scripts) and read the result next frame |
| `GET_CLOSEST_*` (10 natives) | 3,697 calls; `GET_CLOSEST_OBJECT_OF_TYPE` in 349 scripts | Searches nearby entities; fine once, costly every frame with a big radius |
| `GET_PED_NEARBY_PEDS`, `_VEHICLES` | 389 and 358 scripts | Fill a fixed-size array; the array's first value must hold its size |
| `CLEAR_AREA*` (7) | 8,120 calls, 539 scripts | Deletes everything in a sphere, including other scripts' unowned entities |
| `GET_GROUND_Z_FOR_3D_COORD` | 549 scripts, 8,901 calls | Only works where collision is loaded; returns false far from the player. Rockstar loads collision first (`REQUEST_COLLISION_AT_COORD`, 262 scripts) |
| Load scenes: `NEW_LOAD_SCENE_START_SPHERE`, `LOAD_SCENE` | 345 and 47 scripts | Stream a whole area; `LOAD_SCENE` blocks until done. Rockstar mostly uses the non-blocking `NEW_LOAD_SCENE_*` and polls `IS_NEW_LOAD_SCENE_LOADED` (383 scripts) ([streaming](/docs/core/streaming.md)) |
| `SET_FOCUS_POS_AND_VEL` | 294 scripts, 6,529 calls | Moves the streaming focus; always paired with `CLEAR_FOCUS` (446 scripts) |
| `REQUEST_PATH_NODES_IN_AREA_THIS_FRAME` | 328 scripts | Path nodes are streamed; route queries far away fail until requested |
| `SET_GAME_PAUSED`, `SET_TIME_SCALE` | 195 and 125 scripts | Global; a mod that forgets to undo them leaves the game paused or slowed |
| Unnamed natives (`_NAME` or `unk_0x...`) | 170 natives, 52,553 calls | Names and parameters are guesses; test before relying on them |
| `NETWORK_*`, `NET_GAMESERVER_*`, `MONEY` | 857 natives in `NETWORK` | Online services. **Never call the ones that act** (transactions, sessions, stats on the server) |

Debug natives (`SET_PED_NAME_DEBUG` in 94 scripts, `PRINT*`) are left in the scripts but do nothing in the retail game (**Known**), so they are safe to see and useless to call.

## 14.5 What each family can't do

The namespaces are listed in the [namespace map](/scripting/native-namespace-map.md). Their limits (**Known** unless a count is given):

| Family | Can | Can't |
| --- | --- | --- |
| `ENTITY`, `PED`, `VEHICLE`, `OBJECT` | Create, move, change and delete entities; read their state | List every entity in the world: scripts only get nearby lists (`GET_PED_NEARBY_*`) or closest-of-type. Script hooks add pool access from outside (see [C# with ScriptHookVDotNet](/scripting/csharp-shvdn3.md)) |
| `STREAMING` | Load and release models, animations, IPLs, collision, scenes | Load a file that isn't in an archive or the mods folder; assets must be registered by the content system ([archives and content](/docs/core/archives-and-content.md)) |
| `TASK` (150 natives, 70,018 calls) | Give peds orders, sequences and behaviour | Change the AI's tuning files at run time; tasks are requests the AI may drop (watch with `GET_SCRIPT_TASK_STATUS`) |
| `CAM` | Script cameras, the gameplay camera, shakes, fades | Keep a script camera without `RENDER_SCRIPT_CAMS`; it is a layer over the game's cameras ([cameras](/docs/rendering/cameras.md)) |
| `GRAPHICS` | Markers, lines, sprites, particle effects, decals, post effects | Draw anything that lasts: every `DRAW_*` call lasts one frame |
| `HUD` | Text, help, blips, the radar, the feed | Show text that isn't in a loaded text block without the "literal string" commands ([text labels](/docs/ui/text-labels.md)) |
| `SHAPETEST` | Ray, box, capsule and sphere tests against collision | Test what isn't streamed in: far collision isn't loaded |
| `DATAFILE` | Build and read JSON for UGC and the cloud | Read or write arbitrary files on disk; it serves Rockstar's cloud and the local UGC files ([R7.11](/docs/online/creator-internals.md)). Mods use their own file access through the script hook |
| `STATS` | Read and write stats (`STAT_SET_INT` 774 scripts, `STAT_GET_INT` 792) | Make Online stats safe to change: Online stats are checked by the server ([stats and tunables](/docs/online/stats-and-tunables.md)) |
| `NETWORK` | Everything Online | Anything useful in story mode; with no session most return false |

## 14.6 What this means for modders

- **Follow Rockstar's contracts:** request and poll (never a tight loop without `WAIT(0)`), release what you load, delete or release what you create, check handles with `DOES_ENTITY_EXIST` before use, and listen for force cleanup. The counts above show Rockstar doing exactly this in hundreds of scripts.
- **Call one-frame natives every frame,** and draw every frame: a `*_THIS_FRAME` or `DRAW_*` call made once shows for a single frame.
- **Prefer deferred shape tests** over the synchronous one inside per-frame code on a weak PC.
- **Use area scans and `CLEAR_AREA` at set-up time,** with small radii.
- **Stay off `NETWORK`, `NET_GAMESERVER` and `MONEY`.** Single player only.

## 14.7 Open questions

| Question | Where it goes |
| --- | --- |
| Measured cost of the heavy natives (synchronous shape test, `GET_CLOSEST_*`, load scenes) on a low-end PC | R18 performance topics, an in-game timing test |
| Which natives crash on a stale handle and which fail quietly | In-game tests, one family at a time |
| The size limits of the nearby-entity arrays | In-game test |

## 14.8 Test cards (story mode, a script mod)

Not run yet.

1. **One-frame natives.** Call `HIDE_HUD_AND_RADAR_THIS_FRAME` once on a key press. Expected: nothing visible, or a one-frame flicker. Call it every tick while a key is held. Expected: the HUD stays hidden while held.
2. **Ask then wait.** Call `REQUEST_MODEL` for a model not nearby and count the ticks until `HAS_MODEL_LOADED` is true. Expected: a few ticks to many, depending on the disk; never zero for a model that wasn't loaded.
3. **Stale handle.** Create a ped, delete it, then call `DOES_ENTITY_EXIST` with the old handle. Expected: false.
