# Driving and AI driving

How AI drivers decide how fast to go and how to behave: the four AI handling profiles and their corner-speed curves, which vehicles use which, the driving-task natives Rockstar's scripts use and how often, the driving-style flags they pass, driver ability and aggressiveness, waypoint recordings, and what this means for a mod that makes peds drive. Roadmap topic **R3.3** in the [roadmap](/ROADMAP.md). Builds on [vehicle handling](/docs/physics/vehicle-handling.md) (R2.2: the physics of the car itself) and [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (R4.3: ambient traffic and road nodes).

**How it was made.** Data from build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md): `common\data\ai\vehicleaihandlinginfo.meta` (the AI profiles), `update\update.rpf\common\data\handling.meta` (which vehicle uses which profile) and `update\update.rpf\x64\data\tune\vehicletasks.ymt`. Script use from the [native usage](/scripting/native-usage.md) tables, and the driving-style argument of all 1,283 `TASK_VEHICLE_DRIVE_TO_COORD`, `TASK_VEHICLE_DRIVE_WANDER` and `TASK_VEHICLE_MISSION_PED_TARGET` calls pulled with `git grep` from the decompile (commit `6c18d3e8b`). Values and counts are **Verified**. The meaning of each driving-style bit is NativeDB's flag list (**Known**), as is how the engine uses each tunable.

## 18.1 Short version

- **Four AI handling profiles** set how AI drives a vehicle: `SPORTS_CAR`, `AVERAGE`, `CRAP` and `TRUCK`. Each has brake distances and a curve of top speed against corner angle: a sports car takes a straight at 60 m/s and a 90° turn at 10 m/s; the others top out at 45 m/s.
- **`handling.meta` picks the profile** per vehicle (`AIHandling`): in the update's file 193 `AVERAGE`, 35 `TRUCK`, 19 `SPORTS_CAR`, 7 `CRAP`.
- **Rockstar's commonest driving tasks:** `TASK_LEAVE_ANY_VEHICLE` (504 scripts), `TASK_ENTER_VEHICLE` (461), `TASK_VEHICLE_DRIVE_TO_COORD` (339), `TASK_VEHICLE_FOLLOW_WAYPOINT_RECORDING` (311), `TASK_VEHICLE_TEMP_ACTION` (293), `TASK_HELI_MISSION` (287).
- **Recorded routes are everywhere:** waypoint recordings are followed in 311 scripts and their speed overridden in 271 (`VEHICLE_WAYPOINT_PLAYBACK_OVERRIDE_SPEED`, 1,568 calls). Chases and set pieces are driven on recorded lines, not by free AI.
- **The usual driving styles:** 786,603 (careful: stops for cars, peds and lights, steers round empty cars and objects), 786,599, 786,469, 786,468 (rushed: no stopping) and 786,597; the single most passed value to `TASK_VEHICLE_DRIVE_TO_COORD` is 262,144 (312 of its calls).
- **Driver personality from script:** `SET_DRIVER_ABILITY` (105 scripts), `SET_DRIVER_AGGRESSIVENESS` (118) and `SET_DRIVER_RACING_MODIFIER` (113), usually set before a race or a chase.

## 18.2 The AI handling profiles

From `vehicleaihandlinginfo.meta` (**Verified**). Speeds are in m/s, angles in degrees of the turn ahead:

| Profile | Min / max brake distance | Speed at max brake distance | Corner curve (angle: top speed) |
| --- | --- | ---: | --- |
| `SPORTS_CAR` | 10 / 80 m | 50 | 0°: 60, 2°: 50, 6°: 35, 12°: 25, 22°: 20, 28°: 18, 40°: 16, 90°: 10, 180°: 4 |
| `AVERAGE` | 10 / 80 m | 30 | 0°: 45, 6°: 35, 12°: 25, 22°: 20, 28°: 15, 40°: 12.5, 90°: 10, 180°: 4 |
| `CRAP` | 10 / 100 m | 30 | 0°: 45, 3°: 20, 28°: 15, 40°: 11, 90°: 10, 180°: 4 |
| `TRUCK` | 10 / 100 m | 30 | same curve as `CRAP` |

All four have an absolute minimum speed of 1 m/s. *Known*: the AI looks at the bend ahead, reads the curve for its angle, and won't go faster than that speed or the task's cruise speed, whichever is lower; the brake distances decide how early it slows down.

