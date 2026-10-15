# Police and service AI

How the police and emergency services are sent and how they search: the dispatch data (14 services, what each wanted level sends, crime-point thresholds, search radii and how long the player must hide), the search helpers for cops on foot, in cars and in helicopters, where dispatch spawns units, ambulances and fire trucks, and which pieces police mods replace. Roadmap topic **R17.7** in the [roadmap](/ROADMAP.md). Extends R3.7 (wanted level and police, still open: crime detection and reporting) and builds on [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (R4.3: the 14 services and their vehicle sets) and [perception and events](/docs/ai/perception-and-events.md) (R17.2: which events make witnesses call the police).

**How it was made.** `update\update.rpf\common\data\dispatch.meta` and `x64\data\tune\dispatchtuning.ymt` and `wantedtuning.ymt` of build 1.0.3725.0, extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and read with `awk`. Native counts from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Values and counts are **Verified**; what each value does in the engine is **Known** from the field names.

## 35.1 Short version

- **Wanted stars come from crime points:** 50 points for one star, 180 for two, 550 for three, 1,200 for four, 3,800 for five (`WantedLevelThresholds`).
- **The search area grows with the stars:** in story mode the radius is 145, 227.5, 340, 510 and 850 m for one to five stars (Online: 217.5 to 1,275 m), and the player must stay hidden 30, 37.5, 45, 56.25 and 82.5 seconds to lose them (`HiddenEvasionTimes`).
- **What each level sends** (`WantedResponses`, peds to spawn): 1 star: 4 in cars, 3 by boat; 2: 6 and 3; 3: 8 in cars, 3 by helicopter, 2 at road blocks, 6 by boat; 4 and 5: 6 police, 6 SWAT in cars, 3 police and 5 SWAT by helicopter, 4 at road blocks, 6 (or 9) by boat.
- **Units come in waves:** new law units every 10 to 30 s depending on speed setting, ambulances and fire trucks every 20 to 60 s; dispatch tries to spawn about 250 m from the incident, in front of a fleeing player and out of view of the camera.
- **Cops search where you were last seen:** on foot they search a circle of 3 to 7 m around the last seen point for up to 15 s; in cars 100 down to 15 m over 60 s; in helicopters 150 down to 50 m over 120 s.
- **Emergency services** (not wanted-level): fire 4, ambulance 2, police vehicle request 2, gangs 6, army 6, biker backup 4, assassins 4.
- **Scripts control it all:** `GET_PLAYER_WANTED_LEVEL` (633 scripts), `SET_POLICE_IGNORE_PLAYER` (565), `SET_PLAYER_WANTED_LEVEL` (500), `SET_MAX_WANTED_LEVEL` (387), `SET_WANTED_LEVEL_MULTIPLIER` (372), `ENABLE_DISPATCH_SERVICE` (290), `SET_DISPATCH_COPS_FOR_PLAYER` (162), `SET_CREATE_RANDOM_COPS` (109).

## 35.2 `dispatch.meta`

Global values (**Verified**): parole after losing the stars 9,000 ms; detection is immediate within 25 m (45 m on screen); the radius is ×1.5 when the player is in a helicopter.

| Value | 1 star | 2 | 3 | 4 | 5 |
| --- | ---: | ---: | ---: | ---: | ---: |
| Crime points to reach it | 50 | 180 | 550 | 1,200 | 3,800 |
| Search radius, story (m) | 145 | 227.5 | 340 | 510 | 850 |
| Search radius, Online (m) | 217.5 | 341.25 | 450 | 645 | 1,275 |
| Hidden time to lose it, story (ms) | 30,000 | 37,500 | 45,000 | 56,250 | 82,500 |
| Hidden time, Online (ms) | 30,000 | 37,500 | 40,500 | 50,625 | 74,250 |

**Units sent** (peds per service):

| Service | 1 | 2 | 3 | 4 | 5 |
| --- | ---: | ---: | ---: | ---: | ---: |
| Police cars (`DT_PoliceAutomobile`) | 4 | 6 | 8 | 6 | 6 |
| SWAT cars | | | | 6 | 6 |
| Police helicopter | | | 3 | 3 | 3 |
| SWAT helicopter | | | | 5 | 5 |
| Road blocks | | | 2 | 4 | 4 |
| Police boats | 3 | 3 | 6 | 6 | 9 |

**Spawn delays** (seconds, slow / medium / fast): law 20–30 / 10–20 / 10–20; ambulance and fire 45–60 / 20–30 / 20–30. **Order distances:** units are told to go to the player within 200 m on foot and 350 m in vehicles.

Vehicle sets name the models (police cars and bikes, SWAT jeep, two police helicopters, ambulance, fire truck, three road-block kinds including spike strips, gangs, police boat, army, biker, assassins).

## 35.3 Search and spawning (`dispatchtuning.ymt`)

| Helper | Search time (s) | Radius (m) | Notes |
| --- | ---: | --- | --- |
| On foot | 0 to 15 | 3 growing to 7 | Uses the last seen position, searches enclosed regions |
| In a car | 0 to 60 | 100 shrinking to 15 | Default helper |
| In a helicopter | 0 to 120 | 150 shrinking to 50 | Default helper, open areas only |

**Spawning:** ideal distance 250 m from the incident; prefer points in front of the player (dot ≥ 0.707) when the player is escaping above 10 m/s; avoid points within 125 m of the camera that are in view. A destroyed police helicopter can't be replaced for 30 s (`MinSpawnTimeForPoliceHeliAfterDestroyed` 30,000 ms); boats retry every 3 s.

**Assassins** (dispatch type used by some missions): accuracy 20, 20, 30; shoot rate 30, 60, 100; health ×1, ×1.2, ×1.5 at levels 1 to 3.

`wantedtuning.ymt` holds the crime list (9 crime-info entries, under hashed names) and the rules for how the wanted level rises with time evading and distance (**Verified** values; meaning is R3.7).

## 35.4 What scripts do

| Native | Scripts | Calls |
| --- | ---: | ---: |
| `GET_PLAYER_WANTED_LEVEL` | 633 | 14,430 |
| `SET_POLICE_IGNORE_PLAYER` | 565 | 1,148 |
| `SET_PLAYER_WANTED_LEVEL`, `_NOW` | 500, 490 | 8,102, 1,743 |
| `SET_MAX_WANTED_LEVEL` | 387 | 2,157 |
| `SET_WANTED_LEVEL_MULTIPLIER` | 372 | 1,219 |
| `ENABLE_DISPATCH_SERVICE` | 290 | 2,901 |
| `IS_PLAYER_WANTED_LEVEL_GREATER` | 276 | 862 |
| `SET_FAKE_WANTED_LEVEL` | 181 | 427 |
| `CLEAR_PLAYER_WANTED_LEVEL` | 168 | 440 |
| `SET_DISPATCH_COPS_FOR_PLAYER` | 162 | 394 |
| `SUPPRESS_LOSING_WANTED_LEVEL_IF_HIDDEN_THIS_FRAME` | 139 | 250 |
| `SET_CREATE_RANDOM_COPS` | 109 | 348 |
| `GET_WANTED_LEVEL_RADIUS` | 94 | 94 |
| `CLEAR_AREA_OF_COPS` | 62 | 194 |

Missions cap the wanted level (`SET_MAX_WANTED_LEVEL`), switch services off (`ENABLE_DISPATCH_SERVICE` false) and stop random cops spawning for set pieces, then undo it at cleanup.

## 35.5 What police mods replace

| Piece | File or native |
| --- | --- |
| How many and which units come | `dispatch.meta` (`WantedResponses`, vehicle sets) |
| How fast stars rise and fall, search radius, hiding time | `dispatch.meta` thresholds, radii and evasion times |
| How cops search | `dispatchtuning.ymt` |
| Which crimes count and how much | `wantedtuning.ymt`, R3.7 |
| Who reports crimes | `shockingevents.ymt` (`CanCallPolice`, [R17.2](/docs/ai/perception-and-events.md)) |
| Callouts, pursuits and arrests | Script mods using the natives in 35.4 and tasks |

All are data-file replacements in the mods folder ([archives and content](/docs/core/archives-and-content.md)); a script mod can do much of the same at run time with `SET_WANTED_LEVEL_MULTIPLIER`, `SET_MAX_WANTED_LEVEL` and `ENABLE_DISPATCH_SERVICE`.

## 35.6 Open questions

| Question | Where it goes |
| --- | --- |
| The names and values of the 9 crime-info entries | R3.7 |
| How crime points are added per crime | R3.7 |
| The full vehicle sets with model names | Second pass, `dispatch.meta` |

## 35.7 Test cards (story mode)

1. **Hiding time.** Get one star, break line of sight and hide. Expected: the star goes after about 30 s hidden (37.5 s for two stars).
2. **Three stars.** Reach three stars. Expected: a helicopter joins and road blocks appear; no SWAT until four stars.
