# Flying

How aircraft fly and how scripts handle flying: the flying handling block in `handling.meta` and its values for the base game's 22 aircraft, landing gear, VTOL nozzles, countermeasures and turbulence natives, parachuting and skydiving, the AI flight tasks, and the story-mode flight school. Roadmap topic **R3.4** in the [roadmap](/ROADMAP.md). Builds on [vehicle handling](/docs/physics/vehicle-handling.md) (R2.2: the handling file), [skills and abilities](/docs/gameplay/player/skills-and-abilities.md) (R3.6: the flying skill) and [driving and AI driving](/docs/ai/driving.md) (R3.3).

**How it was made.** Data from build 1.0.3725.0 extracted with [`tools/rpf-cw.ps1`](/tools/README.md): `update\update.rpf\common\data\handling.meta` (the `CFlyingHandlingData` blocks) and `update\update.rpf\x64\data\tune\movementtasks.ymt` (`CTaskParachute`). Native use from the [native usage](/scripting/native-usage.md) tables; the flight school read in `pilot_school` (decompile commit `6c18d3e8b`) with its text labels resolved from the American `.gxt2` files. Values and counts are **Verified**; what each handling value does to the flight model is **Known** (community handling documentation and the field names).

## 19.1 Short version

- **Aircraft get a second handling block,** `CFlyingHandlingData`, under the normal one: 30 values for thrust, yaw, roll and pitch response and stability, lift, landing-gear drag, wind, turbulence, damage effect and engine-off gliding. The update's `handling.meta` has 22 of them (13 planes, 8 helicopters, the blimp); DLC aircraft add their own in their packs.
- **Planes and helicopters use the same fields on different scales:** a plane's roll multiplier is 0.0015 to 0.015, a helicopter's 1.2 to 1.95. The Lazer has the most thrust (2, against 0.5 to 1 for other planes) and the lowest engine-off glide (0.1, others 1).
- **Scripts manage the extras, not the flight:** landing gear (`CONTROL_LANDING_GEAR` 407 scripts, `GET_LANDING_GEAR_STATE` 493), rotor speed (`SET_HELI_BLADES_FULL_SPEED` 335), turbulence (`SET_HELI_TURBULENCE_SCALAR` 258, `SET_PLANE_TURBULENCE_MULTIPLIER` 114), VTOL nozzles (`SET_VEHICLE_FLIGHT_NOZZLE_POSITION*`, 214 and 284 scripts) and countermeasure ammo (`SET_VEHICLE_COUNTERMEASURE_AMMO`, 284 scripts, 3,376 calls).
- **AI flight is mission tasks:** `TASK_HELI_MISSION` (287 scripts, 1,790 calls), `TASK_PLANE_TAXI` (247), `TASK_PLANE_MISSION` (114), rarely `TASK_PLANE_LAND` (3) or the chase tasks.
- **Parachutes are mostly about looks in script:** pack and canopy models and tints (`SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE` 442 scripts, `SET_PLAYER_PARACHUTE_VARIATION_OVERRIDE` 442), state checks (`GET_PED_PARACHUTE_STATE` 441, `IS_PED_IN_PARACHUTE_FREE_FALL` 620), and `SET_AUTO_GIVE_PARACHUTE_WHEN_ENTER_PLANE` (82).
- **The story flight school** (`pilot_school`, 2.6 MB of decompiled code) has 12 lessons with bronze, silver and gold targets and 22 fail reasons; Online has its own copy (`pilot_school_mp`).

## 19.2 The flying handling block

The 30 fields of `CFlyingHandlingData` (**Verified** names): `fThrust`, `fThrustFallOff`, `fThrustVectoring`, `fYawMult`, `fYawStabilise`, `fSideSlipMult`, `fRollMult`, `fRollStabilise`, `fPitchMult`, `fPitchStabilise`, `fFormLiftMult`, `fAttackLiftMult`, `fAttackDiveMult`, `fGearDownDragV`, `fGearDownLiftMult`, `fWindMult`, `fMoveRes`, the gear-door angles, the four turbulence values (spelt `fTurublence...` in the file), `fBodyDamageControlEffectMult`, `fInputSensitivityForDifficulty`, two on-ground yaw boost values and `fEngineOffGlideMulti`.

Selected values for the base aircraft (**Verified**; mass from the main block, kg):

