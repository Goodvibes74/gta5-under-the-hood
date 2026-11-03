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

### The stock market (second pass)

**Verified** in `stock_controller` and `code_controller` (build 3725; global numbers are pointers). The market has **80 companies**, each with two text labels (`BSS_BSTR_0` and `_1` for the first, and so on; the first is Ammu-Nation). A flag on each one puts it on one of two exchanges:

- **39 BAWSAQ companies** don't move in the game at all. When the game is signed in to Rockstar's servers, it reads each price and its last five values from a **community stat** (`STAT_COMMUNITY_GET_HISTORY`), so BAWSAQ is whatever the servers say. Offline, it stays where it was.
- **41 LCN companies** are simulated by `stock_controller`, and their prices, highs and lows are saved in `FINANCE_SAVED_ARRAY`. On each update a company's price moves by a random step of up to ±(volatility × 10%) of its price, so ±1% at the start: volatility starts at 0.1 and decays by 0.5% per update. A target pull is added when a target is set. The step is capped at 3.5, and a price above the ceiling (1,000) or below the floor (3.5) is pulled halfway back. These limits come from a 41-entry table, but the price loop only ever reads its first entry in this build. A rise is damped when the three characters already own many shares of that company.

**The company names** (*leftovers pass*, **Verified**, the American text blocks of every archive (base `x64b.rpf`, `update.rpf`, `update2.rpf` and the DLC packs, 645,160 entries) dumped with the CodeWalker library and searched by the `joaat` hash of each label). Company *n* is named by `BSS_BSTR_<2n>` and its ticker by `BSS_BSTR_<2n+1>`. All 160 labels are in `global.gxt2` (base and the `update2.rpf` copy); the earlier pass missed them because it searched only a few labels. The text writes names without spaces (`BettaPharmaceuticals`), spaced out here:

- **LCN (41, simulated in story mode):** Bank of Liberty (`BOL`), Fleeca (`FLC`), Hijak (`HJK`), Augury Insurance (`AUG`), Bullhead (`BUL`), Hammerstein & Faust (`HAF`), Slaughter, Slaughter & Slaughter (`SSS`), Maze Bank (`MAZ`), Animal Ark (`ARK`), Raine (`RAI`), Debonaire (`DEB`), Air Emu (`EMU`), Bean Machine (`BEN`), Gold Coast (`GCD`), Bob Mulét (`BOM`), Burger Shot (`BGR`), Cluckin' Bell (`CLK`), Cool Beans (`BAN`), Dollar Pills (`DOP`), eCola (`ECL`), FlyUS (`FUS`), Gastro Band (`GAS`), GoPostal (`GOP`), Gruppe Sechs (`GRU`), Krapea (`KRP`), Lifeinvader (`LFI`), Max Renda (`MAX`), Post Op (`POP`), Pro Laps (`PRO`), Redwood (`RWC`), Richards Majestic (`RIM`), Taco Bomb (`TBO`), Up-n-Atom (`UPA`), Vangelico (`VAG`), Vanilla Unicorn (`UNI`), Logger (`LOG`), Merryweather (`MER`), Worldwide FM (`WFM`), Radio Los Santos (`RLS`), Mors Mutual Insurance (`MOR`), Bilkinton (`BIL`).
- **BAWSAQ (39, community stats):** Ammu-Nation (`AMU`), Badger (`BDG`), BF (`BFA`), Binco (`BIN`), Bitter Sweet (`BTR`), Bleeter (`BLE`), Brute (`BRU`), CNT (`CNT`), Crevis (`CRE`), Daily Globe (`DGP`), Dept. Water and Power (`WAP`), Facade (`FAC`), Fruit (`FRT`), Los Santos Customs (`LSC`), LS Transport (`LST`), LTD Oil (`LTD`), Maibatsu (`MAI`), Suburban (`SUB`), Pisswasser (`PIS`), Ponsonbys (`PON`), Ron Oil (`RON`), Schyster (`SHT`), Sprunk (`SPU`), Tinkle (`TNK`), WIWANG (`WIW`), Ubermacht (`UMA`), Vapid (`VAP`), Vom Feuer (`VOM`), Weazel (`WZL`), Whiz (`WIZ`), Zit (`ZIT`), Shark (`SHK`), Betta Pharmaceuticals (`BET`), Pump & Run (`PMP`), Grain of Truth (`GOT`), Eyefind (`EYE`), HVY Industries (`HVY`), Shrewsbury (`SHR`), Hawk & Little (`HAL`).

