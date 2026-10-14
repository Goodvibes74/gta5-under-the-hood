# Physics cost: what the simulation spends, and how scripts keep it down

Which physical simulations cost the most (ragdolls, vehicles and wrecks, breaking objects and glass, explosions and fire, ropes and cloth, projectiles), the limits the engine has for each, how Rockstar's scripts keep physics cheap, and spawn and effect budgets for mods on a low-end PC. Roadmap topic **R2.7** in the [roadmap](/ROADMAP.md). Builds on [memory, pools and limits](/docs/core/memory-and-pools.md), [vehicle handling](/docs/physics/vehicle-handling.md) and [collision and materials](/docs/physics/collision-and-materials.md); feeds R18.4 (CPU) and every spawning mod.

**How it was made.** Vanilla `common\data\gameconfig.xml` (from `update\update.rpf`) and a test install's modded copy (from OpenIV's mods folder) extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and their physics pools compared. Physics-control natives counted with [`tools/native-usage.ps1`](/scripting/native-usage.md) (build 3725). Example caps and stalls from script mods on a low-end test PC. What each simulation costs per frame is **Known** (general engine knowledge) until the test cards are run; pool sizes and script counts are **Verified**. This is a first pass: the per-effect numbers on this PC are still to be measured (test cards).

## 11.1 Short version

- **The engine sizes physics by pools.** Vanilla: `phInstGta` 10,030 physics instances, `PhysicsBounds` 1,450, `StaticBounds` 14,700, `Object` 2,300, `CMoveObject` 300, `ClothStore` 60, `PtFxSortedEntity` 384. Hitting a pool limit makes new things fail to appear; it doesn't slow the game. Cost comes from how many of them are **active** (moving, colliding) at once.
- **A heavily modded `gameconfig.xml` (from a test install) raises most physics pools:** `phInstGta` to 18,000, `StaticBounds` to 46,700, `ClothStore` x10 (600), `CMoveObject` x2 (620), `FragmentStore` x7 (299,000), and adds explicit pools the vanilla file doesn't list: `fraginstgta` 5,000, `wheels` 3,000, `ropedata` 28, `vehicleglasscomponententity` 256, bullets 60 and 128 instances. More slots, more reserved memory; not more speed.
- **Rockstar's main physics brake is freezing:** `FREEZE_ENTITY_POSITION` is called 41,519 times in 663 scripts. Props placed for missions are frozen unless they must move; `SET_ENTITY_DYNAMIC` (3,665 calls) and `ACTIVATE_PHYSICS` (744) wake things up only when needed.
- **Cleanup is the second brake:** `CLEAR_AREA` (3,180 calls), `CLEAR_AREA_OF_VEHICLES` (1,999), `CLEAR_AREA_OF_OBJECTS` (1,461), `CLEAR_AREA_OF_PEDS` (781), `CLEAR_AREA_OF_PROJECTILES` (463), `STOP_FIRE_IN_RANGE` (960), `REMOVE_DECALS_IN_RANGE` (219), run before and after set pieces.
- **Ragdolls and breaking are switched off where not wanted:** `SET_PED_CAN_RAGDOLL` (1,760 calls), `SET_RAGDOLL_BLOCKING_FLAGS` (718), `SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT` (1,208), `SET_VEHICLE_CAN_BREAK` (690), `SET_DISABLE_FRAG_DAMAGE` (149), `SET_DISABLE_BREAKING` (52).
- **Density is cut per frame:** `SET_VEHICLE_DENSITY_MULTIPLIER_THIS_FRAME` (549 calls), `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME` (321), plus scenario, random and parked vehicle multipliers, so mission spawns don't add to full ambient traffic.
- **On a low-end test PC the worst physics-heavy moments were traffic set pieces:** a script mod staging crashes logged ticks of 1,000 ms and 8,758 ms with 2 cars and a helicopter out. Those ticks include whole-game stalls, so they show where to measure, not what physics alone costs.

## 11.2 The pools, vanilla and modded