| Aircraft | Mass | Thrust | Yaw | Roll | Pitch | Form lift | Wind | Turbulence max | Engine-off glide |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| `LAZER` | 8,000 | 2 | −0.001 | 0.009 | 0.002 | 0.00015 | 0.12 | 10 | 0.1 |
| `stunt` (Mallard) | 2,000 | 1 | −0.001 | 0.008 | 0.002 | 0.00025 | 0.15 | 10 | 1 |
| `luxor`, `shamal` | 6,400 | 0.81 | −0.0001 | 0.0035 | 0.0002 | 0.00025 | 0.15 | 10 | 1 |
| `mammatus` | 2,000 | 0.5 | −0.001 | 0.007 | 0.002 | 0.00048 | 0.15 | 10 | 1 |
| `duster` | 2,000 | 0.5 | −0.001 | 0.006 | 0.002 | 0.0005 | 0.15 | 10 | 1 |
| `CUBAN800` | 5,000 | 0.6 | −0.001 | 0.0045 | 0.0014 | 0.0001 | 0.2 | 10 | 1 |
| `velum` | 5,000 | 0.57 | −0.001 | 0.0045 | 0.002 | 0.0001 | 0.2 | 10 | 1 |
| `cargoplane`, `jet`, `titan` | 38,000 | 0.62 to 0.63 | about −0.0001 | 0.0015 to 0.002 | tiny | 0.00011 to 0.0005 | 0 | 10 | 1 |
| `BUZZARD`, `BUZZARD2` | 3,800 | 0.55 | −1.55 | 1.95 | 1.7 | 1 | 0.001 | 0 | 1 |
| `polmav`, `MAVERICK`, `FROGGER` | 6,500 to 7,000 | 0.52 to 0.56 | −1.3 to −1.45 | 1.68 to 1.85 | 1.58 to 1.67 | 1 | 0.0005 | 0 | 1 |
| `cargobob`, `ANNIHL`, `SKYLIFT` | 10,000 to 15,000 | 0.47 to 0.51 | −1.05 to −1.25 | 1.2 to 1.35 | 1.3 to 1.5 | 0.6 to 0.8 | 0.00025 | 0 to 0.5 | 1 |
| `BLIMP` | 12,000 | 0.58 | −0.2 | 0.1 | 0.2 | 1 | 0.0005 | 0 | 1 |

Two more entries, `SPMED` and `SPSMALL` (1,000 kg, roll 0.015), have the highest roll and wind values of all. *Known* reading: big jets turn slowly and ignore wind (0); small planes feel the wind most; helicopters have no turbulence in this block and get it from script (`SET_HELI_TURBULENCE_SCALAR`) and the pilot's flying skill ([R3.6](/docs/gameplay/player/skills-and-abilities.md)).

## 19.3 What scripts do with aircraft

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `IS_PED_IN_ANY_HELI`, `IS_PED_IN_ANY_PLANE`, `IS_PED_IN_FLYING_VEHICLE` | 456, 453, 299 | 5,331, 2,807, 588 | Checks |
| `GET_LANDING_GEAR_STATE`, `CONTROL_LANDING_GEAR` | 493, 407 | 1,795, 3,528 | Gear up for flying set pieces, down for landings |
| `SET_HELI_BLADES_FULL_SPEED`, `SET_HELI_BLADES_SPEED` | 335, 253 | 1,521, 407 | Spawn a helicopter already flying |
| `SET_VEHICLE_COUNTERMEASURE_AMMO` | 284 | 3,376 | Flares and chaff |
| `SET_VEHICLE_FLIGHT_NOZZLE_POSITION`, `_IMMEDIATE` | 214, 284 | 650, 736 | VTOL hover or forward flight |
| `SET_HELI_TURBULENCE_SCALAR` | 258 | 305 | Calmer or rougher helicopter flight |
| `SET_PLANE_TURBULENCE_MULTIPLIER` | 114 | 136 | Same for planes |
| `GET_FLYING_VEHICLE_MODEL_AGILITY` | 37 | 38 | Compare aircraft |
| Damage checks (`ARE_PLANE_PROPELLERS_INTACT`, `ARE_WINGS_OF_PLANE_INTACT`, `GET_HELI_MAIN_ROTOR_HEALTH` ...) | 2 to 9 each | | Rare |

