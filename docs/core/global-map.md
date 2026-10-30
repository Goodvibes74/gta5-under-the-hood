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
| 13, 15 | none | 1, 1 | 23, 19 | Dead code: reached only behind two flags that no script ever sets (second pass, below) |
| 16 | `mp_prop_special_global_block` | 20 | 28,015 | Special properties |
| 17 | `title_update_registration_2` | 234 | 128,039 | Later title-update additions |
| 18, 19, 20 | `globals_fmmc_struct_registration`, `2`, `3` | 1 each | 264,829, 114,619, 11,380 | The mission (FMMC) structures, one huge structure each, used mostly by the creators and mission controllers |

**Blocks 13 and 15** (*second pass, 2026-10-25*, **Verified**). Every reference was listed with `git grep` (commit `6c18d3e8b`). They sit in five scripts: `dialogue_handler`, `emergencycalllauncher`, `main_persistent`, `pausemenu_sp_repeat` and `replay_controller`. They always come in pairs: the same code reads `Global_3407872` (block 13) when one flag is set (`Global_2883694` in this build) and `Global_3932160` (block 15) when another is (`Global_2883693`), and both point at large structures with the same field layout (fields such as `.f_964.f_539.f_4321`, a character model, and `.f_931.f_21`, a count the replay menu checks). No script registers either block, and the only writes to the two flags in the whole decompile set them to 0. So these paths never run in build 3725: they are leftovers of an older save layout that still compile into the scripts. A mod can ignore both blocks.

## 6.3 The most-used globals