**Who uses which** (`AIHandling` in the update's `handling.meta`, **Verified**): 193 `AVERAGE`, 35 `TRUCK`, 19 `SPORTS_CAR`, 7 `CRAP`. DLC vehicles set it in their own `handling.meta` (the `mpapartment` patch: 13 `AVERAGE`, 5 `SPORTS_CAR`). So most supercars drive like an average car under AI unless their handling entry says `SPORTS_CAR`.

## 18.3 Driving tasks in Rockstar's scripts

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `TASK_LEAVE_ANY_VEHICLE` | 504 | 16,239 | Get out |
| `TASK_ENTER_VEHICLE` | 461 | 2,060 | Get in (seat, speed, flags) |
| `TASK_VEHICLE_DRIVE_TO_COORD` | 339 | 653 | Drive to a point |
| `TASK_VEHICLE_FOLLOW_WAYPOINT_RECORDING` | 311 | 988 | Follow a recorded route |
| `TASK_VEHICLE_TEMP_ACTION` | 293 | 484 | Short actions: brake, swerve, reverse |
| `TASK_HELI_MISSION` | 287 | 1,790 | Helicopters (R3.4) |
| `TASK_PLANE_TAXI`, `TASK_PLANE_MISSION` | 247, 114 | 500, 528 | Planes (R3.4) |
| `TASK_VEHICLE_MISSION_PED_TARGET`, `_COORS_TARGET`, `TASK_VEHICLE_MISSION` | 179, 164, 157 | 412, 366, 332 | Chase, flee, ram, follow, block |
| `TASK_VEHICLE_PARK` | 119 | 124 | Park in a spot |
| `TASK_VEHICLE_DRIVE_WANDER` | 107 | 218 | Drive around |
| `TASK_BOAT_MISSION` | 102 | 578 | Boats |
| `TASK_DRIVE_BY` | 43 | 166 | Shoot from a vehicle |
| `TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE` | 22 | 61 | Long trips (route found in pieces) |
| `TASK_VEHICLE_ESCORT` | 15 | 34 | Escort a vehicle |

Waypoint recordings: `IS_WAYPOINT_PLAYBACK_GOING_ON_FOR_VEHICLE` (276 scripts), `VEHICLE_WAYPOINT_PLAYBACK_OVERRIDE_SPEED` (271), `VEHICLE_WAYPOINT_PLAYBACK_PAUSE` (253). Cruise speed after the start: `SET_DRIVE_TASK_CRUISE_SPEED` (52 scripts), `SET_DRIVE_TASK_MAX_CRUISE_SPEED` (13); changing the style of a running task, `SET_DRIVE_TASK_DRIVING_STYLE`, is rare (4 scripts).

## 18.4 Driving styles

The driving style is a set of flags (bit meanings **Known** from NativeDB: 1 stop for vehicles, 2 stop for peds, 4 swerve around vehicles, 8 steer around empty vehicles, 16 steer around peds, 32 steer around objects, 128 stop at lights, 512 drive into oncoming traffic, 1,024 reverse, 262,144 use shortcut links, 524,288 change lanes around obstructions ...). Values found in the 1,283 calls read (**Verified** counts):

| Value | Bits | Reads as | `DRIVE_WANDER` | `DRIVE_TO_COORD` |
| ---: | --- | --- | ---: | ---: |
| 786,603 | 1, 2, 8, 32, 128, 262,144, 524,288 | Careful, law-abiding | 37 | 21 |
| 786,599 | 1, 2, 4, 32, 128, 262,144, 524,288 | Careful, swerves instead of steering | 46 | 17 |
| 786,469 | 1, 4, 32, 262,144, 524,288 | Stops for cars only, ignores lights | 36 | 68 |
| 786,468 | 4, 32, 262,144, 524,288 | Rushed: never stops | 27 | 26 |
| 786,597 | 1, 4, 32, 128, 262,144, 524,288 | Stops for cars and lights, not peds | 23 | |
| 262,144 | 262,144 | Shortcuts only, nothing avoided | 5 | 312 |

The high count of 262,144 in `DRIVE_TO_COORD` comes from set pieces where the route and traffic are controlled by the mission, so the driver doesn't need to stop or steer.

## 18.5 Other tunables

`vehicletasks.ymt` (**Verified**) tunes getting in and out (`CTaskEnterVehicle`, `CTaskExitVehicle`, seat shuffles, door opening), bikes leaning, trains, reactions to collisions (`CTaskCarReactToVehicleCollision`) and the player's driving task. For example, `CTaskPlayerDrive` lets the player jump out of a car from 10 m/s and off a bike from 12 m/s (`MinPlayerJumpOutSpeedCar`, `_Bike`), and adds a "dangerous vehicle" event at most every 3 s.

## 18.6 What this means for modders

- **To make AI drive a car faster in corners,** give its handling entry `<AIHandling>SPORTS_CAR</AIHandling>` ([vehicle handling](/docs/physics/vehicle-handling.md)), or edit the curves in `vehicleaihandlinginfo.meta` for every car using a profile.
- **Pick a style from 18.4** instead of building flags from scratch: 786,603 for traffic-like driving, 786,468 for a getaway. Add 512 to let the driver use the oncoming lane.
- **For a chase that must look right, record a route** and play it with `TASK_VEHICLE_FOLLOW_WAYPOINT_RECORDING`, as Rockstar does in 311 scripts; free AI is for traffic and fleeing.
- **Long trips need the long-range task** (`TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE`) or the route fails where road nodes aren't streamed in.

## 18.7 Open questions

| Question | Where it goes |
| --- | --- |
| AI profiles of every DLC vehicle (all `handling.meta` files) | Second pass, with the DLC scan |
| How `SET_DRIVER_ABILITY` and `_AGGRESSIVENESS` change the curve or braking | In-game test |
| What `TASK_VEHICLE_TEMP_ACTION`'s action numbers mean, with Rockstar's counts | Second pass |
| Road nodes and how routes are planned | R17.5 (navigation) |

## 18.8 Test cards (story mode, a script mod)

1. **Profiles.** Put an AI driver in a car with `AVERAGE`, then the same car with `SPORTS_CAR` in its handling entry, on the same twisty road with `TASK_VEHICLE_DRIVE_TO_COORD` and cruise speed 60. Expected: the sports profile corners faster.
2. **Styles.** Have a driver wander with 786,603, then 786,468, through a junction with red lights. Expected: the first stops, the second doesn't.
