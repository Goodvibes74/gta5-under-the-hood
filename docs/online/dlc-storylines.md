# DLC storylines in GTA Online

How each GTA Online update's story is started and carried: the DLC pack behind it, the `freemode` "flow" that sends the calls, texts and help that open the arc, the contacts, which missions are scripts on disk and which are cloud jobs, the property cutscenes, and what it takes to rebuild an arc. Roadmap topic **R7.9** in the [roadmap](/ROADMAP.md). Research only: this documents Rockstar's Online scripts; never run mods in GTA Online. Builds on [inside freemode](/docs/online/07-freemode.md) (R7.1: the flow functions), [the UGC mission format](/file-formats/ugc-json.md) (R7.4: the 1,001 local mission files), [organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7: the event-type table), [heists](/docs/online/heists.md) (R7.8), [properties](/docs/online/properties.md) (R7.6) and [DLC packs](/docs/entities/vehicles/dlc-packs.md).

**How it was made.** `common\data\dlclist.xml` from `update\update.rpf` of build 1.0.3725.0 (pack order); `freemode` from the decompile (commit `6c18d3e8b`) searched for the label families its story flows use, and every label's English text read from `update\update2.rpf` and the `americandlc.rpf` of the six newest packs with a small `.gxt2` reader; cutscene names counted from every literal `REQUEST_CUTSCENE` argument in the decompile; the local/cloud split from the event-type table in `am_launcher` and the local `.ugc` files ([R7.4](/file-formats/ugc-json.md)). Pack names, label texts and counts are **Verified**; update names and dates, and what happens in the missions, are **Known**.

## 48.1 Short version

