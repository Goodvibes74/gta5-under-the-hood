# Economy and pickups

How story-mode money is stored and spent, which scripts handle the money side of the world (shop robberies, ATMs, the stock market), what a pickup is in the data (92 pickup types and their rewards), which pickups story mode places, and how scripts create and track pickups. Roadmap topic **R3.9** in the [roadmap](/ROADMAP.md). Builds on [respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md) (the hospital and arrest charges), [health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (health and armour pickups) and [weapons](/docs/gameplay/weapons/weapons.md). Online money (server transactions) is in [how Online works](/docs/online/01-how-online-works.md).

**How it was made.** The update copy of `common:/data/pickups.meta` was extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and counted by item type. `pickup_controller`, `stock_controller`, `shoprobberies`, `letterscraps`, `spaceshipparts`, `underwaterpickups` and `atm_trigger` were found in the build-3725 decompile (commit `6c18d3e8b`); the pickup types `pickup_controller` places were counted from its `joaat("pickup_...")` literals; the story money stats were read in `respawn_controller`. Native use from the [OBJECT](/scripting/native-usage/OBJECT.md), [STATS](/scripting/native-usage/STATS.md) and [MONEY](/scripting/native-usage/MONEY.md) usage pages. Build 1.0.3725.0 Legacy. Data and counts are **Verified**; how the stock market and robberies work beyond what is quoted is **Known**.

## Short version

- **Story money is a stat per character:** `SP0_TOTAL_CASH` (Michael), `SP1_TOTAL_CASH` (Franklin), `SP2_TOTAL_CASH` (Trevor). Scripts read and write it with `STAT_GET_INT` / `STAT_SET_INT` (792 and 774 scripts, mostly shared code) through a shared "change money" helper that also books the amount under a spending stat (for example `SPx_MONEY_SPENT_ON_HEALTHCARE`, `SPx_MONEY_SPENT_IN_COP_BRIBES`).
- **Online money is different:** it goes through server transactions (`NETWORK_EARN_*` and `NETWORK_SPENT_*`, 183 natives in the MONEY namespace) and can't be changed locally.
- **92 pickup types** in `pickups.meta`: 33 weapon pickups, 19 vehicle pickups (the ones you drive through in Online modes), 12 ammo, 12 portable (carried objects), 8 money, 2 health, 1 armour, a parachute, a camera and others. They use 74 reward definitions: 34 give a weapon, 28 ammo, and the rest health (100, or 50 from a vehicle), armour (100), money (variable), a stat, a vehicle repair.
- **Story pickups are placed by script:** `pickup_controller` creates the world's weapon and armour pickups; the types it names most are the crowbar (16 references), bat (14), pistol (12), molotov (10), sawn-off (8), sniper rifle (7), SMG and assault rifle (6 each), RPG (5), plus armour (3) and parachutes (2).
- **Collectables are scripts of their own:** `letterscraps`, `spaceshipparts`, `underwaterpickups` (the hidden packages under the sea), `am_cp_collection` and `am_ga_pickups` (Online).
- **Money in the world:** `shoprobberies` (holding up stores), `re_atmrobbery` and `re_shoprobbery` (random events, R4.4), `atm_trigger` (using ATMs), and `stock_controller` (5,777 lines; the in-game BAWSAQ and LCN markets, with per-company price labels).
- **Pickup natives are mostly Online:** the portable pickup family (`CREATE_PORTABLE_PICKUP` 137 scripts and its helpers, 100 to 125 scripts each) is used by Online jobs; story uses `CREATE_PICKUP_ROTATE` (66 scripts) and `CREATE_PICKUP` (43).

## Where it lives

| File or script | What it holds | Count (build 3725) |
| --- | --- | --- |
| `common:/data/pickups.meta` (update copy) | Pickup types (`CPickupData`: model, rewards, actions, glow, collection rules), rewards, actions (audio, pad shake) | 92 types, 74 rewards, 33 actions |
| DLC `DLC_WEAPON_PICKUPS` entries | Pickups for DLC weapons | 23 entries in `content.xml` files |
| `pickup_controller` | Places the story world's weapon, armour and parachute pickups | 2,882 lines |
| `stock_controller` | The story stock market | 5,777 lines |
| `shoprobberies`, `atm_trigger` | Store hold-ups, ATMs | |
| `letterscraps`, `spaceshipparts`, `underwaterpickups` | Collectables | |
| Story save stats `SPx_TOTAL_CASH` and the `SPx_MONEY_SPENT_*` family | Cash and what it was spent on | Saves (R1.7) |

### Pickup types by family

| Family (name prefix) | Types | Reward |
| --- | ---: | --- |
| `PICKUP_WEAPON_*` | 33 | The weapon with some ammo |
| `PICKUP_VEHICLE_*` | 19 | Vehicle weapons, health, armour (Online modes) |
| `PICKUP_AMMO_*` | 12 | Ammo for a weapon group |
| `PICKUP_PORTABLE_*` | 12 | Carried objects (packages, crates) |
| `PICKUP_MONEY_*` | 8 | Money (amount set when created) |
| `PICKUP_HEALTH_*` | 2 | 100 health (`PICKUP_HEALTH_STANDARD`), a snack |
| `PICKUP_ARMOUR_STANDARD` | 1 | 100 armour |
| `PICKUP_PARACHUTE`, `PICKUP_CAMERA`, `PICKUP_SUBMARINE`, `PICKUP_GANG_ATTACK_MONEY`, `PICKUP_CUSTOM_SCRIPT` | 1 each | |

## How scripts use money and pickups

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `STAT_GET_INT`, `STAT_SET_INT` | 792, 774 | 15,065, 7,302 | Read and write stats, including story cash |
| `CREATE_PICKUP_ROTATE`, `CREATE_PICKUP` | 66, 43 | 173, 50 | Place a pickup (story) |
| `DOES_PICKUP_EXIST`, `HAS_PICKUP_BEEN_COLLECTED`, `REMOVE_PICKUP` | 95, 48, 84 | 537, 62, 226 | Track and remove |
| `CREATE_PORTABLE_PICKUP`, `ATTACH_PORTABLE_PICKUP_TO_PED`, `PREVENT_COLLECTION_OF_PORTABLE_PICKUP` | 137, 106, 125 | | Carried objects (Online) |
| `GET_WEAPON_TYPE_FROM_PICKUP_TYPE` | 36 | 178 | Which weapon a pickup gives |
| `GET_SAFE_PICKUP_COORDS` | 119 | 145 | A safe place to drop a pickup |
| `NETWORK_EARN_*`, `NETWORK_SPENT_*` | | | Online money (server) |

### Where story money is booked (second pass)

Every story debit and credit goes through one shared helper (in the shared code of 124 scripts; read in `respawn_controller`, build 3725, **Verified**). It takes the character, debit or credit, a transaction type and the amount. A debit always adds to `SPx_MONEY_TOTAL_SPENT`, then books the amount under at most one spending stat, chosen by the transaction type or, for shops, by the script that is running:

| Stat (`SP0_`, `SP1_`, `SP2_` ...) | Booked when | Chosen by |
| --- | --- | --- |
| `MONEY_SPENT_ON_TATTOOS` | Transaction types 63 to 68 | Type |
| `MONEY_SPENT_ON_TAXIS` | Type 21 | Type |
| `MONEY_SPENT_IN_STRIP_CLUBS` | Type 25 | Type |
| `MONEY_SPENT_PROPERTY` | Types 99 to 102 and 104 to 113 (property purchases) | Type |
| `MONEY_SPENT_IN_CLOTHES` | Any other type, in `clothes_shop_sp` | Script |
| `MONEY_SPENT_ON_HAIRDOS` | Any other type, in `hairdo_shop_sp` | Script |
| `MONEY_SPENT_IN_BUYING_GUNS` | Any other type, in `gunclub_shop` | Script |
| `MONEY_SPENT_CAR_MODS` | Any other type, in `carmod_shop` | Script |
| `MONEY_SPENT_ON_HEALTHCARE` | Death (hospital types 125 to 129) | Booked by the respawn code before the helper runs |
| `MONEY_SPENT_IN_COP_BRIBES` | Arrest (police station types 118 to 124) | Booked by the respawn code before the helper runs |

That is the full family: **10 spending categories plus the total**, for each of the three characters. Any other debit is counted only in the total. The hospital types get 10% off when one unlock check in the helper passes (which unlock wasn't identified). A credit adds to `SPx_TOTAL_CASH_EARNED` instead.

A second, smaller family is written directly by three shops, outside the helper: `SPx_SP_MONEY_SPENT_ON_WEAPONS` (`gunclub_shop`), `SPx_SP_MONEY_SPENT_ON_CLOTHES` (`clothes_shop_sp`, `clothes_shop_mp`) and `SPx_SP_MONEY_SPENT_ON_VEHICLES` (`appinternet`, the vehicle websites). They are only in those 4 scripts. No other story `MONEY_SPENT` name appears in the decompile; the rest (`MONEY_SPENT_PROPERTY_UTIL`, `MONEY_SPENT_JOB_ACTIVITY`, `MONEY_SPENT_BETTING` ...) are Online stats.

## What this means for modders

- **Give or take story money** by changing `SP0_TOTAL_CASH` (or `SP1_`, `SP2_`) with `STAT_SET_INT`; the HUD shows the change. Record what you change if your mod should be undoable.
- **Never touch Online money.** It lives on the server; local changes don't stick and are logged.
- **Place a pickup:** `CREATE_PICKUP_ROTATE(GET_HASH_KEY("PICKUP_WEAPON_PISTOL"), x, y, z, 0, 0, 0, 512, ammo, 2, true, 0)` (**Known** argument pattern), keep the handle, and `REMOVE_PICKUP` when your mod stops.
- **New pickup types** are a `pickups.meta` edit or a DLC `DLC_WEAPON_PICKUPS` entry; rewards are reused from the existing list.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| How `stock_controller` moves prices and which story events move which company | Second pass |
| Where `pickup_controller` places each pickup and when they respawn | Second pass: its coordinate tables |
| How shop robberies pay out (the till amounts) | Second pass: `shoprobberies` |
| The full list of `SPx_MONEY_SPENT_*` categories | Answered in [where story money is booked](#where-story-money-is-booked-second-pass) |

## Test cards

1. **Cash stat.** Add 1,000 to `SP1_TOTAL_CASH` with `STAT_SET_INT`. Expected: Franklin's HUD money rises by 1,000.
2. **Pickup.** Create a pistol pickup in front of the player and walk over it. Expected: a pistol with ammo; `HAS_PICKUP_BEEN_COLLECTED` true.
3. **World pickups.** Visit a known story weapon pickup spot after collecting it. Note how long until it reappears.
