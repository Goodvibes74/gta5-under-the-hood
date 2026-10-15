# Perception and events

How peds notice things and turn them into reactions: the event system, the 48 "shocking" events with their sight and hearing ranges, lifetimes, reaction sizes and whether they make peds call the police, the general and weapon event tunables, and how Rockstar's scripts block, add and suppress events. Roadmap topic **R17.2** in the [roadmap](/ROADMAP.md). The perception profiles in `pedperception.meta` (default 60 m sight and hearing, a 180° field) are already in [combat and perception](/docs/ai/combat-and-perception.md) (R3.2); this page covers the events. Builds on [decisions and personalities](/docs/ai/decisions-and-personalities.md) (R17.3) and [relationships and groups](/docs/ai/relationships-and-groups.md) (R17.4).

**How it was made.** `update\update.rpf\x64\data\tune\shockingevents.ymt`, `generalevents.ymt` and `weaponevents.ymt` of build 1.0.3725.0 (extracted with [`tools/rpf-cw.ps1`](/tools/README.md), read as XML). The shocking-event entries are stored under hashed names; 44 of 48 were named by hashing `CEventShocking<Name>` for the event names known from NativeDB and matching. Native counts from [native usage](/scripting/native-usage.md) (decompile commit `6c18d3e8b`). Values and counts are **Verified**; how the engine routes events through decision makers is **Known**.

## 33.1 Short version

- **Events are messages to nearby peds:** something happens (a gunshot, a crash, a dead body), the engine creates an event with a position and source, and every ped that can sense it (by sight or hearing, within range) gets it; its decision maker turns it into a response (watch, flee, film, fight, call the police) ([R17.3](/docs/ai/decisions-and-personalities.md), **Known**).
- **48 shocking events** are tuned in `shockingevents.ymt`, each with a visual range, an audio range, a lifetime, a reaction size (18 big, 24 small, 6 none) and a priority; **8 make witnesses call the police**: explosion, fire, gunfight, gunshot fired, ped run over, seen car stolen, seen ped killed and one unnamed event (seen vehicle towed, by its speech line).
- **The loudest:** gunfight heard at 140 m (seen 60 m), gunshot fired heard 100 m (seen 45 m), explosion 80/80 m, the studio bomb 85/90 m; **the quietest:** a weird ped (seen at 4 m), a nice car (8 m, not heard), a confrontation (5 m).
- **Peds film on their phones:** half of watching peds film an event (`ChanceOfFilmingEventOnPhoneIfWatching` 0.5 in the base entry), for 4 to 8 seconds.
- **Scripts mostly block events:** `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` is in 627 scripts (7,232 calls), so mission peds ignore the world and follow their tasks; `SET_PED_CONFIG_FLAG` (694 scripts, 36,119 calls) and `SET_PED_RESET_FLAG` (489) tune the rest.
- **Scripts add shocking events** to make crowds react (`ADD_SHOCKING_EVENT_FOR_ENTITY` 110 scripts, `_AT_POSITION` 19), remove them (26) or suppress them for a frame (24); the player can be ignored entirely (`SET_EVERYONE_IGNORE_PLAYER` 219 scripts, `SET_POLICE_IGNORE_PLAYER` 565).

## 33.2 The shocking events

From `shockingevents.ymt` (**Verified**). Ranges in metres, lifetime in seconds; "police" = `CanCallPolice`. Sorted by audio range:

