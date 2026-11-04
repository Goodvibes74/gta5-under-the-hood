# Ped physics and ragdoll

How peds fall over: the ragdoll tasks and their Euphoria (NaturalMotion) behaviours, the tuning file that drives them, when a falling ped turns into a ragdoll and how high a fall has to be, how Rockstar's scripts block, start and control ragdolls, and what that means for mods. Roadmap topic **R2.3** in the [roadmap](/ROADMAP.md). Builds on [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (R3.8: health thresholds), [physics cost](/docs/performance/physics-cost.md) (R2.7: what ragdolls cost) and [collision and materials](/docs/physics/collision-and-materials.md) (R2.1).

**How it was made.** Data from build 1.0.3725.0: `update\update.rpf\x64\data\tune\physicstasks.ymt` (the ragdoll tuning, 22,191 lines as XML), `movementtasks.ymt` and `playerinfo.ymt` (falling), extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and counted with `grep` and `awk`. Script use from the [native usage](/scripting/native-usage.md) tables and a `git grep` of every `SET_RAGDOLL_BLOCKING_FLAGS` and `SET_PED_TO_RAGDOLL` call in the decompile (commit `6c18d3e8b`). Values and counts are **Verified**. Names of the blocking-flag bits and ragdoll types come from NativeDB's enums (**Known**), as does what the engine does with each tunable.

## 17.1 Short version