- **Each update since 2016 has a flow in `freemode`:** a block of calls, texts and help, keyed to stats, that tells the player what to buy and where to go next. They are found by their label families: `EXEC_FLW`, `GR_FLOW`, `SM_FLOW`, `AW_FLOW`, `VCMFLOW`, `CH_FLOW`, `HIF_`, `TFLOW`, `FIX_FLOW`, `SUM22_`, `XM22`, `SUM23_FLOW`, `SAL23_FLOW`, `BT24_FLOW`, `HK24_FLW`, `TYFLOW` and newer ones whose text lives in voice or DLC files.
- **The trigger is almost always a purchase:** buy the property on an in-game website (Maze Bank Foreclosures, Dynasty 8 Executive, Warstock), visit it, meet the contact. Cayo Perico starts with a text from Miguel Madrazo; Drug Wars with a "help Ron" prompt; The Contract with an Agency purchase and a meeting with Franklin at the golf club.
- **Two kinds of missions:** older story missions (heists, Doomsday, the Casino story, the ULP missions, Drug Wars' First and Last Dose, most finales) are cloud jobs run by `fm_mission_controller` or `_2020`, and only 16 such missions ship on disk (the Cayo Perico finale in 13 languages and two others). Newer business and side content is local: 91 `fm_content_*` scripts in the event-type table, reading about 980 local content files.
- **Property intros are local cutscenes** named in the scripts (`FIX_AGY_INT1`, `HS4_SUB_INT`, `TUN_SHOP_INT`, `XM4_YARD_INT`, `XM24_FACTORY_INT`, `XM25_MANSION_INTA` ...); mission cutscenes come with the cloud job.
- **Rebuilding an arc offline** therefore means: the property and its intro are on disk, the flow's texts are on disk, local `fm_content` missions are on disk (but need `freemode`), and the cloud missions must be recreated by hand.

## 48.2 Updates, packs and flows

Packs in `dlclist.xml` order (**Verified**), the update they belong to (**Known**), and the flow that starts the story (**Verified** labels and text):

| Pack | Update | Flow labels | How the arc starts (from the flow text) | Contacts named |
| --- | --- | --- | --- | --- |
| `mpheist` | Heists | | Lester's call to an apartment owner (**Known**) | Lester |
| `mpexecutive` | Further Adventures in Finance and Felony | `EXEC_FLW` (5) | Buy an office; "you can now become a CEO at any time"; log in to the SecuroServ Special Cargo Network | |
| `mpimportexport`, `mpbiker` | Import/Export, Bikers | `IMPA_FLOW` (2, text not read) | Vehicle warehouse; clubhouse | |
| `mpgunrunning` | Gunrunning | `GR_FLOW` (25) | Buy a bunker at foreclosures.maze-bank.com; Mobile Operations Center missions for Agent 14; discounted weaponized vehicles | Agent 14 |
| `mpsmuggler` | Smuggler's Run | `SM_FLOW` (7) | Buy a hangar; the Air-Freight business | |
| `mpchristmas2017` | The Doomsday Heist | | Facility; planning in `gb_gang_ops_planning` ([R7.8](/docs/online/heists.md)) | Lester, Agent 14 |
| `mpbattle` | After Hours | | Nightclub | |
| `mpchristmas2018` | Arena War | `AW_FLOW` (26) | Buy an Arena Workshop at arenawar.tv; sponsorship tiers unlock clothing, mods and vehicles | Sacha, Pegasus |
| `mpvinewood` | The Diamond Casino & Resort | `VCMFLOW` (14) | Buy and visit a penthouse; meet Tom Connors and Ms. Baker | Agatha Baker, Tom Connors, Vincent |
| `mpheist3` | The Diamond Casino Heist | `CH_FLOW` (7) | Go to the planning area in your new arcade | Lester, Yung Ancestor, Packie |
| `mpheist4` | The Cayo Perico Heist | `HIF_` (33) | Text from Miguel Madrazo: meet him at the Music Locker; buy a Kosatka; Pavel's tour | Miguel Madrazo, Pavel |
| `mptuner` | Los Santos Tuners | `TFLOW` (23) | Mimi's email about the LS Car Meet; buy an Auto Shop for KDJ and Sessanta's contracts | Mimi, KDJ (Moodymann), Sessanta |
| `mpsecurity` | The Contract | `FIX_FLOW` (37) | Buy a Celebrity Solutions Agency; meet Franklin at the golf club about the VIP client | Franklin, Imani, Lamar, Vernon, Dr. Dre, DJ Pooh |
| `mpsum2` | The Criminal Enterprises | `SUM22_` (24) | Business add-ons per business; Operation Paper Trail at the IAA headquarters | Agent ULP, Lupe, Malc, Sindy, Agent 14, Marcel, Yohan |
| `mpchristmas3` | Los Santos Drug Wars | `XM22` (19) | "Press to help Ron with his situation"; First Dose and Last Dose missions | Dax, Ron |
| `mp2023_01` | San Andreas Mercenaries | `SUM23_FLOW` (9) | Buy an Avenger and its Operations Terminal; Project Overthrow and LSA Operations | Rooster, Ron |
| `mp2023_02` | The Chop Shop | `SAL23_FLOW` (18), `SALV23_` (21) | Buy a Salvage Yard; meet Yusuf Amir; robberies (Cargo Ship, Gangbanger, Duggan, Podium, McTony); The Cluckin' Bell Farm Raid with Vincent | Yusuf Amir, Vincent |
| `mp2024_01` | Bottom Dollar Bounties | `BT24_FLOW` (2) | Buy a Bail Office; meet Maude Eccles | Maude Eccles |
| `mp2024_02` | Agents of Sabotage | `HK24_FLW` (19) | Buy the Darnell Bros Garment Factory and meet Pavel for jobs from an ex-FIB agent; the Black Box, Brute Force, Fine Art and Project Breakaway files; buy the McKenzie Field Hangar for Oscar Guzman Flies Again | Pavel, Oscar Guzman |
| `mp2025_01` | Money Fronts | `TYFLOW` (5) | Visit Martin Madrazo; buy the Hands On Car Wash to launder money | Martin Madrazo, Raf |
| `mp2025_02` | A Safehouse in the Hills (the pack's `global` text says "Part of A Safehouse in the Hills", **Verified** in the second pass) | `MP252_*` music events | Mansion intro cutscenes `XM25_MANSION_INTA` to `C`; mansions The Tongva Estate, Richman Villa, The Vinewood Residence | |

Flows with text outside the main text files (`XM4V_FLW` 22, `S25R_FLW` 6, `SR2CH_FLW` 6, `X24O_FLW`, `S25M_FLW`, `SR2RN_FLW`) are phone calls, whose subtitles live in each pack's dialogue blocks ([R9.2](/docs/audio/speech-and-dialogue.md); see 48.2.1).

### 48.2.1 The phone-call flows (second pass)

*Second pass, 2026-10-30.* **Verified** by reading `freemode`, which returns each call's conversation root with its dialogue block (for example `XM4VAU`). The subtitles were then matched in the packs' `americandlc.rpf`: each line is the root plus `_<n>`, so `XM4V_FLW_1A_1` is the first line of call `XM4V_FLW_1A`. `freemode` names 40 roots, and every one has lines. In short, in our own words:

| Calls (block, pack) | Caller | What the calls cover |
| --- | --- | --- |
| `XM4V_FLW_1A` to `14C`, 22 calls (`XM4VAU`, `mp2023_02` The Chop Shop) | Vincent Effenburger (names himself) | The Cluckin' Bell Farm Raid: the opening offer (four versions, by how the player knows Vincent: not yet, from the Diamond Casino, or from his mall security job at Rockford Plaza), then one call after each setup step (the train, the weapons and gear, the getaway car, the supply-line sabotage, with an "A" or "B" version for a clean or loud result), the go-ahead for the raid, and the pay-out calls after the finale and its replays |
| `SR2CH_FLW_1A` to `6A`, 6 calls (`SR2CHAU`, `mp2023_01` San Andreas Mercenaries) | Charlie (**Known**; he calls the player "TL") | The Merryweather storyline between Project Overthrow jobs: a cobalt find, Coil weapons tech in stolen crates, a rescue, and the final split between Merryweather and the government |
| `SR2RN_FLW_1A`, `1B`, 2 calls (`SR2RNAU`, same pack) | Ron | Two versions of Ron's opening call: one about the player going into business with the Fooligans in Sandy Shores, one general pitch (*probable*: which condition picks each isn't traced) |
| `X24O_FLW_1A`, `2A`, 2 calls (`X24OAU`, `mp2024_02` Agents of Sabotage) | Oscar Guzman (names himself) | The offer of the McKenzie Field hangar, and the follow-up after buying it |
| `S25M_FLW_1A`, `2A`, 2 calls (`S25MAU`, `mp2025_01` Money Fronts) | Martin Madrazo (names himself) | An invitation to meet someone important at the airport (two versions) |
| `S25R_FLW_1A` to `7A`, 6 calls (`S25RAU`, same pack) | Raf (*probable*: the speaker's name isn't in the subtitles) | Money Fronts' laundering businesses: the car wash, Higgins Helitours, Smoke on the Water, one call when both are owned, and a warning to slow down when too much money goes through at once |

The call-to-pack mapping follows from which pack's `americandlc.rpf` holds each block (**Verified**). The update names are **Known**.

### 48.2.2 After Hours, Doomsday and the 2015 heists (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in `freemode`. These three have no `*_FLOW` label family because their story beats are mostly phone calls from a dialogue block, plus help messages with other prefixes:

| Update | Calls (dialogue block) | Texts and help | Progress kept in |
| --- | --- | --- | --- |
| After Hours (`mpbattle`) | 143 conversation roots `BATFM_*` in block `BATFMAU`. Their name groups include `BATFM_SGN*`, `BATFM_RESIN*`, `BATFM_REMLT*`, `BATFM_MGENF*`, `BATFM_LP*` (four, each used twice), `BATFM_TUCALL` and `BATFM_BMCALL`, plus four 16-call grids (`BATFM_CF*`, `HU*`, `ME*`, `SM*` followed by one of B/D/S/T, then one of A/D/O/P). One function returns the root for an index, and three more 20-entry tables pick among them | Texts `BATFM_REMLT1T`/`2T` and `BATFM_RESIN1T` to `3T`, sent by one function with sender id 153 | Character stat 7229 (bits 0, 5 to 7, 29 and 30), plus session flags |
| The Doomsday Heist (`mpchristmas2017`) | 64 roots `XMFM_*` in block `XMFMAUD`. The facility-buy call has four versions, `XMFM_FBUYA1` to `D1`, with sender id 12. It plays when the player stands within 8.5 m of 1211.7, -1758.6, 39.4 and the conditions pass; which version plays depends on what the player already owns. The other groups include `XMFM_PIA*`, `XMFM_PSI*`, `XMFM_PSU*`, `XMFM_RIV*` and `XMFM_GEN*` | Help `GOPS_BASE_HELP`, `GOPS_BASE_OWN`, `GOPS_LESTBLIP`, `GOPS_R_READY`, `GOPS_H_AVENG`, and replay help per act (`GO_IAA_FIN_R`, `GO_SUB_STR_R`, `GO_SUB_FIN_R`, `GO_SIL_STR_R`, `GO_SIL_OC_R`, `GO_SIL_FIN_R`); texts `GOTXT_RIVAL*` | The call's own memory and session flags; one help function reads and writes character stat 6156 |
| The 2015 heists (`mpheist`) | Lester (contact name `LESTER`, 4 uses) | Help `HEIST_TUTSMS`, `HEIST_PRE_VIEW`, `HEIST_PRE_DONE`, `HEIST_NOTE_2`, `HEIST_READY_HLP`, `HEIST_NEXT_SOON`, `HEIST_FULL`, `HEIST_WARN_2`, and replay help `HEIST_REPLAY`, `_L`, `_FIN` | Spread over about ten small `freemode` functions; the heist planning itself runs in the planning scripts ([R7.8](/docs/online/heists.md)) |

The call subtitles are in each pack's dialogue block, as in 48.2.1. They aren't read for this pass, so what each `BATFM` and `XMFM` call says is still open. Our reading of the name parts (`FBUY` facility purchase, `RIV` rival, `GEN` generic) comes only from the labels.

## 48.3 How a flow works

Each flow is a function in `freemode`'s running state ([R7.1](/docs/online/07-freemode.md)), called every frame (**Verified** placement; **Known** behaviour):

1. It reads the player's stats: does the player own the property, which steps are done, which story mission was passed.
2. When a step's condition is met it sends one beat: a phone call, a text (`*_TXT`), an email (`TFLOW_MAIL`), a help message (`*_HLP`, `*_H`) or a ticker (`*_TCK`), and sets a stat so it doesn't repeat.
3. It places blips and context prompts for the next meeting (`XM22_TRIG_*` "Press ~INPUT_CONTEXT~ to play First Dose - Designated Driver"; `SALV23_CFR_PR0` "Press ~INPUT_CONTEXT~ to start The Cluckin' Bell Farm Raid").
4. After the finale it switches to replay texts (`HIF_REPLAY_*`, `CH_FLOW_TXT_8*`, `FIX_FLOW_HLP23`) with cooldowns from tunables.

The flows also advertise: `GR_FLOW_TXT_*` reminds the player of discounted vehicles, `AW_FLOW_*` announces unlocks, `SUM22_*` introduces each business's new staff.

### 48.3.1 Where each flow keeps its progress (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in `freemode`. A script went through every function that uses a flow's labels, plus the functions that call those, and listed which stats they read and write. Character stats are read with one helper and written with another (`func_26015` and `func_25916` in this build); packed stat bools go through `GET_PACKED_STAT_BOOL_CODE` and `SET_PACKED_STAT_BOOL_CODE`. A flow remembers its beats in one of three ways: **bits of a character stat** (read, set a bit, written back), **packed stat bools**, or **bits in the flow's own script memory** (lost when the session ends, so the beat can repeat):

| Flow | Character stats (bit words) | Packed stat bools |
| --- | --- | --- |
| `EXEC_FLW` | 14804 | |
| `GR_FLOW` | 5467, 7880 | |
| `SM_FLOW` | 6122 (read only) | |
| `AW_FLOW` | 7880 | |
| `VCMFLOW` | 8267, 7880 (also reads 7229, 8283) | |
| `CH_FLOW` | 8838 (also reads 8726) | |
| `HIF_` (Cayo Perico) | 9509, 9510, 10410, 7880, 8267 | 30516 to 30518 set; 30309 and 30520 to 30521 read |
| `TFLOW` | 9618, 9839 | 25520 (read) |
| `SUM22_` | | 13 read (32327 to 32338), 5 set (32335 to 32338, 32364) |
| `XM22` | 10872 (read only) | |
| `SUM23_FLOW` | 11950 (read only) | |
| `SAL23_FLOW`, `SALV23_` | 12033 | 41982 |
| `HK24_FLW` | 12444 | 51342 |
| `TYFLOW` | | 54708 to 54710 |
| `XM4V_FLW` | | 42108 (read) |
| `SR2CH_FLW`, `SR2RN_FLW` | | 41836 (read) |

Stat 7880 is shared by four flows (Gunrunning, Arena War, the Casino and Cayo Perico). Each uses its own bits of it, so it works as a common "story beats seen" word. `FIX_FLOW`, `IMPA_FLOW`, `BT24_FLOW`, `S25R_FLW`, `X24O_FLW` and `S25M_FLW` touch no stat in these functions: they keep their beats in script memory, or read their stats two or more calls away. The stat names behind the numbers need the stats mapping data.

**One flow step by step: `EXEC_FLW`.** It stays quiet while a help message is showing, in an activity session, while the screen is faded out, and in other blocking states. Then, once two player checks pass (our reading: the player owns an office and isn't a boss yet):

1. If bit 14 of stat 14804 is clear: text `EXEC_FLW_TXT_2`, help `EXEC_FLW_HLP_2`, set bit 14.
2. Ten seconds later, if bit 15 is clear and one more check fails: help `EXEC_FLW_HLP_3`, set bit 15.
3. Once bit 15 is set and bit 23 is clear, while the second check still holds: help `EXEC_FLW_HLP4C` or `EXEC_FLW_HLP_4` (which one depends on a second check on the player), then set bit 23.

Each beat writes the stat back at once, so it fires only once per character.

## 48.4 Local and cloud missions

| Kind | Where | How many | Run by |
| --- | --- | ---: | --- |
| Classic creator missions (story missions, heist finales, ULP, Drug Wars doses, Doomsday, Casino story) | Rockstar's cloud; only 16 ship on disk | 16 local | `fm_mission_controller`, `fm_mission_controller_2020` |
| Content jobs (business work, setups, side jobs) | On disk: `update2.rpf\common\data\ugc\` | about 980 | 85 `fm_content_*` scripts read them ([R7.4](/file-formats/ugc-json.md)) |
| Older organisation work | Script only | 70 | `gb_*` scripts ([R7.7](/docs/online/organisations-and-businesses.md)) |

The `fm_content_*` scripts named in the event-type table group by update through their names (**Verified** names; grouping **Known**): `tuner_robbery`, `vehicle_list`, `auto_shop_delivery` (Tuners); `security_contract`, `payphone_hit`, `vip_contract_1` (The Contract); `cargo`, `export_cargo`, `ammunation`, `gunrunning`, `source_research`, `club_management`, `club_odd_jobs`, `club_source`, `bar_resupply`, `bike_shop_delivery`, `clubhouse_contracts` (Criminal Enterprises); `acid_lab_setup`, `_source`, `_sell`, `drug_lab_work`, `stash_house`, `taxi_driver` (Drug Wars era); `smuggler_trail`, `_plane`, `_sell`, `_resupply`, `_ops` (Mercenaries); `vehrob_scoping`, `_task`, `_prep`, `_disrupt`, `_cargo_ship`, `_police`, `_arena`, `_casino_prize`, `_submarine` (Chop Shop); `bounty_targets`, `daily_bounty`, `dispatch_work` (Bottom Dollar); `hacker_*` preps and finales for four jobs (Agents of Sabotage); `car_wash_work`, `_detailing`, `helitours_work`, `_tour`, `weed_shop_work`, `_delivery` (Money Fronts era).

So the newest arcs are mostly local scripts, while 2015 to 2022 story missions are mostly cloud jobs.

## 48.5 Cutscenes

289 distinct cutscene names appear as literals in the scripts, mostly story mode (**Verified**). The Online ones are property and arc intros: `MP_INTRO_CONCAT` (the Online intro), `IMPEXP_INT`, `HANG_INT`, `IAA_INT`, `IAAJ_INT`, `LOW_INT`, `MPCAS_INT`, `MPSUI_INT`, `HS3_ARC_INT`, `HS3_PLN_INT`, `HS3_PRP_CELB`, `HS4_CAS_INT`, `HS4_SUB_INT`, `HS4_SCP_KNCK`, `HS4_SCP_PUSH`, `TUN_MEET_INT`, `TUN_SHOP_INT`, `TUN_SHOP_EXT`, `FIX_AGY_INT1` to `3`, `FIX_ART_*`, `FIX_PROD_*`, `FIX_WEED_*`, `FIX_WRM_INT`, `XM4_YARD_INT`, `XM4_YARD_EXT`, `SUM24_OFFICE_INT`, `SUM24_BTW_CELL_EXT`, `XM24_FACTORY_INT`, `XM24_MFH_INT`, `XM25_MANSION_INTA` to `C`. Cutscenes inside cloud missions are named in the mission data (`cuts` and `mocap` sections, [R7.4](/file-formats/ugc-json.md)), not in the scripts.

## 48.6 Rebuilding an arc

For a story-mode or offline remake (never touch the live game):

| Piece | Available on disk? | Where |
| --- | --- | --- |
| The property's map and interior | Yes | The DLC pack's map data and IPLs ([R4.6](/docs/world/map-data.md), [R7.6](/docs/online/properties.md)) |
| The property intro cutscene | Yes | Named above; played with the cutscene natives ([R5.6](/docs/gameplay/missions/cutscenes-and-dialogue.md)) |
| The flow's texts and help | Yes | `global.gxt2` and the pack's `americandlc.rpf` |
| Phone calls | Yes (audio and subtitles) | The pack's dialogue files ([R9.2](/docs/audio/speech-and-dialogue.md)) |
| Local content jobs | Yes, but they need `freemode` | `fm_content_*` plus the `.ugc` content files |
| Cloud story missions | No | Recreate from play-throughs, using the creator format as a guide |

A mod rebuilds the flow itself (a small state machine on its own save), reuses the text labels and intro cutscenes by name, and writes each mission as a story-mode script ([missions cookbook](/modding/cookbook/missions.md)).

### 48.6.1 When each `fm_content_*` script arrived (second pass)

*Second pass, 2026-10-30.* The decompile repository adds each script in the commit for the build that first shipped it. Its history (178 commits up to build 3725) dates all 97 `fm_content_*` scripts. Commits and dates are **Verified** with `git log --diff-filter=A`; the update names are **Known**. Scripts in the first commit (September 2020) are older than the repository, so it only says they existed by then.

| Commit (date) | Update (**Known**) | Scripts (`fm_content_` dropped) |
| --- | --- | --- |
| Initial commit (2020-09-17) | Before late 2020 | `business_battles`, `drug_vehicle`, `movie_props` |
| 2020-12-15 | The Cayo Perico Heist | `golden_gun`, `island_dj`, `island_heist` |
| 2021-07-20 | Los Santos Tuners | `auto_shop_delivery`, `phantom_car`, `sightseeing`, `slasher`, `tuner_robbery`, `vehicle_list` |
| 2021-12-22 | The Contract | `payphone_hit`, `payphone_intro`, `security_contract`, `vip_contract_1` |
| 1.59-2612 (2022-04-26) | Next-gen patches | `hsw_setup`, `hsw_time_trial`, `mp_intro` |
| 1.61-2699 (2022-08-06) | The Criminal Enterprises | 17 scripts: `ammunation`, `bar_resupply`, `bike_shop_delivery`, `cargo`, `cerberus`, `club_management`, `club_odd_jobs`, `club_source`, `clubhouse_contracts`, `crime_scene`, `export_cargo`, `gunrunning`, `metal_detector`, `skydive`, `smuggler_plane`, `smuggler_trail`, `source_research` |
| 2022-12-13 | Los Santos Drug Wars | `acid_lab_sell`, `acid_lab_setup`, `acid_lab_source`, `bank_shootout`, `convoy`, `drug_lab_work`, `robbery`, `stash_house`, `taxi_driver`, `xmas_mugger` |
| 2944 (2023-06-13) | San Andreas Mercenaries | `armoured_truck`, `bicycle_time_trial`, `ghosthunt`, `possessed_animals`, `smuggler_ops`, `smuggler_resupply`, `smuggler_sell`, `test` |
| 1.68-3095 (2023-12-12) | The Chop Shop | `chop_shop_delivery`, `tow_truck_work`, `xmas_truck` and the nine `vehrob_*` scripts |
| 1.69-3258 (2024-06-25) | Bottom Dollar Bounties | `bounty_targets`, `daily_bounty`, `dispatch_work`, `pizza_delivery`, `ufo_abduction` |
| 1.70-3407 (2024-12-10) | Agents of Sabotage | `arms_trafficking`, `community_outreach`, `drone` and the eight `hacker_*` prep and finale scripts |
| 1.71-3570 (2025-06-17) | Money Fronts | `car_wash_detailing`, `car_wash_work`, `cutscene`, `helitours_tour`, `helitours_work`, `tycoon_odd_jobs`, `weed_shop_delivery`, `weed_shop_work` |
| 1.72-3717.0 (2025-12-10) | A Safehouse in the Hills (`mp2025_02`) | `firefighter`, `forklift_operator`, `getaway_driver`, `postal_worker`, `survival`, `survival_grouping`, `valentine_cheater` |

### 48.6.2 The `mp2025_02` story (leftovers pass)

**Verified** from the dump of every American text block (base, `update.rpf`, `update2.rpf` and every DLC pack, 645,160 entries), looked up by the `joaat` hash of each label; the summary is in our words. The pack's arc is **KnoWay Out**, started from a payphone in Alta (the text says it can be replayed from that payphone later). Its global text describes it as taking down KnoWay's surveillance grid around Los Santos with the help of Avi Schwartzman. KnoWay runs driverless taxis and offices across the city. The six mission dialogue blocks (`X25A1AU` to `X25A6AU`), read in samples, give this outline (*our reading*):

1. **Negative Press** (`X25A1AU`; named in a challenge that mentions the KnoWay taxi): spoil KnoWay's driverless-taxi publicity by wrecking its billboards and taxis.
2. `X25A2AU`: the player is sent the location of a data centre.
3. `X25A3AU`: block a tunnel so a train stops, and grab a guarded person from it (*our reading*: the mission called **Tunnel Vision**).
4. `X25A4AU`: go in as a garbage crew and bring back KnoWay's trash, to learn who KnoWay is targeting and whether the crew is on that list (*our reading*: **Trash Talking**).
5. `X25A5AU`: a fight with federal agents, after which the player has to reach a set of coordinates and get away by sea.
6. `X25A6AU` (the largest, 1,099 entries): an armed assault, with a caller asking the player to come home.

The other seven blocks (`X25AFAU`, `X25CBAU`, `X25DSAU`, `X25FBAU`, `X25MAAU`, `X25RBAU`, `X25VNAU`, 11 to 297 entries) were not read in this pass. The same pack's text has award steps for destroying 5, 10, 15 and 20 KnoWay taxis and a $250,000 reward for finishing every KnoWay Out mission as a crew member.

## 48.7 Open questions

| Question | Where it goes |
| --- | --- |
| Which stats each flow keys on, step by step | Partly answered in [48.3.1](#4831-where-each-flow-keeps-its-progress-leftovers-pass) (leftovers pass): the progress stat or packed bools of 18 flows, and `EXEC_FLW` step by step. Left: the other flows step by step, and six flows whose storage is further away |
| The text of the voice-only flows (`XM4V_FLW`, `S25R_FLW`, `SR2CH_FLW` ...) | Answered in [48.2.1](#4821-the-phone-call-flows-second-pass): 40 phone calls in six DLC dialogue blocks |
| Which update each `fm_content_*` script arrived in (compare decompile commits by build) | Answered in [48.6.1](#4861-when-each-fm_content_-script-arrived-second-pass) |
| The flows for After Hours, Doomsday and the 2015 heists (no flow label family found) | Partly answered in [48.2.2](#4822-after-hours-doomsday-and-the-2015-heists-leftovers-pass) (leftovers pass): they are phone-call blocks (`BATFMAU` 143 roots, `XMFMAUD` 64 roots) plus help families (`GOPS_*`, `GO_*_R`, `HEIST_*`), with the triggers and stats found. Left: the call subtitles (data) |
| The mp2025_02 update's name and story | Mostly answered: the name is A Safehouse in the Hills (second pass); the story, KnoWay Out, is summarised in [48.6.2](#4862-the-mp2025_02-story-leftovers-pass). Missions 2, 5 and 6 are not tied to their titles |
