# Rockstar Creator internals: how tracks and maps are built from props

How GTA Online's content creator (the "Rockstar Creator") builds custom races, stunt tracks and job maps out of props: the hub script and the eight creator scripts it can start, the free camera and the cursor ray that places things, the 1,883-entry prop catalogue, the placement checks and limits, how stunt track pieces snap together, removing map objects, how a creation is saved as columns of JSON and sent to Rockstar's cloud, and how a race puts the props back into the world when the job is played. Roadmap topic **R7.11** in the [roadmap](/ROADMAP.md). Builds on [UGC mission files](/file-formats/ugc-json.md) (R7.4, the file format), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2, how the game gets into the creator) and the [global map](/docs/core/global-map.md) (the FMMC structures).

**How it was made.** The creator scripts of build 1.0.3725.0 (decompile commit `6c18d3e8b`, "Update for 1.72-3725.0") were read at the functions named below: `creator` (181,363 lines), `fm_main_menu` (761), `fm_race_creator` (911,481), `fm_deathmatch_creator`, `fm_capture_creator`, `fm_lts_creator`, `fm_survival_creator`, `public_mission_creator`, and the race player `fm_race_controler` (710,598). Native calls were counted per script with `grep -o` over each file and across all scripts with `git grep`. Tunable names and defaults come from `tuneables_processing`. Menu and error text was resolved by hashing each string label in the creator scripts and looking it up in the American `.gxt2` files of `update\update2.rpf` and the DLC packs (17,969 of 49,596 strings are text labels; method in [research tools](/docs/00-getting-started/research-tools.md)). Numbers, names, limits and key names are **Verified** from the scripts; what the engine does inside a native is **Known**. Function numbers (`func_12851`) and globals (`Global_4718592`) are decompiler names for this build only. Nothing was tested in game: the creator only runs inside GTA Online (see 12.11).

## 12.1 Short version

- **One hub, eight creator scripts.** `maintransition` starts `creator` (the hub, stack 28,000). The hub starts `FM_Main_Menu` (stack 5,050), which reads the job type and starts one creator on the 64,500 mission stack: `FM_Race_Creator`, `FM_Deathmatch_Creator`, `FM_Capture_Creator`, `FM_LTS_Creator`, `FM_Survival_Creator`, `Public_Mission_Creator`, `Freemode_Creator` or `Basic_Creator`. The last two, plus `fm_mission_creator` and `hud_creator`, are empty in the PC build: Rockstar's internal creators were stripped.
- **All six real creators share one prop catalogue:** 59 numbered prop libraries ("Barriers", "Ramps", "Stunt Track", "Stunt Tube", "Track Smoothing", "Arena Traps" ...) with **1,883 entries and 1,784 distinct models** in the race creator.
- **Placing is a ray from the camera.** A fly camera (`DEFAULT_SCRIPTED_FLY_CAMERA`, ceiling 1,300 m) looks at the world. Each frame a line test runs from the camera up to **2,400 m** forward, plus a water probe. The hit point is where the held prop goes.
- **Every placement is checked:** 106 different "cannot place" and "maximum" messages in the race creator alone (ground not level, must be on water, too close to the grid, inside an interior ...).
- **Limits:** **200 props**, **20 dynamic props**, about **100 checkpoints** (102 slots), **10 prop templates**, **40 removed map objects**, 5 alarms, 40 fireworks, **50 overlapping props** around one spot (tunable `propproximitylimit`) and a model-memory budget the engine reports (`GET_USED_CREATOR_BUDGET`).
- **Stunt track pieces snap with bones.** Bones 2 to 5 of a track model are its connection points. The creator compares them with the bones of the 10 nearest placed props within about 89 m and picks the closest pair facing each other.
- **A creation is saved as columns.** The `prop` section is a set of arrays (`loc`, `vRot`, `head`, `model`, `prpclr` ...), one entry per prop, about 90 column names in all. A column is written only once some prop needs a value other than the default.
- **Saving needs Rockstar's cloud.** The file is built with the `DATAFILE` natives and sent with `UGC_CREATE_MISSION` or `UGC_UPDATE_MISSION` as content type `"gta5mission"`, then made public with `UGC_PUBLISH`.
- **Playing a race rebuilds the props locally.** `fm_race_controler` creates every static prop as a non-networked object on each player's machine, then freezes it, makes it invincible and proofs it, gives it a draw distance of at least 150 m, and applies its colour and its speed-pad strength (25 boost for 0.4 s by default, up to 100).

