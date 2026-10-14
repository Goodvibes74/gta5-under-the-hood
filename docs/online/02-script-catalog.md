# Script catalog

All 1,143 compiled scripts in `update\update2.rpf\x64\levels\gta5\script\script_rel.rpf`, grouped by what they do. Names, sizes, native counts and strings are **Verified** from the files (`tools/ysc-dump.ps1`). The group a script is in comes from its name prefix and its strings, so a few scripts may sit in a neighbouring group.

## 2.1 Overview

| Group | Scripts | Bytecode | What it is |
| --- | --- | --- | --- |
| Core and Online framework | 55 | 30 MB | Boot, story-to-Online transition, `freemode`, job launcher, HUD, pause menus, stats and unlocks, Rockstar test scripts |
| Properties and interiors (`am_mp_`) | 70 | 134 MB | One script per property type: apartments and garages, bunker, hangar, nightclub, casino, auto shop, agency, mansion, yacht, submarine, salvage yard ... |
| Freemode ambient events (`am_`) | 71 | 23 MB | Free-roam events and activities: hold-ups, crate drops, King of the Castle, Hunt the Beast, taxis, darts, arm wrestling, cinematic flights |
| Freemode content missions (`fm_content_`) | 97 | 236 MB | The modern mission framework (2020 on): business sourcing and selling, acid lab, bounties, salvage yard, auto shop deliveries, Cayo Perico preps, daily jobs |
| Organisation work (`gb_`) | 70 | 141 MB | VIP and CEO work, MC club contracts, Casino work and the Casino heist script |
| Jobs and creators (`fm_`) | 23 | 61 MB | The UGC players and creators: mission controllers, races, deathmatches, survival, the content creator |
| Phone and computer apps (`app`) | 38 | 10 MB | Internet, job list, email, the business computers |
| Shops | 28 | 41 MB | Clothes, barber, tattoo, gun shop, mod shops (with property versions) |
| Seating and interior activities | 47 | 42 MB | Sitting, drinking and smoking in properties and clubs |
| Online support | 62 | 21 MB | Smaller helpers named after their DLC (`gpb_`, `tuner_`, `fixer_`, `casino_` ...) |
| Story mode, shared systems and test scripts | 582 | 111 MB | Story missions, strangers and freaks, minigames, shared controllers (cellphone, dialogue, respawn), debug and test scripts. Broken down script by script in [core guide 1](/docs/gameplay/missions/story-script-catalog.md) |

Bytecode is the uncompressed code size; it shows where Rockstar's effort went. Content missions, organisation work and properties are two thirds of all Online code.

## 2.2 The biggest scripts

| Script | Bytecode | Native calls | Role |
| --- | --- | --- | --- |
| `freemode` | 7.5 MB | 2,798 | The Online main script |
| `fm_mission_controller_2020` | 6.3 MB | 3,166 | Plays newer heists and missions from UGC files |
| `fm_mission_controller` | 6.1 MB | 3,029 | Plays classic jobs and heists from UGC files |
| `public_mission_controller` | 6.0 MB | 3,090 | Public (free-roam) missions |
| `fm_race_creator` | 5.2 MB | 2,235 | Race creator |
| `fmmc_launcher` | 4.4 MB | 2,134 | The job lobby ("corona") and job start |
| `am_mp_property_int` | 4.3 MB | 1,745 | Inside apartments and garages |
| `fm_deathmatch_controler` | 3.9 MB | 2,204 | Deathmatches |
| `gb_deathmatch` | 3.8 MB | 2,135 | Organisation deathmatch modes |
| `fm_race_controler` | 3.7 MB | 2,266 | Races |
| `am_mp_casino_nightclub` | 3.6 MB | 1,378 | Casino nightclub (Music Locker) |
| `am_mp_car_meet_property` | 3.4 MB | 1,428 | LS Car Meet |
| `am_mp_nightclub` | 3.4 MB | 1,498 | Nightclub |
| `am_pi_menu` | 3.2 MB | 1,383 | Interaction menu |
| `am_mp_mansion` | 3.2 MB | 1,426 | December 2025 mansions |
| `appinternet` | 2.9 MB | 1,300 | In-game internet |

Native calls is the size of the script's native table: how many different engine functions it uses.

## 2.3 Who references whom

