# Graph Report - gta5-under-the-hood  (2026-11-03)

## Corpus Check
- 32 files · ~454,828 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2408 nodes · 5240 edges · 137 communities (129 shown, 8 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 402 edges (avg confidence: 0.82)
- Token cost: 1,007,998 input · 0 output

## Community Hubs (Navigation)
- Repo Overview and Guides
- Story Flow and Strangers
- Performance and Measuring
- Saves, Autosave, Completion
- PED and PLAYER Natives
- Population and Traffic
- Skills, Stats and Flying
- Vehicle and World Physics
- Archives, Streaming, Memory
- Mod Map and Data Atlas
- Toolbox and Repo Tools
- Setup and Requirements
- Online Broadcast Blocks
- Native Namespace Index
- Peds, Animation, Ragdoll
- Minigames and Activities
- Story Mission Anatomy
- Cutscenes and Dialogue
- Modding Start Guide
- Time, Weather, MISC Natives
- Props, Rendering, Effects
- Global Variable Map
- VEHICLE Natives
- Script VM and Natives
- NETWORK Natives
- Online DLC Storylines
- TASK Natives
- Replay and Director Mode
- Modding Languages
- Example Mods (C#)
- Audio, Speech, Radio
- Menus, Text, HUD
- Online Heists
- Camera, Audio, Cutscene Natives
- AI Layers and Glossary
- Freemode and Sessions
- Online Properties
- Online Cosmetic Shops
- Job Lobby
- File-rules Workflow Steps
- Script Launch Graph
- Roadmap and Contributing
- Controls and Camera
- Stats and Tunables
- MONEY and Shop Natives
- Example Mod Classes
- Organisations and Businesses
- Scaleform and Story UI
- Server-backed Online Screens
- Signed-out Screen Guards
- Cookbooks: Menus, Shops, UI
- Data Needs Checklist
- Runtime Scripts and Mission Type
- MainTransition and Creator
- Respawn, Death, Arrest
- Online Character Creator
- Rockstar Creator Internals
- Transitions and Sessions
- Menus with LemonUI
- Open Questions Tracker
- HUD, DATAFILE, APPS Natives
- WEAPON and ZONE Natives
- Handoff and AI Instructions
- Persistent Controller Scripts
- Weapons Data and Unlocks
- Script Catalogs
- Rockstar Services
- Brain Sets and Clashes
- DLC and Metadata Natives
- GRAPHICS and INTERIOR Natives
- Decompile and Game Version
- Boot Scripts (initial, main)
- Character Switching
- Health and Armour
- Phone and Interaction Menu
- Player Broadcast Data
- Leaderboards and Online Globals
- How GTA Online Works
- Prologue Strand and Mission Table
- Global Registration Scripts
- Random Events and IPLs
- ENTITY and DECORATOR Natives
- Research Workflow and Graph
- Boot and Script Control
- Tools You Need
- Research Tools
- Finding Natives
- Global Blocks and Owners
- Pickups Data
- Economy and Gameplay Index
- PlayerAndWorld Example
- Phase 4 Story Batches
- FIRE and EVENT Natives
- Appearance and Clothing
- Working Method and Stocks
- Business Computer Apps
- Simple Interior System
- File Rules
- Level Indexes and Testbed
- Launch Table and Flow Controller
- STREAMING Natives
- Swimming and Gameplay Questions
- Weapon Damage Natives
- Cookbook: Missions
- Phase 1 UI Batches
- Stock Company Names
- Server Broadcast Fields
- Property Table and Vehicles
- Issue Template Config
- Cookbook Traps
- OBJECT Natives
- PATH Natives
- PHYSICS Natives
- SCRIPT Natives
- Script Stack Pools
- Key Codes and Controls
- Online Pause Tab
- PAD Natives
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- Task Sequences
- ITEMSETS Natives
- LOCALIZATION Natives
- REPLAY Natives
- SECURITY Natives
- SHAPETEST Natives
- Inbox Template
- SAVEMIGRATION Natives
- Unknown Natives
- Decompile and Launch Graph Tool
- Call-graph Labeller

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 116 edges
2. `Mod map: what to read for the mod you want to make` - 114 edges
3. `Tools` - 80 edges
4. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
5. `The global variable map (R0.4)` - 70 edges
6. `The story mission flow: how missions unlock` - 65 edges
7. `Native namespace map` - 61 edges
8. `Anatomy of a story mission (R5.2)` - 59 edges
9. `Native usage index` - 56 edges
10. `Cutscenes and dialogue (R5.6)` - 53 edges

## Surprising Connections (you probably didn't know these)
- `flow_controller (story missions by hash, mission_stat_watcher)` --semantically_similar_to--> `flow_controller`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/core/runtime-scripts.md
- `270-entry activity table (fmmc_launcher and 265 scripts)` --semantically_similar_to--> `Activity table (270 activities to 260 scripts, in 266 scripts)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/online/job-lobby.md
- `Script brains: 99 world-point and 47 object brains` --semantically_similar_to--> `Script brains`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/gameplay/missions/strangers-and-freaks.md
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `Steps 5/6/7 are alternatives (C#, Lua, C++)` --semantically_similar_to--> `Language-for-job table (XML, C#, Lua, C++, natives, JSON...)`  [INFERRED] [semantically similar]
  modding/README.md → scripting/languages.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **freemode's player broadcast data blocks** — docs_core_global_map_global_1845250, docs_core_global_map_global_2658291, docs_core_global_map_global_1892653, docs_core_global_map_global_1882572, docs_core_global_map_network_register_broadcast [EXTRACTED 1.00]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Three scripts that force strand 27 active for a new game** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Creator prop pipeline: catalogue, save columns, upload, race rebuild** — docs_online_creator_internals_prop_catalogue, docs_online_creator_internals_column_save_format, docs_online_creator_internals_ugc_upload, docs_online_creator_internals_race_prop_rebuild [EXTRACTED 1.00]
- **Creator slider to saved stat pipeline** — docs_gameplay_player_online_character_creator_micro_morph_map, docs_gameplay_player_online_character_creator_heritage, docs_gameplay_player_online_character_creator_slider_to_stat, docs_gameplay_player_online_character_creator_mpstatssetup [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **freemode player state, host state and per-frame running systems** — docs_online_07_freemode_player_state_machine, docs_online_07_freemode_host_state_machine, docs_online_07_freemode_running_state_systems [EXTRACTED 1.00]
- **Ped reaction data chain (personality, decision maker, combat info, relationship group)** — docs_ai_decisions_and_personalities_ped_ai_chain, docs_ai_combat_and_perception_events_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_relationships_and_groups_default_groups [EXTRACTED 1.00]
- **Rockstar's physics-cost controls (freeze, clear, density, disable)** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_area_cleanup, docs_performance_physics_cost_density_multipliers [EXTRACTED 1.00]
- **Strand 27 activated in standard_global_reg, initial and flow_controller** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **Registering add-on content (meta, text, content.xml)** — docs_entities_vehicles_vehicles_add_on_vehicle_pack, docs_entities_objects_text_and_names_dlc_text_registration, docs_entities_peds_peds_add_on_ped [INFERRED 0.75]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Crime to wanted stars to dispatch pipeline** — docs_ai_perception_and_events_can_call_police, docs_ai_wanted_level_and_police_crimeinformation_meta, docs_ai_wanted_level_and_police_points_to_stars, docs_ai_police_and_services_dispatch_meta [INFERRED 0.85]
- **Ambient population system (zones, schedules, scenarios, car generators)** — docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_scenarios_scenario_points, docs_entities_spawning_vehicle_generators_and_traffic_car_generators, docs_entities_spawning_population_zonebind_ymt [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Material-keyed data: physics, fire and effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_effects_data_files [INFERRED 0.85]
- **Rules for mods running beside the VM** — scripting_script_vm_waitpattern, scripting_script_vm_forcecleanup, scripting_natives_engine_api_contracts [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules, _github_workflows_file_rules_file_rules_check [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How Rockstar scripts stay within memory and streaming limits** — docs_core_memory_and_pools_can_register_mission_entities, docs_core_memory_and_pools_population_budgets, scripting_native_usage_streaming_set_model_as_no_longer_needed, docs_core_streaming_request_check_release, docs_core_streaming_polling_not_blocking [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]
- **Phased second pass: UI, core engine, Online, story** — open_questions_phase_1, open_questions_phase_2, open_questions_phase_3, open_questions_phase_4, open_questions_priority_order [EXTRACTED 1.00]
- **Questions that need the executable (engine RE)** — open_questions_engine_reverse_engineering, open_questions_force_cleanup_bits_16_32, open_questions_brain_sets_2_4, open_questions_category_core, docs_core_memory_and_pools, docs_core_saves [INFERRED 0.85]
- **Low-end PC performance measurements by test card** — docs_performance_cpu, docs_performance_graphics_settings, docs_performance_load_times, docs_performance_memory_and_vram, docs_performance_mod_overhead, docs_performance_pc_profiles, docs_performance_windows_and_drivers, open_questions_in_game_test_card [INFERRED 0.85]
- **Story unlock pipeline: build, run and gate strands** — docs_gameplay_missions_story_flow_initial, docs_gameplay_missions_story_flow_flow_program, docs_gameplay_missions_story_flow_flow_controller, docs_gameplay_missions_story_flow_flow_strands, docs_gameplay_missions_story_flow_flow_flags, docs_gameplay_missions_story_flow_mission_triggerers [EXTRACTED 1.00]
- **Stranger entry gating chain** — docs_gameplay_missions_strangers_and_freaks_randomchar_controller, docs_gameplay_missions_strangers_and_freaks_availability_conditions, docs_gameplay_missions_strangers_and_freaks_saved_random_characters, docs_gameplay_missions_strangers_and_freaks_gating_flags, docs_gameplay_missions_strangers_and_freaks_code_controller, docs_gameplay_missions_story_flow_activate_stranger_mission [EXTRACTED 1.00]
- **Three systems called replay** — docs_gameplay_missions_replay_director_and_editor_replay_controller, docs_gameplay_missions_replay_director_and_editor_clip_recorder, docs_gameplay_missions_replay_director_and_editor_director_mode, docs_gameplay_missions_replay_director_and_editor_rockstar_editor [EXTRACTED 1.00]
- **Mission fail, retry and checkpoint restore flow** — docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_running_mission_list, docs_gameplay_missions_mission_anatomy_replay_controller, docs_gameplay_missions_mission_anatomy_retry_screen_states, docs_gameplay_missions_mission_anatomy_player_snapshot, docs_gameplay_missions_mission_anatomy_checkpoint_recording [EXTRACTED 1.00]
- **Activity launch flow (unlock bit, launcher, candidate slot, telemetry)** — docs_gameplay_missions_minigames_and_activities_activity_unlock_bits, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_minigames_and_activities_mission_candidate, docs_gameplay_missions_minigames_and_activities_force_cleanup_8, docs_gameplay_missions_minigames_and_activities_playstats_oddjob_done [EXTRACTED 1.00]
- **Scripted conversation request pipeline** — docs_gameplay_missions_cutscenes_and_dialogue_dialogue_request_globals, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler_states, docs_gameplay_missions_cutscenes_and_dialogue_conversation_root_labels, docs_gameplay_missions_cutscenes_and_dialogue_create_new_scripted_conversation [EXTRACTED 1.00]
- **Character switch pipeline** — docs_gameplay_player_character_switching_selector, docs_gameplay_player_character_switching_player_controller_b, docs_gameplay_player_character_switching_player_timetable_scene, docs_gameplay_player_character_switching_player_scene_scripts, docs_gameplay_player_character_switching_start_player_switch, docs_gameplay_player_character_switching_change_player_ped [EXTRACTED 1.00]
- **Story death/arrest restart flow** — docs_gameplay_player_respawn_death_and_arrest_standard_global_init, docs_gameplay_player_respawn_death_and_arrest_hospital_restarts, docs_gameplay_player_respawn_death_and_arrest_police_restarts, docs_gameplay_player_respawn_death_and_arrest_respawn_controller, docs_gameplay_player_respawn_death_and_arrest_death_fee, docs_gameplay_player_respawn_death_and_arrest_arrest_penalty, docs_gameplay_player_respawn_death_and_arrest_respawn_resets, docs_gameplay_player_respawn_death_and_arrest_pause_death_arrest_restart [EXTRACTED 1.00]
- **Skill system data flow** — docs_gameplay_player_skills_and_abilities_spstatssetup_xml, docs_gameplay_player_skills_and_abilities_playerinfo_ymt, docs_gameplay_player_skills_and_abilities_stats_controller, docs_gameplay_player_skills_and_abilities_seven_skills, docs_gameplay_player_skills_and_abilities_skill_growth_formula [EXTRACTED 1.00]
- **Property purchase and trade-in flow** — docs_online_properties_layered_property_pricing, docs_online_properties_net_gameserver_get_price, docs_online_properties_trade_in_half_refund, docs_online_properties_network_earn_from_property, docs_online_properties_network_buy_property [EXTRACTED 1.00]
- **Simple interior launch chain (ext -> int -> type script)** — docs_online_properties_am_mp_smpl_interior_ext, docs_online_properties_am_mp_smpl_interior_int, docs_online_properties_simple_interior_type_scripts, docs_online_properties_simple_interiors [EXTRACTED 1.00]
- **Heist planning scripts per generation** — docs_online_heists_fmmc_launcher, docs_online_heists_gb_gang_ops_planning, docs_online_heists_gb_casino_heist_planning, docs_online_heists_heist_island_planning [EXTRACTED 1.00]
- **Server-side dependencies an offline Online must replace** — docs_online_stats_and_tunables_tuneables_processing, docs_online_stats_and_tunables_mpstatssetup_xml, docs_online_stats_and_tunables_transaction_basket, docs_online_rockstar_services_cloud_stat_slots, docs_online_rockstar_services_ros_credentials, docs_online_rockstar_services_ugc_service, docs_online_stats_and_tunables_offline_online_replacement [INFERRED 0.85]
- **Job launch flow from lobby to running controller** — docs_online_job_lobby_fmmc_launcher, docs_online_job_lobby_lobby_state_flags, docs_online_job_lobby_activity_table, docs_online_job_lobby_mission_controller_selection, docs_online_job_lobby_start_argument_block, docs_online_job_lobby_job_controllers, docs_online_job_lobby_net_cloud_mission_loader [EXTRACTED 1.00]
- **Cosmetic shop scripts launched by shop_controller** — docs_gameplay_player_online_cosmetic_shops_shop_controller, docs_gameplay_player_online_cosmetic_shops_hairdo_shop_mp, docs_online_stats_and_tunables_clothes_shop_mp, docs_gameplay_player_online_cosmetic_shops_tattoo_shop, docs_gameplay_player_online_cosmetic_shops_cosmetic_stats [EXTRACTED 1.00]
- **Boot chain: startup to main_persistent** — docs_core_runtime_scripts_startup, docs_core_runtime_scripts_registration_scripts, docs_core_runtime_scripts_standard_global_init, docs_core_runtime_scripts_standard_global_reg, docs_core_runtime_scripts_main_persistent [EXTRACTED 1.00]
- **Story to Online handover** — docs_core_runtime_scripts_selector, docs_core_runtime_scripts_maintransition, docs_core_runtime_scripts_force_cleanup_bits, docs_core_runtime_scripts_freemode, docs_core_runtime_scripts_network_safe_flag [EXTRACTED 1.00]
- **One story mission at a time** — docs_core_runtime_scripts_mission_stack, docs_core_runtime_scripts_current_mission_type, docs_core_runtime_scripts_mission_triggerers, docs_core_runtime_scripts_director_mode [INFERRED 0.85]
- **Story money booking flow** — docs_gameplay_economy_economy_and_pickups_change_money_helper, docs_gameplay_economy_economy_and_pickups_sp_total_cash, docs_gameplay_economy_economy_and_pickups_money_spent_stats, docs_gameplay_economy_economy_and_pickups_respawn_controller, docs_gameplay_economy_economy_and_pickups_stat_set_int [EXTRACTED 1.00]
- **Story stock market system** — docs_gameplay_economy_economy_and_pickups_stock_controller, docs_gameplay_economy_economy_and_pickups_bawsaq, docs_gameplay_economy_economy_and_pickups_lcn, docs_gameplay_economy_economy_and_pickups_finance_saved_array, docs_gameplay_economy_economy_and_pickups_stock_events, docs_gameplay_economy_economy_and_pickups_sm_stats [EXTRACTED 1.00]
- **Second-pass state tracking documents** — handoff, data_needs, open_questions, claude [INFERRED 0.85]

## Communities (137 total, 8 thin omitted)

### Community 0 - "Repo Overview and Guides"
Cohesion: 0.04
Nodes (100): The AI architecture, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks, Task pool of 8,192 running tasks (gameconfig.xml), Task system: everything a ped does is a task (CTask classes, nested) (+92 more)

### Community 1 - "Story Flow and Strangers"
Cohesion: 0.05
Nodes (73): Global_80551 (flow program), Global_93192 (story mission table), Mission triggerer lead-in scenes, Pause-menu Replay Mission (pausemenu_sp_repeat, mission_repeat_controller), The story mission flow: how missions unlock, Activate strand command, Activate stranger mission command, agency_heist2 special builder (+65 more)

### Community 2 - "Performance and Measuring"
Cohesion: 0.05
Nodes (60): CPU: population, AI, physics and scripts, Population density as biggest lever, Game threads (24, Update TIME_CRITICAL), Open questions (CPU), Heavily modded install script load (52 + 61), 15 W laptop throttling, Graphics settings, one by one, commandline.txt launch switches (+52 more)

### Community 3 - "Saves, Autosave, Completion"
Cohesion: 0.06
Nodes (52): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values), Autosave requesters (220 scripts via the shared helper) (+44 more)

### Community 4 - "PED and PLAYER Natives"
Cohesion: 0.08
Nodes (57): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+49 more)

### Community 5 - "Population and Traffic"
Cohesion: 0.06
Nodes (51): LOD settings (LodScale, MaxLodScale), Population and model budgets, Objects, Text and names in content, DLC text registration (dlctext.meta, TEXTFILE_METAFILE), global.gxt2 text tables, Name lookup natives (GET_DISPLAY_NAME_FROM_VEHICLE_MODEL), Behaviour by reference (personality, combat info, decision maker) (+43 more)

### Community 6 - "Skills, Stats and Flying"
Cohesion: 0.08
Nodes (51): Flying, AI flight tasks, Script aircraft natives, CTaskParachute tunables (movementtasks.ymt), Story flight school pilot_school, CFlyingHandlingData block, handling.meta (22 base aircraft), LAZER (highest thrust, lowest glide) (+43 more)

### Community 7 - "Vehicle and World Physics"
Cohesion: 0.05
Nodes (49): Weapons (folder README), CLEAR_AREA cleanup before and after set pieces, Freeze by default (FREEZE_ENTITY_POSITION), Proposed physics budgets for a low-end PC, Physics pools (phInstGta, StaticBounds, FragmentStore ...), Background programs as biggest Windows-side cost, Collision, materials and shape tests, Collision loading around the focus (+41 more)

### Community 8 - "Archives, Streaming, Memory"
Cohesion: 0.06
Nodes (44): Crowd thinning natives (density, non-creation area, suppress), Navmesh required region and blocking objects, Online venue peds (am_mp_peds etc.), Ambient speech voices (full and mini), Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list (+36 more)

### Community 9 - "Mod Map and Data Atlas"
Cohesion: 0.06
Nodes (43): Interiors and IPLs, building_controller and maintransition IPL swaps, Interior entity sets, REQUEST_IPL / REMOVE_IPL, Opening Online interiors in story mode, Map data, dlc_patch map replacement, ymap placement files (+35 more)

### Community 10 - "Toolbox and Repo Tools"
Cohesion: 0.06
Nodes (35): Pull request template, Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Tools and resources (toolbox), Claude Code (AI assistance) and skills, CodeWalker, Community decompile (GTA-V-Decompiled-Scripts), Contributed tools and resources table, Workflow: grouping DISABLE_CONTROL_ACTION runs (+27 more)

### Community 11 - "Setup and Requirements"
Cohesion: 0.07
Nodes (35): Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads (+27 more)

### Community 12 - "Online Broadcast Blocks"
Cohesion: 0.06
Nodes (36): 37 broadcast blocks by registered name (15 player, 18 host, 4 job), freemode (registers 33 broadcast blocks: 15 player, 18 host), Global_1057198 g_sMC_serverBDEndJob (end of job) (host broadcast block), Global_1689064 GlobalServerBD_DM (host broadcast block), Global_1873411 GPBD_MissionName (player broadcast block), Global_1873924 GPBD_Kicking (vote kicks) (player broadcast block), Global_1877125 GSBD_Kicking (host broadcast block), Global_1877158 GPBD_FM_HeistPlanning (player broadcast block) (+28 more)

### Community 13 - "Native Namespace Index"
Cohesion: 0.19
Nodes (36): Native namespace map, MISC namespace is a junk drawer, Decompiler vs NativeDB namespace names (CAM=CAMERA...), Native namespace coverage map (R0.8), 45 named namespaces + 2 unknown natives, AUDIO natives used by the game scripts, CAMERA natives used by the game scripts, ENTITY natives used by the game scripts (+28 more)

### Community 14 - "Peds, Animation, Ragdoll"
Cohesion: 0.07
Nodes (33): Peds, Add-on ped requirements, Ped name prefixes (a_, ig_, s_, csb_ ...), Special abilities on the model (AbilityType), Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file (+25 more)

### Community 15 - "Minigames and Activities"
Cohesion: 0.11
Nodes (34): Minigames and activities (R5.5), Activity id list 0-18, Activity unlock bits (flow bitset ID 0), am_mp_arc_cab_manager, code_controller code entries, Darts (301 per leg), Activity fees and pay, Flight school medals (pilot_school) (+26 more)

### Community 16 - "Story Mission Anatomy"
Cohesion: 0.15
Nodes (31): Global_102466/108447/96580/96581 (checkpoint, snapshot, skip), FORCE_CLEANUP(8), Mission candidate slot, mission_stat_watcher script, Anatomy of a story mission (R5.2), armenian1 (Franklin and Lamar), Checkpoint recording (func_893 / func_680 / func_580), Heist crew skill tiers and the take (+23 more)

### Community 17 - "Cutscenes and Dialogue"
Cohesion: 0.12
Nodes (31): Freemode models and head blend, Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A) (+23 more)

### Community 18 - "Modding Start Guide"
Cohesion: 0.10
Nodes (26): handling.meta, CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, Data mods vs script mods, Per-frame script loop, 3. Install the basics and check they load, Verify install via asiloader/ScriptHookV/SHVDN logs (+18 more)

### Community 19 - "Time, Weather, MISC Natives"
Cohesion: 0.07
Nodes (32): Time, weather and wind, Game clock natives, Online clock override, respawn_controller weather reroll, WeatherCycles fixed list, Persistent weather lock natives, weather.xml (types, cycles, GPU fx), Wind (WindMin/WindMax, SET_WIND) (+24 more)

### Community 20 - "Props, Rendering, Effects"
Cohesion: 0.07
Nodes (32): IPLs (optional map sections), Props, archetypes and doors, Archetype definition, Door auto-open flags, Door system (ADD_DOOR_TO_SYSTEM), doortuning.meta, Rayfire destruction objects, Static vs dynamic and breakable props (+24 more)

### Community 21 - "Global Variable Map"
Cohesion: 0.14
Nodes (29): The global variable map (R0.4), Global reference count (git grep, 5,151 distinct bases), Global_22983/22602/21591 (dialogue request and state), Global_2658291[p].f_325.f_11: interior owner, Global_2658291[p].f_325: interior the player is in, Global_102154 (three characters' current outfits), Global_102429 (replay controller state), Global_102481 (shop data) (+21 more)

### Community 22 - "VEHICLE Natives"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 23 - "Script VM and Natives"
Cohesion: 0.08
Nodes (29): Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED), Contracts Rockstar keeps (request, release, create, clean up), Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT), START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, What each native family can't do, Handle guards (DOES_ENTITY_EXIST, IS_ENTITY_DEAD), Slow, heavy or risky natives (+21 more)

### Community 24 - "NETWORK Natives"
Cohesion: 0.16
Nodes (29): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+21 more)

### Community 25 - "Online DLC Storylines"
Cohesion: 0.11
Nodes (28): DLC storylines in GTA Online, dlclist.xml pack order, When each fm_content_* script arrived (97 scripts by decompile commit), fm_content_* scripts (85-91), Local vs cloud missions (16 on disk, ~980 content files), Open questions (DLC storylines), Phone-call flows (40 call roots in six DLC dialogue blocks), Property intro cutscenes (289 distinct names) (+20 more)

### Community 26 - "TASK Natives"
Cohesion: 0.17
Nodes (27): TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS, TASK native namespace (+19 more)

### Community 27 - "Replay and Director Mode"
Cohesion: 0.14
Nodes (25): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder (engine), Director mode quick-travel locations (27 + 2 user), director_mode, Director mode rules and warnings (CM_WARN01-07), Fail screen labels (REPLAY_RETRY, REPLAY_SKIPM ...), GP-087: engine meaning of replay type number (+17 more)

### Community 28 - "Modding Languages"
Cohesion: 0.09
Nodes (21): Beginner modding path (R12.6), Steps 5/6/7 are alternatives (C#, Lua, C++), 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini (+13 more)

### Community 29 - "Example Mods (C#)"
Cohesion: 0.13
Nodes (4): Samples, NativeCalls, Examples, Six SHVDN v3 C# sample scripts

### Community 30 - "Audio, Speech, Radio"
Cohesion: 0.12
Nodes (23): How audio is organised, Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, 54 sound archives (x64/audio/sfx, .awc), Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Music and radio (+15 more)

### Community 31 - "Menus, Text, HUD"
Cohesion: 0.12
Nodes (24): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, Pause and Online menus (+16 more)

### Community 32 - "Online Heists"
Cohesion: 0.15
Nodes (23): Casino heist crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo Perico primary target weighting, Classic heists (Fleeca, Prison Break, Humane Labs, Series A, Pacific Standard), Classic planning board Scaleform movies (heist_mp, heistmap_mp, heist_pre), The Diamond Casino Heist, The Doomsday Heist, Heist elite challenges (+15 more)

### Community 33 - "Camera, Audio, Cutscene Natives"
Cohesion: 0.09
Nodes (23): GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CREATE_CAM, DO_SCREEN_FADE_IN (+15 more)

### Community 34 - "AI Layers and Glossary"
Cohesion: 0.10
Nodes (22): Community decompile repository (one commit per build), Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts), Glossary, ASI, ScriptHookV, ScriptHookVDotNet, Broadcast data (player and host synced globals), Decision maker: event to ped reaction table, Global block: shared script memory owned by a registration script, Glossary of modding and engine terms (+14 more)

### Community 35 - "Freemode and Sessions"
Cohesion: 0.14
Nodes (22): Inside freemode (first pass), Player/server broadcast data globals, freemode_init, freemode (GTA Online main script), Host state machine (0,4,5), 29 helper scripts launched by freemode, 60 network event types (queue 1, ids 151-249), Open questions (freemode) (+14 more)

### Community 36 - "Online Properties"
Cohesion: 0.13
Nodes (20): freemode, Nightclub popularity and safe pay bands, am_mp_property_ext, am_mp_yacht, ambient_mp.ipl, Property entry checks (wanted, mission objective, garage full, trailer), freemode, Garage sizes per ownership slot (freemode function) (+12 more)

### Community 37 - "Online Cosmetic Shops"
Cohesion: 0.20
Nodes (21): Online cosmetics and the shops that sell them (R6.7), 512 priced barber items, Barber menu pages (Hairstyles, Beards, Eyebrows, Chest, Contacts, Face Paints, Makeup), Barber rank locks (HAIR_UNLOCK), Clothes store browse spots and interiors (v_clotheslo/mid/hi), Clothing catalogue (36,232 items in 86 *_shop.meta files), Contact lenses as eye colour (SET_HEAD_BLEND_EYE_COLOR), Hair fades (NG_M_Hair_001, multiplayer_overlays, hairOverlay) (+13 more)

### Community 38 - "Job Lobby"
Cohesion: 0.22
Nodes (20): am_pi_menu (interaction menu), Interaction menu tree (144 pages, 1,203 items), The job lobby (fmmc_launcher, R7.5), Activity table (270 activities to 260 scripts, in 266 scripts), Corona (job lobby screens), Corona settings flow (GPBD_FM_2 to Global_2685150.f_669), End-of-job rating and next-job vote (FM_NXT_*), Loaded job FMMC structure (Global_4718592) (+12 more)

### Community 39 - "File-rules Workflow Steps"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 40 - "Script Launch Graph"
Cohesion: 0.24
Nodes (20): Script launch graph (build 3725), Activity launchers' own names (golf, darts, triathlon, pilot school ...), 270-entry activity table (fmmc_launcher and 265 scripts), Backbone diagram, Online, Backbone diagram, story mode, Script brains: 99 world-point and 47 object brains, cellphone_flashhand (55 callers, starts phone-slot apps), Started by the engine (startup at boot; main and initial for a story game) (+12 more)

### Community 41 - "Roadmap and Contributing"
Cohesion: 0.13
Nodes (16): Issue template: Claim a research topic, Claim a research topic issue template, Branch naming (research/<ID>-pass2-<what> ...), Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass) (+8 more)

### Community 42 - "Controls and Camera"
Cohesion: 0.16
Nodes (19): Control ID renumbering in build 3717 (+37 from 257), Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+11 more)