| Pool | Holds | Vanilla | Modded file |
| --- | --- | ---: | ---: |
| `phInstGta` | Physics instances (anything that can collide and move) | 10,030 | 18,000 |
| `PhysicsBounds` | Bounds for dynamic physics | 1,450 | 1,450 |
| `StaticBounds` | Static collision (map) bounds | 14,700 | 46,700 |
| `Object` | Props as entities | 2,300 | 2,300 |
| `CMoveObject` | Moving-object controllers | 300 | 620 |
| `Dummy Object` | Map objects not yet turned into physics objects | 10,010 | 15,000 |
| `FragmentStore` | Breakable (fragment) models, slots | 41,500 | 299,000 |
| `fraginstgta` | Fragment instances (broken-off parts) | engine default | 5,000 |
| `ClothStore` | Cloth (flags, tarps, clothes that simulate) | 60 | 600 |
| `ropedata` | Ropes | engine default | 28 |
| `wheels` | Vehicle wheels | engine default | 3,000 |
| `vehicleglasscomponententity` | Shattering vehicle glass | engine default | 256 |
| `cbullet`, `cbullet::sbulletinstance` | Bullets in flight | engine default | 60, 128 |
| `PtFxSortedEntity`, `PtFxAssetStore` | Particle effects attached to entities, effect assets | 384, 400 | 1,000, 600 |
| `MaxAttrsExplosion`, `MaxAttrsDecal`, `MaxAttrsParticle` | Map-placed explosion, decal and particle effects | 50, 50, 2,500 | 200, 200, 5,000 |
| `ExplosionType` | Explosion types | | 18 ([memory and pools](/docs/core/memory-and-pools.md)) |

"Engine default" means the vanilla file doesn't name the pool; the executable's built-in size applies (**Known**). The modded file's own comments say some entries "appear to not use" the value.

## 11.3 What costs what

| Simulation | Why it costs (**Known**) | What scripts use to control it |
| --- | --- | --- |
| **Ragdolls (Euphoria / NaturalMotion)** | Each active ragdoll runs a full-body physics and behaviour simulation; the most expensive per-ped cost. The engine limits how many run as Euphoria at once and falls back to simpler ragdolls | `SET_PED_CAN_RAGDOLL`, `SET_RAGDOLL_BLOCKING_FLAGS`, `SET_PED_CAN_RAGDOLL_FROM_PLAYER_IMPACT`, `SET_PED_TO_RAGDOLL` (174 scripts start one on purpose) |
| **Vehicles** | Wheels, suspension and collisions every frame; crashes add deformation and fragments | Density multipliers, `SET_VEHICLE_CAN_BREAK`, `SET_VEHICLE_WHEELS_CAN_BREAK`, freezing parked set-dressing vehicles |
| **Breaking objects and glass** | Fragments become new physics instances | `SET_DISABLE_FRAG_DAMAGE`, `SET_DISABLE_BREAKING`, `CLEAR_AREA_OF_OBJECTS` |
| **Explosions and fire** | Push forces on everything in range, start fires and ragdolls, spawn debris and particles | `ADD_EXPLOSION` (501 calls), `ADD_OWNED_EXPLOSION` (54), `STOP_FIRE_IN_RANGE`, `START_SCRIPT_FIRE` (17) |
| **Projectiles and bullets** | Each bullet is traced; projectiles are physics objects | `CLEAR_AREA_OF_PROJECTILES` |
| **Ropes and cloth** | Per-segment simulation | `ADD_ROPE` (45 calls) / `DELETE_ROPE` (72), cloth pool |
| **Decals** | Draw cost, not physics, but they come with every crash and shot | `REMOVE_DECALS_IN_RANGE`, `REMOVE_DECALS_FROM_VEHICLE`, `REMOVE_DECALS_FROM_OBJECT` |
| **Many props** | Only active ones cost; frozen ones are almost free | `FREEZE_ENTITY_POSITION` (41,519 calls), `SET_ENTITY_DYNAMIC`, `ACTIVATE_PHYSICS` |

## 11.4 How Rockstar keeps physics cheap

