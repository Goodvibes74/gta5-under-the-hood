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

Two more entries, `SPMED` and `SPSMALL` (1,000 kg, roll 0.015), have the highest roll and wind values of all. *Leftovers pass* (**Verified**, every `vehicles.meta` of the base game, the update, the 37 DLC packs that have one and the 38 `dlc_patch` copies): **no vehicle uses them**. Their `handlingId` appears in no `vehicles.meta`, and both are complete flying entries with a weapon block (`CVehicleWeaponHandlingData`) next to the flying block, so they are left-over entries nothing loads a model for. What the names stood for isn't in the files. *Known* reading: big jets turn slowly and ignore wind (0); small planes feel the wind most; helicopters have no turbulence in this block and get it from script (`SET_HELI_TURBULENCE_SCALAR`) and the pilot's flying skill ([R3.6](/docs/gameplay/player/skills-and-abilities.md)).

### 19.2.1 The DLC aircraft (leftovers pass)

**Verified**, from all 47 `handling.meta` files (base, update, DLC packs and `dlc_patch`; a later copy of a handling name replaces an earlier one): **63 handling entries have a flying block**, 22 from the base game and update and 41 from 12 DLC packs. `mpsmuggler` (Smuggler's Run) adds the most (14), then `mpchristmas2017` and `mp2023_01` (4 each), `mpheist4`, `mp2024_02` and `mpheist` (3 each), `mpbattle`, `mpluxe`, `mpexecutive` and `mpapartment` (2 each), and `mpsum2` and `mpassault` (1 each). 60 of them are used by 72 vehicles (39 planes, 31 helicopters, 2 blimps); only `BLIMP3`, `SPMED` and `SPSMALL` have no vehicle.

The DLC blocks stay inside the base game's ranges with a little more at the edges. Thrust runs from 0.47 to 2.0 in the base game and from 0.468 to 2.1 in DLC. The yaw multiplier reaches −3.0 in DLC against −1.55, pitch reaches 1.93 against 1.7, and roll 2.1 against 1.95. The strongest thrust belongs to the Smuggler's Run planes `ALPHAZ1` and `HOWARD` (2.1) and `SEABREEZE` (2.05), just above the base game's `LAZER` (2.0), then `RAIJU` (1.7, `mp2023_01`) and `STRIKEFORCE` (1.6, `mpbattle`). The table above (19.2) stays the reference for the field meanings.

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

**The mission types in use** (**Verified** counts, second pass). The type is the eighth argument. Most calls pass a variable, so where it was a parameter of the calling function, every call of that function in the same script was followed (up to three levels) to the number. The counts are resolved uses, so a shared wrapper called from many places counts once per call. Names are the vehicle mission enum as NativeDB and the community document it (**Known**).

| Type | Name | `TASK_HELI_MISSION` uses (scripts) | `TASK_PLANE_MISSION` uses (scripts) |
| ---: | --- | ---: | ---: |
| 4 | Go to | 948 (278) | 125 (104) |
| 5 | Stop | 247 (247) | |
| 8 | Flee | 118 (110) | 11 (5) |
| 19 | Land | 114 (109) | |
| 21 | Crash | 2 (2) | 102 (100) |
| 6 | Attack | 40 (21) | 9 (5) |
| 9 | Circle | 10 (9) | 2 (2) |
| 7 | Follow | 7 (7) | |
| 23 | Protect | 6 (4) | |
| 12, 13 | Escort rear, escort front | 4, 4 | |
| 16 | Police behaviour | 4 (1) | |
| 20 | Land and wait | 2 (2) | |
| 1 | Cruise | 1 | |
| unresolved | (a variable, a struct field or a value from a table) | 283 (96) | 279 (93) |

So helicopters are mostly sent somewhere (go to), held (stop: one shared helper compiled into 247 scripts, mostly Online ones), sent away (flee) or landed; planes are sent somewhere or told to crash (all 100 scripts that pass type 21 are Online ones).

## 19.4 Parachuting and skydiving

- **Equipment and looks** (**Verified** counts): pack model, canopy variation and tints are set per job (`SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE`, `_VARIATION_OVERRIDE`, `SET_PLAYER_PARACHUTE_PACK_TINT_INDEX` 449 scripts), cleared again at cleanup (`CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE` 442). Reserve chutes: `SET_PLAYER_HAS_RESERVE_PARACHUTE` (23). Smoke trails: `SET_PLAYER_CAN_LEAVE_PARACHUTE_SMOKE_TRAIL` (18 scripts, 188 calls).
- **State:** `GET_PED_PARACHUTE_STATE` (441 scripts, 1,246 calls), `IS_PED_IN_PARACHUTE_FREE_FALL` (620), `GET_PED_PARACHUTE_LANDING_TYPE` (3), `FORCE_PED_TO_OPEN_PARACHUTE` (12).
- **Planes give parachutes:** `SET_AUTO_GIVE_PARACHUTE_WHEN_ENTER_PLANE` (82 scripts).
- **Tuning:** `CTaskParachute__Tunables` in `movementtasks.ymt` (**Verified** examples): landing at 0.5 to 5 m of height difference, 2 s to turn toward a target, and in a ragdoll after a bad landing a minimum falling speed of 10 m/s and at least 1 s.
- **Scripts:** story base jumps (`bj`, with `launcher_basejumpheli` and `launcher_basejumppack`), Online `fm_content_skydive` and `fm_content_parachuter`.

## 19.5 The flight school

`pilot_school` (its launcher, `launcher_pilotschool`, is a world-point brain with a 100 m range, see [strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md)) runs 12 lessons (`LESSON_01` to `LESSON_12` in the script, **Verified**). The script has one set-up function per lesson that picks the aircraft (**Verified**, second pass): six use the Mallard (`stunt`), two the Cuban 800, two the Maverick and two the Frogger. The set-ups are reached through a function table, so which lesson gets which set-up isn't readable from the decompile; the lesson names are text labels.

*Leftovers pass* (**Verified**, the `PSCHOOL` text block, the American text blocks of every archive (base `x64b.rpf`, `update.rpf`, `update2.rpf` and the DLC packs, 645,160 entries) dumped with the CodeWalker library and searched by the `joaat` hash of each label). The lesson table's labels `MGFS_0` to `MGFS_11` name the 12 lessons in the order of the medal table in [minigames 42.5.1](/docs/gameplay/missions/minigames-and-activities.md#4251-medals-and-goals-second-pass): 0 Training Take Off, 1 Runway Landing, 2 Inverted Flight, 3 Knife Flight, 4 Flat Hatting, 5 Touch Down, 6 Loop the Loop, 7 Helicopter Course, 8 Helicopter Speed Run, 9 Skydiving, 10 Drop Zone, 11 Earn Your Wings. The aircraft follow from the set-ups. The two Maverick set-ups are the parachute lessons: both load a parachute, and one also loads a target truck, which makes it Drop Zone (the lesson whose gold needs a landing on the target vehicle), so the other is Skydiving. The two Frogger set-ups are therefore the two helicopter lessons. The other eight lessons share the six Mallard and two Cuban 800 set-ups. Which two of those use the Cuban 800 is still open. The medal goals per lesson are in [minigames](/docs/gameplay/missions/minigames-and-activities.md), and the flying skill points per medal in [skills](/docs/gameplay/player/skills-and-abilities.md#how-skills-grow-second-pass). Each has a time and bronze, silver and gold targets (`PS_HUDTARG_B`, `_S`, `_G`). The score bars name the manoeuvres: formation, half loop, half roll, inverted, knifing, looping, roll; checkpoints include "Inverted Checkpoint", "Knife Checkpoint" and "Moving Target". Twenty-two fail reasons cover things like "Missed the goal time", "Formation broken", "Out of bounds", "The plane went too high", "Landed in the water", "Ditched too early" and "Wanted level earned". Its save block is a single dummy value (`PILOT_SCHOOL_DUMMY_DATA`, [saves](/docs/core/saves.md)); results live in the main story save. The flying skill it raises is in [R3.6](/docs/gameplay/player/skills-and-abilities.md).

## 19.6 What this means for modders

- **Tune aircraft in `CFlyingHandlingData`,** one aircraft at a time ([vehicle handling](/docs/physics/vehicle-handling.md) for where the file goes). Remember the scale: the same field means something very different for a plane and a helicopter.
- **For a calmer flight in a mod,** call `SET_PLANE_TURBULENCE_MULTIPLIER` / `SET_HELI_TURBULENCE_SCALAR` as Rockstar does, rather than editing every handling entry.
- **Spawning a helicopter in the air** needs `SET_HELI_BLADES_FULL_SPEED` and landing gear up (`CONTROL_LANDING_GEAR`), or it drops.
- **Undo parachute overrides at cleanup**, as Rockstar's 442 scripts do; they stay on the player otherwise.

## 19.7 Open questions

| Question | Where it goes |
| --- | --- |
| Flying blocks of all DLC aircraft | Answered in [19.2.1](#1921-the-dlc-aircraft-leftovers-pass) |
| What `SPMED` and `SPSMALL` are | Answered in [19.2](#192-the-flying-handling-block): entries no vehicle uses |
| The 12 lessons by name, and which lesson uses which aircraft (the six Mallard, two Cuban 800, two Maverick and two Frogger set-ups) | Second pass, `pilot_school` with the `PSCHOOL` text block |

Answered in the second pass: the mission type numbers with counts (GP-048, [AI flight tasks](#193-what-scripts-do-with-aircraft)).

## 19.8 Test cards (story mode, a script mod)

1. **Helicopter spawn.** Spawn a Maverick 100 m up without and with `SET_HELI_BLADES_FULL_SPEED`. Expected: without it, it falls before the rotor spins up.
2. **Turbulence.** Fly a Mallard through rain with `SET_PLANE_TURBULENCE_MULTIPLIER` 0 and then 1. Expected: no buffeting at 0.