Scripts start other scripts by name (`REQUEST_SCRIPT("name")`, then `START_NEW_SCRIPT`), so a script's strings show which scripts it can start or checks for. These are references, not proof of a launch. **Verified.**

- `main_persistent` references the property scripts and every `fm_content_*` mission: it is the hub that launches free-roam content.
- `maintransition` and `fmmc_launcher` reference the same large set, which is the list of scripts they clean up or check during transitions and job starts.
- `freemode` is referenced by about 100 scripts: every ambient event, organisation job, property and job controller checks that it is running.
- `main` (story mode) references `net_cloud_mission_loader`, so story mode can read UGC files too.

## 2.4 Full lists by group

Sorted by bytecode size, largest first.

### Core and Online framework (55 scripts)

`freemode` `fmmc_launcher` `main_persistent` `net_test_drive` `net_apartment_activity` `net_apartment_activity_light` `maintransition` `fmmc_playlist_controller` `pausemenu_multiplayer` `main` `startup_positioning` `ingamehud` `standard_global_reg` `net_cloud_mission_loader` `mp_menuped` `net_mansion_yoga` `mp_bed_high` `code_controller` `fm_maintain_transition_players` `freemode_init` `startup` `net_tunable_check` `mp_awards` `building_controller` `pausemenu_map` `mp_weapons` `freemode_clearglobals` `mp_prop_special_global_block` `mp_gameplay_menu` `pausemenu_sp_repeat` `stats_controller` `mp_unlocks` `mp_fm_registration` `mp_registration` `error_listener` `pausemenu_example` `pausemenu` `pausemenucareerhublaunch` `net_activity_creator_ui` `startup_install` `net_session_soaktest` `net_jacking_soaktest` `net_combat_soaktest` `net_bot_brain` `mp_player_damage_numbers` `fmmc_contentquicklauncher` `mp_prop_global_block` `startup_smoketest` `startup_locationtest` `net_freemode_debug_stat_2023` `net_freemode_debug_2023` `net_bot_simplebrain` `mp_skycam_stuck_wiggler` `mp_save_game_global_block` `freemode_creator` 

### Properties and interiors (am_mp_) (70 scripts)

`am_mp_property_int` `am_mp_casino_nightclub` `am_mp_car_meet_property` `am_mp_nightclub` `am_mp_auto_shop` `am_mp_mansion` `am_mp_fixer_hq` `am_mp_hangar` `am_mp_submarine` `am_mp_salvage_yard` `am_mp_music_studio` `am_mp_bail_office` `am_mp_hacker_den` `am_mp_defunct_base` `am_mp_juggalo_hideout` `am_mp_casino_apartment` `am_mp_car_meet_sandbox` `am_mp_casino` `am_mp_sb_weed_shop` `am_mp_arena_garage` `am_mp_warehouse` `am_mp_acid_lab` `am_mp_sb_car_wash` `am_mp_simeon_showroom` `am_mp_sb_heli_tours` `am_mp_bunker` `am_mp_arcade` `am_mp_multistorey_garage` `am_mp_biker_warehouse` `am_mp_business_hub` `am_mp_hacker_truck` `am_mp_armory_truck` `am_mp_smpl_interior_int` `am_mp_property_ext` `am_mp_armory_aircraft` `am_mp_mansion_garage` `am_mp_boardroom_seating` `am_mp_creator_trailer` `am_mp_yacht` `am_mp_smpl_interior_ext` `am_mp_shooting_range` `am_mp_arena_box` `am_mp_creator_aircraft` `am_mp_arc_cab_manager` `am_mp_ie_warehouse` `am_mp_mansion_driveway` `am_mp_field_hangar` `am_mp_casino_valet_garage` `am_mp_solomon_office` `am_mp_smoking_activity` `am_mp_island` `am_mp_peds` `am_mp_rc_vehicle` `am_mp_garage_control` `am_mp_vehicle_reward` `am_mp_arcade_love_meter` `am_mp_arcade_strength_test` `am_mp_arcade_claw_crane` `am_mp_rpa_menu` `am_mp_drone` `am_mp_orbital_cannon` `am_mp_arcade_peds` `am_mp_vehicle_weapon` `am_mp_hotwire` `am_mp_arcade_fortune_teller` `am_mp_carwash_launch` `am_mp_social_club_garage` `am_mp_vinewood_premium_modshop` `am_mp_vinewood_premium_garage` `am_mp_vehicle_organization_menu` 

