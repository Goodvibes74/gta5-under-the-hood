# Interiors and IPLs

Which interiors exist, how an interior is built (an MLO archetype with rooms, portals and entity sets), how interiors and optional map sections (IPLs) are switched on, which scripts do it, and how the Online interiors can be opened in story mode. Roadmap topic **R4.5** in the [roadmap](/ROADMAP.md). Builds on [map data](/docs/world/map-data.md) (ymaps and ytyps), [streaming](/docs/core/streaming.md) (`REQUEST_IPL`, `PIN_INTERIOR_IN_MEMORY`) and [archives and content](/docs/core/archives-and-content.md).

**How it was made.** Every `.ytyp` in the vanilla archives (2,744 files: root `x64*.rpf`, `update\update.rpf`, every DLC pack) was loaded with CodeWalker's `YtypFile` and each MLO (interior) archetype listed with its rooms, portals and entity sets; when one interior name exists in several archives, the winning copy (update over DLC over base) is counted once. IPL and entity set names scripts pass by literal were counted with `git grep -o` over the decompile (commit `6c18d3e8b`). Native use from the [INTERIOR](/scripting/native-usage/INTERIOR.md) and [STREAMING](/scripting/native-usage/STREAMING.md) usage pages. Build 1.0.3725.0 Legacy. Counts are **Verified**; how the engine loads interiors is **Known** unless stated.

## Short version

- **386 interiors** (MLO archetypes): 143 from the base game, 238 from DLC packs, 5 replaced by the update. By name: `v_` story interiors 102, `metro` tunnel sections 40, then Online families (`xm_` 18, `hei_` 16, `ex_` 12, `apa_` 11, `ch_` 10, `m23_` 10, `bkr_` 8 ...).
- **An interior is rooms, portals and entity sets.** The median interior has 2 rooms; the largest are Humane Labs (`v_lab`, 25 rooms), the Doomsday submarine (`xm_x17dlc_int_sub`, 22), the O'Neil farmhouse (`v_farmhouse`, 21) and the FIB buildings (`v_fib02` 19, `v_fib03` 18).
- **Entity sets are the "versions" of an interior:** 116 interiors have them, 2,150 sets in all. The Arena workshop (`xs_x18_int_01`) has 71, each CEO office style (`ex_int_office_*`) 69. Scripts turn them on with `ACTIVATE_INTERIOR_ENTITY_SET` (284 scripts) and then `REFRESH_INTERIOR` (275).
- **IPLs switch map sections and interiors on and off:** scripts pass 353 different IPL names to `REQUEST_IPL` by literal (from 297 scripts) and 397 to `REMOVE_IPL` (from 300); the natives themselves are in 407 and 412 scripts. The most active are the Online mission controllers and `freemode`, `maintransition` (switching between story and Online map states) and `building_controller` (story-mode building swaps).
- **Interior natives are everywhere:** `GET_INTERIOR_FROM_ENTITY` (569 scripts), `IS_VALID_INTERIOR` (518), `PIN_INTERIOR_IN_MEMORY` / `UNPIN_INTERIOR` (359 / 375), `IS_INTERIOR_READY` (393), `DISABLE_INTERIOR` (280), `CAP_INTERIOR` (286).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `.ytyp` with `CMloArchetypeDef` | Interior archetype: entities, rooms (with timecycle and flags), portals between rooms, entity sets | 386 interiors in 536 copies |
| `.ymap` with a `CMloInstanceDef` | Where an interior is placed in the world | [Map data](/docs/world/map-data.md) |
| `_interior` and other optional `.ymap` files | Interior placements and set dressing loaded on request (IPLs) | 928 `_interior` ymaps |
| `interiorproxies.meta` and DLC `INTERIOR_PROXY_ORDER_FILE` entries | Load order of interior proxies | 27 DLC entries |

### Interior families

| Prefix | Interiors | What (**Known**) |
| --- | ---: | --- |
| `v_` | 102 | Story-mode interiors (houses, shops, offices, the FIB building, the lab) |
| `metro` | 40 | Subway tunnel and station sections |
| `xm_` | 18 | Doomsday Heist (facility, submarine, silo) |
| `hei_` | 16 | Heists update |
| `ex_` | 12 | Executives and Other Criminals (CEO offices, warehouses) |
| `apa_` | 11 | Executives and apartments |
| `ch_` | 10 | Diamond Casino Heist |
| `m23_`, `m25_`, `m24_` | 10, 7, 4 | Recent Online updates |
| `bkr_` | 8 | Bikers |
| `cs1_`, `id1_`, `sc1_`, `dt1_`, `id2_` | 5 to 9 | Interiors tied to a map block (story) |

