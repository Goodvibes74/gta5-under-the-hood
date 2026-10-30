# Streaming: how assets get into memory

How GTA V loads what it needs while you play: models, textures, map sections and IPLs, interiors, collision, animations and effects; how scripts ask for them, how Rockstar's scripts wait for them, load scenes and streaming focus, LOD settings, and why pop-in and streaming hitches happen. Roadmap topic **R1.5** in the [roadmap](/ROADMAP.md). Builds on [memory, pools and limits](/docs/core/memory-and-pools.md) (the pools and streaming stores) and [archives and content](/docs/core/archives-and-content.md) (where the files live); feeds R18.3 (memory and VRAM) and R18.8 (load times).

**How it was made.** Native use from [`tools/native-usage.ps1`](/tools/README.md) ([native usage](/scripting/native-usage.md), build 3725). Blocking vs polling counted with `git grep` on the decompile (commit `6c18d3e8b`): `while (!NS::HAS_..._LOADED(` against `if (...HAS_..._LOADED(`. Rockstar's load-scene pattern read in `family1`. Example numbers from a low-end test PC's `settings.xml` and a monitoring script's log. What the engine does internally (budgets, priorities) is **Known**; counts and script patterns are **Verified**.

## 10.1 Short version

- **Everything is request, check, release.** Every asset type has a `REQUEST_*`, a `HAS_*_LOADED` and a `REMOVE_*` (or `SET_MODEL_AS_NO_LONGER_NEEDED`). The engine loads in the background; the script only asks and checks.
- **Rockstar's scripts almost never block on a load.** `HAS_MODEL_LOADED` is checked in an `if` 16,545 times but waited on in a `while` loop only 294 times (1.7%); `HAS_ANIM_DICT_LOADED` 8,720 against 143. Missions request early and move on to the next stage when the check passes. Blocking loops appear behind fades and loading screens.
- **Models and animations are the bulk:** `REQUEST_MODEL` and `HAS_MODEL_LOADED` in 739 scripts each, `SET_MODEL_AS_NO_LONGER_NEEDED` 23,990 calls in 697 scripts, `REQUEST_ANIM_DICT` in 682.
- **Load scenes move the streaming focus.** `NEW_LOAD_SCENE_START(_SPHERE)` preloads a place before a teleport or a cut (584 scripts check one), `SET_FOCUS_POS_AND_VEL` / `CLEAR_FOCUS` make the streamer load around a point other than the player (294 / 446 scripts), streaming volumes (`STREAMVOL_*`) and SRLs (streamed request lists, for cutscenes and the character switch) do the same for shapes and timelines. `LOAD_SCENE` blocks and is used only behind a fade.
- **Map sections are IPLs.** Scripts request 371 different IPL names (`REQUEST_IPL` in 407 scripts); interiors are kept in memory with `PIN_INTERIOR_IN_MEMORY` (359 scripts).
- **Pop-in and streaming hitches come from memory and bandwidth,** not from the pools: when the streamer can't keep up (low memory, a slow disk, a fast camera), low-detail models stay on screen; when a script waits for something big mid-play, the frame stalls (**Known** mechanism; the stall was measured on a test PC, 10.6).
- **Settings that control it:** distance scaling (`LodScale`), extended distance scaling (`MaxLodScale`), `PedLodBias`, `VehicleLodBias`, high-detail streaming while flying (`HdStreamingInFlight`) and population density (`CityDensity`) in `settings.xml`.

## 10.2 What streams, and how scripts ask for it

| Asset | Files | Request / check / release | Scripts using the request (build 3725) |
| --- | --- | --- | ---: |
| Models (peds, vehicles, props) | `.ydr`, `.yft`, `.ydd`, archetypes in `.ytyp` | `REQUEST_MODEL` / `HAS_MODEL_LOADED` / `SET_MODEL_AS_NO_LONGER_NEEDED` | 739 |
| Animation dictionaries | `.ycd` | `REQUEST_ANIM_DICT` / `HAS_ANIM_DICT_LOADED` / `REMOVE_ANIM_DICT` | 682 |
| Clip sets, anim sets (movement styles) | | `REQUEST_CLIP_SET`, `REQUEST_ANIM_SET` | 193, 50 |
| Particle effects | `.ypt` | `REQUEST_NAMED_PTFX_ASSET` / `HAS_NAMED_PTFX_ASSET_LOADED` / `REMOVE_NAMED_PTFX_ASSET` | 276 |
| Map sections (IPLs) | `.ymap` | `REQUEST_IPL` / `IS_IPL_ACTIVE` / `REMOVE_IPL` | 407 |
| Interiors | `.ymap` + `.ytyp` | `PIN_INTERIOR_IN_MEMORY` / `IS_INTERIOR_READY` / `UNPIN_INTERIOR` | 359 |
| Collision | `.ybn` | `REQUEST_COLLISION_AT_COORD`, `HAS_COLLISION_LOADED_AROUND_ENTITY` | 262, 93 |
| A whole area | (everything around a point) | `NEW_LOAD_SCENE_START(_SPHERE)` / `IS_NEW_LOAD_SCENE_LOADED` / `NEW_LOAD_SCENE_STOP` | 345 sphere, 137 frustum |
| Texture dictionaries for 2D drawing | `.ytd` | `REQUEST_STREAMED_TEXTURE_DICT` / `HAS_STREAMED_TEXTURE_DICT_LOADED` | (HUD and menus) |
| Cutscenes | `.cut` + assets | `REQUEST_CUTSCENE` / `HAS_CUTSCENE_LOADED` ([cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md)) | 420 play one |
| Vehicle recordings | `.yvr` | `REQUEST_VEHICLE_RECORDING` / `HAS_VEHICLE_RECORDING_BEEN_LOADED` | (missions with chases) |

