# Random events

How GTA V's story-mode random events (the stranger who needs a lift, the ATM robbery, the security van) are placed in the world, how they launch, the shared check every one of them runs before starting (speed, height, cooldowns, unlocks, character), and the list of events with where they can happen. Roadmap topic **R4.4** in the [roadmap](/ROADMAP.md). Builds on the [script launch graph](/scripting/script-launch-graph.md) (world brains), [runtime scripts](/docs/core/runtime-scripts.md) and the [story script catalog](/docs/gameplay/missions/story-script-catalog.md).

**How it was made.** `common:/data/levels/gta5/ambient.ipl` (the world brain points) extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and its `re_*` entries counted. The `re_*` scripts listed from the build-3725 decompile (commit `6c18d3e8b`); the shared launch check read in `re_abandonedcar` (the same helper is compiled into every random event). Native use from the [BRAIN](/scripting/native-usage/BRAIN.md) and [MISC](/scripting/native-usage/MISC.md) usage pages. Build 1.0.3725.0 Legacy. Script behaviour and counts are **Verified**; what the global flags hold is described from their use and is **Known** where it says so.

## Short version

- **38 `re_*` scripts** in build 3725 (the roadmap row says 41).
- **Events are world brains:** `ambient.ipl` places 105 points that name a random event script (46 different names). When the player comes into a point's activation range, the engine starts that script (**Known**: the brain mechanism; the points are **Verified**). Most events have one point; `re_atmrobbery` and `re_pickpocket` have 16 each, `re_securityvan` 10, `re_hitch_lift` and `re_chasethieves` 4.
- **12 names in `ambient.ipl` have no script** (`re_pickpocket`, `re_squeegeeman`, `re_seizure`, `re_car_chase`, `re_heli_chase`, `re_petrol_rob`, `re_mountainbike` ...): cut events whose points were left in the map. **4 scripts have no point** (`re_armybase`, `re_prison`, `re_lossantosintl`, `re_yetarian`); they are area scripts started another way.
- **Every event runs the same gate before it starts.** It refuses if random events are switched off, the player is moving faster than 37 m/s (`VMAG2(velocity) > 1369`), the player is more than 50 m above the point, a mission or another random event is running (`GET_MISSION_FLAG`, `GET_RANDOM_EVENT_FLAG`), less than **150 seconds** have passed since the last random event (except event 30), the event isn't unlocked yet (a bit per event in the save), its own cooldown (a game time saved per event) hasn't passed, the current character isn't allowed (some events are Trevor-only), or the player is inside one of three interiors.
- **Many add their own rules:** `re_abandonedcar` only runs between 19:00 and 07:00; the events check the wanted level before each step and end if the player leaves the activation range.
- **The flags:** `SET_RANDOM_EVENT_FLAG` (35 scripts) marks a running event so nothing else starts; `SET_MISSION_FLAG` (200 scripts) does the same for missions.

## Where it lives