**AI flight tasks:** `TASK_HELI_MISSION` (287 scripts, 1,790 calls), `TASK_PLANE_TAXI` (247, 500), `TASK_PLANE_MISSION` (114, 528), `TASK_PARACHUTE_TO_TARGET` (29), `TASK_PARACHUTE` (11), `TASK_PLANE_GOTO_PRECISE_VTOL` (4), `TASK_HELI_ESCORT_HELI` (4), `TASK_PLANE_CHASE` (4), `TASK_HELI_CHASE` (3), `TASK_PLANE_LAND` (3). Rockstar mostly takes planes off with a taxi task and gives everything else as a "mission" (fly to, follow, attack, circle, land) with a mission type number.

## 19.4 Parachuting and skydiving

- **Equipment and looks** (**Verified** counts): pack model, canopy variation and tints are set per job (`SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE`, `_VARIATION_OVERRIDE`, `SET_PLAYER_PARACHUTE_PACK_TINT_INDEX` 449 scripts), cleared again at cleanup (`CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE` 442). Reserve chutes: `SET_PLAYER_HAS_RESERVE_PARACHUTE` (23). Smoke trails: `SET_PLAYER_CAN_LEAVE_PARACHUTE_SMOKE_TRAIL` (18 scripts, 188 calls).
- **State:** `GET_PED_PARACHUTE_STATE` (441 scripts, 1,246 calls), `IS_PED_IN_PARACHUTE_FREE_FALL` (620), `GET_PED_PARACHUTE_LANDING_TYPE` (3), `FORCE_PED_TO_OPEN_PARACHUTE` (12).
- **Planes give parachutes:** `SET_AUTO_GIVE_PARACHUTE_WHEN_ENTER_PLANE` (82 scripts).
- **Tuning:** `CTaskParachute__Tunables` in `movementtasks.ymt` (**Verified** examples): landing at 0.5 to 5 m of height difference, 2 s to turn toward a target, and in a ragdoll after a bad landing a minimum falling speed of 10 m/s and at least 1 s.
- **Scripts:** story base jumps (`bj`, with `launcher_basejumpheli` and `launcher_basejumppack`), Online `fm_content_skydive` and `fm_content_parachuter`.

## 19.5 The flight school

`pilot_school` (*probably* started by `launcher_pilotschool`; the launch graph has no fixed edge) runs 12 lessons (`LESSON_01` to `LESSON_12` in the script, **Verified**). Each has a time and bronze, silver and gold targets (`PS_HUDTARG_B`, `_S`, `_G`). The score bars name the manoeuvres: formation, half loop, half roll, inverted, knifing, looping, roll; checkpoints include "Inverted Checkpoint", "Knife Checkpoint" and "Moving Target". Twenty-two fail reasons cover things like "Missed the goal time", "Formation broken", "Out of bounds", "The plane went too high", "Landed in the water", "Ditched too early" and "Wanted level earned". Its save block is a single dummy value (`PILOT_SCHOOL_DUMMY_DATA`, [saves](/docs/core/saves.md)); results live in the main story save. The flying skill it raises is in [R3.6](/docs/gameplay/player/skills-and-abilities.md).

## 19.6 What this means for modders

- **Tune aircraft in `CFlyingHandlingData`,** one aircraft at a time ([vehicle handling](/docs/physics/vehicle-handling.md) for where the file goes). Remember the scale: the same field means something very different for a plane and a helicopter.
- **For a calmer flight in a mod,** call `SET_PLANE_TURBULENCE_MULTIPLIER` / `SET_HELI_TURBULENCE_SCALAR` as Rockstar does, rather than editing every handling entry.
- **Spawning a helicopter in the air** needs `SET_HELI_BLADES_FULL_SPEED` and landing gear up (`CONTROL_LANDING_GEAR`), or it drops.
- **Undo parachute overrides at cleanup**, as Rockstar's 442 scripts do; they stay on the player otherwise.

## 19.7 Open questions

| Question | Where it goes |
| --- | --- |
| Flying blocks of all DLC aircraft | Second pass with every DLC `handling.meta` |
| What `SPMED` and `SPSMALL` are | Second pass, `vehicles.meta` |
| The 12 lessons by name, their aircraft and targets | Second pass, `pilot_school` |
| The mission type numbers used with `TASK_HELI_MISSION` and `TASK_PLANE_MISSION`, with counts | Second pass |

## 19.8 Test cards (story mode, a script mod)

1. **Helicopter spawn.** Spawn a Maverick 100 m up without and with `SET_HELI_BLADES_FULL_SPEED`. Expected: without it, it falls before the rotor spins up.
2. **Turbulence.** Fly a Mallard through rain with `SET_PLANE_TURBULENCE_MULTIPLIER` 0 and then 1. Expected: no buffeting at 0.
