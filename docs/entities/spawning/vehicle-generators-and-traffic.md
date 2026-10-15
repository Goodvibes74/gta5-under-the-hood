# Vehicle generators and traffic

Where parked cars come from (car generators in the map files), what decides the traffic on the roads (the population cycle and the vehicle groups), how trains run, how police, fire and ambulance vehicles are sent, and how scripts thin out, block or empty the roads. Roadmap topic **R4.3** in the [roadmap](/ROADMAP.md). Builds on [streaming](/docs/core/streaming.md) (population budgets and LOD), [memory, pools and limits](/docs/core/memory-and-pools.md) (the 300-vehicle limit) and [CPU](/docs/performance/cpu.md) (what traffic costs). Peds and the population cycle as a whole are R4.1; scenarios (ambient planes, boats and parked scenario vehicles) are R4.2; police behaviour is R3.7.

**How it was made.** Every `.ymap` in the vanilla archives (the root `x64*.rpf`, `update\update.rpf` and every DLC pack, 19,362 files) was loaded with CodeWalker's library and its car generators (`CCarGen`) and timecycle boxes counted; when the same ymap name appears in several archives, only the copy that wins (update over DLC over base) was counted. Data files extracted the same way: the update copies of `common:/data/levels/gta5/popcycle.dat`, `trains.xml`, the twelve `trains*.dat` tracks and `traintracks.xml`, `common:/data/dispatch.meta`, and `update:/x64/levels/gta5/popgroups.ymt` (converted to XML). Native use from the [VEHICLE](/scripting/native-usage/VEHICLE.md), [PATH](/scripting/native-usage/PATH.md) and [MISC](/scripting/native-usage/MISC.md) usage pages; `main_persistent` read in the build-3725 decompile (commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts and values are **Verified**; what the engine does with them is **Known** unless stated.

## Short version

- **22,506 car generators** in the map files (winning copies only): 2,255 in base-game ymaps that no update replaces, 8,515 in `update.rpf` (which replaces many base ymaps), 11,736 in DLC packs (many in Online-only map sections and the Cayo Perico island).
- **93% are "random":** 20,881 generators name no model and pick one from the area's vehicle groups. The rest name a model: `trailers2` 128, `trailers` 114, `rentalbus` 114, `mule` 86, `bulldozer` 52, `forklift` 50, `seashark` 50, `tanker` 44 ...
- **Traffic comes from the population cycle.** `popcycle.dat` has 116 schedules (one per map area such as `ALTA`, `VINE_WOOD`, `SANDY_SHORES`), each with 12 two-hour slots for weekdays and weekends: at most 20 to 100 moving cars, up to 40 parked cars and 40 low-priority parked cars, and the share of police cars (0 to 2%). Each slot lists the vehicle groups to draw from, by weight.
- **55 vehicle groups** in `popgroups.ymt` (`veh_mid` 44 models, `veh_freeway` 34, `veh_rich` 33, `veh_poor` 24 ...), most with an `_mp` twin for Online.
- **Trains run on 2 of 12 tracks.** `traintracks.xml` defines 12 tracks (the main freight loop has 4,226 nodes, the metro 2,250); `main_persistent` switches on only track 0 (freight) and track 3 (metro), sets a freight every 120 seconds and turns random trains on. 29 train configs (28 freight, 1 metro) are built from 10 carriage models.
- **14 dispatch services** in `dispatch.meta`: police cars, bikes, helicopters, road blocks and boats, SWAT cars and helicopters, fire trucks, ambulances, army, gangs, bikers and assassins.
- **Missions control traffic every frame.** `SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` (180 scripts), `SET_ROADS_IN_AREA` (83), `SET_ALL_VEHICLE_GENERATORS_ACTIVE_IN_AREA` (239), `SET_VEHICLE_MODEL_IS_SUPPRESSED` (191), `SET_VEHICLE_POPULATION_BUDGET` (76).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `.ymap` map files (`CCarGen` entries) | Car generators: position, direction, model or none, population group, flags, livery | 22,506 in 11,061 distinct ymaps |
| `common:/data/levels/gta5/popcycle.dat` | Population schedules: per area and two-hour slot, the maximum ambient peds, scenario peds, cars, parked and low-priority parked cars, the police share, and the ped and vehicle groups with weights | 116 schedules, 1,392 rows |
| `update:/x64/levels/gta5/popgroups.ymt` | Ped groups (171) and vehicle groups (55) with their models | 55 vehicle groups |
| `common:/data/levels/gta5/popzone.ipl` | The map zones and which schedule each uses (**Known**) | R4.1 |
| `common:/data/levels/gta5/traintracks.xml`, `trains1.dat` to `trains12.dat` | 12 tracks: node lists, speed, braking distance, whether the train stops at stations (story and Online) | 7,769 nodes |
| `common:/data/levels/gta5/trains.xml` | Train configs (engine and carriages, repeat counts, carriage gaps, station announcements) and groups | 29 configs, 2 groups |
| `common:/data/dispatch.meta` (update copy) | Dispatch services, their vehicle sets and how many respond per wanted level | 14 services |
| Road nodes (`.ynd`) | The road network traffic drives on | R17.5 |

