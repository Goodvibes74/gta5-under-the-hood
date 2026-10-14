# handling.meta

Vehicle physics data: one `CHandlingData` entry per handling name, with sub-handling blocks for cars, bikes, aircraft, boats, submarines, trailers and vehicle weapons.

| | |
| --- | --- |
| Where | `update\update.rpf\common\data\handling.meta` (base, 254 entries), `update\update.rpf\dlc_patch\<pack>\common\data\handling.meta` (patches), each DLC pack's own `handling.meta` (544 more) |
| Format | XML (`CHandlingDataMgr` > `HandlingData` > `Item type="CHandlingData"`) |
| Linked from | `vehicles.meta` (`handlingId`) |
| Edit safely | In an add-on pack's own file, or a copy in the mods folder that starts from the current game version |

Fields, ranges, flags and sub-handling blocks: [vehicle handling](/docs/physics/vehicle-handling.md).