### Community 43 - "Stats and Tunables"
Cohesion: 0.18
Nodes (19): Clothing price lookup by textLabel (17,411 cases, tunables), Cosmetic save stats (CLTHS_*, DLC_APPAREL_ACQUIRED, TATTOO_FM_UNLOCKS, CHAR_FM_STORED_HAIRDO), Rebuild shops in a mod rather than launching Rockstar's, Tunables cloud service, Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, Hash-only tunables (7,296; 311 recovered), mpstatssetup.xml (17,928 Online stats) (+11 more)

### Community 44 - "MONEY and Shop Natives"
Cohesion: 0.11
Nodes (18): Native changes 3725 to 3889, 0x0F7082C60FB479EF (creator budget cost), MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC (+10 more)

### Community 45 - "Example Mod Classes"
Cohesion: 0.13
Nodes (4): HelloWorld, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 46 - "Organisations and Businesses"
Cohesion: 0.16
Nodes (17): tuneables_processing, Acid lab, am_pi_menu (interaction menu), appbusinesshub, Biker businesses (weed, documents, cash, meth, cocaine), Boss registration (gb_bosscost unused, registering free), Bunker manufacturing and research, Business loop: supplies, production, stock, sell (+9 more)

### Community 47 - "Scaleform and Story UI"
Cohesion: 0.13
Nodes (17): pausemenu.xml menu description, Scaleform movies, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), DLC movies (mpheist, mpapartment), Scaleform .gfx archives, Interior map movies (int<hash>.gfx), Request-wait-call-draw-release pattern, Movie method names from ActionScript (+9 more)

