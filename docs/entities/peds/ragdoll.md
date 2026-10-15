# Ped physics and ragdoll

How peds fall over: the ragdoll tasks and their Euphoria (NaturalMotion) behaviours, the tuning file that drives them, when a falling ped turns into a ragdoll and how high a fall has to be, how Rockstar's scripts block, start and control ragdolls, and what that means for mods. Roadmap topic **R2.3** in the [roadmap](/ROADMAP.md). Builds on [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (R3.8: health thresholds), [physics cost](/docs/performance/physics-cost.md) (R2.7: what ragdolls cost) and [collision and materials](/docs/physics/collision-and-materials.md) (R2.1).

**How it was made.** Data from build 1.0.3725.0: `update\update.rpf\x64\data\tune\physicstasks.ymt` (the ragdoll tuning, 22,191 lines as XML), `movementtasks.ymt` and `playerinfo.ymt` (falling), extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and counted with `grep` and `awk`. Script use from the [native usage](/scripting/native-usage.md) tables and a `git grep` of every `SET_RAGDOLL_BLOCKING_FLAGS` and `SET_PED_TO_RAGDOLL` call in the decompile (commit `6c18d3e8b`). Values and counts are **Verified**. Names of the blocking-flag bits and ragdoll types come from NativeDB's enums (**Known**), as does what the engine does with each tunable.

## 17.1 Short version

- **Ragdolls are tasks.** Each kind of fall is its own task with its own tunables: 19 `CTaskNM*` tasks (shot, high fall, explosion, flinch, brace, balance, electrocute, on fire, drunk, river rapids, through the windscreen, jump-roll from a vehicle, injured on the ground, dragging to safety, buoyancy ...) plus `CTaskRageRagdoll` (the plain physics ragdoll without behaviours) and a grab helper.
- **The behaviours are NaturalMotion messages:** the tuning file sends 587 messages using 58 behaviour names (`configuresoftlimit`, `configurebalance`, `setfallingreaction`, `shot`, `bodywrithe`, `stayupright`, `smartfall`, `catchfall`, `rolldownstairs`, `highfall`, `electrocute` ...), set with 3,704 number and on-off parameters (2,100 floats, 1,340 bools, 264 ints) plus a few vectors and strings.
- **24 tuning sets** change a behaviour for one cause: weapon kinds (`automatic`, `AutomaticSMG`), melee (`BAT_FRONT`, `BAT_SMASH`, `KNIFE`, `KICK_STANDING`, `HAMMER_FACE`), vehicles that hit you (`LOWCAR`, `MINI`, `SLOWTRUCK`, `MOTOBIKE`, `BICYCLE`) and others.
- **A fall turns into a high fall** when the downward speed passes 3 m/s (`ImmediateHighFallSpeedPlayer` and `_Ai`, −3) with a 6 m ground probe; landings roll from 2.75 m (3 m after a vault); water 1 to 3 m deep softens a high fall. The player's ragdoll on falling starts at 6 m (`MinFallHeight`).
- **Scripts mostly stop ragdolls:** `SET_PED_CAN_RAGDOLL` (478 scripts, 1,760 calls), `SET_RAGDOLL_BLOCKING_FLAGS` (313 scripts, 718 calls), `SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT` (342) and `SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE` (296 scripts, 14,183 calls), against `SET_PED_TO_RAGDOLL` in only 71 scripts.
- **The commonest blocking mask is 57,360** (267 calls): player impact, player bump, player-ragdoll bump and ped-ragdoll bump, so a ped doesn't fall over when someone walks or stumbles into it.
- **Scripts rarely drive Euphoria directly:** `CREATE_NM_MESSAGE` / `GIVE_PED_NM_MESSAGE` appear in 4 scripts; everything else comes from the engine's own tasks and this tuning.

## 17.2 Where it lives

| File | What it holds | Count |
| --- | --- | ---: |
| `physicstasks.ymt` | Tunables for each ragdoll task, NM messages and tuning sets | 21 tunables blocks, 587 messages, 24 tuning sets |
| `movementtasks.ymt` (`CTaskFall__Tunables`) | When a fall becomes a high fall, landing and roll heights, water depths | about 40 values |
| `playerinfo.ymt` | The player's fall height for ragdoll (`MinFallHeight` 6) | |
| `pedhealth.meta` | Health thresholds (hurt, injured, dying) that decide writhing and death | 10 configs, see [R3.8](/docs/gameplay/player/health-armour-death.md) |
| `data\anim\pose_databases\nm_blend_out_sets.meta` | How a ped gets up from a ragdoll pose | |

