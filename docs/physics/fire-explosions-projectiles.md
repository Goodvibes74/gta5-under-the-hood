# Fire, explosions and projectiles

How explosions are defined (damage at the centre and the edge, radius, push, camera shake, fire), which materials burn and for how long, how thrown and fired projectiles are set up, and how scripts start fires and explosions. Roadmap topic **R2.5** in the [roadmap](/ROADMAP.md). Builds on [weapons](/docs/gameplay/weapons/weapons.md) (`weapons.meta` and the damage model), [collision and materials](/docs/physics/collision-and-materials.md) (the materials fire reads) and [physics cost](/docs/performance/physics-cost.md) (what fire and explosions cost). Particles and decals are R13.3.

**How it was made.** Data files extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) from `common.rpf`, `update\update.rpf` and every DLC pack's `dlc.rpf`: `update:/x64/data/metadata/explosion.ymt` (converted to XML), each DLC's `common:/data/explosion.meta` (16 packs register one in `content.xml` as `EXPLOSION_INFO_FILE`, found with [`tools/dlc-scan.ps1`](/tools/README.md)), the update copies of `explosionfx.dat` and `weapons.meta`, the base `firefx.dat`, and the DLC weapon files. Native use from the [FIRE](/scripting/native-usage/FIRE.md), [WEAPON](/scripting/native-usage/WEAPON.md) and [VEHICLE](/scripting/native-usage/VEHICLE.md) usage pages; explosion types passed to `ADD_EXPLOSION` counted with one `git grep -o` over every decompiled script (commit `6c18d3e8b`, literal arguments only). Build 1.0.3725.0 Legacy. Values and counts are **Verified**; what the engine does with each field is **Known** unless stated.

## Short version

- **85 explosion types.** 36 in the base game's `explosion.ymt` (`EXP_TAG_GRENADE` to `EXP_TAG_BIRD_CRAP`) and 49 added by 16 DLC packs (`EXP_TAG_ORBITAL_CANNON`, `EXP_TAG_RAILGUNXM3`, the vehicle mines, the bombs ...). The position in the list is the number scripts pass to `ADD_EXPLOSION` (**Known**: the order matches NativeDB's explosion tag list).
- **Each type sets damage, radius and push:** a grenade does 500 at the centre and 75 at its 5 m edge with a force factor of 60; a tank shell 3,000 and 300; a molotov 30 and 4 over 3 m (the fire does the rest); bullets from explosive weapons 200 and 50 over 2 m.
- **Fire depends on the surface.** `firefx.dat` lists 69 material groups; 22 can burn. Paper, leaves, hay and grass catch fully (flammability 1.0) and burn 3.25 to 3.5 s per patch; wood 0.8 for 5 s; plastic, carpet and meat 0.4 to 0.6 for 10 to 12 s; rubber 0.2 for 15 s. Tarmac, stone, glass, metal and all liquids don't burn (0.0).
- **80 projectile ammo types:** 17 in the base `weapons.meta` (3 fired grenades and shells, 6 rockets, 8 thrown) and 63 in DLC packs (34 fired, 24 rockets, 5 thrown). Each names the explosion it makes.
- **Scripts mostly react to fire and explosions rather than make them.** `IS_ENTITY_ON_FIRE` is in 540 scripts and `STOP_FIRE_IN_RANGE` in 442, but `START_SCRIPT_FIRE` in only 7 and `ADD_EXPLOSION` in 146. The type scripts set off most is the grenade (63 literal calls).
- **Vehicles have their own rules:** `SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE` (323 scripts), `SET_DISABLE_VEHICLE_PETROL_TANK_FIRES` (32), `SET_DISABLE_VEHICLE_ENGINE_FIRES` (21), `EXPLODE_VEHICLE` (39).

## Where it lives

