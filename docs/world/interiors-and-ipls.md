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

### What `building_controller` swaps (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in the build 1.0.3725.0 decompile of `building_controller` (11,724 lines). One function describes **198 buildings (ids 0 to 197)**. For each id it gives a type, up to three state names (state 0, 1 and 2), a position, and sometimes area boxes and door settings. Other scripts ask for a building's state by id, and the controller applies it:

- **IPL swaps (types 1 and 2; the function sets type 1 141 times and type 2 54 times).** 180 buildings have state names. Each state is an IPL name, and setting a state requests that IPL and removes the others. `REMOVE_ALL_STATES` as the last state means the third state removes every IPL of the building (ids 21, 50, 53, 95, 196).
- **Model swaps (type 4; 3 entries).** Ids 29 to 31 swap the FIB building's models: `dt1_05_build1_h` to `dt1_05_build1_damage`, its LOD, and `dt1_05_slod` to `dt1_05_damage_slod`.
- **Entries without state names (18).** Ids 29 to 31 (the model swaps), 37, 77, 175 to 177, 182 to 188 and 191 to 193 work through area boxes, an interior (id 175 names `v_carshowroom`) or side effects in the controller. For example, id 37 turns off the radio emitters of the Trevor 1 trailer park.

The controller also handles doors (`DOOR_SYSTEM_SET_DOOR_STATE`, 51 calls) and checks interior entity sets.

<details><summary>All 180 buildings with state names</summary>

