# Vehicles

How a vehicle is defined across its data files: `vehicles.meta` (model, type, class, layout, flags, cameras, name labels), `carcols` (mod kits, sirens and light settings), `carvariations` (colours, extras, liveries, kits per model), `vehiclelayouts` (seats and how peds get in), and `handling.meta`; what an add-on car needs; and how scripts spawn and customise vehicles. Roadmap topic **R14.1** in the [roadmap](/ROADMAP.md). Builds on [vehicle handling](/docs/physics/vehicle-handling.md) (R2.2: `handling.meta`), [DLC packs and their vehicles](/docs/entities/vehicles/dlc-packs.md), [text and names in content](/docs/entities/objects/text-and-names.md) (R14.4: the name labels) and [cameras](/docs/rendering/cameras.md) (the vehicle cameras).

**How it was made.** The update copies of `common:/data/levels/gta5/vehicles.meta`, `x64/data/carcols.ymt` and `x64/data/carvariations.ymt` (converted to XML) and every DLC pack's `vehicles.meta`, `carcols.meta`, `carvariations.meta` and `vehiclelayouts.meta` were extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and counted by model (a DLC entry with the same model name counts once). Native use from the [VEHICLE](/scripting/native-usage/VEHICLE.md) usage page (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; what fields do is **Known** unless stated.

## Short version

