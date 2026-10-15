# Navigation and pathfinding

How peds and vehicles find their way: the navmesh tiles peds walk on (4,404 in the base game plus 37 for walkable vehicles), the road and path nodes cars drive on (259 node files, 274 in the update), how both stream around the player, the natives Rockstar's scripts use to send peds somewhere, block routes, add cover and patrol, and why peds get stuck. Roadmap topic **R17.5** in the [roadmap](/ROADMAP.md). Builds on [driving and AI driving](/docs/ai/driving.md) (R3.3), [streaming](/docs/core/streaming.md) (R1.5) and [map data](/docs/world/map-data.md) (R4.6).

**How it was made.** Every `.ynv` and `.ynd` file in the `x64*.rpf` archives and `update\update.rpf` of build 1.0.3725.0 was listed with [`tools/rpf-cw.ps1`](/tools/README.md), and the navmesh grid read from the file names. Native counts from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Counts are **Verified**; tile size, what a navmesh holds and how the planner works are **Known** (CodeWalker's formats and community research).

## 34.1 Short version

- **Peds walk on navmeshes:** 4,404 `.ynv` tiles (308 MB) in ten `navmeshes*.rpf` archives inside `x64f.rpf`, named by grid cell `navmesh[x][y]` with x from 36 to 246 and y from 6 to 288 in steps of 3. *Known*: each tile covers 150 × 150 m and holds walkable polygons, edges to neighbours, climb and drop links, cover points and portals into interiors.
- **37 navmeshes belong to vehicles** you can walk on (`predator`, `seashark`, `squalo`, `proptrailer` ...), and DLC packs add their own tiles (16 in one pack's archive inside `x64w.rpf`).
- **Cars drive on path nodes:** 259 `nodes*.ynd` files in `x64e.rpf`'s `paths.rpf`, replaced by 274 in `update.rpf` and patched by DLC copies (494 in `x64w.rpf`). Nodes carry road links, speed, lane counts, junctions and street-name hashes (**Known**).
- **Both stream around the player.** Scripts that send peds or cars far away ask for the area first: `ADD_NAVMESH_REQUIRED_REGION` (223 scripts) with `IS_NAVMESH_LOADED_IN_AREA` (220), and `REQUEST_PATH_NODES_IN_AREA_THIS_FRAME` (328) or `LOAD_ALL_PATH_NODES` (93).
- **The commonest movement orders:** `TASK_FOLLOW_NAV_MESH_TO_COORD` (481 scripts, 2,930 calls), `TASK_GO_STRAIGHT_TO_COORD` (408, 2,963; no pathfinding), `TASK_GO_TO_COORD_ANY_MEANS` (277; walk or drive), `TASK_GO_TO_ENTITY` (152).
- **Scripts shape routes:** block areas with navmesh blocking objects (`ADD_NAVMESH_BLOCKING_OBJECT`, 88 scripts), allow or deny climbing and ladders (`SET_PED_PATH_CAN_USE_CLIMBOVERS` 140, `_LADDERS` 112), switch ped paths off in an area (`SET_PED_PATHS_IN_AREA` 49), build patrol routes (97 scripts) and add cover points (38).
- **Recorded routes** replace pathfinding for set pieces: `REQUEST_WAYPOINT_RECORDING` (376 scripts) for peds and vehicles ([R3.3](/docs/ai/driving.md)).

## 34.2 Navmeshes

| Where | Files | Notes |
| --- | ---: | --- |
| `x64f.rpf` → `levels\gta5\navmeshes.rpf` to `navmeshes9.rpf` | 4,404 (4,367 tiles + 37 vehicle meshes) | Grid `navmesh[36..246][6..288]`, step 3 |
| DLC packs (example: one pack in `x64w.rpf`) | 16 | New areas and interiors |

A ped's route is planned on the navmesh polygons and smoothed into a path (**Known**). Interiors are stitched in through portals; doors are crossed with the door system ([props and doors](/docs/entities/objects/props-and-doors.md)); climbs, drops and ladders are special links the ped may or may not use (`SET_PED_PATH_CAN_USE_CLIMBOVERS`, `_LADDERS`, `_CAN_DROP_FROM_HEIGHT`).

**Why peds get stuck** (**Known**, with the script fixes Rockstar uses):

| Cause | Fix in Rockstar's scripts |
| --- | --- |
| The navmesh around the goal isn't loaded | `ADD_NAVMESH_REQUIRED_REGION`, wait for `IS_NAVMESH_LOADED_IN_AREA` |
| A prop or vehicle stands on the route the navmesh doesn't know about | `ADD_NAVMESH_BLOCKING_OBJECT` around it (88 scripts) |
| The goal is off the navmesh (inside a prop, in water) | `GET_SAFE_COORD_FOR_PED` (257 scripts) to find a reachable point |
| The route needs a climb or ladder the ped isn't allowed | Set the path flags |
| Pathfinding is the wrong tool | `TASK_GO_STRAIGHT_TO_COORD` or a waypoint recording |

## 34.3 Path nodes

| Where | Files |
| --- | ---: |
| `x64e.rpf` → `levels\gta5\paths.rpf` | 259 |
| `update.rpf` → `x64\levels\gta5\paths.rpf` | 274 |
| DLC copies in `x64w.rpf` | 494 |

Ambient traffic and AI drivers plan on nodes; peds use navmeshes. Scripts switch roads off and on (`SET_ROADS_IN_AREA`, `SET_ROADS_BACK_TO_ORIGINAL`; the job creator does it, [R7.11](/docs/online/creator-internals.md)) and ask for nodes (`GET_CLOSEST_VEHICLE_NODE`, `GET_NTH_CLOSEST_VEHICLE_NODE`). Street names shown on the HUD come from the nodes ([text and names](/docs/entities/objects/text-and-names.md)).

## 34.4 Natives

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `TASK_FOLLOW_NAV_MESH_TO_COORD` | 481 | 2,930 |
| `TASK_GO_STRAIGHT_TO_COORD` | 408 | 2,963 |
| `REQUEST_WAYPOINT_RECORDING`, `GET_IS_WAYPOINT_RECORDING_LOADED` | 376 | 1,621, 1,667 |
| `REQUEST_PATH_NODES_IN_AREA_THIS_FRAME` | 328 | 962 |
| `TASK_GO_TO_COORD_ANY_MEANS` | 277 | 665 |
| `GET_SAFE_COORD_FOR_PED` | 257 | 298 |
| `ADD_NAVMESH_REQUIRED_REGION`, `REMOVE_NAVMESH_REQUIRED_REGIONS`, `IS_NAVMESH_LOADED_IN_AREA` | 223, 226, 220 | 230, 464, 221 |
| `TASK_GO_TO_ENTITY` | 152 | 243 |
| `SET_PED_PATH_CAN_USE_CLIMBOVERS`, `_LADDERS` | 140, 112 | 287, 237 |
| Patrol routes (`CREATE_`, `OPEN_`, `ADD_PATROL_ROUTE_NODE`, `_LINK`, `CLOSE_`) | 97 | 115 to 164 |
| `LOAD_ALL_PATH_NODES` | 93 | 186 |
| `ADD_NAVMESH_BLOCKING_OBJECT`, `REMOVE_`, `DOES_NAVMESH_BLOCKING_OBJECT_EXIST` | 88, 82, 56 | 221, 176, 104 |
| `GET_NAVMESH_ROUTE_RESULT` | 65 | 80 |
| `SET_PED_PATHS_IN_AREA`, `SET_PED_PATHS_BACK_TO_ORIGINAL` | 49, 33 | 128, 55 |
| `ADD_COVER_POINT`, `REMOVE_COVER_POINT` | 38, 32 | 268, 235 |

## 34.5 What this means for modders

- **Before sending a ped far, load the area:** `ADD_NAVMESH_REQUIRED_REGION`, wait for `IS_NAVMESH_LOADED_IN_AREA`, then the task; remove the region at cleanup.
- **Spawned props block nothing until you tell the navmesh:** add a blocking object, or peds walk into them.
- **A new map area needs navmesh tiles** (and nodes for roads), built with map tools and added in a DLC pack; without them peds stand still there.
- **Weak PC:** keep required regions small and few; each one keeps navmesh tiles in memory.

## 34.6 Open questions

| Question | Where it goes |
| --- | --- |
| Polygon, link and cover-point counts per tile | Second pass, a `.ynv` reader |
| Node and link counts in the `.ynd` files, and what the update changed | Second pass |
| How far around the player navmeshes stream by default | In-game test with `GET_NUM_NAVMESHES_EXISTING_IN_AREA` |

## 34.7 Test cards (story mode, a script mod)

1. **Far goal.** Tell a ped to `TASK_FOLLOW_NAV_MESH_TO_COORD` to a point 2 km away without and with `ADD_NAVMESH_REQUIRED_REGION`. Expected: without it, the ped may stand still until the area loads.
2. **Blocking.** Spawn a container on a pavement and send a ped through it, then add a navmesh blocking object. Expected: it walks around only after the blocker is added.