| File | What it holds | Count (build 3725) |
| --- | --- | --- |
| `update:/x64/data/metadata/explosion.ymt` | Explosion types (`CExplosionTagData`): damage at centre, middle and edge, radius, speed, force, ragdoll force, camera shake, fire, vehicle effects (EMP, slick, tyre pop), the VFX tag | 36 |
| `common:/data/explosion.meta` in DLC packs | More explosion types, same format (as XML) | 49 in 16 packs |
| `common:/data/effects/explosionfx.dat` (update copy) | Each VFX tag's particle effects (ground, air, LOD), scale, scorch decals, and the fires it leaves (number, range, burn time and strength, fuel) | One row per `EXP_VFXTAG_*` |
| `common:/data/effects/firefx.dat` | Per material group: flammability, burn time, burn strength, the map fire effect | 69 groups, 22 flammable |
| `common:/data/ai/weapons.meta` (update copy) and DLC weapon files | Ammo, including `CAmmoProjectileInfo`, `CAmmoRocketInfo` and `CAmmoThrownInfo` (lifetime, launch speed, the explosion it makes) | 17 base, 63 DLC |
| `common:/data/gameconfig.xml` | `MaxAttrsExplosion` 50 (explosion attributes on map objects); each script is expected to own at most 32 fires (`ConfigScriptResourceExpectedMaximums`, `FIRE` 32) | R1.4 |

### The base explosion types

From `explosion.ymt`. Damage is in health points (a player has 100 usable, R3.8); radius in metres; force is the push factor.

| Type | Centre | Edge | Radius | Force | Frag damage | Camera shake | Sets peds on fire |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| `GRENADE`, `GRENADELAUNCHER` | 500 | 75 | 5 | 60 | 1,500 | 0.6 | yes |
| `STICKYBOMB` | 500 | 75 | 5 | 80 | 1,500 | 0.6 | yes |
| `ROCKET` | 500 | 50 | 5 | 80 | 1,500 | 0.7 | yes |
| `TANKSHELL` | 3,000 | 300 | 5 | 100 | 1,500 | 0.8 | no |
| `PLANE_ROCKET` | 500 | 50 | 5 | 80 | 2,000 | 0.7 | no |
| `MOLOTOV` | 30 | 4 | 3 | 0.001 | 0 | 0 | no (the fire does it) |
| `CAR`, `BIKE` | 500 | 50 | 5 | 60, 30 | 1,500 | 0.7, 0.4 | no |
| `TRUCK`, `PLANE`, `BLIMP` | 500 | 50 | 8 | 8 | 1,500 | 1.0 | no |
| `BOAT` | 500 | 50 | 7 | 12 | 1,500 | 1.0 | no |
| `TRAIN`, `SHIP_DESTROY` | 500 | 200 | 8 | 60 | 1,500 | 1.0, 0.8 | no |
| `HI_OCTANE`, `TANKER` | 500 | 50 | 10 | 30, 3 | 1,500 | 0.7, 1.0 | no |
| `GAS_TANK` | 500 | 75 | 10 | 30 | 1,500 | 1.0 | yes |
| `PETROL_PUMP` | 500 | 50 | 8 | 28 | 1,500 | 0.9 | no |
| `BARREL` | 200 | 75 | 5 | 50 | 100 | 0.5 | no |
| `GAS_CANISTER`, `PROPANE` | 50 | 75 | 3 | 30 | 100 | 0.4, 0.8 | no |
| `BULLET` (explosive rounds) | 200 | 50 | 2 | 10 | 1,500 | 0.05 | no |
| `VEHICLE_BULLET`, `PROGRAMMABLEAR` | 200 | 20 | 2 | 5, 10 | 1,500 | 0.05, 0.1 | no |
| `DIR_FLAME`, `DIR_FLAME_EXPLODE` | 30 | 4 | 2.5 | 3 | 100, 0 | 0 | no |
| `DIR_GAS_CANISTER` | 500 | 50 | 2.5 | 6 | 0 | 0 | no |
| `DIR_STEAM` | 0.03 | 0.03 | 3 | 1 | 0 | 0 | no |
| `DIR_WATER_HYDRANT` | 0 | 0 | 6 | 12 | 0 | 0 | no |
| `SMOKEGRENADE`, `BZGAS` | 0.15 | 0.075 | 3 | 0 | 0 | 0 | no |
| `SMOKEGRENADELAUNCHER`, `FLARE`, `EXTINGUISHER`, `BIRD_CRAP` | 0 | 0 | 1 to 6 | 0 to 4 | 0 or 1 | 0 | no |

`DIR_*` types are directed (a jet, not a ball). `bAppliesContinuousDamage` is on for steam, smoke, tear gas and the flare: they keep hurting while you stand in them.

