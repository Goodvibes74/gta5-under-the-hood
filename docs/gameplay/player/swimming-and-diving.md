# Swimming and diving

How long a player can hold their breath and sprint, what makes a ped drown, how scuba gear is given and what it looks like on each model, how high you can dive from, the edge of the world at sea, and the script hooks for boats and submarines. Roadmap topic **R3.5** in the [roadmap](/ROADMAP.md). Builds on [native usage](/scripting/native-usage.md). Water itself (waves, buoyancy, the water map) is R2.4; health and drowning damage connect to R3.8; the lung capacity and stamina stats are R3.6.

**How it was made.** Data files extracted from `update\update.rpf` with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and converted to XML: `update:/x64/data/tune/playerinfo.ymt`, `motiontasks.ymt` and `movementtasks.ymt`. Native use from the [PED](/scripting/native-usage/PED.md), [PLAYER](/scripting/native-usage/PLAYER.md), [VEHICLE](/scripting/native-usage/VEHICLE.md) and [WATER](/scripting/native-usage/WATER.md) usage pages; the values scripts pass to the underwater-time natives counted with one `git grep -o` over every decompiled script (commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Values and counts are **Verified**; how the engine uses each value is **Known** unless stated.

## Short version

- **Breath: 10 to 40 seconds; stamina: 10 to 90 seconds.** Every character in `playerinfo.ymt` (the three story characters and 5 more entries, 8 in all) has `MinHoldBreathDuration` 10, `MaxHoldBreathDuration` 40, `MinStaminaDuration` 10, `MaxStaminaDuration` 90. The lung capacity and stamina stats move a character between the two (**Known**).
- **After that, you drown.** When breath runs out the ped loses health until it surfaces (**Known**). Scripts read and set what is left with `GET_PLAYER_UNDERWATER_TIME_REMAINING` (4 scripts) and `SET_PLAYER_UNDERWATER_BREATH_PERCENT_REMAINING` (297 scripts, mostly Online content).
- **Scuba is a ped flag plus a costume.** `SET_ENABLE_SCUBA` (9 scripts) turns the gear on; `motiontasks.ymt` lists the scuba outfit (tank and mask components, with lights on and off) for 5 models: `player_zero`, `player_one`, `player_two`, `mp_m_freemode_01`, `mp_f_freemode_01`. Getting out of a submersible gives scuba automatically when `SET_AUTO_GIVE_SCUBA_GEAR_WHEN_EXIT_VEHICLE` is on (64 scripts).
- **Missions remove the breath limit** with `SET_PED_MAX_TIME_UNDERWATER`: of the literal values, 1E+07 seconds (11 calls), 1E+08 (4) and 10,000 (8) mean "unlimited"; −1 (27 calls) puts the default back; 2 seconds (11) is for peds that should drown at once.
- **Diving from a height** is safe from 5 m (6 m for Michael) up to 150 m (`MinDiveHeight`, `MaxDiveHeight`) if the water is deep enough; a high fall into water 1 to 3 m deep is treated as a fall (`HighFallWaterDepthMin` 1, `Max` 3).
- **The sea has an edge.** A player outside X −8,000 to 8,000 or Y −8,000 to 9,000 (`MinWorldLimitsPlayerX` ...) who keeps swimming dies after `MaxTimeToTrespassWhileSwimmingBeforeDeath` = 60 seconds (**Known**: the "sharks get you" rule).
- **Boats and subs** are vehicle natives: `SET_BOAT_ANCHOR` (138 scripts), `TRANSFORM_TO_SUBMARINE` (284 scripts, for the amphibious cars; shared code), `GET_ENTITY_SUBMERGED_LEVEL` (276).

## Where it lives

| File | What it holds | Values (build 3725) |
| --- | --- | --- |
| `update:/x64/data/tune/playerinfo.ymt` | Per-character stat ranges (`PlayerStatInfos`: stamina, breath, wheelie, plane control, plane and heli damping, fall and dive heights) and player-wide values (sprint refill, world limits, swim trespass time) | 8 entries: `PLAYER_0`, `PLAYER_1`, `PLAYER_2` and 5 whose names didn't resolve (**Known**: the Online characters) |
| `update:/x64/data/tune/motiontasks.ymt` | `CTaskMotionSwimming` tunables: struggle time, turning and pitch rates, surface probes, and the scuba outfit per model | 5 models with scuba outfits |
| `update:/x64/data/tune/movementtasks.ymt` | Dive control and falls into water | `DiveControlMaxFallDistance` 100, `HighFallWaterDepthMin` 1, `HighFallWaterDepthMax` 3 |

### Per-character values

| Value | `PLAYER_0` (Michael) | `PLAYER_1` (Franklin) | `PLAYER_2` (Trevor) | Online and others |
| --- | ---: | ---: | ---: | ---: |
| Stamina (s) | 10 to 90 | 10 to 90 | 10 to 90 | 10 to 90 |
| Hold breath (s) | 10 to 40 | 10 to 40 | 10 to 40 | 10 to 40 |
| Fall height without injury (m) | 6 to 8.5 | 6 to 8.5 | 6 to 8.5 | 6 to 8.5 |
| Dive height (m) | 6 to 150 | 5 to 150 | 5 to 150 | 5 to 150 |
| `DiveRampPow` | 2 | 2 | 2 | 2 |

The breath and stamina ranges are the same for everyone; only the stats differ. **Known:** `PLAYER_0`, `_1`, `_2` are Michael, Franklin and Trevor (the order of the story character index everywhere else in the game).

### Player-wide values

| Value | Meaning (**Known**) |
| --- | --- |
| `SprintReplenishFinishedPercentage` 0.2 (bicycle 0.05) | How full the sprint bar must be before you can sprint again after running out |
| `SprintReplenishRateMultiplier` 0.5 (bike 0.25) | How fast it refills |
| `MinWorldLimitsPlayerX/Y` −8,000 / −8,000, `MaxWorldLimitsPlayerX/Y` 8,000 / 9,000 | The playable square |
| `MaxTimeToTrespassWhileSwimmingBeforeDeath` 60 | Seconds you can swim outside it |
| `MinStruggleTime` 1,500, `MaxStruggleTime` 4,000 (ms) | The drowning struggle animation |

## How scripts use it

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `IS_ENTITY_IN_WATER` | 675 | 2,317 | In water at all |
| `IS_PED_SWIMMING_UNDER_WATER`, `IS_PED_SWIMMING` | 380, 373 | 609, 904 | Swimming checks (mission objectives, Online) |
| `SET_PLAYER_UNDERWATER_BREATH_PERCENT_REMAINING` | 297 | 593 | Refill or drain breath |
| `GET_ENTITY_SUBMERGED_LEVEL` | 276 | 359 | How deep an entity is (0 to 1) |
| `SET_PED_DIES_IN_WATER`, `SET_PED_DIES_INSTANTLY_IN_WATER` | 191, 109 | 592, 151 | Whether a ped can drown, or dies at once in water |
| `SET_AUTO_GIVE_SCUBA_GEAR_WHEN_EXIT_VEHICLE` | 64 | 74 | Scuba when leaving a sub (`docks_prep1`, `exile3`, `agency_heist2`, `director_mode`) |
| `IS_PED_DIVING` | 28 | 54 | Diving from height |
| `SET_PED_MAX_TIME_UNDERWATER`, `SET_PED_MAX_TIME_IN_WATER` | 18, 9 | 62, 16 | Breath limit and time in water |
| `SET_SWIM_MULTIPLIER_FOR_PLAYER` | 18 | 86 | Swim speed, 1.0 to 1.49 (**Known** cap) |
| `SET_ENABLE_SCUBA`, `IS_USING_PED_SCUBA_GEAR_VARIATION`, `CLEAR_PED_SCUBA_GEAR_VARIATION` | 9, 10, 8 | 31, 10, 8 | Scuba on and off |
| `GET_PLAYER_UNDERWATER_TIME_REMAINING` | 4 | 6 | Seconds of breath left |
| `RESET_PLAYER_STAMINA`, `GET_PLAYER_SPRINT_STAMINA_REMAINING` | 76, 7 | 95, 14 | Stamina |
| `SET_BOAT_ANCHOR`, `CAN_ANCHOR_BOAT_HERE`, `IS_BOAT_ANCHORED` | 138, 18, 20 | 576, 36, 46 | Boats |
| `TRANSFORM_TO_SUBMARINE`, `IS_VEHICLE_IN_SUBMARINE_MODE` | 284, 9 | 722, 28 | Amphibious cars |

**Verified (values):** the literal times scripts pass to `SET_PED_MAX_TIME_UNDERWATER`: −1 ×27, 2 ×11, 1E+07 ×11, 10,000 ×8, 1E+08 ×4, 60 ×1. To `SET_PED_MAX_TIME_IN_WATER`: 2 ×11, 5 ×2, 60, 300 and 600 once each. Users include `fbi5a` (the chemical plant dive), `docks_heista` and `docks_heistb` (the Merryweather heist), the bail bond missions (targets that drown), `triathlonsp` and `director_mode`.

## What this means for modders

- **Unlimited breath:** `SET_PED_MAX_TIME_UNDERWATER(PLAYER_PED_ID(), 1E+07)` the way missions do it, and `-1` to give the default back. Or keep refilling with `SET_PLAYER_UNDERWATER_BREATH_PERCENT_REMAINING(PLAYER_ID(), 100)`.
- **Scuba gear:** `SET_ENABLE_SCUBA(ped, true)` plus the outfit (`SET_PED_SCUBA_GEAR_VARIATION`) works out of the box only for the five models listed in `motiontasks.ymt`; on other models you get the behaviour without the look (**Known**).
- **Longer breath for every character** is a data edit: raise `MaxHoldBreathDuration` in `playerinfo.ymt` (a binary `.ymt`; convert with CodeWalker and replace through a `dlc_patch` or the mods folder). The stat still scales within the new range.
- **Peds that can't swim:** `SET_PED_DIES_IN_WATER(ped, true)` or `SET_PED_DIES_INSTANTLY_IN_WATER`. Escort missions turn drowning off for allies with `SET_PED_DIES_IN_WATER(ped, false)`.
- **Leaving the map by sea kills you after 60 s.** A mod that adds islands or content beyond ±8,000 has to raise the world limits in `playerinfo.ymt` too (**Known**: this is what map-extension mods change).
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The exact curve from the lung capacity stat to seconds of breath (`DiveRampPow` may be part of it) | Test card 1; R3.6 |
| How fast drowning drains health | Test card 2 |
| What the 5 non-story entries in `PlayerStatInfos` are (their names didn't resolve) | Second pass |
| How the fall heights combine with ragdoll and fall damage | R2.3 |
| Swim speed from the stamina and lung stats | R3.6 |

## Test cards

1. **Breath.** As each character, dive and stay under; time from going under to the first health loss. Expected: between 10 and 40 seconds, longer with a higher lung capacity stat.
2. **Drowning.** Stay under after the breath runs out and log `GET_ENTITY_HEALTH` each second. Expected: steady health loss until 100 (death).
3. **Scuba on a non-player model.** Switch to an ambient ped model and call `SET_ENABLE_SCUBA(PLAYER_PED_ID(), true)`. Expected: unlimited breath but no tank visible.
4. **The edge.** Take a boat to X 8,100 and swim. Expected: death about 60 seconds after leaving the limits.
