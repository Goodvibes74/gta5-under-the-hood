# Driving AI: missions, chases, aircraft and boats

What AI drivers, pilots and boat crews are told to do: the vehicle "mission" types behind the driving tasks and how often Rockstar uses each, chases and escorts, the short "temp actions", helicopter, plane and boat specifics, and how races and pursuits are built. Roadmap topic **R17.6** in the [roadmap](/ROADMAP.md). Extends [driving and AI driving](/docs/ai/driving.md) (R3.3: AI handling profiles, driving styles, the driving tasks), and builds on [navigation](/docs/ai/navigation.md) (R17.5: road nodes) and [flying](/docs/gameplay/player/flying.md) (R3.4).

**How it was made.** Every call to `TASK_VEHICLE_MISSION`, `_MISSION_PED_TARGET`, `_MISSION_COORS_TARGET`, `TASK_HELI_MISSION`, `TASK_PLANE_MISSION`, `TASK_BOAT_MISSION` and `TASK_VEHICLE_TEMP_ACTION` (4,535 in all) was pulled from the build 1.0.3725.0 decompile (commit `6c18d3e8b`) with `git grep`, its arguments split with `awk` (respecting brackets), and the literal mission or action number counted. Native counts from [native usage](/scripting/native-usage.md). Counts are **Verified**; the names of the mission numbers are NativeDB's vehicle mission list (**Known**), as is what each mission does.

## 39.1 Short version

- **One mission list drives cars, helicopters, planes and boats.** The commonest missions are **go to** (4), **flee** (8), **cruise** (1), **stop** (5), **attack** (6), **follow** (7), **circle** (9), **land** (19) and **crash** (21); escorts (10 to 13), ramming (2), blocking (3), racing (14), police behaviour (16), parking (17), pull over (22) and protect (23) are rarer.
- **Helicopters get the most varied orders:** of 1,507 literal `TASK_HELI_MISSION` missions, 948 are go to, 247 stop, 118 flee, 114 land, 40 attack and a few circle, follow, protect and escort.
- **Planes mostly fly to a point (125) or crash (102)**; boats go to (196) or flee (95).
- **Car chases are built from missions, not the chase task:** `TASK_VEHICLE_MISSION_PED_TARGET` with flee (220) or go to (61); the dedicated `TASK_VEHICLE_CHASE` appears in only 7 scripts and `TASK_VEHICLE_ESCORT` in 15.
- **`TASK_VEHICLE_TEMP_ACTION`** (293 scripts) gives short manoeuvres (brake, swerve, reverse, burnout ...); action 24 is the commonest literal (36), then 1, 5, 4, 30, 6.
- **Racing and pursuit "personality"** comes from `SET_DRIVER_RACING_MODIFIER` (113 scripts), `SET_DRIVER_AGGRESSIVENESS` (118) and `SET_DRIVER_ABILITY` (105), plus driving styles and recorded routes ([R3.3](/docs/ai/driving.md)).

## 39.2 The mission types

Literal mission numbers per task (**Verified** counts; names **Known**). "var" = passed in a variable.

| No. | Mission | Car (ped target) | Car (coord target) | Car (vehicle target) | Helicopter | Plane | Boat |
| ---: | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 1 | Cruise | 10 | 5 | 163 | 1 | | |
| 2 | Ram | 2 | | 3 | | | |
| 3 | Block | | | 1 | | | |
| 4 | Go to | 61 | 208 | 1 | 948 | 125 | 196 |
| 5 | Stop | | 12 | 7 | 247 | | |
| 6 | Attack | 16 | 12 | 2 | 40 | 9 | 4 |
| 7 | Follow | 4 | | 12 | 7 | | 3 |
| 8 | Flee | 220 | 22 | 14 | 118 | 11 | 95 |
| 9 | Circle | | 6 | | 10 | 2 | |
| 10, 11, 12, 13 | Escort left, right, rear, front | 0, 0, 1, 0 | | 5, 8, 12, 0 | 0, 0, 4, 4 | | |
| 14 | Go to (racing) | | 6 | | | | |
| 15 | Follow recording | | | 1 | | | |
| 16 | Police behaviour | | | | 4 | | |
| 17 | Park | | | | | | 1 |
| 19 | Land | | 2 | | 114 | | |
| 20 | Land and wait | | | | 2 | | |
| 21 | Crash | | | | 2 | 102 | |
| 22 | Pull over | | | 4 | | | |
| 23 | Protect | | | | 6 | | |
| | var | 98 | 93 | 99 | 283 | 279 | 279 |