**Known (engine):** damage falls from `damageAtCentre` to `damageAtEdge` across `endRadius` (with an optional `midRadius` / `damageAtMid` step, unused by the base types: −1), and is scaled by `networkPlayerModifier` and `networkPedModifier` in Online. `fragDamage` breaks breakable objects and vehicle parts. `forceFactor` and `fRagdollForceModifier` push objects and peds.

### What DLC packs add

| Pack | Explosion types |
| --- | --- |
| `mpheist` | `VALKYRIE_CANNON` |
| `mpapartment` | `AIR_DEFENCE` |
| `mpchristmas2` | `PROXMINE`, `SNOWBALL` |
| `mpbiker` | `PIPEBOMB` |
| `mpgunrunning` | `VEHICLEMINE`, `EXPLOSIVEAMMO`, `APCSHELL` |
| `mpsmuggler` | `BOMB_CLUSTER`, `BOMB_CLUSTER_SECONDARY`, `BOMB_GAS`, `BOMB_INCENDIARY`, `BOMB_STANDARD`, `BOMBUSHKA_CANNON`, `HUNTER_BARRAGE`, `HUNTER_CANNON`, `ROGUE_CANNON` |
| `mpchristmas2017` | `TORPEDO`, `TORPEDO_UNDERWATER`, `MINE_UNDERWATER`, `ORBITAL_CANNON`, `BOMB_STANDARD_WIDE`, `EXPLOSIVEAMMO_SHOTGUN` |
| `mpbattle` | `OPPRESSOR2_CANNON` |
| `mpchristmas2018` | `MORTAR_KINETIC`, `VEHICLEMINE_KINETIC`, `VEHICLEMINE_EMP`, `VEHICLEMINE_SPIKE`, `VEHICLEMINE_SLICK`, `VEHICLEMINE_TAR`, `SCRIPT_DRONE`, `SCRIPT_MISSILE`, `RAYGUN`, `BURIEDMINE` |
| `mpheist3` | `RCTANK_ROCKET` |
| `mpsum` | `BOMB_WATER`, `BOMB_WATER_SECONDARY` |
| `mpheist4` | `SCRIPT_MISSILE_LARGE`, `SUBMARINE_BIG` |
| `mpsecurity` | `EMPLAUNCHER_EMP` |
| `mp2023_01` | `BALANCED_CANNONS` |
| `mp2024_02` | `UNDERWATER_BOMB`, `MFH_GAS_CANISTER`, `MFH_MILITARY_EXPLOSIVE`, `SCARAB_KINETIC`, `TITAN2_25MM_CANNON`, `TITAN2_40MM_CANNON`, `TITAN2_105MM_CANNON` |
| `mpchristmas3` | `RAILGUNXM3` |

The vehicle-mine types use the fields the base types leave off: `bApplyVehicleEMP`, `bApplyVehicleSlick`, `bApplyVehicleSlowdown`, `bApplyVehicleTyrePop`.

## Fire

**Verified (data):** `firefx.dat` gives each material group a flammability (0 to 1), a burn time (seconds), a burn strength and a fire effect (`fire_map_quick` or `fire_map_slow`). The 22 that burn:

| Material groups | Flammability | Burn time (s) | Strength | Effect |
| --- | ---: | ---: | ---: | --- |
| `PAPER`, `CARDBOARD`, `HAY`, `GRASS`, `GRASS_SHORT` | 1.0 | 3.25 to 3.5 | 1.0 | quick |
| `LEAVES`, `FEATHERS` | 1.0 | 3.5, 4.0 | 0.9 | quick |
| `WOOD`, `WOOD_DUSTY`, `WOOD_SPLINTER`, `FOAM` | 0.8 | 5.0, 6.0 (foam) | 0.8 | quick |
| `TREE_BARK`, `BUSHES` | 0.8 | 3.5 | 0.7 | quick |
| `PLASTIC`, `PLASTIC_HOLLOW`, `CARPET_FABRIC`, `CARPET_FABRIC_DUSTY` | 0.6 | 10.0 | 0.8, 0.9 | slow |
| `FRESH_MEAT`, `DRIED_MEAT` | 0.5 | 12.0 | 0.9 | slow |
| `LINOLEUM` | 0.4 | 10.0 | 0.8 | slow |
| `RUBBER` | 0.2 | 15.0 | 0.9 | slow |
| `CONCRETE` | 0.1 | 0.1 | 0.1 | slow |