### Community 48 - "Server-backed Online Screens"
Cohesion: 0.16
Nodes (15): Server-backed Online screens (R8.5), appinternet (in-game websites), Busy spinners and warning screens, NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, Engine-filled network pages (friends, crews, party, store, invites), What a local replacement would need, NET_GAMESERVER_IS_SESSION_VALID, Transaction server NET_GAMESERVER_* (+7 more)

### Community 49 - "Signed-out Screen Guards"
Cohesion: 0.15
Nodes (17): am_contact_requests, appbusinesshub (business computer), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED), ingamehud (Online HUD), Map page paid-action check refuses when signed out (+9 more)

### Community 50 - "Cookbooks: Menus, Shops, UI"
Cohesion: 0.13
Nodes (11): Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu, Cookbook: shops, Pattern: story-mode shop, Per-character cash stats SP0_TOTAL_CASH, Cookbook: UI and HUD, frontend.xml and hudcolor.dat (+3 more)

### Community 51 - "Data Needs Checklist"
Cohesion: 0.13
Nodes (16): DATA-NEEDS.md (questions needing game files), Animation, cameras, effects, timecycle data needs, Character appearance and shops data needs, Audio data needs (.rel, .awc), cameras.ymt, Engine config and archives data needs (gameconfig.xml, listings), gameconfig.xml, handling.meta (+8 more)