1. **Freeze by default.** Mission props are created and frozen; they're unfrozen (`SET_ENTITY_DYNAMIC`, `ACTIVATE_PHYSICS`) only when the player can interact with them.
2. **Clear before and after.** Set pieces start with `CLEAR_AREA*` around the spot (removing ambient cars, peds, objects, projectiles, fires and decals) and end the same way in cleanup ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).
3. **Thin the crowd during action.** Density multipliers are set to 0 or lowered every frame while a mission runs, so ambient population doesn't add to the mission's own spawns.
4. **Switch off what isn't needed.** Ragdoll from player impact off for allies and important peds, frag damage and breaking off for mission-critical props and vehicles.
5. **Count frames.** Expensive checks run every N frames (`GET_FRAME_COUNT() % 60`, [measuring performance](/docs/performance/measuring.md#frame-timing-from-a-script)).

## 11.5 Example caps on a low-end test PC

| Mod type | Caps that played acceptably | What it spawns |
| --- | --- | --- |
| Outbreak set-piece script | 2 incidents, 8 peds at once | Police chases, beatings, crashes, helicopters |
| Zombie spawner | 45 zombies (mod default 140), 6 vehicles (default 14) | Zombies and wrecks |
| Normal play, population density 0.0 | 33 to 34 peds, 82 to 95 vehicles, 574 to 599 props (peaks) | Ambient population |

The set-piece script logged slow ticks of 209, 254, 628, 1,000 and 8,758 ms while it had 1 to 3 cars and 1 helicopter out. Those are real-time ticks, so they include streaming and everything else; the 8.8 s one is most likely a streaming or load stall, not physics. They mark the moments to test with physics in mind.
## 11.6 Proposed budgets for a low-end PC (to be confirmed by the tests)

Until measured, keep mods at or under these (based on Rockstar's own set pieces, which rarely run more than a handful of simultaneous ragdolls or wrecks, and on the caps above that already play acceptably):

| Effect | Budget at once | Why |
| --- | ---: | --- |
| Ragdolling peds (script-made) | 4 | Euphoria is the most expensive per-ped cost |
| Script-spawned moving vehicles | 6 (plus ambient at reduced density) | Each adds wheels, AI driving and collisions |
| Wrecks left in the world | 4, then delete the oldest | Deformed vehicles keep their fragments |
| Explosions per second | 1 | Each one ragdolls, fires and spawns debris |
| Unfrozen script props | 10 | Freeze the rest |
| Fires | 2 areas | Fire spreads and lights things |

## 11.7 What this means for modders

- **Freeze what you place,** unfreeze on interaction.
- **Clear the area** of ambient vehicles and objects before a set piece, and of wrecks, fires, projectiles and decals after.
- **Cap and recycle:** keep a list of what you spawned and delete the oldest wreck or ped when over budget.
- **Lower density during action** with the `*_DENSITY_MULTIPLIER_THIS_FRAME` natives (they must be called every frame).
- **Measure the set piece,** not the mod: run it with a frame-time log ([measuring performance](/docs/performance/measuring.md)) and look at the hitches during the crash or explosion.

## 11.8 Open questions

| Question | Where it goes |
| --- | --- |
| How many Euphoria ragdolls the engine runs at once before falling back, and what one costs on a low-end PC | Test card 1 |
| Cost of a vehicle crash, an explosion, a fire, on a low-end PC | Test cards 2 and 3 |
| Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels | R18.3, compare with the vanilla file |

## 11.9 Test cards

Run each with a frame-time log on (hitches and samples; see [measuring performance](/docs/performance/measuring.md)), in the same spot (an empty car park), VSync off, a minute of standing still first as the baseline.

1. **Ragdolls:** with a trainer, spawn 5, then 10, then 20 peds and knock them down together (explosion at a distance, or set them to ragdoll). Note the FPS drop and hitches at each step.
2. **Crashes:** spawn 5 cars and push them into each other at speed; then 10. Note the drop and how long it lasts.
3. **Explosions and fire:** set off 1, then 3 explosions a second apart near parked cars. Note the drop.
4. **A set piece:** run a mod's crash or explosion scene and line up its own log with the frame-time log at the same second.
