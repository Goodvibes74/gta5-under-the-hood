# Graph Report - gta5-under-the-hood  (2026-11-03)

## Corpus Check
- 2 files · ~455,251 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2552 nodes · 5377 edges · 133 communities (125 shown, 8 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 432 edges (avg confidence: 0.82)
- Token cost: 223,711 input · 0 output

## Community Hubs (Navigation)
- Repo Overview and Guides
- Modding Start Guide
- PED and PLAYER Natives
- Population and Traffic
- Mod Map and Data Atlas
- Vehicle and World Physics
- Performance and Measuring
- Skills, Stats and Flying
- Menus, Text, HUD
- Boot Scripts (initial, main)
- Example Mods (C#)
- Roadmap and Contributing
- Audio, Speech, Radio
- Phase 4 Story Batches
- Online DLC Storylines
- Server-backed Online Screens
- NETWORK Natives
- Minigames and Activities
- Online Broadcast Blocks
- Story Flow and Strangers
- Replay and Director Mode
- MainTransition and Creator
- Cutscenes and Dialogue
- Story Flow and Strangers (2)
- Script Launch Graph
- Story Mission Anatomy
- VEHICLE Natives
- Saves, Autosave, Completion
- Native Namespace Index
- Transitions and Sessions
- MONEY and Shop Natives
- Respawn, Death, Arrest
- Global Variable Map
- TASK Natives
- Open Questions Tracker
- Stats and Tunables
- Saves, Autosave, Completion (2)
- Script Catalogs
- Skills, Stats and Flying (2)
- Rockstar Creator Internals
- Online Heists
- Time, Weather, MISC Natives
- Population and Traffic (2)
- Online Properties
- Runtime Scripts and Mission Type
- Job Lobby
- File-rules Workflow Steps
- Global Variable Map (2)
- Online Cosmetic Shops
- Script VM and Natives
- Handoff and AI Instructions
- Open Questions Tracker (2)
- WEAPON and ZONE Natives
- Controls and Camera
- Organisations and Businesses
- Decompile and Game Version
- Archives, Streaming, Memory
- HUD, DATAFILE, APPS Natives
- Handoff and AI Instructions (2)
- Archives, Streaming, Memory (2)
- Data Needs Checklist
- AI Layers and Glossary
- Setup and Requirements
- Persistent Controller Scripts
- Character Switching
- How GTA Online Works
- Freemode and Sessions
- Menus with LemonUI
- DLC and Metadata Natives
- GRAPHICS and INTERIOR Natives
- Toolbox and Repo Tools
- Saves, Autosave, Completion (3)
- Repo Overview and Guides (2)
- Phone and Interaction Menu
- Brain Sets and Clashes
- Phase 1 UI Batches
- Camera, Audio, Cutscene Natives
- Toolbox and Repo Tools (2)
- Camera, Audio, Cutscene Natives (2)
- ENTITY and DECORATOR Natives
- Script VM and Natives (2)
- Random Events and IPLs
- Working Method and Stocks
- Time, Weather, MISC Natives (2)
- Stock Company Names
- Setup and Requirements (2)
- Leaderboards and Online Globals
- Appearance and Clothing
- Global Blocks and Owners
- FIRE and EVENT Natives
- Online DLC Storylines (2)
- Business Computer Apps
- Simple Interior System
- Working Method and Stocks (2)
- File Rules
- Setup and Requirements (3)
- Setup and Requirements (4)
- STREAMING Natives
- Toolbox and Repo Tools (3)
- Server Broadcast Fields
- Property Table and Vehicles
- Issue Template Config
- OBJECT Natives
- PATH Natives
- PHYSICS Natives
- SCRIPT Natives
- Repo Overview and Guides (3)
- Key Codes and Controls
- PAD Natives
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- Toolbox and Repo Tools (4)
- Task Sequences
- Toolbox and Repo Tools (5)
- Global Variable Map (3)
- Population and Traffic (3)
- Population and Traffic (4)
- ITEMSETS Natives
- LOCALIZATION Natives
- REPLAY Natives
- SECURITY Natives
- SHAPETEST Natives
- Inbox Template
- Story Flow and Strangers (3)
- SAVEMIGRATION Natives
- Unknown Natives
- Call-graph Labeller

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 115 edges
2. `Mod map: what to read for the mod you want to make` - 114 edges
3. `Tools` - 79 edges
4. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
5. `The global variable map (R0.4)` - 66 edges
6. `The story mission flow: how missions unlock` - 63 edges
7. `Native namespace map` - 60 edges
8. `Native usage index` - 56 edges
9. `Anatomy of a story mission (R5.2)` - 56 edges
10. `Native usage guide (R0.3)` - 52 edges

## Surprising Connections (you probably didn't know these)
- `Story mission table (Global_93192, 94 entries, 92 scripts)` --semantically_similar_to--> `Story mission table (94 missions, Global_93192)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/gameplay/missions/story-flow.md
- `Script brains: 99 world-point and 47 object brains` --semantically_similar_to--> `Script brains`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/gameplay/missions/strangers-and-freaks.md
- `Strangers-and-freaks table (63 entries, 16 follow-up scripts)` --semantically_similar_to--> `Strangers-and-freaks table (63 entries, 18 strands)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/gameplay/missions/strangers-and-freaks.md
- `270-entry activity table (fmmc_launcher and 265 scripts)` --semantically_similar_to--> `Activity table (270 activities to 260 scripts, in 266 scripts)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/online/job-lobby.md
- `flow_controller (story missions by hash, mission_stat_watcher)` --semantically_similar_to--> `flow_controller`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/core/runtime-scripts.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **freemode's player broadcast data blocks** — docs_core_global_map_global_1845250, docs_core_global_map_global_2658291, docs_core_global_map_global_1892653, docs_core_global_map_global_1882572, docs_core_global_map_network_register_broadcast [EXTRACTED 1.00]
- **Activity launch flow (unlock bit, launcher, candidate slot, telemetry)** — docs_gameplay_missions_minigames_and_activities_activity_unlock_bits, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_minigames_and_activities_mission_candidate, docs_gameplay_missions_minigames_and_activities_force_cleanup_8, docs_gameplay_missions_minigames_and_activities_playstats_oddjob_done [EXTRACTED 1.00]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Three scripts that force strand 27 active for a new game** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Character switch pipeline** — docs_gameplay_player_character_switching_selector, docs_gameplay_player_character_switching_player_controller_b, docs_gameplay_player_character_switching_player_timetable_scene, docs_gameplay_player_character_switching_player_scene_scripts, docs_gameplay_player_character_switching_start_player_switch, docs_gameplay_player_character_switching_change_player_ped [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Cosmetic shop scripts launched by shop_controller** — docs_gameplay_player_online_cosmetic_shops_shop_controller, docs_gameplay_player_online_cosmetic_shops_hairdo_shop_mp, docs_online_stats_and_tunables_clothes_shop_mp, docs_gameplay_player_online_cosmetic_shops_tattoo_shop, docs_gameplay_player_online_cosmetic_shops_cosmetic_stats [EXTRACTED 1.00]
- **Creator prop pipeline: catalogue, save columns, upload, race rebuild** — docs_online_creator_internals_prop_catalogue, docs_online_creator_internals_column_save_format, docs_online_creator_internals_ugc_upload, docs_online_creator_internals_race_prop_rebuild [EXTRACTED 1.00]
- **Creator slider to saved stat pipeline** — docs_gameplay_player_online_character_creator_micro_morph_map, docs_gameplay_player_online_character_creator_heritage, docs_gameplay_player_online_character_creator_slider_to_stat, docs_gameplay_player_online_character_creator_mpstatssetup [EXTRACTED 1.00]
- **Scripted conversation request pipeline** — docs_gameplay_missions_cutscenes_and_dialogue_dialogue_request_globals, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler_states, docs_gameplay_missions_cutscenes_and_dialogue_conversation_root_labels, docs_gameplay_missions_cutscenes_and_dialogue_create_new_scripted_conversation [EXTRACTED 1.00]
- **Boot chain: startup to main_persistent** — docs_core_runtime_scripts_startup, docs_core_runtime_scripts_registration_scripts, docs_core_runtime_scripts_standard_global_init, docs_core_runtime_scripts_standard_global_reg, docs_core_runtime_scripts_main_persistent [EXTRACTED 1.00]
- **Story to Online handover** — docs_core_runtime_scripts_selector, docs_core_runtime_scripts_maintransition, docs_core_runtime_scripts_force_cleanup_bits, docs_core_runtime_scripts_freemode, docs_core_runtime_scripts_network_safe_flag [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Research inputs to gather for remaining questions** — handoff_decompile_commit_6c18d3e8, handoff_codewalker_rpf_cw, handoff_gxt2_text_files, handoff_game_executable_re, handoff_in_game_test_cards, modding_02_tools_you_need_nativedb [EXTRACTED 1.00]
- **Token-saving decompile working method** — handoff_python_tracing_helpers, handoff_joaat_hashing, handoff_vector_argument_counting, handoff_flow_initial_strand_builders, handoff_code_controller_unlock_chains [EXTRACTED 1.00]
- **Heist planning scripts per generation** — docs_online_heists_fmmc_launcher, docs_online_heists_gb_gang_ops_planning, docs_online_heists_gb_casino_heist_planning, docs_online_heists_heist_island_planning [EXTRACTED 1.00]
- **Job launch flow from lobby to running controller** — docs_online_job_lobby_fmmc_launcher, docs_online_job_lobby_lobby_state_flags, docs_online_job_lobby_activity_table, docs_online_job_lobby_mission_controller_selection, docs_online_job_lobby_start_argument_block, docs_online_job_lobby_job_controllers, docs_online_job_lobby_net_cloud_mission_loader [EXTRACTED 1.00]
- **Mission fail, retry and checkpoint restore flow** — docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_running_mission_list, docs_gameplay_missions_mission_anatomy_replay_controller, docs_gameplay_missions_mission_anatomy_retry_screen_states, docs_gameplay_missions_mission_anatomy_player_snapshot, docs_gameplay_missions_mission_anatomy_checkpoint_recording [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **freemode player state, host state and per-frame running systems** — docs_online_07_freemode_player_state_machine, docs_online_07_freemode_host_state_machine, docs_online_07_freemode_running_state_systems [EXTRACTED 1.00]
- **Force-cleanup bit questions across guides** — open_questions_core_017, open_questions_core_032, open_questions_on_060, open_questions_scr_011, open_questions_force_cleanup_bits [EXTRACTED 1.00]
- **Second-pass priority phases** — open_questions_phase_1, open_questions_phase_2, open_questions_phase_3, open_questions_phase_4, open_questions_priority_order [EXTRACTED 1.00]
- **Ped reaction data chain (personality, decision maker, combat info, relationship group)** — docs_ai_decisions_and_personalities_ped_ai_chain, docs_ai_combat_and_perception_events_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_relationships_and_groups_default_groups [EXTRACTED 1.00]
- **Rockstar's physics-cost controls (freeze, clear, density, disable)** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_area_cleanup, docs_performance_physics_cost_density_multipliers [EXTRACTED 1.00]
- **Strand 27 activated in standard_global_reg, initial and flow_controller** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Property purchase and trade-in flow** — docs_online_properties_layered_property_pricing, docs_online_properties_net_gameserver_get_price, docs_online_properties_trade_in_half_refund, docs_online_properties_network_earn_from_property, docs_online_properties_network_buy_property [EXTRACTED 1.00]
- **Three systems called replay** — docs_gameplay_missions_replay_director_and_editor_replay_controller, docs_gameplay_missions_replay_director_and_editor_clip_recorder, docs_gameplay_missions_replay_director_and_editor_director_mode, docs_gameplay_missions_replay_director_and_editor_rockstar_editor [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Simple interior launch chain (ext -> int -> type script)** — docs_online_properties_am_mp_smpl_interior_ext, docs_online_properties_am_mp_smpl_interior_int, docs_online_properties_simple_interior_type_scripts, docs_online_properties_simple_interiors [EXTRACTED 1.00]
- **Skill system data flow** — docs_gameplay_player_skills_and_abilities_spstatssetup_xml, docs_gameplay_player_skills_and_abilities_playerinfo_ymt, docs_gameplay_player_skills_and_abilities_stats_controller, docs_gameplay_player_skills_and_abilities_seven_skills, docs_gameplay_player_skills_and_abilities_skill_growth_formula [EXTRACTED 1.00]
- **Story death/arrest restart flow** — docs_gameplay_player_respawn_death_and_arrest_standard_global_init, docs_gameplay_player_respawn_death_and_arrest_hospital_restarts, docs_gameplay_player_respawn_death_and_arrest_police_restarts, docs_gameplay_player_respawn_death_and_arrest_respawn_controller, docs_gameplay_player_respawn_death_and_arrest_death_fee, docs_gameplay_player_respawn_death_and_arrest_arrest_penalty, docs_gameplay_player_respawn_death_and_arrest_respawn_resets, docs_gameplay_player_respawn_death_and_arrest_pause_death_arrest_restart [EXTRACTED 1.00]
- **Story unlock pipeline: build, run and gate strands** — docs_gameplay_missions_story_flow_initial, docs_gameplay_missions_story_flow_flow_program, docs_gameplay_missions_story_flow_flow_controller, docs_gameplay_missions_story_flow_flow_strands, docs_gameplay_missions_story_flow_flow_flags, docs_gameplay_missions_story_flow_mission_triggerers [EXTRACTED 1.00]
- **Story money booking flow** — docs_gameplay_economy_economy_and_pickups_change_money_helper, docs_gameplay_economy_economy_and_pickups_sp_total_cash, docs_gameplay_economy_economy_and_pickups_money_spent_stats, docs_gameplay_economy_economy_and_pickups_respawn_controller, docs_gameplay_economy_economy_and_pickups_stat_set_int [EXTRACTED 1.00]
- **Story stock market system** — docs_gameplay_economy_economy_and_pickups_stock_controller, docs_gameplay_economy_economy_and_pickups_bawsaq, docs_gameplay_economy_economy_and_pickups_lcn, docs_gameplay_economy_economy_and_pickups_finance_saved_array, docs_gameplay_economy_economy_and_pickups_stock_events, docs_gameplay_economy_economy_and_pickups_sm_stats [EXTRACTED 1.00]
- **Stranger entry gating chain** — docs_gameplay_missions_strangers_and_freaks_randomchar_controller, docs_gameplay_missions_strangers_and_freaks_availability_conditions, docs_gameplay_missions_strangers_and_freaks_saved_random_characters, docs_gameplay_missions_strangers_and_freaks_gating_flags, docs_gameplay_missions_strangers_and_freaks_code_controller, docs_gameplay_missions_story_flow_activate_stranger_mission [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **Registering add-on content (meta, text, content.xml)** — docs_entities_vehicles_vehicles_add_on_vehicle_pack, docs_entities_objects_text_and_names_dlc_text_registration, docs_entities_peds_peds_add_on_ped [INFERRED 0.75]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Crime to wanted stars to dispatch pipeline** — docs_ai_perception_and_events_can_call_police, docs_ai_wanted_level_and_police_crimeinformation_meta, docs_ai_wanted_level_and_police_points_to_stars, docs_ai_police_and_services_dispatch_meta [INFERRED 0.85]
- **Ambient population system (zones, schedules, scenarios, car generators)** — docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_scenarios_scenario_points, docs_entities_spawning_vehicle_generators_and_traffic_car_generators, docs_entities_spawning_population_zonebind_ymt [INFERRED 0.85]
- **One story mission at a time** — docs_core_runtime_scripts_mission_stack, docs_core_runtime_scripts_current_mission_type, docs_core_runtime_scripts_mission_triggerers, docs_core_runtime_scripts_director_mode [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Material-keyed data: physics, fire and effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_effects_data_files [INFERRED 0.85]
- **Rules for mods running beside the VM** — scripting_script_vm_waitpattern, scripting_script_vm_forcecleanup, scripting_natives_engine_api_contracts [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Server-side dependencies an offline Online must replace** — docs_online_stats_and_tunables_tuneables_processing, docs_online_stats_and_tunables_mpstatssetup_xml, docs_online_stats_and_tunables_transaction_basket, docs_online_rockstar_services_cloud_stat_slots, docs_online_rockstar_services_ros_credentials, docs_online_rockstar_services_ugc_service, docs_online_stats_and_tunables_offline_online_replacement [INFERRED 0.85]
- **Replay and retry controller questions** — open_questions_gp_016, open_questions_gp_017, open_questions_gp_020, open_questions_gp_024, open_questions_gp_025, docs_gameplay_missions_replay_director_and_editor_gp_087, open_questions_replay_controller, open_questions_mission_repeat_controller [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules, _github_workflows_file_rules_file_rules_check [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How Rockstar scripts stay within memory and streaming limits** — docs_core_memory_and_pools_can_register_mission_entities, docs_core_memory_and_pools_population_budgets, scripting_native_usage_streaming_set_model_as_no_longer_needed, docs_core_streaming_request_check_release, docs_core_streaming_polling_not_blocking [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]

## Communities (133 total, 8 thin omitted)

### Community 0 - "Repo Overview and Guides"
Cohesion: 0.04
Nodes (96): The AI architecture, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks, Test cards: poll vs re-give, keep task, AI cost and level of detail (+88 more)

### Community 1 - "Modding Start Guide"
Cohesion: 0.04
Nodes (77): Core engine (folder index), Surviving game updates guide (R11), ScriptHookV.log, ScriptHookV build version gate, Examples, Six SHVDN v3 C# sample scripts, handling.meta, CHandlingData entries (+69 more)

### Community 2 - "PED and PLAYER Natives"
Cohesion: 0.07
Nodes (63): Swimming and diving, Breath 10 to 40 s, stamina 10 to 90 s, Dive and fall heights, SET_PED_MAX_TIME_UNDERWATER literals, Scuba gear outfit for 5 models, Sea edge world limits and 60 s trespass death, PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES (+55 more)

### Community 3 - "Population and Traffic"
Cohesion: 0.05
Nodes (57): Objects, Text and names in content, DLC text registration (dlctext.meta, TEXTFILE_METAFILE), global.gxt2 text tables, Name lookup natives (GET_DISPLAY_NAME_FROM_VEHICLE_MODEL), Peds, Add-on ped requirements, Ped name prefixes (a_, ig_, s_, csb_ ...) (+49 more)

### Community 4 - "Mod Map and Data Atlas"
Cohesion: 0.05
Nodes (52): Adding or replacing music (DLC station pack), Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins) (+44 more)

### Community 5 - "Vehicle and World Physics"
Cohesion: 0.05
Nodes (53): Static vs dynamic and breakable props, Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file, Ragdoll blocking flags and masks, CTaskNM ragdoll tasks, Physics cost: what the simulation spends, and how scripts keep it down (+45 more)

### Community 6 - "Performance and Measuring"
Cohesion: 0.05
Nodes (48): Game threads (24, Update TIME_CRITICAL), Heavily modded install script load (52 + 61), 15 W laptop throttling, Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat (+40 more)

### Community 7 - "Skills, Stats and Flying"
Cohesion: 0.07
Nodes (47): Economy and pickups (R3.9), atm_trigger script, Collectable scripts (letterscraps, spaceshipparts, underwaterpickups), CPickupData, CREATE_PICKUP_ROTATE native, CREATE_PORTABLE_PICKUP native family, DLC_WEAPON_PICKUPS content entries, SPx_MONEY_SPENT_* spending stat family (10 categories + total) (+39 more)

### Community 8 - "Menus, Text, HUD"
Cohesion: 0.06
Nodes (49): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, Pause and Online menus (+41 more)

### Community 9 - "Boot Scripts (initial, main)"
Cohesion: 0.06
Nodes (47): Boot and script control (R1.2), Boot sequence short version, Timeline of one measured launch, director_mode, Engine starts startup, initial and main, flow_controller, flowintrotitle, GET_INDEX_OF_CURRENT_LEVEL (+39 more)

### Community 10 - "Example Mods (C#)"
Cohesion: 0.06
Nodes (7): Samples, HelloWorld, PlayerAndWorld, NativeCalls, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 11 - "Roadmap and Contributing"
Cohesion: 0.06
Nodes (38): Issue template: Claim a research topic, Claim a research topic issue template, Branch naming (research/<ID>-pass2-<what> ...), Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass) (+30 more)

### Community 12 - "Audio, Speech, Radio"
Cohesion: 0.06
Nodes (40): How audio is organised, Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, 54 sound archives (x64/audio/sfx, .awc), Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Music and radio (+32 more)

### Community 13 - "Phase 4 Story Batches"
Cohesion: 0.08
Nodes (42): GP-087: engine meaning of replay type number, P4.1 Story flow (R5.1), P4.10 Skills, flying and weapons (R3.6, R3.4, R3.1), P4.2 Mission anatomy and replay (R5.2, R5.8), P4.3 Minigames and activities (R5.5), P4.4 Strangers and freaks (R5.4), P4.5 Cutscenes and dialogue (R5.6), P4.6 Character switching (R6.1) (+34 more)

### Community 14 - "Online DLC Storylines"
Cohesion: 0.09
Nodes (39): Properties in GTA Online, am_pi_menu script, P3.1 Interaction menu, phone and apps (R7.10), P3.10 DLC storylines (R7.9), P3.11 Creator internals (R7.11), P3.12 Story systems in an Online mode (R5.7), P3.2 The job lobby (R7.5), P3.3 Inside freemode and sessions (R7.1, R15.1) (+31 more)

### Community 15 - "Server-backed Online Screens"
Cohesion: 0.08
Nodes (36): Server-backed Online screens (R8.5), am_contact_requests, appbusinesshub (business computer), appinternet (in-game websites), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Busy spinners and warning screens (+28 more)

### Community 16 - "NETWORK Natives"
Cohesion: 0.11
Nodes (37): Time, weather and wind, Game clock natives, Online clock override, respawn_controller weather reroll, WeatherCycles fixed list, Persistent weather lock natives, weather.xml (types, cycles, GPU fx), Wind (WindMin/WindMax, SET_WIND) (+29 more)

### Community 17 - "Minigames and Activities"
Cohesion: 0.10
Nodes (36): Minigames and activities (R5.5), Activity id list 0-18, Activity unlock bits (flow bitset ID 0), am_mp_arc_cab_manager, code_controller code entries, Darts (301 per leg), Activity fees and pay, Flight school medals (pilot_school) (+28 more)

### Community 18 - "Online Broadcast Blocks"
Cohesion: 0.06
Nodes (36): 37 broadcast blocks by registered name (15 player, 18 host, 4 job), freemode (registers 33 broadcast blocks: 15 player, 18 host), Global_1057198 g_sMC_serverBDEndJob (end of job) (host broadcast block), Global_1689064 GlobalServerBD_DM (host broadcast block), Global_1873411 GPBD_MissionName (player broadcast block), Global_1873924 GPBD_Kicking (vote kicks) (player broadcast block), Global_1877125 GSBD_Kicking (host broadcast block), Global_1877158 GPBD_FM_HeistPlanning (player broadcast block) (+28 more)

### Community 19 - "Story Flow and Strangers"
Cohesion: 0.11
Nodes (35): Mission triggerer lead-in scenes, The story mission flow: how missions unlock, Activate strand command, agency_heist2 special builder, What a fail does to the flow (pass/fail labels), Blitz Play prep 3 (fbi4_prep3, never activated), finale_choice, Flag ID 120: Michael and Trevor in exile (+27 more)

### Community 20 - "Replay and Director Mode"
Cohesion: 0.09
Nodes (35): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder (engine), Director mode quick-travel locations (27 + 2 user), director_mode, Director mode rules and warnings (CM_WARN01-07), Fail screen labels (REPLAY_RETRY, REPLAY_SKIPM ...), maintransition (+27 more)

### Community 21 - "MainTransition and Creator"
Cohesion: 0.08
Nodes (33): Back to story mode, benchmark, Force cleanup bits (2, 8, 64, 1, 128), freemode (MP_LAUNCH_SCRIPT stack), Level index 5: network testbed level, MainTransition, selector, SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME (+25 more)

### Community 22 - "Cutscenes and Dialogue"
Cohesion: 0.12
Nodes (31): Freemode models and head blend, Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A) (+23 more)

### Community 23 - "Story Flow and Strangers (2)"
Cohesion: 0.11
Nodes (32): Activate stranger mission command, Flag IDs 130/131: exile started/over, 146 script brains (99 world-point, 47 object), Strangers, freaks and side content, appinternet (Epsilon website), atm_trigger object brain, What makes an entry available, Brain sets (story set 1, Online set 8) (+24 more)

### Community 24 - "Script Launch Graph"
Cohesion: 0.15
Nodes (31): script-launch-graph.ps1: launches via git grep, Script launch graph (build 3725), Activity launchers' own names (golf, darts, triathlon, pilot school ...), 270-entry activity table (fmmc_launcher and 265 scripts), am_mp_drone (33 callers), Backbone diagram, Online, Backbone diagram, story mode, Script brains: 99 world-point and 47 object brains (+23 more)

### Community 25 - "Story Mission Anatomy"
Cohesion: 0.17
Nodes (28): mission_stat_watcher script, Anatomy of a story mission (R5.2), armenian1 (Franklin and Lamar), Checkpoint recording (func_893 / func_680 / func_580), Heist crew skill tiers and the take, flow_controller script, Flow-started flag (f_9092 FLOW_STRUCT), Force cleanup handler HAS_FORCE_CLEANUP_OCCURRED(3) (+20 more)

### Community 26 - "VEHICLE Natives"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 27 - "Saves, Autosave, Completion"
Cohesion: 0.14
Nodes (29): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values) (+21 more)

### Community 28 - "Native Namespace Index"
Cohesion: 0.26
Nodes (30): Native namespace map, MISC namespace is a junk drawer, Decompiler vs NativeDB namespace names (CAM=CAMERA...), Native namespace coverage map (R0.8), 45 named namespaces + 2 unknown natives, Native usage index, Game build 3725, Decompile commit 6c18d3e8b (+22 more)

### Community 29 - "Transitions and Sessions"
Cohesion: 0.15
Nodes (29): Rockstar services (R15.2), Cloud files (NETWORK_IS_CLOUD_AVAILABLE), Cloud stat slots (STAT_SLOT_IS_LOADED), Crews (NETWORK_CLAN_*), Leaderboards (LEADERBOARDS_WRITE_ADD_COLUMN), Behaviour when a service is missing, Money service (MONEY namespace, 311 natives), Presence (PRESENCE_EVENT_UPDATESTAT_INT, rich presence) (+21 more)

### Community 30 - "MONEY and Shop Natives"
Cohesion: 0.07
Nodes (26): Asset dependency list, dlclist.xml, Native changes 3725 to 3889, Stale modded update.rpf, Bullet damage model (fall-off, headshot, penetration), CAimingInfo and lock-on (LockOnRange), CAmmoInfo and shared ammo pools (AmmoMax), CWeaponInfo (+18 more)

### Community 31 - "Respawn, Death, Arrest"
Cohesion: 0.12
Nodes (28): PP_INFO_STRUCT per-character saved state, Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS (+20 more)

### Community 32 - "Global Variable Map"
Cohesion: 0.14
Nodes (26): The global variable map (R0.4), Global_102466/108447/96580/96581 (checkpoint, snapshot, skip), Global_22983/22602/21591 (dialogue request and state), Who sets each bit of .f_204/.f_203 (shared header, mod shops, jobs, freemode), Global_2658291[p].f_204/.f_203 per-player flag words, 16 named parts of .f_260 (property OWNED stats), Global_1845250[p].f_260 stat-backed state, Global_2658291[p].f_325.f_11: interior owner (+18 more)

### Community 33 - "TASK Natives"
Cohesion: 0.17
Nodes (27): TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS, TASK native namespace (+19 more)

### Community 34 - "Open Questions Tracker"
Cohesion: 0.11
Nodes (23): Open Questions: the Second Pass, Audio questions (AUD-), File formats questions (FF-), Physics questions (PHY-), Rendering questions (REN-), The world questions (WLD-), GP-079 Explosion damage and radius per explosive, KG-001 Tie in weakly connected nodes (+15 more)

### Community 35 - "Stats and Tunables"
Cohesion: 0.13
Nodes (25): Clothing price lookup by textLabel (17,411 cases, tunables), Cosmetic save stats (CLTHS_*, DLC_APPAREL_ACQUIRED, TATTOO_FM_UNLOCKS, CHAR_FM_STORED_HAIRDO), Rebuild shops in a mod rather than launching Rockstar's, am_contact_requests (Online contact services), Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, Hash-only tunables (7,296; 311 recovered), MONEY NETWORK_SPENT_* / NETWORK_EARN_* natives (+17 more)

### Community 36 - "Saves, Autosave, Completion (2)"
Cohesion: 0.12
Nodes (25): P2.2 The global map (R0.4), P2.3 Saves (R1.7), P2.4 Completion and autosave (R5.3), P2.5 Archives and content (R1.6), P2.6 Script launch graph (R0.5), P2.7 Streaming and memory (R1.5, R1.4), Player and server broadcast data, Core engine questions (CORE-) (+17 more)

### Community 37 - "Script Catalogs"
Cohesion: 0.09
Nodes (23): Research tools, After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts, ugc-keys.ps1: key paths in UGC files, ysc-dump.ps1: script headers and strings for all 1,143 scripts (+15 more)

### Community 38 - "Skills, Stats and Flying (2)"
Cohesion: 0.15
Nodes (24): Flying, AI flight tasks, Script aircraft natives, CTaskParachute tunables (movementtasks.ymt), Story flight school pilot_school, CFlyingHandlingData block, handling.meta (22 base aircraft), LAZER (highest thrust, lowest glide) (+16 more)

### Community 39 - "Rockstar Creator Internals"
Cohesion: 0.13
Nodes (23): Rockstar Creator internals: how tracks and maps are built from props, Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Job type and subtype table, Mission Creator limits (public_mission_creator), Open questions (creator) (+15 more)

### Community 40 - "Online Heists"
Cohesion: 0.15
Nodes (23): Casino heist crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo Perico primary target weighting, Classic heists (Fleeca, Prison Break, Humane Labs, Series A, Pacific Standard), Classic planning board Scaleform movies (heist_mp, heistmap_mp, heist_pre), The Diamond Casino Heist, The Doomsday Heist, Heist elite challenges (+15 more)

### Community 41 - "Time, Weather, MISC Natives"
Cohesion: 0.09
Nodes (23): TYRE_GRIP / WET_GRIP / TOP_SPEED_MULT columns, handling.meta (CHandlingData), Sub-handling blocks (Car, Bike, Flying, Boat ...), Water and buoyancy, CBoatHandlingData fields, fPercentSubmerged buoyancy field, Water heights (0, 30, 160.3, 196.4 m), Water probe and calming natives (+15 more)

### Community 42 - "Population and Traffic (2)"
Cohesion: 0.13
Nodes (23): AI-032 Most-set SET_PED_CONFIG_FLAG numbers, Entities questions (ENT-), Performance questions (PERF-), CORE-026 TextureQuality values and memory, ENT-007 Load order when two packs define the same label, ENT-014 SET_PED_CONFIG_FLAG numbers, ENT-016 Concurrent Euphoria ragdoll limit, ENT-018 Fall damage by height (+15 more)

### Community 43 - "Online Properties"
Cohesion: 0.13
Nodes (20): freemode, Nightclub popularity and safe pay bands, am_mp_property_ext, am_mp_yacht, ambient_mp.ipl, Property entry checks (wanted, mission objective, garage full, trailer), freemode, Garage sizes per ownership slot (freemode function) (+12 more)

### Community 44 - "Runtime Scripts and Mission Type"
Cohesion: 0.13
Nodes (18): gameconfig.xml PoolSizes, Runtime scripts guide (R0.2, R0.5), code_controller (delayed-action scheduler), Current mission type global (Global_44869, CORE-033), director_mode, flow_controller, Force-cleanup bits (FORCE_CLEANUP / HAS_FORCE_CLEANUP_OCCURRED), gameconfig.xml (+10 more)

### Community 45 - "Job Lobby"
Cohesion: 0.23
Nodes (20): am_pi_menu (interaction menu), Interaction menu tree (144 pages, 1,203 items), The job lobby (fmmc_launcher, R7.5), Activity table (270 activities to 260 scripts, in 266 scripts), Corona (job lobby screens), Corona settings flow (GPBD_FM_2 to Global_2685150.f_669), End-of-job rating and next-job vote (FM_NXT_*), FM_Maintain_Transition_Players (+12 more)

### Community 46 - "File-rules Workflow Steps"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 47 - "Global Variable Map (2)"
Cohesion: 0.14
Nodes (18): Shared activity-type helper (212 scripts), Global reference count (git grep, 5,151 distinct bases), Global_1583765 (personal vehicles), Global_1679103 (mission HUD timers), Global_1892653 GPBD_FM_3 (player broadcast, 615/player), Global_24529 (creator menu and text state), Global_2635562 (activity timers / job session state), Global_2673271 (local session state, am I host) (+10 more)

### Community 48 - "Online Cosmetic Shops"
Cohesion: 0.22
Nodes (19): Online cosmetics and the shops that sell them (R6.7), 512 priced barber items, Barber menu pages (Hairstyles, Beards, Eyebrows, Chest, Contacts, Face Paints, Makeup), Barber rank locks (HAIR_UNLOCK), Clothes store browse spots and interiors (v_clotheslo/mid/hi), Clothing catalogue (36,232 items in 86 *_shop.meta files), Contact lenses as eye colour (SET_HEAD_BLEND_EYE_COLOR), Hair fades (NG_M_Hair_001, multiplayer_overlays, hairOverlay) (+11 more)

### Community 49 - "Script VM and Natives"
Cohesion: 0.11
Nodes (19): Ask-then-wait (REQUEST_ / HAS_..._LOADED), Contracts Rockstar keeps (request, release, create, clean up), What each native family can't do, Stack sizes passed per launch, The script VM: how GTA V runs its scripts, and how mods run beside them, Compiled script (.ysc): code, statics, native table, strings, Force cleanup bits (1, 2, 4, 8, 16, 32, 64, 128), Lua plugin (LUA.asi) as a ScriptHookV script (+11 more)

### Community 50 - "Handoff and AI Instructions"
Cohesion: 0.13
Nodes (12): Branch main-km1sze (phase 4 work), Build 3717 control ID renumbering (37 INPUT_CREATOR_* at 257-293, old IDs +37), Engine enum dump of build 3889 (Known source for control and ability-type names), Game executable (read-only reverse engineering), Global_114904.f_8620 (GP-088/GP-089 watch entries), HANDOFF: second pass, end of phase 4, In-game test cards (story mode + SHVDN/ScriptHookV test mod), KG-001 to KG-004 knowledge graph docs housekeeping (+4 more)

### Community 51 - "Open Questions Tracker (2)"
Cohesion: 0.16
Nodes (18): P2.1 Boot and runtime scripts (R1.2, R0.2), Getting started questions (GS-), Scripting questions (SCR-), CORE-017 Force-cleanup bits 8 to 128, CORE-018 How the engine starts main, initial and startup, CORE-024 Save file on-disk format, CORE-032 Engine-raised force-cleanup bits 16 and 32, Engine reverse engineering (the executable) (+10 more)

### Community 52 - "WEAPON and ZONE Natives"
Cohesion: 0.12
Nodes (18): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+10 more)

### Community 53 - "Controls and Camera"
Cohesion: 0.18
Nodes (17): Control ID renumbering in build 3717 (+37 from 257), Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+9 more)

### Community 54 - "Organisations and Businesses"
Cohesion: 0.16
Nodes (17): tuneables_processing, Acid lab, am_pi_menu (interaction menu), appbusinesshub, Biker businesses (weed, documents, cash, meth, cocaine), Boss registration (gb_bosscost unused, registering free), Bunker manufacturing and research, Business loop: supplies, production, stock, sell (+9 more)

### Community 55 - "Decompile and Game Version"
Cohesion: 0.12
Nodes (16): Game version (Legacy 1.0.3725.0), LOBBY_AUTO_MULTIPLAYER_* flags, Launching into Online, Reading the decompiled game scripts, Community decompile repository (one commit per build), freemode started by maintransition with stack 35,250; creator 28,000, Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts) (+8 more)

### Community 56 - "Archives, Streaming, Memory"
Cohesion: 0.14
Nodes (15): Crowd thinning natives (density, non-creation area, suppress), Navmesh required region and blocking objects, Online venue peds (am_mp_peds etc.), Ambient speech voices (full and mini), RPF archives, Memory, pools and limits (R1.4), Entity limits: 256 peds, 300 vehicles, Fixed-size pools (~230) (+7 more)

### Community 57 - "HUD, DATAFILE, APPS Natives"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 58 - "Handoff and AI Instructions (2)"
Cohesion: 0.15
Nodes (8): graphify-out exempt paths, CLAUDE.md (AI assistant instructions), Decompile commit 'Update for 1.72-3725.0', graphify knowledge graph (graphify-out/), Natives as the script-engine interface, RPF data layout (common.rpf, update.rpf, dlcpacks, dlc_patch), Using an AI assistant, Research a topic in an hour checklist

### Community 59 - "Archives, Streaming, Memory (2)"
Cohesion: 0.14
Nodes (13): Population budgets (SET_PED_POPULATION_BUDGET), Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (optional map sections), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, PIN_INTERIOR_IN_MEMORY (+5 more)

### Community 60 - "Data Needs Checklist"
Cohesion: 0.15
Nodes (14): DATA-NEEDS.md (questions needing game files), Animation, cameras, effects, timecycle data needs, Character appearance and shops data needs, Audio data needs (.rel, .awc), cameras.ymt, Engine config and archives data needs (gameconfig.xml, listings), gameconfig.xml, handling.meta (+6 more)

### Community 61 - "AI Layers and Glossary"
Cohesion: 0.15
Nodes (14): Glossary, Broadcast data (player and host synced globals), Decision maker: event to ped reaction table, Global block: shared script memory owned by a registration script, Glossary of modding and engine terms, IPL map placement groups toggled by REQUEST_IPL, Legacy vs Enhanced PC editions, RPF archive and DLC pack layout (+6 more)

### Community 62 - "Setup and Requirements"
Cohesion: 0.14
Nodes (14): ASI, ScriptHookV, ScriptHookVDotNet, Setup: game version and everything you need, Quick start for research (about 30 minutes), Tools to read the game: CodeWalker, OpenIV, Git, decompile, PowerShell, bash, NativeDB, Dependencies to run mods: ScriptHookV 3889.0, SHVDN 3.7.0, LemonUI, NativeUI, iFruitAddon2, Lua plugin, Menyoo, ILSpy, Menyoo trainer, OpenIV (+6 more)

### Community 63 - "Persistent Controller Scripts"
Cohesion: 0.16
Nodes (14): building_controller (IPL world states), cellphone_controller, error_listener, freemode, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, InGameHud, main_persistent, maintransition (story to Online) (+6 more)

### Community 64 - "Character Switching"
Cohesion: 0.24
Nodes (14): SRLs (streamed request lists, srllist.meta), Character switching (R6.1), Arrival scene picker (time blocks, flags, weighted draw), CHANGE_PLAYER_PED, Wheel Online slot (MainTransition), player_controller, player_controller_b, PLAYER_SCENE_SAVED_DATA (+6 more)

### Community 65 - "How GTA Online Works"
Cohesion: 0.15
Nodes (14): How GTA Online works, Online stats in mpstatssetup.xml (17,933), Network session and broadcast data, Script VM, natives, globals, What depends on Rockstar servers, Server transactions for money, Cloud tunables, UGC cloud content and local files (+6 more)

### Community 66 - "Freemode and Sessions"
Cohesion: 0.24
Nodes (14): Inside freemode (first pass), Player/server broadcast data globals, freemode_init, freemode (GTA Online main script), Host state machine (0,4,5), 29 helper scripts launched by freemode, 60 network event types (queue 1, ids 151-249), Open questions (freemode) (+6 more)

### Community 67 - "Menus with LemonUI"
Cohesion: 0.15
Nodes (14): LemonUI, Steps 5/6/7 are alternatives (C#, Lua, C++), ScriptHookVDotNet v3 (SHVDN 3.7.0.189), Language-for-job table (XML, C#, Lua, C++, natives, JSON...), 07 Legacy: SHVDN v2 and NativeUI, NativeUI 1.9.0, NativeUI to LemonUI mapping, Porting v2 mod to v3 (+6 more)

### Community 68 - "DLC and Metadata Natives"
Cohesion: 0.14
Nodes (14): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA (+6 more)

### Community 69 - "GRAPHICS and INTERIOR Natives"
Cohesion: 0.14
Nodes (14): GRAPHICS natives used by the game scripts, ANIMPOSTFX_PLAY, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, SET_TIMECYCLE_MODIFIER, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME (+6 more)

### Community 70 - "Toolbox and Repo Tools"
Cohesion: 0.17
Nodes (11): Community decompile (GTA-V-Decompiled-Scripts), git grep / git show / git diff, GTA V Script Decompiler (njames93), Workflow: following native arguments through wrappers, NativeDB, update-check.ps1 tool, EXTRAMETADATA namespace (shop items), Decompiler vs NativeDB name aliases (+3 more)

### Community 71 - "Saves, Autosave, Completion (3)"
Cohesion: 0.21
Nodes (11): Saves: the story save (R1.7), COMP_PERCENT_SAVED_ARRAY, FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values), Save upgrade function in startup, Save version fSaveVersion (1.7), standard_global_reg (+3 more)

### Community 72 - "Repo Overview and Guides (2)"
Cohesion: 0.26
Nodes (13): pedpersonality.ymt, AI-011 Decode pedpersonality.ymt, AI-013 Aim assist and lock-on for the player, AI-016 Decode pedpersonality.ymt (from guide text), AI-021 Temp action number names, AI-026 TASK_VEHICLE_TEMP_ACTION action numbers, AI-035 Crime points per crime, AI-047 Crime points added per crime (engine) (+5 more)

### Community 73 - "Phone and Interaction Menu"
Cohesion: 0.32
Nodes (13): Interaction menu, phone and apps (R7.10), 38 app* scripts (appbusinesshub, appmpjoblistnew, appsecuroserv ...), appinternet (in-game internet), cellphone_controller (phone app table owner), cellphone_flashhand (starts phone app scripts), Is_Sniper_App_Available story save flag, Phone app table (Global_9470 slots), Phone skins (cellphone_ifruit, cellphone_badger, cellphone_facade, cellphone_prologue) (+5 more)

### Community 74 - "Brain Sets and Clashes"
Cohesion: 0.21
Nodes (12): Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems), pb_prostitute ped brains (three hooker models) (+4 more)

### Community 75 - "Phase 1 UI Batches"
Cohesion: 0.19
Nodes (13): P1.1 Pause and Online menus (R8.1), P1.2 Text labels (R8.3), P1.3 HUD, colours and blips (R8.4), P1.4 Scaleform movies (R8.2), P1.5 Story-mode UI (R8.6), P1.6 Server-backed Online screens (R8.5), P1.7 Subtitles and phone-call lines, User interface questions (UI-) (+5 more)

### Community 76 - "Camera, Audio, Cutscene Natives"
Cohesion: 0.15
Nodes (13): AUDIO natives used by the game scripts, GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CUTSCENE natives used by the game scripts (+5 more)

### Community 77 - "Toolbox and Repo Tools (2)"
Cohesion: 0.20
Nodes (12): Tools and resources (toolbox), Claude Code (AI assistance) and skills, CodeWalker, ILSpy, LemonUI, NativeUI, iFruitAddon2, Repo PowerShell tools, SHVDN monitoring script, Protecting a working install (R11.3) (+4 more)

### Community 78 - "Camera, Audio, Cutscene Natives (2)"
Cohesion: 0.17
Nodes (12): CAMERA natives used by the game scripts, CREATE_CAM, DO_SCREEN_FADE_IN, IS_SCREEN_FADED_OUT, CAMERA native namespace: CAMERA natives: script cams, gameplay cam, screen fades, RENDER_SCRIPT_CAMS, SET_CAM_ACTIVE, GTA natives used by the game scripts (+4 more)

### Community 79 - "ENTITY and DECORATOR Natives"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 80 - "Script VM and Natives (2)"
Cohesion: 0.18
Nodes (11): Natives as the engine API: kinds, contracts and costs, Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT), START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, Handle guards (DOES_ENTITY_EXIST, IS_ENTITY_DEAD), Slow, heavy or risky natives, Advice for modders: follow Rockstar's contracts, NETWORK natives off-limits for mods, One-frame natives (*_THIS_FRAME) (+3 more)

### Community 81 - "Random Events and IPLs"
Cohesion: 0.20
Nodes (10): IPL map section switching, Restricted areas (re_armybase, re_prison), Random events, Area scripts re_armybase/re_prison/re_lossantosintl/re_yetarian, Shared random event launch check, SET_RANDOM_EVENT_FLAG / SET_MISSION_FLAG, re_* random event scripts, World brain points (ambient.ipl) (+2 more)

### Community 82 - "Working Method and Stocks"
Cohesion: 0.18
Nodes (9): clothes_shop_mp item tables (GP-083), CodeWalker + tools/rpf-cw.ps1 extraction, DATA-NEEDS.md per-question data checklist, Text files (.gxt2, American, base + update + DLC), handling.meta (base + every DLC), Hashed tunables (tunable name list), playerinfo.ymt (GP-073), shop_controller tag hashes (GP-081) (+1 more)

### Community 83 - "Time, Weather, MISC Natives (2)"
Cohesion: 0.18
Nodes (11): BRAIN natives used by the game scripts, IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, REGISTER_WORLD_POINT_SCRIPT_BRAIN, BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, START_NEW_SCRIPT_WITH_ARGS (+3 more)

### Community 84 - "Stock Company Names"
Cohesion: 0.24
Nodes (10): Text (.gxt2) data needs, BAWSAQ exchange (community-stat prices), BSS_BSTR_ company labels, code_controller script, FINANCE_SAVED_ARRAY, GP-090 stock company names, LCN exchange (simulated prices), sm_ stock counter stats (204, 126 counters) (+2 more)

### Community 85 - "Setup and Requirements (2)"
Cohesion: 0.29
Nodes (10): Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, check-system.ps1: PC requirement check, System requirements outside the game folder, After reinstalling Windows checklist, DirectX End-User Runtime June 2010 (d3dcompiler_43, d3dx9_43, xinput1_3), .NET Framework 4.8 (needed by SHVDN and .NET mods), Method: read import tables of every exe/asi/dll, Not needed: x86 runtimes, mss64.dll, XNA, .NET 5+ runtime (+2 more)

### Community 86 - "Leaderboards and Online Globals"
Cohesion: 0.22
Nodes (10): Global_2097536 (leaderboard rows for display), Global_2733002 (interaction-menu local state), am_pi_menu (interaction menu), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780, Leaderboard board IDs per screen (39 IDs), Shared leaderboard library (30 scripts), LEADERBOARDS2_READ_* natives, Story minigame boards (golf 193, darts 190, tennis 283, pilot school 965-974 ...) (+2 more)

### Community 87 - "Appearance and Clothing"
Cohesion: 0.20
Nodes (10): Name labels (gameName, vehicleMakeName, HumanNameHash), Appearance and clothing, 12 ped component slots and prop anchors, EXTRAMETADATA shop natives, Preload ped variation data, Restriction tags and forced components, Shop catalogue files (*_shop.meta), Shop scripts (clothes_shop, hairdo_shop, tattoo_shop) (+2 more)

### Community 88 - "Global Blocks and Owners"
Cohesion: 0.25
Nodes (9): landing_pre_startup (empty), 146 script brains, standard_global_init, Block owner scripts table (references per block), Blocks 13 and 15: dead code behind two never-set flags, Global_3407872 (block 13, behind Global_2883694), Global_3932160 (block 15, behind Global_2883693), 21 global blocks of 262,144 slots (+1 more)

### Community 89 - "FIRE and EVENT Natives"
Cohesion: 0.22
Nodes (9): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions (+1 more)

### Community 90 - "Online DLC Storylines (2)"
Cohesion: 0.25
Nodes (8): dlclist.xml pack order, When each fm_content_* script arrived (97 scripts by decompile commit), fm_content_* scripts (85-91), Local vs cloud missions (16 on disk, ~980 content files), Phone-call flows (40 call roots in six DLC dialogue blocks), Property intro cutscenes (289 distinct names), Rebuilding an arc offline, Per-update story flows in freemode (EXEC_FLW...HK24_FLW)

### Community 91 - "Business Computer Apps"
Cohesion: 0.32
Nodes (8): Per-app NET_GAMESERVER transactions and spend/earn natives, appbikerbusiness, appbunkerbusiness, appsecuroserv, Business computer apps and Scaleform movies, NETWORK_EARN_FROM_BUSINESS_PRODUCT, am_mp_property_int, Scripts started by am_mp_property_int (appSecuroServ, appImportExport, appBikerBusiness, carmod_shop, AM_MP_PEDS)

### Community 92 - "Simple Interior System"
Cohesion: 0.25
Nodes (8): am_mp_smpl_interior_ext, AM_MP_SMPL_INTERIOR_INT, Mansions (Tongva Hills, West Vinewood, East Vinewood; interiors 177-179), Restricted mission interiors (43), Simple-interior entrance function tables, The 180 simple interior ids, Per-type interior scripts (AM_MP_BUNKER, AM_MP_HANGAR, AM_MP_NIGHTCLUB ...), Simple interior system (181 SIMPLE_INTERIOR_* names)

### Community 93 - "Working Method and Stocks (2)"
Cohesion: 0.25
Nodes (8): am_pi_menu interaction menu pages (ON-069), Decompile clone at commit 6c18d3e8 (Update for 1.72-3725.0), freemode script (running states, request queue, slot-to-index), golf script AI shot choice (GP-011), mission_triggerer_* scripts (GP-021), mpstatscharactermappingdata.xml (ON-065), native_tables/ folder (native hashes per script and build), player_controller_b / selector 42-entry scene table (GP-038)

### Community 94 - "File Rules"
Cohesion: 0.29
Nodes (6): Blocked extensions list, file-rules check (GitHub workflow), Download-and-run (RISKY) patterns, 500 KB size limit, file-rules check workflow, File rules table

### Community 95 - "Setup and Requirements (3)"
Cohesion: 0.29
Nodes (7): Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, rpf-cw.ps1: list and extract archive files (CodeWalker), CodeWalker 30 dev46, NativeDB

### Community 96 - "Setup and Requirements (4)"
Cohesion: 0.29
Nodes (6): Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Launch with -nobattleye for story-mode mods, Run under Proton or Wine with DXVK (D3D11 to Vulkan)

### Community 97 - "STREAMING Natives"
Cohesion: 0.33
Nodes (7): CAN_REGISTER_MISSION_PEDS/VEHICLES/OBJECTS, HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 98 - "Toolbox and Repo Tools (3)"
Cohesion: 0.33
Nodes (7): Global blocks (18 blocks of 2^18 slots), Registration scripts (global block owners), standard_global_init, standard_global_reg, startup script, startup_positioning, Finding risky code in a mod (memory offsets, patterns, globals)

### Community 99 - "Server Broadcast Fields"
Cohesion: 0.40
Nodes (6): Global_1835511 GSBD_FM (host broadcast block), Global_2649159 GSBD (server broadcast data), Global_2650423 GSBD_BlockB (host broadcast block), Global_2652579 GSBD_BlockC (host broadcast block), Busiest server broadcast fields (GSBD.f_2 entity areas, GSBD_BlockB.f_199 ...), GSBD.f_2 networked entity areas (NETWORK_ADD_ENTITY_AREA)

### Community 100 - "Property Table and Vehicles"
Cohesion: 0.33
Nodes (6): appinternet (Dynasty 8, Maze Bank Foreclosures, Warstock), Kosatka submarine, Offices, clubhouses, office garages and vehicle warehouse, Home classes (high-end, medium, low-end, 2/6/10-car garages), 115-entry property table, Vehicles as properties (MOC, Avenger, Terrorbyte, Kosatka)

### Community 101 - "Issue Template Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 102 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 103 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 104 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 105 - "SCRIPT Natives"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 106 - "Repo Overview and Guides (3)"
Cohesion: 0.40
Nodes (5): Task pool of 8,192 running tasks (gameconfig.xml), Task system: everything a ped does is a task (CTask classes, nested), 119 tuned task classes in tune files (53 combat, 23 vehicle, 21 physics...), Hard caps: 256 peds, 300 vehicles, 8,192 tasks, 950 events, 1,024 navmesh routes, MaxTotalPeds 200 (base 70) population cap below the 256 pool

### Community 107 - "Key Codes and Controls"
Cohesion: 0.60
Nodes (5): Key codes and control IDs, FiveM controls list (old numbering above 256), Frontend control IDs 187-217, TrainerV trainerv.ini [KeyBindings], Windows virtual-key codes (keyboard)

### Community 108 - "PAD Natives"
Cohesion: 0.40
Nodes (5): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace

### Community 109 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 110 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 111 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 113 - "Task Sequences"
Cohesion: 0.50
Nodes (4): Native (engine function identified by 64-bit hash; ~6,700), How scripts give tasks: give once and poll GET_SCRIPT_TASK_STATUS, Sequence tasks: OPEN/CLOSE_SEQUENCE_TASK, TASK_PERFORM_SEQUENCE, FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts) and LOD multiplier natives

### Community 114 - "Toolbox and Repo Tools (5)"
Cohesion: 0.50
Nodes (4): Contributed tools and resources table, Workflow: grouping DISABLE_CONTROL_ACTION runs, Workflow: pricing shop items from tuneables_processing, Global_262145 tunables (most-read global)

### Community 116 - "Population and Traffic (3)"
Cohesion: 0.50
Nodes (4): LOD settings (LodScale, MaxLodScale), popcycle.dat population schedules, Scenario points and region files, Traffic from population cycle

### Community 117 - "Population and Traffic (4)"
Cohesion: 0.67
Nodes (4): Population and model budgets, Script natives shaping population, Scenario groups and blocking areas, Script traffic control natives

### Community 118 - "ITEMSETS Natives"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 119 - "LOCALIZATION Natives"
Cohesion: 0.50
Nodes (4): LOCALIZATION natives used by the game scripts, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type

### Community 120 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 121 - "SECURITY Natives"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 122 - "SHAPETEST Natives"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 123 - "Inbox Template"
Cohesion: 0.67
Nodes (3): Issue template: Inbox, Inbox issue template (found a system no topic covers), Inbox for topics nobody covers

### Community 124 - "Story Flow and Strangers (3)"
Cohesion: 0.67
Nodes (3): code_controller, Run code ID command (code_controller), code_controller

### Community 125 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

### Community 126 - "Unknown Natives"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

## Knowledge Gaps
- **675 isolated node(s):** `Open questions: engine task list, status values, slot numbering`, `Primary task tree and secondary tasks`, `Test cards: poll vs re-give, keep task`, `Open questions: LOD distances, frame time per ped, second CTask pool`, `Scripts trim cost: reduce model budget, population budgets, IS_ENTITY_ON_SCREEN` (+670 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 759 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Repo Overview and Guides` to `Modding Start Guide`, `PED and PLAYER Natives`, `Population and Traffic`, `Mod Map and Data Atlas`, `Vehicle and World Physics`, `Performance and Measuring`, `Skills, Stats and Flying`, `Menus, Text, HUD`, `Roadmap and Contributing`, `Audio, Speech, Radio`, `NETWORK Natives`, `Minigames and Activities`, `Replay and Director Mode`, `MainTransition and Creator`, `Cutscenes and Dialogue`, `Script Launch Graph`, `Story Mission Anatomy`, `Saves, Autosave, Completion`, `Native Namespace Index`, `Transitions and Sessions`, `Respawn, Death, Arrest`, `Global Variable Map`, `Stats and Tunables`, `Script Catalogs`, `Skills, Stats and Flying (2)`, `Rockstar Creator Internals`, `Time, Weather, MISC Natives`, `Job Lobby`, `Online Cosmetic Shops`, `Script VM and Natives`, `Controls and Camera`, `Archives, Streaming, Memory`, `Handoff and AI Instructions (2)`, `Archives, Streaming, Memory (2)`, `Setup and Requirements`, `Character Switching`, `How GTA Online Works`, `Freemode and Sessions`, `Saves, Autosave, Completion (3)`, `Phone and Interaction Menu`, `Brain Sets and Clashes`, `Script VM and Natives (2)`, `Random Events and IPLs`, `Appearance and Clothing`, `Inbox Template`?**
  _High betweenness centrality (0.208) - this node is a cross-community bridge._
- **What connects `Open questions: engine task list, status values, slot numbering`, `Primary task tree and secondary tasks`, `Test cards: poll vs re-give, keep task` to the rest of the system?**
  _675 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Repo Overview and Guides` be split into smaller, more focused modules?**
  _Cohesion score 0.041666666666666664 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Audio, Speech, Radio` to `Repo Overview and Guides`, `Modding Start Guide`, `PED and PLAYER Natives`, `Population and Traffic`, `Mod Map and Data Atlas`, `Vehicle and World Physics`, `Performance and Measuring`, `Skills, Stats and Flying`, `Menus, Text, HUD`, `Roadmap and Contributing`, `NETWORK Natives`, `Minigames and Activities`, `Story Flow and Strangers`, `Cutscenes and Dialogue`, `Story Flow and Strangers (2)`, `Script Launch Graph`, `Story Mission Anatomy`, `Saves, Autosave, Completion`, `Respawn, Death, Arrest`, `Global Variable Map`, `Script Catalogs`, `Skills, Stats and Flying (2)`, `Rockstar Creator Internals`, `Time, Weather, MISC Natives`, `Job Lobby`, `Script VM and Natives`, `Controls and Camera`, `Archives, Streaming, Memory`, `Archives, Streaming, Memory (2)`, `AI Layers and Glossary`, `Character Switching`, `Saves, Autosave, Completion (3)`, `Toolbox and Repo Tools (2)`, `Script VM and Natives (2)`, `Appearance and Clothing`, `Key Codes and Controls`?**
  _High betweenness centrality (0.177) - this node is a cross-community bridge._
- **Should `Modding Start Guide` be split into smaller, more focused modules?**
  _Cohesion score 0.037868162692847124 - nodes in this community are weakly interconnected._
- **Why does `GTA V Under the Hood: how Grand Theft Auto V works underneath` connect `Repo Overview and Guides` to `Modding Start Guide`, `Population and Traffic`, `Mod Map and Data Atlas`, `Vehicle and World Physics`, `Menus, Text, HUD`, `Boot Scripts (initial, main)`, `Roadmap and Contributing`, `Audio, Speech, Radio`, `Online DLC Storylines`, `Minigames and Activities`, `Story Flow and Strangers`, `MainTransition and Creator`, `Script Launch Graph`, `Story Mission Anatomy`, `Saves, Autosave, Completion`, `Native Namespace Index`, `Open Questions Tracker`, `Rockstar Creator Internals`, `Runtime Scripts and Mission Type`, `Job Lobby`, `Online Cosmetic Shops`, `Script VM and Natives`, `Decompile and Game Version`, `AI Layers and Glossary`, `Setup and Requirements`, `Freemode and Sessions`, `Saves, Autosave, Completion (3)`, `Toolbox and Repo Tools (2)`, `Script VM and Natives (2)`, `Setup and Requirements (2)`, `Appearance and Clothing`, `Setup and Requirements (3)`, `Setup and Requirements (4)`?**
  _High betweenness centrality (0.168) - this node is a cross-community bridge._
- **Should `PED and PLAYER Natives` be split into smaller, more focused modules?**
  _Cohesion score 0.06861239119303636 - nodes in this community are weakly interconnected._