# The global variable map

Where the game's scripts keep shared state: the global blocks, which script owns each, how heavily each block and each big global is used, and what the most important globals hold, so that decompiled code reading `Global_2658291[player].f_...` can be understood at a glance. Roadmap topic **R0.4** in the [roadmap](/ROADMAP.md). Extends the block table in [guide 1, section 1.5](/docs/core/runtime-scripts.md#15-global-blocks).

**How it was made.** Every `Global_<n>` reference in the build-3725 decompile (1,145 scripts) was counted with one `git grep -o -E "Global_[0-9]+" <commit> -- decompiled_scripts` piped into `awk` (about 30 seconds): 5,151 distinct global bases, with reference counts per base and per script. A global's block is its index divided by 262,144. Roles come from the scripts that use each global most and from the earlier guides that decoded some of them. Counts and owners are **Verified**; a role is **Verified** where an earlier guide traced it and otherwise our reading (marked **Known**).

**Important:** global indices are decompiler numbers and **change with every game build** (an update inserts globals and shifts everything after). This map is for reading the build-3725 decompile. Mods must not hard-code them ([rule R11.5](/ROADMAP.md)).

## 6.1 Short version

- **Globals live in 21 blocks of 262,144 slots.** Each block is created by one registration script; the busiest are block 7 (freemode state, 1.5 million references), block 10 (title-update additions, 1.5 million), block 0 (story and shared state, 1.1 million) and block 1 (tunables, 0.9 million, almost all through one global).
- **A handful of globals carry most of the game.** The top ten are referenced 3.5 million times between them: the tunables (`Global_262145`, read by 806 scripts), Online player and session state in blocks 7 and 10, the mission-creator structures in blocks 18 and 19, and the story save (`Global_114904`, read by 861 scripts).
- **Story mode keeps everything in block 0:** the story save, the mission table, the flow program, the running-mission list, replay and checkpoint state, the dialogue request, shop data.
- **Online splits its state by owner:** per-player broadcast data (synced between players), server broadcast data (synced from the host), local session state, the Online save (block 9), properties (blocks 5 and 16).

## 6.2 The blocks, with how much they are used

| Block | Owner script | Distinct globals used | References | What it holds |
| --- | --- | --- | --- | --- |
| 0 | `standard_global_init` | 1,277 | 1,141,755 | Story mode and shared state (6.4) |
| 1 | `tunables_registration` | 6 | 886,297 | Tunables: almost all of it is `Global_262145` |
| 2 | `profiler_registration` | 0 | 0 | Profiler; never read by any script (debug) |
| 3, 4 | `ugc_global_registration`, `_2` | 14, 45 | 14,180, 13,328 | Mission-creator (UGC) data |
| 5 | `mp_prop_global_block` | 21 | 20,401 | Online properties |
| 6 | `mp_registration` | 815 | 282,294 | Online core state |
| 7 | `mp_fm_registration` | 1,546 | 1,505,899 | Freemode state, player broadcast data |
| 8 | `sc_lb_global_block` | 22 | 61,226 | Social Club leaderboards |
| 9 | `mp_save_game_global_block` | 1 | 13,557 | The Online save (`Global_2359296`, one structure) |
| 10 | `title_update_registration` | 1,134 | 1,510,605 | Title-update additions: much of today's Online lives here |
| 11 | `sp_dlc_registration` | 10 | 31,711 | Story-mode DLC data |
| 12 | `sp_pilotschool_reg` | 1 | 2 | Pilot School flag |
| 13, 15 | none | 1, 1 | 23, 19 | No owner in the headers, yet a few references (to check: decompiler artefacts or unused code) |
| 16 | `mp_prop_special_global_block` | 20 | 28,015 | Special properties |
| 17 | `title_update_registration_2` | 234 | 128,039 | Later title-update additions |
| 18, 19, 20 | `globals_fmmc_struct_registration`, `2`, `3` | 1 each | 264,829, 114,619, 11,380 | The mission (FMMC) structures, one huge structure each, used mostly by the creators and mission controllers |

## 6.3 The most-used globals

