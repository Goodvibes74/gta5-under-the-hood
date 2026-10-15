# Rendering, visual settings and LOD

How a frame of GTA V is drawn at a high level, the 1,144 values in `visualsettings.dat` that tune lights, coronas, distant lights, imposters, the sky and depth of field, how level of detail and draw distance work (LOD distances, LOD lights, the LOD scale), and what Rockstar's scripts change about rendering. Roadmap topic **R13.1** in the [roadmap](/ROADMAP.md). The cost of each graphics setting is already in [graphics settings](/docs/performance/graphics-settings.md) (R18.2); this page covers what the settings act on. Builds on [timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md) (R13.2) and [map data](/docs/world/map-data.md) (R4.6: ymaps and LOD parents).

**How it was made.** `common\data\visualsettings.dat` from `common.rpf` and its newer copy in `update\update.rpf` (build 1.0.3725.0), extracted with [`tools/rpf-cw.ps1`](/tools/README.md), keys grouped by prefix with `awk`; the `lodlights.rpf` archives listed. Native counts from [native usage](/scripting/native-usage.md). Values and counts are **Verified**. The render pipeline description is **Known**: community analysis, chiefly Adrian Courrèges' [GTA V graphics study](https://www.adriancourreges.com/blog/2015/11/02/gta-v-graphics-study/), not checked here.

## 29.1 Short version

- **The renderer is deferred** (**Known**): the scene is first drawn into several G-buffer targets (colour, normals, specular, depth), then lights are added, then transparent objects, then post-processing (bloom, depth of field, motion blur, tone mapping) and the HUD. Shadows use cascaded shadow maps; reflections use a low-detail paraboloid environment map; water and mirrors are separate passes.
- **`visualsettings.dat` is a plain-text tuning file** of 1,144 `key value` lines in the update's copy (136 keys are new or changed against the base copy). The biggest groups: car lights (176), misc including coronas (115), plane lights (103), adaptive depth of field (77), camera (56), helicopter lights (53), distant lights (51), dark-time settings (45), searchlights (29 each for heli, default and boat), traffic lights (28), see-through (thermal) vision (26), peds (23).
- **Distant lights** (the far car and street light dots) are on from 20:00 to 06:00 (`distantlights.hourStart`, `hourEnd`), sized 0.8 and at least 8 pixels.
- **LOD lights** (lights on far buildings) come in three ranges: small 250 m, medium 750 m, large 2,500 m, with coronas to 150, 180 and 1,250 m; they're placed by ymaps in `x64\levels\gta5\lodlights.rpf` (`distlodlights_*`, `lodlights_*`).
- **Draw distance is per entity** (LOD distance in the ymap and archetype, [R4.6](/docs/world/map-data.md)), scaled by the "extended distance scaling" setting; `lod.container.caploddist` caps container LODs at 750. Scripts override the scale with `OVERRIDE_LODSCALE_THIS_FRAME` (71 scripts) and an entity's distance with `SET_ENTITY_LOD_DIST` (266).
- **What Rockstar's scripts touch most:** cascade shadow bounds (`CASCADE_SHADOWS_INIT_SESSION` 566 scripts, `CASCADE_SHADOWS_SET_CASCADE_BOUNDS` 247), paused render phases for menus and screenshots (`TOGGLE_PAUSED_RENDERPHASES` 409), depth of field (`SET_HIDOF_OVERRIDE` 253), decals off for a frame (248), and model budgets (`SET_REDUCE_PED_MODEL_BUDGET` 47, `_VEHICLE_` 49).

## 29.2 The pipeline (Known)

| Stage | What happens | Settings that change its cost ([R18.2](/docs/performance/graphics-settings.md)) |
| --- | --- | --- |
| Shadow maps | Four cascades from the sun; script can change the bounds | Shadow quality, soft shadows, long shadows, high-resolution shadows |
| Environment reflection | Low-detail paraboloid map around the camera | Reflection quality, reflection MSAA |
| G-buffer | Opaque geometry into several targets | Texture quality, MSAA, population density, distance scaling |
| Lighting | Sun, then lights read from the G-buffer; LOD lights far away | (lights are cheap per light, numerous at night) |
| Transparent and water | Glass, particles, water surface | Water quality, particles quality |
| Post-processing | SSAO, bloom, depth of field, motion blur, tone mapping | Ambient occlusion, post FX, motion blur |
| UI | HUD and Scaleform | |

## 29.3 `visualsettings.dat`

