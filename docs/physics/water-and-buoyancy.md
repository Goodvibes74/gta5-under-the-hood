# Water and buoyancy

Where GTA V's water is (the ocean, lakes, rivers and pools as rectangles in `water.xml`), how waves are shaped by weather and calmed near shore, how boats, submarines and floating things are tuned to float, and how scripts read the water height and override the sea. Roadmap topic **R2.4** in the [roadmap](/ROADMAP.md). Builds on [time, weather and wind](/docs/world/time-and-weather.md) (each weather sets the sea), [vehicle handling](/docs/physics/vehicle-handling.md) (`handling.meta`) and [swimming and diving](/docs/gameplay/player/swimming-and-diving.md) (R3.5: breath, scuba, the sea edge).

**How it was made.** `common:/data/levels/gta5/water.xml`, `common:/data/watertune.xml` and `common:/data/water.dat` extracted from `common.rpf` with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and counted; boat and submarine sections counted in the update copy of `handling.meta` and the DLC `handling.meta` files. Native use from the [WATER](/scripting/native-usage/WATER.md) and [MISC](/scripting/native-usage/MISC.md) usage pages (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Data and counts are **Verified**; how the physics uses them is **Known** unless stated.

## Short version

- **Water is rectangles.** `water.xml` holds 504 water quads (57.6 km² in all), 542 calming quads and 116 wave quads. 402 water quads sit at height 0 (the sea), 77 at 30 m (the Alamo Sea and other inland water), 17 at 196.4 m and 8 at 160.3 m (the reservoirs in the hills). They come in 5 types (0 for 342 quads, others 33 to 48 each).
- **Calming quads damp the waves** near shores, harbours and inland water (`fDampening`, for example 0.05 over the reservoir).
- **Wave size comes from the weather:** each weather type sets ocean wave amplitude, shore waves, ripples and foam ([R2.6](/docs/world/time-and-weather.md)); storms lower the base amplitude (2.03) but raise wind-driven waves.
- **Floating is per vehicle:** every vehicle's `fPercentSubmerged` in `handling.meta` sets how deep it sits (254 base entries, from 45 to 200%, median 85). Boats add a `CBoatHandlingData` section (10 base, 9 DLC) with keel, rudder, impeller, prow-raise and aquaplane values; submarines a `CSubmarineHandlingData` (1 base, 4 DLC); seaplanes a `CSeaPlaneHandlingData` (3 DLC).
- **Scripts probe and calm the water:** `TEST_PROBE_AGAINST_WATER` (301 scripts), `GET_WATER_HEIGHT_NO_WAVES` (257), `ADD_EXTRA_CALMING_QUAD` (17), `SET_DEEP_OCEAN_SCALER` (11), `MODIFY_WATER` (3), and the `WATER_OVERRIDE_SET_*` natives that set the sea directly.

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/levels/gta5/water.xml` | Water quads (min and max X, Y, height, type, invisible, limited depth, alpha per corner), calming quads (with dampening), wave quads | 504 / 542 / 116 |
| `common:/data/watertune.xml` | Look of the water: colour, ripple and foam scale, refraction, fog, god rays, deep-water fade | 1 |
| `common:/data/water.dat` | Old-style water planes (four corners and a height per line) | |
| `common:/data/levels/gta5/waterheight.dat` | A height map of the water (binary) | |
| `update:/common/data/watertune_heistisland.xml` | Water look for Cayo Perico | |
| `common:/data/levels/gta5/weather.xml` | Wave, ripple and foam values per weather | [R2.6](/docs/world/time-and-weather.md) |
| `common:/data/handling.meta` and DLC copies | `fPercentSubmerged` and the boat, submarine and seaplane sections | 254 base `CHandlingData` |

### Water heights

| Height | Quads | Where (**Known**) |
| --- | ---: | --- |
| 0.0 m | 402 | The ocean and the harbour |
| 30.0 m | 77 | The Alamo Sea and other low inland water |
| 196.4 m | 17 | The Land Act reservoir (above the Vinewood Hills) |
| 160.3 m | 8 | The Vinewood reservoir |
| Others | 0 | Pools, rivers and ponds use other heights |

Pools in back gardens are mostly not in `water.xml`; they are drawn and simulated as part of their buildings (**Known**).

### Boats

`CBoatHandlingData` fields (**Verified** names): `fBoxFrontMult`, `fBoxRearMult`, `fBoxSideMult` (hull shape for buoyancy), `fSampleTop`, `fSampleBottom` (where the hull samples the water), `fKeelSphereSize`, `fDinghySphereBuoyConst` (inflatables), `fRudderForce`, `fRudderOffsetForce`, `fRudderOffsetSubmerge`, `fImpellerForceMult`, `fImpellerOffset`, `fPropRadius`, `fProwRaiseMult` (how the bow lifts at speed), `fAquaplaneForce` and its push-water values, `fDragCoefficient`, `fLowLodAngOffset`, `fLowLodDraughtOffset` (cheap floating far from the player), `fWaveAudioMult`.

**Known (engine):** a vehicle floats by sampling the water height at points on its body and pushing up in proportion to how far each point is under; `fPercentSubmerged` sets the target depth. Far from the player, boats switch to a low-detail "anchored" float that costs less (`SET_BOAT_LOW_LOD_ANCHOR_DISTANCE`, 15 scripts).

## How scripts use water

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `TEST_PROBE_AGAINST_WATER`, `TEST_PROBE_AGAINST_ALL_WATER`, `TEST_VERTICAL_PROBE_AGAINST_ALL_WATER` | 301, 10, 15 | 316, 19, 23 | Is there water along a line, and where |
| `GET_WATER_HEIGHT_NO_WAVES`, `GET_WATER_HEIGHT` | 257, 19 | 564, 100 | Water height at a point |
| `ADD_EXTRA_CALMING_QUAD` / `REMOVE_EXTRA_CALMING_QUAD` | 17 / 17 | 21 / 25 | Calm an area for a scene |
| `SET_DEEP_OCEAN_SCALER`, `GET_DEEP_OCEAN_SCALER`, `RESET_DEEP_OCEAN_SCALER` | 11, 9, 11 | | Scale the open-sea waves |
| `SET_CALMED_WAVE_HEIGHT_SCALER` | 8 | 16 | Scale waves inside calming quads |
| `MODIFY_WATER` | 3 | 91 | Raise or lower water at a point |
| `WATER_OVERRIDE_SET_*`, `WATER_OVERRIDE_SET_STRENGTH` | 8 to 11 | | Set the sea's values directly ([R2.6](/docs/world/time-and-weather.md)) |
| `IS_ENTITY_IN_WATER`, `GET_ENTITY_SUBMERGED_LEVEL` | 675, 276 | | Is something wet, and how deep ([R3.5](/docs/gameplay/player/swimming-and-diving.md)) |

## What this means for modders

- **Calm water for a scene:** `ADD_EXTRA_CALMING_QUAD(minX, minY, maxX, maxY, 0.0)` and remove it after; or `WATER_OVERRIDE_SET_STRENGTH` with low wave values.
- **Huge waves:** raise the weather's wave values in `weather.xml`, or call `SET_DEEP_OCEAN_SCALER` (**Known**: values well above 1 make storm seas). Boats and the sea edge then become much harder.
- **New water** (a lake, a flooded city) is a `water.xml` edit: add water quads at the height you want. A whole-map flood is a well-known mod built this way; the map's collision and AI don't expect it, so peds and traffic behave oddly.
- **Better boats** are `handling.meta` edits (`fPercentSubmerged`, the boat section); add-on boats need all of it.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| What the 5 water quad types mean | Second pass: compare where each type is |
| The format of `waterheight.dat` | Second pass |
| How wave quads differ from calming quads in effect | In-game test |
| Where swimming pools are defined | R4.6 second pass |

## Test cards

1. **Heights.** `GET_WATER_HEIGHT_NO_WAVES` on the Alamo Sea and on the Land Act reservoir. Expected: about 30 and 196.4.
2. **Calming.** In a storm at sea, add a calming quad around your boat. Expected: flat water inside, waves outside.
3. **Sinking.** Lower a boat's `fPercentSubmerged` and launch it. Expected: it rides higher; raise it far and it sits low or swamps.
