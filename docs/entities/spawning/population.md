# Population

How GTA V decides who walks and drives around the player: the map's population zones, the schedules that set how many peds and cars each zone may have at each time of day, the ped and vehicle groups they draw from, the zone attributes (how rough an area is, how fast the police come), and the natives scripts and mods use to thin out, empty or reshape the population. Roadmap topic **R4.1** in the [roadmap](/ROADMAP.md). Builds on [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (R4.3: the vehicle side of the same files), [streaming](/docs/core/streaming.md) (population budgets) and [CPU](/docs/performance/cpu.md) (what population costs). Scenarios (peds placed at benches, bars, guard posts) are R4.2; how peds behave once spawned is R17.

**How it was made.** Data files extracted from `update\update.rpf` with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does): `common:/data/levels/gta5/popzone.ipl`, `common:/data/levels/gta5/popcycle.dat`, and `x64/levels/gta5/zonebind.ymt` and `popgroups.ymt` (converted to XML; schedule names in `zonebind.ymt` are hashes and were matched to the schedule names in `popcycle.dat`). Native use from the [PED](/scripting/native-usage/PED.md), [VEHICLE](/scripting/native-usage/VEHICLE.md), [MISC](/scripting/native-usage/MISC.md) and [ZONE](/scripting/native-usage/ZONE.md) usage pages (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts and values are **Verified**; how the population system uses them is **Known** unless stated.

## Short version

- **Three layers:** `popzone.ipl` cuts the map into 1,321 boxes (1,320 zone names such as `Z_RMAN2`, grouped into 97 area labels such as `Richm`, `PBluff`, `OCEANA`); `zonebind.ymt` gives each of 1,310 zones its attributes and the population schedule it uses in story mode and in Online; `popcycle.dat` defines 116 schedules.
- **A schedule is 12 two-hour slots.** Each slot sets the maximum ambient peds (median 10, at most 30), scenario peds (median 40, at most 60), moving cars (median 85, at most 100), parked and low-priority parked cars, the share of police cars, and the ped and vehicle groups with weights. The file's own comment promises weekday and weekend sets, but all 116 schedules have only the weekday set.
- **Story mode uses 66 schedules, Online 48.** The most common in story mode: `countryside` (405 zones), `OCEAN` (286), `FREEWAY` (86), `FREEWAY_CITY` (78), `SANDY_SHORES` (66), `VINEWOOD_HILLS` (33).
- **Zones also carry character:** a "scumminess" level (below average for 922 zones, posh 223, above average 90, scum 48, crap 18, nice 9), the police response delay (medium 746, slow 564) and vehicle (countryside 855, default 433, army base 22), the airport flag (21 zones), and how dirty vehicles and peds get.
- **171 ped groups and 55 vehicle groups** in `popgroups.ymt`; the schedules refer to 134 ped groups. The most-used are `InCar_General` (the drivers, 288 slots), fish and birds (`Fish` 252, `Birds_Ocean` 204, `Birds_Countryside` 180, `Birds_City` 144) and area street groups (`Vespucci_StreetGeneral`, `Rockford_Hills_Day` / `_Night`).
- **Scripts shape the crowd every frame:** `SET_ALL_RANDOM_PEDS_FLEE` (574 scripts), `CLEAR_AREA_OF_VEHICLES` (531), `CLEAR_AREA_OF_PEDS` (456), `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME` (158), pop multiplier areas and spheres (80 to 100 scripts each), `SET_PED_NON_CREATION_AREA` (86), and the population budgets (`SET_PED_POPULATION_BUDGET` 70 scripts).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/levels/gta5/popzone.ipl` | Zone boxes: name, min and max corners, area label | 1,321 boxes, 97 area labels |
| `x64/levels/gta5/zonebind.ymt` | Per zone: story and Online schedule, VFX region, scumminess, police response time and vehicle type, special attribute, dirt levels, population range scaling | 1,310 zones |
| `common:/data/levels/gta5/popcycle.dat` | Schedules: 12 slots each with caps, police shares and weighted ped and vehicle groups | 116 schedules, 1,392 slots |
| `x64/levels/gta5/popgroups.ymt` | Ped groups and vehicle groups with their models | 171 ped groups, 55 vehicle groups |
| `settings.xml` (the player's) | `CityDensity`, `PedVarietyMultiplier`, `VehicleVarietyMultiplier` | [Graphics settings](/docs/performance/graphics-settings.md) |

### The schedule columns

| Column | Meaning | Range in the file |
| --- | --- | --- |
| `#Peds` | Maximum ambient (walking) peds | up to 30, median 10 |
| `#Scenario` | Maximum scenario peds (R4.2) | up to 60, median 40 |
| `#Cars` | Maximum moving cars | 20 to 100, median 85 |
| `#prkdcrs`, `#lowprkdcrs` | Parked and low-priority parked cars | up to 40 each |
| `PercCopCars`, `PercCopPed` | Share of police cars and police peds | cars 0 to 2%, peds 0% everywhere |
| `MaxScenPeds`, `MaxScenVehs`, `MaxPreAssignedParked` | How many scenario ped and vehicle models may be streamed for scenarios | |
| `peds <group> <weight> ...` | Ped groups for the slot | 134 groups used |
| `cars <group> <weight> ...` | Vehicle groups for the slot | 40 groups used |

So the map is mostly fed by scenarios rather than free walkers: a typical slot allows 10 walking peds and 40 scenario peds. No schedule asks for police on foot; police peds come from dispatch and scenarios (R3.7, R4.2).

### Zone attributes

| Attribute | Values (zones) | What it changes (**Known**) |
| --- | --- | --- |
| `scumminessLevel` | `BELOW_AVERAGE` 922, `POSH` 223, `ABOVE_AVERAGE` 90, `SCUM` 48, `CRAP` 18, `NICE` 9 | Crime events, how peds react, shop prices in some scripts (`GET_ZONE_SCUMMINESS`) |
| `lawResponseTime` | `MEDIUM` 746, `SLOW` 564 | How fast the police arrive after a crime |
| `lawResponseType` | `COUNTRYSIDE` 855, `DEFAULT` 433, `ARMY_BASE` 22 | Which police (sheriff, LSPD, army) respond |
| `specialZoneAttribute` | `NONE` 1,289, `AIRPORT` 21 | Airport rules |
| `vehDirtMin/Max`, `pedDirtMin/Max`, dirt colour | per zone | How dirty spawned cars and peds look |
| `popRangeScaleStart/End`, `popRangeMultiplier`, `popBaseRangeScale` | per zone | How far from the player population spawns |

**Known (engine):** the population code reads the zone under the player (and the camera), takes the current two-hour slot of its schedule, and spawns peds and cars up to the caps from the weighted groups, limited by the budgets, the density settings, what models are in memory and the road and pavement nodes nearby. It removes them when they are far away or behind the player.

## How scripts shape the population

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_ALL_RANDOM_PEDS_FLEE` | 574 | 1,273 | Ambient peds run from the player (shared mission code) |
| `CLEAR_AREA_OF_VEHICLES`, `CLEAR_AREA_OF_PEDS` | 531, 456 | 1,999, 781 | Empty an area before a scene |
| `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME`, `SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME` | 158, 105 | 321, 172 | Fewer or more peds, every frame |
| `SET_ALL_RANDOM_PEDS_FLEE_THIS_FRAME` | 132 | 181 | The same for one frame |
| `GET_ENTITY_POPULATION_TYPE` | 109 | 209 | Is a ped ambient, scenario, mission ... |
| `ADD_POP_MULTIPLIER_SPHERE` / `REMOVE_...` | 100 / 100 | 161 / 165 | A sphere with its own density (Online interiors, contracts) |
| `GET_CITY_DENSITY` | 99 | 99 | Read the player's density setting (ambient characters scale with it) |
| `SET_PED_NON_CREATION_AREA` / `CLEAR_PED_NON_CREATION_AREA` | 86 / 96 | 165 / 139 | No new peds in a box (mission sets, strip club) |
| `USE_SCRIPT_CAM_FOR_AMBIENT_POPULATION_ORIGIN_THIS_FRAME` | 92 | 111 | Spawn around the script camera, not the player |
| `ADD_POP_MULTIPLIER_AREA` / `REMOVE_...` | 80 / 85 | 93 / 100 | A box with its own density |
| `SET_PED_MODEL_IS_SUPPRESSED` | 74 | 233 | Keep a model out of the population (a mission's actors) |
| `SET_PED_POPULATION_BUDGET`, `SET_VEHICLE_POPULATION_BUDGET` | 70, 76 | 291, 361 | Lower the budgets (0 to 3) during heavy scenes |
| `SET_REDUCE_PED_MODEL_BUDGET` | 47 | 101 | Fewer ped models in memory |
| `GET_NAME_OF_ZONE` | 93 | 164 | The zone's area label (shown as the area name) |
| `SET_AMBIENT_ZONE_STATE` and friends | 247 to 268 | | Ambient **sound** zones (R9.1), not population |

## What this means for modders

- **Thin or fill the streets from a script:** `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME(x)` and `SET_SCENARIO_PED_DENSITY_MULTIPLIER_THIS_FRAME(x, x)` every frame (with the vehicle versions from R4.3). Values above 1.0 don't raise the caps in `popcycle.dat` (**Known**).
- **Change the population for good** with a data edit: the `#Peds` and `#Scenario` columns and the group lists in `popcycle.dat`, and the group members in `popgroups.ymt`. "More peds" and "realistic population" mods edit exactly these. Every extra ped costs main-thread CPU (see [CPU](/docs/performance/cpu.md)); on a weak PC lower `CityDensity` instead.
- **Change an area's character:** `zonebind.ymt` sets the schedule, police response and scumminess per zone. A police mod that wants faster response in the city edits `lawResponseTime` there.
- **Keep your own peds safe from clean-up:** mark them as mission entities (`SET_ENTITY_AS_MISSION_ENTITY`) so the population code doesn't remove them, and release them when done.
- **Weekends don't exist** in the data: every day uses the same 12 slots.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The 5 story-mode schedule hashes that don't match a `popcycle.dat` name | Second pass |
| How the caps, `CityDensity` and the budgets combine into the real spawn count | Test card 1; R17.9 |
| What `scumminessLevel` changes in code and in scripts | Second pass: `GET_ZONE_SCUMMINESS` callers |
| The unnamed zone fields (`hash_7111AC8A`, three flags) | Second pass |
| How birds and fish groups spawn (they fill many slots) | R17.8 |

## Test cards

1. **Caps.** At noon in Vespucci Beach, count walking and scenario peds within 150 m for a minute with `CityDensity` 1.0, then 0.0. Expected: well under the schedule caps at 1.0, close to none at 0.0.
2. **Time of day.** Count peds in Rockford Hills at 03:00 and 15:00. Expected: fewer at night, and the `_Night` group's models.
3. **Non-creation area.** `SET_PED_NON_CREATION_AREA` around a street, wait a minute. Expected: no new walkers inside it; existing ones walk out.