A line is a dotted key and a value (`trafficLight.near.radius 1.5`), `#` starts a comment. Groups in the update's copy (**Verified** line counts):

| Prefix | Lines | Tunes |
| --- | ---: | --- |
| `car` | 176 | Headlights, tail lights, interior lights, per-light intensities, ranges, cone angles |
| `misc` | 115 | Coronas (global size 0.75, intensity 0.5, z-bias), 3D marker lighting, height-based multipliers |
| `plane` | 103 | Aircraft lights and their coronas |
| `adaptivedof` | 77 | Adaptive depth of field |
| `cam` | 56 | Camera-related light and blur |
| `heli` | 53 | Helicopter lights |
| `distantlights` | 51 | Far light dots: size, hours, speed, density, twinkle |
| `dark` | 45 | Settings for dark scenes |
| `helisearchlight`, `defaultsearchlight`, `boatsearchlight` | 29 each | Searchlights |
| `trafficLight` | 28 | Near and far traffic lights (near fade 30 to 35 m, far fade 100 to 120 m) |
| `seeThrough` | 26 | Thermal vision |
| `ped`, `pedlight`, `pedFpslight`, `pedFootLight` | 23, 13, 13, 13 | Light around the player and peds |
| `puddles`, `rain` | 17, 14 | Wet surfaces |
| `Tonemapping`, `bloom`, `Adaptation`, `lensflare`, `bokeh` | 16, 7, 5, 4, 12 | Post-processing |
| `imposter` | 15 | Far-away imposter blend and shadows |
| `lodlight`, `lod` | 13, 8 | LOD lights and LOD caps |
| `sky`, `cloud` | 8, 5 | Sun disc, cloud warp and speed |

## 29.4 Level of detail

- **Entities** switch between high detail, LOD and super-LOD models at the distances stored in their ymap and archetype ([R4.6](/docs/world/map-data.md)); the player's "extended distance scaling" multiplies them (**Known**).
- **Containers** are capped at 750 m (`lod.container.caploddist`).
- **LOD lights** are a separate system so the city shows lights at night far beyond its LOD buildings: small, medium and large lights at 250, 750 and 2,500 m, fading over 50, 100 and 50 m (**Verified** values), placed by 200 ymaps in `x64e.rpf`'s `lodlights.rpf` (99 `lodlights_small`, `_medium`, `_large` ymaps, the matching 99 `distlodlights_*`, and two for the prologue; the `mp2025_02` patch adds another `lodlights.rpf`).
- **Distant lights** draw car and street lights along roads at night as dots, from 20:00 to 06:00.
- **Scripts:** `OVERRIDE_LODSCALE_THIS_FRAME` (71 scripts) for flights and cutscenes, `SET_ENTITY_LOD_DIST` (266 scripts, 1,017 calls) for props that must stay visible (the race player sets at least 150 m, [R7.11](/docs/online/creator-internals.md)), `SET_RENDER_HD_ONLY` (5).

## 29.5 What this means for modders

- **Lighting mods edit `visualsettings.dat` and the timecycles** ([R13.2](/docs/rendering/timecycle-and-post-effects.md)); both are data files placed in the mods folder. Keep a copy of the original: every update can change it (136 keys changed between the base and update copies in this build).
- **Draw distance mods** raise LOD distances or the LOD scale; this costs memory and draw calls first ([memory and video memory](/docs/performance/memory-and-vram.md)), so on a weak PC raise `distantlights` and `lodlight` ranges (cheap) before entity LOD distances (expensive).
- **For a scripted scene,** cap the shadow cascades and lower budgets the way Rockstar does (`CASCADE_SHADOWS_SET_CASCADE_BOUNDS`, `SET_REDUCE_PED_MODEL_BUDGET`), and reset them at cleanup.

## 29.6 Open questions

| Question | Where it goes |
| --- | --- |
| What each changed key between base and update copies does | Second pass, diff and in-game test |
| How "extended distance scaling" maps to the LOD scale value | In-game test with `GET_LODSCALE` |
| What popular lighting and graphics overhauls change in these files | A comparison, with each author's release page linked |
| Per-pass cost measured on a low-end PC | R18.1 measuring, with a frame capture tool |

## 29.7 Test cards (story mode)

1. **Distant lights.** Look over the city from a hill at 19:50 and at 20:10 game time. Expected: the road dots appear at 20:00.
2. **LOD scale.** Call `OVERRIDE_LODSCALE_THIS_FRAME(0.5)` every frame while flying. Expected: buildings switch to LOD models much closer.