So the story events in the table below touch Lifeinvader (61), Bilkinton (79) and Betta Pharmaceuticals (43), Redwood (65) and Debonaire (40), Facade (12) and Fruit (15), Vapid (36), Gold Coast (49) and Tinkle (33). Five of these ten are BAWSAQ companies (Betta, Facade, Fruit, Vapid, Tinkle), whose prices the game takes from the community stats; the event is still recorded for them.

**Story events.** `lester1` and the five assassinations each arm a `code_controller` entry (192 to 197) that writes a **stock event** for chosen companies. The event is held in one of 8 save slots (`FINANCE_SAVED_ARRAY`), shows the help text `AM_H_STOCKS`, and gives that company a price multiplier for a number of updates. The event's bits set the strength (1, 2, 4 and 8 summed, times 3, times 7 for a long event), and our reading is that one bit sets the direction:

| Code entry | Armed after | Companies (index) |
| ---: | --- | --- |
| 192 | `lester1` | 61 |
| 193 | `Assassin_Valet` | 79, 43 |
| 194 | `Assassin_Multi` | 65, 40 |
| 195 | `Assassin_Hooker` | 12, 15 |
| 196 | `Assassin_Bus` | 36 |
| 197 | `Assassin_Construction` | 49 |
| 198 | not armed by a strand | 33 |

**What the 204 "sm_" stats are.** `stock_controller` also keeps a table of 204 stats. 126 of them are event counters that 141 other scripts add to when something happens in the world (`sm_brvecdesbfa` and the other `sm_brvecdes...` counters count destroyed vehicles of each brand; shops, vending machines, races and car mods add their own). The rest mirror ordinary game stats. The controller reads them on every update and records how much each has changed, but no price in the LCN code uses those changes. Our reading is that they are the inputs Rockstar's servers use for the BAWSAQ community prices. Which company each counter feeds is in its name (below); the English names of the companies (their labels aren't in the base game's text files) are left for the third pass.

**Counter to company** (**Verified**, second pass). The counter table in `stock_controller` holds only the stat name, no company number. But 39 stats in the same table are named `sm_price_<code>`, one per company code, and 95 of the 126 counters end in one of those codes. The verb in front says what is counted (`brvecdes` destroyed, `vecbuy` bought, `vecstol` stolen, `vecdmg` damaged, `disdriv` distance driven in, `kilw` kills with, `kilciv`/`kilcop`/`kilcrim` civilians, police or criminals killed with, `wepbuy`/`weptake` weapons bought or picked up, `phoncal`/`phontxt` calls and texts on, `chtick`/`calcan` ticks and cancelled calls, `rad`/`radcha` radio listened to or changed, `tvtick` TV watched, `clobof` clothes bought from):

| Code | Counters |
| --- | --- |
| `bfa`, `bru`, `mai`, `sht`, `uma`, `vap`, `hvy` (vehicle makers) | destroyed, bought, driven, stolen, damaged and kills-with counters for each (`mai`, `sht`, `uma` also civilians killed); `lst` destroyed, driven, stolen; `lsc` destroyed and `vecmodlsc` (car mods); `ltd`, `ron` destroyed only |
| `vom`, `shr`, `hal` (weapon makers) | weapons bought or taken, kills of police, criminals and civilians with them (`vom` also `kilwvom`) |
| `bdg`, `tnk`, `wiz` (phone networks) | calls, texts, ticks and cancelled calls |
| `cnt`, `wzl`, `zit` (radio and media) | radio listening and changes; `zitpopzit` |
| `wap`, `wiw` | TV watched |
| `bin`, `pkw`, `pon` | clothes bought |
| `spu` | `venusespu` (vending machines) |
| `shk` | `monupshk` |

The codes with a price stat but no counter are `amu`, `btr`, `ble`, `cre`, `dgp`, `fac`, `frt`, `pis`, `mol`, `pmp`, `got` and `eye`. The 31 counters without a code are general activity: `yoga`, `tri`, `gym`, `strip`, `pubclub`, `tdrnk`, `drnkcrm`, `hangovr`, `taxdest`, `storob` (shop robberies), `drugkil`, `killspr`, `totinj`, `para`, `carapp` and others; our reading is that the server spreads them over several companies.