All of these load asynchronously: the request returns at once and the engine streams in the background (**Known**). A request with no release keeps the asset in memory until the script ends (**Known**: scripts' requests are cleaned up on termination), which is why long-running mods must release what they no longer use.

## 10.3 How Rockstar waits: polling, not blocking

| Check | In an `if` | In a `while (!...)` loop | Share blocking |
| --- | ---: | ---: | ---: |
| `HAS_MODEL_LOADED` | 16,545 | 294 | 1.7% |
| `HAS_ANIM_DICT_LOADED` | 8,720 | 143 | 1.6% |
| `IS_NEW_LOAD_SCENE_LOADED` | 332 | 76 | 19% |
| `HAS_COLLISION_LOADED_AROUND_ENTITY` | 140 | 2 | 1.4% |
| `IS_SRL_LOADED` | 109 | 1 | 0.9% |
| `STREAMVOL_HAS_LOADED` | 11 | 43 | 80% |

The usual shape is the mission stage machine from [mission anatomy](/docs/gameplay/missions/mission-anatomy.md): stage N requests what stage N+1 needs; each frame, the stage checks `HAS_..._LOADED` for everything and only then creates entities and moves on. The frame never waits. Blocking loops are kept for moments the player can't see: load scenes and streaming volumes (19% and 80% blocking) are waited on behind a fade, often with a minimum time. `family1` shows both:

- After its yacht cutscene it calls `NEW_LOAD_SCENE_START` at the next scene's camera (range 80), requests three vehicle recordings, then waits until `IS_NEW_LOAD_SCENE_LOADED()` **and** at least 2,000 ms have passed, before continuing.
- Its fade-in helper calls `CLEAR_AREA` and the blocking `LOAD_SCENE` at the player's position only while `IS_SCREEN_FADED_OUT()`, then fades in over 500 ms.

`SET_GAME_PAUSES_FOR_STREAMING` (30 scripts) lets the game itself pause for streaming; scripts switch it off around sequences that must not stop.

## 10.4 Streaming focus, load scenes, volumes and SRLs

The streamer loads around the **focus**, normally the player (or the camera). Scripts move it when the player is about to be somewhere else:

| Tool | What it does | Scripts |
| --- | --- | ---: |
| `SET_FOCUS_POS_AND_VEL` / `SET_FOCUS_ENTITY` / `CLEAR_FOCUS` | Stream around a point or entity instead of the player (for a camera far away, a teleport target) | 294 / 272 / 446 |
| `NEW_LOAD_SCENE_START_SPHERE` / `NEW_LOAD_SCENE_START` | Preload a sphere, or a view frustum from a position and direction, without moving the focus; the stage polls `IS_NEW_LOAD_SCENE_LOADED` | 345 / 137 |
| `LOAD_SCENE` | Load around a point **now** (blocks the script) | 47 |

The sphere load scene's usual arguments: radius 20 with flag 1 (497 calls), radius 50 (123), 25 (33); the frustum version usually 35 (60), 300 (53) or 5,000 (22, long views from the air) (**Verified**, argument counts in the decompile).

| Tool | What it does | Scripts |
| --- | --- | ---: |
| `STREAMVOL_CREATE_SPHERE` / `STREAMVOL_CREATE_FRUSTUM` | A streaming volume that keeps an area loaded while it exists | 54 / 26 |
| `PREFETCH_SRL` / `BEGIN_SRL` / `IS_SRL_LOADED` / `END_SRL` | A streamed request list: a recorded list of what a camera path will need, loaded ahead along a timeline (13 SRL names in scripts) | 20 / 17 / 104 / 105 |
| `START_PLAYER_SWITCH` and the `SWITCH_*` family | The sky-camera character switch, which streams the destination while the camera is up | 291 |
| `LOAD_ALL_OBJECTS_NOW` | Finish all pending requests at once (blocks) | 270 |

### 10.4.1 The SRLs (second pass)

**Where they are** (**Verified**, build 3725). The list of streamed request lists is a data file, `common\data\streaming\srllist.meta` in `update.rpf` (a `CStreamingRequestMasterList`), loaded with the content type `STREAMING_REQUEST_LISTS_FILE`. It names **207 SRLs**, each a file `<name>_srl.ymt` under `levels\gta5\streaming\` (206 entries point into the base archives, `platform:`; one, `mic_1_mcs_1_srl`, points into `update.rpf`). **14 DLC packs** add their own `srllist.meta` (`mpheist`, `mpheist3`, `mpheist4`, `mpluxe`, `mplowrider`, `mpbattle`, `mpchristmas2017`, `mpchristmas3`, `mpsecurity`, `mpvinewood`, `mp2023_02`, `mp2024_02`, `mp2025_01`, `mp2025_02`), and `mpluxe`'s `dlc_patch` folder holds a newer `gtao_intro_male_srl.ymt`.

**What they cover.** 183 of the 207 are named after a **cutscene** (`fam_1_int_srl`, `trv_2_mcs_4_concat_srl`, `ep_7_rcm_srl` ...: the `_int`, `_ext`, `_mcs_`, `_rcm`, `_ig_` parts are the cutscene names; the GTA Online intro, `GTAO_INTRO_MALE` and `GTAO_INTRO_FEMALE`, is one of them), so a cutscene's camera path has its assets loaded ahead. The other 24 are scripted camera moves: custom character switches (`carsteal1_customswitch`, `exile1_customswitch`, `fin_2b_customswitch`, `mike2_mike_to_frank`, `michaeltofiretruck`), set pieces (`ah3bHeliCrash`, `ex3crash`, `JHRAMPDOWNSCENE`, `family_2_Timelapse`, `trafficControl`, `fbi_4_binoculars`, the cable car `cablecar_up` and `cablecar_down`, `CHI1_Methlab_Arrival`, `finbconf`, `extreme3_outro` ...).

**Which scripts start one by name.** `PREFETCH_SRL` names **20 SRLs** in the decompile: 13 written in the call and 7 held in a variable (resolved by reading where the variable is set):

| SRL | Script |
| --- | --- |
| `GTAO_INTRO_MALE` | `fm_intro`, `maintransition`, `selector` (and the dev copy `fm_intro_cut_dev`) |
| `chinese2_farmhouse_cutscene`, `chinese2_explosion_cutscene` | `chinese2` |
| `chi_1_mcs_1`, `CHI1_Methlab_Arrival` | `chinese1` |
| `TREV3_TRAILER_ARRIVAL_CUTSCENE` | `trevor3` |
| `JHRAMPDOWNSCENE` | `jewelry_heist` |
| `family_2_Timelapse_srl` | `family2` |
| `finbconf` | `finaleb` |
| `ah3bHeliCrash` | `agency_heist3b` |
| `michaelToFiretruck` | `agency_heist3a` |
| `ass_construction` | `assassin_construction` |
| `cablecar_up`, `cablecar_down` | `cablecar` |
| `carsteal1_customswitch`, `exile1_customswitch`, `fin_2b_customswitch` | `carsteal1`, `exile1`, `finale_heist2b` |
| `fbi_4_binoculars` | `fbi4` |
| `mph_hum_key_mcs1_Script_srl`, `MPH_TUT_EXT_SRL` | `fmmc_launcher`, `fm_mission_controller` (Online heists; these two come from a DLC list) |

The cutscene SRLs aren't named by any script: *Known*, the cutscene system uses the SRL that matches the cutscene's name by itself.

## 10.5 IPLs, interiors and LOD

- **IPLs** are optional map sections (`.ymap`) switched on and off by name: damaged and repaired buildings, interiors' shells, event props, the Online map additions. 371 distinct names are requested in the scripts; `IS_IPL_ACTIVE` is checked 7,158 times. Requesting an IPL is cheap; loading its contents happens when the focus is near (**Known**).
- **`ON_ENTER_MP` / `ON_ENTER_SP`** (3 scripts each) switch the whole map between its story and Online states, one blocking step; on a low-end test PC this was an 8.6 s frame behind a loading screen ([measuring performance](/docs/performance/measuring.md#reading-a-session-an-example-from-a-low-end-test-pc)).
- **Interiors** are pinned with `PIN_INTERIOR_IN_MEMORY` before the player enters (359 scripts) and released with `UNPIN_INTERIOR`; `IS_INTERIOR_READY` says when.
- **LOD** (level of detail): each archetype has LOD distances; `SET_ENTITY_LOD_DIST` (266 scripts) changes one entity's, `OVERRIDE_LODSCALE_THIS_FRAME` (71) the whole view's for cameras and cutscenes. The player's settings scale them: `LodScale` (distance scaling), `MaxLodScale` (extended distance scaling), `PedLodBias`, `VehicleLodBias`, and `HdStreamingInFlight` (high-detail streaming while flying) in `settings.xml` (**Known** mapping to the menu).
- **Population budgets:** `SET_PED_POPULATION_BUDGET` / `SET_VEHICLE_POPULATION_BUDGET` (70 / 76 scripts) and `SET_REDUCE_PED_MODEL_BUDGET` / `SET_REDUCE_VEHICLE_MODEL_BUDGET` (47 / 49) cut how many different ambient models the streamer keeps, freeing memory for a mission's own assets.

## 10.6 Example: a low-end test PC

| What | Value | Note |
| --- | --- | --- |
| `settings.xml` `LodScale`, `MaxLodScale`, `CityDensity` | 0.0 each | The lowest values: short draw distance and minimal population (33 to 34 peds counted) |
| `TextureQuality` | 2 | **Known**: the file's scale is said to run 0 Normal, 1 High, 2 Very High; check it against the menu, because textures cost the most shared memory on integrated graphics |
| An Online-style mod switching the map | 98 `REQUEST_IPL` and 50 `REMOVE_IPL` in two seconds after `ON_ENTER_MP` | All behind a loading screen: fine |
| The same mod loading an animation dictionary mid-play | `oddjobs@shop_robbery@rob_till` took 3,360 ms, and a 1,403 ms frame was logged at the same second | The one streaming hitch felt in play |
## 10.7 What this means for modders

The Rockstar recipe in C# (SHVDN v3):

```csharp
// Stage 1: request early, during a fade or at mission start.
var model = new Model("g_m_m_armgoon_01");
model.Request();
Function.Call(Hash.REQUEST_ANIM_DICT, "oddjobs@shop_robbery@rob_till");

// Every tick: check, don't wait. Move on only when everything is in.
if (model.IsLoaded && Function.Call<bool>(Hash.HAS_ANIM_DICT_LOADED, "oddjobs@shop_robbery@rob_till"))
{
    Ped p = World.CreatePed(model, spawnPos);
    model.MarkAsNoLongerNeeded();   // the ped keeps its model; the request is released
    stage++;
}

// Teleports and cuts: fade out, preload the destination, wait with a minimum time, fade in.
Function.Call(Hash.NEW_LOAD_SCENE_START_SPHERE, dest.X, dest.Y, dest.Z, 50f, 0);
// ...poll IS_NEW_LOAD_SCENE_LOADED (with a timeout), then NEW_LOAD_SCENE_STOP and fade in.
```

- **Don't block in the middle of play.** `model.Request(1000)` and loops on `IsLoaded` are fine behind a fade; in play, request a stage ahead and poll.
- **Release what you requested:** `MarkAsNoLongerNeeded`, `REMOVE_ANIM_DICT`, `REMOVE_NAMED_PTFX_ASSET`, `UNPIN_INTERIOR`, `CLEAR_FOCUS`, `NEW_LOAD_SCENE_STOP`. A mod that never releases leaks streaming memory for the whole session.
- **Always time out.** Every wait needs a limit (Rockstar's use `TIMERA` or the game timer); a model that never loads (bad name, full memory) must not hang a mod.
- **Batch IPL switches behind a loading screen** the way the Online switch does; toggling IPLs in view causes visible pop-in.
- **Preload mission assets a stage early** (or behind the loading screen at the start), so nothing big is requested in the middle of play.

## 10.8 Open questions

| Question | Where it goes |
| --- | --- |
| How `TextureQuality` values map to the menu, and how much memory each level takes on shared graphics | R18.2, R18.3 |
| The streaming memory budget (how the engine splits RAM between stores), and what HeapAdjuster changes in it | R18.3 |
| Which SRLs exist (13 names in scripts) and what each covers | Answered in [10.4.1](#1041-the-srls-second-pass): 207 in the base list plus 14 DLC lists; 20 started by name |
| Measure a pop-in case: drive fast through the city at `LodScale` 0 and 0.5 with a frame-time log, compare hitches and memory | Test card below, R18.2 |

## 10.9 Test cards

1. **Preload fixes the hitch:** in a mod that requests an animation dictionary mid-play, move the request one stage earlier and check with a frame-time log that the hitch at that moment is gone.
2. **LOD and pop-in:** drive the same 60-second route with distance scaling at its current value and at the middle of the slider; compare logged hitches and memory, and note how much pop-in you see.