| File or script | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/levels/gta5/ambient.ipl` | World brain points: position, brain type, orientation, script name | 105 random event points (of 298 points in the file), 46 event names |
| `ambient_leeds.ipl`, `ambient_sd.ipl` | More world brain points for other ambient scripts | |
| `re_*.c` (decompile) | One script per event | 38 |
| The save (`Global_114904.f_25002` in build 3725) | Per event: unlock bit, next allowed time, completion | Decompiler names are pointers for this build only |

### Points per event

| Event | Points | | Event | Points |
| --- | ---: | --- | --- | ---: |
| `re_atmrobbery` | 16 | | `re_burials` | 1 |
| `re_pickpocket` (no script) | 16 | | `re_bus_tours` | 1 |
| `re_securityvan` | 10 | | `re_crashrescue` | 1 |
| `re_hitch_lift` | 4 | | `re_cultshootout` | 1 |
| `re_chasethieves` | 4 | | `re_dealgonewrong` | 1 |
| `re_muggings` | 3 | | `re_domestic` | 1 |
| `re_bikethief` | 3 | | `re_duel` | 1 |
| `re_border` | 3 | | `re_gang_intimidation` | 1 |
| `re_rc_checkpoints` (no script) | 3 | | `re_gangfight` | 1 |
| `re_abandonedcar` | 2 | | `re_getaway_driver` | 1 |
| `re_arrests` | 2 | | `re_homeland_security` | 1 |
| `re_cartheft` | 2 | | `re_lured` | 1 |
| `re_drunkdriver` | 2 | | `re_monkey` | 1 |
| `re_prisonerlift` | 2 | | `re_mountdance` | 1 |
| `re_shoprobbery` | 2 | | `re_paparazzi` | 1 |
| `re_accident` | 1 | | `re_prisonvanbreak` | 1 |
| | | | `re_rescuehostage`, `re_seaplane`, `re_snatched`, `re_stag_do` | 1 each |

Points with no script: `re_pickpocket` 16, `re_rc_checkpoints` 3, and one each for `re_squeegeeman`, `re_seizure`, `re_shootingmovies`, `re_car_chase`, `re_heli_chase`, `re_daddyscar`, `re_raildrunk`, `re_cultrescue`, `re_petrol_rob`, `re_mountainbike`. **Known:** the engine skips a point whose script doesn't exist.

## The launch check, step by step

**Verified** (the shared helper in `re_abandonedcar`, called with the event's own index):

1. Random events must be enabled (a global switch the flow sets) and the save's "random events allowed" flag must be on.
2. **Speed:** the player's speed squared must not exceed 1,369 (37 m/s, about 133 km/h), unless a special case applies.
3. **Height:** the player must not be more than 50 m above the point.
4. **Unlock:** the event's bit must be set in the save (events 0 to 30 in one word, 31 and up in a second); events 31 and 32 need an extra condition.
5. **Character:** some events are tied to a character (event 18 only runs for character 2, Trevor; event 19 for anyone but Trevor).
6. **Cooldown:** the event's saved "next allowed" time must have passed.
7. **Gap:** at least 150,000 ms since the last random event ended, except for event 30.
8. **Nothing else running:** no mission flag, no random event flag, no other blocking state (the player switching, a cutscene, a phone call).
9. **Not inside** the three interiors checked by coordinates (around 377, −717; 321, 265; −1426, −244).
10. **Event 30 nearby:** while event 30 is available and not done, no other event starts within 420 m of −61, −1100 (the area of Simeon's dealership, **Known**).

If any test fails the script ends at once and the brain waits until the player leaves and comes back (`REACTIVATE_NAMED_WORLD_BRAINS_WAITING_TILL_OUT_OF_RANGE`, 52 scripts).

## While an event runs

**Verified (`re_abandonedcar`):** it sets its own time window (here only before 07:00 and after 19:00), then loops: it stays alive while `IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE()` is true and the player has no wanted level, marks the moment for the Rockstar Editor (`REPLAY_CHECK_FOR_EVENT_THIS_FRAME("RE_AV", 0)`), and steps through its stages. On force cleanup or when the player leaves, it cleans up and records the event's next allowed time.

## What this means for modders

- **Don't start Rockstar's events from a script** without their parameters: they expect the world point's position passed in by the brain (`ScriptParam_0`). Let the brain start them.
- **Blocking events:** while your mod runs a scene, `SET_RANDOM_EVENT_FLAG(true)` keeps random events from starting (they check `GET_RANDOM_EVENT_FLAG`); clear it when done.
- **Your own random event** can follow the same pattern: a world brain point (an add-on `ambient`-style placement, or a script that watches distance), a gate with a gap timer and a cooldown, and a clean exit when the player leaves.
- **The missing scripts are not bugs to fix:** the 12 points without scripts are leftovers; adding scripts with those names would make them fire.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The event index of each script, and the full character and time rules per event | Second pass: the index each script passes to the check |
| How long each event's cooldown is | Second pass: read where each script writes its next allowed time |
| How `re_armybase`, `re_prison`, `re_lossantosintl` and `re_yetarian` are started | Second pass: [launch graph](/scripting/script-launch-graph.md) |
| When each event is unlocked (story progress) | R5.1 second pass |
| The world brain activation range and how the engine picks between nearby points | Test card 2 |

## Test cards

1. **Gap.** Finish a random event, then drive straight to another event's point. Expected: nothing for 2.5 minutes, then it can start.
2. **Speed.** Drive past an ATM robbery point at full speed in a supercar, then walk past. Expected: it starts only when you are slow.
3. **Night only.** Visit an abandoned-car point at noon and at 22:00. Expected: only at night.
