# Wanted level and police

How the game turns a crime into stars: the 42 crimes in `crimeinformation.meta` and which must be witnessed, who can witness and report them, the crime points that set each star, how the wanted level gets harder or easier with time (`wantedtuning.ymt`), and the natives scripts use to control all of it. Roadmap topic **R3.7** in the [roadmap](/ROADMAP.md). Dispatch (who is sent per star, search radii, hiding times, search helpers) is in [police and service AI](/docs/ai/police-and-services.md) (R17.7); which shocking events make witnesses call the police is in [perception and events](/docs/ai/perception-and-events.md) (R17.2).

**How it was made.** `common\data\ai\crimeinformation.meta` and `crimes.meta`, `update\update.rpf\common\data\ai\witnessinformation.meta` and `common\data\dispatch.meta`, and `x64\data\tune\wantedtuning.ymt` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and read with `awk`. Literal crime numbers passed to `REPORT_CRIME` and `SUPPRESS_CRIME_THIS_FRAME` were pulled from the decompile (commit `6c18d3e8b`) with `git grep`; native counts from [native usage](/scripting/native-usage.md). Values and counts are **Verified**. How many points each crime adds is set inside the engine, not in these files (open question in 38.7).

## 38.1 Short version

- **42 crimes** are listed in `crimeinformation.meta`, from `CRIME_RUN_REDLIGHT` and `CRIME_SPEEDING` to `CRIME_KILL_COP` and `CRIME_TERRORIST_ACTIVITY`. **25 must be witnessed** to count; the other 17 (mostly crimes against the police, such as `CRIME_SHOOT_COP`, `CRIME_KILL_COP` and `CRIME_HIT_COP`, and big ones such as `CRIME_DESTROY_HELI` and `CRIME_MOLOTOV`) count without a witness.
- **Gunfire, explosions and shooting a ped can be heard** up to 50 m (`MaxDistanceToHear`); the rest must be seen.
- **Some crimes need a phone call:** firearm discharge, stealing a car or vehicle, jacking a dead ped and hassling (`MustNotifyLawEnforcement` in story mode); a hassle can only be reported by its victim.
- **Who witnesses:** the default witness personality is `CanWitnessCrimes WillCallLawEnforcement`; players and animals witness nothing. The old `crimes.meta` only gives vehicle theft a 50 m range.
- **Points to stars:** 50, 180, 550, 1,200 and 3,800 crime points for one to five stars (`dispatch.meta`).
- **The police get harder with stars and easier with time:** `wantedtuning.ymt` raises a difficulty value from 0.1 at one star to 0.75 at five, adds weight for distance from where the player was last seen, and lets it decay while the player evades (60 s at one star to 300 s at five). Police helicopters refuel at three stars (after 120 s, gone 90 s) but never at four or five.
- **Scripts control stars directly:** `GET_PLAYER_WANTED_LEVEL` (633 scripts), `SET_PLAYER_WANTED_LEVEL` (500), `SET_MAX_WANTED_LEVEL` (387), `SET_WANTED_LEVEL_MULTIPLIER` (372), `START_FIRING_AMNESTY` (161), `SET_PLAYER_WANTED_CENTRE_POSITION` (103). Reporting a crime by script (`REPORT_CRIME`) is rare (7 scripts).

## 38.2 The crimes

From `crimeinformation.meta` (**Verified**). "Witness" = `MustBeWitnessed`; "Heard" = `MaxDistanceToHear` in metres; "Call" = story-mode `MustNotifyLawEnforcement`.

