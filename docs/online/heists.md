# Heists in GTA Online

How GTA Online's four generations of heists are built and paid: the planning scripts and boards, where preps and finales run, and the numbers in the tunables: setup costs, finale takes, crew cuts, failure penalties, target values and cooldowns for the classic heists, the Doomsday Heist, the Diamond Casino Heist and the Cayo Perico Heist. Roadmap topic **R7.8** in the [roadmap](/ROADMAP.md). Research only: this documents Rockstar's Online scripts; never run mods in GTA Online. Builds on [organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7: the event-type table and tunable defaults), [the job lobby](/docs/online/job-lobby.md) (R7.5), [the UGC mission format](/file-formats/ugc-json.md) (R7.4) and [how Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md) (R17.10: story-mode heist crews).

**How it was made.** Tunable defaults parsed from `tuneables_processing` (build 1.0.3725.0, decompile commit `6c18d3e8b`; 35,834 registrations, names where the script gives them, hashes otherwise); the planning scripts `gb_casino_heist_planning` (43,973 lines), `heist_island_planning` (34,199), `gb_gang_ops_planning` (31,091) and the controllers read for which tunable feeds which value; crew names from the American text. Values are tunable **defaults** (the live game can override them) and are **Verified**, as is which function uses them. Where a hashed tunable's meaning comes only from its value and position, it is marked *probable*. What players see is **Known**.

## 47.1 Short version

- **Four generations, four planning scripts:** the classic heists (2015) plan on the apartment board, the Doomsday Heist on the facility screen (`gb_gang_ops_planning`), the Casino Heist on the arcade boards (`gb_casino_heist_planning`), Cayo Perico on the Kosatka screen (`heist_island_planning`). Preps and finales run in the mission controllers (`fm_mission_controller`, `_2020`) or, for Cayo preps, in `fm_content_island_heist`.
- **Classic heists:** setup cost $11,500 (Fleeca) or $25,000; finale takes of $201,250 (Fleeca), $700,000 (Prison Break), $945,000 (Humane Labs), $707,000 (Series A) and $1,500,000 (Pacific Standard); total take kept between $100,000 and $1,875,000.
- **Cuts:** the leader's default is 55% (60% on the tutorial Fleeca job), nobody may be set below 15%, and no one can take more than 70%. Each prep pays the crew a small percentage of the take (3.26%, 2.09% for Pacific Standard).
- **Failing costs money:** a failed finale costs 0% to 60% of the take depending on how long the team took (time bands 2, 4, 6, 8, 10 and 15); failed preps cost 0% to 15%.
- **Doomsday:** finales of $975,000 (IAA), $1,425,000 (submarine) and $1,800,000 (missile silo); preps pay $39,000 to $54,000; take capped at $3,000,000; prep skips cost $94,500 to $175,500.
- **Casino:** targets of $2,115,000 (cash), $2,350,000, $2,585,000 and $3,290,000 (diamonds), ×1.1 on hard; crew members cost 3% to 10% each and Lester 5%.
- **Cayo Perico:** primary targets of $630,000 (tequila), $700,000 (necklace), $770,000 (bonds), $1,100,000 (Madrazo files), $1,300,000 (pink diamond) and $1,900,000 (panther statue); which one appears is weighted (tequila 60%); support crew costs $10,000 to $30,000.

## 47.2 Where each heist lives

| Heist | Planning | Preps and finale | Board script size |
| --- | --- | --- | ---: |
| Classic (Fleeca, Prison Break, Humane Labs, Series A, Pacific Standard) | Apartment planning room (which script draws the board is an open question) | Rockstar-made jobs run by `fm_mission_controller` | |
| Doomsday (Data Breaches, Bogdan Problem, Doomsday Scenario) | `gb_gang_ops_planning` in the facility; preps also through `GB_GANGOPS` (event type 113) | `fm_mission_controller` | 31,091 lines |
| Diamond Casino | `gb_casino_heist_planning` in the arcade; preps through `GB_CASINO_HEIST` (126) | `fm_mission_controller_2020` | 43,973 lines |
| Cayo Perico | `heist_island_planning` on the Kosatka | Preps in `fm_content_island_heist`; finale in `fm_mission_controller_2020` | 34,199 lines |

Which controller runs which finale is **Known**, not read. The finales are Rockstar-created jobs in the creator format ([R7.4](/file-formats/ugc-json.md)), loaded from the cloud and run by the mission controllers (**Known**); the planning scripts only choose options, pay setup costs and launch them.

## 47.3 Classic heists

Tunable defaults (**Verified**):

| Heist | Setup cost | Finale take | Prep cut |
| --- | ---: | ---: | ---: |
| The Fleeca Job | 11,500 | 201,250 | 3.26% |
| The Prison Break | 25,000 | 700,000 | 3.26% |
| The Humane Labs Raid | 25,000 | 945,000 | 3.26% |
| Series A Funding | 25,000 | 707,000 | 3.26% |
| The Pacific Standard Job | 25,000 | 1,500,000 | 2.09% |

**Cut rules:** `heists_leader_default_heist_finale_cut` 55, `leader_default_heist_tutorial_finale_cut` 60, `leader_min_heist_finale_take_percentage` and `member_min_...` 15, `max_heist_cut_amount` 70. Total take is clamped by `earnings_heists_finale_minimum_total_cash_take` 100,000 and `_maximum_` 1,875,000. Dropped cash during the money grab is tied to two thresholds (10,000 and 14,000), and a team can lose at most 45% of the take to damage and drops (`max_heist_cash_loss_percentage`).

**Failure penalties** (**Verified** tables; time bands are the tunable values as stored, units not read):

