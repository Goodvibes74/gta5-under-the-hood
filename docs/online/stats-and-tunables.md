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

### 10.5.1 The tunable index, save categories and the basket (second pass)

*Second pass, 2026-10-30.* **Verified** in `tuneables_processing`, `clothes_shop_mp` and `common\data\mpstatssetup.xml` (`update.rpf`).

**The tunable index.** Every tunable is one assignment of the form `Global_262145.f_<n> = <reader>(name hash, default)`. The three readers the decompile shows as `unk_` are, by their native hashes:

| Hash | NativeDB name (**Known**) | Calls |
| --- | --- | ---: |
| `0x0D94071E55F4C9CE` | `_NETWORK_GET_TUNABLES_REGISTRATION_INT` | 23,449 |
| `0x367E5E33E7F0DD1A` | `_NETWORK_GET_TUNABLES_REGISTRATION_FLOAT` | 6,241 |
| `0xB327CF1B8C2C0EA3` | `_NETWORK_GET_TUNABLES_REGISTRATION_BOOL` | 5,297 |

Read line by line, the script gives a complete index of field, type, name and default:

- **34,987 assignments** in all.
- 29,100 go to plain fields (`Global_262145.f_<n>`) and 5,887 to array elements.
- 27,691 pass the name as `joaat("...")`, so the name can be read directly. The other 7,296 pass only a number, the hash of a name that isn't in the scripts.

A few lines of script can rebuild the index from the decompile for any build. The fields move between builds, but the names stay.

The fields `freemode` reads most show what the tunables are mostly for: prices and price multipliers. Examples:

| Field | Reads in `freemode` | Name | Type, default |
| --- | ---: | --- | --- |
| `.f_17236` | 108 | `stunt_all_helmets` | float, 1.0 |
| `.f_26303` | 99 | `aw_vehicle_mods_buy_it_now_price_multiplier` | float, 2.0 |
| `.f_15065` | 60 | `male_and_female_uppers_all_uppers` | float, 1.0 |
| `.f_31069` | 30 | `tuner_pursuit_race_place_xp_multiplier` | float, 1.2 |
| `.f_22364` | 24 | `smug_mods_standard_price_smoke` | int, 68,500 |
| `.f_1` | | `xp_multiplier` | float, 1.0 |

**The appearance fee** (GP-058): changing a character's appearance costs `character_appearance_charge` = **$100,000**. The tunables limit how often it can be done:

| Tunable | Default | Meaning |
| --- | --- | --- |
| `character_appearance_cooldown` | 2,880,000 ms | 48 minutes between changes |
| `character_appearance_cap_time` | 86,400,000 ms | A 24-hour window |
| `character_appearance_cap_instances` | 30 | Changes allowed in that window |

**The two save categories.** All 17,933 stats are Online stats, and `SaveCategory` splits them:

| | `SaveCategory="0"` | `SaveCategory="1"` |
| --- | ---: | ---: |
| Stats | 15,411 | 2,522 |
| Biggest families | `MPSV_` (4,389), every `*PSTAT_` packed family, `MPPLY_` (592) | `CHAR_` (394), `AWD_` (349), `DAMAGE_` (169), `CONTACT_`, `SHOPFM_`, `HEIST_`, `CL_` |
| Packed stats | all 6,403 | none |
| Server-authoritative | 13,058 of 13,637 marked | 572 of 940 marked |
| Owned by the game code (`coder`) | 174 | 510 |
| Per character | 14,655 (account-level `MPPLY_` included here) | all |

So category 1 is the original 2013-era per-character set: character basics, awards, damage and contacts, more of it owned by the game code and less of it server-checked. Category 0 is everything added since, and all the packed business stats. That the two are saved separately is **Known**, not seen in the scripts.

**The basket, step by step** (`clothes_shop_mp`):

1. If server transactions are off (`NET_GAMESERVER_USE_SERVER_TRANSACTIONS` false), the same bookkeeping runs with no server calls.
2. Otherwise the game-server session must be valid and not refreshing (`NET_GAMESERVER_IS_SESSION_VALID`, `_IS_SESSION_REFRESH_PENDING`), or the purchase stops with an error flag.
3. The script takes a free entry in a table of 15 pending transactions (84 values each). It refuses if any entry is still waiting on the server.
4. It ends any open basket, then `NET_GAMESERVER_BASKET_START(category, action, ...)` opens one and the transaction is recorded in the table.
5. `NET_GAMESERVER_BASKET_ADD_ITEM` adds each item: its catalogue key, price and quantity, also copied into the table entry. Prices come from `NET_GAMESERVER_GET_PRICE`, and keys are checked with `_CATALOG_ITEM_IS_VALID`.
6. `NET_GAMESERVER_CHECKOUT_START` sends the basket, and the script polls the table entry until the server answers.

Single services skip the basket and use `NET_GAMESERVER_BEGIN_SERVICE` then `_CHECKOUT_START` instead.

## 10.6 What this means for modders

- **Don't write Online stats in story mode** to "unlock" things; offline mods should keep their own save and leave the game's stats alone.
- **Use the game's own defaults:** when a mod needs a price, payout or switch the game takes from tunables, the default in `tuneables_processing` is what an unconnected game would use.
- **Stats and tunable fields move between builds** (field numbers of `Global_262145` change); the tunable **names** stay ([surviving updates](/docs/core/surviving-updates.md)).

## 10.7 Open questions

| Question | Where it goes |
| --- | --- |
| A tool that writes the tunable name, type and default list for one build (read-only, from the decompile), to diff builds and to feed a mod's defaults | Tool idea; R11.2 update check |
| What `SaveCategory` 0 and 1 mean exactly | Answered in [10.5.1](#1051-the-tunable-index-save-categories-and-the-basket-second-pass): 1 is the original per-character set, 0 everything since |
| The basket flow step by step in one shop script | Answered in [10.5.1](#1051-the-tunable-index-save-categories-and-the-basket-second-pass) |
| Which tunables a given offline system needs | Per mod; the index in [10.5.1](#1051-the-tunable-index-save-categories-and-the-basket-second-pass) gives each field's name and default |

## 10.8 Test cards

None: everything is read from files and scripts.