## How interiors and IPLs are switched

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `REQUEST_IPL` / `REMOVE_IPL` / `IS_IPL_ACTIVE` | 407 / 412 / 428 | 6,501 / 7,129 / 7,158 | Turn an optional map section or interior on and off |
| `PIN_INTERIOR_IN_MEMORY` / `UNPIN_INTERIOR` / `IS_INTERIOR_READY` | 359 / 375 / 393 | 878 / 787 / 1,702 | Keep an interior loaded and wait for it |
| `ACTIVATE_INTERIOR_ENTITY_SET` / `DEACTIVATE_...` / `IS_..._ACTIVE` | 284 / 283 / 282 | 1,375 / 2,839 / 3,204 | Choose an interior's version |
| `REFRESH_INTERIOR` | 275 | 1,369 | Apply entity set changes |
| `DISABLE_INTERIOR`, `CAP_INTERIOR` | 280, 286 | 592, 804 | Stop an interior loading, or block entry |
| `GET_INTERIOR_AT_COORDS`, `GET_INTERIOR_AT_COORDS_WITH_TYPE` | 453, 513 | 3,829, 4,141 | Find an interior by position |
| `GET_ROOM_KEY_FROM_ENTITY`, `FORCE_ROOM_FOR_ENTITY` | 377, 290 | 2,871, 1,489 | Which room an entity is in; fix entities placed by script |
| `ENABLE_EXTERIOR_CULL_MODEL_THIS_FRAME`, `ENABLE_SHADOW_CULL_MODEL_THIS_FRAME` | 249, 247 | 3,804, 4,956 | Hide the outside building while you are inside |

IPL names by family (prefix of the 353 names passed to `REQUEST_IPL`): `hei_` 47, `ex_` 36, `apa_` 33, `m24_` 23, `imp_` 16, `h4_` 16, `m23_` 14, `m25_` 13, `sf_` 12, `xm3_` 9, then smaller groups including `prologue` (5, the North Yankton map).

**Known:** `building_controller` keeps story-mode buildings in the right state for the story (destroyed or repaired, open or closed) and `maintransition` swaps the map between its story and Online states, which is why both toggle hundreds of IPLs.

## Opening Online interiors in story mode

**Known (community practice, consistent with the natives above):** most Online interiors are already in the archives and only need their IPL and their entity sets:

1. `REQUEST_IPL("<ipl name>")` for the interior and its exterior shell, and remove the IPL of any placeholder that stands in its place.
2. `GET_INTERIOR_AT_COORDS(x, y, z)`, `PIN_INTERIOR_IN_MEMORY`, wait for `IS_INTERIOR_READY`.
3. `ACTIVATE_INTERIOR_ENTITY_SET(interior, "<set>")` for the style you want (office decor, workshop tools), then `REFRESH_INTERIOR`.
4. Unlock its doors (`DOOR_SYSTEM_SET_DOOR_STATE`) and teleport in if there is no physical entrance.

Interiors that depend on Online scripts for furniture, lighting or audio look empty or dark offline; that part has to be rebuilt by the mod.

## What this means for modders

- **Turn sections on and off** with `REQUEST_IPL` / `REMOVE_IPL`; check with `IS_IPL_ACTIVE`. Put things back when your mod stops, or story buildings may stay in the wrong state.
- **Entity sets** are the cheap way to vary an interior: one MLO, many versions.
- **A custom interior** is a new MLO archetype in your own `.ytyp` plus a `.ymap` that places it, in your own DLC pack (`DLC_ITYP_REQUEST`).
- **Memory:** pinned interiors stay loaded; unpin them when you leave.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| A list of IPL names with the interior or building each one controls | Second pass: match IPL names to the ymaps they load |
| What `building_controller` swaps, building by building | Second pass |
| Which Online interiors work offline with IPLs alone | Test card 2; second pass |

## Test cards

1. **Entity set.** Inside a CEO office in story mode, deactivate one decor set and activate another, then `REFRESH_INTERIOR`. Expected: the decor changes at once.
2. **Online interior offline.** Request a nightclub's IPLs, pin it, teleport in. Note what is present and what is missing.
3. **Exterior cull.** Stand inside an interior and stop calling `ENABLE_EXTERIOR_CULL_MODEL_THIS_FRAME` where Rockstar calls it. Expected: the outer building's walls show through.