### Community 52 - "Runtime Scripts and Mission Type"
Cohesion: 0.17
Nodes (14): Runtime scripts guide (R0.2, R0.5), code_controller (delayed-action scheduler), Current mission type global (Global_44869, CORE-033), director_mode, flow_controller, Force-cleanup bits (FORCE_CLEANUP / HAS_FORCE_CLEANUP_OCCURRED), initial script, Script launch graph, first pass (R0.5) (+6 more)

### Community 53 - "MainTransition and Creator"
Cohesion: 0.16
Nodes (14): benchmark, Force cleanup bits (2, 8, 64, 1, 128), freemode (MP_LAUNCH_SCRIPT stack), MainTransition, Other boot paths (benchmark, Rockstar Editor, director mode), selector, SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE (BG_SCRIPT_KICK), TRANSITION stack 8,032 and MP_LAUNCH_SCRIPT stack 35,250 (+6 more)

### Community 54 - "Respawn, Death, Arrest"
Cohesion: 0.23
Nodes (15): PP_INFO_STRUCT per-character saved state, Respawn, death and arrest (R6.2), Arrest penalty: up to $300 and weapons cleared, Death fee: 5% of cash, max $5,000, exile_city_denial, 5 hospital restart points (ADD_HOSPITAL_RESTART), mission_repeat_controller, Online respawn (NETWORK_START_RESPAWN_SEARCH, NETWORK_RESURRECT_LOCAL_PLAYER) (+7 more)