## 17.3 The ragdoll tasks

| Task | Used when (**Known**) | Size in the file (lines) |
| --- | --- | ---: |
| `CTaskNMShot` | Hit by bullets | 10,067 |
| `CTaskNMFlinch` | Flinching from nearby hits and pushes | 2,418 |
| `CTaskNMBrace` | Bracing for a vehicle hit | 2,377 |
| `CTaskNMJumpRollFromRoadVehicle` | Bailing out of a moving vehicle | 1,571 |
| `CTaskNMHighFall` | Falling from height | 1,444 |
| `CTaskNMBalance` | Stumbling and trying to stay up | 1,218 |
| `CTaskNMBehaviour` | Shared settings for all of them | 780 |
| `CTaskNMExplosion` | Blast | 527 |
| `CTaskNMThroughWindscreen` | Thrown through the windscreen | 337 |
| `CTaskNMSimple` | Simple scripted behaviours (three tuning entries) | 277 |
| `CTaskNMPrototype` | A test task | 224 |
| `CTaskNMDrunk` | Drunk stumbling | 168 |
| `CTaskNMElectrocute` | Stun gun | 144 |
| `CTaskNMRiverRapids` | Rapids | 128 |
| `CTaskNMControl` | The controller that runs the others | 104 |
| `CTaskNMOnFire` | Burning | 39 |
| `CTaskNMDraggingToSafety` | Being dragged by a buddy | 21 |
| `CTaskNMInjuredOnGround`, `CTaskNMBuoyancy` | Writhing on the ground, floating | 8, 10 |
| `CTaskRageRagdoll` | The plain physics ragdoll (no behaviours), also used when Euphoria is not available | 42 |

Bullet hits get by far the most tuning, which matches how often peds are shot. The shot task alone sends `shot`, `shotsnap`, `shotshockspin`, `shotfalltoknees`, `shotinguts`, `shotfrombehind`, `configureshotinjuredleg` and `configurebullets` with different settings per case.

**`CTaskRageRagdoll` values** (**Verified**): three force stages per case (start 0, middle 300 or 150, end 0, over 1 to 4 s), impulse reduced by 0.2 per extra shot and recovered at 1 per second, modifiers between 0.5 and 1, the first hit's impulse doubled, and animals at 0.07 of the mass with impulse ×0.5 to ×2.

**`CTaskNMHighFall` values** (**Verified**): the push into the fall has a magnitude of 800, scales with speed from 0 to 4 m/s (half force to full), is capped at 4,500, lasts 300 ms, and pitches 10° into the direction of travel (also 10° for stunt jumps). A ped that has high-fallen can't go into "injured on the ground" for 3,500 ms.

## 17.4 Falling

From `CTaskFall__Tunables` (**Verified**):

| Value | Setting | Meaning (**Known**) |
| --- | --- | --- |
| `ImmediateHighFallSpeedPlayer`, `_Ai` | −3 | Falling faster than 3 m/s goes straight to a high fall |
| `HighFallProbeLength` | 6 | Distance checked below the ped |
| `ContinuousGapHighFallTime` | 0.25 | Seconds over a gap before a high fall |
| `DeferHighFallTime` | 0.33 | Delay before committing to a high fall |
| `LandRollHeight`, `_FromJump`, `_FromVault` | 2.75, 2.75, 3 | Fall height that ends in a roll |
| `HighFallWaterDepthMin`, `_Max` | 1, 3 | Water depth that softens a high fall |
| `HighFallExtraHeightWaterDepthMin`, `_Max` | 1.25, 5 | Extra height allowed above water of that depth |
| `DiveControlMaxFallDistance` | 100 | Longest fall with dive control |
| `FallTimeBeforeHighFallAbort` | 300 | ms before a high fall can be cancelled |
| `MinFallSpeedForHighFallAbort` | −2.5 | |

The player starts ragdolling from a fall at 6 m (`playerinfo.ymt` `MinFallHeight`); scripts change this with `SET_PLAYER_FALL_DISTANCE_TO_TRIGGER_RAGDOLL_OVERRIDE` (6 scripts) and start a fall with `SET_HIGH_FALL_TASK` (12 scripts). Fall damage itself isn't in these files ([R3.8](/docs/gameplay/player/health-armour-death.md), open question there).