### Freemode ambient events and activities (am_) (71 scripts)

`am_pi_menu` `am_casino_peds` `am_vehicle_spawn` `am_hunt_the_beast` `am_hot_target` `am_hot_property` `am_dead_drop` `am_pass_the_parcel` `am_criminal_damage` `am_heist_int` `am_rontrevor_cut` `am_darts` `am_armwrestling` `am_luxury_showroom` `am_simosa` `am_contact_requests` `am_penned_in` `am_hs4_nimb_lsa_isd_arrive` `am_lowrider_int` `am_darts_apartment` `am_armwrestling_apartment` `am_agency_suv` `am_mansion_limo` `am_casino_limo` `am_crate_drop` `am_hs4_nimb_lsa_isd_leave` `am_hi_plane_take_off_cinematic` `am_hs4_lsa_take_vel` `am_hs4_lsa_land_nimb_arrive` `am_lsia_take_off_cinematic` `am_hs4_lsa_land_vel` `am_hs4_isd_take_vel` `am_hs4_vel_lsa_isd` `am_hs4_nimb_isd_lsa_leave` `am_hi_plane_land_cinematic` `am_kill_list` `am_challenges` `am_hold_up` `am_king_of_the_castle` `am_mansion_luxury_car` `am_casino_luxury_car` `am_cp_collection` `am_heli_taxi` `am_launcher` `am_imp_exp` `am_gang_call` `am_taxi` `am_mission_launch` `am_npc_invites` `am_bru_box` `am_ferriswheel` `am_car_mod_tut` `am_rollercoaster` `am_lester_cut` `am_destroy_veh` `am_penthouse_peds` `am_distract_cops` `am_armybase` `am_plane_takedown` `am_doors` `am_arena_shp` `am_ammo_drop` `am_boat_taxi` `am_airstrike` `am_backup_heli` `am_joyrider` `am_prison` `am_prostitute` `am_island_backup_heli` `am_ga_pickups` `am_beach_washup_cinematic` 

### Freemode content missions (fm_content_) (97 scripts)

`fm_content_island_heist` `fm_content_vehrob_police` `fm_content_vehrob_casino_prize` `fm_content_tuner_robbery` `fm_content_vehrob_prep` `fm_content_survival` `fm_content_vehrob_cargo_ship` `fm_content_vip_contract_1` `fm_content_security_contract` `fm_content_vehrob_arena` `fm_content_smuggler_ops` `fm_content_vehrob_submarine` `fm_content_cargo` `fm_content_bounty_targets` `fm_content_business_battles` `fm_content_car_wash_work` `fm_content_dispatch_work` `fm_content_gunrunning` `fm_content_drug_lab_work` `fm_content_payphone_hit` `fm_content_hacker_whistle_prep` `fm_content_vehrob_task` `fm_content_hacker_zancudo_fin` `fm_content_hacker_house_finale` `fm_content_acid_lab_source` `fm_content_helitours_work` `fm_content_clubhouse_contracts` `fm_content_hacker_whistle_fin` `fm_content_hacker_cargo_finale` `fm_content_hacker_house_prep` `fm_content_hacker_zancudo_prep` `fm_content_firefighter` `fm_content_club_management` `fm_content_vehrob_disrupt` `fm_content_vehrob_scoping` `fm_content_acid_lab_sell` `fm_content_smuggler_sell` `fm_content_stash_house` `fm_content_forklift_operator` `fm_content_ufo_abduction` `fm_content_acid_lab_setup` `fm_content_island_dj` `fm_content_smuggler_resupply` `fm_content_weed_shop_work` `fm_content_weed_shop_delivery` `fm_content_arms_trafficking` `fm_content_hacker_cargo_prep` `fm_content_car_wash_detailing` `fm_content_sightseeing` `fm_content_tycoon_odd_jobs` `fm_content_club_source` `fm_content_chop_shop_delivery` `fm_content_export_cargo` `fm_content_daily_bounty` `fm_content_source_research` `fm_content_skydive` `fm_content_helitours_tour` `fm_content_tow_truck_work` `fm_content_auto_shop_delivery` `fm_content_taxi_driver` `fm_content_postal_worker` `fm_content_club_odd_jobs` `fm_content_bar_resupply` `fm_content_pizza_delivery` `fm_content_robbery` `fm_content_bicycle_time_trial` `fm_content_convoy` `fm_content_xmas_truck` `fm_content_ammunation` `fm_content_ghosthunt` `fm_content_cutscene` `fm_content_getaway_driver` `fm_content_bike_shop_delivery` `fm_content_bank_shootout` `fm_content_valentine_cheater` `fm_content_smuggler_trail` `fm_content_crime_scene` `fm_content_drug_vehicle` `fm_content_armoured_truck` `fm_content_cerberus` `fm_content_metal_detector` `fm_content_golden_gun` `fm_content_parachuter` `fm_content_smuggler_plane` `fm_content_vehicle_list` `fm_content_movie_props` `fm_content_survival_grouping` `fm_content_xmas_mugger` `fm_content_possessed_animals` `fm_content_phantom_car` `fm_content_slasher` `fm_content_community_outreach` `fm_content_drone` `fm_content_test` `fm_content_mp_intro` `fm_content_hsw_time_trial` `fm_content_hsw_setup` 