| Event | Seen at | Heard at | Lifetime | Reaction | Police | Priority |
| --- | ---: | ---: | ---: | --- | --- | ---: |
| `GunFight` | 60 | 140 | 15 | BIG_REACTION | yes | 4 |
| `GunshotFired` | 45 | 100 | 7 | BIG_REACTION | yes | 4 |
| `StudioBomb` | 85 | 90 | 1000 | BIG_REACTION |  | 4 |
| `Explosion` | 80 | 80 | 15 | BIG_REACTION | yes | 4 |
| `CarPileUp` | 35 | 35 | 10 | SMALL_REACTION |  | 3 |
| `CarCrash` | 35 | 35 | 3 | SMALL_REACTION |  | 3 |
| `CarChase` | 35 | 35 | 4 | NO_REACTION |  | 1 |
| `BicycleCrash` | 35 | 35 | 3 | SMALL_REACTION |  | 3 |
| `Siren` | 0 | 30 | 3 | NO_REACTION |  | 0 |
| `PlaneFlyby` | 30 | 30 | 0 | SMALL_REACTION |  | 1 |
| `PedShot` | 30 | 30 | 2 | BIG_REACTION |  | 4 |
| `CarAlarm` | 0 | 30 | 0 | NO_REACTION |  | 0 |
| `hash_079D1299` | 25 | 25 | 3 | SMALL_REACTION |  | 1 |
| `PropertyDamage` | 25 | 25 | 3 | SMALL_REACTION |  | 1 |
| `PedRunOver` | 25 | 25 | 5 | BIG_REACTION | yes | 4 |
| `PedKnockedIntoByPlayer` | 25 | 25 | 3 | NO_REACTION |  | 1 |
| `ParachuterOverhead` | 45 | 25 | 5 | SMALL_REACTION |  | 1 |
| `HelicopterOverhead` | 25 | 25 | 0 | SMALL_REACTION |  | 2 |
| `MadDriverExtreme` | 25 | 22 | 4 | BIG_REACTION |  | 2 |
| `hash_F138B835` | 25 | 20 | 0 | BIG_REACTION |  | 3 |
| `SeenPedKilled` | 40 | 20 | 3 | BIG_REACTION | yes | 4 |
| `SeenCarStolen` | 25 | 20 | 10 | BIG_REACTION | yes | 2 |
| `HornSounded` | 0 | 20 | 1 | SMALL_REACTION |  | 1 |
| `hash_F0424EAA` | 15 | 15 | 5 | SMALL_REACTION |  | 2 |
| `InjuredPed` | 20 | 15 | 4 | BIG_REACTION |  | 3 |
| `EngineRevved` | 15 | 15 | 2 | SMALL_REACTION |  | 1 |
| `DangerousAnimal` | 30 | 15 | 0 | BIG_REACTION |  | 3 |
| `MadDriver` | 11 | 11 | 4 | BIG_REACTION |  | 2 |
| `SeenInsult` | 10 | 10 | 5 | SMALL_REACTION |  | 1 |
| `SeenGangFight` | 20 | 10 | 6 | BIG_REACTION |  | 2 |
| `NonViolentWeaponAimedAt` | 10 | 10 | 0 | SMALL_REACTION |  | 2 |
| `MadDriverBicycle` | 12 | 10 | 4 | SMALL_REACTION |  | 0 |
| `Fire` | 20 | 10 | 2 | BIG_REACTION | yes | 4 |
| `CarOnCar` | 12 | 10 | 0.5 | BIG_REACTION |  | 3 |
| `SeenConfrontation` | 5 | 5 | 5 | NO_REACTION |  | 1 |
| `RunningStampede` | 20 | 5 | 0 | SMALL_REACTION |  | 0 |
| `RunningPed` | 20 | 5 | 0 | SMALL_REACTION |  | 0 |
| `DrivingOnPavement` | 20 | 5 | 1 | BIG_REACTION |  | 2 |
| `BicycleOnPavement` | 10 | 5 | 1 | NO_REACTION |  | 0 |
| `WeirdPedApproaching` | 5 | 4 | 0 | SMALL_REACTION |  | 2 |
| `SeenMeleeAction` | 20 | 4 | 3 | SMALL_REACTION |  | 1 |
| `PotentialBlast` | 25 | 3 | 1 | SMALL_REACTION |  | 4 |
| `DeadBody` | 14 | 3 | 0 | SMALL_REACTION |  | 1 |
| `hash_BB1A793C` | 10 | 0 | 10 | SMALL_REACTION | yes | 4 |
| `WeirdPed` | 4 | 0 | 0 | SMALL_REACTION |  | 1 |
| `WeaponThreat` | 20 | 0 | 3 | SMALL_REACTION |  | 4 |
| `VisibleWeapon` | 10 | 0 | 0 | BIG_REACTION |  | 1 |
| `SeenNiceCar` | 8 | 0 | 10 | SMALL_REACTION |  | 0 |

The first unnamed entry (`hash_079D1299`) has all the default values and is *probably* the shared base. Each entry also sets how long peds watch (1 to 2 s in the base), whether they hurry away, the speech line they say (`ShockingSpeechHash`, mostly `EVENT_SHOCKING_*` contexts, [speech and dialogue](/docs/audio/speech-and-dialogue.md)), whether nearby traffic slows or avoids, and whether the area blocks ped spawning for a while (`AddPedGenBlockedArea`).

