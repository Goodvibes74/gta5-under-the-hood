# Map data

How the GTA V map is stored: `.ymap` placement files and `.ytyp` archetype files, how they are split by area and level of detail, how DLC packs and patches add or replace parts of the map, what scripts switch on with IPLs, and where the restricted areas come from. Roadmap topic **R4.6** in the [roadmap](/ROADMAP.md). Builds on [streaming](/docs/core/streaming.md) (how map sections load and the IPL natives), [archives and content](/docs/core/archives-and-content.md) (DLC packs and `dlc_patch`), [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (car generators in the same files) and [random events](/docs/world/random-events.md) (the restricted-area scripts).

**How it was made.** Every file in the vanilla archives (the root `.rpf` files, `update\update.rpf` and every DLC pack) was listed with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does), and every `.ymap` (19,362 files) was loaded with CodeWalker's `YmapFile` to count its entities, car generators, timecycle boxes and occluders. When one ymap name exists in several archives, the copy that wins (update over DLC over base) is counted once. Restricted areas read in `re_armybase` and `re_prison` (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; how the engine streams and draws them is **Known**.

## Short version

- **19,362 `.ymap` files, 11,061 distinct names.** Raw: 4,597 in the base archives (726,300 entity placements), 2,975 in `update.rpf` (2,773 of them under `dlc_patch`, replacing older packs' maps), 11,790 in DLC packs.
- **1.69 million entity placements** in the winning copies: 203,349 from base ymaps no update replaces, 470,883 from `update.rpf`, 1,015,527 from DLC packs (most DLC map sections are Online interiors and areas loaded on demand).
- **2,744 `.ytyp` archetype files** define the objects that ymaps place (models, LOD distances, flags, interiors as MLOs); 85,456 `.ydr`, 59,342 `.yft` and 22,939 `.ydd` models and 88,558 `.ytd` texture dictionaries fill them in; 15,124 `.ybn` collision files and 10,038 `.ynv` navmesh files go with them.
- **Ymaps are split by detail and purpose:** by name, 2,642 are streaming chunks (`_strm_`), 1,212 `_critical`, 1,166 `_long_0` (far-visible), 928 `_interior`, 826 `_lod`, 426 `_lodlights`, 206 `_occl` (occluders), 138 `_mp`. The `flags` field is 0 for 7,863, 2 for 1,854, 1 for 919, 3 for 425.
- **Inside the ymaps:** 22,506 car generators (R4.3), 6,262 timecycle modifier boxes (R13.2) and 19,326 box occluders.
- **Scripts switch map sections:** `REQUEST_IPL` in 407 scripts with 371 different IPL names, `REMOVE_IPL`, `IS_IPL_ACTIVE` ([streaming](/docs/core/streaming.md)).
- **Restricted areas are scripts, not map data:** `re_armybase` (Fort Zancudo) gives a 4-star wanted level; `re_prison` (Bolingbroke) raises it from 1 to 4 stars step by step. `re_lossantosintl` (the airport) and `re_yetarian` are area scripts of the same family.

## Where it lives

| File type | What it holds | Count (all vanilla archives) |
| --- | --- | --- |
| `.ymap` | Placements: entities (archetype, position, rotation, LOD parent, LOD distance, flags), car generators, timecycle boxes, occluders, LOD lights, grass instances | 19,366 files |
| `.ytyp` | Archetypes: model name, texture dictionary, physics dictionary, LOD distance, flags, 2D effects (lights, particles, spawn points), MLO interiors with rooms and portals | 2,744 |
| `.ydr`, `.ydd`, `.yft` | Drawables: props, peds, fragments (breakable objects and vehicles) | 85,456 / 22,939 / 59,342 |
| `.ytd` | Texture dictionaries | 88,558 |
| `.ybn` | Collision | 15,124 |
| `.ynv`, `.ynd` | Navmeshes and road / path nodes | 10,038 / 1,027 |
| `.ymf` | Manifests (which ymap is the LOD parent of which; interior bounds) | 1,778 |
| `common:/data/levels/gta5/*.ipl` (text) | World brains (`ambient.ipl`), zones (`popzone.ipl`), paths | R4.1, R4.4 |

### Levels of detail

**Known (engine), matching the file names:** the map is made of high-detail ymaps per block (`cs1_12.ymap`, the busiest with 1,770 entities, and its Online twin `hei_cs1_12.ymap`), LOD and SLOD ymaps that hold simpler stand-ins (`_lod`, and `_slod1` to `_slod4` inside the archives' `lod` folders), `_long_0` ymaps for things seen from far away, `_lodlights` and `_distantlights` for the lights that dot the city at night, and `_occl` occluders that let the renderer skip what's hidden. Each entity points to its LOD parent; the game swaps between levels by distance and the `LodScale` setting ([graphics settings](/docs/performance/graphics-settings.md)).

### How packs add and replace map parts

- **Base** ymaps live in the root `x64*.rpf` archives (`levels\gta5\_citye\...`, `_hills`, `_cityw` ...).
- **`dlc_patch`** folders in `update.rpf` hold 2,773 ymaps that replace the same-named ymaps of older DLC packs ([archives and content](/docs/core/archives-and-content.md)).
- **DLC packs** add whole map sections (interiors, Cayo Perico, Online buildings) as new ymaps with new names (`hei_*`, `apa_*`, `bkr_*` ...), many of which only load when a script requests their IPL.

**Known (community practice):** map mods add ymaps and ytyps in their own DLC pack (forests, extra props), or replace base ymaps with edited copies of the same name through the mods folder (total visual overhauls). Adding is safer: replaced base ymaps break when an update changes them, and two mods replacing the same ymap can't both win.

## Restricted areas

**Verified:** `re_armybase` sets a 4-star wanted level (`SET_PLAYER_WANTED_LEVEL(PLAYER_ID(), 4, false)` followed by `SET_PLAYER_WANTED_LEVEL_NOW`), three times in the script. `re_prison` sets 1, 2, 3 and 4 stars at different points (closer to the inner yard means more stars, **Known**). `re_lossantosintl` (700 lines) and `re_yetarian` (8,730 lines) set no wanted level in their own code. None of the four has a world brain point in `ambient.ipl`.

## What this means for modders

- **Add, don't replace:** put new ymaps and ytyps in your own DLC pack with `DLC_ITYP_REQUEST` and `RPF_FILE` entries (515 `DLC_ITYP_REQUEST` entries exist across the vanilla packs).
- **Use IPLs for optional map sections:** a ymap whose flags mark it as script-loaded (**Known**: flag value 1) stays off until `REQUEST_IPL("name")`; that is how Online interiors and story set changes work, and how a mod can toggle its own additions.
- **Mind the counts:** each extra entity costs memory and draw time; dense placement in one block raises CPU and GPU cost on weak PCs ([physics cost](/docs/performance/physics-cost.md), [CPU](/docs/performance/cpu.md)).
- **Restricted areas** are governed by those scripts: a mod that wants free access to Fort Zancudo has to suppress the wanted level while the player is there (`SET_MAX_WANTED_LEVEL(0)` or clearing it), not edit the map.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The exact meaning of the ymap `flags` values 1, 2, 3 | Second pass: compare with the IPL names scripts request |
| How many entities the story-mode map loads (only ymaps active outside Online) | Second pass: filter by IPL state |
| How `re_lossantosintl` and `re_yetarian` enforce their areas | Second pass |
| How the LOD manifests (`.ymf`) tie ymaps together | R4.5, second pass |

## Test cards

1. **IPL toggle.** `REMOVE_IPL` then `REQUEST_IPL` on a known IPL (for example a story set change) and watch the building change.
2. **Fort Zancudo.** Enter the base on foot. Expected: 4 stars at once.
3. **LOD.** Lower `LodScale` and fly over the city. Expected: buildings switch to their LOD versions closer to you.