- **901 vehicle models** with a `vehicles.meta` entry: 676 cars, 58 bikes, 43 planes, 32 helicopters, 29 trailers, 22 boats, 11 trains, 9 bicycles, 8 quad bikes, 4 submarines, 3 blimps, 3 amphibious cars, 2 submarine cars and 1 amphibious quad.
- **24 vehicle classes:** sports 118, muscle 90, off-road 69, super 60, motorcycles 59, sports classics 54, utility 52, sedans and SUVs 47 each, planes 46, vans 41, emergency 32, helicopters 31, boats 26 ... (the class sets the HUD category, shop pages and race classes).
- **190 different flags** describe behaviour and spawning: `FLAG_AVERAGE_CAR` 366, `FLAG_EXTRAS_STRONG` 305, `FLAG_HAS_INTERIOR_EXTRAS` 303, `FLAG_NO_BOOT` 268, `FLAG_RICH_CAR` 242, `FLAG_SPORTS` 189, `FLAG_CAN_HAVE_NEONS` 184, `FLAG_DONT_SPAWN_AS_AMBIENT` 161, `FLAG_DONT_SPAWN_IN_CARGEN` 156, `FLAG_POOR_CAR` 132.
- **Seats and entry come from layouts:** 367 different layouts are used by vehicles, from 351 `LAYOUT_*` definitions in the base and DLC `vehiclelayouts.meta` files.
- **Customisation is per mod kit:** 602 distinct mod kits across the base `carcols.ymt` (91) and the DLC `carcols.meta` files; each kit lists the visible parts (spoilers, bumpers, liveries, horns ...) and links to the shared engine, brakes, gearbox, armour and suspension upgrades.
- **Plates:** back only 393, front and back 252, none 240, front only 16.
- **Scripts customise constantly:** `GET_VEHICLE_MOD` (544 scripts, 19,686 calls), `SET_VEHICLE_MOD` (447, 13,907), `SET_VEHICLE_COLOURS` (480, 12,499), `SET_VEHICLE_EXTRA` (461, 10,193), `CREATE_VEHICLE` (584, 4,197).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/levels/gta5/vehicles.meta` (update copy) and DLC `vehicles.meta` | One entry per model: model and texture dictionary names, handling id, `gameName` and `vehicleMakeName`, type, class, layout, cameras, LOD distances, flags, plate type, dashboard, seat and door data, rewards, trailers it can tow | 298 base, 581 in DLC files (901 distinct models) |
| `x64/data/carcols.ymt` and DLC `carcols.meta` | Mod kits, visible mod parts, light and siren settings, wheel lists | 91 base kits, 602 kits in all; 14 siren settings in the base file |
| `x64/data/carvariations.ymt` and DLC `carvariations.meta` | Per model: allowed colour combinations, extras, liveries, the mod kit, plate probabilities, light and siren setting ids | 298 base, 581 in DLC files |
| `common:/data/ai/vehiclelayouts.meta` and DLC copies | Seats, entry and exit points and animations, per layout | 351 layouts |
| `common:/data/handling.meta` (update copy) and DLC `handling.meta` | Physics ([vehicle handling](/docs/physics/vehicle-handling.md)) | |
| `x64/vehicles.rpf` and DLC `vehicles.rpf` | `.yft` models and `.ytd` textures | |

### The type and class tables

| Type | Models | | Class | Models |
| --- | ---: | --- | --- | ---: |
| Car | 676 | | Sport | 118 |
| Bike | 58 | | Muscle | 90 |
| Plane | 43 | | Off-road | 69 |
| Helicopter | 32 | | Super | 60 |
| Trailer | 29 | | Motorcycle | 59 |
| Boat | 22 | | Sports classic | 54 |
| Train | 11 | | Utility | 52 |
| Bicycle | 9 | | Sedan, SUV | 47, 47 |
| Quad bike | 8 | | Plane | 46 |
| Submarine | 4 | | Van | 41 |
| Blimp | 3 | | Emergency | 32 |
| Amphibious car | 3 | | Helicopter | 31 |
| Submarine car | 2 | | Boat | 26 |
| Amphibious quad | 1 | | Commercial, coupe, military, service, compacts, industrial, rail, cycle, open wheel | 24, 21, 17, 14, 18, 11, 11, 9, 4 |

(`VC_COMPACT` and `VC_COMPACTS` both appear in the files, for 11 and 7 models.)

### Flags that matter to mods (**Known** meaning)

| Flag | Models | Effect |
| --- | ---: | --- |
| `FLAG_DONT_SPAWN_AS_AMBIENT`, `FLAG_DONT_SPAWN_IN_CARGEN` | 161, 156 | Kept out of traffic and parked-car generators ([R4.3](/docs/entities/spawning/vehicle-generators-and-traffic.md)) |
| `FLAG_AVERAGE_CAR`, `FLAG_RICH_CAR`, `FLAG_POOR_CAR`, `FLAG_SPORTS` | 366, 242, 132, 189 | Which areas and drivers it suits |
| `FLAG_CAN_HAVE_NEONS` | 184 | Neon kits allowed |
| `FLAG_EXTRAS_STRONG`, `FLAG_EXTRAS_REQUIRE`, `FLAG_HAS_INTERIOR_EXTRAS` | 305, 173, 303 | How extras (roof racks, light bars) behave and are chosen |
| `FLAG_NO_BOOT`, `FLAG_IS_BULKY`, `FLAG_IS_OFFROAD_VEHICLE` | 268, 183, 145 | Boot, size and off-road AI rules |

### How many models, counted three ways (leftovers pass)

**Verified** by reading all 76 `vehicles.meta` files: the base and update copies, 37 DLC packs and **38 `dlc_patch` copies in `update.rpf`**. The union is **921 models** (696 cars, 58 bikes, 43 planes, 32 helicopters, 29 trailers, 22 boats, 11 trains, 9 bicycles, 8 quad bikes, 4 submarines, 3 blimps, 3 amphibious cars, 2 submarine cars and 1 amphibious quad).

- 298 models come from the base game (and its update copy), 517 from a DLC pack that a `dlc_patch` file also carries, and 64 from a pack alone.
- **42 models appear only in a `dlc_patch` file**, the vehicles of the early packs (13 in `spupgrade`, 7 in `mphipster`, 4 each in `mpbeach`, `mpbusiness`, `mpbusiness2` and `mppilot`, 3 in `mplts`, 2 in `mpindependence`, 1 in `mpvalentines`: `zentorno`, `turismor`, `massacro`, `dodo`, `blimp2` ...).
- Leaving those 42 out gives exactly **879**, the count in [text and names](/docs/entities/objects/text-and-names.md), which read the base and 37 pack files but no `dlc_patch` copy. The 901 above came from a different selection of copies that isn't recorded, so it can't be rebuilt exactly; 921 is the full number.

**The rare flags** (**Verified**, the same files, each model's last copy). 191 different flags are used; 26 of them by one model only and 79 by five or fewer. The names say what each does, and the one model that uses it shows where it matters: `FLAG_HAS_GLIDER` (`oppressor`), `FLAG_HAS_PARACHUTE` (`ruiner2`), `FLAG_HAS_VERTICAL_ROCKET_BOOST` and `FLAG_HAS_HELI_STRAFE_MODE` (`thruster`), `FLAG_HAS_OUTRIGGER_LEGS` and `FLAG_HEADLIGHTS_ON_TAP_ONLY` (`chernobog`), `FLAG_LATCH_ALL_JOINTS`, `FLAG_REJECT_ENTRY_TO_VEHICLE_WHEN_STOOD_ON` and `FLAG_USE_LENGTH_OF_VEHICLE_BOUNDS_FOR_PLAYER_LOCKON_POS` (the `kosatka` submarine), `FLAG_CANNOT_BE_DRIVEN_BY_PLAYER` (`metrotrain`), `FLAG_CANNOT_BE_MODDED` (`crusader`), `FLAG_EXTRAS_TAXI` (`taxi`), `FLAG_TWO_DOORS_ONE_SEAT` (`bulldozer`), `FLAG_SECOND_TURRET_MOD` (`bombushka`) and `FLAG_THIRD_TURRET_MOD` (`pounder2`), `FLAG_EQUIP_UNARMED_ON_ENTER` (`microlight`), `FLAG_IS_QUADBIKE_USING_BIKE_ANIMATIONS` (`stryder`), `FLAG_SET_WANTED_FOR_ATTACHED_VEH` (`trailersmall2`). Pairs: `FLAG_IS_FORMULA_VEHICLE` (`openwheel1`, `openwheel2`), `FLAG_HAS_LOWRIDER_DONK_HYDRAULICS` (`faction3`, `slamtruck`), `FLAG_SPRAY_PETROL_BEFORE_EXPLOSION` (`tanker`, `tanker2`), `FLAG_ALLOW_RAPPEL_AI_ONLY` (`buzzard`, `buzzard2`), `FLAG_TALL_SHIP` (`marquis`, `tug`). One entry looks like a typo: `bodhi2` lists `ALLOW_OBJECT_LOW_LOD_COLLISION` without the `FLAG_` prefix that every other flag has (`kosatka` has the prefixed form), so our reading is that the engine ignores it. What each rare flag does in detail is a test for each model.

## How scripts use vehicles

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `CREATE_VEHICLE` / `DELETE_VEHICLE` | 584 / 538 | 4,197 / 6,130 | Spawn and remove |
| `SET_VEHICLE_ON_GROUND_PROPERLY` | 544 | 12,987 | Settle a spawned vehicle on its wheels |
| `SET_VEHICLE_ENGINE_ON`, `SET_VEHICLE_DOORS_LOCKED` | 533, 507 | 8,930, 13,017 | State |
| `SET_VEHICLE_COLOURS`, `SET_VEHICLE_EXTRA_COLOURS`, `SET_VEHICLE_CUSTOM_PRIMARY_COLOUR` | 480, 463, 395 | 12,499, 10,026, 631 | Paint |
| `SET_VEHICLE_EXTRA` | 461 | 10,193 | Turn extras on and off |
| `SET_VEHICLE_MOD_KIT` then `SET_VEHICLE_MOD`, `TOGGLE_VEHICLE_MOD`, `GET_VEHICLE_MOD`, `GET_NUM_VEHICLE_MODS` | 451, 447, 445, 544, 473 | | Mods (the kit must be set first, **Known**) |
| `SET_VEHICLE_LIVERY`, `SET_VEHICLE_WINDOW_TINT`, `SET_VEHICLE_WHEEL_TYPE`, `SET_VEHICLE_NEON_ENABLED`, `SET_VEHICLE_TYRE_SMOKE_COLOR` | 449, 443, 440, 437, 437 | | The rest of the look |
| `SET_VEHICLE_NUMBER_PLATE_TEXT` | 457 | 1,611 | Plates (personal vehicles) |
| `SET_VEHICLE_SIREN` | 210 | 530 | Sirens on |
| `GET_VEHICLE_CLASS`, `GET_VEHICLE_CLASS_FROM_NAME` | 47, 40 | | Class checks (races, shops) |

The near-identical counts around 440 to 480 scripts for the look natives come from shared code that saves and restores a vehicle's full setup (personal vehicles, garages, mission vehicles); story missions themselves mostly spawn a fixed vehicle and set colours, extras and a plate.

## An add-on vehicle

**Known (community practice, matching how Rockstar's packs are built):** a DLC-style pack with

1. `vehicles.rpf` holding the `.yft` (and `_hi.yft`) model and `.ytd` textures.
2. `vehicles.meta` with a new `modelName`, a `handlingId`, `gameName`/`vehicleMakeName` labels ([R14.4](/docs/entities/objects/text-and-names.md)), a type, class, layout and cameras copied from a similar vehicle, and spawn flags (`FLAG_DONT_SPAWN_AS_AMBIENT` if it shouldn't appear in traffic).
3. `handling.meta` with a `CHandlingData` for that `handlingId`.
4. `carvariations.meta` with colours, the kit id and liveries; `carcols.meta` if it has its own mod kit or sirens (siren and kit ids must not clash with Rockstar's or other mods'; pick high numbers).
5. `content.xml` entries (`VEHICLE_METADATA_FILE`, `HANDLING_FILE`, `VEHICLE_VARIATION_FILE`, `CARCOLS_FILE`, `VEHICLE_LAYOUTS_FILE` if needed, the `RPF_FILE` for the models) and the pack in `dlclist.xml` ([archives and content](/docs/core/archives-and-content.md)).

Replacing a vanilla car instead means replacing its `.yft`/`.ytd` with the same names and leaving the data alone, or editing the vanilla entries in a `dlc_patch`; add-ons are safer across updates.

## What this means for modders

- **Spawn properly:** `REQUEST_MODEL`, `CREATE_VEHICLE`, `SET_VEHICLE_ON_GROUND_PROPERLY`, then `SET_VEHICLE_MOD_KIT(veh, 0)` before any `SET_VEHICLE_MOD`, and `SET_MODEL_AS_NO_LONGER_NEEDED`.
- **Mod kits are per model:** a mod index means a different part on every car; read `GET_NUM_VEHICLE_MODS(veh, type)` before choosing.
- **Count the cost:** each different model in memory costs streaming memory; spawning many unique add-ons on a weak PC causes texture loss ([memory and VRAM](/docs/performance/memory-and-vram.md)).
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The difference between the 901 models here and the 879 counted in R14.4 (how entries were split) | Answered in [how many models](#how-many-models-counted-three-ways-leftovers-pass): 921 in all; 879 leaves out the 42 models only in `dlc_patch` files |
| The meaning of the less common flags | Mostly answered in [the rare flags](#how-many-models-counted-three-ways-leftovers-pass): which model uses each; the detailed effect is a test per model |
| Light and siren setting id ranges used by DLC packs | Second pass |
| Which `carcols` mod parts each kit really links (the per-type counts include repeats) | Second pass |

## Test cards

1. **Kit first.** `SET_VEHICLE_MOD(veh, 0, 1, false)` on a fresh `sultan` without `SET_VEHICLE_MOD_KIT`. Expected: no change; with the kit set first, the spoiler appears.
2. **Spawn flags.** Drive around the city for 10 minutes with a pack whose car has `FLAG_DONT_SPAWN_AS_AMBIENT`. Expected: you never see it in traffic.
3. **Class.** `GET_VEHICLE_CLASS` on `adder` and `blista`. Expected: 7 (super) and 0 (compacts) (**Known** numbering).