## 33.3 Other events

From `generalevents.ymt` and `weaponevents.ymt` (**Verified**; each tunes the delay before peds respond):

| Event | Values |
| --- | --- |
| `CEventGunAimedAt` | Respond after 0.1 to 0.15 s |
| `CEventGunShot` | 0.2 to 0.5 s; shots within 2 m count as the same |
| `CEventMeleeAction` | 0.2 to 0.5 s |
| `CEventPedJackingMyVehicle` | 0 to 0.5 s |
| `CEventRequestHelp` | 0.1 to 0.4 s; fist fights heard up to 10 m without a radio |
| `CEventCrimeCryForHelp` | Up to 50 m; delay grows with distance (5 to 50 m), plus 0.3 to 0.6 s |
| `CEventAgitated` | Lives 1 s; ambient reaction 15 m around |
| `CEventRespondedToThreat` | 0.3 to 0.6 s |
| `CEventSuspiciousActivity`, `CEventEncroachingPed` | Same-event radius 1 m |

## 33.4 What scripts do

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SET_PED_CONFIG_FLAG` | 694 | 36,119 | Per-ped behaviour switches (many are about events) |
| `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` | 627 | 7,232 | Ped ignores events and keeps its task |
| `SET_PED_CAN_BE_TARGETTED` | 603 | 1,866 | |
| `SET_POLICE_IGNORE_PLAYER` | 565 | 1,148 | |
| `SET_PED_RESET_FLAG` | 489 | 9,969 | One-frame behaviour switches |
| `SET_PED_KEEP_TASK` | 486 | 2,280 | Keep the task after the script lets go |
| `SET_EVERYONE_IGNORE_PLAYER` | 219 | 458 | |
| `HAS_ENTITY_CLEAR_LOS_TO_ENTITY` | 188 | 431 | Script line-of-sight checks |
| `SET_PED_SEEING_RANGE`, `SET_PED_HEARING_RANGE` | 185, 151 | 524, 393 | Change perception per ped |
| `SET_PED_VISUAL_FIELD_CENTER_ANGLE` (and min, max, peripheral) | 112 | 211 | Stealth missions |
| `ADD_SHOCKING_EVENT_FOR_ENTITY`, `_AT_POSITION` | 110, 19 | 122, 21 | Make crowds react |
| `IS_TARGET_PED_IN_PERCEPTION_AREA` | 109 | 168 | |
| `TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` | 72 | 571 | Same, inside a task sequence |
| `SET_PLAYER_STEALTH_PERCEPTION_MODIFIER` | 61 | 61 | How hard the player is to notice |
| `REMOVE_SHOCKING_EVENT`, `SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME` | 26, 24 | 37, 27 | |

Scripts can also read events from the queue (`GET_EVENT_AT_INDEX`, 265 scripts), mostly for damage and network events ([sessions and sync](/docs/online/sessions-and-sync.md)).

## 33.5 What this means for modders

- **A ped that must follow its task** (a bodyguard, a driver in a scene) needs `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)`, as in 627 of Rockstar's scripts; otherwise the first gunshot within 100 m pulls it away.
- **To make a street react** to something a mod does, add a shocking event (`ADD_SHOCKING_EVENT_AT_POSITION`) of the right type; the table in 33.2 tells you how far it carries.
- **Fewer police calls:** events with "police" in 33.2 are what bring cops; a mod that changes `CanCallPolice` in `shockingevents.ymt` changes how quickly crimes are reported.
- **Stealth mods** combine `SET_PED_SEEING_RANGE`, the visual-field natives and `SET_PLAYER_STEALTH_PERCEPTION_MODIFIER`.

## 33.6 Open questions

| Question | Where it goes |
| --- | --- |
| The three other unnamed shocking events | Second pass, more name guesses |
| Which `SET_PED_CONFIG_FLAG` numbers scripts set most, and what they do | Second pass, R17.10 |
| How decision makers map each event to a response | R17.3 second pass |

## 33.7 Test cards (story mode)

1. **Gunshot range.** Fire a pistol 90 m from a group of peds out of sight. Expected: they react (heard up to 100 m). At 120 m they shouldn't.
2. **Blocking.** Give a ped a wander task with `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS` true and fire near it. Expected: it keeps walking.
