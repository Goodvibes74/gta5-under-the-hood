# Graph Report - gta5-under-the-hood  (2026-10-30)

## Corpus Check
- 245 files · ~430,661 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 3 file(s) not represented in the graph (top: (none) 3)

## Summary
- 2652 nodes · 6430 edges · 158 communities (150 shown, 8 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 521 edges (avg confidence: 0.81)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- DLC Packs and Vehicles (2)
- Ped Health and Death
- Handling and How Mods Work
- Native Usage Index
- Globals and Save Data (2)
- TASK Natives
- Globals and Save Data 3
- Minigames and Activities 2
- Rockstar Creator (2)
- Globals and Save Data
- Globals and Save Data (2) (2)
- Boot and Script Control 4
- DLC Packs and Vehicles
- Time Weather Wind
- C# Example Mods
- Combat and AI Tuning (2)
- Rockstar Creator
- Online UI Screens
- Economy and Pickups 2
- Boot and Script Control 3
- Ambient Life
- Freemode Internals
- Navigation and Streaming (2)
- APPS and DATAFILE Natives
- Ambient Life (2)
- Story Mission Anatomy
- Online Properties
- HUD Colours and Blips
- Combat and AI Tuning
- Economy and Pickups
- Minigames and Activities 2 (2)
- Rockstar Creator (3)
- Online Properties (2)
- Online DLC Storylines (3)
- Story Mission Anatomy (3)
- Weapons
- Physics Cost and Cleanup (2)
- Boot and Script Control 2 (2)
- Audio System
- Story Mission Anatomy (2)
- Story vs Online Scripts
- Story vs Online Scripts (2)
- Performance and Script Load (5)
- Combat and AI Tuning (2)
- Story Mission Anatomy (2) (2)
- Globals and Save Data 3 (2)
- Online DLC Storylines (2)
- Performance and Script Load (2)
- Driving AI
- AUDIO Natives
- BRAIN and BUILTIN Natives
- Physics Cost and Cleanup (2) (2)
- File-rules Workflow
- Natives as Engine API
- Issue and PR Templates
- RPF Archives and Music Mods (3)
- Economy and Pickups (2)
- How GTA Online Works (2)
- RPF Archives and Music Mods
- Repo Rules and Workflow
- Credits and File Rules
- Minigames and Activities 2 (3)
- Story Mission Anatomy (3) (2)
- Time Weather Wind (2)
- Strangers and Side Content (2)
- WEAPON Natives
- RPF Archives and Music Mods (2)
- HUD Colours and Blips (4)
- SHVDN Scripting Guide
- Natives as Engine API (2)
- Boot and Script Control
- RPF Archives and Music Mods (2) (2)
- Online DLC Storylines
- Rendering and LOD (2)
- RPF Archives and Music Mods (2)
- Repo Rules and Workflow 2
- Credits and File Rules (2)
- Ambient Life (3)
- Ambient Life (3) (2)
- Weapons (2)
- Story Mission Anatomy (2) (2)
- How GTA Online Works
- Navigation and Streaming
- RPF Archives and Music Mods (4)
- SHVDN Scripting Guide (2)
- Example Mod Classes
- Combat and AI Tuning (3)
- Combat and AI Tuning (4)
- Ambient Life (3) (3)
- Performance and Script Load (3)
- Ambient Life (4)
- HUD Colours and Blips (5)
- Script VM Contracts 2
- Issue and PR Templates 2
- Issue and PR Templates (2)
- Repo Rules and Workflow (2)
- Strangers and Side Content
- Ambient Life (2) (2)
- Navigation and Streaming (2) (2)
- Natives as Engine API (2)
- Online UI Screens (2)
- Ambient Life (3) (4)
- RPF Archives and Music Mods (5)
- Performance and Script Load (4)
- Rendering and LOD (2) (2)
- Rendering and LOD
- HUD Colours and Blips (2)
- Example Mod Classes (2)
- DLC and EXTRAMETADATA Natives
- MONEY Natives
- Issue and PR Templates 2 (2)
- Ambient Life (2) (3)
- Globals and Save Data (2) (3)
- Economy and Pickups (3)
- Story Mission Anatomy (2) (3)
- Economy and Pickups (3) (2)
- SHVDN Scripting Guide (2) (2)
- DECORATOR and ENTITY Natives
- Audio System (2)
- Globals and Save Data (3)
- Strangers and Side Content (2)
- Story Mission Anatomy (2) (4)
- Globals and Save Data (2) (2)
- Boot and Script Control 2 (3)
- RPF Archives and Music Mods (3)
- Repo Rules and Workflow (3)
- EVENT and FIRE Natives
- Story Mission Anatomy (2) (2) (2)
- STREAMING Natives
- Globals and Save Data (2)
- Economy and Pickups (2) (2)
- Story Mission Anatomy (2) (2) (3)
- Online UI Screens (2) (2)
- Issue Config
- OBJECT Natives
- PAD Natives
- PATH Natives
- PHYSICS Natives
- Native Usage Index (2)
- Audio System (3)
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- Story Mission Anatomy (2) (2) (4)
- HUD Colours and Blips (6)
- Economy and Pickups (3) (3)
- Native Namespace Map
- REPLAY Natives
- Native Usage Index (2)
- SHAPETEST Natives
- Native Namespace Map 2
- SAVEMIGRATION Natives
- SHAPETEST Natives (2)

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 129 edges
2. `Mod map: what to read for the mod you want to make` - 114 edges
3. `In-game test card` - 93 edges
4. `Gameplay questions (GP-, 86)` - 88 edges
5. `Tools` - 87 edges
6. `GTA Online questions (ON-, 66)` - 79 edges
7. `The global variable map (R0.4)` - 77 edges
8. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
9. `Native usage: which scripts call which natives` - 70 edges
10. `Runtime scripts: the scripts that keep the game running (R0.2)` - 65 edges

## Surprising Connections (you probably didn't know these)
- `flow_controller (story missions by hash, mission_stat_watcher)` --semantically_similar_to--> `flow_controller (story missions by hash on MISSION)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/core/runtime-scripts.md
- `Script brains: 99 world-point and 47 object brains` --semantically_similar_to--> `World-point and object script brains`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/gameplay/missions/strangers-and-freaks.md
- `270-entry activity table (fmmc_launcher and 265 scripts)` --semantically_similar_to--> `Activity table (270 activities, 266 scripts)`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/online/job-lobby.md
- `Backbone diagram, story mode` --semantically_similar_to--> `Boot sequence: startup, registration scripts, standard_global_reg, main_persistent`  [INFERRED] [semantically similar]
  scripting/script-launch-graph.md → docs/core/runtime-scripts.md
- `Every force-cleanup bit (1, 2, 4, 8, 16, 32, 64, 128)` --semantically_similar_to--> `Force cleanup bits (1, 2, 4, 8, 16, 32, 64, 128)`  [INFERRED] [semantically similar]
  docs/core/runtime-scripts.md → scripting/script-vm.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Script brain to launcher to activity** — docs_gameplay_missions_strangers_and_freaks_script_brains, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_story_script_catalog_launchers [EXTRACTED 0.95]
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **Boot chain from launch to control** — docs_core_runtime_scripts_startup, docs_core_runtime_scripts_standard_global_reg, docs_core_runtime_scripts_main_persistent, docs_core_runtime_scripts_initial, docs_core_runtime_scripts_main_watchdog [EXTRACTED 1.00]
- **freemode's player broadcast data blocks** — docs_core_global_map_global_1845250, docs_core_global_map_global_2658291, docs_core_global_map_global_1892653, docs_core_global_map_global_1882572, docs_core_global_map_network_register_broadcast [EXTRACTED 1.00]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Three scripts that force strand 27 active for a new game** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Creator prop pipeline: catalogue, save columns, upload, race rebuild** — docs_online_creator_internals_prop_catalogue, docs_online_creator_internals_column_save_format, docs_online_creator_internals_ugc_upload, docs_online_creator_internals_race_prop_rebuild [EXTRACTED 1.00]
- **Creator slider to saved stat pipeline** — docs_gameplay_player_online_character_creator_micro_morph_map, docs_gameplay_player_online_character_creator_heritage, docs_gameplay_player_online_character_creator_slider_to_stat, docs_gameplay_player_online_character_creator_mpstatssetup [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Job launch pipeline: activity table, job type mapping, start arguments, corona settings** — docs_online_job_lobby_activity_table, docs_online_job_lobby_job_type_to_controller, docs_online_job_lobby_start_arguments, docs_online_job_lobby_corona_settings_flow [EXTRACTED 1.00]
- **Mission replay without moving the flow** — docs_gameplay_missions_mission_anatomy_mission_repeat_controller, docs_gameplay_missions_mission_anatomy_replay_leaves_flow_alone, docs_gameplay_missions_mission_anatomy_mission_repeat_save_load, docs_gameplay_missions_mission_anatomy_pass_routine [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Native usage trio (guide, index, namespace map)** — scripting_native_usage, scripting_native_usage_index, scripting_native_namespace_map [EXTRACTED 1.00]
- **freemode player state, host state and per-frame running systems** — docs_online_07_freemode_player_state_machine, docs_online_07_freemode_host_state_machine, docs_online_07_freemode_running_state_systems [EXTRACTED 1.00]
- **Path from story to freemode to job** — docs_online_transitions_and_sessions_maintransition, docs_online_07_freemode_freemode_script, docs_online_job_lobby_fmmc_launcher [EXTRACTED 1.00]
- **Phase 1 batches** — open_questions_p1_1, open_questions_p1_2, open_questions_p1_3, open_questions_p1_4, open_questions_p1_5, open_questions_p1_6, open_questions_p1_7 [EXTRACTED 1.00]
- **Phase 2 batches** — open_questions_p2_1, open_questions_p2_2, open_questions_p2_3, open_questions_p2_4, open_questions_p2_5, open_questions_p2_6, open_questions_p2_7 [EXTRACTED 1.00]
- **Phase 3 batches** — open_questions_p3_1, open_questions_p3_2, open_questions_p3_3, open_questions_p3_4, open_questions_p3_5, open_questions_p3_6, open_questions_p3_7, open_questions_p3_8, open_questions_p3_9, open_questions_p3_10, open_questions_p3_11, open_questions_p3_12 [EXTRACTED 1.00]
- **Ped reaction data chain (personality, decision maker, combat info, relationship group)** — docs_ai_decisions_and_personalities_ped_ai_chain, docs_ai_combat_and_perception_events_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_relationships_and_groups_default_groups [EXTRACTED 1.00]
- **Rockstar's physics-cost controls (freeze, clear, density, disable)** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_area_cleanup, docs_performance_physics_cost_density_multipliers [EXTRACTED 1.00]
- **Strand 27 activated in standard_global_reg, initial and flow_controller** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **Business economy second-pass numbers** — docs_online_organisations_and_businesses_nightclub_safe, docs_online_organisations_and_businesses_nightclub_warehouse_goods, docs_online_organisations_and_businesses_warehouse_sizes, docs_online_organisations_and_businesses_vip_mc_challenges [INFERRED 0.75]
- **Registering add-on content (meta, text, content.xml)** — docs_entities_vehicles_vehicles_add_on_vehicle_pack, docs_entities_objects_text_and_names_dlc_text_registration, docs_entities_peds_peds_add_on_ped [INFERRED 0.75]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Server dependencies a fake Online must replace** — docs_online_stats_and_tunables_tunable_index, docs_online_stats_and_tunables_basket_flow, docs_online_transitions_and_sessions_retry_slots, docs_online_rockstar_services_offline_standins [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Crime to wanted stars to dispatch pipeline** — docs_ai_perception_and_events_can_call_police, docs_ai_wanted_level_and_police_crimeinformation_meta, docs_ai_wanted_level_and_police_points_to_stars, docs_ai_police_and_services_dispatch_meta [INFERRED 0.85]
- **Ambient population system (zones, schedules, scenarios, car generators)** — docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_scenarios_scenario_points, docs_entities_spawning_vehicle_generators_and_traffic_car_generators, docs_entities_spawning_population_zonebind_ymt [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Material-keyed data: physics, fire and effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_effects_data_files [INFERRED 0.85]
- **Story mission lifecycle: unlock, run, fail/pass, replay** — docs_gameplay_missions_story_flow_flow_controller, docs_gameplay_missions_story_flow_mission_triggerers, docs_gameplay_missions_mission_anatomy_mission_main_loop, docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_pass_routine, docs_gameplay_missions_mission_anatomy_cleanup, docs_gameplay_missions_mission_anatomy_replay_controller, docs_gameplay_missions_mission_anatomy_mission_repeat_controller [INFERRED 0.85]
- **Rules for mods running beside the VM** — scripting_script_vm_waitpattern, scripting_script_vm_forcecleanup, scripting_natives_engine_api_contracts [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Online cosmetics creation, shops and saved stats** — docs_gameplay_player_online_character_creator_overlay_map, docs_gameplay_player_online_cosmetic_shops_barber, docs_gameplay_player_online_cosmetic_shops_shop_save_stats, docs_online_03_online_data_files_clothing_catalogues [INFERRED 0.85]
- **Server-backed Online dependencies** — docs_online_rockstar_services_service_families, docs_online_stats_and_tunables_tuneables_processing, docs_online_stats_and_tunables_server_transactions [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules, _github_workflows_file_rules_file_rules_check [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How Rockstar scripts stay within memory and streaming limits** — docs_core_memory_and_pools_can_register_mission_entities, docs_core_memory_and_pools_population_budgets, scripting_native_usage_streaming_set_model_as_no_longer_needed, docs_core_streaming_request_check_release, docs_core_streaming_polling_not_blocking [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]

## Communities (158 total, 8 thin omitted)

### Community 0 - "DLC Packs and Vehicles (2)"
Cohesion: 0.06
Nodes (57): Collision, materials and shape tests, material_override_pairs.dat, materials.dat material table, procedural.meta (procedural grass/plants), Shape test collision-layer flags, Shape tests (START_SHAPE_TEST_*), TYRE_GRIP / WET_GRIP / TOP_SPEED_MULT columns, Fire, explosions and projectiles (+49 more)

### Community 1 - "Ped Health and Death"
Cohesion: 0.08
Nodes (57): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+49 more)

### Community 2 - "Handling and How Mods Work"
Cohesion: 0.07
Nodes (37): Timeline of one measured launch, Mod start timing: SHVDN about 13 s, playable about 14 s later, handling.meta, CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, ASI loader load chain (dinput8, ScriptHookV), Data mods vs script mods (+29 more)

### Community 3 - "Native Usage Index"
Cohesion: 0.14
Nodes (45): Native namespace map, MISC namespace is a junk drawer, Native namespace coverage map (R0.8), 45 named namespaces + 2 unknown natives, AUDIO natives used by the game scripts, BUILTIN natives used by the game scripts, CAMERA natives used by the game scripts, CLOCK natives used by the game scripts (+37 more)

### Community 4 - "Globals and Save Data (2)"
Cohesion: 0.12
Nodes (38): gameconfig.xml PoolSizes, Runtime scripts: the scripts that keep the game running (R0.2), Boot sequence: startup, registration scripts, standard_global_reg, main_persistent, building_controller (IPL world-state swaps), code_controller (235 timed delayed-action slots), Force-cleanup bits 16 and 32 raised only by the engine (cause open), error_listener (NETWORK_BAIL on error event), flow_controller (story missions by hash on MISSION) (+30 more)

### Community 5 - "TASK Natives"
Cohesion: 0.10
Nodes (39): 12 ped component slots and prop anchors, Peds, Add-on ped requirements, Ped name prefixes (a_, ig_, s_, csb_ ...), pedpersonality.ymt, peds.ymt / peds.meta ped model entries, Special abilities on the model (AbilityType), Ragdoll blocking flags and masks (+31 more)

### Community 6 - "Globals and Save Data 3"
Cohesion: 0.12
Nodes (38): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values) (+30 more)

### Community 7 - "Minigames and Activities 2"
Cohesion: 0.12
Nodes (36): script-launch-graph.ps1: launches via git grep, Launch graph, first pass (R0.5): 679 edges, What the launch graph misses (variable and table-driven launches), Registration table with one bare hash (globals_fmmcstruct3_registration), CORE-021 Resolve table-driven launches (second pass of the graph) (Mostly answered), GP-009 Who starts minigame_stats_tracker and minigame_ending_stinger (not ... (Answered), GP-040 Who starts the family_scene_ scripts (Answered), Script launch graph (R0.5) (+28 more)

### Community 8 - "Rockstar Creator (2)"
Cohesion: 0.09
Nodes (34): Tunables block Global_262145, Garage sizes and 607 personal vehicle records, Daily property fees (48 real minutes), Rockstar services, Behaviour when a service is missing, Open questions (services), Service native families (counts per service), Service guard natives (+26 more)

### Community 9 - "Globals and Save Data"
Cohesion: 0.06
Nodes (36): 37 broadcast blocks by registered name (15 player, 18 host, 4 job), freemode (registers 33 broadcast blocks: 15 player, 18 host), Global_1057198 g_sMC_serverBDEndJob (end of job) (host broadcast block), Global_1689064 GlobalServerBD_DM (host broadcast block), Global_1873411 GPBD_MissionName (player broadcast block), Global_1873924 GPBD_Kicking (vote kicks) (player broadcast block), Global_1877125 GSBD_Kicking (host broadcast block), Global_1877158 GPBD_FM_HeistPlanning (player broadcast block) (+28 more)

### Community 10 - "Globals and Save Data (2) (2)"
Cohesion: 0.13
Nodes (30): Story save block (38,592 values), The global variable map (R0.4), Global reference count (git grep, 5,151 distinct bases), Global_22983/22602/21591 (dialogue request and state), Global_2658291[p].f_325.f_11: interior owner, Global_2658291[p].f_325: interior the player is in, Global_102154 (three characters' current outfits), Global_102481 (shop data) (+22 more)

### Community 11 - "Boot and Script Control 4"
Cohesion: 0.09
Nodes (30): director_mode, Engine starts startup, initial and main, flow_controller, flowintrotitle, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, Global_1 (game started flag), Global_3 (boot into Online), Global_80281 (+22 more)

### Community 12 - "DLC Packs and Vehicles"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 13 - "Time Weather Wind"
Cohesion: 0.16
Nodes (29): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+21 more)

### Community 14 - "C# Example Mods"
Cohesion: 0.12
Nodes (8): Samples, NativeCalls, Examples, Six SHVDN v3 C# sample scripts, Languages for modding GTA V, ActionScript 2 for Scaleform UI, Five-step learning path, Shared game thread

### Community 15 - "Combat and AI Tuning (2)"
Cohesion: 0.11
Nodes (28): Perception and events, CanCallPolice shocking events (8), Script-added shocking events (ADD_SHOCKING_EVENT_*), Police and service AI, dispatch.meta (crime points, radii, units sent), dispatchtuning.ymt (search helpers and spawning), What police mods replace, AI (+20 more)

### Community 16 - "Rockstar Creator"
Cohesion: 0.12
Nodes (28): Inside freemode (first pass), Player/server broadcast data globals, freemode_init, freemode (GTA Online main script), Host state machine (0,4,5), 29 helper scripts launched by freemode, 60 network event types (queue 1, ids 151-249), Open questions (freemode) (+20 more)

### Community 17 - "Online UI Screens"
Cohesion: 0.09
Nodes (27): am_contact_requests, appbusinesshub (business computer), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Busy spinners and warning screens, Credits & Legal tunable Global_262145.f_9321, Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED) (+19 more)

### Community 18 - "Economy and Pickups 2"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 19 - "Boot and Script Control 3"
Cohesion: 0.09
Nodes (25): Shared activity-type helper (212 scripts), LOBBY_AUTO_MULTIPLAYER_* flags, benchmark, Force cleanup bits (2, 8, 64, 1, 128), freemode (MP_LAUNCH_SCRIPT stack), GET_INDEX_OF_CURRENT_LEVEL, Launching into Online, Level index 1 (levels/gta5) (+17 more)

### Community 20 - "Ambient Life"
Cohesion: 0.10
Nodes (26): Glossary, Broadcast data (player and host synced globals), Decision maker: event to ped reaction table, Flow and strand: 32 strands run by flow_controller, Global block: shared script memory owned by a registration script, Glossary of modding and engine terms, IPL map placement groups toggled by REQUEST_IPL, Legacy vs Enhanced PC editions (+18 more)

### Community 21 - "Freemode Internals"
Cohesion: 0.14
Nodes (26): Job type and subtype table, Race subtype pairs (even lap, odd point-to-point), fm_content_* scripts (85-91), Classic planning board (fmmc_launcher, heist_mp movies), The job lobby (fmmc_launcher), Activity table (270 activities, 266 scripts), The corona lobby screens, How corona settings reach the controller (+18 more)

### Community 22 - "Navigation and Streaming (2)"
Cohesion: 0.14
Nodes (23): Map data, IPL map section switching, Restricted areas (re_armybase, re_prison), ytyp archetype files, Random events, Area scripts re_armybase/re_prison/re_lossantosintl/re_yetarian, Shared random event launch check, SET_RANDOM_EVENT_FLAG / SET_MISSION_FLAG (+15 more)

### Community 23 - "APPS and DATAFILE Natives"
Cohesion: 0.08
Nodes (26): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING, DATAFILE native namespace: DATAFILE natives: DATADICT/DATAARRAY JSON-like data and UGC (+18 more)

### Community 24 - "Ambient Life (2)"
Cohesion: 0.16
Nodes (24): Online venue peds (am_mp_peds etc.), Ambient speech voices (full and mini), Memory, pools and limits (R1.4), Entity limits: 256 peds, 300 vehicles, Fixed-size pools (~230), gameconfig.xml PoolSizes, HeapAdjuster, Limit adjuster plugins (HeapAdjuster, PackfileLimitAdjuster, PoolManager) (+16 more)

### Community 25 - "Story Mission Anatomy"
Cohesion: 0.13
Nodes (25): Health, armour, death and arrest, 10 ped health configs in pedhealth.meta, Script health natives, IS_PED_INJURED as dead check, Health regeneration, Clothing catalogue 36,232 items, Swimming and diving, Dive and fall heights (+17 more)

### Community 26 - "Online Properties"
Cohesion: 0.15
Nodes (24): Properties in GTA Online, Entrance entry checks (wanted, mission, garage full, trailer), Per-owner interior instances (rows 0 to 31), Open questions (properties), Ownership slots and stats, 83 AM_MP_PROPERTY_EXT world-point entrances, Property exterior/interior script pair, 115-entry property table (+16 more)

### Community 27 - "HUD Colours and Blips"
Cohesion: 0.14
Nodes (25): HUD, colours and blips, Blip natives lifecycle, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, Radar and minimap interiors, Pause and Online menus, ACTIVATE_FRONTEND_MENU usage, DISABLE_FRONTEND_THIS_FRAME (+17 more)

### Community 28 - "Combat and AI Tuning"
Cohesion: 0.17
Nodes (24): Combat and AI (first pass), Melee action tables (action definitions.meta), pedaccuracy.meta accuracy modifiers, pedperception.meta profiles, How Rockstar's scripts drive AI, Heist crew table (13 members), Online enemy difficulty scaling, re_rescuehostage hostage event (+16 more)

### Community 29 - "Economy and Pickups"
Cohesion: 0.16
Nodes (24): Appearance and clothing, EXTRAMETADATA shop natives, Preload ped variation data, Restriction tags and forced components, Shop scripts (clothes_shop, hairdo_shop, tattoo_shop), Tattoos and decals as decorations, Online cosmetics and the shops that sell them, Hair fades as decorations (+16 more)

### Community 30 - "Minigames and Activities 2 (2)"
Cohesion: 0.12
Nodes (24): Shared activity launcher template, Script catalog: story mode and shared scripts, 86 scripts empty in release, 37 launcher scripts, 146 script brains (99 world-point, 47 object), 12 groups of 584 story and shared scripts, Scripts marked to check, wardrobe_sp and wardrobe_mp (+16 more)

### Community 31 - "Rockstar Creator (3)"
Cohesion: 0.17
Nodes (24): Rockstar Creator internals: how tracks and maps are built from props, Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Mission Creator limits (public_mission_creator), Open questions (creator), Placement checks and limits (200 props, 20 dynamic) (+16 more)

### Community 32 - "Online Properties (2)"
Cohesion: 0.14
Nodes (24): Interaction menu, phone and apps, app* scripts (38) business computers, Cellphone app table (cellphone_controller, flashhand), Phone each character carries (iFruit, Badger, Facade), Contact services (am_contact_requests), In-game internet (appinternet, web_browser, www_*.gfx), Open questions (phone/menu), Phone slots by mode (story vs Online home screen) (+16 more)

### Community 33 - "Online DLC Storylines (3)"
Cohesion: 0.16
Nodes (23): Organisations and businesses, Biker business and bunker numbers, gb_bosscost and gb_bosssetupcost read by no script, Business loop: supplies, production, stock, sell, Challenge payout shares (goons 50% RP, rival 70%, solo 30%, wager cut 10%), 70 gb_* scripts, Nightclub safe: popularity pay bands, $250,000 cap, 48-minute timer, Nightclub warehouse goods (7 types: value, capacity, units per step) (+15 more)

### Community 34 - "Story Mission Anatomy (3)"
Cohesion: 0.17
Nodes (23): Story mission table (95 entries), Global_80551 (flow program), Global_93192 (story mission table), Story mission flow (R5.1), Flow command vocabulary, Flow command types (69), 57 flow flags, Flow program (1,882 commands) (+15 more)

### Community 35 - "Weapons"
Cohesion: 0.15
Nodes (23): Flying, AI flight tasks, Script aircraft natives, CFlyingHandlingData block, Parachuting and skydiving, Health floor of 100, Player skills and abilities, Special ability natives (+15 more)

### Community 36 - "Physics Cost and Cleanup (2)"
Cohesion: 0.15
Nodes (21): CPU: population, AI, physics and scripts, Population density as biggest lever, Game threads (24, Update TIME_CRITICAL), Open questions (CPU), Heavily modded install script load (52 + 61), Load phases (80 to 107 s), GET_FRAME_COUNT() % 60 pattern (5,030 uses), Mod overhead: what each kind of mod costs (+13 more)

### Community 37 - "Boot and Script Control 2 (2)"
Cohesion: 0.18
Nodes (21): Boot and script control (R1.2), Back to story mode, Boot sequence short version, Boot open questions, Boot test cards, Global blocks (18 declared blocks of 2^18 slots, each owned by one script), Global N is in block N >> 18 (slots of 2^18), profiler_registration (empty script, global block 2 unused) (+13 more)

### Community 38 - "Audio System"
Cohesion: 0.16
Nodes (22): How audio is organised, Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Music and radio, Mission music events (TRIGGER_MUSIC_EVENT) (+14 more)

### Community 39 - "Story Mission Anatomy (2)"
Cohesion: 0.15
Nodes (22): The Online character creator, Apparel (64 outfits per sex, crew T-shirt, crew emblem), Appearance change fee and cooldown (100,000, 48 minutes), 63 saved creator stats (62 server-authoritative), Seven skill stats with 100-point pool, 32 eye colours (FACE_E_C_0 to 31), Heritage head blend, Seven top menu items (Sex, Heritage, Features, Appearance, Apparel, Stats, Save) (+14 more)

### Community 40 - "Story vs Online Scripts"
Cohesion: 0.14
Nodes (22): Cloud stat slots (STAT_SLOT_IS_LOADED), Session type checks, Transitions and sessions, Creator destination value 2 opens state 32, freemode_clearGlobals (31 reset steps), Usual path into freemode, Offline-mode branch unreachable in build 3725, Offline-mode branch before START_FM_LAUNCH_SCRIPT (+14 more)

### Community 41 - "Story vs Online Scripts (2)"
Cohesion: 0.14
Nodes (22): Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems), pb_prostitute ped brains (three hooker models) (+14 more)

### Community 42 - "Performance and Script Load (5)"
Cohesion: 0.13
Nodes (22): Graphics settings, one by one, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat, Open questions (graphics), Biggest GPU/CPU/memory costs, Streaming, memory and video memory, HeapAdjuster (478 to 1,950 MB) (+14 more)

### Community 43 - "Combat and AI Tuning (2)"
Cohesion: 0.14
Nodes (21): Personality driving ability and aggressiveness ranges, Driving and AI driving, Driving AI: missions, chases, aircraft and boats, How Rockstar builds a chase or race, AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), Helicopter, plane and boat missions, TASK_VEHICLE_TEMP_ACTION manoeuvres, Vehicle mission types (TASK_VEHICLE_MISSION list) (+13 more)

### Community 44 - "Story Mission Anatomy (2) (2)"
Cohesion: 0.13
Nodes (21): Global_102429 (replay controller state), Global_93156 (running-mission list), Anatomy of a story mission (R5.2), armenian1 (Franklin and Lamar), armenian1 stage list (stages 0 to 11, 4 checkpoints), Mission cleanup, Fail function with reason labels, Force cleanup handler (+13 more)

### Community 45 - "Globals and Save Data 3 (2)"
Cohesion: 0.14
Nodes (19): Saves: the story save (R1.7), FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values), Keep mod data in its own file, Save upgrade function in startup, Save version fSaveVersion (1.7), standard_global_reg (+11 more)

### Community 46 - "Online DLC Storylines (2)"
Cohesion: 0.25
Nodes (20): Heists in GTA Online, Diamond Casino Heist (targets, crew cuts), Cayo Perico Heist (target weights, support costs), Classic heist economics (setup, take, cuts), Doomsday Heist numbers, Elite challenges in the tunables (per heist), Failure penalty time bands (0 to 60%), Heist planning scripts (4 generations) (+12 more)

### Community 47 - "Performance and Script Load (2)"
Cohesion: 0.13
Nodes (21): 15 W laptop throttling, Load times and stutter, First three minutes hold most hitches, Open questions (load times), Driver shader cache, Performance, Performance folder topic index (R18.x), Windows and drivers (+13 more)

### Community 48 - "Driving AI"
Cohesion: 0.13
Nodes (19): update-check.ps1 tool, Question categories by ID prefix (GS, CORE, ENT, PHY, AI, WLD, GP, ON, UI, AUD, REN, PERF, SCR, FF), Scripting questions (SCR-, 14), Native namespace map (R0.8), Native usage: which scripts call which natives (R0.3), SCR-001 Split MISC into sub-families with their own owners (weather, cheats, ... (Open), SCR-002 Which natives are reached only through shared helper code and never ... (Open), SCR-003 Which namespaces' unused natives still work in story mode (useful to ... (Open) (+11 more)

### Community 49 - "AUDIO Natives"
Cohesion: 0.10
Nodes (21): GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CREATE_CAM, DO_SCREEN_FADE_IN (+13 more)

### Community 50 - "BRAIN and BUILTIN Natives"
Cohesion: 0.10
Nodes (21): BRAIN natives used by the game scripts, IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, REGISTER_WORLD_POINT_SCRIPT_BRAIN, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, START_NEW_SCRIPT_WITH_ARGS, TIMESTEP (+13 more)

### Community 51 - "Physics Cost and Cleanup (2) (2)"
Cohesion: 0.11
Nodes (20): Physics cost: what the simulation spends, and how scripts keep it down, CLEAR_AREA cleanup before and after set pieces, Per-frame density multipliers, Freeze by default (FREEZE_ENTITY_POSITION), Proposed physics budgets for a low-end PC, Physics cost test cards, Physics pools (phInstGta, StaticBounds, FragmentStore ...), Euphoria ragdoll cost (+12 more)

### Community 52 - "File-rules Workflow"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 53 - "Natives as Engine API"
Cohesion: 0.12
Nodes (19): Natives as the engine API: kinds, contracts and costs (R1.3), SCR-008 Measured cost of the heavy natives (synchronous shape test, ... (Open), SCR-009 Which natives crash on a stale handle and which fail quietly (Open), SCR-010 The size limits of the nearby-entity arrays (Open), Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED), Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT), START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE (+11 more)

### Community 54 - "Issue and PR Templates"
Cohesion: 0.18
Nodes (18): Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, Objects, Peds (folder index), Entities, Spawning (+10 more)

### Community 55 - "RPF Archives and Music Mods (3)"
Cohesion: 0.17
Nodes (19): Adding or replacing music (DLC station pack), Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins) (+11 more)

### Community 56 - "Economy and Pickups (2)"
Cohesion: 0.16
Nodes (17): Shop catalogue files (*_shop.meta), Economy and pickups (R3.9), Collectable scripts (letterscraps, spaceshipparts, underwaterpickups), Collectables scripts, CREATE_PICKUP_ROTATE, Shared story money helper, SPx_MONEY_SPENT_* categories (10 + total), Online money server transactions (+9 more)

### Community 57 - "How GTA Online Works (2)"
Cohesion: 0.16
Nodes (19): Director mode script, Character switching (R6.1), CHANGE_PLAYER_PED, Wheel Online slot (MainTransition), player_controller, player_controller_b, player_scene_* arrival scenes (42-entry table), player_timetable_scene (+11 more)

### Community 58 - "RPF Archives and Music Mods"
Cohesion: 0.13
Nodes (18): dlc_patch map replacement, ymap placement files, Archive and data file atlas, 89 DLC packs hold most files, 389,555 files of 57 kinds in 5,290 archives, Table of every file type (.ytd, .ydr, .ymap ...), Update archives carry the logic, materials.dat and related material files (+10 more)

### Community 59 - "Repo Rules and Workflow"
Cohesion: 0.12
Nodes (8): CLAUDE.md (AI assistant instructions), Repository map, Rule: one roadmap topic per branch, Verified / Known claim marking, Branch naming (research/<ID>-pass2-<what> ...), Phase 6: second pass, Verified / Known definitions, Status: first pass of 109 topics, ~95 open-question tables

### Community 60 - "Credits and File Rules"
Cohesion: 0.15
Nodes (17): Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, Run under Proton or Wine with DXVK (D3D11 to Vulkan), Getting started, Getting started topics R0.6 and R1.2 (done) (+9 more)

### Community 61 - "Minigames and Activities 2 (3)"
Cohesion: 0.18
Nodes (18): Minigames and activities, Activity ids 0 to 18, Activity fees and pay table, Hunting score and weapon factor, Minigames are 42 entries worth 10% of completion, Mission candidate slot, Odd-job pay goes through story properties, Open questions R5.5 (+10 more)

### Community 62 - "Story Mission Anatomy (3) (2)"
Cohesion: 0.17
Nodes (18): Controls and camera, INPUT_* control actions and IDs up to 401, Three control groups, Control meta files, DISABLE_CONTROL_ACTION usage, SET_INPUT_EXCLUSIVE, Camera view mode per context, Key codes and control IDs (+10 more)

### Community 63 - "Time Weather Wind (2)"
Cohesion: 0.20
Nodes (17): Time, weather and wind, Game clock natives, Online clock override, respawn_controller weather reroll, WeatherCycles fixed list, Persistent weather lock natives, weather.xml (types, cycles, GPU fx), Wind (WindMin/WindMax, SET_WIND) (+9 more)

### Community 64 - "Strangers and Side Content (2)"
Cohesion: 0.12
Nodes (9): Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu, Mod-builder's cookbook, Cookbook: shops, Pattern: story-mode shop, Per-character cash stats SP0_TOTAL_CASH, Category: trainers and menu utilities (+1 more)

### Community 65 - "WEAPON Natives"
Cohesion: 0.12
Nodes (18): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+10 more)

### Community 66 - "RPF Archives and Music Mods (2)"
Cohesion: 0.19
Nodes (16): Freemode models and head blend, Cutscenes and dialogue, Cutscene exit states, Cutscene request-dress-register-start-remove sequence, dialogue_handler script, Online cutscene handles MP_1 to MP_4, REGISTER_ENTITY_FOR_CUTSCENE handles, Subtitle flags and phone call conversations (+8 more)

### Community 67 - "HUD Colours and Blips (4)"
Cohesion: 0.16
Nodes (15): pausemenu.xml menu description, Scaleform movies, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), DLC movies (mpheist, mpapartment), Scaleform .gfx archives, Request-wait-call-draw-release pattern, Mission-passed screen (mission_stat_watcher), REQUEST_ADDITIONAL_TEXT slots (+7 more)

### Community 68 - "SHVDN Scripting Guide"
Cohesion: 0.13
Nodes (16): 9. Next steps and sharing your mod, Where to publish mods, Mod readme required sections, 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, SHVDN namespaces (GTA, GTA.UI, GTA.Native, GTA.Input...) (+8 more)

### Community 69 - "Natives as Engine API (2)"
Cohesion: 0.15
Nodes (17): The script VM: how GTA V runs its scripts, and how mods run beside them (R1.1), SCR-011 Meaning of force-cleanup bits 4, 16 and 32 (engine-raised) (Open), SCR-012 What thread priority values change (Open), SCR-013 The event queue indexes and the script event layout (Open), SCR-014 Which of the duplicated pool entries in gameconfig.xml applies to the ... (Open), Contracts Rockstar keeps (request, release, create, clean up), The script VM: how GTA V runs its scripts, and how mods run beside them, Force cleanup bits (1, 2, 4, 8, 16, 32, 64, 128) (+9 more)

### Community 70 - "Boot and Script Control"
Cohesion: 0.14
Nodes (16): GTA V Legacy build 1.0.3725.0, Game build 1.0.3725.0 (Legacy), Decompiler names change every build, Research sources: decompile, data files, natives, in-game tests, Game version (Legacy 1.0.3725.0), Reading the decompiled game scripts, Community decompile repository (one commit per build), Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical (+8 more)

### Community 71 - "RPF Archives and Music Mods (2) (2)"
Cohesion: 0.16
Nodes (13): Stale modded update.rpf, Text and names in content, DLC text registration (dlctext.meta, TEXTFILE_METAFILE), global.gxt2 text tables, Name lookup natives (GET_DISPLAY_NAME_FROM_VEHICLE_MODEL), DLC packs and their vehicles, DLC pack inventory (89 packs), Add-on vehicle pack requirements (+5 more)

### Community 72 - "Online DLC Storylines"
Cohesion: 0.23
Nodes (16): DLC storylines in GTA Online, dlclist.xml pack order, When each fm_content_* script arrived (97 scripts by decompile commit), Local vs cloud missions (16 on disk, ~980 content files), Open questions (DLC storylines), Phone-call flows (40 call roots in six DLC dialogue blocks), Property intro cutscenes (289 distinct names), Rebuilding an arc offline (+8 more)

### Community 73 - "Rendering and LOD (2)"
Cohesion: 0.23
Nodes (16): visualsettings.dat tuning file, Timecycle and post effects, Always clear modifiers and effects, Script, player and extra modifier layers, Timecycle modifiers, SET_TIMECYCLE_MODIFIER / ANIMPOSTFX_PLAY usage, Weather timecycle (w_*.xml), Rendering questions (REN-, 27) (+8 more)

### Community 74 - "RPF Archives and Music Mods (2)"
Cohesion: 0.12
Nodes (16): Pattern: mission skeleton (idle, setup, stages, fail, pass, cleanup), Cookbook (R12.1), Ideas list: mods the research says are possible, Data-file mod ideas (7), Harder or riskier ideas (4), Mod ideas list (R12.3), Script mod ideas (11), Category: missions, heists, new stories (+8 more)

### Community 75 - "Repo Rules and Workflow 2"
Cohesion: 0.13
Nodes (10): Launch with -nobattleye for story-mode mods, Research tools, After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts, ugc-keys.ps1: key paths in UGC files (+2 more)

### Community 76 - "Credits and File Rules (2)"
Cohesion: 0.14
Nodes (15): Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), ASI, ScriptHookV, ScriptHookVDotNet, rpf-cw.ps1: list and extract archive files (CodeWalker), Setup: game version and everything you need, Quick start for research (about 30 minutes), Dependencies to run mods: ScriptHookV 3889.0, SHVDN 3.7.0, LemonUI, NativeUI, iFruitAddon2, Lua plugin, Menyoo, CodeWalker 30 dev46, ILSpy (+7 more)

### Community 77 - "Ambient Life (3)"
Cohesion: 0.20
Nodes (15): Modder advice: poll not re-give, sequences, block events, tune in right layer, AI cost and level of detail, AI LOD by distance table (near, middle, far), Hard caps: 256 peds, 300 vehicles, 8,192 tasks, 950 events, 1,024 navmesh routes, Low-detail locomotion for far peds (CTaskMotionBasicLocomotionLowLod), MaxTotalPeds 200 (base 70) population cap below the 256 pool, Open questions: LOD distances, frame time per ped, second CTask pool, Proposed safe limits for mods: 20-30 combat peds, under 150 peds, 10-15 AI vehicles, 4 ragdolls (+7 more)

### Community 78 - "Ambient Life (3) (2)"
Cohesion: 0.17
Nodes (15): LOD settings (LodScale, MaxLodScale), Population, Open question: how caps, CityDensity and budgets combine, popcycle.dat population schedules, popzone.ipl zone boxes, Zone attributes (scumminess, law response), zonebind.ymt zone attributes, Scenario points and region files (+7 more)

### Community 79 - "Weapons (2)"
Cohesion: 0.16
Nodes (15): Armour purchase and pickups, Weapons (folder README), Weapons, Shared ammo pools, Ammu-Nation story unlocks, Bullet damage and fall-off model, Weapon components, clips, tints, 246 DLC weapon entries in 33 packs (+7 more)

### Community 80 - "Story Mission Anatomy (2) (2)"
Cohesion: 0.25
Nodes (15): Respawn, death and arrest, Arrest costs up to $300 and clears weapons, Death costs 5% of cash up to $5,000, Online respawn search, What every respawn resets, 5 hospital and 7 police restart points, GP-060 What the "building" table tied to each restart point drives (Open), GP-061 Which respawn states (global values 7 and 9) and money categories (3 ... (Open) (+7 more)

### Community 81 - "How GTA Online Works"
Cohesion: 0.15
Nodes (15): How GTA Online works, Online stats in mpstatssetup.xml (17,933), Network session and broadcast data, Script VM, natives, globals, What depends on Rockstar servers, Server transactions for money, Cloud tunables, UGC cloud content and local files (+7 more)

### Community 82 - "Navigation and Streaming"
Cohesion: 0.15
Nodes (15): Interior map movies (int<hash>.gfx), Interiors and IPLs, building_controller and maintransition IPL swaps, Interior entity sets, REQUEST_IPL / REMOVE_IPL, MLO interior archetypes, Opening Online interiors in story mode, Cookbook: world and map (+7 more)

### Community 83 - "RPF Archives and Music Mods (4)"
Cohesion: 0.20
Nodes (14): re_* random event scripts, UGC mission files (JSON), UGC classic creator missions (16), UGC content files family (~980), Scripts that read UGC (fm_content_*, creators), File formats questions (FF-, 6), FF-001 Reliable sizes per type (audio sizes read as zero) (Open), FF-002 A per-pack breakdown for all 89 DLC packs (Open) (+6 more)

### Community 84 - "SHVDN Scripting Guide (2)"
Cohesion: 0.15
Nodes (15): LemonUI, 07 Legacy: SHVDN v2 and NativeUI, NativeUI 1.9.0, NativeUI to LemonUI mapping, Porting v2 mod to v3, Old "v1" name redirected to v2, v2 vs v3 API differences, GUI.lua button menu library (+7 more)

### Community 85 - "Example Mod Classes"
Cohesion: 0.16
Nodes (3): HelloWorld, PhoneContactSample, SettingsAndText

### Community 86 - "Combat and AI Tuning (3)"
Cohesion: 0.19
Nodes (14): combatbehaviour.meta combat profiles, events.meta decision makers and responses, Decisions and personalities, Agitation system (agitated*.meta), Bravery types, Model to personality to decision maker to combat info chain, pedpersonality.ymt (95 personalities), Player character modifiers (Michael, Franklin, Trevor) (+6 more)

### Community 87 - "Combat and AI Tuning (4)"
Cohesion: 0.19
Nodes (14): relationships.dat groups, Script fight recipe (relationship, attributes, task, keep task), SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, Relationships and groups, 40 default relationship groups, Mission relationship group pattern (ENEMIES / BUDDIES), Player groups (followers), Relationship levels (0 companion to 5 hate, 255) (+6 more)

### Community 88 - "Ambient Life (3) (3)"
Cohesion: 0.19
Nodes (13): Population and model budgets, Script natives shaping population, Scenarios and ambient life, Ambient speech natives, Scenario groups and blocking areas, scenarios.meta type definitions, Script traffic control natives, Ambient speech vs scripted conversations (+5 more)

### Community 89 - "Performance and Script Load (3)"
Cohesion: 0.16
Nodes (14): commandline.txt launch switches, ON_ENTER_MP map switch (8.6 s), Measuring performance, Game benchmark script (5 scenes), CPU-bound vs GPU-bound resolution test, Frame time over frame rate; hitches and freezes, GET_FRAME_TIME / GET_FRAME_COUNT / GET_GAME_TIMER, Open questions (measuring) (+6 more)

### Community 90 - "Ambient Life (4)"
Cohesion: 0.20
Nodes (14): Animation, clip_sets.ymt clip sets, conditionalanims.meta ambient idles, Facial clip sets and expressions (.yed), Move networks (.mrf), TASK_PLAY_ANIM usage and flag bits, Animated post effects (animpostfx.ymt), Animation (R13.4) (+6 more)

### Community 91 - "HUD Colours and Blips (5)"
Cohesion: 0.21
Nodes (14): hudcolor.dat colour table, Movie method names from ActionScript, Story-mode UI, Character wheel (selector), Completion percent and medal formula, 913-entry mission stat table, SHOW_MISSION_PASSED_MESSAGE parameters, spstatssetupui.xml Stats page (+6 more)

### Community 92 - "Script VM Contracts 2"
Cohesion: 0.20
Nodes (14): Compiled script (.ysc): code, statics, native table, strings, Tools, check-system.ps1: what Windows needs, CodeWalker (external dependency), Community decompiled-scripts repository (external dependency), dlc-scan.ps1: inventory of DLC packs, Tools stay read-only and ship no game data, rpf-cw.ps1: list and extract any archive (CodeWalker) (+6 more)

### Community 93 - "Issue and PR Templates 2"
Cohesion: 0.18
Nodes (13): Issue template: Inbox, Inbox issue template (found a system no topic covers), Issue template: Claim a research topic, Claim a research topic issue template, Phases of a topic (claim, research, write, PR, merge, second pass), Research roadmap, Good first topics (R2.6, R3.8, R9.3, R13.2, R14.4, R8.3, R18.6), Inbox for topics nobody covers (+5 more)

### Community 94 - "Issue and PR Templates (2)"
Cohesion: 0.17
Nodes (10): Pull request template, Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Property table in am_mp_property_ext (index to entrance coordinates), Tools and resources, Contributed tools and resources table, Reading the logic: decompile, git, grep/awk/sed, call-graph labeller, Workflow: price decompiled shop items from tuneables_processing, Watching the game run: logs, SHVDN monitoring script, test cards (+2 more)

### Community 95 - "Repo Rules and Workflow (2)"
Cohesion: 0.15
Nodes (13): graphify-out exempt paths, Data files via tools/rpf-cw.ps1 and CodeWalker, Decompiled scripts (build 3725 commit), Entry template (templates/entry-template.md), graphify-out knowledge graph, Research workflow (one topic), ROADMAP.md, Using an AI assistant (+5 more)

### Community 96 - "Strangers and Side Content"
Cohesion: 0.18
Nodes (13): Crowd thinning natives (density, non-creation area, suppress), Navigation and pathfinding, Navmesh required region and blocking objects, Navmesh tiles (.ynv, 4,404), Path nodes (.ynd, road nodes), Patrol routes and cover point natives, Why peds get stuck (causes and script fixes), Patrol route building (miss_ routes) (+5 more)

### Community 97 - "Ambient Life (2) (2)"
Cohesion: 0.18
Nodes (12): Population budgets (SET_PED_POPULATION_BUDGET), Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, PIN_INTERIOR_IN_MEMORY, Pop-in and streaming hitches (+4 more)

### Community 98 - "Navigation and Streaming (2) (2)"
Cohesion: 0.21
Nodes (13): IPLs (optional map sections), Props, archetypes and doors, Archetype definition, Door auto-open flags, Door system (ADD_DOOR_TO_SYSTEM), doortuning.meta, Rayfire destruction objects, Static vs dynamic and breakable props (+5 more)

### Community 99 - "Natives as Engine API (2)"
Cohesion: 0.21
Nodes (13): Synchronized scenes, Cameras, Camera directors (10), cameras.ymt camera metadata, Gameplay camera hints, Screen fades and widescreen borders, Script camera create/render/destroy pattern, Cameras (R13.5) (+5 more)

### Community 100 - "Online UI Screens (2)"
Cohesion: 0.33
Nodes (12): Server-backed Online screens (R8.5), Engine-filled network pages (friends, crews, party, store, invites), What a local replacement would need, Server-backed screens open questions, User interface questions (UI-, 19), Server-backed screens guide (R8.5), Batch P1.6: Server-backed Online screens (R8.5) (Done), UI-005 What pausemenu_multiplayer fills on each Online page (Answered) (+4 more)

### Community 101 - "Ambient Life (3) (4)"
Cohesion: 0.24
Nodes (12): Vehicle generators and traffic, Car generators (CCarGen), dispatch.meta emergency services, Trains (12 tracks, 2 active), Vehicle flags (FLAG_*), ENT-030 What the car generator flag bits mean (3,680, 3,936 ...) (Open), ENT-031 Which DLC ymaps with generators load in story mode (Open), ENT-032 How the schedule caps, the budget and the CityDensity setting combine (Open) (+4 more)

### Community 102 - "RPF Archives and Music Mods (5)"
Cohesion: 0.26
Nodes (11): Vehicles, carcols mod kits and sirens, carvariations, Vehicle types and classes, vehiclelayouts.meta, Entities questions (ENT-, 39), ENT-036 The difference between the 901 models here and the 879 counted in R14.4 ... (Open), ENT-037 The meaning of the less common flags (Open) (+3 more)

### Community 103 - "Performance and Script Load (4)"
Cohesion: 0.18
Nodes (9): settings.xml (version 27) keys, Profiles for different PCs, Low-end laptop profile, Mid-range PC profile, Open questions (profiles), Strong PC profile, Profiles for different PCs (R18.7), PERF-021 Measured FPS and hitches of the low-end profile vs typical settings on ... (Open) (+1 more)

### Community 104 - "Rendering and LOD (2) (2)"
Cohesion: 0.23
Nodes (12): Clip dictionaries (.ycd), Particles and decals, Decal limit (executable-fixed), Particle dictionaries (.ypt), Particle limits (PtFxAssetStore 400, PTFX 61 per script), Request asset, USE_PARTICLE_FX_ASSET, start effect, Particles and decals (R13.3), REN-012 The exact decal limit in build 3725 and what limit patches change (Open) (+4 more)

### Community 105 - "Rendering and LOD"
Cohesion: 0.21
Nodes (12): Rendering (folder index), Rendering roadmap topics R13.1-R13.5, Rendering, visual settings and LOD, Deferred rendering pipeline, Distant lights (20:00-06:00), LOD distance and OVERRIDE_LODSCALE_THIS_FRAME, LOD lights (250/750/2500 m), Rendering, visual settings and LOD (R13.1) (+4 more)

### Community 106 - "HUD Colours and Blips (2)"
Cohesion: 0.27
Nodes (12): Blip sprites and BLIP_<n> labels, Text labels, DLC text (dlctext.meta, americandlc.rpf), .gxt2 text files and label hashes, STRING label (~a~) trick, Eight blocks added by update2.rpf, Text labels guide (R8.3), Batch P1.2: Text labels (R8.3) (Done) (+4 more)

### Community 108 - "DLC and EXTRAMETADATA Natives"
Cohesion: 0.17
Nodes (12): GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA, GET_SHOP_PED_COMPONENT, EXTRAMETADATA native namespace: EXTRAMETADATA natives: DLC shop ped, vehicle, weapon metadata (+4 more)

### Community 109 - "MONEY Natives"
Cohesion: 0.17
Nodes (12): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC, NETSHOPPING native namespace, NET_GAMESERVER_BASKET_START (+4 more)

### Community 110 - "Issue and PR Templates 2 (2)"
Cohesion: 0.29
Nodes (8): Open questions: engine task list, status values, slot numbering, Open questions: the second pass (416 questions), AI-001 The full list of task classes the engine has (not only tuned ones) (Open), AI-002 Task status values and what each means, measured (Open), AI-003 How primary and secondary task slots are numbered (Open), The AI architecture (R17.1), Where the work is: second pass 203, links 147, in-game tests 83, engine RE 6, Question status values (Open, Partly answered, Answered)

### Community 111 - "Ambient Life (2) (3)"
Cohesion: 0.22
Nodes (11): Ambient life, Ambient task tunables (defaulttasks.ymt), Flying and swimming wander (birds, fish), CAmbientLookAt, CTaskAmbientClips, Open question: ambient ped despawn distance (R17.9), General and weapon event tunables, AI-007 How far from the player ambient peds despawn (Open) (+3 more)

### Community 112 - "Globals and Save Data (2) (3)"
Cohesion: 0.18
Nodes (10): Who sets each bit of .f_204/.f_203 (shared header, mod shops, jobs, freemode), Global_2658291[p].f_204/.f_203 per-player flag words, 16 named parts of .f_260 (property OWNED stats), Global_1845250[p].f_260 stat-backed state, Global_1845250[p].f_97 bit-field sub-structure, Global_1845250 GPBD_FM (player broadcast data, 880/player), Global_2658291 GlobalplayerBD (player broadcast data, 468/player), mpstatscharactermappingdata.xml (stat index names) (+2 more)

### Community 113 - "Economy and Pickups (3)"
Cohesion: 0.25
Nodes (10): Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file, ENT-016 How many Euphoria ragdolls run at once before peds fall back to ... (Open), ENT-017 Which tuning set is chosen for which weapon and vehicle, and the 3 ... (Open), ENT-018 Fall damage by height (Open), ENT-019 What nm_blend_out_sets.meta sets for getting up (Open) (+2 more)

### Community 114 - "Story Mission Anatomy (2) (3)"
Cohesion: 0.25
Nodes (11): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder natives, NoEditorRestrictions community patch, REPLAY_RECORD_BACK_FOR_TIME usage, GP-023 What exactly NoEditorRestrictions patches, and the vanilla limits it ... (Open), GP-024 The meaning of replay_controller states 1 to 6 and 11 to 13 (Open), GP-025 The REPLAY_START_EVENT and REPLAY_RECORD_BACK_FOR_TIME type numbers (Open) (+3 more)

### Community 115 - "Economy and Pickups (3) (2)"
Cohesion: 0.18
Nodes (8): Cookbook: vehicles and handling, Pattern: add-on car via DLC pack, Driving styles 786603 careful / 786468 rushed, handling.meta, vehicles.meta, carcols.meta, carvariations.meta, Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta, Pattern: weapon loadout, Category: vehicle and model add-ons

### Community 116 - "SHVDN Scripting Guide (2) (2)"
Cohesion: 0.18
Nodes (10): Steps 5/6/7 are alternatives (C#, Lua, C++), ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini, Language-for-job table (XML, C#, Lua, C++, natives, JSON...), ScriptHookVDotNet v2 (2.11.6), 06 The Lua plugin (LUA.asi), scripts/main.lua + addins structure, No console/log: debug via screen and io (+2 more)

### Community 117 - "DECORATOR and ENTITY Natives"
Cohesion: 0.18
Nodes (11): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION, GET_ENTITY_COORDS (+3 more)

### Community 118 - "Audio System (2)"
Cohesion: 0.24
Nodes (10): 54 sound archives (x64/audio/sfx, .awc), Audio (folder index), Speech and dialogue, Ambient speech contexts (PLAY_PED_AMBIENT_SPEECH_NATIVE), Named character voices (S_MISC), Scripted speech archives (SS_AC to SS_UZ), AUD-009 The list of contexts each voice has, from speech2.dat4.rel (Open), AUD-010 Which block name maps to which mission, for all 331 containers (Open) (+2 more)

### Community 119 - "Globals and Save Data (3)"
Cohesion: 0.22
Nodes (10): Global_2097536 (leaderboard rows for display), Global_2733002 (interaction-menu local state), am_pi_menu (interaction menu), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780, Leaderboard board IDs per screen (39 IDs), Shared leaderboard library (30 scripts), LEADERBOARDS2_READ_* natives, Story minigame boards (golf 193, darts 190, tennis 283, pilot school 965-974 ...) (+2 more)

### Community 120 - "Strangers and Side Content (2)"
Cohesion: 0.22
Nodes (10): Cookbook: spawning peds and giving them AI, Pattern: bodyguard ped, pedpersonality.ymt, combatbehaviour.meta, pedaccuracy.meta, Relationship groups natives, Mod map: what to read for the mod you want to make, Category: graphics and visual mods, Category: LSPDFR and police roleplay, Category: save games (+2 more)

### Community 121 - "Story Mission Anatomy (2) (4)"
Cohesion: 0.31
Nodes (10): GP-016 Where armenian1, jewelry_heist and trevor1 set the skip flag ... (Open), GP-017 The exact meaning of replay_controller states 1 to 6 and 11 to 13 (Open), GP-018 How the snapshot in Global_108447 is restored on retry, and what it ... (Answered), GP-019 How crew skill changes the heist take and the fail labels in Local_3373 (Open), GP-020 How mission_repeat_controller replays a mission without moving the flow ... (Answered), GP-021 What the mission triggerers build before a mission starts (lead-in ... (Open), GP-022 Where armenian1, jewelry_heist and trevor1 unlock their skip (they ... (Open), GP-033 How mission_repeat_controller replays a mission without moving the flow (Answered) (+2 more)

### Community 122 - "Globals and Save Data (2) (2)"
Cohesion: 0.25
Nodes (9): landing_pre_startup (empty), 146 script brains, standard_global_init, Block owner scripts table (references per block), Blocks 13 and 15: dead code behind two never-set flags, Global_3407872 (block 13, behind Global_2883694), Global_3932160 (block 15, behind Global_2883693), 21 global blocks of 262,144 slots (+1 more)

### Community 123 - "Boot and Script Control 2 (3)"
Cohesion: 0.50
Nodes (9): Global map open questions, CORE-009 Field layout of the player broadcast data (Global_1845250, ... (Mostly answered), CORE-010 The tunable index list: which Global_262145.f_<n> is which tunable (Open), CORE-011 What the references into blocks 13 and 15 are (Answered), CORE-012 Roles of the Known rows above, by reading one use each (Answered), Global map guide (R0.4), ON-003 The fields of the player and server broadcast data (Answered at block level), ON-050 The layout of the big broadcast blocks (Answered at block level) (+1 more)

### Community 124 - "RPF Archives and Music Mods (3)"
Cohesion: 0.22
Nodes (7): Core engine (folder index), Surviving game updates, Asset dependency list, Protecting a working install (backup, delay, rollback), ScriptHookV build gate, update-check.ps1 tool, Update day checklist

### Community 125 - "Repo Rules and Workflow (3)"
Cohesion: 0.25
Nodes (7): Blocked extensions list, file-rules check (GitHub workflow), Download-and-run (RISKY) patterns, 500 KB size limit, File rules table, Tools to read the game: CodeWalker, OpenIV, Git, decompile, PowerShell, bash, NativeDB, Tools and resources page (belongs to everyone)

### Community 126 - "EVENT and FIRE Natives"
Cohesion: 0.25
Nodes (8): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions, STOP_FIRE_IN_RANGE

### Community 127 - "Story Mission Anatomy (2) (2) (2)"
Cohesion: 0.33
Nodes (7): Global_102466/108447/96580/96581 (checkpoint, snapshot, skip), Mission checkpoints, Checkpoint player snapshot (Global_108447), PLAYSTATS_MISSION_CHECKPOINT (telemetry), What the snapshot leaves out (stats, collectables, flow flags), Restoring the checkpoint snapshot on retry (replay_controller), Flow state in story save f_9092

### Community 128 - "STREAMING Natives"
Cohesion: 0.33
Nodes (7): CAN_REGISTER_MISSION_PEDS/VEHICLES/OBJECTS, HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 129 - "Globals and Save Data (2)"
Cohesion: 0.40
Nodes (6): Global_1835511 GSBD_FM (host broadcast block), Global_2649159 GSBD (server broadcast data), Global_2650423 GSBD_BlockB (host broadcast block), Global_2652579 GSBD_BlockC (host broadcast block), Busiest server broadcast fields (GSBD.f_2 entity areas, GSBD_BlockB.f_199 ...), GSBD.f_2 networked entity areas (NETWORK_ADD_ENTITY_AREA)

### Community 130 - "Economy and Pickups (2) (2)"
Cohesion: 0.33
Nodes (6): Name labels (gameName, vehicleMakeName, HumanNameHash), Behaviour by reference (personality, combat info, decision maker), popgroups.ymt ped and vehicle groups, Vehicle groups in popgroups.ymt, 581 DLC vehicle models, vehicles.meta

### Community 131 - "Story Mission Anatomy (2) (2) (3)"
Cohesion: 0.33
Nodes (6): Crew choice read from story save (gunman, driver, hacker), Heist approach A/B and crew, Heist take counter (CMN_TAKE, kept in Global_102429.f_12), jewelry_heist (The Jewel Store Job), replay_controller retry screen states, Mission replay (replay_controller)

### Community 132 - "Online UI Screens (2) (2)"
Cohesion: 0.47
Nodes (6): appinternet (in-game websites), NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, NET_GAMESERVER_IS_SESSION_VALID, Transaction server NET_GAMESERVER_*, Seven server services behind the Online UI, appinternet websites as a shop front (519 transaction calls)

### Community 133 - "Issue Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 134 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 135 - "PAD Natives"
Cohesion: 0.33
Nodes (6): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace, SET_INPUT_EXCLUSIVE

### Community 136 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 137 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 138 - "Native Usage Index (2)"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 139 - "Audio System (3)"
Cohesion: 0.40
Nodes (4): Cookbook: audio, .awc containers plus .dat*.rel config, Pattern: looping alarm, PLAY_SOUND_FRONTEND / GET_SOUND_ID / START_AUDIO_SCENE natives

### Community 140 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 141 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 142 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 144 - "HUD Colours and Blips (6)"
Cohesion: 0.50
Nodes (4): Cookbook: UI and HUD, frontend.xml and hudcolor.dat, HIDE_HUD_COMPONENT_THIS_FRAME, scaleform movies, text commands, Pattern: timer with big message

### Community 145 - "Economy and Pickups (3) (3)"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 146 - "Native Namespace Map"
Cohesion: 0.50
Nodes (4): LOCALIZATION natives used by the game scripts, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type

### Community 147 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 148 - "Native Usage Index (2)"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 149 - "SHAPETEST Natives"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 151 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

### Community 152 - "SHAPETEST Natives (2)"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

## Knowledge Gaps
- **637 isolated node(s):** `Activity fees and pay table`, `Hunting score and weapon factor`, `Minigames are 42 entries worth 10% of completion`, `Mission candidate slot`, `Odd-job pay goes through story properties` (+632 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 717 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Issue and PR Templates 2` to `DLC Packs and Vehicles (2)`, `Handling and How Mods Work`, `Native Usage Index`, `Globals and Save Data (2)`, `TASK Natives`, `Globals and Save Data 3`, `Minigames and Activities 2`, `Rockstar Creator (2)`, `Globals and Save Data (2) (2)`, `C# Example Mods`, `Combat and AI Tuning (2)`, `Rockstar Creator`, `Ambient Life`, `Freemode Internals`, `Navigation and Streaming (2)`, `Ambient Life (2)`, `Story Mission Anatomy`, `Online Properties`, `HUD Colours and Blips`, `Combat and AI Tuning`, `Economy and Pickups`, `Minigames and Activities 2 (2)`, `Rockstar Creator (3)`, `Online Properties (2)`, `Online DLC Storylines (3)`, `Story Mission Anatomy (3)`, `Weapons`, `Physics Cost and Cleanup (2)`, `Audio System`, `Story Mission Anatomy (2)`, `Story vs Online Scripts`, `Story vs Online Scripts (2)`, `Performance and Script Load (5)`, `Combat and AI Tuning (2)`, `Story Mission Anatomy (2) (2)`, `Globals and Save Data 3 (2)`, `Online DLC Storylines (2)`, `Performance and Script Load (2)`, `Driving AI`, `Physics Cost and Cleanup (2) (2)`, `Natives as Engine API`, `Issue and PR Templates`, `RPF Archives and Music Mods (3)`, `Economy and Pickups (2)`, `How GTA Online Works (2)`, `RPF Archives and Music Mods`, `Credits and File Rules`, `Minigames and Activities 2 (3)`, `Story Mission Anatomy (3) (2)`, `Time Weather Wind (2)`, `Strangers and Side Content (2)`, `RPF Archives and Music Mods (2)`, `HUD Colours and Blips (4)`, `SHVDN Scripting Guide`, `Natives as Engine API (2)`, `RPF Archives and Music Mods (2) (2)`, `Online DLC Storylines`, `Rendering and LOD (2)`, `RPF Archives and Music Mods (2)`, `Repo Rules and Workflow 2`, `Credits and File Rules (2)`, `Ambient Life (3)`, `Ambient Life (3) (2)`, `Weapons (2)`, `Story Mission Anatomy (2) (2)`, `How GTA Online Works`, `Navigation and Streaming`, `RPF Archives and Music Mods (4)`, `Combat and AI Tuning (3)`, `Combat and AI Tuning (4)`, `Ambient Life (3) (3)`, `Performance and Script Load (3)`, `Ambient Life (4)`, `HUD Colours and Blips (5)`, `Script VM Contracts 2`, `Strangers and Side Content`, `Ambient Life (2) (2)`, `Navigation and Streaming (2) (2)`, `Natives as Engine API (2)`, `Ambient Life (3) (4)`, `RPF Archives and Music Mods (5)`, `Performance and Script Load (4)`, `Rendering and LOD (2) (2)`, `Rendering and LOD`, `HUD Colours and Blips (2)`, `Issue and PR Templates 2 (2)`, `Ambient Life (2) (3)`, `Economy and Pickups (3)`, `Story Mission Anatomy (2) (3)`, `Audio System (2)`, `RPF Archives and Music Mods (3)`?**
  _High betweenness centrality (0.260) - this node is a cross-community bridge._
- **Are the 91 inferred relationships involving `In-game test card` (e.g. with `Research workflow (one topic)` and `AI-002 Task status values and what each means, measured (Open)`) actually correct?**
  _`In-game test card` has 91 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Activity fees and pay table`, `Hunting score and weapon factor`, `Minigames are 42 entries worth 10% of completion` to the rest of the system?**
  _637 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `DLC Packs and Vehicles (2)` be split into smaller, more focused modules?**
  _Cohesion score 0.06015037593984962 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Strangers and Side Content (2)` to `DLC Packs and Vehicles (2)`, `Handling and How Mods Work`, `TASK Natives`, `Globals and Save Data 3`, `Minigames and Activities 2`, `Globals and Save Data (2) (2)`, `Audio System (3)`, `C# Example Mods`, `Combat and AI Tuning (2)`, `HUD Colours and Blips (6)`, `Ambient Life`, `Freemode Internals`, `Navigation and Streaming (2)`, `Ambient Life (2)`, `Story Mission Anatomy`, `Combat and AI Tuning`, `Economy and Pickups`, `Minigames and Activities 2 (2)`, `Rockstar Creator (3)`, `Story Mission Anatomy (3)`, `Weapons`, `Physics Cost and Cleanup (2)`, `Audio System`, `Performance and Script Load (5)`, `Combat and AI Tuning (2)`, `Story Mission Anatomy (2) (2)`, `Globals and Save Data 3 (2)`, `Online DLC Storylines (2)`, `Physics Cost and Cleanup (2) (2)`, `Natives as Engine API`, `Issue and PR Templates`, `RPF Archives and Music Mods (3)`, `Economy and Pickups (2)`, `How GTA Online Works (2)`, `RPF Archives and Music Mods`, `Minigames and Activities 2 (3)`, `Story Mission Anatomy (3) (2)`, `Time Weather Wind (2)`, `Strangers and Side Content (2)`, `RPF Archives and Music Mods (2)`, `HUD Colours and Blips (4)`, `SHVDN Scripting Guide`, `Natives as Engine API (2)`, `RPF Archives and Music Mods (2) (2)`, `Online DLC Storylines`, `Rendering and LOD (2)`, `RPF Archives and Music Mods (2)`, `Ambient Life (3) (2)`, `Weapons (2)`, `Story Mission Anatomy (2) (2)`, `Navigation and Streaming`, `RPF Archives and Music Mods (4)`, `SHVDN Scripting Guide (2)`, `Combat and AI Tuning (3)`, `Combat and AI Tuning (4)`, `Ambient Life (3) (3)`, `Ambient Life (4)`, `HUD Colours and Blips (5)`, `Issue and PR Templates (2)`, `Strangers and Side Content`, `Ambient Life (2) (2)`, `Navigation and Streaming (2) (2)`, `Ambient Life (3) (4)`, `RPF Archives and Music Mods (5)`, `Rendering and LOD (2) (2)`, `Rendering and LOD`, `HUD Colours and Blips (2)`, `Ambient Life (2) (3)`, `Economy and Pickups (3)`, `Economy and Pickups (3) (2)`, `Audio System (2)`, `RPF Archives and Music Mods (3)`?**
  _High betweenness centrality (0.148) - this node is a cross-community bridge._
- **Should `Ped Health and Death` be split into smaller, more focused modules?**
  _Cohesion score 0.07957393483709273 - nodes in this community are weakly interconnected._
- **Why does `The global variable map (R0.4)` connect `Globals and Save Data (2) (2)` to `Globals and Save Data (2)`, `Handling and How Mods Work`, `Globals and Save Data (2)`, `Globals and Save Data`, `Boot and Script Control 4`, `Rockstar Creator`, `Freemode Internals`, `Rockstar Creator (3)`, `Story Mission Anatomy (3)`, `Boot and Script Control 2 (2)`, `Story vs Online Scripts`, `Story Mission Anatomy (2) (2)`, `Globals and Save Data 3 (2)`, `How GTA Online Works (2)`, `Issue and PR Templates 2`, `Globals and Save Data (2) (3)`, `Globals and Save Data (3)`, `Strangers and Side Content (2)`, `Globals and Save Data (2) (2)`, `Boot and Script Control 2 (3)`, `RPF Archives and Music Mods (3)`, `Story Mission Anatomy (2) (2) (2)`?**
  _High betweenness centrality (0.076) - this node is a cross-community bridge._