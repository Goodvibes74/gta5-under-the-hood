# Ped AI data files

The data that decides how peds sense, react and fight.

| File | Where | What |
| --- | --- | --- |
| `relationships.dat` | `common.rpf\data\` | Relationship groups and their attitudes |
| `pedperception.meta` | `common.rpf\data\` | Sight, hearing and encroachment ranges |
| `events.meta` | `common.rpf\data\`, newer in `update.rpf` | Events, decision makers and responses |
| `combatbehaviour.meta` | `common.rpf\data\ai\`, newer in `update.rpf` | Combat profiles |
| `pedaccuracy.meta` | `common.rpf\data\ai\` | Global accuracy modifiers |
| `pedhealth.meta` | `common.rpf\data\` | Health profiles and thresholds |
| `pedbrawlingstyle.meta`, `action\*.meta` | `common.rpf\data\`, `update.rpf` | Melee styles and the melee action tables |
| `agitated*.meta` | `common.rpf\data\ai\` | Agitation triggers and responses |
| `loadouts.meta` | `update.rpf\common\data\ai\` | Weapon loadouts per ped type |
| `pedpersonality.ymt` | `update.rpf\x64\data\metadata\` | Personalities (binary PSO) |

Contents and values: [combat and perception](/docs/ai/combat-and-perception.md).
