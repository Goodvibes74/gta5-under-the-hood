# Time, weather and wind

How the game clock runs, where the weather types are defined, how the game picks the next weather, what wind does, and how scripts (Rockstar's and yours) lock the time and weather and then hand them back. Roadmap topic **R2.6** in the [roadmap](/ROADMAP.md). Builds on [native usage](/scripting/native-usage.md) (the counts below come from its tables) and [archives and content](/docs/core/archives-and-content.md) (where the files live). The look of each weather (the timecycle files and modifiers) belongs to R13.2; this page only says how they are wired to weather.

**How it was made.** Data files extracted from `common.rpf` and `update\update.rpf` with [`tools/rpf-cw.ps1`](/tools/README.md) and compared (the `update.rpf` copy wins): `common:/data/levels/gta5/weather.xml`, `common:/data/cloudkeyframes.xml`, `common:/data/clouds.xml`, `common:/data/branchbend_windsettings.xml`, the `w_*.xml` files in `common:/data/timecycle/`. Native use from the [CLOCK](/scripting/native-usage/CLOCK.md), [MISC](/scripting/native-usage/MISC.md), [NETWORK](/scripting/native-usage/NETWORK.md) and [GRAPHICS](/scripting/native-usage/GRAPHICS.md) usage pages. Weather names passed to the weather natives counted with one `git grep -o` over every decompiled script (literal string arguments only; arguments held in variables are not counted). Script behaviour read in `respawn_controller`, `cheat_controller`, `savegame_bed`, `golf` and `exile1`. Build 1.0.3725.0 Legacy, decompile commit `6c18d3e8b`. Values, counts and script behaviour are **Verified**; what the engine does internally (cycle timing, wind physics) is **Known** unless stated.

## Short version

- **17 weather types** live in `weather.xml` (14 in the base file; the update copy adds `HALLOWEEN`, `RAIN_HALLOWEEN` and `SNOW_HALLOWEEN`). Each one sets sun, cloud, wind range, rain, snow, fog, lightning, the sea state, its rain or snow particle system, its timecycle file (`W_<NAME>.XML`) and its cloud set.
- **The natural weather is a fixed list,** not a dice roll: `WeatherCycles` holds 173 entries with a total `TimeMult` of 384. By weight the world is `CLEAR` 32.0%, `SMOG` 26.8%, `EXTRASUNNY` 22.7%, `CLOUDS` 7.3%, `OVERCAST` 6.0%, `FOGGY` 2.1%, `THUNDER` 1.6%, `RAIN` 0.8% and `CLEARING` 0.8% of the time. Snow, `XMAS`, `NEUTRAL` and the Halloween types never come up by themselves.
- **Rain is rare.** Wet weather (`RAIN`, `THUNDER`, `CLEARING`) is 3.1% of the cycle by weight. A mod that wants storms has to ask for them.
- **The clock is a script-visible counter.** 16 `CLOCK` natives; `GET_CLOCK_HOURS` is read by 568 scripts. Only 88 scripts set the time (`SET_CLOCK_TIME`), 16 pause it, and sleeping in a save bed adds 6, 8 or 12 hours.
- **Scripts lock weather in two ways.** Persistent lock: `SET_WEATHER_TYPE_NOW_PERSIST` (69 scripts) or a timed blend `SET_WEATHER_TYPE_OVERTIME_PERSIST` (180 scripts), released by `CLEAR_WEATHER_TYPE_PERSIST` (154 scripts). Override (mostly Online): `SET_OVERRIDE_WEATHER` (36) and `CLEAR_OVERRIDE_WEATHER` (37).
- **`EXTRASUNNY` is the default reset.** It is the name passed most often (183 of 459 literal weather arguments), and `respawn_controller` forces it when leaving the prologue. After a death or arrest, `respawn_controller` clears any weather lock and timecycle modifier and calls `SET_RANDOM_WEATHER_TYPE` (its only caller in the game).
- **Wind is a per-weather range** (`WindMin` to `WindMax`, 0.0 to 1.0) that drives tree sway, rain and mist particles and sea waves. Only 18 scripts set wind (`SET_WIND`); golf is the main reader and writes its own simulated wind back into the world.
- **Online runs its own clock and weather.** Missions override the time (`NETWORK_OVERRIDE_CLOCK_TIME`, 125 scripts) and the clock speed (`NETWORK_OVERRIDE_CLOCK_RATE`, 94 scripts) and clear the override after (`NETWORK_CLEAR_CLOCK_TIME_OVERRIDE`, 123 scripts).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/levels/gta5/weather.xml` | Three lists: `WeatherGpuFx` (rain, snow and mist particle systems), `WeatherTypes`, `WeatherCycles` | 24 GPU effects (rain storm, thunder, snow, blizzard, underwater, and ambient ones such as `DESERT_GROUND`, `LAKE_FOG_DROP`, `WOODLAND_FIREFLY_DROP`), 17 types, 173 cycle entries |
| `common:/data/levels/gta5/weather/*.xml` | Emitter and render settings for each GPU effect (`rainstorm_emitter_drop`, `thunder_render_mist` ...) | 52 files in the base copy, 1 replaced by the update |
| `common:/data/timecycle/w_<name>.xml` | The look of each weather through the day: 380 variables per region, 2 regions (`GLOBAL`, `URBAN`), 13 keyframes across the day per variable | 14 base files plus `underwater_deep.xml`; the update replaces 11 and adds the 3 Halloween ones |
| `common:/data/cloudkeyframes.xml` | Cloud sets by time of day: which cloud hats show and how likely each is | 8 sets: `LIGHTclouds`, `MEDIUMclouds`, `HEAVYclouds`, `STORMclouds`, `POSTRAINclouds`, `SNOWclouds`, `HALLOWEENclouds`, `default` |
| `common:/data/clouds.xml` | The cloud hats themselves (layers of sky models) | 20 hats (`Cloudy 01`, `Stormy 01`, `Contrails`, `Cirrus`, `shower` ...) |
| `common:/data/branchbend_windsettings.xml` | How trees and plants bend in wind (`umHighWind 3.5`, `WindSpeedSoftClamp 20.0`) | 1 file, plus an `sfx` variant for the sound |
| `common:/data/visualsettings.dat` | Rain particle count and look (`rain.NumberParticles 16384`, `rain.gravity.z -0.98`) | Rows starting `rain.` and `raincollision.` |
| `common:/data/effects/vfxlightningsettings.xml` | Lightning flashes and bolts | 1 file (base only) |

### The weather types

Values from the update copy of `weather.xml`. Sun, cloud, rain, snow and fog are 0 to 1. Wave is `OceanWaveAmplitude` (how rough the sea is).

| Type | Sun | Wind min to max | Rain | Snow | Fog | Lightning | Wave | Particles | Clouds |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `EXTRASUNNY` | 1.0 | 0.25 to 1.0 | 0 | 0 | 0 | no | 3.56 | none | `LIGHTclouds` |
| `CLEAR` | 0.8 | 0.3 to 0.8 | 0 | 0 | 0 | no | 3.56 | none | `LIGHTclouds` |
| `CLOUDS` | 0.5 | 0.2 to 0.7 | 0 | 0 | 0 | no | 3.56 | none | `MEDIUMclouds` |
| `SMOG` | 0.9 | 0.2 to 0.8 | 0 | 0 | 0 | no | 3.56 | none | `MEDIUMclouds` |
| `FOGGY` | 0.8 | 0.2 to 0.7 | 0 | 0 | 1.0 | no | 3.56 | none | `MEDIUMclouds` |
| `OVERCAST` | 0.3 | 0.2 to 0.7 | 0 | 0 | 0 | no | 3.56 | none | `HEAVYclouds` |
| `RAIN` | 0.1 | 0.4 to 1.0 | 1.0 | 0 | 0 | no | 2.03 | `RAINSTORM_DROP` | `HEAVYclouds` |
| `THUNDER` | 0.0 | 0.7 to 1.0 | 1.0 | 0 | 0 | yes | 2.03 | `THUNDER_DROP` | `STORMclouds` |
| `CLEARING` | 0.2 | 0.8 to 1.0 | 0.2 | 0 | 0 | no | 3.56 | `RAINSTORM_DROP` | `POSTRAINclouds` |
| `NEUTRAL` | 0.5 | 0 to 0 | 0.2 | 0 | 0 | no | 3.56 | `RAINSTORM_DROP` | `STORMclouds` |
| `SNOW` | 0.2 | 0.05 to 0.15 | 0 | 0.5 | 0.5 | no | 0.5 | `VFX_SNOW_HEAVY_DROP` | `SNOWclouds` |
| `BLIZZARD` | 0.2 | 0.25 to 0.30 | 0 | 1.0 | 0.8 | no | 0.5 | `BLIZZARD_DROP` | `SNOWclouds` |
| `SNOWLIGHT` | 1.0 | 0 to 0 | 0 | 0.3 | 0 | no | 0.5 | `VFX_SNOW_LIGHT_DROP` | `default` |
| `XMAS` | 1.0 | 0 to 0 | 0 | 0.3 | 0 | no | 0.5 | `VFX_SNOW_LIGHT_DROP` | `SNOWclouds` |
| `HALLOWEEN` | 0.1 | 0.4 to 1.0 | 1.0 | 0 | 0 | yes | 2.03 | `RAINSTORM_DROP` | `HALLOWEENclouds` |
| `RAIN_HALLOWEEN` | 0.1 | 0.4 to 1.0 | 1.0 | 0 | 0 | yes | 2.03 | `RAINSTORM_DROP` | `HALLOWEENclouds` |
| `SNOW_HALLOWEEN` | 1.0 | 0.2 to 0.4 | 0 | 0.3 | 0.5 | yes | 0.5 | `VFX_SNOW_LIGHT_DROP` | `HALLOWEENclouds` |

Two things stand out. Rough seas come with calm weather: the sun types have the highest wave amplitude (3.56) and the rain types a lower one (2.03), with other sea values (`OceanWaveMaxAmplitude`, `DeepOceanScale`) changing as well. And the snow types turn the sea down to 0.5 (**Verified** values; how they combine is **Known** to be the water system's business, R2.4).

## How the weather changes

### The cycle

**Verified (data):** `WeatherCycles` is an ordered list of 173 entries, each a weather name and a `TimeMult` from 1 to 5. The list starts `EXTRASUNNY` ×2, `CLEAR` ×1, `SMOG` ×4. Summed per type:

| Type | Entries | Total `TimeMult` | Share of the cycle |
| --- | ---: | ---: | ---: |
| `CLEAR` | 36 | 123 | 32.0% |
| `SMOG` | 43 | 103 | 26.8% |
| `EXTRASUNNY` | 56 | 87 | 22.7% |
| `CLOUDS` | 11 | 28 | 7.3% |
| `OVERCAST` | 13 | 23 | 6.0% |
| `FOGGY` | 6 | 8 | 2.1% |
| `THUNDER` | 3 | 6 | 1.6% |
| `RAIN` | 3 | 3 | 0.8% |
| `CLEARING` | 2 | 3 | 0.8% |

The base copy in `common.rpf` has the same 173 entries; the update only added the Halloween types and replaced one particle file.

**Known (engine):** the game walks this list in order, staying on each entry for a length of time scaled by its `TimeMult` and blending into the next one, so the previous and next weather are always defined. Scripts read them with `GET_PREV_WEATHER_TYPE_HASH_NAME` (35 scripts), `GET_NEXT_WEATHER_TYPE_HASH_NAME` (10), `IS_PREV_WEATHER_TYPE` (13) and `IS_NEXT_WEATHER_TYPE` (11), and the blend with `GET_CURR_WEATHER_STATE` (146 scripts: previous type, next type and how far through the blend). The base length of one `TimeMult` unit is not in the file (open question). In Online every player in the session must see the same weather, so the position in the cycle is taken from network time (**Known**).

### What scripts do to it

| Native | Scripts | Calls | What Rockstar uses it for |
| --- | ---: | ---: | --- |
| `SET_WEATHER_TYPE_OVERTIME_PERSIST` | 180 | 303 | Blend to a weather over N seconds and keep it there (missions, Online jobs). Of the literal blend times, 30 s is the most common (15 calls), then 20 s (7) and 10 s (6) |
| `CLEAR_WEATHER_TYPE_PERSIST` | 154 | 185 | Release the lock: the cycle takes over again |
| `GET_CURR_WEATHER_STATE` | 146 | 156 | Read previous, next and blend amount (`exile1`, for example, stores all three) |
| `SET_WEATHER_TYPE_NOW_PERSIST` | 69 | 322 | Switch at once and keep it (cutscenes, mission starts, cheats) |
| `SET_OVERRIDE_WEATHER` / `CLEAR_OVERRIDE_WEATHER` | 36 / 37 | 76 / 89 | A separate override layer, mostly in Online job controllers and creators (`SET_OVERRIDE_WEATHEREX`, 20 scripts, is the newer form) |
| `SET_RAIN` | 21 | 52 | Rain amount on its own, without changing type (Online job controllers) |
| `SET_WEATHER_TYPE_PERSIST` | 11 | 13 | Keep the next weather the cycle reaches (some story missions) |
| `FORCE_LIGHTNING_FLASH` | 10 | 20 | A single flash for drama (a Trevor mission, `freemode`, Online content) |
| `SET_WEATHER_TYPE_NOW` | 7 | 30 | Switch at once without locking (the end credits, `family3`, the finale) |
| `SET_CURR_WEATHER_STATE` | 5 | 5 | Restore a saved previous/next/blend state (`director_mode`, `initial`, `maintransition`, `animal_controller`) |
| `SET_RANDOM_WEATHER_TYPE` | 1 | 1 | Pick a random point in the cycle (`respawn_controller` only) |
| `LOAD_CLOUD_HAT` / `UNLOAD_ALL_CLOUD_HATS` | 48 / 60 | 50 / 68 | Force a cloud hat for a scene, then go back to the weather's own clouds |
| `WATER_OVERRIDE_SET_*` | 8 to 11 | | Set sea values directly (calm water for `docks_heista`, `director_mode`) |

Which weather names scripts ask for (459 literal string arguments to the `SET_WEATHER_TYPE_*` and `SET_OVERRIDE_WEATHER` natives): `EXTRASUNNY` 183, `CLEAR` 59, `THUNDER` 49, `OVERCAST` 28, `SMOG` 25, `RAIN` 25, `CLOUDS` 25, `FOGGY` 19, `RAIN_HALLOWEEN` 18, `HALLOWEEN` 17, `XMAS` 3, `CLEARING` 3, `SNOWLIGHT` 2, and `SNOW`, `NEUTRAL` and `BLIZZARD` once each. Scripts ask for thunder 49 times though the cycle almost never reaches it: storms are a mission choice.

**Verified (scripts):**

- **The pattern in a mission:** blend to the mission's weather with `SET_WEATHER_TYPE_OVERTIME_PERSIST` (or switch behind a fade with `SET_WEATHER_TYPE_NOW_PERSIST`), and at cleanup call `CLEAR_WEATHER_TYPE_PERSIST` so the cycle resumes. The lock and the release are close in number (180 + 69 scripts lock, 154 release) because shared cleanup code does the release. **Known:** a script that ends without its cleanup leaves the weather locked until something else clears it, such as the next death.
- **After death or arrest:** `respawn_controller`, in the function that runs when the respawn starts (the same code turns on `SET_FADE_OUT_AFTER_DEATH` and `SET_FADE_OUT_AFTER_ARREST`), calls `CLEAR_WEATHER_TYPE_PERSIST`, `CLEAR_TIMECYCLE_MODIFIER` and `SET_RANDOM_WEATHER_TYPE` unless a global flag tells it not to, then `UNLOAD_ALL_CLOUD_HATS`. So dying in story mode is a weather reroll.
- **Leaving the prologue:** `respawn_controller` sets `EXTRASUNNY` with `SET_WEATHER_TYPE_NOW_PERSIST` and at once clears the lock (story) or uses `SET_OVERRIDE_WEATHER("EXTRASUNNY")` (Online session).
- **The weather cheat:** `cheat_controller` steps through `EXTRASUNNY`, `CLEAR`, `CLOUDS`, `SMOG`, `OVERCAST`, `RAIN`, `THUNDER`, `CLEARING` and `XMAS`. Each step is `SET_WEATHER_TYPE_NOW_PERSIST` followed at once by `CLEAR_WEATHER_TYPE_PERSIST`: the change is instant, but the cycle carries on from there, so cheated weather doesn't last.

## The clock

**Known:** one game minute takes 2,000 ms of real time by default, so a game day lasts 48 real minutes. `GET_MILLISECONDS_PER_GAME_MINUTE` returns the current rate; 5 scripts read it (`vehicle_gen_controller`, `shop_controller`, `stats_controller`, `barry3a`, `pm_delivery`) to turn game time into real time. The clock pauses on the pause menu and during loading.

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `GET_CLOCK_HOURS` | 568 | 1,149 | Time-of-day checks: shop hours, night-only events, mission windows |
| `GET_CLOCK_MINUTES` / `SECONDS` | 528 / 523 | 724 / 678 | Same, and building a full date |
| `GET_CLOCK_DAY_OF_MONTH`, `MONTH`, `YEAR` | 521 to 524 | 750 to 810 | Shared helper code that packs the game date into one value (compiled into most scripts, which is why the counts are so high) |
| `GET_CLOCK_DAY_OF_WEEK` | 12 | 19 | `flow_controller`, car meets, the phone |
| `SET_CLOCK_TIME` | 88 | 466 | Missions and cutscenes jumping to their time of day; the end credits; heists |
| `SET_CLOCK_DATE` | 52 | 55 | `flow_controller`, missions that need a date, `benchmark` |
| `PAUSE_CLOCK` | 16 | 43 | Freeze time during an activity (golf, hunting, some missions) |
| `ADD_TO_CLOCK_TIME` | 8 | 14 | Skip ahead: `savegame_bed`, taxi rides, `trevor2`, friend activities, getting high |
| `ADVANCE_CLOCK_TIME_TO` | 5 | 5 | Move forward to a set time (`family3`, `family5`, `taxiservice`, two heists) |

**Verified:** sleeping in a save bed (`savegame_bed`) fades out and adds hours by the current character's index: 6 for index 0, 8 for 1, 12 for 2 (`ADD_TO_CLOCK_TIME(6, 0, 0)` and so on), then saves. **Known:** the indices are Michael, Franklin and Trevor, so Michael sleeps 6 hours, Franklin 8 and Trevor 12. `golf` and `hunting_ambient` call `PAUSE_CLOCK(true)` for the activity and `PAUSE_CLOCK(false)` after.

### Online's clock

**Verified (counts):** Online scripts don't set the world clock; they override it for their players. `NETWORK_OVERRIDE_CLOCK_TIME` (125 scripts, 430 calls) sets the time a job runs at, `NETWORK_OVERRIDE_CLOCK_RATE` (94 scripts, 280 calls) changes how fast it runs, `NETWORK_IS_CLOCK_TIME_OVERRIDDEN` (24) checks, and `NETWORK_CLEAR_CLOCK_TIME_OVERRIDE` (123 scripts, 147 calls) gives the session clock back. **Known:** the session clock runs at the same 2 s per game minute and is synchronised from the host or server time, which is why Online's time can't be changed for one player without an override.

## Wind

**Verified (data):** each weather type has `WindMin` and `WindMax` from 0.0 to 1.0. `THUNDER` (0.7 to 1.0) and `CLEARING` (0.8 to 1.0) are the windiest, `SNOW` (0.05 to 0.15) the calmest that has any wind, and `NEUTRAL`, `SNOWLIGHT` and `XMAS` have none. In `weather.xml` each particle system has a `windInfluence`: rain drops 0.5 (`RAINSTORM_DROP`) or 0.3 (`THUNDER_DROP`), mist 1.0, ground splashes 0. Each type also has `OceanWaveWindScale` and `ShoreWaveWindScale` (0.7 in the sunny types), which tie the waves to wind. Trees and plants bend through a shader whose settings are in `branchbend_windsettings.xml`.

**Known (engine):** the engine picks a wind speed within the weather's range and drifts its direction over time; wind moves vegetation, cloth, flags, particles (smoke, rain, fire), the sea and some sounds. It has little or no effect on the physics of peds and cars. Whether it pushes aircraft or boats is not settled (open question).

**Verified (scripts):** only 18 scripts call `SET_WIND`, 4 `SET_WIND_SPEED` and 4 `SET_WIND_DIRECTION`; 3 read `GET_WIND_SPEED` and 5 `GET_WIND_DIRECTION`.

- **Golf** (`golf`, `golf_mp`) runs its own wind: it starts between 1 and 4 (or 5 and 8 if the previous weather was `RAIN`, `THUNDER` or `OVERCAST`), is nudged by up to 1 between holes, and is kept between 1 and 6 (5 and 10 in bad weather). The starting direction is taken from `GET_WIND_DIRECTION`. The script then calls `SET_WIND_SPEED` and `SET_WIND_DIRECTION` with its own values, so the world's wind matches the golf wind.
- **Hunting** (`hunting_ambient`, `hunting2`) and `martin1` read wind speed and direction (in hunting the wind carries your scent to animals; **Known**).
- **`exile1`** (the plane mission) sets strong wind for a stage: `SET_WIND(1.0)`, `SET_WIND_SPEED(11.99)`, `SET_WIND_DIRECTION(2.92)`.
- The Online creators and `fmmc_launcher` set wind as part of a job's weather options.

## What this means for modders

- **Lock weather the way missions do.** Use `SET_WEATHER_TYPE_OVERTIME_PERSIST(name, seconds)` for a smooth change (30 s looks natural) or `SET_WEATHER_TYPE_NOW_PERSIST` behind a fade, and always call `CLEAR_WEATHER_TYPE_PERSIST` when your mod stops or is unloaded. To put things back exactly, save `GET_CURR_WEATHER_STATE` first and restore it with `SET_CURR_WEATHER_STATE`.
- **Expect your weather to be undone on death.** `respawn_controller` rerolls the weather after every death or arrest. A weather mod that must persist has to re-apply its weather after the respawn, for example when `IS_PLAYER_DEAD` goes back to false.
- **A cheat-style change doesn't last.** `SET_WEATHER_TYPE_NOW` without `PERSIST`, or `NOW_PERSIST` followed by a clear, lets the cycle take over again.
- **Changing the natural weather is a data edit.** Edit `WeatherCycles` in the update copy of `weather.xml` (add more `RAIN` and `THUNDER` entries, raise `TimeMult`) and replace it through a `dlc_patch` or the mods folder ([archives and content](/docs/core/archives-and-content.md)). The type values (wind range, fog, wave height) are in the same file.
- **Snow is a separate switch.** The snow weathers only change the sky and particles. Snow on the ground and snow footprints and tyre tracks come from `_FORCE_GROUND_SNOW_PASS` and `USE_SNOW_FOOT_VFX_WHEN_UNSHELTERED` / `USE_SNOW_WHEEL_VFX_WHEN_UNSHELTERED` (22 scripts each, all Online creators and controllers) (**Known**: in story mode these need the snow textures that the Christmas content loads).
- **Time:** `SET_CLOCK_TIME` jumps instantly, `ADD_TO_CLOCK_TIME` skips ahead (shops and scripts that track game days notice), `PAUSE_CLOCK(true)` freezes it. Unpause when your mod stops; a frozen clock stays frozen.
- **Wind:** `SET_WIND(0..1)` scales the wind, `SET_WIND_SPEED` / `SET_WIND_DIRECTION` (radians) set it exactly; `SET_WIND(-1)` hands it back to the weather (**Known**). It changes the look (trees, rain, smoke, waves), not handling.
- **Cost:** the weather itself is cheap. Rain draws 16,384 GPU particles (`visualsettings.dat`) and wet surfaces, and storms add lightning; on a weak GPU rain and thunder cost a few frames per second more than clear weather (**Known**; measured costs belong to R18).
- **Single player only.** The `NETWORK_*` clock natives and the Online weather override are for Rockstar's Online scripts; don't use them in GTA Online.

## Open questions

| Question | Where it goes |
| --- | --- |
| How long one `TimeMult` unit lasts, and whether the cycle position is tied to the game clock or to real time (story vs Online) | Test card 1; second pass |
| Whether wind changes the flight of aircraft, the drift of boats, or bullets | Test card 3; R2.2, R2.4 |
| What the global flag that skips the post-death weather reroll is, and which scripts set it | Second pass: read the writers of that global in `respawn_controller`'s callers |
| How `SET_OVERRIDE_WEATHER` and the persistent lock interact when both are set | In-game test |
| What the 380 timecycle variables per region do, and how timecycle modifiers stack on the weather | R13.2 |

## Test cards

1. **Cycle length.** In free roam with no mission, read `GET_PREV_WEATHER_TYPE_HASH_NAME` and `GET_NEXT_WEATHER_TYPE_HASH_NAME` every second (a small ScriptHookVDotNet or Lua script) and log the game time when the pair changes. Expected: the pairs follow the `WeatherCycles` order, and each step lasts the same game time per `TimeMult` unit.
2. **Death reroll.** Set `THUNDER` with `SET_WEATHER_TYPE_NOW_PERSIST`, then die. Expected: you wake at the hospital in a different weather, and the lock is gone.
3. **Wind on vehicles.** On a flat road, park a car with the handbrake off and fly a slow plane (Duster) at a fixed throttle. Toggle `SET_WIND_SPEED(0)` and `SET_WIND_SPEED(12)` with a fixed direction. Expected (**Known**): trees and rain move; the car doesn't roll. Note whether the plane drifts.
4. **Sleep.** Save in each character's bed at 10:00. Expected: Michael wakes at 16:00, Franklin at 18:00, Trevor at 22:00.