### Car generators

**Verified:** of the 22,506 generators, 21,401 use no population group and 20,881 name no model. The named groups are `large_city` 140, `army` 138, `freeway` 73, `police` 72, `airport` 58, `camper` 24, `boat_trailer` 22 and a few small ones, plus one unresolved group hash on 455 generators. The flags field holds a small set of values: 3,680 on 11,311 generators, 3,936 on 4,296, 3,616 on 1,089, 1,632 on 818 (meaning of the bits not decoded here).

**Known (engine):** a generator spawns a parked vehicle when the player comes within range and there is room in the parked-car budget for the area (`#prkdcrs` in the schedule), and removes it when the player leaves, unless the player used the vehicle. "Low priority" generators fill a second, smaller budget that missions often switch off. Generators are suppressed while a mission or script clears the area.

### The population cycle

**Verified:** one row looks like this (`ALTA`, the first weekday slot): 4 ambient peds, 30 scenario peds, 60 cars, 20 parked, 40 low-priority parked, 1% police cars, 0% police peds, then the ped groups with weights (`Alta_Business 10`, `Alta_Tramps 20` ...) and the vehicle groups (`VEH_MID 80`, `VEH_TRANSPORT 10`, `VEH_LARGE_CITY 0`, `VEH_BIKES 10`). Across all 1,392 rows the car maximum runs from 20 to 100 (median 85); 40 different vehicle groups are referenced. The busiest areas reach 100 cars (`VINE_WOOD`, `WEST_VINEWOOD`, `VESPUCCI_*`, the prologue); the quietest are 40 (`SANDY_SHORES` in Online, `TERMINAL`).

**Known (engine):** these are caps, not targets. What actually spawns is further limited by the population budget (scaled by the `CityDensity` and `VehicleVarietyMultiplier` settings and by memory), by what models are in memory, and by the road nodes near the player. Cars appear out of view on road nodes and are removed when far away or behind the player.

### The vehicle groups

| Group | Models | Example models |
| --- | ---: | --- |
| `veh_mid` | 44 | `asterope`, `baller`, `buffalo`, `blista` |
| `veh_freeway` | 34 | `baller`, `burrito`, `buffalo`, `camper` |
| `veh_rich` | 33 | `banshee`, `bjxl`, `bullet`, `carbonizzare` |
| `veh_poor` | 24 | `asea`, `buccaneer`, `emperor2`, `intruder` |
| `veh_countryside_onroad` / `_offroad` | 20 / 16 | `fq2`, `gresley` / `bfinjection`, `bison` |
| `veh_haulage` | 16 | `benson`, `hauler`, `flatbed`, `mixer` |
| `veh_bikes`, `veh_bicycles` | 12, 4 | `akuma`, `bati` / `bmx`, `scorcher` |
| `veh_salt` | 12 | Salton Sea area: `picador`, `rebel2`, `tornado3` |
| `veh_utility` | 8 | `burrito`, `pony`, `speedo`, `utillitruck` |
| `veh_boats`, `veh_boats_freeway` | 7, 3 | `seashark`, `jetmax`, `squalo`, `tropic` |
| `veh_large_city` | 4 | `pounder`, `biff`, `mule`, `taco` |
| `veh_army` | 4 | `crusader`, `barracks`, `rhino` |
| `veh_copcar` | 3 | `police`, `police2`, `police3` |
| `veh_yankton` | 6 | The North Yankee prologue cars |
| `veh_airport` | 2 | `ripley`, `airbus` |