## 12.2 Where it lives

| Script | Lines | Distinct natives | Native calls | What it does |
| --- | ---: | ---: | ---: | --- |
| `creator` | 181,363 | 617 | 12,177 | The hub: Creator menus ("Create a Race", "Load Creation"), tutorials, UGC registration, starts `FM_Main_Menu` |
| `fm_main_menu` | 761 | 16 | 78 | Reads the job type and starts the matching creator script |
| `fm_race_creator` | 911,481 | 2,219 | 70,337 | Races: land, sea, air, stunt, special vehicle, transform, Arena, Open Wheel, drift |
| `fm_deathmatch_creator` | 555,340 | 1,671 | 40,628 | Deathmatch, team and vehicle deathmatch, King of the Hill |
| `public_mission_creator` | 476,664 | 1,322 | 31,874 | The public Mission creator |
| `fm_survival_creator` | 433,909 | 1,239 | 31,014 | Survival |
| `fm_lts_creator` | 429,405 | 1,235 | 30,736 | Last Team Standing |
| `fm_capture_creator` | 428,044 | 1,196 | 30,609 | Capture (Contend, GTA, Hold, Raid) |
| `fm_mission_creator`, `freemode_creator`, `basic_creator`, `hud_creator` | 4 each | 0 | 0 | Empty in the PC build |
| `fm_race_controler` | 710,598 | | | Plays a published race and rebuilds its props |

Not to be confused with `am_mp_creator_trailer` and `am_mp_creator_aircraft`: those run the vehicle workshops inside the Mobile Operations Center and the Avenger (interiors `CREATOR_TRAILER_1`, `CREATOR_AIRCRAFT_1`), not the content creator.

The creation in progress lives in the FMMC globals ([global map](/docs/core/global-map.md)): the job header and checkpoints in `Global_4718592` (type at offset 0, subtype at `.f_2`, checkpoint count at `.f_121625`, checkpoints from `.f_114994`, 65 values each), placed props in `Global_5242880` (count, then one 165-value record per prop), and removed map objects, templates and other lists in `Global_4980736`. These addresses are for build 3725 only.

## 12.3 From the menu to a creator

The hub is entered through the transition states 32 to 38 (`START_CREATOR_PRE_LAUNCH_SCRIPT_CHECK` to `MOVE_CREATOR_TO_RUNNING_STATE`, [R7.2](/docs/online/transitions-and-sessions.md)). Inside, `FM_Main_Menu` loads the `FMMC` text block, takes player control away and waits until the hub has set the job type. It then picks a creator (**Verified**, entry function and `func_2` to `func_13`):

| Job type (`Global_4718592`) | Subtype (`.f_2`) | Script started |
| --- | --- | --- |
| 2 or 8 (races, parachuting) | any | `FM_Race_Creator` |
| 1 (deathmatch) | any | `FM_Deathmatch_Creator` |
| 3 (survival) | any | `FM_Survival_Creator` |
| 0, 4, 6 or 31 (missions, gang attacks and two unnamed types) | 5 | `FM_LTS_Creator` |
| same | 11 | `Basic_Creator` (empty) |
| same | 12 | `Freemode_Creator` (empty) |
| same | 14 | `Public_Mission_Creator` |
| same | anything else | `FM_Capture_Creator` |

Each script is requested, started with 64,500 words of stack and marked no longer needed; `FM_Main_Menu` then waits until the creator thread is gone and shows the menu again.

**What the numbers mean** (**Verified**, the job-name function `func_874` in `creator`, labels resolved to American text):

| Type | Name | Subtypes |
| ---: | --- | --- |
| 0 (and 9) | Mission | 1 Heist (finale), 4 Versus Mission or Adversary Mode, 5 Last Team Standing, 6 Capture (Contend, GTA, Hold or Raid, chosen by option bits 20 to 23), 7 Heist setup, 14 Mission Creator Content, otherwise Mission |
| 1 | Deathmatch | 0 Deathmatch, 1 Team Deathmatch, 2 Vehicle Deathmatch, 3 King of the Hill, 4 Team King of the Hill |
| 2 | Race | 0/1 Land, 2/3 Sea, 4/5 Air, 6/7 Stunt, 10/11 On Foot, 12/13 Bike, 18/19 Target Assault, 24/25 Open Wheel, 26 Pursuit, 27 Street, 30/31 Drift, 32 Drag |
| 3 | Survival | |
| 6 | Gang Attack | |
| 7 | Last Team Standing | |
| 8 | Parachuting | |