| Global | Block | References | Scripts | Most used by | Role |
| --- | --- | --- | --- | --- | --- |
| `Global_262145` | 1 | 863,136 | 806 | `tuneables_processing`, `freemode`, `am_criminal_damage`, `clothes_shop_mp` | **Tunables**: server-set values and switches (**Verified**, [online guide 7](/docs/online/07-freemode.md)) |
| `Global_1950198` | 7 | 638,563 | 447 | `freemode`, the simple-interior scripts, `am_mp_mansion` | Freemode and interior state (**Known**) |
| `Global_2635562` | 10 | 504,993 | 494 | `freemode`, `public_mission_controller`, the deathmatch controllers | Job and mission session state (**Known**) |
| `Global_2658291` | 10 | 371,140 | 795 | `freemode`, `am_vehicle_spawn`, `fm_mission_controller` | **Player broadcast data**, 468 values per player; value 0 is freemode's player state (**Verified**) |
| `Global_4718592` | 18 | 264,829 | 681 | The creators (`fm_race_creator` ...) | **The FMMC mission structure** (the loaded job) |
| `Global_114904` | 0 | 214,629 | 861 | `main`, story missions, `player_controller` | **The story save** (38,592 values; flow state at `.f_9092`) (**Verified**, [core guide 2](/docs/gameplay/missions/story-flow.md)) |
| `Global_1845250` | 7 | 198,235 | 793 | `freemode`, `appinternet`, `fmmc_launcher` | **Player broadcast data**, 880 values per player (properties, vehicles, status) (**Verified**) |
| `Global_24529` | 0 | 193,000 | 563 | The creators | Creator state (**Known**) |
| `Global_80063` | 0 | 180,206 | 569 | `clothes_shop_mp`, `hairdo_shop_mp`, `maintransition`, `wardrobe_mp` | Character appearance and clothing data (**Known**) |
| `Global_2673271` | 10 | 174,111 | 690 | `freemode`, the simple interiors | Local session state, including "am I host" (**Verified**) |
| `Global_4980736` | 19 | 114,619 | 262 | The creators | Second FMMC structure |
| `Global_2733002` | 10 | 104,424 | 767 | `freemode`, `am_pi_menu` | Freemode local state, interaction menu (**Known**) |
| `Global_1892653` | 7 | 66,038 | 790 | `freemode`, `am_pi_menu`, `am_mp_property_int` | Player Online state (**Known**) |
| `Global_80060` | 0 | 63,463 | 569 | The clothes shops, `wardrobe_mp` | Clothing (with `Global_80063`) (**Known**) |
| `Global_1583765` | 6 | 54,501 | 513 | `freemode`, property interiors, the mod shops | Personal vehicles (**Known**) |
| `Global_2097536` | 8 | 52,565 | 33 | `fmmc_launcher`, garages, `am_pi_menu` | Leaderboard and vehicle-list data (**Known**) |
| `Global_2686090` | 10 | 43,435 | 542 | `freemode`, the mission controllers, `fmmc_launcher` | Job transition state (**Known**) |
| `Global_2685150` | 10 | 33,302 | 618 | `fmmc_launcher`, mission controllers | Job lobby state (**Known**) |
| `Global_1679103` | 6 | 30,470 | 429 | `timershud`, the mission controllers | Mission HUD timers and counters (**Verified** for the take counter in [core guide 4](/docs/gameplay/weapons/weapons.md)) |
| `Global_2649159` | 10 | 10,601 | 348 | `freemode` | **Server broadcast data**; value 0 is freemode's host state (**Verified**) |

## 6.4 Story mode's globals (block 0), traced in earlier guides

| Global | References | Scripts | What it is | Guide |
| --- | --- | --- | --- | --- |
| `Global_114904` | 214,629 | 861 | Story save (flow at `.f_9092`, mission completion at `.f_9092.f_330`) | [core 2](/docs/gameplay/missions/story-flow.md) |
| `Global_93192` | 3,351 | 359 | Story mission table (94 missions, 34 values each) | [core 2](/docs/gameplay/missions/story-flow.md) |
| `Global_80551` | 2,250 | 424 | The flow program (1,882 commands, rebuilt every boot) | [core 2](/docs/gameplay/missions/story-flow.md) |
| `Global_93156` | 1,318 | 146 | Running-mission list (7 slots; bit 4 passed, bit 5 failed) | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_80529` | 1,606 | 666 | Mission-passed signal for the flow | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_102429` | 8,479 | 271 | Replay controller state (retry, restart, skip) | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_102466` | 1,490 | 189 | Current mission checkpoint | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_108447` | 4,314 | 176 | Player snapshot at the last checkpoint | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_96580`, `Global_96581` | 294, 348 | 78, 161 | Skip offered, skip chosen | [core 3](/docs/gameplay/missions/mission-anatomy.md) |
| `Global_22983`, `Global_22602`, `Global_21591` | 6,241, 2,689, 4,006 | 828, 476, 187 | Dialogue request and state for `dialogue_handler` | [core 6](/docs/gameplay/missions/cutscenes-and-dialogue.md) |
| `Global_21610` | 25,881 | 877 | Phone state (top users: `appcontacts`, `cellphone_flashhand`, `cellphone_controller`) (**Known**) | |
| `Global_102481` | 15,195 | 704 | Shop data (`shop_controller`'s table, mod-shop state) | [core 7](/docs/online/story-systems-in-online-mode.md) |
| `Global_102154` | 1,905 | 179 | The three characters' current outfits | [core 3](/docs/gameplay/missions/mission-anatomy.md) |

## 6.5 How to use this

- **Reading the decompile:** when a script touches `Global_2658291[iVar0 /*468*/].f_...`, it is reading player `iVar0`'s broadcast data; `Global_262145.f_<n>` is tunable number `n`; anything at `Global_114904.f_...` is in the story save.
- **Finding a global's role yourself:** list which scripts use it most (the per-script counts this guide was built from), then read one use in the smallest of those scripts.
- **After a game update:** the block owners and sizes come from the script headers (`tools/ysc-dump.ps1`), and the top globals can be found again by usage pattern (the same scripts, the same counts), not by number.

## 6.6 What this means for modders

- **Read, never write.** A global is shared memory that dozens or hundreds of Rockstar scripts read; writing one from a mod can break systems far from what the mod does. Reading story progress (mission completed, flow flags) is safe and is how a mod should check story state ([core guide 2](/docs/gameplay/missions/story-flow.md#28-what-this-means-for-modders)).
- **Never hard-code an index.** Every number in this guide moves with the next game build. A mod that needs a global value should find it by a native where one exists (stats, `GET_MISSION_FLAG`, `IS_CUTSCENE_ACTIVE`), and otherwise document the pattern it relies on so it can be found again (R11.2).
- **For an offline Online:** the player and server broadcast data are where `freemode` keeps everything other scripts need to know about a player; an offline rebuild keeps the same information in its own state, not in these globals.

## 6.7 Open questions

| Question | Where it goes |
| --- | --- |
| Field layout of the player broadcast data (`Global_1845250`, `Global_2658291`) | R7.1 second pass |
| The tunable index list: which `Global_262145.f_<n>` is which tunable | R7.3 |
| What the references into blocks 13 and 15 are | Second pass |
| Roles of the **Known** rows above, by reading one use each | Second pass |
