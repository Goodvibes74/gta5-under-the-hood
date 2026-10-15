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
| `mp2025_02` | (mansions) | `MP252_*` music events | Mansion intro cutscenes `XM25_MANSION_INTA` to `C`; mansions The Tongva Estate, Richman Villa, The Vinewood Residence | |

Flows with text outside the main text files (`XM4V_FLW` 22, `S25R_FLW` 6, `SR2CH_FLW` 6, `X24O_FLW`, `S25M_FLW`, `SR2RN_FLW`) are *probably* phone conversations, whose lines live in the dialogue files ([R9.2](/docs/audio/speech-and-dialogue.md)).

## 48.3 How a flow works

Each flow is a function in `freemode`'s running state ([R7.1](/docs/online/07-freemode.md)), called every frame (**Verified** placement; **Known** behaviour):

1. It reads the player's stats: does the player own the property, which steps are done, which story mission was passed.
2. When a step's condition is met it sends one beat: a phone call, a text (`*_TXT`), an email (`TFLOW_MAIL`), a help message (`*_HLP`, `*_H`) or a ticker (`*_TCK`), and sets a stat so it doesn't repeat.
3. It places blips and context prompts for the next meeting (`XM22_TRIG_*` "Press ~INPUT_CONTEXT~ to play First Dose - Designated Driver"; `SALV23_CFR_PR0` "Press ~INPUT_CONTEXT~ to start The Cluckin' Bell Farm Raid").
4. After the finale it switches to replay texts (`HIF_REPLAY_*`, `CH_FLOW_TXT_8*`, `FIX_FLOW_HLP23`) with cooldowns from tunables.

The flows also advertise: `GR_FLOW_TXT_*` reminds the player of discounted vehicles, `AW_FLOW_*` announces unlocks, `SUM22_*` introduces each business's new staff.

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

## 48.7 Open questions

| Question | Where it goes |
| --- | --- |
| Which stats each flow keys on, step by step | Next pass, per flow function in `freemode` |
| The text of the voice-only flows (`XM4V_FLW`, `S25R_FLW`, `SR2CH_FLW` ...) | Dialogue files, R9.2 second pass |
| Which update each `fm_content_*` script arrived in (compare decompile commits by build) | Next pass, `git log` of the decompile |
| The flows for After Hours, Doomsday and the 2015 heists (no flow label family found) | Next pass |
| The mp2025_02 update's name and story | Next pass, its pack text |