| Crime | Witness | Heard | Call |
| --- | --- | ---: | --- |
| `CRIME_BLOCK_POLICE_CAR` |  |  |  |
| `CRIME_CAR_SET_ON_FIRE` | yes |  |  |
| `CRIME_CAUSE_EXPLOSION` | yes | 50 |  |
| `CRIME_COP_SET_ON_FIRE` |  |  |  |
| `CRIME_DAMAGE_TO_PROPERTY` | yes |  |  |
| `CRIME_DESTROY_HELI` |  |  |  |
| `CRIME_DESTROY_PLANE` |  |  |  |
| `CRIME_DESTROY_VEHICLE` | yes |  |  |
| `CRIME_DRIVE_AGAINST_TRAFFIC` | yes |  |  |
| `CRIME_FIREARM_DISCHARGE` | yes | 50 | yes |
| `CRIME_HASSLE` | yes |  | yes (victim only) |
| `CRIME_HIT_COP` |  |  |  |
| `CRIME_HIT_PED` | yes |  |  |
| `CRIME_JACK_DEAD_PED` | yes |  | yes |
| `CRIME_KILL_COP` |  |  |  |
| `CRIME_KILL_PED` | yes |  |  |
| `CRIME_MOLOTOV` |  |  |  |
| `CRIME_PED_SET_ON_FIRE` | yes |  |  |
| `CRIME_POSSESSION_GUN` | yes |  |  |
| `CRIME_RECKLESS_DRIVING` | yes |  |  |
| `CRIME_RESIST_ARREST` |  |  |  |
| `CRIME_RIDING_BIKE_WITHOUT_HELMET` | yes |  |  |
| `CRIME_RUNOVER_COP` |  |  |  |
| `CRIME_RUNOVER_PED` | yes |  |  |
| `CRIME_RUN_REDLIGHT` | yes |  |  |
| `CRIME_SHOOT_AT_COP` |  |  |  |
| `CRIME_SHOOT_COP` |  |  |  |
| `CRIME_SHOOT_NONLETHAL_COP` |  |  |  |
| `CRIME_SHOOT_NONLETHAL_PED` | yes |  |  |
| `CRIME_SHOOT_PED` | yes | 50 |  |
| `CRIME_SHOOT_PED_SUPPRESSED` | yes |  |  |
| `CRIME_SHOOT_VEHICLE` |  |  |  |
| `CRIME_SPEEDING` | yes |  |  |
| `CRIME_STAB_COP` |  |  |  |
| `CRIME_STAB_PED` | yes |  |  |
| `CRIME_STAND_ON_POLICE_CAR` |  |  |  |
| `CRIME_STEALTH_KILL_COP` | yes |  |  |
| `CRIME_STEALTH_KILL_PED` | yes |  |  |
| `CRIME_STEAL_CAR` | yes |  | yes |
| `CRIME_STEAL_VEHICLE` | yes |  | yes |
| `CRIME_TARGET_COP` |  |  |  |
| `CRIME_TERRORIST_ACTIVITY` |  |  |  |

## 38.3 Witnesses and reporting

`witnessinformation.meta` (update copy, **Verified**) has three personalities: `Default` (`CanWitnessCrimes WillCallLawEnforcement`), `Player` and `Animal` (no flags). *Known* from the flag names: a "witness" crime counts only if a ped that can witness sees it (or hears it, within the "heard" range); a "call" crime also needs the witness to phone the police before stars appear, which is the delay you see after stealing a car in view. Witnesses use ordinary ped perception ([combat and perception](/docs/ai/combat-and-perception.md)), so a crime nobody sees doesn't count; that's why stealth kills are listed as needing witnesses. Crimes against the police, destroying aircraft and molotovs need no witness.

## 38.4 From points to stars, and back

| Star | Crime points | Search radius, story (m) | Hidden time to lose it (s) | Difficulty | Last-seen weight | Decay time (s) | Decay max | Heli refuel |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| 1 | 50 | 145 | 30 | 0.1 | 0.1 | 60 | 1 | yes |
| 2 | 180 | 227.5 | 37.5 | 0.2 | 0.1 | 90 | 1 | yes |
| 3 | 550 | 340 | 45 | 0.35 | 0.15 | 120 | 0.75 | after 120 s, gone 90 s |
| 4 | 1,200 | 510 | 56.25 | 0.55 | 0.2 | 180 | 0.5 | no |
| 5 | 3,800 | 850 | 82.5 | 0.75 | 0.25 | 300 | 0.25 | no |

Points, radii and hidden times from `dispatch.meta`; the rest from `wantedtuning.ymt` (**Verified**). *Known* reading: the difficulty value (0 to 1) drives how hard the police push; it rises with the star level and the distance from the last seen position, and decays toward its maximum while the player keeps evading. `wantedtuning.ymt` also scores spawn points (distance, direction, randomness), sets an ideal spawn distance of 300 to 350 m, and decides when units that fall behind are despawned. After the stars go, a 9-second parole follows ([R17.7](/docs/ai/police-and-services.md)).