### Organisation work VIP CEO MC (gb_) (70 scripts)

`gb_deathmatch` `gb_casino_heist` `gb_casino` `gb_biker_contraband_defend` `gb_biker_bad_deal` `gb_illicit_goods_resupply` `gb_biker_rescue_contact` `gb_biker_safecracker` `gb_biker_last_respects` `gb_biker_rippin_it_up` `gb_biker_contract_killing` `gb_fragile_goods` `gb_biker_shuttle` `gb_fully_loaded` `gb_biker_unload_weapons` `gb_amphibious_assault` `gb_biker_steal_bikes` `gb_biker_burn_assets` `gb_carjacking` `gb_infiltration` `gb_biker_stand_your_ground` `gb_vehicle_export` `gb_data_hack` `gb_cashing_out` `gb_biker_free_prisoner` `gb_ploughed` `gb_biker_search_and_destroy` `gb_ramped_up` `gb_jewel_store_grab` `gb_salvage` `gb_security_van` `gb_fortified` `gb_transporter` `gb_biker_destroy_vans` `gb_stockpiling` `gb_target_pursuit` `gb_biker_driveby_assassin` `gb_velocity` `gb_biker_criminal_mischief` `gb_biker_wheelie_rider` `gb_collect_money` `gb_finderskeepers` `gb_biker_race_p2p` `gb_fivestar` `gb_point_to_point` `gb_rob_shop` `gb_delivery` `gb_contraband_buy` `gb_contraband_defend` `gb_ie_delivery_cutscene` `gb_gunrunning_delivery` `gb_gangops` `gb_gunrunning` `gb_smuggler` `gb_bank_job` `gb_contraband_sell` `gb_gunrunning_defend` `gb_biker_contraband_sell` `gb_yacht_rob` `gb_airfreight` `gb_assault` `gb_sightseer` `gb_headhunter` `gb_bellybeast` `gb_hunt_the_boss` `gb_biker_joust` `gb_terminate` `gb_casino_heist_planning` `gb_gang_ops_planning` `gb_biker_target_rival` 

### Jobs and creators (fm_) (23 scripts)

`fm_mission_controller_2020` `fm_mission_controller` `public_mission_controller` `fm_race_creator` `fm_deathmatch_controler` `fm_impromptu_dm_controler` `fm_race_controler` `fm_bj_race_controler` `fm_deathmatch_creator` `fm_survival_controller` `public_mission_creator` `fm_horde_controler` `fm_survival_creator` `fm_capture_creator` `fm_lts_creator` `fm_hideout_controler` `fm_maintain_cloud_header_data` `fm_intro` `fm_intro_cut_dev` `fm_street_dealer` `fm_hold_up_tut` `fm_main_menu` `fm_mission_creator` 

### Phone and computer apps (38 scripts)

`appinternet` `appmpjoblistnew` `appbusinesshub` `apparcadebusiness` `appsecuroserv` `appimportexport` `apphackerden` `appbunkerbusiness` `appbikerbusiness` `apphackertruck` `appcontacts` `appbailoffice` `appsmuggler` `appcamera` `appjipmp` `appfixersecurity` `apparcadebusinesshub` `appcovertops` `appavengeroperations` `appemail` `apptextmessage` `appmpemail` `appmpbossagency` `appsettings` `appchecklist` `apphs_sleep` `appmedia` `appbroadcast` `appsidetask` `apporganiser` `apptrackify` `appzit` `appvlsi` `appextraction` `appsecurohack` `appvinewoodmenu` `appprogresshub` `apprepeatplay` 