Race subtypes come in pairs; what separates the even and odd number of a pair is not settled (12.13). Any job can also be named "Arena War" when its Arena check passes. Types 4 and 31, which `FM_Main_Menu` also sends to the mission creators, have no name in this function.

The hub's own menu text (**Verified**, labels): "Create a custom Land, Sea or Air Race", "Create a custom GTA Deathmatch", "Create a Capture", "Create a Last Team Standing", "Create a custom Survival mode", "Create a custom King of the Hill mode", "Create a Mission", "Create a Race in the Arena", "Create a Deathmatch in the Arena" and "Load Creation". Four tutorials are tracked by the stats `mpply_done_race_creator_tut`, `_dm_`, `_surv_` and `_koth_creator_tut`.

*Second pass, 2026-10-30* (**Verified** in `fm_race_controler`):

- **Even and odd race subtypes.** One check in the race controller is true for the odd subtypes (1, 3, 5, 7, 11, 13, 19, 25, 31) and for 21, 23, 26 and 32. For those races it forces one lap and counts the finish as a checkpoint. Every other race takes its lap count from the corona. So in each pair, the even number is a lap race and the odd number a point-to-point race (*probable*, from that behaviour).
- **Types 4 and 31.** They appear in the same check as missions, Gang Attack and Survival in 23 scripts (the creators, `appmpjoblistnew`, the mission, race and deathmatch controllers), and type 31 is paired with Survival in 12 more checks. Neither has a name or a creator branch of its own in this build.

## 12.4 The camera and the cursor

The creator does not move the player around to place things; it flies a camera.

- **Camera** (**Verified**): `CREATE_CAM("DEFAULT_SCRIPTED_FLY_CAMERA")`, the engine's built-in free-flight camera, started looking straight down (pitch −89.5°). A second `DEFAULT_SCRIPTED_CAMERA` is used to blend between views. The ceiling is set with `SET_FLY_CAM_MAX_HEIGHT`: **1,300 m** normally, **215 m** in one mode and **188 m** over a small area around x 2,782 to 2,813, y −3,819 to −3,782 (*probable*: the Arena interior, which sits at those coordinates). `SET_FLY_CAM_COORD_AND_CONSTRAIN` moves it without going through the map.
- **Cursor** (**Verified**, `func_13859`): every frame a line test runs from `GET_FINAL_RENDERED_CAM_COORD()` along the camera's forward direction. Its length is **2,400 m**, 700 m in one mode, or worked out from the camera height and pitch when placing at a set height, never below 5 m. It is a synchronous `START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE` with collision flags 211 (195 or 209 in some modes; the flag bits are **Known**: map, vehicles, objects and more), or a swept sphere of radius 1.75 m for one item type. The player's own ped or vehicle is excluded.
- **Water** (**Verified**): the same segment is tested with `TEST_PROBE_AGAINST_ALL_WATER`. If the water surface is nearer than the hit, the cursor sits on the water and the item is marked as placed on water.
- **Mouse** (**Verified**): on PC, `START_SHAPE_TEST_MOUSE_CURSOR_LOS_PROBE` (2 calls) lets the mouse pick items.

The held prop is a real object created at the cursor (`CREATE_OBJECT`, 45 calls), drawn see-through (`SET_ENTITY_ALPHA`, 51), without collision (`SET_ENTITY_COLLISION`, 146) and frozen (`FREEZE_ENTITY_POSITION`, 212). Markers (`DRAW_MARKER`, 68) and lines show the snap points, checkpoints and areas.

## 12.5 The prop catalogue

The race creator's prop list is one function (`func_621(library, index)`) that returns a model for a library and position. The same 58 library labels appear in all six creators (**Verified**, label count per script).