### The pickups `pickup_controller` places (second pass)

**Verified.** `pickup_controller` creates every story pickup with `CREATE_PICKUP_ROTATE` and gives each a **regeneration time of 10 minutes** (600,000 ms): once collected, it comes back 10 minutes later. Some pickups are tied to an interior room (`ADD_PICKUP_TO_INTERIOR_ROOM_BY_NAME`) so that they stream with that interior. The script removes all of them while the current mission type is 13 or 14, and puts them back afterwards:

| Group | Count | Contents |
| --- | ---: | --- |
| Weapons | 102 | The most common are `pickup_weapon_crowbar` (16), `bat` (14), `pistol` (12), `molotov` (10), `sawnoffshotgun` (8), `sniperrifle` (7), then SMGs, assault rifles, RPGs, sticky bombs, grenades and two parachutes |
| Health | 76 | `pickup_health_standard` |
| Armour | 45 | `pickup_armour_standard` |
| Petrol cans | 19 | `pickup_weapon_petrolcan` |
| Extra cache | 9 | A grenade launcher, an RPG, a combat MG, armour, an AP pistol, a pump shotgun, a sniper rifle and two sticky bombs, once flag ID 75 is set |
| Railgun | 1 | Once flag ID 75 is set, and only for owners of the special or collector's edition content or returning players (`NETWORK_HAS_ROS_PRIVILEGE_PLAYED_LAST_GEN`) |
| Hatchet | 1 | Once `trevor1` is passed, for the same players |

For a returning player the same check also sets the `sp_unlock_exclus_content` stat bits. The coordinates of each pickup are in the script's tables (one function per group); they aren't copied here.

### What a shop robbery pays (second pass)

**Verified** in `shoprobberies`. All 19 stores use the same amounts:

- **The clerk fills the bag:** the bag holds a random **$220 to $786**, paid when you pick it up. If the bag is dropped, it becomes a money pickup worth a random $50 to $219.
- **You empty the till yourself:** each grab in the till animation adds $10 to $50 (two grabs per animation loop). If the total is still under $15 when you stop, $25 to $64 more is added.

## What this means for modders

- **Give or take story money** by changing `SP0_TOTAL_CASH` (or `SP1_`, `SP2_`) with `STAT_SET_INT`; the HUD shows the change. Record what you change if your mod should be undoable.
- **Never touch Online money.** It lives on the server; local changes don't stick and are logged.
- **Place a pickup:** `CREATE_PICKUP_ROTATE(GET_HASH_KEY("PICKUP_WEAPON_PISTOL"), x, y, z, 0, 0, 0, 512, ammo, 2, true, 0)` (**Known** argument pattern), keep the handle, and `REMOVE_PICKUP` when your mod stops.
- **New pickup types** are a `pickups.meta` edit or a DLC `DLC_WEAPON_PICKUPS` entry; rewards are reused from the existing list.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| How `stock_controller` moves prices and which story events move which company | Mostly answered in [the stock market](#the-stock-market-second-pass): the LCN model, BAWSAQ from community stats, the story events per mission; which company each `sm_` counter feeds is answered; the company names are third pass (GP-090) |
| The English names of the 80 companies (`BSS_BSTR_` labels, not in the base text files), and how the 31 counters without a company code are used (GP-090) | Names answered in [the stock market](#the-stock-market-second-pass) (they are in `global.gxt2`); how the 31 counters without a company code are used is third pass |
| Where `pickup_controller` places each pickup and when they respawn | Answered in [the pickups](#the-pickups-pickup_controller-places-second-pass): 253 pickups in seven groups, 10-minute regeneration |
| How shop robberies pay out (the till amounts) | Answered in [what a shop robbery pays](#what-a-shop-robbery-pays-second-pass) |
| The full list of `SPx_MONEY_SPENT_*` categories | Answered in [where story money is booked](#where-story-money-is-booked-second-pass) |

## Test cards

1. **Cash stat.** Add 1,000 to `SP1_TOTAL_CASH` with `STAT_SET_INT`. Expected: Franklin's HUD money rises by 1,000.
2. **Pickup.** Create a pistol pickup in front of the player and walk over it. Expected: a pistol with ammo; `HAS_PICKUP_BEEN_COLLECTED` true.
3. **World pickups.** Visit a known story weapon pickup spot after collecting it. Note how long until it reappears.
