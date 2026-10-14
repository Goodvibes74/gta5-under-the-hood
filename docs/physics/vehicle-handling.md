# Vehicle physics: handling, damage and upgrades

How GTA V decides how a vehicle drives, breaks and responds to upgrades: the `handling.meta` data file and its sub-handling blocks, the flag words, the damage multipliers, what mod-shop upgrades change, the natives scripts use to bend the rules. Roadmap topic **R2.2** in the [roadmap](/ROADMAP.md).

**How it was made.** The vanilla `handling.meta` (`update\update.rpf\common\data\`), the eight `dlc_patch` handling files in the same archive, the handling files of the 89 DLC packs, `vehicleaihandlinginfo.meta` and one `carcols.meta` were read with `tools/rpf-cw.ps1` (read-only). Native use was counted in the build-3725 decompile. The file has no documentation of its own, so what each field *does* is community knowledge (**Known**) unless this guide says it was checked; the *values and counts* are **Verified**.

## 4.1 Short version

- **One entry per handling name.** Every vehicle model names a handling entry (`handlingId` in `vehicles.meta`); the entry is a `CHandlingData` with about 50 fields: mass, drag, centre of mass, drive bias, gears, drive force and top speed, brakes, steering, traction curve, suspension, anti-roll, damage multipliers, fuel and oil, value, three flag words and an AI driving style.
- **Sub-handling blocks** add what only some vehicles need: `CCarHandlingData` (cars), `CBikeHandlingData` (lean and wheelies), `CFlyingHandlingData` (planes and helicopters), `CBoatHandlingData`, `CSubmarineHandlingData`, `CTrailerHandlingData`, `CVehicleWeaponHandlingData` (turrets) and `CAdvancedData` (per-mod tuning tweaks). Each entry has three sub-handling slots, mostly `NULL`.
- **DLC packs add their own `handling.meta`.** The base game file holds 254 entries; 38 DLC packs add 544 more, and `dlc_patch` folders inside `update.rpf` patch older entries.
- **Upgrades are data too.** The mod kits in `carcols.meta` give each engine, brakes, gearbox, suspension and armour level a *modifier* value that the engine applies on top of the handling entry.
- **Scripts rarely touch handling.** No native edits a handling field directly. Scripts use about 30 vehicle natives that scale speed, grip, damage and strength on one vehicle (`MODIFY_VEHICLE_TOP_SPEED`, `SET_VEHICLE_DAMAGE_SCALE`, `SET_DRIFT_TYRES` ...). Mods that change handling per vehicle at run time write to the handling memory directly.

## 4.2 Where handling comes from

| File | What it holds | Entries |
| --- | --- | --- |
| `common.rpf\data\handling.meta` | The launch-day file, replaced by the next one | |
| `update\update.rpf\common\data\handling.meta` | The current base file | 254 `CHandlingData` (**Verified**) |
| `update\update.rpf\dlc_patch\<pack>\common\data\handling.meta` | Rockstar's later fixes to entries from seven Online packs (`mpapartment`, `mpbiker`, `mpchristmas2018`, `mpjanuary2016`, `mpluxe`, `mpspecialraces`, `mpstunt`) | 99 between them |
| `update\x64\dlcpacks\<pack>\dlc.rpf\...\handling.meta` | Each DLC pack's own vehicles | see 4.8 |
| `common.rpf\data\ai\vehicleaihandlinginfo.meta` | Four AI driving styles: `AVERAGE`, `CRAP`, `SPORTS_CAR`, `TRUCK`, each with braking distances and cornering speeds by curve angle | 4 |

A vehicle's `vehicles.meta` entry picks its handling by name, so several models can share one entry. The `AIHandling` field picks which of the four AI styles NPC drivers use with it: 193 base entries are `AVERAGE`, 35 `TRUCK`, 19 `SPORTS_CAR`, 7 `CRAP` (**Verified**). How NPCs drive is R17.6.

## 4.3 The main block (`CHandlingData`)

Field groups, with the range found across the 254 base entries (**Verified** values; meanings **Known**):

| Group | Fields | Range in the base file |
| --- | --- | --- |
| Body | `fMass` (kg), `fInitialDragCoeff`, `fPercentSubmerged` (how deep it floats before sinking), `vecCentreOfMassOffset`, `vecInertiaMultiplier`, `fDownforceModifier` (7 entries) | Mass 100 to 60,000 kg, median 2,100 |
| Drive train | `fDriveBiasFront` (0 rear-wheel drive, 1 front-wheel drive, between: all-wheel), `nInitialDriveGears`, `fInitialDriveForce`, `fDriveInertia`, `fClutchChangeRateScaleUpShift` / `DownShift`, `fInitialDriveMaxFlatVel` (top speed on the flat, in km/h before the engine's own scaling) | 187 rear, 17 front, 50 all-wheel drive; gears 1 (66, mostly aircraft and boats), 4 (43), 5 (115), 6 (27); top speed value 15 to 328.6, median 134 |
| Brakes | `fBrakeForce`, `fBrakeBiasFront`, `fHandBrakeForce` | Brake force 0.001 to 5.0, median 0.6 |
| Steering | `fSteeringLock` (degrees) | 22 to 55, median 38 |
| Traction | `fTractionCurveMax` / `Min` (grip at peak and when sliding), `fTractionCurveLateral` (slip angle of the peak), `fTractionSpringDeltaMax`, `fLowSpeedTractionLossMult` (burnouts), `fCamberStiffnesss` (sic), `fTractionBiasFront`, `fTractionLossMult` (grip lost on loose surfaces) | Peak grip up to 3.3, median 1.95 |
| Suspension | `fSuspensionForce`, `CompDamp`, `ReboundDamp`, `UpperLimit`, `LowerLimit`, `Raise`, `BiasFront`, `fAntiRollBarForce`, `fAntiRollBarBiasFront`, `fRollCentreHeightFront` / `Rear` | |
| Damage | `fCollisionDamageMult`, `fWeaponDamageMult`, `fDeformationDamageMult`, `fEngineDamageMult`, `fPetrolTankVolume`, `fOilVolume`, `fWeaponDamageScaledToVehHealthMult` (1 entry) | 4.6 |
| Seat and misc | `fSeatOffsetDistX/Y/Z`, `nMonetaryValue` (insurance and AI "value" of the car), `fPopUpLightRotation` (4 entries) | |
| Flags | `strModelFlags`, `strHandlingFlags`, `strDamageFlags` (hex) | 4.5 |
| AI | `AIHandling` | 4.2 |

**How the grip from the surface combines with this** (tyre grip, wet grip, drag and top speed per material) is in [guide 5](/docs/physics/collision-and-materials.md#53-materials).

## 4.4 Sub-handling blocks

Counts are for the base file (**Verified**):

| Block | Count | What it adds |
| --- | --- | --- |
| `CCarHandlingData` | 113 | Back-end pop-up on crashes (`fBackEndPopUp*`, 152 across the patches), and in newer entries `strAdvancedFlags`, `fEngineResistance`, toe, camber and castor angles, `fJumpForceScale`, `AdvancedData` |
| `CBikeHandlingData` | 23 | Lean forward and back (centre of mass and force), maximum bank angle, wheelie and stoppie balance points, in-air steering, ground side friction, kickstand angles, jump force (BMX) |
| `CFlyingHandlingData` | 22 (26 with the patches) | Thrust and fall-off, thrust vectoring, yaw, roll and pitch multipliers and stabilisers, lift from form and angle of attack, landing-gear drag and lift, wind, turbulence (`fTurublence*`, sic), damage-to-control effect, glide with the engine off, and `fSubmergeLevelToPullHeliUnderwater` (4) |
| `CBoatHandlingData` | 10 | Buoyancy box multipliers, aquaplaning, rudder, keel, propeller, impeller, prow raise, move and turn resistance |
| `CSubmarineHandlingData` | 1 | Pitch, yaw, roll, dive speed, resistances |
| `CTrailerHandlingData` | 15 | Attach limits (pitch, roll, yaw), upright spring, attach distance, mass ratio for the hitch |
| `CVehicleWeaponHandlingData` | 17 (44 with the patches) | Weapon hashes per seat, turret speed and pitch limits, bullet velocity for gravity, gadgets |
| `CAdvancedData` | 8 | Slot, index and value triples: changes that apply only when a given mod-kit part is fitted |
| `CBaseSubHandlingData` | 1 | Empty placeholder |

## 4.5 The flag words

Three hex words per entry, plus `strAdvancedFlags` in some car blocks. How often each bit is set across the 353 base and patch entries (**Verified** counts; bit names come from community lists and are **Known**, so check one in game before relying on it):

- **`strModelFlags`**: most common bits `0x10` (254), `0x40000` (240), `0x400000` (227), `0x8` (65), `0x200000` (63), `0x20000` (60), `0x40` and `0x4000` (44 each), `0x20000000` (43). These describe the model (wheel and tyre setup, axles, lights, whether it is a tank or a rally car).
- **`strHandlingFlags`**: most common `0x1` (64), `0x20000` (42), `0x400000` (29), `0x1000` (28), `0x4000000` (28). `0x4000000` is set only on armoured and Arena War vehicles in vanilla: `RHINO`, `INSURGENT`, `INSURGENT2`, `FREIGHT`, `SCARAB`, `RCBANDITO`, and the Arena War `BRUISER`, `BRUTUS`, `CERBERUS`, `DEATHBIKE`, `DOMINATOR4/5`, `IMPALER2/3`, `IMPERATOR`, `ISSI4/5`, `MONSTER3`, `SLAMVAN4/5`, `ZR380` families. Community lists call it a heavy-armour flag (**Known**).
- **`strDamageFlags`**: only three bits used: `0x20` (143), `0x10` (15), `0x1` (1). Community lists name them "driver can't be knocked off", "doors can't break" and similar (**Known**).
- **`strAdvancedFlags`** (29 entries): `0x40000` (21), `0x20000000` (6), `0x2000000` (3).

## 4.6 Damage

A vehicle's damage is decided by four multipliers in its handling entry, scaled at run time by script natives:

| Multiplier | Applies to (**Known**) | Base file |
| --- | --- | --- |
| `fCollisionDamageMult` | Health lost in collisions | |
| `fWeaponDamageMult` | Health lost to weapons | |
| `fDeformationDamageMult` | How much the body visibly deforms | |
| `fEngineDamageMult` | How much of the damage reaches the engine | 1.5 on most entries |

Vehicles have three health values a script can set and read: body, engine and petrol tank (`SET_VEHICLE_BODY_HEALTH`, `SET_VEHICLE_ENGINE_HEALTH`, `SET_VEHICLE_PETROL_TANK_HEALTH`; 1,000 is full, an engine below 0 catches fire, **Known**). `fPetrolTankVolume` and `fOilVolume` decide how much leaks when the tank or the engine is shot (**Known**).

Missions shape damage per vehicle (**Verified** counts of calls in the decompile):

| Native | Calls | Used for |
| --- | --- | --- |
| `SET_VEHICLE_TYRES_CAN_BURST` | 2,715 | Bulletproof tyres on mission cars |
| `SET_VEHICLE_STRONG` | 1,473 | Less damage from collisions |
| `SET_VEHICLE_ENGINE_HEALTH` | 1,377 | Start a car damaged, or keep a mission car alive |
| `SET_VEHICLE_HAS_STRONG_AXLES` | 1,300 | Wheels don't break off |
| `SET_VEHICLE_DAMAGE_SCALE` | 1,223 | Scale all damage on one vehicle |
| `SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE` | 1,010 | Mission vehicles that must survive a blast |
| `SET_VEHICLE_PETROL_TANK_HEALTH` | 780 | |
| `SET_VEHICLE_CAN_BREAK` | 690 | Parts can come off |
| `SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED` | 587 | Hide deformation, for example on show cars |
| `SET_VEHICLE_FIXED` | 514 | Repair |
| `SET_VEHICLE_CAN_DEFORM_WHEELS` | 504 | |
| `SET_VEHICLE_ENGINE_CAN_DEGRADE` | 314 | Engine wear |
| `SET_VEHICLE_DAMAGE` | 182 | Dent a car at a given point (staged wrecks) |
| `SET_VEHICLE_BODY_HEALTH` | 151 | |
| `SET_VEHICLE_DEFORMATION_FIXED` | 35 | Remove dents only |
| `SET_DISABLE_VEHICLE_ENGINE_FIRES` | 34 | |
| `SET_VEHICLE_WEAPON_DAMAGE_SCALE` | 33 | |

## 4.7 Speed, grip and upgrades

**Natives that change driving** (**Verified** counts):

| Native | Calls | Effect (**Known**) |
| --- | --- | --- |
| `SET_VEHICLE_MOD` | 13,907 | Fit a mod-kit part, including engine, brakes, gearbox, suspension, armour and turbo |
| `MODIFY_VEHICLE_TOP_SPEED` | 3,073 | Percentage change to drive force and top speed (Online races and catch-up) |
| `SET_VEHICLE_MAX_SPEED` | 2,017 | Hard speed cap, often for scripted chases |
| `SET_VEHICLE_FORWARD_SPEED` | 1,675 | Set speed instantly (spawning a moving car, launches) |
| `SET_DRIFT_TYRES` / `GET_DRIFT_TYRES_SET` | 1,475 / 652 | Low-grip drift tyres (2021+ content) |
| `SET_VEHICLE_REDUCE_GRIP` / `_LEVEL` | 25 / 10 | Less grip on one vehicle |
| `SET_VEHICLE_IS_RACING` | 21 | Racing mode for AI-driven cars |
| `SET_VEHICLE_USE_ALTERNATE_HANDLING` | 11 | Swap to an alternative handling (special vehicles) |
| `SET_VEHICLE_FRICTION_OVERRIDE` | 9 | |
| `SET_VEHICLE_CHEAT_POWER_INCREASE` | 8 | Extra power (story cheats) |
| `SET_VEHICLE_GRAVITY` | 4 | |

There is no native that writes a handling field. ScriptHookV's `getHandling`-style memory access and SHVDN's `Vehicle.HandlingData` are the way mods change one vehicle's handling at run time (**Known**; SHVDN members in [`reference/SHVDN3/`](https://github.com/scripthookvdotnet/scripthookvdotnet)).

**Mod-shop upgrades** are defined in each mod kit in `carcols.meta` as `statMods` items: a type, a `modifier` value and a weight (**Verified**, sample `dlc_patch\mp2023_01\common\data\carcols.meta`):

| Type | Modifier values seen | Notes |
| --- | --- | --- |
| `VMT_ENGINE` | 25, 50, 75, 100 in most kits; up to 220 on some | Each level adds drive force (**Known**) |
| `VMT_BRAKES` | 25 to 250, usually three levels | |
| `VMT_GEARBOX` | 50, 100, 200 typical | Faster shifts (**Known**) |
| `VMT_SUSPENSION` | 1 to 110 | Lowering (**Known**) |
| `VMT_ARMOUR` | 20, 40, 60, 80, 100 in every kit | Damage reduction in percent (**Known**) |
| `VMT_HORN` | sound hashes | Not physics |

The weight (`weight` 20 for engines, 5 for brakes) adds mass to the car (**Known**). Turbo is a toggle mod with no stat item in these kits. `CAdvancedData` (4.4) lets a single part also change a handling field for one model.

## 4.8 DLC handling

All 89 vanilla DLC packs were scanned (**Verified**). 38 of them carry a `handling.meta`, together holding **544 more `CHandlingData` entries**, more than twice the base file. With the 254 base entries the game has about 800 handling entries (some DLC entries re-define base names).

| Pack | Entries | Pack | Entries |
| --- | --- | --- | --- |
| `mpchristmas2018` (Arena War) | 33 | `mpbiker` | 21 |
| `mpchristmas2017` (Doomsday) | 29 | `mp2024_01` | 21 |
| `mpimportexport` | 23 | `mpheist4` (Cayo Perico) | 20 |
| `mp2023_02` | 23 | `mpheist3` (Casino heist) | 20 |
| `mpvinewood` (Casino) | 22 | `mpsmuggler`, `mpsum2`, `mpgunrunning` | 19, 18, 18 |

The newer entries use the newer fields far more: 172 `CAdvancedData` blocks (8 in the base file), 281 `strAdvancedFlags`, 81 `fDownforceModifier`, 35 toe angles, and 108 vehicle-weapon blocks. They also bring three block types the base file lacks: `CSeaPlaneHandlingData` (3), `CSpecialFlightHandlingData` (2, hover and flight modes such as the Oppressor Mk II and Deluxo) and more submarines (4). Drive layout is 353 rear, 21 front and 170 all-wheel drive; AI styles are 456 `AVERAGE`, 61 `SPORTS_CAR`, 23 `TRUCK`, 4 `CRAP`. Median top-speed value is 147 (134 in the base file).


## 4.9 What this means for modders

- **Change handling through data, not code, where possible.** A new vehicle or a changed feel belongs in an add-on pack's `handling.meta`, never in `update.rpf`, so game updates don't have to be merged by hand.
- **Merge, don't replace.** A `handling.meta` copied from an older build silently removes later Rockstar entries and blocks. Any handling edit should start from the current vanilla file and change only the fields it needs; a script that diffs by handling name (as done for this guide) shows exactly what changed.
- **Per-vehicle changes at run time** (a damaged-but-driving car, an upgraded mission car, a slippery road) go through the natives in 4.6 and 4.7, which the game itself uses tens of thousands of times. They reset when the vehicle is deleted, which is safer than editing handling memory, which affects every car using that entry.
- **Keep the AI in mind.** NPC drivers use one of four AI handling styles, not the handling entry's grip numbers, to choose speeds and braking points. A car made much faster in `handling.meta` will be driven badly by NPCs unless its `AIHandling` changes too.
- **Weight and damage cost little on a low-end PC.** Deformation is a mesh change on the crashed car only; the real cost of crashes is debris, fire and ragdolls (R2.7).

## 4.10 Open questions

| Question | Where it goes |
| --- | --- |
| Bit names for the model, handling, damage and advanced flags, checked one by one in game | R2.2 second pass |
| How the engine turns `fInitialDriveMaxFlatVel` and the drive force into the real top speed | R2.2 second pass, in-game measurement |
| What exactly each `statMods` modifier changes (percent of what) | R2.2 second pass |
| How `vehicles.meta` fields (`handlingId`, wheel scale, `flags`) interact with handling | R14.1 |
