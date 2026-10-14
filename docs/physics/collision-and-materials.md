# Collision, materials and shape tests

How GTA V decides what touches what: collision bounds, the material table that gives every surface its friction, bounce, tyre grip and bullet behaviour, how scripts probe the world with shape tests, and how collision is loaded around the player. Roadmap topic **R2.1** in the [roadmap](/ROADMAP.md). Vehicle handling, which uses the tyre-grip columns, is [guide 4](/docs/physics/vehicle-handling.md).

**How it was made.** `materials.dat`, `material_override_pairs.dat`, `procedural.meta`, `rumbleprofiles.meta` (`common.rpf\data\materials\`, with the newer copies in `update\update.rpf\common\data\materials\`) and `materialfx.dat` (`common.rpf\data\effects\`) were read with `tools/rpf-cw.ps1`. Native use was counted in the build-3725 decompile, and native signatures come from the natives reference ([`reference/natives/SHAPETEST.md`](https://nativedb.dotindustries.dev/gta5/natives)). `materials.dat` documents its own columns in a comment header, which is quoted by name below.

## 5.1 Short version

- **Two kinds of collision.** Static world collision comes in `.ybn` bound files streamed with the map; each model (car, prop, ped) carries its own bounds inside its drawable or fragment. A bound is made of primitives (boxes, spheres, capsules, cylinders) and triangle meshes, and every polygon names a **material** (**Known**).
- **One material table.** `materials.dat` lists 213 materials in 13 groups, each with friction, elasticity, density, tyre grip, wet grip, tyre drag, top speed multiplier, bullet penetration resistance and flags (see-through for AI, shoot-through for bullets, no decals, porous, heats tyres). The effects table (`materialfx.dat`) and the audio pick sounds and particles from the same material.
- **Surfaces change how cars drive.** Ice has tyre grip 0.45 and a top-speed multiplier of 0.8; loose sand 0.75 grip and 0.7 top speed; marsh 0.6 top speed. That is the whole "off-road" model, apart from the handling flags.
- **Bullet glass is just a number.** `GLASS_BULLETPROOF` has a penetration resistance of 10,000; `GLASS_SHOOT_THROUGH` has 0 and the shoot-through flag.
- **Scripts test the world with shape tests**: line probes, capsules, swept spheres, boxes and bounds, started asynchronously and polled with `GET_SHAPE_TEST_RESULT`. Rockstar's scripts make about 4,500 of these calls; capsules are the most common (4,032 calls in 311 scripts).
- **Collision has to be loaded.** The world's collision streams around the camera focus. Scripts move that focus (`SET_FOCUS_POS_AND_VEL`, 6,529 calls), ask for collision (`REQUEST_COLLISION_AT_COORD`) and wait for it (`HAS_COLLISION_LOADED_AROUND_ENTITY`) before putting an entity somewhere far away.

## 5.2 Bounds

**Known** (community documentation of the RAGE formats; to check with CodeWalker on our side):

| Where | Format | What |
| --- | --- | --- |
| Map collision | `.ybn` in the map archives, grouped by area | Static bound trees for terrain and buildings, with separate bounds for the high-detail and the low-detail "mover" collision |
| Props and buildings with physics | Bound inside the `.ydr` or `.yft` | Primitive shapes for dynamic objects |
| Vehicles and breakable props | Fragment (`.yft`) | One bound per breakable part, so doors, bumpers and wheels can come off |
| Peds | Ragdoll bounds from the skeleton | Capsules per bone (R2.3) |

Collision is tested in several layers (map, vehicles, peds, objects, glass, water, foliage), which is what the shape test flags in 5.4 select.

## 5.3 Materials

**`materials.dat`** (version line `12.00` in `update.rpf`) has 213 material rows (**Verified**). The groups (`FILTER` column) and how many materials each has:

| Group | Count | Examples |
| --- | --- | --- |
| `SPECIAL` | 46 | `PHYS_NO_FRICTION`, `PHYS_GOLF_BALL`, `PHYS_TENNIS_BALL`, `PHYS_PED_CAPSULE`, `PHYS_ELECTRIC_FENCE`, `PHYS_BARBED_WIRE`, `PHYS_CAR_VOID` |
| `MANMADE` | 31 | `RUBBER`, `CLOTH`, `CARDBOARD_SHEET`, `TARPAULIN` |
| `LOOSE_TERRAIN` | 26 | `SAND_LOOSE`, `ICE`, `SNOW_LOOSE`, `GRAVEL_LARGE`, `DIRT_TRACK`, `MUD_HARD`, `MARSH` |
| `NATURAL_MOTION` | 22 | Body parts for ragdoll and hit reactions |
| `HARD_TERRAIN` | 22 | `CONCRETE`, `TARMAC`, `ROCK`, `STONE`, `ICE_TARMAC` |
| `METALS` | 20 | `METAL_SOLID_SMALL`, `METAL_CHAINLINK_*`, `STUNT_RAMP_SURFACE` |
| `WOODS` | 14 | `WOOD_SOLID_*` |
| `VEHICLES` | 10 | `CAR_METAL`, `CAR_GLASS_WEAK/MEDIUM/STRONG`, `CAR_SOFTTOP` |
| `VEGETATION` | 10 | `GRASS`, `HAY`, `BUSHES`, `LEAVES`, `TREE_BARK` |
| `LIQUIDS` | 5 | `WATER`, `OIL`, `PETROL` |
| `GLASS` | 4 | `GLASS_SHOOT_THROUGH`, `GLASS_BULLETPROOF` |
| `MISC` | 2 | |
| `DEFAULT` | 1 | `DEFAULT` |

**Columns** (names from the file's own header, **Verified**): material, filter, FX group, VFX disturbance type, rumble profile, react weapon type, `RAGE_FRICTION`, `RAGE_ELASTICITY`, `DENSITY`, `TYRE_GRIP`, `WET_GRIP`, `TYRE_DRAG`, `TOP_SPEED_MULT`, then two columns that hold 0.95 and 0.0 in every row read, `PENETRATION_RESISTANCE`, four flags (`SEE_THRU`: AI probes pass through; `SHOOT_THRU`: weapon probes pass through; `SHOOT_THRU_FX`: report the hit anyway so effects play; `NO_DECAL`), two more flags (`POROUS`, `HEATS_TYRE`) and an audio material name.

**Selected rows** (**Verified** values):

| Material | Friction | Elasticity | Tyre grip | Wet grip | Tyre drag | Top speed | Penetration | Flags |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `TARMAC` | 1.0 | 0.4 | 1.00 | -0.10 | 0 | 1.0 | 1 | heats tyres |
| `CONCRETE` | 1.0 | 0.3 | 1.00 | -0.10 | 0 | 1.0 | 1 | heats tyres |
| `ROCK` | 0.9 | 0.4 | 1.00 | -0.15 | 0 | 0.8 | 1 | heats tyres |
| `DIRT_TRACK` | 0.8 | 0.3 | 0.90 | -0.10 | 0.03 | 0.8 | 1 | porous, heats tyres |
| `GRASS` | 0.6 | 0.1 | 0.90 | -0.15 | 0.02 | 0.8 | 1 | porous |
| `GRAVEL_LARGE` | 0.6 | 0.1 | 0.85 | -0.10 | 0.06 | 0.8 | 1 | |
| `SAND_LOOSE` | 0.8 | 0.1 | 0.75 | -0.05 | 0.115 | 0.7 | 1 | porous |
| `MARSH` | 0.7 | 0.2 | 0.70 | -0.10 | 0.07 | 0.6 | 1 | porous |
| `SNOW_LOOSE` | 0.4 | 0.1 | 0.40 | -0.10 | 0.06 | 0.8 | 1 | porous |
| `ICE` | 0.1 | 0.3 | 0.45 | -0.10 | 0 | 0.8 | 1 | |
| `RUBBER` | 2.0 | 3.0 | 1.00 | -0.12 | 0 | 1.0 | 1 | |
| `PHYS_TENNIS_BALL` | 1.0 | 10.0 | | | | | | |
| `GLASS_SHOOT_THROUGH` | 0.2 | 0.7 | 0.90 | | | | 0 | see-through, shoot-through, shoot-through FX |
| `GLASS_BULLETPROOF` | 0.2 | 0.7 | 0.90 | | | | 10,000 | see-through |
| `WATER` | 0.5 | 0.1 | 0.90 | | | | 1 | all four |

Reading it: `TYRE_GRIP` replaces the surface friction for tyres, `WET_GRIP` is subtracted when it rains, `TYRE_DRAG` slows wheels down in soft ground, and `TOP_SPEED_MULT` caps speed on that surface (column meanings from the file's header; the exact formula is **Known**). 18 materials are shoot-through, including chain-link fences, grilles, lattices, tarpaulin, cardboard, blinds, car soft-tops and car glass (**Verified**).

**`material_override_pairs.dat`** can set a combined friction and elasticity for a pair of materials. Its only example (`CAR_METAL` on `CONCRETE`) is commented out, so no pair overrides are active (**Verified**).

**Other files keyed by material:**

| File | What it does |
| --- | --- |
| `materialfx.dat` (version `6.00`) | The effects table: for each FX group (`CONCRETE`, `TARMAC`, `GENERIC` ...) a debug colour and the particle and decal ids used for bullet impacts, footsteps, tyre marks and scrapes (**Verified** layout, ids **Known**) |
| `procedural.meta` | 860 entries: which grass, plants and small props grow procedurally on which material (`procTagTable`, `procObjInfos`, `plantInfos`) (**Verified** counts) |
| `rumbleprofiles.meta` | 16 controller rumble profiles (duration, frequency, speed range) picked by the rumble column |

The newer `update.rpf` copy of `materials.dat` adds `STUNT_RAMP_SURFACE` and puts the old temporary slots to use for the stunt-race pads (`g_idPhysVehicleSpeedUp`, `SlowDown`, `Refill`, `StuntTargetA` ...) (**Verified** in the diff). Material indices are positions in this table, so the order must never change: new materials are added at the end or in reserved slots.

## 5.4 Shape tests

The natives (**Verified** signatures in the natives reference; counts from the decompile):

| Native | Calls (scripts) | Shape |
| --- | --- | --- |
| `START_SHAPE_TEST_CAPSULE` | 4,032 (311) | A line with a radius |
| `START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE` | 248 (218) | A line, answered at once (blocks the script) |
| `START_SHAPE_TEST_LOS_PROBE` | 241 (171) | A line, answered later |
| `START_SHAPE_TEST_BOX` | 122 (30) | An oriented box |
| `START_SHAPE_TEST_SWEPT_SPHERE` | 98 (38) | A sphere moved along a line |
| `START_SHAPE_TEST_BOUNDING_BOX` | 14 (7) | An entity's bounding box |
| `START_SHAPE_TEST_BOUND` | 4 (4) | An entity's actual bounds |
| `START_SHAPE_TEST_MOUSE_CURSOR_LOS_PROBE` | (1) | From the camera through the mouse cursor |
| `GET_SHAPE_TEST_RESULT` | 3,441 (416) | Read the result: hit, point, normal, entity |
| `GET_SHAPE_TEST_RESULT_INCLUDING_MATERIAL` | 16 (7) | The same plus the material hash |

**How they work.** A start call returns a handle; the result call returns 1 while the test is still pending and 2 when it is done, after which the handle is gone. The synchronous version answers in the same frame and is called "expensive" for that reason. An entity hit by a probe gets a script handle, which `RELEASE_SCRIPT_GUID_FROM_ENTITY` gives back when the script doesn't need it (**Known**, from the reference descriptions).

**Flags.** The flags argument picks the collision layers to test. In the line and capsule probes Rockstar's scripts mostly use 81, 83 and 19 (744, 741 and 212 calls), then 4, 7 and 511 (all layers) (**Verified** counts). With the community bit names (1 map, 2 vehicles, 4 peds, 8 ragdolls, 16 objects, 32 pickups, 64 glass, 128 rivers, 256 foliage; **Known**), 81 is map + objects + glass, 83 adds vehicles, and 19 is map + vehicles + objects. The last argument is a separate options mask (usually 7 or 4, **Known**).

## 5.5 Collision around the player

The world's collision streams in around the **focus**, which is the player unless a script moves it (**Known**). Scripts manage it with (**Verified** counts):

| Native | Calls | Use |
| --- | --- | --- |
| `SET_ENTITY_COLLISION` | 24,870 | Turn an entity's collision on or off (cutscenes, attached props, hiding entities) |
| `GET_GROUND_Z_FOR_3D_COORD` | 8,901 | Find the ground under a point (needs collision loaded there) |
| `SET_FOCUS_POS_AND_VEL` / `SET_FOCUS_ENTITY` / `CLEAR_FOCUS` | 6,529 / 1,361 / 3,582 | Move streaming and collision to a camera or another place |
| `SET_ENTITY_DYNAMIC` | 3,665 | Let physics move an entity |
| `SET_ENTITY_NO_COLLISION_ENTITY` | 3,186 | Two entities ignore each other |
| `GET_GROUND_Z_EXCLUDING_OBJECTS_FOR_3D_COORD` | 2,091 | Ground height, ignoring props |
| `NEW_LOAD_SCENE_START_SPHERE` / `NEW_LOAD_SCENE_START` / `LOAD_SCENE` | 1,294 / 323 / 231 | Load everything around a point before a warp |
| `SET_ENTITY_LOAD_COLLISION_FLAG` | 1,255 | Make an entity load collision around itself (mission peds and cars far from the player) |
| `ACTIVATE_PHYSICS` | 744 | Wake a sleeping object |
| `SET_ENTITY_COMPLETELY_DISABLE_COLLISION` | 611 | |
| `REQUEST_COLLISION_AT_COORD` | 306 | Ask for collision at a point |
| `HAS_COLLISION_LOADED_AROUND_ENTITY` | 221 | Wait before freezing or unfreezing a warped entity |
| `HAS_ENTITY_COLLIDED_WITH_ANYTHING` | 172 | |
| `SET_DISABLE_FRAG_DAMAGE` / `SET_DISABLE_BREAKING` | 149 / 52 | Stop props from breaking |
| `GET_COLLISION_NORMAL_OF_LAST_HIT_FOR_ENTITY` / `GET_LAST_MATERIAL_HIT_BY_ENTITY` | 105 / 32 | What an entity last hit |

The pattern used by missions after a warp (seen in `armenian1`'s restart code, [core guide 3](/docs/gameplay/missions/mission-anatomy.md)): freeze the player, `LOAD_SCENE` or `NEW_LOAD_SCENE_START_SPHERE` at the target, wait, then unfreeze. An entity placed where collision isn't loaded falls through the map (**Known**), which is why far-away mission entities get `SET_ENTITY_LOAD_COLLISION_FLAG`.

## 5.6 What this means for modders

- **Spawning safely.** Before placing a ped or car away from the player, request collision there (or set the entity's load-collision flag) and find the ground with `GET_GROUND_Z_FOR_3D_COORD`; otherwise it can fall through the world. Zombie and gang spawners on a low-end PC should prefer points the player can already see, where collision is loaded anyway.
- **Use asynchronous probes.** `START_SHAPE_TEST_*` plus polling costs almost nothing per frame; the synchronous probe blocks the script. A mod running many line-of-sight checks (zombie vision, cover finding) should start them on one frame and read them on the next, and cap how many it runs.
- **Pick the right flags.** 19 or 83 (map, vehicles, objects) is the usual line of sight; add 4 or 8 only when the test must hit peds.
- **Surfaces are a cheap gameplay lever.** Weather mods that make roads slippery, or a "mud" event, change grip through these columns rather than per car. Editing `materials.dat` means a modded `update.rpf`, and the material order must stay the same.
- **Shoot-through materials matter for combat mods.** A cop shooting through a chain-link fence is the material table working as designed, not a bug.

## 5.7 Open questions

| Question | Where it goes |
| --- | --- |
| The two unnamed columns (0.95 and 0.0 in every row) | R2.1 second pass |
| How many `.ybn` files the map has and how they are grouped | R4.1 (map) |
| The exact shape test flag bits, checked in game | R2.1 second pass |
| The ragdoll and `NATURAL_MOTION` materials | R2.3 |
| How water collision differs from water simulation | R2.4 |