| Id | State 0 | State 1 | State 2 |
| ---: | --- | --- | --- |
| 0 | `gasstation_ipl_group1` | `gasstation_ipl_group2` |  |
| 1 | `DES_Smash2_startimap` | `DES_Smash2_endimap` |  |
| 2 | `DES_StiltHouse_imapstart` | `DES_StiltHouse_imapend` | `des_stilthouse_rebuild` |
| 3 | `TRV1_Trail_start` | `TRV1_Trail_end` | `TRV1_Trail_Finish` |
| 4 | `CS3_05_water_grp1` | `CS3_05_water_grp2` |  |
| 5 | `bnkheist_apt_norm` | `bnkheist_apt_dest` |  |
| 6 |  | `crashed_cargoplane` |  |
| 7 |  | `prop_jb700_covered` |  |
| 8 |  | `prop_entityXF_covered` |  |
| 9 |  | `prop_cheetah_covered` |  |
| 10 |  | `prop_ztype_covered` |  |
| 11 |  | `BH1_48_Killed_Michael` |  |
| 12 | `cargoship` | `sunkcargoship` |  |
| 13 | `ship_occ_grp1` | `ship_occ_grp2` |  |
| 14 | `smboat` |  |  |
| 15 |  | `gasparticle_grp2` |  |
| 16 | `CS1_02_cf_offmission` | `CS1_02_cf_onmission1` |  |
| 17 |  | `CS1_02_cf_onmission2` |  |
| 18 |  | `CS1_02_cf_onmission3` |  |
| 19 |  | `CS1_02_cf_onmission4` |  |
| 20 | `jetstealtunnel` |  |  |
| 21 | `Jetsteal_ipl_grp1` | `Jetsteal_ipl_grp2` | (removes all states) |
| 22 | `BH1_47_JoshHse_UnBurnt` | `BH1_47_JoshHse_Burnt` |  |
| 23 |  | `bh1_47_joshhse_firevfx` |  |
| 24 | `SC1_30_Keep_Closed` |  |  |
| 25 | `triathlon2_VBprops` |  |  |
| 26 |  | `DT1_05_REQUEST` |  |
| 27 | `FBI_colPLUG` |  |  |
| 28 |  | `FBI_repair` |  |
| 32 | `FIB_heist_lights` |  |  |
| 33 |  | `FIB_heist_dmg` |  |
| 34 |  | `DT1_05_rubble` |  |
| 35 | `FIBlobbyfake` | `FIBlobby` |  |
| 36 | `DT1_05_HC_REMOVE` | `DT1_05_HC_REQ` |  |
| 38 | `trailerparkA_grp1` | `trailerparkA_grp2` |  |
| 39 | `occl_trailerA_grp1` |  |  |
| 40 | `trailerparkB_grp1` | `trailerparkB_grp2` |  |
| 41 | `occl_trailerB_grp1` |  |  |
| 42 | `trailerparkC_grp1` | `trailerparkC_grp2` |  |
| 43 | `occl_trailerC_grp1` |  |  |
| 44 | `trailerparkD_grp1` | `trailerparkD_grp2` |  |
| 45 | `occl_trailerD_grp1` |  |  |
| 46 | `trailerparkE_grp1` | `trailerparkE_grp2` |  |
| 47 | `occl_trailerE_grp1` |  |  |
| 48 | `methtrailer_grp1` | `methtrailer_grp2` | `methtrailer_grp3` |
| 49 | `occl_meth_grp1` |  |  |
| 50 | `des_farmhs_startimap` | `des_farmhs_endimap` | (removes all states) |
| 51 | `farm` | `farm` | `farm_burnt` |
| 52 | `farm_props` |  | `farm_burnt_props` |
| 53 | `des_farmhouse` | `des_farmhouse` | (removes all states) |
| 54 | `farmint_cap` | `farmint` |  |
| 55 | `des_farmhs_start_occl` | `des_farmhs_end_occl` |  |
| 56 | `tankerexp_grp0` | `tankerexp_grp3` |  |
| 57 |  | `tankerexp_grp1` |  |
| 58 |  | `tankerexp_grp2` |  |
| 59 |  | `DES_tankerexp` |  |
| 60 | `dockcrane1` |  |  |
| 61 | `CanyonRvrShallow` | `CanyonRvrDeep` |  |
| 62 |  | `Garage_door_locked` |  |
| 63 | `ch1_02_closed` | `ch1_02_open` |  |
| 64 | `ferris_finale_Anim` |  |  |
| 65 | `railing_start` | `railing_end` |  |
| 66 | `canyonriver01` | `canyonriver01_traincrash` |  |
| 67 | `DT1_05_WOFFM` | `DT1_05_FIB2_Mission` | `DT1_05_WOFFM` |
| 68 |  | `coronertrash` |  |
| 69 | `Coroner_Int_off` | `Coroner_Int_on` |  |
| 70 | `id2_14_pre_no_int` |  |  |
| 71 |  | `id2_14_during1` | `id2_14_during2` |
| 72 |  | `id2_14_on_fire` | `id2_14_post_no_int` |
| 73 |  | `id2_14_during_door` |  |
| 74 | `burnt_switch_off` |  |  |
| 75 | `RC12B_Default` | `RC12B_Destroyed` | `RC12B_Fixed` |
| 76 | `RC12B_HospitalInterior` |  |  |
| 78 | `TrevorsTrailer` | `TrevorsTrailerTrash` | `TrevorsTrailerTidy` |
| 79 | `scafstartimap` | `scafendimap` |  |
| 80 |  | `chop_props` |  |
| 81 |  | `KorizTempWalls` |  |
| 82 |  | `mic3_chopper_debris` |  |
| 83 | `chemgrill_grp1` |  |  |
| 84 |  | `Plane_crash_trench` |  |
| 85 | `golfflags` |  |  |
| 86 | `yogagame` |  |  |
| 87 | `DT1_21_prop_lift_on` |  |  |
| 88 | `jewel2fake` | `post_hiest_unload` | `bh1_16_refurb` |
| 89 | `bh1_16_doors_shut` | `refit_unload` |  |
| 90 | `v_tunnel_hole_swap` | `v_tunnel_hole` |  |
| 91 | `cs5_4_trains` |  |  |
| 92 | `ld_rail_01_track` |  |  |
| 93 | `ld_rail_02_track` |  |  |
| 94 | `airfield` |  |  |
| 95 |  |  | (removes all states) |
| 96 |  | `chophillskennel` |  |
| 97 | `DT1_03_Gr_Closed` |  |  |
| 98 |  | `FINBANK` |  |
| 99 |  | `PAPER1_RCM_ALT` | `PAPER1_RCM` |
| 100 | `SP1_10_fake_interior` | `SP1_10_real_interior` |  |
| 101 | `facelobbyfake` | `facelobby` |  |
| 102 | `SC1_14_OldBill` | `SC1_14_NewBill` |  |
| 103 | `DT1_17_OldBill` | `DT1_17_NewBill` |  |
| 104 | `SC1_01_OldBill` | `SC1_01_NewBill` |  |
| 105 |  | `SM_15_BldGRAF1` |  |
| 106 |  | `CH3_RD2_BishopsChickenGraffiti` |  |
| 107 |  | `FruitBB` |  |
| 108 |  | `CS5_04_MazeBillboardGraffiti` |  |
| 109 |  | `CS5_Roads_RonOilGraffiti` |  |
| 110 |  | `ap1_03_bbrd_dcl` |  |
| 111 | `HW1_02_OldBill` | `HW1_02_NewBill` |  |
| 112 | `HW1_Emissive_OldBill` | `HW1_Emissive_NewBill` |  |
| 113 |  | `AP1_04_TriAf01` |  |
| 114 |  | `CS2_06_TriAf02` |  |
| 115 |  | `CS4_04_TriAf03` |  |
| 116 | `V_Michael_D_items` | `V_Michael_D_Moved` |  |
| 117 | `V_Michael_S_items` | `V_Michael_S_items_swap` |  |
| 118 | `V_Michael_M_items` | `V_Michael_M_moved` |  |
| 119 | `V_Michael_L_Items` | `V_Michael_L_Moved` |  |
| 120 |  | `V_Michael_M_items_swap` |  |
| 121 |  | `V_Michael_JewelHeist` |  |
| 122 |  | `V_Michael_FameShame` |  |
| 123 |  | `Michael_premier` |  |
| 124 |  | `V_Michael_plane_ticket` |  |
| 125 | `V_Michael_bed_tidy` | `V_Michael_bed_Messy` |  |
| 126 |  | `V_26_Trevor_Helmet1` |  |
| 127 |  | `V_26_Trevor_Helmet3` |  |
| 128 |  | `V_26_Trevor_Helmet2` |  |
| 129 |  | `V_24_Trevor_Briefcase1` |  |
| 130 |  | `V_24_Trevor_Briefcase3` |  |
| 131 |  | `V_24_Trevor_Briefcase2` |  |
| 132 |  | `V_26_Michael_Stay1` |  |
| 133 |  | `V_26_Michael_Stay3` |  |
| 134 |  | `V_26_Michael_Stay2` |  |
| 135 | `swap_clean_apt` | `layer_mess_A` |  |
| 136 |  | `layer_mess_B` |  |
| 137 |  | `layer_mess_C` |  |
| 138 |  | `layer_sextoys_a` |  |
| 139 |  | `layer_wade_shit` |  |
| 140 |  | `swap_wade_sofa_A` |  |
| 141 | `layer_debra_pic` |  |  |
| 142 |  | `layer_torture` |  |
| 143 | `swap_sofa_A` | `swap_sofa_B` |  |
| 144 |  | `layer_whiskey` |  |
| 145 | `swap_mrJam_A` | `swap_mrJam_B` |  |
| 146 |  | `swap_mrJam_C` |  |
| 147 | `vb_30_emissive` | `vb_30_murder` |  |
| 148 |  | `vb_30_crimetape` |  |
| 149 | `sheriff_cap` |  |  |
| 150 | `CS1_16_Sheriff_Cap` |  |  |
| 151 |  | `ufo` |  |
| 152 |  | `ufo_eye` |  |
| 153 | `V_57_FranklinStuff` | `V_57_Franklin_LEFT` |  |
| 154 |  | `V_57_GangBandana` |  |
| 155 |  | `V_57_Safari` |  |
| 156 |  | `showhome_only` |  |
| 157 |  | `franklin_unpacking` |  |
| 158 |  | `franklin_settled` |  |
| 159 |  | `bong_and_wine` |  |
| 160 | `locked` | `unlocked` |  |
| 161 |  | `progress_flyer` |  |
| 162 |  | `progress_tux` |  |
| 163 |  | `progress_tshirt` |  |
| 164 |  | `Jewel_Gasmasks` |  |
| 165 |  | `V_53_Agency _Overalls` |  |
| 166 |  | `V_53_Agency_Blueprint` |  |
| 167 |  | `V_35_KitBag` |  |
| 168 |  | `V_35_Body_Armour` |  |
| 169 |  | `V_35_Fireman` |  |
| 170 |  | `burgershot_yoga` |  |
| 171 |  | `V_Michael_Scuba` |  |
| 172 |  | `V_19_Trevor_Mess` |  |
| 173 | `shr_int` | `fakeint` |  |
| 174 | `csr_beforeMission` | `csr_afterMissionA` | `csr_afterMissionB` |
| 178 |  | `carshowroom_broken` | `carshowroom_boarded` |
| 179 | `shutter_open` | `shutter_closed` |  |
| 180 | `DT1_03_Shutter` |  |  |
| 181 | `Hospitaldoorsanim` |  | `Hospitaldoorsfixed` |
| 189 | `Carwash_with_spinners` | `Carwash_without_spinners` |  |
| 190 | `KT_CarWash` | `KT_CarWash_NoBrush` |  |
| 194 |  | `CS3_07_MPGates` |  |
| 195 | `atriumglstatic` | `atriumglmission` | `atriumglcut` |
| 196 |  | `bnkheist_apt_dest_vfx` | (removes all states) |
| 197 |  | `racetrack01` |  |