| No. | Library | Entries | | No. | Library | Entries |
| ---: | --- | ---: | --- | ---: | --- | ---: |
| 0 | Barriers | 90 | | 30 | Stunt Ramps | 49 |
| 1 | Benches | 6 | | 31 | Stunt Set Pieces | 41 |
| 2 | Buoys and Platforms | 5 | | 32 | Stunt Signs | 110 |
| 3 | Cabins | 11 | | 33 | Stunt Special | 17 |
| 4 | Construction | 42 | | 34 | Stunt Targets | 23 |
| 5 | Containers | 12 | | 35 | Target Assault Props | 8 |
| 6 | Crates and Boxes | 38 | | 36 | Race Buildings | 8 |
| 7 | Dumpsters | 9 | | 37 | Drugs and Equipment | 22 |
| 8 | Machinery | 16 | | 38 | Gunrunning | 34 |
| 9 | Ramps | 17 | | 39 | (no text) | 148 |
| 10 | Signs | 12 | | 40 | Arena Traps (Apocalypse) | 20 |
| 11 | Trailers | 9 | | 41 | Arena Traps (Future Shock) | 19 |
| 12 | Wreckage | 22 | | 42 | Arena Traps (Nightmare) | 19 |
| 13 | Rocks and Trees | 24 | | 43 | Arena Props (Apocalypse) | 68 |
| 14 | Dynamic | 87 | | 44 | Arena Props (Future Shock) | 30 |
| 15 | (second dynamic list, no text) | 107 | | 45 | Arena Props (Nightmare) | 21 |
| 16 | Special | 60 | | 46 | Arena Ramps | 23 |
| 17 | Stunt Track | 58 | | 47 | Arena Dynamic | 3 |
| 18 | Stunt Track with Barriers | 29 | | 48 | Misc Arena Props | 4 |
| 19 | Stunt Raised Track | 45 | | 49 to 51 | (no text), (no text), Painted Signs | 6, 27, 25 |
| 20 | Stunt Barriers | 27 | | 52 | Holidays | 80 |
| 21 | Stunt Tube | 41 | | 53 | Track Smoothing | 40 |
| 22 | Stunt Neon Tubes | 50 | | 54 | Precision Drift Obstacles | 1 |
| 23 | Big Neon Arrows | 6 | | 55 | (no text) | 6 |
| 24 | Stunt Air Tubes | 41 | | 58 | Film Set | 27 |
| 25 | Stunt Checkpoint Rings | 11 | | 60, 61 | (no text) | 29, 7 |
| 26 | Stunt Air Gates | 7 | | 56, 57, 59 | Custom, (no text), Templates | no fixed list |
| 27 | Stunt Inflatable Gates | 27 | | | | |
| 28 | Stunt Building Blocks | 39 | | | | |
| 29 | Stunt Neon Blocks | 20 | | | **Total** | **1,883** |

"(no text)" means the library's label (for example `FMMC_PLIB_BB`, `FMMC_PLIB_CCTV`, `FMMC_PLIB_FURN`) has no American text in the files read; those libraries may be hidden or only for Rockstar's own content. 311 entries are bare hashes whose names the decompiler doesn't know. Model names follow the packs: `stt_prop_*` (Cunning Stunts), `ba_prop_*` (After Hours), `ar_prop_*` and `xs_prop_*` (Arena War), `sum_prop_*` (Summer 2020 race props), `gr_prop_*` (Gunrunning targets).

Some props are creator stand-ins: when saving, `func_256` swaps `lts_prop_lts_ramp_01` to `prop_mp_ramp_01_tu`, `lts_prop_lts_offroad_tyres01` to `prop_offroad_tyres01` and so on, so the saved file names the normal model (**Verified**).

Which vehicles and props each creator offers can be switched remotely: **426 tunables** mention a creator, almost all `enable_creator_<vehicle>`, `enable_race_creator_<vehicle>` or `ac_enable_<vehicle>_creators`, plus `toggle_creators_off`, `toggle_race_creator`, `toggle_deathmatch_creator`, `sr_race_creator_props` and `enable_sm_race_creator_props` (**Verified**, `tuneables_processing`).

## 12.6 Placement checks and limits

Every frame the creator decides whether the held item may be placed and keeps a set of reason bits; one function (`func_12377`) turns the first reason into a message. The race creator uses **106 different `FMMC_ER_*` messages** (**Verified**). The common ones:

| Check | Message |
| --- | --- |
| Ground | "The ground must be level", "Too close to the ground", "Too close to the water" |
| Surface | "The position must be on water" / "on land", "This needs to be placed on the ground under water" |
| Distance | "The position is too far from the camera", "Too far from Starting Grid", "Must be placed closer to the Finish Line" |
| Overlap | "Too close to another object", "Placed items cannot be stacked" (unless "Allow Prop Stacking" is on), "Two identical props cannot be placed in exactly the same location", "Can't place here. Placement overlaps with the Start Grid" |
| Area | "The area is restricted", "must be within the map bounds", "Triggers cannot be placed in interiors", Arena and play-area rules |
| Density | "There are too many props in the immediate area", "There are too many animated props in the immediate area" |
| Memory | "Unable to place. Model memory limit was exceeded" |
| Race logic | warp checkpoint rules (`FMMC_ER_029d` to `029i`), transform-race vehicle rules (`045*`), "Every Race needs a valid Starting Grid" |