## 38.5 What scripts do

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `GET_PLAYER_WANTED_LEVEL` | 633 | 14,430 | |
| `SET_POLICE_IGNORE_PLAYER` | 565 | 1,148 | Police don't react to the player |
| `SET_PLAYER_WANTED_LEVEL`, `_NOW` | 500, 490 | 8,102, 1,743 | Give stars (the second applies them at once) |
| `SET_MAX_WANTED_LEVEL` | 387 | 2,157 | Cap stars, often to 0 in missions |
| `SET_WANTED_LEVEL_MULTIPLIER` | 372 | 1,219 | Scale crime points |
| `IS_PLAYER_WANTED_LEVEL_GREATER` | 276 | 862 | |
| `SET_FAKE_WANTED_LEVEL` | 181 | 427 | Show stars without police |
| `CLEAR_PLAYER_WANTED_LEVEL` | 168 | 440 | |
| `START_FIRING_AMNESTY` | 161 | 164 | Ignore gunfire for a few seconds (staged shootouts) |
| `SUPPRESS_LOSING_WANTED_LEVEL_IF_HIDDEN_THIS_FRAME` | 139 | 250 | Stop the stars dropping |
| `SET_PLAYER_WANTED_CENTRE_POSITION`, `GET_` | 103, 94 | 121, 96 | Move the search centre |
| `ARE_PLAYER_FLASHING_STARS_ABOUT_TO_DROP`, `ARE_PLAYER_STARS_GREYED_OUT` | 98, 75 | 111, 159 | Read the hiding state |
| `SET_WANTED_LEVEL_DIFFICULTY`, `RESET_` | 26, 19 | 41, 28 | Override the difficulty value |
| `REPORT_POLICE_SPOTTED_PLAYER` | 23 | 54 | |
| `FORCE_START_HIDDEN_EVASION` | 15 | 42 | |
| `SUPPRESS_CRIME_THIS_FRAME` | 11 | 57 | Ignore one crime type |
| `REPORT_CRIME` | 7 | 35 | Report a crime by script |

Crime numbers passed literally: `REPORT_CRIME` uses 37 (20 calls), 36 (12) and 13 (2); `SUPPRESS_CRIME_THIS_FRAME` uses 28 (4) and a spread of others. Their names come from NativeDB's crime list (open question).

## 38.6 What this means for modders

- **Make the police more or less forgiving** in `dispatch.meta` (points per star, radii, hiding times) and `wantedtuning.ymt` (difficulty, decay, helicopter refuel); both are data-file replacements in the mods folder ([archives and content](/docs/core/archives-and-content.md)).
- **Change what counts as a crime** in `crimeinformation.meta`: remove `MustBeWitnessed` to make a crime always count, add `MustNotifyLawEnforcement` to make witnesses phone first, or raise `MaxDistanceToHear`.
- **Quieter witnesses:** give the `Default` witness personality fewer flags in `witnessinformation.meta`, or turn off `CanCallPolice` on shocking events ([R17.2](/docs/ai/perception-and-events.md)).
- **In a script mod,** use Rockstar's tools: cap stars with `SET_MAX_WANTED_LEVEL`, scale them with `SET_WANTED_LEVEL_MULTIPLIER`, use `START_FIRING_AMNESTY` for staged gunfights, and undo them at cleanup.

## 38.7 Open questions

| Question | Where it goes |
| --- | --- |
| Crime points added per crime (set in the engine) | In-game test: commit one crime with a multiplier of 1 and read the result |
| Names for the crime numbers 13, 36, 37 and 28 | Second pass with NativeDB's crime list |
| How the difficulty value changes police behaviour, measured | In-game test |

## 38.8 Test cards (story mode)

1. **Witness.** Steal a car with nobody around, then in front of a pedestrian. Expected: no stars the first time; the second time stars appear after the witness phones.
2. **Heard gunfire.** Fire a pistol 40 m from a group out of sight, then 60 m. Expected: stars at 40 m (within 50 m), none at 60 m.
3. **Amnesty.** Call `START_FIRING_AMNESTY(5)` and fire. Expected: no stars for gunfire during those seconds.