### Shops (28 scripts)

`shop_controller` `carmod_shop` `vinewood_premium_garage_carmod` `tuner_property_carmod` `personal_carmod_shop` `mansion_carmod` `juggalo_hideout_carmod` `hangar_carmod` `hacker_truck_carmod` `hacker_den_carmod` `fixer_hq_carmod` `car_meet_carmod` `business_hub_carmod` `base_carmod` `armory_aircraft_carmod` `arena_carmod` `clothes_shop_mp` `clothes_shop_sp` `hairdo_shop_mp` `gunclub_shop` `hairdo_shop_sp` `tattoo_shop` `shoprobberies` `re_shoprobbery` `player_scene_m_shopping` `auto_shop_seating` `sb_weed_shop_seating` `arena_workshop_seats` 

### Seating and interior activities (47 scripts)

`casino_interior_seating` `arcade_seating` `casino_main_lounge_seating` `fixer_hq_seating_pq` `fixer_hq_seating_op_floor` `juggalo_hideout_seating` `mansion_lobby_seating` `mansion_seating` `multistorey_garage_seating` `salvage_yard_seating` `base_lounge_seats` `fixer_hq_seating` `mansion_upper_floor_seating` `mansion_lower_basement_seating` `mansion_guest_bedroom_seating` `mansion_basement_seating` `mansion_water_seating` `mansion_upper_balcony_seating` `mansion_lower_east_wing_seating` `mansion_club_seating` `casino_exterior_seating` `music_studio_seating_external` `arena_box_bench_seats` `casino_bar_seating` `mansion_outside_seating` `casino_penthouse_seating` `music_studio_seating` `casino_nightclub_seating` `hacker_den_ext_seating` `multistorey_garage_ext_seating` `simeon_showroom_seating` `hacker_den_seating` `field_hangar_seating` `sb_heli_tours_seating` `bail_office_seating` `nightclub_vip_seats` `nightclub_ground_floor_seats` `nightclub_office_seats` `business_hub_garage_seats` `beach_exterior_seating` `car_meet_exterior_seating` `base_heist_seats` `base_reception_seats` `base_quaters_seats` `base_entrance_seats` `base_corridor_seats` `car_meet_interior_seating` 

### Online support (gpb_, tuner_, fixer_ ...) (62 scripts)

`business_battles_sell` `business_battles_defend` `tuner_sandbox_activity` `celebrations` `sctv` `business_battles` `creator` `player_timetable_scene` `player_controller_b` `player_controller` `mansion_club_bar` `heist_ctrl_docks` `player_scene_ft_franklin1` `player_scene_m_fbi2` `casino_lucky_wheel` `social_controller` `vehicle_gen_controller` `player_scene_m_kids` `heist_island_planning` `heist_ctrl_finale` `tuner_planning` `heist_ctrl_agency` `heist_ctrl_rural` `casino_slots` `heist_ctrl_jewel` `player_scene_f_taxi` `player_scene_f_lamtaunt` `player_scene_t_park` `cellphone_controller` `player_scene_f_lamgraff` `player_scene_t_bbfight` `player_scene_t_tie` `player_scene_t_insult` `player_scene_m_cinema` `player_scene_t_chasecar` `cellphone_flashhand` `player_scene_mf_traffic` `drunk` `dialogue_handler` `gpb_pameladrake` `gpb_baygor` `gpb_andymoon` `gpb_zombie` `gpb_superhero` `gpb_clinton` `gpb_tonya` `gpb_jesse` `gpb_griff` `gpb_jane` `gpb_billbinder` `gpb_mani` `gpb_mime` `gpb_jerome` `vehicle_stealth_mode` `context_controller` `drunk_controller` `ugc_global_registration_2` `celebration_editor` `vehicle_plate` `vehicle_force_widget` `vehicle_ai_test` `ugc_global_registration` 


### Story mode, shared systems and test scripts (582 scripts)

Broken down into 12 groups with one line per script in [core guide 1: script catalog, story mode and shared scripts](/docs/gameplay/missions/story-script-catalog.md) (584 entries there, counting the two Pilot School copies from `x64w.rpf`).