Most groups have an `_mp` twin for Online with a few models fewer. DLC vehicles reach traffic by being added to these groups or by DLC population files (**Known**).

## Trains

**Verified (data):** `traintracks.xml` lists 12 tracks:

| Track | File | Nodes | Config group | Speed | Stops at stations |
| --- | --- | ---: | --- | ---: | --- |
| 0 | `trains1.dat` | 4,226 | freight | 15 | no (Online yes) |
| 1, 2 | `trains2.dat`, `trains3.dat` | 286, 82 | freight | 8 | no |
| 3 | `trains4.dat` | 2,250 | metro | 8 | yes |
| 4 to 10 | `trains5.dat` to `trains11.dat` | 18 to 267 | freight | 8 | no |
| 11 | `trains12.dat` | 176 | freight | 15 | no |

`trains.xml` builds 28 freight configs and 1 metro config from 10 carriage models: `freight` (the engine, in 26 configs), `freight2`, `freightcar` (35 uses), `freightcar2`, `freightcar3`, `freightcont1` (15), `freightcont2` (7), `freightgrain` (16), `tankercar` (14) and `metrotrain`.

**Verified (script):** `main_persistent`, on the main map, deletes all trains, switches track 0 and track 3 on and the other ten off (`SWITCH_TRAIN_TRACK`), sets `SET_TRAIN_TRACK_SPAWN_FREQUENCY(0, 120000)` (a freight every 120 s on the main line), and calls `SET_RANDOM_TRAINS(true)`. It is the only caller of either setting in the game. Missions stop trains with `SET_RANDOM_TRAINS` (50 scripts) and spawn their own with `CREATE_MISSION_TRAIN` (28 scripts; **Known**: its first argument is a config index from `trains.xml`).

## Emergency vehicles

**Verified (data):** `dispatch.meta` defines 14 services (`DT_PoliceAutomobile`, `DT_PoliceHelicopter`, `DT_SwatHelicopter`, `DT_FireDepartment`, `DT_SwatAutomobile`, `DT_AmbulanceDepartment`, `DT_Gangs`, `DT_PoliceRiders`, `DT_PoliceVehicleRequest`, `DT_PoliceRoadBlock`, `DT_PoliceBoat`, `DT_ArmyVehicle`, `DT_BikerBackup`, `DT_Assassins`) and their vehicle sets (`POLICE_CAR`, `POLICE_MOTORCYCLE`, `SWAT_JEEP`, `POLICE_HELI_1` and `_2`, `AMBULANCE`, `FIRE_TRUCK`, three road-block sets including spike strips, `POLICE_BOAT`, `ARMY`, `GANGS`, `BIKER`, `ASSASSINS`). **Known:** fire trucks answer fires and ambulances answer injured peds near the player; police dispatch scales with the wanted level (R3.7).

Scripts switch services with `ENABLE_DISPATCH_SERVICE` (290 scripts, 2,901 calls), keep them away with `ADD_DISPATCH_SPAWN_ANGLED_BLOCKING_AREA` and friends, and stop random police with `SET_CREATE_RANDOM_COPS` (109 scripts).