## 17.5 How scripts control ragdolls

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE` | 296 | 14,183 | Keep mission peds on bikes and in seats |
| `IS_PED_RAGDOLL` | 718 | 3,063 | Wait before giving tasks or dialogue |
| `SET_PED_CAN_RAGDOLL` | 478 | 1,760 | Turn ragdoll off entirely |
| `SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT` | 342 | 1,208 | Stop the player knocking allies over |
| `SET_RAGDOLL_BLOCKING_FLAGS`, `CLEAR_RAGDOLL_BLOCKING_FLAGS` | 313, 36 | 718, 126 | Block chosen causes only |
| `SET_PED_TO_RAGDOLL` | 71 | 174 | Start a ragdoll for a set time |
| `IS_PED_RUNNING_RAGDOLL_TASK` | 120 | 144 | |
| `SET_PED_TO_RAGDOLL_WITH_FALL` | 9 | 13 | Ragdoll with a push in a direction |
| `CREATE_NM_MESSAGE`, `GIVE_PED_NM_MESSAGE` | 4 | 9 each | Send a NaturalMotion behaviour from script |
| `GIVE_PLAYER_RAGDOLL_CONTROL` | 5 | 5 | Let the player steer while ragdolled |
| `SET_CORPSE_RAGDOLL_FRICTION`, `RESET_PED_RAGDOLL_TIMER`, `SET_PED_RAGDOLL_FORCE_FALL` | 1, 3, 5 | | Rare tweaks |

**Blocking masks Rockstar uses** (**Verified** values; bit names **Known**: 1 bullet impact, 2 vehicle impact, 4 fire, 8 electrocution, 16 player impact, 32 explosion, 64 object impact, 128 melee, 8,192 player bump, 16,384 player-ragdoll bump, 32,768 ped-ragdoll bump):

| Mask | Calls | Blocks |
| ---: | ---: | --- |
| 57,360 | 267 | Player impact and the three bump kinds |
| 16 | 116 | Player impact |
| 1 | 56 | Bullet impact |
| 64 | 40 | Object impact |
| 8,208 | 34 | Player impact and player bump |
| 128 | 23 | Melee |
| 32 | 11 | Explosion |
| 24,576, 24,720 | 11 each | Bumps (and object and melee) |

**Ragdoll type** (third value of `SET_PED_TO_RAGDOLL`, names **Known**): 0 normal in 120 calls, 2 (narrow legs) in 37, 1 (stiff legs) in 17.

## 17.6 What this means for modders

- **Edit `physicstasks.ymt` to change how peds fall,** one task or one tuning set at a time (for example the shot task for "heavier" bullet reactions, or `CTaskNMHighFall` for falls). It's a tune file in `update.rpf`, so a replacement goes in the mods folder ([archives and content](/docs/core/archives-and-content.md)).
- **To stop a ped falling over, block causes, don't kill the ragdoll:** Rockstar's favourite mask (57,360) keeps peds standing when bumped but still lets bullets, cars and explosions knock them down. `SET_PED_CAN_RAGDOLL(false)` turns all of it off and looks wrong in a crash.
- **Wait out a ragdoll before tasking a ped:** check `IS_PED_RAGDOLL` (Rockstar does, in 718 scripts).
- **Ragdolls are the most expensive thing a ped does** ([physics cost](/docs/performance/physics-cost.md)): on a weak PC, keep script-made simultaneous ragdolls to a handful.

## 17.7 Open questions

| Question | Where it goes |
| --- | --- |
| How many Euphoria ragdolls run at once before peds fall back to `CTaskRageRagdoll` | In-game test, [physics cost](/docs/performance/physics-cost.md) test card 1 |
| Which tuning set is chosen for which weapon and vehicle, and the 3 hashed set names | Second pass, weapon and vehicle data |
| Fall damage by height | R3.8 open question, in-game test |
| What `nm_blend_out_sets.meta` sets for getting up | Second pass |

## 17.8 Test cards (story mode, a script mod)

1. **Fall height.** Teleport the player 5 m and then 7 m above flat ground. Expected: the 5 m fall lands (or rolls); the 7 m fall ragdolls.
2. **Blocking mask.** Spawn a ped, set blocking flags 57,360, run into it. Expected: it doesn't fall. Shoot it with a non-lethal weapon. Expected: it still reacts and can fall.
3. **Tuning.** Double `Mag` under `CTaskNMHighFall` in a replaced `physicstasks.ymt` and jump off a roof. Expected: a stronger push at the start of the fall.