**Limits** (**Verified**, from the comparisons in the scripts):

| What | Limit | Where it comes from |
| --- | ---: | --- |
| Props | 200 | `func_12851` returns 200 for every job type; the same function returns 200 in the deathmatch, capture, LTS and survival creators. HUD "PROPS n/200" |
| Dynamic props | 20 | 32 when a development switch is on; that switch (`func_13443`) is compiled to return false |
| Checkpoints | about 100 | 102 slots; placing stops at 101 and the HUD counter tops out at 100 |
| Prop templates | 10 | "The maximum number of prop templates has been saved" |
| Removed map objects ("Fixtures removed") | 40 | `func_13902` |
| Props overlapping one spot | 50 | tunable `propproximitylimit`, default 50: counts placed props whose bounding sphere touches the held prop's |
| Animated props overlapping one spot | 1 | an unnamed tunable, default 1; counts stop-sign and tube-jump props |
| Alarms (`stt_prop_race_tannoy`) | 5 | "Maximum (5) Alarms placed" |
| Fireworks | 40 | "Maximum (40) fireworks placed" |
| Jet ski ramps near one spot | 10 | |
| Model memory | engine budget | `STREAMING::GET_USED_CREATOR_BUDGET() >= 1` blocks placing (46 calls in 6 scripts) |

The density check (`func_12708`, **Verified**) takes each placed prop's model dimensions (`GET_MODEL_DIMENSIONS`), uses half the box diagonal as a radius, and counts the props whose distance to the held prop is within the two radii added together.

## 12.7 Snapping track pieces together

This is how stunt tracks line up without gaps (**Verified**, `func_12733`, `func_12718` and the sorted list of nearby props):

1. **Snap points are bones.** Bones 2, 3, 4 and 5 of a prop model are its connection points. The manual snapping menu even labels them "Bone ~1~". A bone below the ground (`GET_GROUND_Z_EXCLUDING_OBJECTS_FOR_3D_COORD` under it) or already used is skipped. Eight models may only use bone 2, and the tube end pieces (`stt_prop_stunt_tube_fn_01` to `_05` and the `ba_prop_battle_tube_fn_*` copies) never use bone 4.
2. **Candidates.** The creator keeps a list of the 10 placed props nearest the held prop, sorted by distance (or the 4 best from the last search).
3. **Pairing.** For every free bone of the held prop and every free bone of a candidate, it measures the squared distance (`VDIST2`) and the bones' directions (from `GET_ENTITY_BONE_ROTATION`). A pair counts only if it is closer than 8,000 (about 89 m) and the two directions point at each other (dot product below 0). The closest pair wins.
4. **Moving.** The held prop is turned to the target bone's rotation (`SET_ENTITY_ROTATION` with `GET_ENTITY_BONE_ROTATION`) and moved so its bone sits on the target bone.
5. **Bookkeeping.** Each placed prop stores which of its snap bones are taken, as a bit field saved in the `prpsnpp` column.

The menu offers "Proximity Snapping", "Triggered Snapping", "Chain Snapping", "Set Position Overrides On Snap" and "Snap Rotation Angle" (in degrees). "Manual Snapping" (pick "Local Snap Point" and "Target Snap Point" bones yourself) only appears when the development switch is on, so the public creator doesn't show it.

**Rotation:** the race creator stores full three-axis rotation (`vRot`) as well as a heading (`head`). The race player uses the rotation (`SET_ENTITY_ROTATION`, order 2) when it is not zero or the model needs it, and the heading otherwise (**Verified**, `fm_race_controler` `func_12541`).

## 12.8 Props with behaviour

Several props carry settings that change the race (**Verified**, labels and `fm_race_controler`):