### Community 55 - "Online Character Creator"
Cohesion: 0.18
Nodes (15): The Online character creator, Apparel (64 outfits per sex, crew T-shirt, crew emblem), Appearance change fee and cooldown (100,000, 48 minutes), 63 saved creator stats (62 server-authoritative), Seven skill stats with 100-point pool, 32 eye colours (FACE_E_C_0 to 31), Head blend natives (SET_PED_HEAD_BLEND_DATA, FINALIZE_HEAD_BLEND), Heritage head blend (+7 more)

### Community 56 - "Rockstar Creator Internals"
Cohesion: 0.23
Nodes (15): Rockstar Creator internals: how tracks and maps are built from props, Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Job type and subtype table, Mission Creator limits (public_mission_creator), Open questions (creator) (+7 more)

### Community 57 - "Transitions and Sessions"
Cohesion: 0.26
Nodes (15): FM_Maintain_Transition_Players, Cloud stat slots (STAT_SLOT_IS_LOADED), Transitions and sessions (R7.2), freemode_clearGlobals (31 reset steps), ingamehud connection-problem warnings, maintransition (transition state machine script), NETWORK_IS_GAME_IN_PROGRESS (905 scripts), Offline-mode branch (unreachable in build 3725) (+7 more)

### Community 58 - "Menus with LemonUI"
Cohesion: 0.15
Nodes (15): LemonUI, 07 Legacy: SHVDN v2 and NativeUI, NativeUI 1.9.0, NativeUI to LemonUI mapping, Porting v2 mod to v3, Old "v1" name redirected to v2, v2 vs v3 API differences, GUI.lua button menu library (+7 more)

### Community 59 - "Open Questions Tracker"
Cohesion: 0.21
Nodes (14): Open questions: the second pass (tracker), Aim assist and lock-on for the player (AI-013, GP-080), Batch kind: scripts, data, test, engine, Batch status values (Open, In progress, Partly done, Done), Ped brain sets 2 and 4 (ON-059, CORE-031), Scripting questions (SCR-, 14), Engine reverse engineering (the executable), Force-cleanup bits 16 and 32 (engine-raised; CORE-032, ON-060, SCR-011) (+6 more)

### Community 60 - "HUD, DATAFILE, APPS Natives"
Cohesion: 0.13
Nodes (15): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+7 more)

### Community 61 - "WEAPON and ZONE Natives"
Cohesion: 0.13
Nodes (15): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+7 more)

### Community 62 - "Handoff and AI Instructions"
Cohesion: 0.18
Nodes (8): CLAUDE.md (AI assistant instructions), Natives as the script-engine interface, RPF data layout (common.rpf, update.rpf, dlcpacks, dlc_patch), HANDOFF.md (second pass, end of phase 4), Branch main-km1sze (phase 4 work), P4.10 skills, flying and weapons, P4.9 controls renumbering (build 3717, INPUT_CREATOR_*), Resources-to-have-ready checklist

### Community 63 - "Persistent Controller Scripts"
Cohesion: 0.16
Nodes (14): building_controller (IPL world states), cellphone_controller, error_listener, freemode, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, InGameHud, main_persistent, maintransition (story to Online) (+6 more)