- **Ragdolls are tasks.** Each kind of fall is its own task with its own tunables: 19 `CTaskNM*` tasks (shot, high fall, explosion, flinch, brace, balance, electrocute, on fire, drunk, river rapids, through the windscreen, jump-roll from a vehicle, injured on the ground, dragging to safety, buoyancy ...) plus `CTaskRageRagdoll` (the plain physics ragdoll without behaviours) and a grab helper.
- **The behaviours are NaturalMotion messages:** the tuning file sends 587 messages using 58 behaviour names (`configuresoftlimit`, `configurebalance`, `setfallingreaction`, `shot`, `bodywrithe`, `stayupright`, `smartfall`, `catchfall`, `rolldownstairs`, `highfall`, `electrocute` ...), set with 3,704 number and on-off parameters (2,100 floats, 1,340 bools, 264 ints) plus a few vectors and strings.
- **24 tuning sets** change a behaviour for one cause: weapon kinds (`automatic`, `AutomaticSMG`), melee (`BAT_FRONT`, `BAT_SMASH`, `KNIFE`, `KICK_STANDING`, `HAMMER_FACE`), bailing out of a vehicle (`LOWCAR`, `SLOWTRUCK`, `MOTOBIKE`, `BICYCLE`, `STANDARD`) and others. Weapons pick theirs by name in the weapon data, vehicles per seat entry in `vehiclelayouts.meta` ([17.3.1](#1731-who-picks-which-tuning-set-pc-data-pass)).
- **A fall turns into a high fall** when the downward speed passes 3 m/s (`ImmediateHighFallSpeedPlayer` and `_Ai`, −3) with a 6 m ground probe; landings roll from 2.75 m (3 m after a vault); water 1 to 3 m deep softens a high fall. The player's ragdoll on falling starts at 6 m (`MinFallHeight`).
- **Scripts mostly stop ragdolls:** `SET_PED_CAN_RAGDOLL` (478 scripts, 1,760 calls), `SET_RAGDOLL_BLOCKING_FLAGS` (313 scripts, 718 calls), `SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT` (342) and `SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE` (296 scripts, 14,183 calls), against `SET_PED_TO_RAGDOLL` in only 71 scripts.
- **The commonest blocking mask is 57,360** (267 calls): player impact, player bump, player-ragdoll bump and ped-ragdoll bump, so a ped doesn't fall over when someone walks or stumbles into it.
- **Scripts rarely drive Euphoria directly:** `CREATE_NM_MESSAGE` / `GIVE_PED_NM_MESSAGE` appear in 4 scripts; everything else comes from the engine's own tasks and this tuning.

## 17.2 Where it lives

| File | What it holds | Count |
| --- | --- | ---: |
| `physicstasks.ymt` | Tunables for each ragdoll task, NM messages and tuning sets | 21 tunables blocks, 587 messages, 24 tuning sets |
| `movementtasks.ymt` (`CTaskFall__Tunables`) | When a fall becomes a high fall, landing and roll heights, water depths | about 40 values |
| `playerinfo.ymt` | The player's fall height for ragdoll (`MinFallHeight` 6, `MaxFallHeight` 8.5) | |
| `pedhealth.meta` | Health thresholds (hurt, injured, dying) that decide writhing and death | 10 configs, see [R3.8](/docs/gameplay/player/health-armour-death.md) |
| `data\anim\pose_databases\nm_blend_out_sets.meta` | How a ped gets up from a ragdoll pose ([17.4.1](#1741-getting-up-nm_blend_out_setsmeta-pc-data-pass)) | 103 sets |

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

### 17.3.1 Who picks which tuning set (PC data pass)

**Verified** (`update:/x64/data/tune/physicstasks.ymt`, every weapon `.meta` file and every `vehiclelayouts.meta` copy, build 1.0.3725.0, read with CodeWalker; hashed names resolved with `joaat` against every file name in the archives, every name in the data files and a word list).

The 24 tuning sets sit in four tunables blocks:

| Block | Sets |
| --- | --- |
| `CTaskNMShot` (bullet hits) | `normal`, `automatic`, `AutomaticSMG`, `BurstFire`, `MINI`, `SHOTGUN`, `SNIPER`, and `AUTOMATICMG` (was hash `BD26D537`) |
| `CTaskNMFlinch` (melee hits) | `BAT_FRONT`, `BAT_SMASH`, `KNIFE`, `KNIFE_SLASH` (was hash `84B5F9FC`), `KICK_STANDING`, `HAMMER_FACE`, `HAMMER_TOWN`, `PRONE_BOOSTER_SHOT` |
| `CTaskNMJumpRollFromRoadVehicle` (bailing out) | `STANDARD`, `LOWCAR`, `SLOWTRUCK`, `MOTOBIKE`, `BICYCLE` |
| `CGrabHelper` | `DEFAULT` and two still unnamed (`91246F78`, with no messages, and `9131BB2D`, with a `grab` message) |

**Weapons choose by name.** Every weapon entry has an `NmShotTuningSet` (331 entries across all weapon files): `Normal` 251 (pistols, melee weapons, launchers, animal attacks and the damage-only "weapons" such as `WEAPON_FALL` or `WEAPON_FIRE`), `Mini` 23 (`WEAPON_SMG`, `WEAPON_COMBATPDW`, `WEAPON_MG`, `WEAPON_COMBATMG`, `WEAPON_MINIGUN`, `WEAPON_RAYCARBINE`, `WEAPON_RAYMINIGUN`), `Automatic` 21 (the assault rifles, `WEAPON_ASSAULTSMG`, `WEAPON_GUSENBERG`), `Shotgun` 15 (every shotgun and `WEAPON_RAILGUN`), `Sniper` 13, `BurstFire` 5 (`WEAPON_APPISTOL`, `WEAPON_MACHINEPISTOL`, `WEAPON_MINISMG`) and `AutomaticSMG` 3 (`WEAPON_MICROSMG`, `WEAPON_TECPISTOL`). Set names are hashes, so case doesn't matter. No weapon names `AUTOMATICMG`, so nothing in the data uses that set. So `MINI` is a shot set, for SMGs, machine guns and the minigun, not a vehicle set.

**Vehicles choose per seat entry.** An entry point in `vehiclelayouts.meta` (`CVehicleEntryPointAnimInfo`) may name an `NMJumpFromVehicleTuningSet`. In the update's copy 40 of the 249 entry points do (`SLOWTRUCK` 27, `MOTOBIKE` 5, `BICYCLE` 5, `LOWCAR` 3; across the base, update and `dlc_patch` copies `SLOWTRUCK` 81, `LOWCAR` 27, `STANDARD` 22, `MOTOBIKE` 14, `BICYCLE` 10). Our reading: an entry point without the field uses `STANDARD`. Being hit by a vehicle is a separate case: `CTaskNMBrace` has `VehicleOverrides` keyed by vehicle type (`BIKE` ...). The melee flinch sets have no field in the weapon data, so the engine picks them from the attack (**Known** from the names only).

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

**Fall damage is not in any data file** (PC data pass, **Verified**): a search of all 2,134 data files extracted from the vanilla archives (every `.meta`, `.ymt`, `.dat` and `.xml` under `common\data`, `update\common\data` and `update\x64\data`, and the DLC copies) finds no field that ties a fall, landing or impact to damage or health. What the files hold is when a fall turns into a ragdoll: `MinFallHeight` 6 and `MaxFallHeight` 8.5 in every `PlayerStatInfos` entry of `playerinfo.ymt`, and in `physicstasks.ymt` `FallingSpeedForHighFall` (5 and 4 in different blocks), `RollUpHeightThreshold` 5, `CatchFallHeightThresholdRollUp` 3, `CatchFallHeightThresholdWindmill` 1, `CatchFallHeightThresholdClipPose` 10, `TimeToStartCatchFall` 2,000 ms and `TimeToStartCatchFallPlayer` 500 ms. So the damage is computed in the executable; test card 1 below measures it.

### 17.4.1 Getting up: `nm_blend_out_sets.meta` (PC data pass)

**Verified** (base and update copies; the update changes values, not names).

The file is a `CNmBlendOutSetManager` with **103 sets** (`NMBS_*`; one name, `NMBS_PLAYER_MP_ACTION_MODE_CLONE_GETUPS`, appears twice). A set is a small graph of items, each with an `id` and a `nextItemId`. Item types: `NMBT_SINGLECLIP` 483, `NMBT_SETBLEND` 130, `NMBT_DIRECTIONALBLEND` 102, `NMBT_FORCEMOTIONSTATE` 33, `NMBT_AIMFROMGROUND` 2, `NMBT_CRAWL` 1, `NMBT_NONE` 1.

A clip item names a clip set and clip and sets:

| Field | What it controls (from the name) |
| --- | --- |
| `minPlaybackRate`, `maxPlaybackRate` | How fast the get-up plays |
| `earlyOutPhase`, `armedAIEarlyOutPhase` | When the get-up may end early (armed AI separately) |
| `movementBreakOutPhase`, `turnBreakOutPhase`, `playerAimOrFireBreakOutPhase` | When moving, turning or aiming and firing may interrupt it |
| `dropDownPhase`, `ragdollFrameBlendDuration` | Blending in from the ragdoll pose |
| `fullBlendHeadingInterpRate`, `zeroBlendHeadingInterpRate` | Turning towards the target heading |
| `addToPointCloud`, `no180Blend`, `looping`, `allowInstantBlendToAim` | Pose matching and other switches |

`NMBT_FORCEMOTIONSTATE` items end the get-up in a motion state (`Idle`, `Walk`, `Run`, `ActionMode_Idle/Walk/Run`, `Diving_Idle`, `Swimming_TreadWater`). Set flags: `BOSF_AllowRootSlopeFixup`, `BOSF_AllowWhenDead`, `BOSF_DontAbortOnFall`, `BOSF_ForceDefaultBlendOutSet`, `BOSF_ForceNoBlendOutSet`.

The sets by use: human get-ups by speed (`STANDARD` at 1.0×, `FAST` 1.15×, `SLOW` 0.85×, each with `_FEMALE` and `_CLONE` variants), `PLAYER` (0.9×, ending in walk or run starts), `INJURED` (with player and MP variants), `DRUNK`, `ARMED_1HANDED` and `_2HANDED` (with `SHOOT_FROM_GROUND`), `ACTION_MODE`, `FIRST_PERSON` (with MP and injured variants), `MELEE`, `ARREST`, `FULL_ARREST`, `CUFFED`, `SKYDIVE`, `DIVING`, `SWIMMING`, `UNDERWATER`, `CRAWL`, `WRITHE`, `PANIC_FLEE`, the standing-aim sets (`STANDING_AIMING_LEFT`, `_CENTRE`, `_RIGHT`, each plain, `_RIFLE`, `_PISTOL_HURT` or `_RIFLE_HURT`), death (`DEATH_HUMAN`, `DEATH_HUMAN_OFFSCREEN`, `DEAD_FALL`), and per animal a `_GETUPS` set (boar, cat, cougar, cow, coyote, deer, horse, pig, pug, rabbit, retriever, rottweiler) and a `_DEAD` set (those plus birds, fish, sharks, whales, dolphin, stingray and rat). A ped model names its set with `GetupSetHash` in `peds.ymt`: 653 of the base models use `NMBS_SLOW_GETUPS`, 13 none, and the animals their own sets (the other sets are chosen by the engine from the situation, our reading).

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
| Which tuning set is chosen for which weapon and vehicle, and the 3 hashed set names | Mostly answered in [17.3.1](#1731-who-picks-which-tuning-set-pc-data-pass): weapons by `NmShotTuningSet`, vehicles per seat entry; two `CGrabHelper` sets still unnamed |
| Fall damage by height | Not in the data files ([17.4](#174-falling)); needs the executable or test card 1 |
| What `nm_blend_out_sets.meta` sets for getting up | Answered in [17.4.1](#1741-getting-up-nm_blend_out_setsmeta-pc-data-pass) |

## 17.8 Test cards (story mode, a script mod)

1. **Fall height.** Teleport the player 5 m and then 7 m above flat ground. Expected: the 5 m fall lands (or rolls); the 7 m fall ragdolls.
2. **Blocking mask.** Spawn a ped, set blocking flags 57,360, run into it. Expected: it doesn't fall. Shoot it with a non-lethal weapon. Expected: it still reacts and can fall.
3. **Tuning.** Double `Mag` under `CTaskNMHighFall` in a replaced `physicstasks.ymt` and jump off a roof. Expected: a stronger push at the start of the fall.