**Verified (data):** explosions leave fires through `explosionfx.dat`: a molotov leaves 3 to 4 fires that burn 0.5 to 1.0 s per stage with strength 0.7 to 1.0; a rocket 1 to 3; a petrol pump, a bike, a plane or a boat 1 to 3 with a fuel burn rate; a grenade none.

**Known (engine):** fire spreads from patch to patch over flammable ground (grass fields burn far, roads stop it), sets peds and vehicles on fire, and a burning vehicle's petrol tank eventually explodes. Petrol trails (from a jerry can or a leaking tank) are a separate system: the material `LIQUID_PETROL` has 0 flammability here because the trail itself carries the fire.

## Projectiles

**Verified (data):** the 17 base projectile ammo types in `weapons.meta`:

| Kind | Ammo | Lifetime (s) | Launch speed | Explosion |
| --- | --- | ---: | ---: | --- |
| Fired | `AMMO_GRENADELAUNCHER`, `AMMO_GRENADELAUNCHER_SMOKE` | 30, 35 | 25 | `GRENADELAUNCHER`, `SMOKEGRENADELAUNCHER` |
| Fired | `AMMO_TANK` | 0.5 | 400 | `TANKSHELL` |
| Rocket | `AMMO_RPG`, `AMMO_STINGER` | 5, 20 | 400 | `ROCKET` |
| Rocket | `AMMO_SPACE_ROCKET`, `AMMO_PLANE_ROCKET` | 5, 10 | 1,250, 1,500 | `PLANE_ROCKET` |
| Rocket | `AMMO_PLAYER_LASER`, `AMMO_ENEMY_LASER` | 5 | 1,000, 1,200 | none |
| Thrown | `AMMO_GRENADE` | 4 (the fuse) | 25 | `GRENADE` |
| Thrown | `AMMO_STICKYBOMB`, `AMMO_MOLOTOV`, `AMMO_BALL` | −1 (until triggered or it lands) | 25 | `STICKYBOMB`, `MOLOTOV`, none |
| Thrown | `AMMO_SMOKEGRENADE`, `AMMO_BZGAS` | 5 | 25 | `SMOKEGRENADE`, `BZGAS` |
| Thrown | `AMMO_FLARE` | 62.5 | 25 | `FLARE` |
| Thrown | `AMMO_BIRD_CRAP` | 4 | 1 | `BIRD_CRAP` |

DLC packs add 63 more (34 fired, such as cannons and launchers; 24 rockets, such as homing and vehicle missiles; 5 thrown, such as the pipe bomb and the proximity mine). The full weapon side is in [weapons](/docs/gameplay/weapons/weapons.md).

## How scripts use it

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `IS_ENTITY_ON_FIRE` | 540 | 6,023 | Is a ped or vehicle burning |
| `STOP_FIRE_IN_RANGE` | 442 | 960 | Put out fires around a point (mission starts, cutscenes) |
| `SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE` | 323 | 1,010 | Whether a big hit blows the vehicle up at once |
| `GET_NUMBER_OF_FIRES_IN_RANGE` | 273 | 299 | Count fires |
| `CLEAR_AREA_OF_PROJECTILES` | 262 | 463 | Remove live grenades and rockets (mission starts, cutscenes) |
| `IS_PROJECTILE_IN_AREA`, `IS_PROJECTILE_TYPE_WITHIN_DISTANCE` ... | 163, 89 | 220, 338 | Spot a thrown grenade or sticky bomb (peds react, missions fail) |
| `IS_EXPLOSION_IN_SPHERE`, `IS_EXPLOSION_IN_AREA`, `IS_EXPLOSION_IN_ANGLED_AREA` | 148, 23, 40 | 422, 139, 126 | Detect an explosion somewhere |
| `ADD_EXPLOSION` / `ADD_OWNED_EXPLOSION` | 146 / 17 | 501 / 54 | Make an explosion (owned = blamed on a ped) |
| `TASK_THROW_PROJECTILE` | 105 | 124 | Make a ped throw a grenade |
| `EXPLODE_VEHICLE` | 39 | 117 | Blow up a vehicle |
| `STOP_ENTITY_FIRE`, `START_ENTITY_FIRE` | 40, 14 | 79, 22 | Put out or start a fire on an entity |
| `SET_DISABLE_VEHICLE_PETROL_TANK_FIRES`, `SET_DISABLE_VEHICLE_ENGINE_FIRES` | 32, 21 | 58, 34 | Stop a mission vehicle burning |
| `START_SCRIPT_FIRE` / `REMOVE_SCRIPT_FIRE` | 7 / 4 | 17 / 13 | A fire the script owns (`chinese2`, `josh3`, `armenian2`, `re_accident`, `michael3`, `finalea`) |
| `SET_FLAMMABILITY_MULTIPLIER` | 6 | 10 | Scale how easily things catch (Online content) |
| `EXPLODE_PED_HEAD` | 17 | 30 | Scripted headshot kill |

