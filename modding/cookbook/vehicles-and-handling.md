# Cookbook: vehicles and handling

New handling, spawned cars, AI drivers. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Handling data | [vehicle handling](/docs/physics/vehicle-handling.md), [`handling.meta`](/file-formats/handling-meta.md) |
| Vehicle definitions and DLC cars | [vehicles](/docs/entities/vehicles/vehicles.md), [DLC packs](/docs/entities/vehicles/dlc-packs.md) |
| AI driving | [driving](/docs/ai/driving.md), [driving AI](/docs/ai/driving-ai.md) |
| Aircraft | [flying](/docs/gameplay/player/flying.md) |
| Traffic and parked cars | [vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) |
| Names | [text and names](/docs/entities/objects/text-and-names.md) |

## Natives and files

- Data: `handling.meta` (physics; `<AIHandling>` for AI), `vehicles.meta` (model, layout, flags), `carcols.meta`, `carvariations.meta`.
- Spawn: `REQUEST_MODEL` … `CREATE_VEHICLE`, `SET_VEHICLE_ON_GROUND_PROPERLY`, `SET_VEHICLE_AS_NO_LONGER_NEEDED`.
- Drive: `TASK_VEHICLE_DRIVE_TO_COORD` with a driving style (786,603 careful, 786,468 rushed), `TASK_VEHICLE_MISSION_PED_TARGET` for chases.
- Aircraft: `SET_HELI_BLADES_FULL_SPEED`, `CONTROL_LANDING_GEAR`.

## Traps

- **Editing the base `handling.meta`** in a replaced `update.rpf` breaks on every update; put new cars and handling in an add-on DLC pack.
- **`vehicles.meta` and `handling.meta` names must match** (`handlingId`), or the car spawns with default handling.
- **Supercars driving like sedans under AI:** set `SPORTS_CAR` AI handling.
- **Vehicle pool:** 300 vehicles in all; clean up what you spawn.

## Minimal pattern: an add-on car

1. Make a DLC pack with the model files, `vehicles.meta`, `handling.meta`, `carcols.meta`, `carvariations.meta`, and a `content.xml` registering them ([archives and content](/docs/core/archives-and-content.md)).
2. Add the pack to `dlclist.xml` in the mods folder.
3. Give it a name label so the HUD shows a name ([text and names](/docs/entities/objects/text-and-names.md)).
4. Spawn it by model name from a script or trainer.

**Quick test:** spawn the car; its name shows on entering, it drives with your handling, and an AI driver can take it around a corner.