| Band | Up to | Finale penalty | Prep penalty |
| ---: | ---: | ---: | ---: |
| 1 | 2 | 0% | 0% |
| 2 | 4 | 16% | 4% |
| 3 | 6 | 20% | 5% |
| 4 | 8 | 24% | 6% |
| 5 | 10 | 32% | 8% |
| 6 | 15 | 40% | 10% |
| 7 | more | 60% | 15% |

## 47.4 The Doomsday Heist

| Act | Finale take | Prep reward each |
| --- | ---: | ---: |
| The Data Breaches (IAA) | 975,000 | 39,000 |
| The Bogdan Problem (submarine) | 1,425,000 | 42,750 |
| The Doomsday Scenario (missile silo) | 1,800,000 | 54,000 |

Setup costs are `h2_cost_*` (25,000 for the submarine act); skipping preps costs 94,500, 114,750, 135,000, 155,250 and 175,500 for the first to fifth skip. The take is clamped between 100,000 and 3,000,000 and failure uses the same penalty bands as the classic heists (`gangops_*` copies). Replay cooldowns depend on the team size (for the submarine act: 10,800 with 2 players, 9,000 with 3, 7,200 with 4). Elite challenges have a 15-minute time limit (`h2_elite_objectives_time_*` 900,000 ms).

## 47.5 The Diamond Casino Heist

From `gb_casino_heist_planning` (**Verified** which function reads each value; the tunable names are hashed except `ch_lester_cut` and `heist3_setup_cost`):

| Value | Default |
| --- | --- |
| Setup cost | 25,000 |
| Target value by target index 0 to 3 | 2,115,000; 2,585,000; 2,350,000; 3,290,000 (cash, then *probably* gold, artwork, diamonds) |
| Hard difficulty multiplier | 1.1 (normal 1.0) |
| Lester's cut | 5% |

**Crew cuts** (percent of the take), by the role lists on the board:

| Slot | Gunman | Cut | Driver | Cut | Hacker | Cut |
| ---: | --- | ---: | --- | ---: | --- | ---: |
| 1 | Karl Abolaji | 5 | Karim Denz | 5 | Rickie Lukens | 3 |
| 2 | Gustavo Mota | 8 | Taliana Martinez | 7 | Christian Feltz | 7 |
| 3 | Charlie Reed | 7 | Eddie Toh | 9 | Yohan Blair | 5 |
| 4 | Chester McCoy | 10 | Zach Nelson | 6 | Avi Schwartzman | 10 |
| 5 | Patrick McReary | 8 | Chester McCoy | 10 | Paige Harris | 9 |

The board's "potential take" is the target value (×1.1 on hard), times the percentages of the three chosen crew plus Lester's 5% taken off (the function adds the three cuts and Lester's and applies them to the take, **Verified**).

## 47.6 The Cayo Perico Heist

Tunable defaults (**Verified** names):

| Primary target | Value | Chance it is offered |
| --- | ---: | ---: |
| Sinsimito tequila | 630,000 | 60% |
| Ruby necklace (`pearl_necklace`) | 700,000 | 15% |
| Bearer bonds | 770,000 | 15% |
| Pink diamond | 1,300,000 | 10% |
| Madrazo files | 1,100,000 | (first heist) |
| Sapphire panther statue | 1,900,000 | (rare, not weighted here) |

A "boost" set of weights (necklace and bonds 40%, diamond 20%, tequila 0) applies at times set by `h4_target_weighting_posix_time` (259,200 s = 3 days) (*probable*). Next to the values sit a 1.1 multiplier (*probably* hard mode) and −0.1 and −0.02 (*probably* the 10% fencing fee and Pavel's 2%).

| Support crew and extras | Cost |
| --- | ---: |
| Weapon stash | 10,000 |
| Airstrike | 12,000 |
| Heavy weapon | 15,000 |
| Sniper | 25,000 |
| Drone | 25,000 |
| Air support | 30,000 |
| Suppressors | 5,000 |
| Replay | 100,000 |

Cooldowns: `h4_cooldown_time` 2,880, `h4_cooldown_hard_time` 5,760 and `h4_solo_cooldown` 5,760 (*probably* seconds: 48 and 96 minutes). The Kosatka's on-call cooldown is `island_heist_on_call_cool_down` 3,600.

## 47.7 What this means for modders

These are Online systems: read them, never mod them in Online. For a story-mode heist mod:

- **Copy the economics, not the scripts.** The tables above are a tested set of numbers: a setup cost, preps that pay a few percent, a finale take, 15% minimum and 70% maximum cuts, and a failure penalty that grows with time.
- **Crew members as data:** the casino crew table (role, cut) and the story crew table in [R17.10](/docs/ai/script-ai-patterns.md#447-heist-crews) (cut plus health, accuracy and shoot rate) are the two models Rockstar uses; a mod can pick either.
- **Target weighting** is a neat way to vary replays: Cayo Perico picks the prize by weights that change on a timer.
- **The finales are creator jobs;** a mod can't load them offline without the cloud content. Build the mission yourself ([missions cookbook](/modding/cookbook/missions.md)).

## 47.8 Open questions

| Question | Where it goes |
| --- | --- |
| The units of the failure time bands (minutes of play, *probable*) | Next pass, the mission controller |
| The casino target index order (gold or artwork at index 1) | Next pass: the target name function |
| Cayo secondary loot values (cash, weed, coke, gold, paintings) and bag capacity | Next pass: hashed tunables near the primary values |
| How the classic apartment board is drawn and which script owns it | Next pass, `freemode` |
| Elite challenge rewards for each heist | Next pass |
| The heist story arcs and their contacts | [R7.9](/ROADMAP.md) |