</details>

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
| A list of IPL names with the interior or building each one controls | Mostly answered (leftovers pass, **Verified**): every one of the 410 IPL names scripts pass by literal is a ymap with the script-loaded flag; 134 of them place an interior (MLO) instance and they hold 12,353 entities in all. By prefix: `hei_` 67, `apa_` 42, `ex_` 36, `m25_` 26, `m24_` 23, `h4_` 22, `imp_` 16, `m23_` 15, `sf_` 12, and story ones such as `prologue*`, `des_*`, `tankerexp*`, `bnkheist*`, `cs1_*`. A building-by-building list would need each ymap's position matched to a place name ([map data](/docs/world/map-data.md#flags-story-mode-entities-and-manifests-leftovers-pass)) |
| What `building_controller` swaps, building by building | Answered in [What `building_controller` swaps](#what-building_controller-swaps-leftovers-pass) (leftovers pass): 198 building ids with their IPL states, the three model swaps and the area-based entries |
| Which Online interiors work offline with IPLs alone | Test card 2; second pass |

## Test cards

1. **Entity set.** Inside a CEO office in story mode, deactivate one decor set and activate another, then `REFRESH_INTERIOR`. Expected: the decor changes at once.
2. **Online interior offline.** Request a nightclub's IPLs, pin it, teleport in. Note what is present and what is missing.
3. **Exterior cull.** Stand inside an interior and stop calling `ENABLE_EXTERIOR_CULL_MODEL_THIS_FRAME` where Rockstar calls it. Expected: the outer building's walls show through.
