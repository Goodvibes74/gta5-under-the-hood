# Organisations and businesses

How GTA Online's VIP, CEO and MC organisations and their businesses are put together: the event-type table that launches all organisation work (`gb_*` and the newer `fm_content_*` scripts), the organisation rules held in tunables (wages, cooldowns, the boss's bonuses), the business loop of supplies, production, stock and selling with each business's default numbers, and the business computers. Roadmap topic **R7.7** in the [roadmap](/ROADMAP.md). Research only: this documents Rockstar's Online scripts; never run mods in GTA Online. Builds on [inside freemode](/docs/online/07-freemode.md) (R7.1), [stats and tunables](/docs/online/stats-and-tunables.md) (R7.3: where tunables get their defaults), [properties](/docs/online/properties.md) (R7.6: offices, clubhouses and the simple interiors) and [interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `am_launcher` (the event-type to script table), `tuneables_processing` (35,834 tunable registrations parsed into field, name and default; 28,395 have a readable name), and the `app*` business computers (their Scaleform movies). Script sizes counted with `wc`. Values are the tunables' **defaults** (what the game uses when the cloud sends nothing; the live game may override them); they and the counts are **Verified**. What each work type is like to play is **Known**.

## 46.1 Short version

- **All free-roam work starts from one table.** `am_launcher` maps an event-type number to a script: 48 to 72 are VIP and CEO work and challenges (`GB_SIGHTSEER` 60, `GB_HEADHUNTER` 65, `GB_CONTRABAND_BUY` 66, `_SELL` 67, `_DEFEND` 68), 73 to 82 vehicle export and import, 83 to 106 MC work and the biker businesses, 107 to 113 gunrunning, smuggling and the Doomsday preps, 114 to 127 business battles, client jobs and the casino, and 127 to 222 the `fm_content_*` scripts of every update since 2020.
- **70 `gb_*` scripts** (141 MB of decompiled code) hold the older work; newer businesses use `fm_content_*` scripts built on the content framework.
- **Organisation rules are tunables:** associates are paid $10,000 every 15 minutes (minus 5% per boss death), work has a 5-minute cooldown and challenges 3 minutes, members near the boss regenerate health 2× faster, and organisation members get 10% of a gunrunning sale (capped at $50,000) or of a hangar sale (capped at $90,000).
- **The business loop is supplies → production → stock → sell,** with each step in tunables: biker businesses produce one unit every 5 minutes (documents) to 50 minutes (cocaine) and hold 10 (cocaine) to 80 (weed) units; the bunker makes 100 units at 10 minutes and $5,000 each; the acid lab holds 160.
- **Special cargo is bought and sold by crate:** buying 1, 2 or 3 crates costs $2,000, $8,000 or $18,000; the sale value per crate rises in 21 steps from $10,000 to $20,000 with the amount sold; a raid can come every 5 to 10 hours when the warehouse is at least 70% full.
- **Every business has a computer app** with its own Scaleform movie: `appsecuroserv` (SecuroServ), `appbikerbusiness` (`BIKER_BUSINESSES`), `appbunkerbusiness` (`DISRUPTION_LOGISTICS`), `appsmuggler` (`HANGAR_CARGO`), `appbusinesshub` (`NIGHTCLUB`), `apparcadebusiness` (`ARCADE_MANAGEMENT`) and more.

## 46.2 The event-type table

`am_launcher` holds one function that returns the script for each free-roam event type (**Verified**). Event types are the numbers `freemode` and the phone use to start work; the table is the map from "what the player chose" to "which script runs".

| Types | Scripts | What |
| --- | --- | --- |
| 1 to 47 | `AM_HOLD_UP`, `AM_JOYRIDER`, `AM_HOT_TARGET`, `AM_KILL_LIST`, `AM_PASS_THE_PARCEL`, `AM_HUNT_THE_BEAST` ... | Freemode events and ambient activities |
| 48 to 59 | `GB_LIMO_ATTACK`, `GB_DEATHMATCH`, `GB_POINT_TO_POINT`, `GB_TERMINATE`, `GB_YACHT_ROB`, `GB_BELLYBEAST`, `GB_FIVESTAR`, `GB_ROB_SHOP`, `GB_COLLECT_MONEY`, `GB_ASSAULT`, `GB_VEH_SURV` | VIP work and challenges |
| 60 to 65 | `GB_SIGHTSEER`, `GB_FLYING_IN_STYLE`, `GB_FINDERSKEEPERS`, `GB_HUNT_THE_BOSS`, `GB_CARJACKING`, `GB_HEADHUNTER` | VIP and CEO work |
| 66 to 72 | `GB_CONTRABAND_BUY`, `_SELL`, `_DEFEND`, `GB_AIRFREIGHT`, `GB_CASHING_OUT`, `GB_SALVAGE`, `GB_FRAGILE_GOODS` | Special cargo and CEO work |
| 73 to 82 | `GB_VEHICLE_EXPORT` (73, 74), `GB_PLOUGHED`, `GB_FULLY_LOADED`, `GB_AMPHIBIOUS_ASSAULT`, `GB_TRANSPORTER`, `GB_FORTIFIED`, `GB_VELOCITY`, `GB_RAMPED_UP`, `GB_STOCKPILING` | Vehicle cargo: export, and the steal missions |
| 83 to 106 | `GB_BIKER_*` (19 scripts), `GB_ILLICIT_GOODS_RESUPPLY` (93), `GB_BIKER_CONTRABAND_SELL` (91), `_DEFEND` (92) | MC challenges, contracts, and the biker business loop |
| 107 to 113 | `GB_GUNRUNNING` (107, 108), `GB_GUNRUNNING_DEFEND`, `GB_SMUGGLER` (110 to 112), `GB_GANGOPS` | Bunker, hangar, Doomsday preps |
| 114 to 127 | `BUSINESS_BATTLES`, `_SELL`, `_DEFEND`, `GB_SECURITY_VAN`, `GB_TARGET_PURSUIT`, `GB_JEWEL_STORE_GRAB`, `GB_BANK_JOB`, `GB_DATA_HACK`, `GB_INFILTRATION`, `GB_CASINO`, `GB_CASINO_HEIST`, `fm_content_business_battles` | Nightclub era: business battles, Terrorbyte client jobs, the casino |
| 128 to 222 | 91 `fm_content_*` scripts and a few others: `fm_content_island_heist`, `_tuner_robbery`, `_security_contract`, `_payphone_hit`, `_acid_lab_sell`, `_smuggler_resupply`, `_bounty_targets`, `_dispatch_work` ... | Every update since 2020 |
| 223 to 271 | Taxis, rides, minigames (`golf_mp`, `Range_Modern_MP`, `Pilot_School_MP`), job controllers (`FM_Race_Controler`, `fm_deathmatch_controler`, `FM_Survival_Controller`), arcade games, `SCTV` | Activities and controllers |

`gb_*` scripts not in the table (`gb_casino_heist_planning`, `gb_gang_ops_planning`, `gb_ie_delivery_cutscene`, `gb_gunrunning_delivery`, `gb_delivery`, `gb_biker_target_rival` are not) are started by their business's own code (**Verified** absence; *probable* starter).

## 46.3 Organisation rules

Default values of the organisation tunables (**Verified** defaults; meaning from the names, **Known**):

| Tunable | Default | Meaning |
| --- | ---: | --- |
| `gb_wages_amount`, `gb_wages_frequency` | 10,000; 900,000 ms | Associate wage every 15 minutes |
| `gb_boss_death_wage_reduction_percentage` | 0.05 | Wage cut each time the boss dies |
| `gb_wage_stop_idle_time` | 900,000 ms | No wage after 15 idle minutes |
| `gb_cooldown_until_next_boss_work`, `_challenge` | 300,000; 180,000 ms | 5 and 3 minutes between work and challenges |
| `gb_boss_radius`, `gb_boss_radius_health_regen_multiplier` | 40 m; 2 | Members within 40 m of the boss regenerate health twice as fast (up to 75%) |
| `gb_boss_stat_boost_percentage`, `gb_boss_boost_max_final_stat` | 0.2; 40 | Members get 20% of the boss's skill stats, up to 40 |
| `gb_percentage_of_goons_cash_to_agency` | 10 | A 10% "agency" share of members' cash (use not read) |
| `gb_ghost_org_cost`, `_duration`, `_cooldown` | 12,000; 180,000 ms; 600,000 ms | Ghost Organization: $12,000, 3 minutes, 10-minute cooldown |
| `gb_bosscost`, `gb_bosssetupcost` | 200,000; 5,000 | Costs tied to registering (exact use not read) |
| `exec_vip2_org_name_change` | 5,000 | Renaming the organisation |
| `gr_org_member_sell_reward_percentage`, `_cap` | 0.1; 50,000 | Members' share of a bunker sale |
| `smug_sell_org_member_reward_percentage`, `_cap` | 0.1; 90,000 | Members' share of a hangar sale |
| `exec1_office_fees`, `exec1_small/medium/large_warehouse_fees` | 250; 25, 50, 75 | Daily fees |

## 46.4 The business loop

Every product business runs the same four steps (**Known** design; numbers **Verified** defaults):

1. **Supplies:** steal them in a resupply mission (`GB_ILLICIT_GOODS_RESUPPLY`, `GB_GUNRUNNING`, `fm_content_smuggler_resupply`, `fm_content_acid_lab_source`) or buy them on the computer (biker: `biker_business_paid_resupply_base` 15,000; acid lab: 12,000 per segment).
2. **Production:** while supplied, the business makes one unit per production time; equipment and staff upgrades shorten the time and raise the value.
3. **Stock:** units pile up to a capacity; a full or nearly full business can be raided (defend missions).
4. **Sell:** a sell mission (`GB_BIKER_CONTRABAND_SELL`, `GB_GUNRUNNING` 108, `GB_CONTRABAND_SELL`) delivers the stock; failing it loses stock.

**Biker businesses and the bunker** (tunable defaults; time per unit in minutes, value per unit in $):

| Business | Capacity | Minutes per unit | Value per unit | Upgrades | Full stock value (base) | Time to fill (base) |
| --- | ---: | ---: | ---: | --- | ---: | ---: |
| Weed farm | 80 | 6 | 2,025 | −1 min each, +$300 each | 162,000 | 8 h |
| Document forgery | 60 | 5 | 1,350 | −1 min each, +$200 each | 81,000 | 5 h |
| Counterfeit cash | 40 | 12 | 4,725 | −2 min each, +$700 each | 189,000 | 8 h |
| Meth lab | 20 | 30 | 11,475 | −6 min each, +$1,700 each | 229,500 | 10 h |
| Cocaine lockup | 10 | 50 | 27,000 | −10 min each, +$4,000 each | 270,000 | 8 h 20 min |
| Acid lab | 160 | 2.25 | 1,485 | −0.75 min, +$610 (equipment) | 237,600 | 6 h |
| Bunker manufacturing | 100 | 10 | 5,000 | −1.5 min each, +$1,000 each | 500,000 | 16 h 40 min |
| Bunker research | 60 | 5 | | −0.75 min each | | 5 h |

**Bunker running costs:** staff $1,200, utilities $800, plus $700 to $1,000 more with the security and staff upgrades (`gr_manu_*_cost`). **Selling:** biker sales scale by stock (`biker_sell_medium_threshold` 25 and `_large_threshold` 50, *probably* per cent of stock) and pick from 11 sell types (convoy, trashmaster, proven, border patrol, helicopter drop, postman, sting, Benson, bag drop, race, club run), each with a 30-minute limit and some needing 2 players.

**Special cargo (CEO)** (tunable defaults):

| Rule | Value |
| --- | --- |
| Crate purchase (1, 2, 3 crates) | $2,000, $8,000, $18,000 |
| Sale value per crate | 21 steps from $10,000 to $20,000 as the amount sold grows |
| Special items (film reel, Sasquatch hide, golden minigun, ornamental egg, XL diamond, pocket watch) | Cost $19,000 to $30,000, value $95,000 to $150,000 |
| Buy and sell cooldowns | 5 and 30 minutes |
| Raids | Between 5 and 10 hours apart, when stock is at least 70% (`exec_warehouse_stock_defend_threshold` 0.7); 5 minutes to respond |
| Failed sale | All the stock being sold is lost (`exec_stock_remove_at_fail_sell` 1) |
| Enemies in sell missions | Accuracy 10 (easy) or 25 (medium), 1 to 3 enemy waves on land, 2 to 6 at sea |
| Office safe | $250,000 per level |

**Vehicle cargo and the hangar.** Vehicle export runs as `GB_VEHICLE_EXPORT`, the steal missions as the eight `GB_*` types 75 to 82; repairs cost `ie_sv_repair_service_cost` 5,000 up to 50,000. Hangar trade prices for its aircraft are tunables too (`smug_vehicles_trade_price_*`, for example the Bombushka $3,562,500 trade and $4,750,000 buy-it-now).

## 46.5 The business computers

Each business has a desk app started by the property's interior script ([R7.6](/docs/online/properties.md)), drawn with its own Scaleform movie (**Verified**):

| App script | Lines | Scaleform movie | Business |
| --- | ---: | --- | --- |
| `appsecuroserv` | 42,136 | `securoserv`, `warehouse` | CEO office: special cargo, work, organisation |
| `appimportexport` | 27,683 | `IMPORT_EXPORT_WAREHOUSE` | Vehicle warehouse |
| `appbikerbusiness` | 22,020 | `BIKER_BUSINESSES` | MC clubhouse: the five factories |
| `appbunkerbusiness` | 22,359 | `DISRUPTION_LOGISTICS` | Bunker |
| `appsmuggler` | 18,139 | `HANGAR_CARGO` | Hangar |
| `apphackertruck` | 20,751 | `hacker_truck_desktop` | Terrorbyte |
| `appbusinesshub` | 381,409 | `NIGHTCLUB` | Nightclub and its warehouse |
| `apparcadebusiness` | 374,965 | `ARCADE_MANAGEMENT` | Arcade |
| `appfixersecurity` | 11,733 | `FIXER_APP` | Agency |
| `appbailoffice` | 18,522 | `BOUNTY_COMPUTER` | Bail office |
| `apphackerden` | 23,849 | `ROBBERY_COMPUTER` | Hacker den |
| `appavengeroperations` | 6,381 | `AVENGER_OPERATIONS_TERMINAL` | Avenger |
| `appcovertops` | 7,832 | `COVERT_OPS` | Covert operations |

### 46.5.1 Warehouse sizes, boss costs and the apps' transactions (second pass)

*Second pass, 2026-10-30.* **Verified** in `freemode`, `tuneables_processing` and the business apps.

**Special cargo warehouses.** The capacities are fixed in the scripts, not tunables. One shared function maps the 22 warehouse ids to three sizes, and a second turns the size into crates:

| Size | Crates | Warehouse ids |
| --- | ---: | --- |
| Small | 16 | 1 to 5, 9 |
| Medium | 42 | 7, 10 to 15, 21 |
| Large | 111 | 6, 8, 16 to 20, 22 |

**`gb_bosscost` and `gb_bosssetupcost`.** `tuneables_processing` registers them with defaults of **$200,000** and **$5,000**, but no script in this build reads either field. They no longer charge anything directly. **Registering is free in this build** (**Verified**, second pass, `am_pi_menu`): the "register as a VIP/CEO" entry of the interaction menu is only greyed out when `NETWORK_CAN_SPEND_MONEY` fails for the tunable `gb_become_boss_threshold` (default **0**). That check is skipped entirely when a player-state check returns true (which picks the `PIM_MAGM0AC` label, our reading: the CEO variant for an office owner). Three other checks can also grey it out; they were not read further. No money changes hands; `gb_become_boss_cooldown` (default 43,200) spaces registrations.

**Transactions per business app.** The count of distinct `NET_GAMESERVER_*` natives in each app, and the spend and earn natives it calls:

| App | `NET_GAMESERVER_*` | Spend | Earn |
| --- | ---: | --- | --- |
| `appbikerbusiness` | 13 | `NETWORK_SPENT_PAY_BUSINESS_SUPPLIES`, `_PURCHASE_BUSINESS_PROPERTY`, `_TRADE_BUSINESS_PROPERTY`, `_UPGRADE_BUSINESS_PROPERTY` | `NETWORK_EARN_FROM_BUSINESS_PRODUCT`, `_FROM_PROPERTY`, `_SELL_ACID` |
| `appbunkerbusiness` | 13 | `NETWORK_SPENT_PAY_BUSINESS_SUPPLIES`, `_UPGRADE_BUSINESS_PROPERTY` | `NETWORK_EARN_FROM_BUSINESS_PRODUCT`, `_SELL_ACID` |
| `appbusinesshub` | 15 | `NETWORK_SPEND_BUY_MFGARAGE`, `_SET_DISCOUNT`, `NETWORK_SPENT_GENERIC`, `_REHIRE_DJ`, `_UPGRADE_NIGHTCLUB_AND_WAREHOUSE` | |
| `apparcadebusiness` | 14 | `NETWORK_SPEND_ARCADE_MGMT`, `_BUY_MFGARAGE`, `_SET_DISCOUNT`, `_UPGRADE_ARCADE`, `NETWORK_SPENT_GENERIC` | |
| `appsecuroserv` | 10 | `NETWORK_SPENT_PURCHASE_WAREHOUSE_PROPERTY`, `_UPGRADE_WAREHOUSE_PROPERTY`, and the three `_IMPEXP_WAREHOUSE_PROPERTY` ones (purchase, trade, upgrade) | `NETWORK_EARN_FROM_PROPERTY` |
| `appsmuggler`, `apphackertruck` | 10 each | `NETWORK_SPENT_SKIP_CARGO_SOURCE_SETUP` | |
| `appimportexport` | 9 | | |
| `apphackerden` | 7 | `NETWORK_SPENT_GENERIC` | |
| `appfixersecurity`, `appbailoffice`, `appavengeroperations`, `appcovertops` | 0 | | |

The last four make no transaction of their own; they hand their actions to other scripts. The apps with server calls also carry the shared table of transaction service names (238 to 334 entries, depending on the app).

### 46.5.2 VIP and MC challenges (second pass)

*Second pass, 2026-10-30.* **Verified** in `am_pi_menu`, `freemode` and `tuneables_processing`; the names of the challenges are the menu text.

**Which challenges there are.** The interaction menu's "VIP Challenges" page (`PIM_MAGCHL`) lists eight entries, and the "Club Challenges" page (`PI_BIK_1_5_T`) three. Each VIP entry passes a menu id to a function that returns that challenge's `_instances_permitted` tunable, and that ties the menu text to its internal name and script:

| Menu text | Menu id | Internal name (tunables) | Script |
| --- | ---: | --- | --- |
| Cashing Out | 171 | `exec_cashing_*` | `gb_cashing_out` |
| Salvage | 172 | `exec_salvage_*` | `gb_salvage` |
| Auto Buyout | 163 | `gb_carjacking_*` | `gb_carjacking` |
| Due Diligence | 160 | `gb_finders_keepers_*` | `gb_finderskeepers` |
| Most Wanted | 153 | `gb_mostwanted_*` | `gb_fivestar` |
| Point to Point | 162 | `gb_pointtopoint_*` | `gb_point_to_point` |
| Courier Service | 155 | `gb_protectionracket_*` | `gb_collect_money` |
| Market Manipulation | 154 | `gb_smashandgrab_*` | `gb_rob_shop` |
| Search and Destroy (MC) | | `biker_search_and_destroy_*` | `gb_biker_search_and_destroy` |
| Criminal Mischief (MC) | | `biker_mischief_*` | `gb_biker_criminal_mischief` |
| Wheelie Rider (MC) | | `biker_wheelie_*` | `gb_biker_wheelie_rider` |

Each script reads its own block (checked by finding a block-specific field, such as the bag value or the destination radius, in that script only).

**The rules, from the tunable defaults.** Cash is the winner's default reward; RP is the winner's RP. Every VIP challenge also pays losers who took part $500 and 100 RP (`_minimum_participation_cash`, `_rp`), and has its own 10-minute cooldown.

| Challenge | Time limit | Cash | RP | Other rules |
| --- | --- | ---: | ---: | --- |
| Cashing Out | 10 min | $5,000 bonus, plus $300 to $500 per ATM hack | 2,000 | One player needed; 60-second hacks; a combined-total cap of 30,000 (`exec_cashing_max_combined_total`); the chance of a wanted level rises 10% for each 10 seconds a hack takes, up to 50%, and 100% if the timer runs out; wanted level capped at 3; 10 at once |
| Salvage | 10 min | $15,000 bonus | 2,000 | Two players needed; a 250 m area; four rebreathers active, one given at the start; 10 at once |
| Auto Buyout | 10 min | $5,000, plus a bonus of 0.5% of the car's value (bonus capped at $5,000,000; car value capped at $500,000) | 2,000 | Six delivery areas, five points each, four deliveries a point |
| Due Diligence | 10 min | $15,000; packages $100 each, rising $100 a package | 2,000 | A 200 m area; a flare after 60 seconds |
| Most Wanted | 10 min | $2,000, plus a $3,000 bonus | 500 | Five stars; 15 seconds of grace in tunnels |
| Point to Point | 10 min | $10,000 | 500 | 60 seconds to choose the destination; a 1 km destination radius; players count as taking part within 1 km, or 4 km at the start |
| Courier Service | 10 min | $5,000; the bag is worth $8,000 | 1,500 | Cash drops when you take damage (from $50 for a fall to $200 for a car crash); death costs 15% (at least $200); three wanted stars |
| Market Manipulation | 10 min | $5,000 | 2,000 | Wanted level capped at 5; a store can't be robbed again for 2 minutes; 15% of the cash dropped on death |
| Search and Destroy | 600 s | $20,000 | 2,000 | Targets blipped for 3 minutes; 100 a kill, 200 a headshot, 300 melee, 500 a civilian (points); 4 at once |
| Criminal Mischief | 600 s | $30,000 | 2,000 | Two players needed; 50 for a helicopter or plane and 50 for a police car (points); 10 at once |
| Wheelie Rider | 300 s | $10,000 | 500 | 10 at once |

The MC time limits are in seconds: the script multiplies the tunable by 1,000 (`gb_biker_wheelie_rider`).

**Shared rules.** A boss has to wait 3 minutes (`gb_cooldown_until_next_boss_challenge`, 180,000 ms) between challenges, and 5 between work. Organisation members get half the RP (`gb_challenge_goon_rp_reward_percentage` 0.5). A rival organisation that wins gets 70% of the cash and RP (`gb_rival_org_*_reward_percentage`), and a player outside an organisation 30% of the cash (`gb_solo_cash_reward_percentage`). The wagers keep 10% for the agency (`gb_challenge_wager_agency_cut`).

**How the percentages combine** (*leftovers pass, 2026-11-04*, **Verified** in `gb_rob_shop`, with spot checks in `gb_biker_wheelie_rider`). The percentages never multiply together. A shared reward routine, copied into 69 scripts (the `gb_*` work and challenge scripts, the business battles, two deathmatch controllers and `am_penned_in`), picks **one** pair of factors, one for cash and one for RP, from the challenge id and the player's standing:

| Case | Cash × | RP × |
| --- | ---: | ---: |
| One of the eight VIP challenges (ids 153, 154, 155, 160, 162, 163, 171, 172, the menu ids above) | 1 | 1 for a boss; otherwise `gb_challenge_goon_rp_reward_percentage` (0.5) |
| Id 157 | 1 | 1 |
| Any other id, player in an organisation | `gb_rival_org_cash_reward_percentage` (0.7) | `gb_rival_org_rp_reward_percentage` (0.7) |
| Any other id, player not in an organisation | `gb_solo_cash_reward_percentage` (0.3) | `gb_solo_rp_reward_percentage` (0.3) |
| Either of the last two, but the player belongs to the organisation their own record points at (our reading: the one running the work) | 1 | 1 |

A few ids replace the 0.7 and 0.3 with tunables of their own: ids 239 to 242, 244 and 248, and a group of 25 ids: 148 and 179 (each only in one state), plus 23 ids from 180 to 211. Their names are hashed, and their defaults are the same 0.7 and 0.3, or 70 and 30 read as percentages. So the rival and solo percentages never apply to the eight VIP challenges. There, anyone who wins gets the full cash, and only the RP depends on whether the winner is the boss.

The winner's sum is then worked out in this order, rounding after each step: (cash collected during the challenge + the base reward) ÷ a divisor, × the cash factor, × one more multiplier. RP goes through the same steps. The base reward is the default reward tunable × its event multiplier tunable (for Market Manipulation, `gb_smashandgrab_default_cash_reward` 5,000 × `gb_smashandgrab_event_multiplier_cash` 1.0). In `gb_rob_shop` the divisor and the extra multiplier keep their starting values (1 and 1.0), and two fixed bonuses are off (-1). The cash collected is the total cash held by the organisation's players, capped by a tunable and halved while one server flag is set. Losers get the participation amounts without any factor, except for ids 185, 220 and 221, which scale them the same way.

### 46.5.3 The nightclub's safe and warehouse (second pass)

*Second pass, 2026-10-30.* **Verified** in `freemode` and `tuneables_processing`. The popularity tunables have names; the warehouse ones are known only by hash, so they're named here by the function that reads them.

**The safe.** `freemode` pays into the safe on a timer kept in a stat. The timer is 2,880,000 ms (48 minutes, one in-game day), and when it runs out the script pays an amount picked by the current popularity (0 to 100). The amount comes from the `nightclubincomeuptopop<N>` tunables, where each band covers popularity up to N:

| Popularity up to | 5 | 10 | 15 | 20 | 25 | 30 | 35 | 40 | 45 | 50 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Pay ($) | 1,500 | 1,600 | 1,800 | 2,000 | 2,200 | 2,500 | 8,000 | 8,500 | 9,000 | 9,500 |

| Popularity up to | 55 | 60 | 65 | 70 | 75 | 80 | 85 | 90 | 95 | 100 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Pay ($) | 10,000 | 20,000 | 21,000 | 22,000 | 23,000 | 24,000 | 25,000 | 45,000 | 50,000 | 50,000 |

- **Multiplier.** The pay is multiplied by a hashed float tunable, 1 by default (an event multiplier).
- **Cap.** The safe holds at most `nightclubmaxsafevalue`, $250,000. A payment that would pass the cap is cut, and a full safe shows `CLUB_NO_PAY` instead of `CLUB_PAY`.
- **Popularity changes.** These come from a nine-case function of tunables, each times 100:
  - decay `nightclubpopdecay` -0.1;
  - decay with the staff upgrade `inightclubpopdecaystaffupgrade` -0.05;
  - gain from a "permission" (promotion) job `nightclubpopgainpermission` 0.25;
  - six further hashed cases.

  Which in-game step applies each one isn't traced.

**The warehouse goods.** Three seven-case functions read the goods tunables, one value per goods type:

| Type | Goods (**Known** order) | Value per unit | Capacity | Units from one source job |
| ---: | --- | ---: | ---: | ---: |
| 0 | Cargo and shipments | $10,000 | 50 | 1 |
| 1 | Sporting goods | $5,000 | 100 | 2 |
| 2 | South American imports | $27,000 | 10 | 1 |
| 3 | Pharmaceutical research | $11,475 | 20 | 1 |
| 4 | Organic produce | $2,025 | 80 | 7 |
| 5 | Printing and copying | $1,350 | 60 | 10 |
| 6 | Cash creation | $4,725 | 40 | 3 |

- **Which column is which.** The value column is multiplied by a unit count, so it is the sale value of each unit. The capacity column is divided by 5 elsewhere.
- **The units column** (*corrected in the leftovers pass, 2026-11-04*, **Verified**). These seven tunables are read only by `fm_content_club_source`, Yohan's source missions. They are multiplied by a multiplier tunable and paid with the transaction `service_earn_yohan_source_goods` (`NETWORK_YOHAN_SOURCE_GOODS`). So they are the units one source job adds for its goods type, not a production step, as the second pass had guessed (*probable*).
- **Production time and technicians** (*leftovers pass, 2026-11-04*, **Verified** in `freemode`; tunable names hashed). One unit of each goods type takes a fixed time:

  | Type | Goods | Time per unit |
  | ---: | --- | ---: |
  | 0 | Cargo and shipments | 8,400,000 ms (140 min) |
  | 1 | Sporting goods | 4,800,000 ms (80 min) |
  | 2 | South American imports | 14,400,000 ms (240 min) |
  | 3 | Pharmaceutical research | 7,200,000 ms (120 min) |
  | 4 | Organic produce | 2,400,000 ms (40 min) |
  | 5 | Printing and copying | 1,800,000 ms (30 min) |
  | 6 | Cash creation | 3,600,000 ms (60 min) |

  - **One upgrade halves every time.** The time is multiplied by a further tunable (0.5) when one nightclub check on the player passes (our reading: the equipment upgrade).
  - **Five technician slots.** Assignments are bits in the player's broadcast data (`Global_1845250[player].f_260.f_321`). Slots 0 to 3 use bit (slot × 7 + goods type) of `.f_2`; slot 4 uses bit (goods type) of `.f_3`. A goods type is produced when a hired technician has its bit set.
  - **The countdown.** Each type in production has a network-time timer, and its remaining time counts down only while three player checks pass (one of them is the boss check). The remaining time of each type is saved in character stats 15626 to 15632 (types 1 to 6, then 0). At start-up it is read back and reset to the full time if it is zero or larger than the full time.

### 46.5.4 How production time is kept (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in `freemode` for the biker businesses and the bunker; the claim about time spent offline is our reading, and it agrees with **Known** player experience.

- **One unit takes the production-time tunable** (`biker_weed_production_time` 360,000 ms, `biker_meth_production_time` 1,800,000, `biker_crack_production_time` 3,000,000, `biker_fakeids_production_time` 300,000, `biker_countercash_production_time` 720,000, `biker_acid_production_time` 135,000; `gr_manu_production_time` 600,000 and `gr_research_production_time` 300,000 for the bunker). Upgrades subtract tunable amounts from it.
- **The timer runs on network time in script memory.** Each business slot has a timer started with the network clock (`GET_NETWORK_TIME`, or the game timer outside a network game). The time left to the next unit is kept in two places: a per-slot value in `freemode`'s memory, and the player's broadcast data (field `.f_9` of each of the seven business slots in `Global_1845250[player].f_260.f_205`, plus `.f_298` for a second line). When the timer restarts, the time already done is subtracted from the full production time, so a part-finished unit isn't lost.
- **Time while offline isn't counted** (our reading). Nothing in this path reads a clock that keeps running outside the session. Only the time left to the next unit carries over, through the broadcast data, which is filled when the session starts.
- **A second, real-time timer.** Each biker business also has a "delay" timer kept in seconds of cloud time (`GET_CLOUD_TIME_AS_INT`), with lengths from the `biker_*_delay_production_time` tunables (600 s; meth 1,200 s; halved with an upgrade; ×13 or ×5 in two special cases). When a slot's start time is first set and the business already holds more than one unit, the start is moved back by (units − 1) × delay, so those units count as already made. This timer is the one that uses real time.

Where the broadcast fields are loaded from and saved to in the stats isn't traced here.

### 46.5.5 Business Battles (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in the build 1.0.3725.0 decompile; the meaning of the cargo label abbreviations is our reading.

**Four scripts.** `business_battles` (287,143 lines) is the freemode event. `fm_content_business_battles` (519,786) is the newer `fm_content` version of it. `business_battles_sell` (513,141) and `business_battles_defend` (499,894) are the related sell and defend jobs; they use the nightclub contacts' labels (`BTL_DAVE`, `BTL_TONY` ...) and the defend-text families (`BB_OT`, `BB_TXT`, `BB_BM`, `BB_TT`, `BB_HT`). The event-type table (46.2) lists all four in its range 114 to 127.

**The event's variations.** `business_battles` keeps a variation number and a cargo type in its server data, both picked together when the event starts. 102 `switch` statements test the variation, with cases 0 to 28, 39 and 41 to 44 (34 variations). The location label, guard weapons and enemy models tell them apart:

| Variations | Where | Enemies and weapons |
| --- | --- | --- |
| 0 to 2 | (no location label) | Pistol and SMG guards |
| 3 to 12 | `BB_POLSTAT`, ten police stations | Unarmed (a break-in) |
| 13, 14, 15 | `BB_LOC_AGUJA`, `BB_LOC_ECLPSE`, `BB_LOC_PLAYA` | Micro SMG and pistol |
| 19 to 21 | `BB_LOC_DROPSITE` | Carbine rifle, pump shotgun, SMG, pistol and the railgun |
| 22 | near 950.8, -2110.6, 29.6 | The Lost (`g_m_y_lost_01` on `daemon` bikes) |
| 23 | near -936.6, -2969.1, 12.9 | Professionals (`mp_g_m_pros_01` in a `kuruma`) |
| 24 | near -2293.6, 370.8, 173.6 | Armoured guards (`s_m_m_armoured_01` in a `huntley`) |
| 39 | `BB_LOC_SHOWRM`, a showroom | |
| 41, 43 | `BB_LOC_ZANC` (Fort Zancudo), `BB_LOC_LSNP` | Mercenaries (`BBOT_ELIM_MERC`) |
| 42 | `BB_LOC_UNION` (Union Depository) | Professionals (`BBOT_ELIM_PROF`) |

Variations 16 to 18, 25 to 28 and 44 have no location label or model in these switches. The objective labels (`BBOT_DOWNLOAD`, `BBOT_LAPTOP`, `BBOT_BLOWOPEN`, `BBOT_THROW`, `BBOT_RECOVER`, `BBOT_ASSASS` ...) show the steps: hacking, blowing a safe open, flares and recovering the goods.

**What the goods are.** The cargo type picks the text: type 0 or 4 `BBOT_SPCCARGO` (special cargo), 2 `BBOT_BKRSPPLY` (our reading: biker supplies), 3 `BBOT_GRNSPPLY` (our reading: gunrunning supplies), 5 `BBOT_EVNTCRGO` (event cargo). `fm_content_business_battles` adds `BBOT_WCARGO`. Event cargo is chosen only while an event-cargo list in the tunables (two 10-entry lists and one single value) has an entry. It is then picked with the chance in `bb_business_battle_event_cargo_weighting` (default 0.5).

**Where the goods go.** The delivery text is `BBT_NIGHTCLUB` (to the player's nightclub) or `BBT_DROPOFF` when one check on the player fails (our reading: the player owns no nightclub). The goods payout and the nightclub stock change aren't traced here.

## 46.6 What this means for modders

These are Online systems: read them, never mod them in Online. For an offline or story-mode project:

- **The tunable defaults are a complete, balanced economy.** A story-mode "business" mod can copy the loop and numbers in 46.4 (capacity, minutes per unit, value per unit, upgrades) and keep them in its own save.
- **One table launches everything:** the event-type table is the model for a mod's own job menu: a number per job and a function that returns the script or handler.
- **Work scripts depend on `freemode`, broadcast data and the server;** they won't run offline. Rebuild the mission logic instead (resupply: steal and deliver; sell: deliver within a time, with enemies scaled by difficulty as in [R17.10](/docs/ai/script-ai-patterns.md)).
- **Production runs on real time:** Online counts production in minutes of play; an offline mod decides whether time passes while the game is closed.

## 46.7 Open questions

| Question | Where it goes |
| --- | --- |
| The nightclub's production and popularity numbers (their tunable names are hashed) | Mostly answered in [46.5.3](#4653-the-nightclubs-safe-and-warehouse-second-pass): the safe pay bands, cap and timer, and each goods type's value, capacity and units one Yohan source job adds |
| How long a nightclub production step takes and how technicians are assigned (ON-077) | Answered in [46.5.3](#4653-the-nightclubs-safe-and-warehouse-second-pass) (leftovers pass): the time per unit for each goods type (30 to 240 minutes, halved by one upgrade), the five technician slots and their assignment bits, and the remaining times saved in stats 15626 to 15632 |
| Special cargo warehouse capacities (16, 42 and 111 crates are **Known**) and where the scripts keep them | Answered in [46.5.1](#4651-warehouse-sizes-boss-costs-and-the-apps-transactions-second-pass) |
| How production is stored in stats and advanced while offline or in another session | Partly answered in [46.5.4](#4654-how-production-time-is-kept-leftovers-pass) (leftovers pass): production runs on a network-time timer, and only the time left to the next unit carries over (broadcast data `.f_9`), so offline time isn't counted (our reading). A second biker timer runs on cloud time and is backdated by the units already held. Left: the stat load and save |
| What `gb_bosscost` and `gb_bosssetupcost` charge | Answered in [46.5.1](#4651-warehouse-sizes-boss-costs-and-the-apps-transactions-second-pass): nothing in this build (no script reads them) |
| Where registering as a boss is charged now (ON-075) | Third pass, the boss registration code in `freemode` and `am_pi_menu` |
| The MC challenge and VIP challenge rules (cash, RP, time) | Answered in [46.5.2](#4652-vip-and-mc-challenges-second-pass): the 11 challenges, their scripts and their tunables. Leftovers pass: one shared routine picks a single cash and RP factor per case, and the VIP challenges never use the rival or solo percentages |
| Business battles and the `fm_content_*` business missions | Partly answered in [46.5.5](#4655-business-battles-leftovers-pass) (leftovers pass): the four scripts, the 34 variations with their locations and enemies, the cargo types and the event-cargo chance, and the delivery target. Left: the payouts, and the other `fm_content_*` business missions |
