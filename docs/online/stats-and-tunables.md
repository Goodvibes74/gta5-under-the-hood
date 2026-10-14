# Stats, tunables and the server's role

What GTA Online keeps in stats and how they're shaped, what the server owns, where every tunable gets its default value, how purchases go through the transaction server, and what an offline Online mode has to replace locally. Roadmap topic **R7.3** in the [roadmap](/ROADMAP.md). Extends [how Online works](/docs/online/01-how-online-works.md) sections 1.4 to 1.6 and [Online data files](/docs/online/03-online-data-files.md); builds on [transitions and sessions](/docs/online/transitions-and-sessions.md) (the stats load in the transition).

**How it was made.** `update\update.rpf\common\data\mpstatssetup.xml` (4.8 MB) extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and parsed with PowerShell's XML reader; `tuneables_processing` (36,347 lines, build 3725, commit `6c18d3e8b`) read and its tunable registrations counted with `grep`; native use from [`tools/native-usage.ps1`](/scripting/native-usage.md). Counts and file fields are **Verified**; what the server does with them is **Known**.

## 10.1 Short version

- **17,928 stats** in `mpstatssetup.xml` (the XML parser's count; a text-line count gives 17,933). 17,177 are per character, 13,630 are `ServerAuthoritative`, 17,244 are owned by scripts and 684 by the game code.
- **Most of the save is packed:** 6,403 packed stats (6,262 packed ints holding several small values each, 141 packed bools of 64 flags each, about 9,000 flags), plus 9,445 plain ints, 751 `u64`, 662 bools, 180 floats, 149 strings, 70 dates and 38 positions.
- **Stats come in families by name:** `MPSV_` (4,389, saved script variables), the per-update packed families (`DLC22023PSTAT_` 1,098, `DLC22025PSTAT_` 638, `IMPEXPPSTAT_` 714, `BUSINESSBATPSTAT_` 383, `ARENAWARSPSTAT_` 355 ...), `MPPLY_` (627, per player not per character), `CHAR_` (468), `AWD_` (392 awards), `CLTHS_` (201 clothes), `TATTOO_` (176), `ADMIN_` (202) and more. Each update adds its own packed family.
- **Every tunable's name and default is in one script.** `tuneables_processing` makes 34,957 registration calls (`_NETWORK_GET_TUNABLES_REGISTRATION_INT` 23,449, `_FLOAT` 6,211, `_BOOL` 5,297) for **28,502 distinct tunable names**, each written as `field = REGISTER(joaat("name"), default)`, for example `xp_multiplier` 1.0, `cash_multiplier` 1.0, `cheat_threshold` 50. The defaults are what the game uses when the cloud doesn't answer. (`tunables_registration`, the script named after them, is empty in this release.)
- **Purchases are server transactions:** basket start, add items, checkout, wait (`NET_GAMESERVER_*`, 41 natives, 552 scripts); `NET_GAMESERVER_USE_SERVER_TRANSACTIONS` decides the path (550 scripts).
- **Offline, everything server-side must be local:** a save for the stats the mod needs, the tunable defaults (from `tuneables_processing`) for the values it reads, and local prices and payouts instead of baskets.

## 10.2 Stat types and families

| Type | Count | Notes (**Known** where marked) |
| --- | ---: | --- |
| `int` | 9,445 | Counters, cash, progress |
| `packed` (int) | 6,262 | Several small values in one 64-bit stat, read with `PACKED_STAT_GET_INT_STAT_INDEX` / `GET_PACKED_NG_INT_STAT_KEY` |
| `packed` (bool) | 141 | 64 flags each, e.g. `MP_PSTAT_BOOL0` |
| `u64`, `s64`, `long`, `x64` | 751, 30, 7, 1 | Large values, bit sets |
| `bool` | 662 | |
| `float`, `double` | 180, 5 | |
| `string`, `label`, `userid` | 149, 3, 2 | Names, text labels |
| `u32`, `short` | 99, 83 | |
| `date` | 70 | Timestamps (cooldowns, first-time events) |
| `pos` | 38 | Positions |

| Name family | Stats | What it holds (**Known** from names) |
| --- | ---: | --- |
| `MPSV_` | 4,389 | Saved script variables |
| `DLC2xxxxPSTAT_`, `DLC12022PSTAT_` and the other `*PSTAT_` families | 6,380 in 32 families | One packed family per update or business (`IMPEXP` import/export, `BUSINESSBAT` bunker, `ARENAWARS`, `CASINO`, `TUNER`, `FIXER`, `LR` Los Santos Drug Wars, `SU20` summer 2020 ...) |
| `MPPLY_` | 627 | Per-player (not per-character) values |
| `CHAR_` | 468 | Character basics (`CHAR_XP_FM` is RP) |
| `AWD_` | 392 | Awards |
| `ADMIN_` | 202 | Admin flags |
| `CLTHS_` | 201 | Clothes owned |
| `TATTOO_` | 176 | Tattoos owned |
| `DAMAGE_` | 169 | Damage records |

`SaveCategory` splits them into two groups (0: 15,406, 1: 2,522; **Known** meaning: save cadence). Per-character stats are stored twice in the save, as `MP0_` and `MP1_` versions of the name, one per character slot ([how Online works](/docs/online/01-how-online-works.md#14-stats-where-the-save-lives)).

## 10.3 Tunables

| | Count |
| --- | ---: |
| Registration calls in `tuneables_processing` | 34,957 |
| ... as int / float / bool | 23,449 / 6,211 / 5,297 |
| Distinct tunable names | 28,502 |
| Assignments into the tunables global block (`Global_262145.f_*`) | 29,152 |
| Tunable fields `freemode` reads ([inside freemode](/docs/online/07-freemode.md)) | 17,829 |

Each registration passes the tunable's name hash and its default, and the native returns the cloud value if there is one, the default otherwise (**Known** behaviour; the default in the call is **Verified**). `tuneables_processing` runs these when the tunables need (re)loading; every other script reads the global block, never the cloud directly.

So for an offline build the defaults table already exists, name by name, in the game's own script for this build. The names are plain strings (`xp_multiplier`, `cash_multiplier`, `cheat_threshold` ...), so a mod can look up "what does the game assume if the cloud is silent" for any value it needs.

## 10.4 Transactions

From [how Online works](/docs/online/01-how-online-works.md#15-money-and-transactions), with counts:

1. `NET_GAMESERVER_USE_SERVER_TRANSACTIONS()` picks the server path (550 scripts).
2. `NET_GAMESERVER_BASKET_START`, `_BASKET_ADD_ITEM`, `_CHECKOUT_START`, then polling until the server answers.
3. On success, the stats change; the server owns them (`ServerAuthoritative`).
4. `MONEY::NETWORK_SPENT_*` / `NETWORK_EARN_*` (305 used natives) record the reason for telemetry and the server.

Offline there is no server: a local mod must change its own saved values directly and skip the basket.

## 10.5 What an offline Online mode must replace

| Online keeps it in | Count | Offline replacement |
| --- | ---: | --- | --- |
| Server stats (13,630 server-authoritative) | 17,928 | The mod's own save; keep only the values its systems use, named after their `mpstatssetup.xml` stats |
| Cloud tunables | 28,502 names | A defaults file built from `tuneables_processing` for the tunables the mod reads (tool idea, 10.7) |
| Server transactions | 41 + 305 natives | Direct changes to the mod's saved cash; prices from the shop catalogues ([appearance and clothing](/docs/entities/peds/appearance-and-clothing.md)) or tunable defaults |
| Cloud content (jobs) | | The local `.ugc` files ([Online data files](/docs/online/03-online-data-files.md)); R7.4 |

## 10.6 What this means for modders

- **Don't write Online stats in story mode** to "unlock" things; offline mods should keep their own save and leave the game's stats alone.
- **Use the game's own defaults:** when a mod needs a price, payout or switch the game takes from tunables, the default in `tuneables_processing` is what an unconnected game would use.
- **Stats and tunable fields move between builds** (field numbers of `Global_262145` change); the tunable **names** stay ([surviving updates](/docs/core/surviving-updates.md)).

## 10.7 Open questions

| Question | Where it goes |
| --- | --- |
| A tool that writes the tunable name, type and default list for one build (read-only, from the decompile), to diff builds and to feed a mod's defaults | Tool idea; R11.2 update check |
| What `SaveCategory` 0 and 1 mean exactly | Second pass |
| The basket flow step by step in one shop script | R7.6 or a second pass |
| Which tunables a given offline system needs | Per mod, with the defaults list |

## 10.8 Test cards

None: everything is read from files and scripts.