| Global | Block | References | Scripts | Most used by | Role |
| --- | --- | --- | --- | --- | --- |
| `Global_262145` | 1 | 863,136 | 806 | `tuneables_processing`, `freemode`, `am_criminal_damage`, `clothes_shop_mp` | **Tunables**: server-set values and switches (**Verified**, [online guide 7](/docs/online/07-freemode.md)) |
| `Global_1950198` | 7 | 638,563 | 447 | `freemode`, the simple-interior scripts, `am_mp_mansion` | Local simple-interior state: entering and leaving interiors (**Verified**, below) |
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
| `Global_1892653` | 7 | 66,038 | 790 | `freemode`, `am_pi_menu`, `am_mp_property_int` | **Player broadcast data `GPBD_FM_3`**, 615 values per player (**Verified**, [6.3.1](#631-every-broadcast-block-by-its-registered-name-third-pass)) |
| `Global_80060` | 0 | 63,463 | 569 | The clothes shops, `wardrobe_mp` | Clothing (with `Global_80063`) (**Known**) |
| `Global_1583765` | 6 | 54,501 | 513 | `freemode`, property interiors, the mod shops | Personal vehicles (**Known**) |
| `Global_2097536` | 8 | 52,565 | 33 | `fmmc_launcher`, garages, `am_pi_menu` | Leaderboard rows read for display (**Verified**, below) |
| `Global_2686090` | 10 | 43,435 | 542 | `freemode`, the mission controllers, `fmmc_launcher` | Job transition state: the gamer handles of the players moving with the job (**Verified**, below) |
| `Global_2685150` | 10 | 33,302 | 618 | `fmmc_launcher`, mission controllers | Job lobby state (**Known**) |
| `Global_1679103` | 6 | 30,470 | 429 | `timershud`, the mission controllers | Mission HUD timers and counters (**Verified** for the take counter in [core guide 4](/docs/gameplay/weapons/weapons.md)) |
| `Global_2649159` | 10 | 10,601 | 348 | `freemode` | **Server broadcast data**; value 0 is freemode's host state (**Verified**) |

**Where the player broadcast data is used** (*second pass, 2026-10-25*, **Verified** counts, roles still open). Counting every `Global_2658291[player].f_<n>` and `Global_1845250[player].f_<n>` reference in the decompile shows how lopsided the two blocks are. In `Global_2658291` (468 values per player) scripts use 138 top-level fields, but one sub-structure, `.f_325`, takes 302,151 references, and inside it `.f_325.f_11` alone 101,492; next come `.f_204` (12,445) and `.f_203` (10,113), which scripts test and set bit by bit (`BitTest`, `SET_BIT`: per-player state flags), then `.f_276`, `.f_221`, `.f_76` and `.f_124`. In `Global_1845250` (880 values per player) 75 top-level fields are used; `.f_260` takes 154,902 references (its busiest parts are `.f_260.f_299`, `.f_397`, `.f_311`, `.f_543` and `.f_490`), then the bare entry (10,562), `.f_97` (5,527, a sub-structure with bit fields at `.f_97.f_32`), `.f_36`, `.f_808`, `.f_198` and `.f_879`. Field numbers change with every build; name a field by reading the natives next to its uses, starting with `.f_325.f_11` and `.f_260`.

**Roles of the busiest broadcast fields** (*second pass, 2026-10-30*; read in `freemode` and `am_mp_mansion` at commit `6c18d3e8b`):

| Field | Role | Evidence |
| --- | --- | --- |
| `Global_2658291[p].f_325` | **The interior the player is in** (the "simple interior" system: offices, bunkers, mansions, vehicles with an interior) | **Verified**: `.f_325.f_8` holds an interior ID, −1 for none, and one switch (`func_203` in `freemode`) maps it to an interior type |
| `Global_2658291[p].f_325.f_11` | **Owner of that interior**: a player index, −1 for none | **Verified**: compared with the invalid-player value −1, read through `INT_TO_PLAYERINDEX`, and set to the player's own ID when they drive into their own vehicle interior (`am_mp_mansion`). In `freemode` its writers are the player's own ID (44 times), the owner chosen in the local interior state (`Global_1950198.f_3891`, `.f_4272`; 42 times) and helpers |
| `Global_2658291[p].f_204`, `.f_203` | Per-player flag words | **Verified** as bit fields only (`BitTest`, `SET_BIT`, `CLEAR_BIT`), spread over about 30 bits each; the busiest bits in `freemode` are 19, 27 to 30 (`.f_204`) and 2, 28 (`.f_203`). Each bit is read through a one-line helper; naming them is per-bit work |
| `Global_1845250[p].f_260` | **The player's stat-backed state**: owned properties, unlocks, preferences, cooldowns ([online guide 7](/docs/online/07-freemode.md), step 9) | **Verified** that `freemode` fills several parts from value-reading helpers called with a number (`.f_364` with 7212, `.f_415` with 8252, `.f_496` with 31558; that these are packed-stat indexes is our reading) and that every part is read through small per-player accessors. The busiest parts in `freemode` are `.f_439`, `.f_39` (with `ADD_BLIP_FOR_COORD`: a location), `.f_311`, `.f_496` and `.f_364`; naming them needs the packed-stat list (R7.3) |
| `Global_1845250[p].f_97` | A small sub-structure with bit fields at `.f_97.f_28` and `.f_97.f_32` | **Verified** layout only. The job lobby's per-player state sits right before it at `.f_96` ([job lobby](/docs/online/job-lobby.md)) |

**Who sets each bit of `.f_204` and `.f_203`** (*third pass, 2026-10-31*, **Verified**: every `SET_BIT` and `CLEAR_BIT` on the two words, counted per script with `git grep` at commit `6c18d3e8b`). The bits fall into four groups by the scripts that write them, which says what they are about:

| Group | `.f_204` bits | `.f_203` bits | Written by |
| --- | --- | --- | --- |
| Shared header code | 6, 7, 10, 13, 14, 15, 19, 25 to 30 | 15, 18 to 21 | About 250 to 263 scripts each (every property, activity and job script carries the same helpers); bits 26, 28 and 30 sit next to vehicle fades and repositioning and `am_mp_car_meet_property` checks |
| Vehicle mod shops | 2 to 5, 9, 12, 16 to 18, 20 to 23 | 4, 9 to 14, 16, 17, 22 to 27 | The 15 or 16 `*_carmod` scripts and `carmod_shop` (with `am_mp_property_int`, `am_mp_arena_garage`, `am_vehicle_spawn`, `gb_gangops`, `gb_vehicle_export` or `am_mp_ie_warehouse` for single bits) |
| Jobs | | 3 (job controllers: races, deathmatches, missions), 29 (deathmatch modes and Hunt the Beast; the setter applies player health, melee and explosive damage modifiers) | `fm_*_controler`, `fm_mission_controller`, `gb_deathmatch`, `am_hunt_the_beast` |
| `freemode` alone | 8 (`am_mp_property_int` only) | 2, 5 to 8, 30, 31 (set next to tutorial-session and screen-fade checks), 28 (71 scripts: seats and menus, set next to the GTA Online logo texture, night vision and network receive restrictions) | `freemode` |

A bit's exact name needs its callers: most are written through one-line "set or clear bit N" helpers.

**The parts of `.f_260`, named** (*third pass*, **Verified**). `freemode` fills them through a helper that turns a stat number into the current character's stat (`_GET_STAT_HASH_FOR_CHARACTER_STAT` with type 0) and reads it. The numbers are indexes into `common\data\mpstatscharactermappingdata.xml` in `update.rpf`, whose comments name every entry (`<!-- 6551 - MP_STAT_NIGHTCLUB_OWNED -->`; 18,486 int stats, 527 bools, 225 floats and smaller lists for strings, dates, vectors and user IDs). That names 16 parts:

| Part | Stat | Part | Stat |
| --- | --- | --- | --- |
| `.f_156` | `OWNED_IE_WAREHOUSE` | `.f_415` | `CASINOAPT_OWNED` |
| `.f_297` | `RESEARCHTOTALFORFACTORY5` | `.f_439` | `ARCADE_OWNED` |
| `.f_304` | `HANGAR_OWNED` | `.f_496` | `AUTO_SHOP_OWNED` |
| `.f_311` | `DBASE_OWNED` (the facility) | `.f_504` | `SALVAGE_YARD_OWNED` |
| `.f_321` | `BUSINESSHUB_OWNED` | `.f_519` | `FIXER_HQ_OWNED` |
| `.f_364` | `NIGHTCLUB_OWNED` | `.f_524` | `MULTSTOREY_GAR_OWNED` |
| `.f_392` | `SU20PSTAT_INT193` | `.f_531` | `BAIL_OFFICE_OWNED` |
| `.f_394` | `BIKER_BAR_RESUPPLY_CASH` | `.f_543`, `.f_546` | `HACKER_DEN_OWNED`, `MCKENZIE_HANGAR_OWNED` |

So the busiest parts are which property of each kind the player owns (`.f_439` the arcade, `.f_311` the facility, `.f_543` the hacker den). Two more parts, `.f_395` and `.f_396`, come from packed stats (indexes 26,808 and 41,216), which the mapping file doesn't cover. The stat names are `MP_STAT_` plus the name above; the per-character stat is `MP0_` or `MP1_` plus the name.

### 6.3.1 Every broadcast block, by its registered name (third pass)

Each script that shares data over the network registers it with `NETWORK_REGISTER_PLAYER_BROADCAST_VARIABLES` (one copy per player, 32 players) or `NETWORK_REGISTER_HOST_BROADCAST_VARIABLES` (one copy, written by the host), and passes a **name**. `freemode` registers 33 global blocks this way (15 player, 18 host); the job controllers add four (**Verified**, every registration in the decompile; "scripts" and "references" counted with `git grep`):

| Global | Name | Kind | Values | Per player | Scripts | References |
| --- | --- | --- | ---: | ---: | ---: | ---: |
| `Global_1845250` | `GPBD_FM` | Player | 28,161 | 880 | 793 | 198,235 |
| `Global_2658291` | `GlobalplayerBD` | Player | 14,977 | 468 | 795 | 371,140 |
| `Global_1892653` | `GPBD_FM_3` | Player | 19,681 | 615 | 790 | 66,038 |
| `Global_1882572` | `GPBD_FM_2` | Player | 10,081 | 315 | 478 | 15,387 |
| `Global_1912395` | `GPBD_FM_4` | Player | 10,081 | 315 | 325 | 2,232 |
| `Global_1983167` | `GPBD_Flow` | Player | 4,769 | 149 | 327 | 7,189 |
| `Global_1927920` | `GPBD_SCTV` (spectator TV) | Player | 6,369 | 199 | 316 | 1,608 |
| `Global_1877158` | `GPBD_FM_HeistPlanning` | Player | 2,465 | 77 | 307 | 856 |
| `Global_1976315` | `GPBD_CasinoHeist` | Player | 2,177 | 68 | 293 | 1,498 |
| `Global_1980733` | `GPBD_HeistIsland` | Player | 1,697 | 53 | 125 | 1,064 |
| `Global_1979868` | `GPBD_NetHeistPlanningGeneric` | Player | 865 | 27 | 39 | 202 |
| `Global_1873924` | `GPBD_Kicking` (vote kicks) | Player | 3,201 | 100 | 5 | 31 |
| `Global_1873411` | `GPBD_MissionName` | Player | 513 | 16 | 28 | 56 |
| `Global_4514608` | `GPBD_Interactions` | Player | 673 | 21 | 73 | 251 |
| `Global_2700170` | `g_AMC_playerBD` | Player | 8,225 | 257 | 3 | 16 |
| `Global_2649159` | `GSBD` | Host | 1,264 | | 348 | 10,601 |
| `Global_2650423` | `GSBD_BlockB` | Host | 2,156 | | 261 | 5,369 |
| `Global_2652579` | `GSBD_BlockC` | Host | 2,711 | | 403 | 1,243 |
| `Global_1835511` | `GSBD_FM` | Host | 652 | | 281 | 1,152 |
| `Global_2625811` | `GSBD_MissionsShared` | Host | 2,757 | | 19 | 413 |
| `Global_2655290` | `GSBD_MissionRequest` | Host | 657 | | 19 | 350 |
| `Global_2655947` | `GSBD_MissionList` | Host | 210 | | 3 | 11 |
| `Global_2656382` | `GSBD_ActivitySelector` | Host | 922 | | 6 | 55 |
| `Global_2657304` | `GSBD_Betting` | Host | 581 | | 25 | 215 |
| `Global_2657885` | `GSBD_HoldUp` (store hold-ups) | Host | 171 | | 7 | 88 |
| `Global_2656157` | `GSBD_ExclusionAreas` | Host | 225 | | 4 | 51 |
| `Global_1922477`, `Global_2658056` | `GSBD_FM_events` (two blocks with the same name) | Host | 525, 235 | | 319, 299 | 1,232, 1,732 |
| `Global_1882120` | `GSBD_RandomEvents` | Host | 367 | | 27 | 141 |
| `Global_1943442` | `GSBD_PropertyInstances` | Host | 464 | | 4 | 22 |
| `Global_1935536` | `GSBD_HeistPlanning` | Host | 35 | | 5 | 249 |
| `Global_1877125` | `GSBD_Kicking` | Host | 33 | | 3 | 14 |
| `Global_4515281` | `GSBD_SyncedInteractions` | Host | 132 | | 3 | 93 |
| `Global_1926563` | `g_MissionControllerserverBD_LB` (job leaderboard) | Host | 1,350 | | 87 | 1,478 |
| `Global_1057198` | `g_sMC_serverBDEndJob` (end of job) | Host | 240 | | 11 | 412 |
| `Global_1689064` | `GlobalServerBD_DM` | Host | 27 | | 255 | 689 |
| `Global_4456449` | `GlobalServerBD_Races` | Host | 35 | | 95 | 677 |

"Per player" is (values − 1) / 32: the first value is the array length. The last four host blocks are registered by the job controllers (deathmatch, race, mission and survival controllers, `public_mission_controller`), not `freemode`.

**The busiest server fields** (read in `freemode`, **Verified** by the natives on the lines that use them): `GSBD.f_2` is a table of networked **entity areas** (`NETWORK_ADD_ENTITY_AREA`, `NETWORK_ENTITY_AREA_IS_OCCUPIED`, 4 values a slot); `GSBD.f_461` holds positions with a radius tested with `VDIST` (11 groups of 5); `GSBD.f_904` mirrors a value from each player's `GlobalplayerBD.f_358`; `GSBD.f_818` is a set of per-player bit flags and slots; `GSBD_BlockB.f_199` is a list of 15-value entries with a cloud-time stamp and a script host check (140 references, the busiest server field); `GSBD_BlockC.f_97` is a per-player table of 33 values timed with `GET_NETWORK_TIME`; `GSBD_BlockC.f_2613` holds networked vehicle IDs (`NET_TO_VEH`); `GSBD_FM.f_410` drives a host-created pickup (`CREATE_PICKUP_ROTATE` with `pickup_custom_script`, a random seed at `.f_197`); `GSBD_FM.f_183` and `.f_269` are per-player bit flags.

**The Known rows, one use each** (*second pass, 2026-10-30*). For each global, the natives and strings on the lines that use it were counted in its top script (`git grep` at commit `6c18d3e8b`, the always-present `PLAYER_ID`, `SET_BIT` and `CLEAR_BIT` left out):

| Global | Counted in | What sits next to it | Role now |
| --- | --- | --- | --- |
| `Global_1950198` | `freemode`, `am_mp_mansion` | Bit flags at `.f_751` (bit 31 set when the player drives into their own interior), the interior owner to enter (`.f_3891`, `.f_4272`, read through `INT_TO_PLAYERINDEX`), synchronized scenes | **Local simple-interior state**: entering and leaving interiors (**Verified** for the fields named) |
| `Global_2635562` | `freemode` | `GET_NETWORK_TIME` (122), `GET_TIME_DIFFERENCE` (64), `GET_ID_OF_THIS_THREAD` (30), networked vehicles; `.f_491` holds an activity-type override with its script thread (read in the shared activity-type helper, [boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass)) | Freemode's activity timers and launched-activity state (**Known**, consistent) |
| `Global_24529` | `fm_race_creator` | `GET_HASH_KEY`, `ARE_STRINGS_EQUAL` (44 each), text components, scaleform methods | Creator menu and text state (**Known**, consistent) |
| `Global_80063`, `Global_80060` | `clothes_shop_mp` | `SET_PED_COMPONENT_VARIATION`, `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG`, `GET_PED_PALETTE_VARIATION`, the `multi_decal` tag (`Global_80063`); `Global_80060` only through helpers | Clothing shop item data (**Known**, consistent) |
| `Global_2733002` | `am_pi_menu` | `DOES_ENTITY_EXIST` (54), `NETWORK_IS_ACTIVITY_SESSION` (21), vehicle checks | Interaction-menu local state, including the player's vehicles (**Known**, consistent) |
| `Global_1892653` | `freemode` (registration) | `NETWORK_REGISTER_PLAYER_BROADCAST_VARIABLES(&Global_1892653, 19681, "GPBD_FM_3")` | **Verified**: the third of freemode's player broadcast blocks, 615 values per player; its busiest sub-structure is `.f_10` (`.f_10.f_77.f_3` alone has 291 references in `freemode`) |
| `Global_1583765` | `freemode` | Vehicle model names (`oppressor2`, `thruster`, `speedo4`), `IS_THIS_MODEL_A_BIKE`, radio station | Personal vehicles (**Known**, consistent) |
| `Global_2097536` | `am_pi_menu`, `fmmc_launcher` | `LEADERBOARDS2_READ_GET_ROW_DATA_INT` and `_FLOAT` write into it; column labels `SCLB_C_RANK`, `SCLB_C_KILLS`, `SCLB_C_TIME`; one entry of 901 values per board holding rows of 75 values, a row count per board at `.f_2704` | **Leaderboard rows read for display** (**Verified**; the board IDs are in [server-backed screens 25.7](/docs/ui/server-backed-screens.md)) |
| `Global_2686090` | `fmmc_launcher` | `NETWORK_ARE_HANDLES_THE_SAME` (21), `NETWORK_IS_HANDLE_VALID`, `NETWORK_GET_PLAYER_FROM_GAMER_HANDLE`, `NETWORK_HAS_PLAYER_STARTED_TRANSITION` | Job transition state: the gamer handles of the players moving with the job (**Verified** that it holds and compares gamer handles) |
| `Global_2685150` | `fmmc_launcher` | Entities set as mission entities, `REGISTER_ENTITY_FOR_CUTSCENE`, `SET_CAM_COORD`, world offsets | Job lobby (corona) scene state: its camera and the peds and vehicles shown (**Known**, consistent) |

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

Answered in the second pass: what the references into blocks 13 and 15 are (dead code, [6.2](#62-the-blocks-with-how-much-they-are-used)).

| Question | Where it goes |
| --- | --- |
| Field layout of the player broadcast data (`Global_1845250`, `Global_2658291`) | Mostly answered in [6.3](#63-the-most-used-globals): `.f_325` named, 16 parts of `.f_260` named from the stat mapping file, every bit of `.f_204` and `.f_203` grouped by who writes it; single-bit names left (they need each helper's callers) |
| The fields of the server broadcast data | Answered at block level in [6.3.1](#631-every-broadcast-block-by-its-registered-name-third-pass): all 37 blocks named, the busiest server fields typed |
| The tunable index list: which `Global_262145.f_<n>` is which tunable | Answered in [R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass): every assignment in `tuneables_processing` gives field, type, name and default (27,691 with plain names) |
| Roles of the **Known** rows above, by reading one use each | Answered in [6.3](#63-the-most-used-globals): `Global_1950198`, `Global_2097536`, `Global_2686090` and `Global_1892653` (`GPBD_FM_3`) now **Verified**, the rest checked as consistent |