### Community 64 - "Weapons Data and Unlocks"
Cohesion: 0.15
Nodes (12): Asset dependency list, dlclist.xml, Stale modded update.rpf, Weapons guide (R3.1), CAimingInfo and lock-on (LockOnRange), CAmmoInfo and shared ammo pools (AmmoMax), Weapon components and clips, GIVE_WEAPON_TO_PED (+4 more)

### Community 65 - "Script Catalogs"
Cohesion: 0.16
Nodes (14): Script catalog: story mode and shared scripts, 86 scripts empty in release, 37 launcher scripts, 12 groups of 584 story and shared scripts, Scripts marked to check, wardrobe_sp and wardrobe_mp, Script catalog (Online), Biggest Online scripts (+6 more)

### Community 66 - "Rockstar Services"
Cohesion: 0.25
Nodes (14): am_contact_requests (Online contact services), Rockstar services (R15.2), Cloud files (NETWORK_IS_CLOUD_AVAILABLE), Crews (NETWORK_CLAN_*), Leaderboards (LEADERBOARDS_WRITE_ADD_COLUMN), Behaviour when a service is missing, Money service (MONEY namespace, 311 natives), Presence (PRESENCE_EVENT_UPDATESTAT_INT, rich presence) (+6 more)

### Community 67 - "Brain Sets and Clashes"
Cohesion: 0.19
Nodes (13): Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems), pb_prostitute ped brains (three hooker models) (+5 more)

### Community 68 - "DLC and Metadata Natives"
Cohesion: 0.14
Nodes (14): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA (+6 more)

### Community 69 - "GRAPHICS and INTERIOR Natives"
Cohesion: 0.14
Nodes (14): GRAPHICS natives used by the game scripts, ANIMPOSTFX_PLAY, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, SET_TIMECYCLE_MODIFIER, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME (+6 more)

### Community 70 - "Decompile and Game Version"
Cohesion: 0.15
Nodes (12): Game version (Legacy 1.0.3725.0), Reading the decompiled game scripts, Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Property table in am_mp_property_ext (index to entrance coordinates), Good scripts to read next, Search with git grep and git show without checkout, Shop purchase on PC: server basket start, add item, checkout (clothes_shop_mp), Globals, func and local numbers change every build (+4 more)

### Community 71 - "Boot Scripts (initial, main)"
Cohesion: 0.19
Nodes (13): director_mode, Engine starts startup, initial and main, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, Global_1 (game started flag), Global_80281, initial script, main, main_persistent and controller_races wait for initial to end, main_persistent (+5 more)

### Community 72 - "Character Switching"
Cohesion: 0.27
Nodes (13): Character switching (R6.1), Arrival scene picker (time blocks, flags, weighted draw), CHANGE_PLAYER_PED, Wheel Online slot (MainTransition), player_controller, player_controller_b, PLAYER_SCENE_SAVED_DATA, player_scene_* arrival scenes (42-entry table) (+5 more)

### Community 73 - "Health and Armour"
Cohesion: 0.24
Nodes (13): Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS, IS_PED_INJURED (903 scripts) (+5 more)

### Community 74 - "Phone and Interaction Menu"
Cohesion: 0.32
Nodes (13): Interaction menu, phone and apps (R7.10), 38 app* scripts (appbusinesshub, appmpjoblistnew, appsecuroserv ...), appinternet (in-game internet), cellphone_controller (phone app table owner), cellphone_flashhand (starts phone app scripts), Is_Sniper_App_Available story save flag, Phone app table (Global_9470 slots), Phone skins (cellphone_ifruit, cellphone_badger, cellphone_facade, cellphone_prologue) (+5 more)

### Community 75 - "Player Broadcast Data"
Cohesion: 0.17
Nodes (11): Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), Who sets each bit of .f_204/.f_203 (shared header, mod shops, jobs, freemode), Global_2658291[p].f_204/.f_203 per-player flag words, 16 named parts of .f_260 (property OWNED stats), Global_1845250[p].f_260 stat-backed state, Global_1845250[p].f_97 bit-field sub-structure, Global_1845250 GPBD_FM (player broadcast data, 880/player), Global_2658291 GlobalplayerBD (player broadcast data, 468/player) (+3 more)

### Community 76 - "Leaderboards and Online Globals"
Cohesion: 0.18
Nodes (12): Global_2097536 (leaderboard rows for display), Global_2686090 (job transition gamer handles), Global_2733002 (interaction-menu local state), am_pi_menu (interaction menu), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780, fmmc_launcher (job lobby and corona), Leaderboard board IDs per screen (39 IDs), Shared leaderboard library (30 scripts) (+4 more)

### Community 77 - "How GTA Online Works"
Cohesion: 0.17
Nodes (12): How GTA Online works, Network session and broadcast data, Script VM, natives, globals, What depends on Rockstar servers, Server transactions for money, Cloud tunables, UGC cloud content and local files, Online data files on disk (+4 more)

### Community 78 - "Prologue Strand and Mission Table"
Cohesion: 0.24
Nodes (10): flow_controller, flowintrotitle, Mission table entry 53 (prologue1) started without a trigger, prologue1 (mission 53), From a new game to prologue1, Strand 27 set active three times (standard_global_reg, initial, flow_controller), 19 story controllers, Story mission table (95 entries) (+2 more)

### Community 79 - "Global Registration Scripts"
Cohesion: 0.24
Nodes (11): Global_3 (boot into Online), Online save block g_savedMPGlobals (5,575 values), startup ready bits 0-2, 14 registration scripts started by startup, sp_dlc_registration, sp_pilotschool_reg, standard_global_reg, startup_positioning (+3 more)

### Community 80 - "Random Events and IPLs"
Cohesion: 0.20
Nodes (10): IPL map section switching, Restricted areas (re_armybase, re_prison), Random events, Area scripts re_armybase/re_prison/re_lossantosintl/re_yetarian, Shared random event launch check, SET_RANDOM_EVENT_FLAG / SET_MISSION_FLAG, re_* random event scripts, World brain points (ambient.ipl) (+2 more)

### Community 81 - "ENTITY and DECORATOR Natives"
Cohesion: 0.18
Nodes (11): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION, GET_ENTITY_COORDS (+3 more)

### Community 82 - "Research Workflow and Graph"
Cohesion: 0.20
Nodes (9): graphify-out exempt paths, Decompile commit 'Update for 1.72-3725.0', graphify knowledge graph (graphify-out/), Using an AI assistant, Research a topic in an hour checklist, Executable reverse-engineering question group, In-game tests question group, Remaining question groups (data, text, executable, in-game, scripts, ask) (+1 more)

### Community 83 - "Boot and Script Control"
Cohesion: 0.20
Nodes (10): Boot and script control (R1.2), LOBBY_AUTO_MULTIPLAYER_* flags, Back to story mode, Boot sequence short version, Launching into Online, Boot open questions, SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME, Boot test cards (+2 more)

### Community 84 - "Tools You Need"
Cohesion: 0.22
Nodes (10): Timeline of one measured launch, Update day checklist (R11.4), ASI loader load chain (dinput8, ScriptHookV), 2. The tools you need, OpenIV, ScriptHookV, ScriptHookVDotNet, Tool paths A-D (data, C#, Lua, C++) (+2 more)

### Community 85 - "Research Tools"
Cohesion: 0.20
Nodes (9): Research tools, After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts, ugc-keys.ps1: key paths in UGC files, ysc-dump.ps1: script headers and strings for all 1,143 scripts (+1 more)

### Community 86 - "Finding Natives"
Cohesion: 0.24
Nodes (10): 05 Native functions, Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument), Finding the native you need, Calling natives from Lua (old names), NativeDB (natives.json), Natives: built-in script functions in namespaces, Old namespace names vs current (GAMEPLAY to MISC, UI to HUD, ...) (+2 more)

