# Player skills and abilities

The story characters' seven skills (stamina, shooting, strength, stealth, flying, driving on two wheels, lung capacity), where they are stored, what each one changes, and the special abilities (Franklin's driving focus, Trevor's red mist, Michael's bullet time) with their numbers. Roadmap topic **R3.6** in the [roadmap](/ROADMAP.md). Builds on [swimming and diving](/docs/gameplay/player/swimming-and-diving.md) (the breath and stamina ranges), [peds](/docs/entities/peds/peds.md) (where a model's ability type is set) and [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md).

**How it was made.** `update:/x64/data/tune/playerinfo.ymt` and `update:/x64/data/playerspecialabilities.ymt` extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and converted to XML; the stat definitions read in the update copies of `common:/data/spstatssetup.xml` and `mpstatssetup.xml`. Which scripts write the skill stats counted with `git grep` on the decompile (commit `6c18d3e8b`); native use from the [PLAYER](/scripting/native-usage/PLAYER.md) and [STATS](/scripting/native-usage/STATS.md) usage pages. Build 1.0.3725.0 Legacy. Data and counts are **Verified**; how each skill feeds the mechanics is **Known** unless stated.

## Short version

- **Seven skills, 0 to 100, per character:** `STAMINA`, `SHOOTING_ABILITY`, `STRENGTH`, `STEALTH_ABILITY`, `FLYING_ABILITY`, `WHEELIE_ABILITY` (bike skill; the menu calls it driving) and `LUNG_CAPACITY` are character stats (`characterStat="true"`, `Min="0" Max="100"`) in `spstatssetup.xml`, stored as `SP0_` (Michael), `SP1_` (Franklin) and `SP2_` (Trevor) stats in the save. Online characters have the same seven in `mpstatssetup.xml`.
- **The engine maps the stat onto ranges** in `playerinfo.ymt`: stamina 10 to 90 seconds of sprinting, breath 10 to 40 seconds, wheelie ability 60 to 120 (Michael), 100 to 120 (Franklin), 72 to 120 (Trevor), plane control 0 to 100, plane and helicopter damping 90 to 110.
- **Scripts write the stats; the engine reads them.** 27 references per script (9 stats × 3 characters) appear in shared helper code compiled into `stats_controller`, `selector`, the mission scripts and others; `stats_controller` is the script that raises them as you play (**Known**: running, cycling and swimming raise stamina, kills raise shooting, and so on).
- **17 special ability entries** in `playerspecialabilities.ymt`, all 30-second-class meters except the newer ones. The story three: Franklin's driving focus slows time to 0.325, Trevor's red mist to 0.8 with double damage, Michael's bullet time to 0.3. All three drain at 0.67 and recharge ×2. A fourth bullet-time entry deals ×5 damage; others are Online abilities (shorter, 1 to 45 seconds).
- **Unlock:** each ability starts capped at 17 (`initialUnlockedCap`); `SPECIAL_ABILITY_UNLOCKED` (0 to 100) is the current size of the meter, grown by missions and use. `SPECIAL_ABILITY_UNLOCK` is called by 13 scripts (the character introductions, `flow_controller`).
- **Missions control the ability tightly:** `SPECIAL_ABILITY_DEACTIVATE_FAST` (568 scripts), `IS_SPECIAL_ABILITY_ACTIVE` (488), `SPECIAL_ABILITY_CHARGE_ON_MISSION_FAILED` (96: a little charge after every fail), `ENABLE_SPECIAL_ABILITY` (24), `SPECIAL_ABILITY_FILL_METER` (15).

## Where it lives

| File | What it holds |
| --- | --- |
| `common:/data/spstatssetup.xml` | Story stat definitions (1,746 stats), including the seven skills and the ability stats (`SPECIAL_ABILITY`, `SPECIAL_ABILITY_UNLOCKED`, `SPECIAL_ABILITY_ACTIVE_NUM`, `SPECIAL_ABILITY_ACTIVE_TIME`, the `*_MAXED` flags) |
| `common:/data/mpstatssetup.xml` | The Online twins |
| `x64/data/tune/playerinfo.ymt` | Per-character ranges the stats scale between (`PlayerStatInfos`) |
| `x64/data/playerspecialabilities.ymt` | Ability entries: duration, initial cap, time scale, damage, defence, stamina, sprint and steering multipliers, drain and charge rates, the screen effect |
| `x64/data/peds.ymt` | Which ability a model has (`AbilityType`: `SAT_CAR_SLOWDOWN` Franklin, `SAT_RAGE` Trevor, `SAT_BULLET_TIME` Michael) |

### What each skill changes

| Skill | Range in `playerinfo.ymt` | Effect (**Known**) |
| --- | --- | --- |
| Stamina | 10 to 90 s of sprint | How long you sprint, cycle and swim before tiring |
| Lung capacity | 10 to 40 s of breath | Time underwater ([R3.5](/docs/gameplay/player/swimming-and-diving.md)) |
| Wheelie (bike) | 60/100/72 to 120 | How long wheelies last and how well bikes are controlled; Franklin starts best |
| Flying | plane control 0 to 100, damping 90 to 110 | How much turbulence moves aircraft and how stable they are |
| Shooting | (no range in this file) | Weapon sway and recoil, reload speed, accuracy |
| Strength | (no range) | Melee damage, falls from height |
| Stealth | (no range) | How quietly you move while sneaking |

Stats that have no range in `playerinfo.ymt` (shooting, strength, stealth) are read elsewhere in the engine (**Known**).

### The special abilities

| Entry | Duration | Start cap | Time scale | Damage | Defence | Other | Drain / charge | Effect |
| ---: | ---: | ---: | ---: | ---: | ---: | --- | --- | --- |
| 0 | 30 | 17 | 0.325 | ×1 | ×1 | | 0.67 / ×2 | `DrivingFocus` (Franklin) |
| 1 | 30 | 17 | 0.8 | ×2 | ×1 | | 0.67 / ×2 | `REDMIST` (Trevor) |
| 2 | 30 | 17 | 0.3 | ×1 | ×1 | | 0.67 / ×2 | `BulletTime` (Michael) |
| 3 | 30 | 17 | 1.0 | ×5 | ×1 | | 0.67 / ×2 | `BulletTime` |
| 4 | 30 | 12 | 0.85 | ×1 | ×0.1 | | 0.67 / ×3 | `REDMIST` |
| 5 | 30 | 30 | 1.0 | ×1 | ×0.6 | stamina ×0.4 | 1 / 1 | (Online) |
| 6 | 20 | 20 | 1.0 | | | | 1 / 1 | (Online) |
| 7 | 30 | 30 | 1.0 | | | sprint ×1.25 | 1 / 1 | (Online) |
| 8 to 16 | 1 to 45 | | 1.0 | | | steering ×0.8 on three | 1 / 1 | (Online) |

The order of entries follows the ability type list (**Known**); entries 0 to 2 are the three story abilities by their screen effects. Entry 4 (Trevor's effect, defence ×0.1, i.e. taking a tenth of the damage) is a stronger red mist; which model uses it is not settled.

## How scripts use them

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `SPECIAL_ABILITY_DEACTIVATE_FAST` | 568 | 633 | End the ability at once (cutscenes, switches) |
| `IS_SPECIAL_ABILITY_ACTIVE` | 488 | 657 | Is it running |
| `SPECIAL_ABILITY_DEACTIVATE` | 134 | 167 | End it with the effect fading out |
| `SPECIAL_ABILITY_CHARGE_ON_MISSION_FAILED` | 96 | 96 | Top up after a fail |
| `ENABLE_SPECIAL_ABILITY`, `IS_SPECIAL_ABILITY_ENABLED` | 24, 7 | 57, 11 | Block it for a section |
| `SPECIAL_ABILITY_FILL_METER`, `SPECIAL_ABILITY_CHARGE_NORMALIZED`, `_ABSOLUTE` | 15, 13, 5 | | Fill or charge (the cheat, tutorials) |
| `SPECIAL_ABILITY_UNLOCK`, `SPECIAL_ABILITY_LOCK`, `SPECIAL_ABILITY_RESET` | 13, 9, 11 | | Unlock per character, lock in the prologue and director mode |
| `UPDATE_SPECIAL_ABILITY_FROM_STAT` | 4 | 5 | Resize the meter from `SPECIAL_ABILITY_UNLOCKED` |
| `RESET_PLAYER_STAMINA` | 76 | 95 | Refill stamina |
| `SET_RUN_SPRINT_MULTIPLIER_FOR_PLAYER`, `SET_SWIM_MULTIPLIER_FOR_PLAYER` | 18, 18 | 87, 86 | Speed (Online modes; 1.0 to 1.49, **Known**) |
| `SET_PLAYER_WEAPON_DAMAGE_MODIFIER`, `SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER` | 78, 73 | 130, 123 | Damage multipliers (Rampages, Online) |

## What this means for modders

- **Read or set a skill:** `STAT_GET_INT` / `STAT_SET_INT` on `SP0_STAMINA` (Michael), `SP1_...` (Franklin) or `SP2_...` (Trevor), 0 to 100. Changes take effect for the engine when it next reads the stat; for the special ability, call `UPDATE_SPECIAL_ABILITY_FROM_STAT` (**Known**).
- **Change what a skill does** with a data edit: the ranges in `playerinfo.ymt` (longer sprints, longer breath) or the ability numbers in `playerspecialabilities.ymt` (a slower bullet time, a longer red mist).
- **Give a model an ability** through its `AbilityType` in `peds.meta` (an add-on ped can have Michael's bullet time).
- **Stats are saved:** edits to `SPx_` stats persist in the save; keep a backup before experimenting.
- **Single player only.** Online skill stats are server-checked.

## Open questions

| Question | Where it goes |
| --- | --- |
| How much each activity raises each skill (the `stats_controller` rules) | Second pass: read `stats_controller` |
| What shooting, strength and stealth change, in numbers | In-game tests |
| Which ability type each entry 3 to 16 is | Second pass with the ability type list |
| The starting skill values of each character in a new game | Second pass: `initial` / `flow_controller` |

## Test cards

1. **Stamina.** Set `SP1_STAMINA` to 0, sprint and time it; set 100 and repeat. Expected: about 10 s and 90 s.
2. **Ability numbers.** Use Franklin's ability for its full length and time it. Expected: up to 30 s of slow motion at about a third of normal speed.
3. **Flying.** Fly the same route in turbulence with `SP0_FLYING_ABILITY` at 0 and 100. Expected: much less buffeting at 100.