## How scripts control traffic

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_ALL_VEHICLE_GENERATORS_ACTIVE_IN_AREA` | 239 | 837 | Turn parked-car generators off (and back on) around a set |
| `SET_VEHICLE_MODEL_IS_SUPPRESSED` | 191 | 904 | Keep a model out of traffic (mission cars, so you don't meet a twin) |
| `SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` | 180 | 549 | Thin or thicken traffic, every frame |
| `SET_RANDOM_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME`, `SET_PARKED_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` | 103, 97 | 164, 137 | Moving or parked cars only |
| `SET_ROADS_IN_AREA`, `SET_ROADS_IN_ANGLED_AREA`, `SET_ROADS_BACK_TO_ORIGINAL` | 83, 74, 82 | 253, 341, 162 | Switch road nodes off so no traffic drives there |
| `SET_VEHICLE_POPULATION_BUDGET` | 76 | 361 | Lower the vehicle budget during heavy scenes (0 to 3) |
| `SET_ALL_VEHICLE_GENERATORS_ACTIVE` | 50 | 54 | Reset generators after a mission |
| `SET_RANDOM_TRAINS`, `DELETE_ALL_TRAINS` | 50, 39 | 135, 59 | Trains off or cleared |
| `SET_NUMBER_OF_PARKED_VEHICLES` | 25 | 57 | Cap parked cars |
| `SET_GARBAGE_TRUCKS`, `SET_ALL_LOW_PRIORITY_VEHICLE_GENERATORS_ACTIVE` | 23, 23 | 44, 44 | Called together by story missions to quieten an area |
| `SET_AMBIENT_VEHICLE_RANGE_MULTIPLIER_THIS_FRAME` | 14 | 23 | Spawn traffic nearer or farther |
| `SET_DISTANT_CARS_ENABLED` | 10 | 27 | The far-away traffic lights on roads |
| `SET_RANDOM_BOATS` | 2 | 5 | Ambient boats (`exile3`, `director_mode`) |
| `CREATE_SCRIPT_VEHICLE_GENERATOR` | 2 | 42 | A generator a script owns (`freemode`, `am_imp_exp` only); story mode doesn't use it |

## What this means for modders

- **More or less traffic:** call `SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` (and the random and parked variants) every frame; 0 empties the roads. For a permanent change everywhere, edit the `#Cars` and parked columns in `popcycle.dat` (a data edit through a `dlc_patch` or the mods folder).
- **Add cars to traffic:** add the model to a vehicle group in `popgroups.ymt` (convert with CodeWalker) or, for an add-on pack, ship your own population data (**Known**). Heavier traffic costs CPU on the main thread and memory for models (see [CPU](/docs/performance/cpu.md)).
- **Parked cars at a spot:** add a `CCarGen` to a ymap you ship (a map mod), or in a script create the vehicle when the player is near and remove it after. `CREATE_SCRIPT_VEHICLE_GENERATOR` exists, but story scripts never use it.
- **Keep a model out of traffic** with `SET_VEHICLE_MODEL_IS_SUPPRESSED(model, true)`, and give it back when your mod stops.
- **Trains:** the other ten tracks exist and can be switched on with `SWITCH_TRAIN_TRACK(track, true)` (**Known**: some are short spurs and look unfinished). Turn trains off for a set piece with `SET_RANDOM_TRAINS(false)` and back on after; `main_persistent` sets them up only once.
- **Clean up.** Every "this frame" native stops working when you stop calling it, but the others (`SET_ROADS_IN_AREA`, `SET_ALL_VEHICLE_GENERATORS_ACTIVE_IN_AREA`, `SET_RANDOM_TRAINS`) persist until something resets them.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| What the car generator flag bits mean (3,680, 3,936 ...) | Second pass: compare generators in known places |
| Which DLC ymaps with generators load in story mode | R4.6 (map data), R4.5 (IPLs) |
| How the schedule caps, the budget and the `CityDensity` setting combine | R4.1, test card 1 |
| What the ten unused train tracks are and whether they work | Test card 3 |
| Where ambient planes, helicopters and boats on routes come from | R4.2 (vehicle scenarios) |

## Test cards

1. **Caps.** In Vinewood at noon on a weekday, count vehicles within 150 m (`World.GetAllVehicles()` in a ScriptHookVDotNet script, filtered by distance) for a minute; repeat in Sandy Shores. Expected: many more in Vinewood (cap 100 vs 60).
2. **Generators off.** `SET_ALL_VEHICLE_GENERATORS_ACTIVE_IN_AREA` with `false` around a car park, leave and come back. Expected: the parked cars don't respawn until you call it with `true`.
3. **Spur tracks.** `SWITCH_TRAIN_TRACK(1, true)`, wait near the start of `trains2.dat`. Expected: a freight train on the short track.
4. **Metro.** Ride the metro and watch it stop at stations (`stopsAtStations` true for track 3).