| Setting | Column | What the race does with it |
| --- | --- | --- |
| Prop colour ("Prop Tint Color") | `prpclr` | `SET_OBJECT_TINT_INDEX` if the model has that tint; a tunable can force colour 0 |
| Speed pad strength | `prpsba` | For the speed-up props (`stt_prop_track_speedup`, `_t1`, `_t2`, `stt_prop_stunt_tube_speed`, `_speedb`, `ar_prop_ar_speed_ring`, the `ar_prop_ar_tube_*speed` tubes): `SET_OBJECT_SPEED_BOOST_AMOUNT` and `_DURATION`. Values 1 to 5 give 15/0.3 s, 25/0.4 s (default), 35/0.5 s, 45/0.5 s, 100/0.5 s; *probable* names Weak, Normal, Strong, Extra Strong, Ultra Strong |
| Slow pad ("Drag Pad Intensity") | `prpsba` | For `stt_prop_track_slowdown` and its `_t1`, `_t2`: boost amount 44, 30 (default) or 16; *probable* Weak, Normal, Strong |
| Draw distance | `pLODDist` | At least 150 m for every prop (raised with `SET_ENTITY_LOD_DIST` if the model's own is lower), more if set |
| Sound and effects | `sndid`, `sndtri`, `sndlmt`, `ptfxtr`, `ptfxst` | Sound triggers (`stt_prop_speakerstack_01a` needs a trigger radius above 0) and particle effects |
| Moving props | `updatez`, `updtime`, `upddel` | *probable* props that move up or down on a timer |
| Fireworks | `fwTPos`, `fwTSize`, `fwTeam` | Firework trigger position, size and team |

## 12.9 Removing and swapping map objects

"Fixtures Removed" hides objects that are part of the map so a track can go through them (**Verified**). Each entry stores a position (`pos`), a model (`mn`), flags (`bits`), an optional replacement model (`mnSwap`) and a radius (`wprad`), in the `dhprop` section; up to 40 per job. The creator and the race call `CREATE_MODEL_HIDE` (or `_EXCLUDING_SCRIPT_OBJECTS`) at that spot. The radius is the stored one when set, 8 m for some gates and buoys (`prop_gate_airport_01`, `prop_gate_military_01`, `prop_dock_bouy_*`), otherwise 0.1 m, so it hides only the object at that exact point. `CREATE_MODEL_SWAP` replaces instead of hiding.

The creator also loads map variants to build in: 47 `REQUEST_IPL` calls in the race creator, among them the Arena (`Xs_arena_interior` and its mods), the Diamond Casino (`vw_casino_main`, `_garage`, `_carpark`, `_penthouse`) and Cayo Perico (`h4_islandx` and 11 other `h4_` IPLs; `AM_MP_ISLAND` is started and island path nodes are allowed). See [streaming](/docs/core/streaming.md) for IPLs.

## 12.10 Saving and publishing

**Building the file** (**Verified**): `DATAFILE_CREATE`, then a dictionary per section. The race creator's writer creates `mission`, and under it `gen`, `meta`, `race`, `prop`, `dprop`, `dhprop`, `ptemp`, `veh`, `weap`, `obj`, `zone`, `ene`, `rule`, `endcon` and others: the same sections the [UGC file guide](/file-formats/ugc-json.md) counted in the local files. The writers are shared code, so the same functions appear in every creator.

**Columns, not records.** Each section stores one array per field, one entry per item:

- `prop`: `no` (count), then `loc` (position), `vRot` (rotation), `head` (heading), `model` (hash, as a signed integer), `prpclr`, `prplod`, `prpsba`, `prpsnpp`, `pLODDist` and so on: 69 arrays always written, `prpsdp0` to `prpsdp3`, and about 17 more (`prolib`, `prpSlSp` ...) written only when used.
- `race`: `chp` (checkpoint count), `lap`, `subtype`, grid settings, and per-checkpoint arrays `chl` (location), `chh` (heading), `chs` and `chs2` (*probable* sizes), `chpp`, `cpbs1` to `cpbs3` (option bits), `cptfrm` (transform vehicle) and others: 32 checkpoint column names.
- `dhprop`: `no`, `pos`, `mn`, `bits`, `mnSwap`, `wprad`, `vcid`.

**Sparse columns** (**Verified**, `func_170`): for most optional fields the writer only creates the array when it meets the first item whose value differs from the default. It then fills the earlier entries with the default and carries on. A reader must treat a missing array as "all default". Two prop writers exist (a full one and a sparse one, chosen by `func_189`); which jobs use which is open.

**Sending it** (**Verified**): a new creation is uploaded with `DATAFILE::UGC_CREATE_MISSION` and an edited one with `UGC_UPDATE_MISSION`, both with content type `"gta5mission"` (the same function also knows `playlist`, `lifeinvaderpost`, `photo` and `challenge`); `UGC_PUBLISH` makes it public. Each of the six creators has one create and one update call; `UGC_PUBLISH` appears 19 times in 7 scripts. Before publishing, text is checked with `SC_PROFANITY_CHECK_STRING_UGC`, and `NETWORK_HAVE_USER_CONTENT_PRIVILEGES` gates the whole thing. Loading a creation back goes through the UGC query natives (`UGC_QUERY_MY_CONTENT`, `UGC_GET_*`); `DATAFILE_LOAD_OFFLINE_UGC` also reads local files such as `RockstarPlaylists`.

**Who reads it.** Only the menu-side scripts parse the `prop` section from JSON (12 scripts: the six creators, `creator`, `fmmc_launcher`, `fmmc_playlist_controller`, `net_cloud_mission_loader`, `appmpjoblistnew`, `pausemenu_multiplayer`). They fill the FMMC globals; the race and mission controllers then read the globals, not the file.

## 12.11 How a race puts the props back

When a race starts, `fm_race_controler` loops over the prop list in the globals (**Verified**, `func_12540` and `func_12541`). For each prop:

1. `CREATE_OBJECT(model, position, isNetwork = false, ...)`: **static props are local objects**, created separately on every player's machine, not synced over the network. Dynamic props are different (below).
2. `SET_ENTITY_COORDS`, then `SET_ENTITY_ROTATION` (order 2) or `SET_ENTITY_HEADING`.
3. Unless the prop is meant to be shot: `SET_OBJECT_TARGETTABLE(false)`, `SET_ENTITY_INVINCIBLE`, `SET_ENTITY_PROOFS` (all), `FREEZE_ENTITY_POSITION`, `SET_OBJECT_ALLOW_LOW_LOD_BUOYANCY`.
4. Draw distance at least 150 m (`SET_ENTITY_LOD_DIST`), then the prop's own `pLODDist` if set; `SET_WAIT_FOR_COLLISIONS_BEFORE_PROBE`.
5. In some race types the prop is moved out of interior rooms (`CLEAR_ROOM_FOR_ENTITY`, `SET_IS_EXTERIOR_ONLY`).
6. Colour, speed and slow pads, sounds as in 12.8. Flares, one firework model and one bush have their collision turned off.

**Dynamic props** (the `dprop` section, which has the same `loc`, `vRot`, `head` and `model` columns plus `obref`) are shared by everyone (**Verified**, `func_12303` and `func_886`):

- Only the **script host** creates them (`NETWORK_IS_HOST_OF_THIS_SCRIPT`), and only while `CAN_REGISTER_MISSION_OBJECTS(1)` allows one more mission object.
- Each is created with networking on and converted to a network ID (`OBJ_TO_NET`), so every player sees the same object move, break or explode. A player changes one only when they have control of it (`NETWORK_HAS_CONTROL_OF_NETWORK_ID`).
- Seven breakable models from the Specialist races (`sr_prop_sr_boxpile_01` to `_03`, `sr_prop_sr_track_wall`, `sr_prop_sr_tube_wall`, `sr_mp_spec_races_ammu_sign`, `ar_prop_ar_ammu_sign`) are rebuilt: when one has been broken and the host is within 200 m, the host deletes it, clears 10 m around it and creates it again.

Checkpoints are drawn with `CREATE_CHECKPOINT` (14 calls in the controller) from the `chl`/`chh` arrays.

### 12.11.1 The Mission Creator's limits (second pass)

*Second pass, 2026-10-30.* **Verified** in `public_mission_creator`. One function gives the maximum count for each kind of placed item, and a second gives the matching "Maximum ... placed" message:

| Item | Limit | Message |
| --- | ---: | --- |
| Props | 200 | `PMCE_F_P` "Maximum Props placed." |
| Spawn points | 60 | `PMCE_F_S` |
| Actors | 50 | `PMCE_F_A` |
| Pickups | 50 | `PMCE_F_W` |
| Fixtures hidden | 40 | `PMCE_F_F` |
| Vehicles | 32 | `PMCE_F_V` |
| Zones | 32 | `PMCE_F_Z` |
| Doors configured | 32 | `PMCE_F_DR` |
| Dynamic props | 20 | `PMCE_F_D` |
| Objects | 20 | `PMCE_F_O` |
| Locations | 20 | `PMCE_F_L` |
| Interactables | 20 | `PMCE_F_I` |

## 12.12 What this means for modders

- **The creator can't be used in story mode.** It is an Online script that needs a session, Online privileges and Rockstar's cloud to save. Don't run mods in GTA Online to get at it; accounts get banned.
- **The same building blocks work in single player.** Nearly every native the creator uses for placing is an ordinary one (the model budget, `GET_USED_CREATOR_BUDGET`, is the exception): a fly camera, a ray from the camera, `CREATE_OBJECT`, `SET_ENTITY_ROTATION`, `FREEZE_ENTITY_POSITION`, `SET_OBJECT_TINT_INDEX`, `SET_OBJECT_SPEED_BOOST_AMOUNT`, `CREATE_MODEL_HIDE`. A story-mode map editor is these natives plus a menu. Community editors such as [Menyoo](https://github.com/MAFINS/MenyooSP) already do this; link to them, don't copy them.
- **To rebuild a creator track in story mode**, read the `prop` columns as 12.11 does: create non-networked objects, freeze them, raise the draw distance to at least 150 m, apply the tint and the speed-pad table above, and hide the `dhprop` objects. Treat missing columns as defaults (12.10). Stunt props from DLC packs (`stt_`, `ar_`, `sum_`) need their pack loaded, which story mode does for packs in `dlclist.xml` (**Known**, [archives and content](/docs/core/archives-and-content.md)).
- **Snapping is easy to copy:** bones 2 to 5 on stunt track models are the ends, so `GET_ENTITY_BONE_COUNT`, `GET_WORLD_POSITION_OF_ENTITY_BONE` and `GET_ENTITY_BONE_ROTATION` give a mod the same "click into place" behaviour.
- **Respect the budgets on a weak PC.** Rockstar caps a job at 200 static props, 50 around one spot and an engine model budget for a reason: every prop is a streamed model and a physics object ([physics cost](/docs/performance/physics-cost.md), [memory and pools](/docs/core/memory-and-pools.md)). A story-mode track with hundreds more props than that will stream slowly on a low-end PC.

## 12.13 Open questions

| Question | Where it goes |
| --- | --- |
| What job types 4 and 31 are, and what the even and odd race subtypes of a pair mean | Mostly answered above (second pass): odd subtypes are one-lap (point-to-point) races; types 4 and 31 are handled with missions and Survival but stay unnamed |
| The prop limit in `public_mission_creator`, which uses its own messages (`PMCE_F_P`, `PMCE_F_D`) | Answered in [12.11.1](#12111-the-mission-creators-limits-second-pass): 200 props, 20 dynamic props, and the other limits |
| The second dynamic list (library 15), library 39 and the other libraries with no text: hidden, Rockstar-only, or text in a pack not read | Second pass, with every DLC text block |
| What `GET_USED_CREATOR_BUDGET` measures inside the engine | Reverse engineering, R1.5 (streaming) |
| Which jobs are saved by the full prop writer and which by the sparse one (`func_189`) | Second pass, compare with the 16 local classic missions ([R7.4](/file-formats/ugc-json.md)) |
| Meaning of `chs`, `chs2`, `chpp` and the `cpbs1` to `cpbs3` bits | Second pass, read the race controller's checkpoint code |
| How the deathmatch and mission controllers create dynamic props (the race is in 12.11) | Next pass |
| The other creators' own placement (spawn points, enemy waves, capture objects) | Second pass per creator |

## 12.14 Test cards (story mode, a script mod)

Not run yet; each needs a small C#, Lua or C++ script ([modding path](/modding/README.md)).

1. **Snap bones.** Spawn `stt_prop_track_straight_l` in story mode and print `GET_ENTITY_BONE_COUNT` and the world position of bones 2 to 5. Expected (*probable*): more than 5 bones, with 2 to 5 at the ends of the track piece.
2. **Speed pad.** Spawn `stt_prop_track_speedup` flat on a road, freeze it, call `SET_OBJECT_SPEED_BOOST_AMOUNT(obj, 25)` and `SET_OBJECT_SPEED_BOOST_DURATION(obj, 0.4)`, and drive over it. Expected: a short push forward. Repeat with 100 and 0.5 for the "Ultra Strong" push.
3. **Draw distance.** Spawn a stunt prop and read `GET_ENTITY_LOD_DIST`; set 150 and fly away. Expected: with the default the prop disappears sooner than at 150 m.
