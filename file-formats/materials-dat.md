# materials.dat and related material files

The collision material table: 213 materials with friction, elasticity, density, tyre grip, wet grip, tyre drag, top-speed multiplier, bullet penetration resistance and flags (see-through, shoot-through, no decal, porous, heats tyres).

| File | Where | What |
| --- | --- | --- |
| `materials.dat` | `common.rpf\data\materials\`, newer copy in `update\update.rpf\common\data\materials\` | The table (tab-separated text with a documented header) |
| `material_override_pairs.dat` | same folder | Combined friction and elasticity for material pairs (none active) |
| `procedural.meta` | same folder | What grows procedurally on each material |
| `rumbleprofiles.meta` | same folder | Controller rumble per surface |
| `materialfx.dat` | `common.rpf\data\effects\` | Particles and decals per material group |

Columns and values: [collision and materials](/docs/physics/collision-and-materials.md). Material indices are positions in the table, so the order must never change.