The explosion types scripts pass to `ADD_EXPLOSION` by number (literal arguments, 123 calls): 0 `GRENADE` 63, 1 `GRENADELAUNCHER` 25, 32 `PLANE_ROCKET` 8, 2 `STICKYBOMB` 7, 4 `ROCKET` 6, 16 `SHIP_DESTROY` 5, then `GAS_TANK`, `DIR_GAS_CANISTER` and `BIKE` twice each and `PLANE`, `CAR` and `BARREL` once.

Map objects that blow up or collapse in story missions are rayfire objects, pre-made destruction animations that scripts trigger: `GET_RAYFIRE_MAP_OBJECT` and `SET_STATE_OF_RAYFIRE_MAP_OBJECT` are in 250 scripts (shared code), and the callers that actually use them include `agency_heist3a`, `family3`, `trevor3`, `prologue1`, `exile3`, `jewelry_heist` and `finale_heist2b`.

## What this means for modders

- **Make an explosion:** `ADD_EXPLOSION(x, y, z, type, damageScale, isAudible, isInvisible, cameraShake)`, with the type number from the order above (0 grenade, 4 rocket, 5 tank shell, 7 car ...). Use `ADD_OWNED_EXPLOSION` so the game blames a ped (wanted level, kill credit). `damageScale` 0 gives the look without the damage.
- **Tune an explosion for everyone** with a data edit: change `damageAtCentre`, `endRadius` or `forceFactor` in a copy of `explosion.ymt` (convert with CodeWalker) or a DLC's `explosion.meta`. Every weapon and vehicle that uses that tag changes with it.
- **Add an explosion type** in your own DLC pack: an `explosion.meta` registered as `EXPLOSION_INFO_FILE` in `content.xml`, as 16 of Rockstar's packs do; its number comes after the existing ones, so look it up by name (`GET_HASH_KEY("EXP_TAG_...")` where a native takes a hash, **Known**) rather than assuming a number.
- **Fires:** `START_SCRIPT_FIRE(x, y, z, maxChildren, isGasFire)` and `REMOVE_SCRIPT_FIRE` when done; `STOP_FIRE_IN_RANGE` to clean up. Fires on grass spread fast and far; fires on tarmac die out.
- **Cost:** every explosion spawns particles, decals, physics impulses and maybe fires; many at once (an airstrike mod) costs GPU and CPU time. See [physics cost](/docs/performance/physics-cost.md) for budgets.
- **Single player only.** Explosions in Online are synced and logged; mods that create them get accounts banned.

## Open questions

| Question | Where it goes |
| --- | --- |
| The exact falloff curve between centre and edge, and how armour takes explosion damage | Test card 1; R3.1 |
| How far and how fast fire spreads, and its limits (number of fires at once) | Test card 2; R18 |
| The meaning of the unnamed boolean fields in `explosion.ymt` (their names didn't resolve) | Second pass |
| The DLC explosion types' numbers, damage and radius | Second pass: tabulate the 16 DLC files |
| The full list of DLC projectiles and their explosions | R3.1 second pass |

## Test cards

1. **Falloff.** Spawn peds at 0, 1, 2, 3, 4 and 5 m from a point and `ADD_EXPLOSION(... 0 /* grenade */, 1.0, true, false, 0.0)` at it; read each ped's health after. Expected: the nearest are dead, the 5 m one loses about 75.
2. **Spread.** Start a fire with `START_SCRIPT_FIRE` on a grass field and on a road; count fires with `GET_NUMBER_OF_FIRES_IN_RANGE` every second for 30 s. Expected: the grass fire grows, the road fire dies.
3. **Molotov.** Throw a molotov on grass and on concrete. Expected: a big spreading fire on grass, a small short one on concrete.