### Community 87 - "Global Blocks and Owners"
Cohesion: 0.25
Nodes (9): landing_pre_startup (empty), 146 script brains, standard_global_init, Block owner scripts table (references per block), Blocks 13 and 15: dead code behind two never-set flags, Global_3407872 (block 13, behind Global_2883694), Global_3932160 (block 15, behind Global_2883693), 21 global blocks of 262,144 slots (+1 more)

### Community 88 - "Pickups Data"
Cohesion: 0.22
Nodes (9): Name labels (gameName, vehicleMakeName, HumanNameHash), Shop catalogue files (*_shop.meta), CPickupData, CREATE_PICKUP_ROTATE native, CREATE_PORTABLE_PICKUP native family, DLC_WEAPON_PICKUPS content entries, pickup_controller script, Story pickup 10-minute regeneration (+1 more)

### Community 89 - "Economy and Gameplay Index"
Cohesion: 0.25
Nodes (9): Economy and pickups (R3.9), atm_trigger script, Collectable scripts (letterscraps, spaceshipparts, underwaterpickups), Online money server transactions (NETWORK_EARN_* / NETWORK_SPENT_*), shoprobberies script (shop robbery payouts), Economy, Missions (folder index), Gameplay (+1 more)

### Community 91 - "Phase 4 Story Batches"
Cohesion: 0.22
Nodes (9): Batch P4.1: Story flow, Batch P4.2: Mission anatomy and replay, Batch P4.3: Minigames and activities, Batch P4.4: Strangers and freaks, Batch P4.5: Cutscenes and dialogue, Batch P4.6: Character switching, Batch P4.7: Respawn and health, Batch P4.9: Controls and camera (+1 more)

### Community 92 - "FIRE and EVENT Natives"
Cohesion: 0.22
Nodes (9): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions (+1 more)

### Community 93 - "Appearance and Clothing"
Cohesion: 0.25
Nodes (8): Appearance and clothing, 12 ped component slots and prop anchors, EXTRAMETADATA shop natives, Preload ped variation data, Restriction tags and forced components, Shop scripts (clothes_shop, hairdo_shop, tattoo_shop), Tattoos and decals as decorations, peds.ymt / peds.meta ped model entries

### Community 94 - "Working Method and Stocks"
Cohesion: 0.25
Nodes (7): code_controller script, FINANCE_SAVED_ARRAY, LCN exchange (simulated prices), Story stock events (code_controller entries 192-198), joaat candidate-name hashing, native_tables/ folder of the decompile repository, Unlock chains via code_controller entries

### Community 95 - "Business Computer Apps"
Cohesion: 0.32
Nodes (8): Per-app NET_GAMESERVER transactions and spend/earn natives, appbikerbusiness, appbunkerbusiness, appsecuroserv, Business computer apps and Scaleform movies, NETWORK_EARN_FROM_BUSINESS_PRODUCT, am_mp_property_int, Scripts started by am_mp_property_int (appSecuroServ, appImportExport, appBikerBusiness, carmod_shop, AM_MP_PEDS)

### Community 96 - "Simple Interior System"
Cohesion: 0.25
Nodes (8): am_mp_smpl_interior_ext, AM_MP_SMPL_INTERIOR_INT, Mansions (Tongva Hills, West Vinewood, East Vinewood; interiors 177-179), Restricted mission interiors (43), Simple-interior entrance function tables, The 180 simple interior ids, Per-type interior scripts (AM_MP_BUNKER, AM_MP_HANGAR, AM_MP_NIGHTCLUB ...), Simple interior system (181 SIMPLE_INTERIOR_* names)

### Community 97 - "File Rules"
Cohesion: 0.29
Nodes (6): Blocked extensions list, file-rules check (GitHub workflow), Download-and-run (RISKY) patterns, 500 KB size limit, file-rules check workflow, File rules table

### Community 98 - "Level Indexes and Testbed"
Cohesion: 0.29
Nodes (7): Shared activity-type helper (212 scripts), GET_INDEX_OF_CURRENT_LEVEL, Level index 1 (levels/gta5), Level index 5: network testbed level, Level indexes, common:/data/levels/stripped (stripped.meta), Testbed transition states 39-52 (state 40 LOOK_FOR_FRESH_JOIN_TESTBED)

### Community 99 - "Launch Table and Flow Controller"
Cohesion: 0.33
Nodes (7): script-launch-graph.ps1: launches via git grep, am_mp_drone (33 callers), buddydeathresponse (started by nearly every story mission), flow_controller (story missions by hash, mission_stat_watcher), mission_stat_watcher (started next to every story and stranger mission, 1,828), Regenerate with tools/script-launch-graph.ps1 after a game update, Generated launch table (caller to started scripts with stack)

### Community 100 - "STREAMING Natives"
Cohesion: 0.33
Nodes (7): CAN_REGISTER_MISSION_PEDS/VEHICLES/OBJECTS, HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 101 - "Swimming and Gameplay Questions"
Cohesion: 0.29
Nodes (7): Swimming and diving, Breath 10 to 40 s, stamina 10 to 90 s, Dive and fall heights, SET_PED_MAX_TIME_UNDERWATER literals, Scuba gear outfit for 5 models, Sea edge world limits and 60 s trespass death, Gameplay questions (GP-, 92)

### Community 102 - "Weapon Damage Natives"
Cohesion: 0.29
Nodes (7): Bullet damage model (fall-off, headshot, penetration), CWeaponInfo, DLC weapons (246 more CWeaponInfo), SET_WEAPON_DAMAGE_MODIFIER, WeaponLimitsAdjuster (weapon pool limits), Native namespaces in numbers, PLAYER_ID (most-called native)

### Community 103 - "Cookbook: Missions"
Cohesion: 0.29
Nodes (5): Cookbook: missions, Pattern: mission skeleton (idle, setup, stages, fail, pass, cleanup), Script brain sets disabling, Script mod ideas (11), Category: missions, heists, new stories

### Community 104 - "Phase 1 UI Batches"
Cohesion: 0.29
Nodes (7): Batch P1.1: Pause and Online menus, frontend.xml, Batch P1.2: Text labels: slots, label-name index, update2.rpf blocks, Batch P1.3: HUD blip sprite names and [HD]/[CRT] colours, Batch P1.4: Scaleform movies and interior maps, Batch P1.5: Story-mode UI stat list and medals, Batch P1.6: Server-backed Online screens, Phase 1: the user interface

### Community 105 - "Stock Company Names"
Cohesion: 0.47
Nodes (6): Text (.gxt2) data needs, BAWSAQ exchange (community-stat prices), BSS_BSTR_ company labels, GP-090 stock company names, sm_ stock counter stats (204, 126 counters), stock_controller script

### Community 106 - "Server Broadcast Fields"
Cohesion: 0.40
Nodes (6): Global_1835511 GSBD_FM (host broadcast block), Global_2649159 GSBD (server broadcast data), Global_2650423 GSBD_BlockB (host broadcast block), Global_2652579 GSBD_BlockC (host broadcast block), Busiest server broadcast fields (GSBD.f_2 entity areas, GSBD_BlockB.f_199 ...), GSBD.f_2 networked entity areas (NETWORK_ADD_ENTITY_AREA)

