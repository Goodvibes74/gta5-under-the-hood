# Cookbook: world and map

Placing props, adding or hiding map parts, interiors, doors, time and weather. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| Map files | [map data](/docs/world/map-data.md), [data file atlas](/file-formats/data-file-atlas.md) |
| Interiors and IPLs | [interiors and IPLs](/docs/world/interiors-and-ipls.md) |
| Props and doors | [props and doors](/docs/entities/objects/props-and-doors.md) |
| Placing props like the creator | [Rockstar Creator internals](/docs/online/creator-internals.md) |
| Time and weather | [time and weather](/docs/world/time-and-weather.md) |
| Streaming | [streaming](/docs/core/streaming.md) |
| Navmesh around new objects | [navigation](/docs/ai/navigation.md) |

## Natives and files

- Props by script: `CREATE_OBJECT`, `SET_ENTITY_ROTATION`, `FREEZE_ENTITY_POSITION`, `SET_ENTITY_LOD_DIST` (150 m or more), `ADD_NAVMESH_BLOCKING_OBJECT`.
- Hide a map object: `CREATE_MODEL_HIDE` at its position.
- Map variants: `REQUEST_IPL` / `REMOVE_IPL`; interiors: `ACTIVATE_INTERIOR_ENTITY_SET`.
- Doors: `ADD_DOOR_TO_SYSTEM`, `DOOR_SYSTEM_SET_DOOR_STATE`.
- Permanent additions: new `.ymap` and `.ytyp` in a DLC pack with `DLC_ITYP_REQUEST`.
- Time and weather: `SET_CLOCK_TIME`, `SET_WEATHER_TYPE_NOW_PERSIST`, cleared with `CLEAR_WEATHER_TYPE_PERSIST`.

## Traps

- **Script props vanish at distance** without a raised draw distance.
- **Peds walk through new props** unless you add navmesh blocking objects.
- **Hundreds of props** cost memory and frame time; Rockstar's creator caps a job at 200 static props.
- **Persisting weather or time** must be undone, or the world stays that way.
- **Replacing base ymaps** breaks on updates; add your own in a DLC pack.

## Minimal pattern: a placed scene

1. List the props (model, position, rotation) in a data file.
2. On load: request each model, create, rotate, freeze, set the draw distance, add a navmesh blocker for big ones, release the model.
3. Hide any map object in the way with a model hide.
4. On unload: delete the props and remove the hides and blockers.

**Quick test:** load the scene, drive 500 m away and back; the props stay put and visible from a distance, and peds walk around them.
