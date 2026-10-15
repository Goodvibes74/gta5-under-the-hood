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

## 46.6 What this means for modders

These are Online systems: read them, never mod them in Online. For an offline or story-mode project:

- **The tunable defaults are a complete, balanced economy.** A story-mode "business" mod can copy the loop and numbers in 46.4 (capacity, minutes per unit, value per unit, upgrades) and keep them in its own save.
- **One table launches everything:** the event-type table is the model for a mod's own job menu: a number per job and a function that returns the script or handler.
- **Work scripts depend on `freemode`, broadcast data and the server;** they won't run offline. Rebuild the mission logic instead (resupply: steal and deliver; sell: deliver within a time, with enemies scaled by difficulty as in [R17.10](/docs/ai/script-ai-patterns.md)).
- **Production runs on real time:** Online counts production in minutes of play; an offline mod decides whether time passes while the game is closed.

## 46.7 Open questions

| Question | Where it goes |
| --- | --- |
| The nightclub's production and popularity numbers (their tunable names are hashed) | Next pass: match hashes to names from the scripts |
| Special cargo warehouse capacities (16, 42 and 111 crates are **Known**) and where the scripts keep them | Next pass |
| How production is stored in stats and advanced while offline or in another session | Next pass, with the stats file |
| What `gb_bosscost` and `gb_bosssetupcost` charge | Next pass, `freemode` |
| The MC challenge and VIP challenge rules (cash, RP, time) | Next pass, per script |
| Business battles and the `fm_content_*` business missions | R7.9 and a later pass |