## 39.3 Helicopters, planes and boats

- **Helicopters:** a mission plus flight height, minimum height and slow-down distance; spawned flying with `SET_HELI_BLADES_FULL_SPEED` (335 scripts) ([R3.4](/docs/gameplay/player/flying.md)). Chases use go to on a moving target or `TASK_HELI_CHASE` (3 scripts).
- **Planes:** taxi first (`TASK_PLANE_TAXI`, 247 scripts), then `TASK_PLANE_MISSION`; the many "crash" missions are scripted plane crashes in set pieces. Landing uses `SET_SHORT_SLOWDOWN_FOR_LANDING` (100) and `SET_USE_DESIRED_Z_CRUISE_SPEED_FOR_LANDING` (99); `TASK_PLANE_LAND` is rare (3).
- **Boats:** `TASK_BOAT_MISSION` (102 scripts) for go to and flee; anchoring (`SET_BOAT_ANCHOR`, 138 scripts; `CAN_ANCHOR_BOAT_HERE`, 18) keeps boats in place for scenes.

## 39.4 Temp actions

`TASK_VEHICLE_TEMP_ACTION(ped, vehicle, action, time)` makes a driver do one manoeuvre for a time (**Verified** literal counts): 24 (36), 1 (21), 5 (15), 4 (13), 30 (11), 6 (10), 9 (8), 11 and 31 (6 each), 20 and 32 (4 each), 10 (3), 8, 13, 14 (1 each); 344 calls pass a variable. *Known* meanings from NativeDB's list include braking, braking and reversing, turning while braking, swerving, burnout and accelerating; which number is which is a second-pass check.

## 39.5 How Rockstar builds a chase or race

1. **Flee or follow by mission:** the chased car gets `TASK_VEHICLE_MISSION_PED_TARGET` with flee (8) and a driving style without stopping; chasers get go to (4) or follow (7) on the player.
2. **Set the driver:** ability, aggressiveness and racing modifier; a fast car gets the `SPORTS_CAR` AI profile ([R3.3](/docs/ai/driving.md)).
3. **Script the beats:** `TASK_VEHICLE_TEMP_ACTION` for a swerve or skid at the right moment, `SET_DRIVE_TASK_CRUISE_SPEED` to keep the gap.
4. **For set pieces, record it:** `TASK_VEHICLE_FOLLOW_WAYPOINT_RECORDING` (311 scripts) with `VEHICLE_WAYPOINT_PLAYBACK_OVERRIDE_SPEED` (271) matched to the player.
5. **Let the traffic make way:** `SET_VEHICLE_CAN_BE_USED_BY_FLEEING_PEDS` (217) and roads switched off in the area ([navigation](/docs/ai/navigation.md)).

## 39.6 What this means for modders

- **A getaway or pursuit mod** needs no special chase task: flee (8) or go to (4) on a ped target, plus a no-stopping driving style.
- **Helicopter support** (a news or police heli circling the player): `TASK_HELI_MISSION` with circle (9) or follow (7) and a height above the target.
- **Planes that land** need a taxi and a go-to toward the runway; the many crash missions show how Rockstar fakes plane disasters.
- **Escorts:** missions 10 to 13 put the escort on a side of the target vehicle; `TASK_VEHICLE_ESCORT` is the dedicated version.

## 39.7 Open questions

| Question | Where it goes |
| --- | --- |
| The name of each temp action number, checked in game | In-game test, one action at a time |
| How the flee mission picks a route | R17.5 second pass |
| Mission numbers passed in variables (about a quarter of the calls) | Second pass, follow the variables |

## 39.8 Test cards (story mode, a script mod)

1. **Flee.** Give a driver `TASK_VEHICLE_MISSION_PED_TARGET` with mission 8 on the player and chase it. Expected: it drives away and keeps fleeing.
2. **Helicopter circle.** Spawn a helicopter in the air, give `TASK_HELI_MISSION` with mission 9 on the player at 40 m. Expected: it circles overhead.
3. **Temp action.** Try `TASK_VEHICLE_TEMP_ACTION` with 24, then 30, for 2 seconds while the car moves. Write down what each does.