### Community 107 - "Property Table and Vehicles"
Cohesion: 0.33
Nodes (6): appinternet (Dynasty 8, Maze Bank Foreclosures, Warstock), Kosatka submarine, Offices, clubhouses, office garages and vehicle warehouse, Home classes (high-end, medium, low-end, 2/6/10-car garages), 115-entry property table, Vehicles as properties (MOC, Avenger, Terrorbyte, Kosatka)

### Community 108 - "Issue Template Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 109 - "Cookbook Traps"
Cohesion: 0.33
Nodes (3): Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta, Pattern: weapon loadout

### Community 110 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 111 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 112 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 113 - "SCRIPT Natives"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 114 - "Script Stack Pools"
Cohesion: 0.40
Nodes (5): gameconfig.xml PoolSizes, gameconfig.xml, Script stack pools (ConfigScriptStackSizes), START_NEW_SCRIPT, Stack sizes passed per launch

### Community 115 - "Key Codes and Controls"
Cohesion: 0.60
Nodes (5): Key codes and control IDs, Frontend control IDs 187-217, TrainerV trainerv.ini [KeyBindings], Windows virtual-key codes (keyboard), The player (folder README)

### Community 116 - "Online Pause Tab"
Cohesion: 0.40
Nodes (5): Credits & Legal tunable Global_262145.f_9321, Jobs and Playlists UGC lists, Online Options settings (PM_SETTING_*), The ONLINE tab, 22 entries, One mode (func_307 returns 2) hides most ONLINE tab entries

### Community 117 - "PAD Natives"
Cohesion: 0.40
Nodes (5): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace

### Community 118 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 119 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 120 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 121 - "Task Sequences"
Cohesion: 0.50
Nodes (4): Native (engine function identified by 64-bit hash; ~6,700), How scripts give tasks: give once and poll GET_SCRIPT_TASK_STATUS, Sequence tasks: OPEN/CLOSE_SEQUENCE_TASK, TASK_PERFORM_SEQUENCE, FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts) and LOD multiplier natives

### Community 122 - "ITEMSETS Natives"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 123 - "LOCALIZATION Natives"
Cohesion: 0.50
Nodes (4): LOCALIZATION natives used by the game scripts, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type

### Community 124 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 125 - "SECURITY Natives"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 126 - "SHAPETEST Natives"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 127 - "Inbox Template"
Cohesion: 0.67
Nodes (3): Issue template: Inbox, Inbox issue template (found a system no topic covers), Inbox for topics nobody covers

### Community 128 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

### Community 129 - "Unknown Natives"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

## Knowledge Gaps
- **642 isolated node(s):** `material_override_pairs.dat`, `procedural.meta (procedural grass/plants)`, `Shape test collision-layer flags`, `Shape tests (START_SHAPE_TEST_*)`, `Explosion damage falloff (centre to edge)` (+637 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 722 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Roadmap and Contributing` to `Repo Overview and Guides`, `Performance and Measuring`, `Saves, Autosave, Completion`, `Population and Traffic`, `Skills, Stats and Flying`, `Vehicle and World Physics`, `Archives, Streaming, Memory`, `Mod Map and Data Atlas`, `Setup and Requirements`, `Native Namespace Index`, `Peds, Animation, Ragdoll`, `Minigames and Activities`, `Story Mission Anatomy`, `Cutscenes and Dialogue`, `Modding Start Guide`, `Time, Weather, MISC Natives`, `Props, Rendering, Effects`, `Global Variable Map`, `Script VM and Natives`, `Online DLC Storylines`, `Modding Languages`, `Audio, Speech, Radio`, `Menus, Text, HUD`, `Freemode and Sessions`, `Online Cosmetic Shops`, `Job Lobby`, `Script Launch Graph`, `Controls and Camera`, `Stats and Tunables`, `Scaleform and Story UI`, `Respawn, Death, Arrest`, `Online Character Creator`, `Rockstar Creator Internals`, `Transitions and Sessions`, `Open Questions Tracker`, `Handoff and AI Instructions`, `Script Catalogs`, `Rockstar Services`, `Brain Sets and Clashes`, `Decompile and Game Version`, `Character Switching`, `Health and Armour`, `Phone and Interaction Menu`, `How GTA Online Works`, `Random Events and IPLs`, `Research Tools`, `Economy and Gameplay Index`, `Appearance and Clothing`, `Swimming and Gameplay Questions`, `Inbox Template`?**
  _High betweenness centrality (0.241) - this node is a cross-community bridge._
- **What connects `material_override_pairs.dat`, `procedural.meta (procedural grass/plants)`, `Shape test collision-layer flags` to the rest of the system?**
  _642 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Repo Overview and Guides` be split into smaller, more focused modules?**
  _Cohesion score 0.040792079207920794 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Mod Map and Data Atlas` to `Repo Overview and Guides`, `Story Flow and Strangers`, `Performance and Measuring`, `Saves, Autosave, Completion`, `Population and Traffic`, `Skills, Stats and Flying`, `Vehicle and World Physics`, `Archives, Streaming, Memory`, `Toolbox and Repo Tools`, `Peds, Animation, Ragdoll`, `Minigames and Activities`, `Story Mission Anatomy`, `Cutscenes and Dialogue`, `Modding Start Guide`, `Time, Weather, MISC Natives`, `Props, Rendering, Effects`, `Global Variable Map`, `Script VM and Natives`, `Online DLC Storylines`, `Modding Languages`, `Example Mods (C#)`, `Audio, Speech, Radio`, `Menus, Text, HUD`, `AI Layers and Glossary`, `Job Lobby`, `Script Launch Graph`, `Roadmap and Contributing`, `Controls and Camera`, `Scaleform and Story UI`, `Cookbooks: Menus, Shops, UI`, `Respawn, Death, Arrest`, `Rockstar Creator Internals`, `Menus with LemonUI`, `Weapons Data and Unlocks`, `Script Catalogs`, `Decompile and Game Version`, `Character Switching`, `Health and Armour`, `Tools You Need`, `Finding Natives`, `Economy and Gameplay Index`, `Appearance and Clothing`, `Swimming and Gameplay Questions`, `Cookbook: Missions`, `Cookbook Traps`, `Key Codes and Controls`?**
  _High betweenness centrality (0.167) - this node is a cross-community bridge._
- **Should `Story Flow and Strangers` be split into smaller, more focused modules?**
  _Cohesion score 0.05477477477477478 - nodes in this community are weakly interconnected._
- **Why does `Native usage index` connect `Native Namespace Index` to `Repo Overview and Guides`, `PED and PLAYER Natives`, `Skills, Stats and Flying`, `Peds, Animation, Ragdoll`, `Time, Weather, MISC Natives`, `VEHICLE Natives`, `NETWORK Natives`, `TASK Natives`, `Camera, Audio, Cutscene Natives`, `Roadmap and Contributing`, `HUD, DATAFILE, APPS Natives`, `WEAPON and ZONE Natives`, `DLC and Metadata Natives`, `GRAPHICS and INTERIOR Natives`, `ENTITY and DECORATOR Natives`, `Research Tools`, `FIRE and EVENT Natives`, `ITEMSETS Natives`, `LOCALIZATION Natives`?**
  _High betweenness centrality (0.109) - this node is a cross-community bridge._
- **Should `Performance and Measuring` be split into smaller, more focused modules?**
  _Cohesion score 0.05432692307692308 - nodes in this community are weakly interconnected._