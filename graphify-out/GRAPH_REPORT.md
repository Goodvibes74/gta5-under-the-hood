# Graph Report - gta5-under-the-hood  (2026-11-04)

## Corpus Check
- 22 files · ~503,935 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 4656 nodes · 10527 edges · 192 communities (190 shown, 2 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 570 edges (avg confidence: 0.86)
- Token cost: 594,257 input · 0 output

## Community Hubs (Navigation)
- Rockstar Creator internals
- Runtime scripts: main_persistent
- Native namespace map
- Properties in GTA Online
- The global variable map: FMMC globals
- Surviving game updates
- Economy and pickups
- The script VM
- The story mission flow
- How GTA Online works
- Props, archetypes and doors
- APPS and BUILTIN natives
- Rockstar services
- Music and radio: RadioStation object
- Boot and script control
- Fire, explosions and projectiles
- Examples and data-file sets
- Credits and build version
- Physics cost
- Native usage
- Animation
- Measuring performance
- Memory, pools and limits
- Time, weather and wind
- Timecycle and post effects
- Population
- Scenarios and ambient life
- Text labels
- Strangers, freaks and side content
- Script launch graph
- Anatomy of a story mission
- Organisations and businesses
- The job lobby
- Interaction menu, phone and apps
- AI cost and level of detail
- Random events
- Cookbook: Pattern 110
- How audio is organised
- Weapons: AmmoMax six ammo caps
- Cutscenes and dialogue
- Flying
- Particles and decals
- Wanted level and police
- Controls and camera
- Text and names in content
- 1. How mods work
- Peds
- Interiors and IPLs
- Online cosmetics and shops
- Minigames and activities
- Heists in GTA Online / Open questions
- Story systems that clash with an Online  / Open questions
- Perception and events
- How Rockstar's scripts drive AI
- Completion, autosave and achievements
- Character switching
- Inside freemode
- VEHICLE natives used by the game scripts
- CONTRIBUTING.md
- Vehicles
- PED natives used by the game scripts
- Data batch PC1 rows
- Ambient life
- Appearance and clothing
- DLC storylines in GTA Online
- Stats, tunables and the server's role
- Load times and stutter
- Collision, materials and shape tests
- Scaleform movies
- 07 Legacy / 03 Menus and UI
- GTA Online / Open questions
- Police and service AI
- Vehicle generators and traffic
- Respawn, death and arrest / Open questions
- Cameras
- Vehicle handling data
- Map data
- NETWORK natives used by the game scripts
- CLAUDE.md
- Data needs: Data batch D8
- System requirements outside the game fol
- Navigation and pathfinding
- Speech and dialogue
- Swimming and diving
- Natives as the engine API
- STATS natives used by the game scripts
- Tools and resources
- Glossary
- Data batches D10 and D11
- Data batch D7 (engine config)
- Relationships and groups
- Ped physics and ragdoll
- Open questions: Block A
- Water and buoyancy
- Native usage index
- PLAYER natives used by the game scripts
- Combat and AI
- The Online character creator
- Open questions: Questions by category
- Data batches D1 and D12
- Decisions and personalities
- Graphics settings
- Replay, director mode and the Rockstar E
- Transitions and sessions / Open questions
- Handoff: Status
- Block B and AI cost questions
- Driving AI
- Rendering, visual settings and LOD
- Driving and AI driving
- Animation and camera questions
- Server-backed Online screens: Server calls per screen table
- Player skills and abilities
- 7. Your first C++
- Archives and the content system
- Streaming
- Swimming and diving questions
- Saves
- UGC mission files / Archive and data file atlas
- TASK natives
- The AI architecture
- Health, armour, death and arrest / Open questions
- Online tab and in-game websites
- Tools / PC session plan
- Driving AI questions
- Boot and getting-started questions
- Ped personality questions
- Missions
- HUD, colours and blips
- Pause and Online menus
- Open questions / PC session plan: Partial data results and what would fini
- Open questions: Batch D8
- AUDIO natives
- Story-mode UI
- AI open questions
- Open questions / PC session plan: Weapons questions
- Open questions: Batch P4.2
- Audio questions
- Water and buoyancy questions
- Graphics settings, one by one
- Server-backed Online screens
- Reading the repo in Obsidian
- Streaming, memory and video memory
- ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip
- Heist crews and enemy groups
- WEAPON natives used by the game scripts
- Completion and autosave questions
- Timecycle and post effects questions
- Hashed function name questions
- Block C world and AI questions
- Animal models and populations
- Data needs: common.rpf
- Data batch D6 (appearance)
- Ragdoll tuning and fall damage
- Wanted level and relationships
- Shape tests and collision layers
- Text labels questions
- Tattoos and barber shops
- Weather timecycle files
- Police and service AI questions
- Data needs and extraction tools
- Post-death weather reroll
- Ragdoll and fall damage questions
- Open questions / PC session plan: Time, weather and wind questions
- DLC natives used by the game scripts / LOBBY natives used by the game scripts
- Patrol routes
- User interface topics
- AI cookbook and patterns
- Cookbook: Vehicle traps
- DLC storylines questions
- MISC natives used by the game scripts
- Weapons: Bullet damage model
- Weapons data files
- Business computer apps
- Cutscenes and dialogue questions
- DATAFILE natives used by the game script / HUD natives used by the game scripts
- INTERIOR natives used by the game script
- MONEY natives
- PHYSICS natives used by the game scripts
- Ped component variations
- Script launch graph questions
- Vehicle handling questions
- NETSHOPPING natives
- OBJECT natives used by the game scripts
- PAD natives
- RECORDING natives used by the game scrip
- SCRIPT natives
- SOCIALCLUB natives used by the game scri
- ITEMSETS natives
- REPLAY natives used by the game scripts
- SECURITY natives used by the game script
- Mission cookbook
- PC session safety rules

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 245 edges
2. `Native namespace map` - 143 edges
3. `Mod map: what to read for the mod you want to make` - 112 edges
4. `Runtime scripts: the scripts that keep the game running` - 104 edges
5. `PC session plan: what to do at the game PC` - 103 edges
6. `Native usage: which scripts call which natives` - 97 edges
7. `Tools` - 89 edges
8. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 88 edges
9. `Properties in GTA Online` - 83 edges
10. `The global variable map` - 83 edges

## Surprising Connections (you probably didn't know these)
- `GTA-V-Decompiled-Scripts community decompile` --semantically_similar_to--> `Decompiled scripts (community decompile)`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CLAUDE.md
- `ScriptHookVDotNet.asi` --semantically_similar_to--> `ScriptHookVDotNet (SHVDN)`  [INFERRED] [semantically similar]
  docs/00-getting-started/system-requirements.md → scripting/script-vm.md
- `ADD_SHOCKING_EVENT_FOR_ENTITY` --semantically_similar_to--> `ADD_SHOCKING_EVENT_FOR_ENTITY / _AT_POSITION`  [INFERRED] [semantically similar]
  scripting/native-usage/EVENT.md → docs/ai/perception-and-events.md
- `ScriptHookV (SHV)` --semantically_similar_to--> `ScriptHookV`  [INFERRED] [semantically similar]
  docs/00-getting-started/glossary.md → modding/02-tools-you-need.md
- `STOP_SCRIPTED_CONVERSATION` --semantically_similar_to--> `AUDIO::STOP_SCRIPTED_CONVERSATION`  [INFERRED] [semantically similar]
  docs/audio/speech-and-dialogue.md → scripting/native-usage-index.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **Activity start flow** — docs_gameplay_missions_minigames_and_activities_mf_control_bitsetids_0, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_minigames_and_activities_mission_candidate_slot, docs_gameplay_missions_minigames_and_activities_playstats_oddjob_done [EXTRACTED 1.00]
- **Load, check and free a mission text block** — docs_ui_text_labels_request_additional_text, docs_ui_text_labels_has_this_additional_text_loaded, docs_ui_text_labels_clear_additional_text, docs_ui_text_labels_text_slots [EXTRACTED 1.00]
- **ASI script lifecycle** — modding_07_first_asi_mod_dllmain, modding_07_first_asi_mod_scriptregister, modding_07_first_asi_mod_scriptmain, modding_07_first_asi_mod_scriptwait_loop, modding_07_first_asi_mod_keyboard_handler [EXTRACTED 1.00]
- **Boot script chain: startup to main** — docs_00_getting_started_boot_startup_script, docs_world_map_data_standard_global_init, docs_online_interaction_menu_phone_apps_standard_global_reg, docs_online_job_lobby_main_persistent, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Scripted conversation request pipeline** — docs_gameplay_missions_cutscenes_and_dialogue_dialogue_request_globals, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler_states, docs_gameplay_missions_cutscenes_and_dialogue_conversation_root_labels, docs_gameplay_missions_cutscenes_and_dialogue_create_new_scripted_conversation [EXTRACTED 1.00]
- **Explosion definition: type data, VFX, camera shake and projectiles** — docs_physics_fire_explosions_projectiles_explosion_ymt, docs_physics_fire_explosions_projectiles_explosionfx_dat, docs_rendering_cameras_camera_shakes, docs_physics_fire_explosions_projectiles_weapons_meta_projectile_ammo [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Flow progress storage in stats** — docs_online_dlc_storylines_freemode_story_flow, docs_online_dlc_storylines_stat_7880, docs_online_dlc_storylines_packed_stat_bools, docs_online_dlc_storylines_exec_flw [EXTRACTED 1.00]
- **Freemode player broadcast blocks** — docs_core_global_map_global_1845250, docs_core_global_map_global_2658291, docs_core_global_map_global_1892653, docs_core_global_map_network_register_player_broadcast_variables, docs_core_global_map_freemode [EXTRACTED 1.00]
- **freemode player and host state machines on broadcast data** — docs_online_07_freemode_player_state_machine, docs_online_07_freemode_host_state_machine, docs_online_07_freemode_global_2658291, docs_online_07_freemode_global_2649159, docs_online_07_freemode_host_participant_rotation [EXTRACTED 1.00]
- **Four heist generations and their planning scripts** — docs_online_heists_classic_planning_board, docs_online_heists_gb_gang_ops_planning, docs_online_heists_gb_casino_heist_planning, docs_online_heists_heist_island_planning [EXTRACTED 1.00]
- **Hostile ped recipe: side, attributes, accuracy, defensive area, task, events blocked, keep task** — docs_ai_relationships_and_groups_set_ped_relationship_group_hash, docs_ai_script_ai_patterns_set_ped_combat_attributes, docs_ai_script_ai_patterns_set_ped_accuracy, docs_ai_script_ai_patterns_set_ped_sphere_defensive_area, docs_ai_script_ai_patterns_task_combat_ped, docs_ai_combat_and_perception_set_blocking_of_non_temporary_events [EXTRACTED 1.00]
- **Interior activation flow (IPL, pin, entity set, refresh)** — docs_world_interiors_and_ipls_request_ipl, docs_core_streaming_pin_interior_in_memory, docs_world_interiors_and_ipls_is_interior_ready, docs_world_interiors_and_ipls_activate_interior_entity_set, docs_world_interiors_and_ipls_refresh_interior [EXTRACTED 1.00]
- **Job launch pipeline: corona to controller** — docs_online_heists_fmmc_launcher, docs_online_job_lobby_activity_table, scripting_native_usage_builtin_start_new_script_with_args, docs_online_job_lobby_start_argument_block, docs_online_heists_fm_mission_controller [EXTRACTED 1.00]
- **Mod runtimes beside the script VM** — modding_02_tools_you_need_scripthookv, scripting_script_vm_shvdn, scripting_script_vm_lua_asi, scripting_script_vm_scripttimeoutthreshold [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Music event playback chain** — docs_audio_music_and_radio_trigger_music_event, docs_audio_music_and_radio_music_events, docs_audio_music_and_radio_starttrackaction, docs_audio_music_and_radio_mood, docs_audio_music_and_radio_stem_mix [EXTRACTED 1.00]
- **Native name resolution pipeline** — scripting_native_usage_native_tables, scripting_natives_nativedb, scripting_native_usage_decompiler_name_aliases, scripting_native_usage_unk_0x_hash_calls [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Load-area-before-task navigation pattern** — docs_ai_navigation_add_navmesh_required_region, docs_ai_navigation_is_navmesh_loaded_in_area, scripting_native_usage_task_task_follow_nav_mesh_to_coord, docs_ai_navigation_navmesh_tiles_ynv [EXTRACTED 1.00]
- **Online systems that depend on Rockstar's servers** — docs_online_01_how_online_works_online_stats, docs_online_01_how_online_works_gameserver_transactions, docs_online_01_how_online_works_tunables, docs_online_01_how_online_works_ugc_cloud_content, docs_online_01_how_online_works_network_session [EXTRACTED 1.00]
- **Ped AI data: personality, decision maker, combat info, relationship group** — docs_ai_decisions_and_personalities_pedpersonality_ymt, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_combat_and_perception_events_meta [EXTRACTED 1.00]
- **Character switch pipeline** — docs_gameplay_player_character_switching_selector, docs_gameplay_player_character_switching_player_controller_b, docs_gameplay_player_character_switching_start_player_switch, docs_gameplay_player_character_switching_change_player_ped, docs_gameplay_player_character_switching_player_timetable_scene, docs_gameplay_player_character_switching_arrival_scene_picker [EXTRACTED 1.00]
- **Pool and limit adjuster plugins** — docs_core_memory_and_pools_heapadjuster, docs_core_memory_and_pools_packfilelimitadjuster, docs_core_memory_and_pools_weaponlimitsadjuster, docs_core_memory_and_pools_decalslimit_patch, docs_core_memory_and_pools_poolmanager [EXTRACTED 1.00]
- **Property purchase and trade-in flow** — docs_online_properties_price_layers, docs_online_properties_net_gameserver_get_price, docs_online_properties_network_earn_from_property, docs_online_properties_network_buy_property [EXTRACTED 1.00]
- **Respawn resets weather and look** — docs_world_time_and_weather_respawn_controller, docs_world_time_and_weather_clear_weather_type_persist, docs_world_time_and_weather_set_random_weather_type, docs_rendering_timecycle_and_post_effects_clear_timecycle_modifier, docs_world_time_and_weather_global_4525837 [EXTRACTED 1.00]
- **Rockstar's physics brakes** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_before_after, docs_performance_physics_cost_ragdoll_control, docs_performance_physics_cost_density_per_frame, docs_performance_physics_cost_frame_count_spreading [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Skill system data flow** — docs_gameplay_player_skills_and_abilities_spstatssetup_xml, docs_gameplay_player_skills_and_abilities_playerinfo_ymt, docs_gameplay_player_skills_and_abilities_stats_controller, docs_gameplay_player_skills_and_abilities_seven_skills, docs_gameplay_player_skills_and_abilities_skill_growth_formula [EXTRACTED 1.00]
- **Story death/arrest restart flow** — docs_gameplay_player_respawn_death_and_arrest_standard_global_init, docs_gameplay_player_respawn_death_and_arrest_hospital_restarts, docs_gameplay_player_respawn_death_and_arrest_police_restarts, docs_gameplay_player_respawn_death_and_arrest_respawn_controller, docs_gameplay_player_respawn_death_and_arrest_death_fee, docs_gameplay_player_respawn_death_and_arrest_arrest_penalty, docs_gameplay_player_respawn_death_and_arrest_respawn_resets, docs_gameplay_player_respawn_death_and_arrest_pause_death_arrest_restart [EXTRACTED 1.00]
- **Story unlock pipeline: build, run and gate strands** — docs_gameplay_missions_story_flow_initial, docs_gameplay_missions_story_flow_flow_program, docs_gameplay_missions_story_flow_flow_controller, docs_gameplay_missions_story_flow_flow_strands, docs_gameplay_missions_story_flow_flow_flags, docs_gameplay_missions_story_flow_mission_triggerers [EXTRACTED 1.00]
- **Story mission fail, retry and replay flow** — docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_replay_controller, docs_gameplay_missions_mission_anatomy_flow_controller, docs_gameplay_missions_mission_anatomy_retry_screen_states, docs_gameplay_missions_mission_anatomy_player_snapshot, docs_gameplay_missions_mission_anatomy_skip_section [EXTRACTED 1.00]
- **Story mode launch backbone** — scripting_script_launch_graph_startup, scripting_script_launch_graph_standard_global_reg, scripting_script_launch_graph_main_persistent, scripting_script_launch_graph_main, scripting_script_launch_graph_initial, scripting_script_launch_graph_flow_controller [EXTRACTED 1.00]
- **Vehicle display-name chain** — docs_entities_vehicles_vehicles_vehicles_meta, docs_entities_objects_text_and_names_gamename, docs_ui_text_labels_global_gxt2, docs_ui_text_labels_get_display_name_from_vehicle_model, docs_entities_objects_text_and_names_dlctext_meta [EXTRACTED 1.00]
- **water.xml quad system** — docs_physics_water_and_buoyancy_water_xml, docs_physics_water_and_buoyancy_water_quads, docs_physics_water_and_buoyancy_calming_quads, docs_physics_water_and_buoyancy_wave_quads, docs_physics_water_and_buoyancy_quad_types [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **How the engine keeps AI affordable** — docs_ai_ai_cost_and_lod_maxtotalpeds, docs_ai_ai_cost_and_lod_vehicletimeslicemaxupdatesperframe, docs_ai_ai_cost_and_lod_ctaskmotionbasiclocomotionlowlod, docs_ai_ai_cost_and_lod_dummy_vehicles, docs_ai_ai_cost_and_lod_timeslicing [INFERRED 0.85]
- **Business supplies-production-sell loop** — docs_online_organisations_and_businesses_business_loop, docs_online_organisations_and_businesses_biker_businesses, docs_online_organisations_and_businesses_production_timers, docs_online_organisations_and_businesses_business_computer_apps, docs_online_organisations_and_businesses_app_transactions [INFERRED 0.85]
- **Creator build, save and replay flow** — docs_online_creator_internals_cursor_ray, docs_online_creator_internals_prop_columns, docs_online_creator_internals_ugc_create_mission, docs_online_creator_internals_local_static_props, docs_online_creator_internals_fm_race_controler [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Crime to stars to dispatch: witness reporting, crime points, dispatch responses and search** — docs_ai_perception_and_events_cancallpolice, docs_ai_police_and_services_wantedlevelthresholds, docs_ai_police_and_services_wantedresponses, docs_ai_police_and_services_search_helpers, docs_ai_police_and_services_wantedtuning_ymt [INFERRED 0.85]
- **Weather to screen look pipeline** — docs_world_time_and_weather_weathercycles, docs_rendering_timecycle_and_post_effects_weather_timecycle, docs_rendering_timecycle_and_post_effects_timecycle_modifiers, docs_rendering_timecycle_and_post_effects_animated_post_effects [INFERRED 0.85]
- **Questions that need the executable (engine reverse engineering)** — open_questions_core_024, open_questions_core_015, open_questions_ai_001, open_questions_ai_003, open_questions_on_009, open_questions_on_052, open_questions_gp_087, open_questions_gp_092, open_questions_core_031, open_questions_ui_020, open_questions_gs_004 [INFERRED 0.85]
- **Engine-raised force-cleanup bits 16 and 32** — open_questions_core_017, open_questions_core_032, open_questions_on_060, open_questions_scr_011 [INFERRED 0.95]
- **Second-pass priority phases** — open_questions_phase_1, open_questions_phase_2, open_questions_phase_3, open_questions_phase_4, open_questions_leftovers_data_batches [EXTRACTED 1.00]
- **PC session: data files, executable, in-game tests** — pc_session_group_vehicles, pc_session_part2_executable, pc_session_block_a_performance, pc_session_codewalker [EXTRACTED 1.00]
- **Batch PC1 answered rows** — pc_session_results_part1_ai_024, pc_session_results_part1_ent_038, pc_session_results_part1_ren_011, pc_session_results_part1_phy_001, pc_session_results_part1_phy_004, pc_session_results_part1_ent_019, pc_session_results_part1_ai_014, pc_session_results_part1_ai_009 [EXTRACTED 1.00]
- **Second-pass workflow rules** — handoff_one_branch_per_phase, handoff_graph_once_per_phase, handoff_new_gaps_numbered, handoff_answered_only_if_really, handoff_check_numbers, handoff_lf_line_endings [EXTRACTED 1.00]
- **Event to response pipeline** — docs_ai_perception_and_events_event_system, docs_ai_perception_and_events_shocking_events, docs_ai_perception_and_events_decision_makers, docs_ai_perception_and_events_response_blocks, docs_ai_perception_and_events_response_tasks [EXTRACTED 1.00]
- **Population data layers (zones, bindings, schedules, groups)** — docs_entities_spawning_population_popzone_ipl, docs_ai_police_and_services_zonebind_ymt, docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_population_popgroups_ymt [EXTRACTED 1.00]
- **Script crowd-thinning natives** — docs_entities_spawning_population_set_ped_density_multiplier_this_frame, docs_entities_spawning_population_set_ped_non_creation_area, docs_entities_spawning_population_clear_area_of_peds_vehicles, docs_entities_spawning_population_set_ped_population_budget, docs_ai_ambient_life_set_ped_model_is_suppressed, docs_ai_ambient_life_set_scenario_type_enabled [INFERRED 0.85]
- **Loading collision before placing far entities** — docs_physics_collision_and_materials_set_focus_pos_and_vel, docs_physics_collision_and_materials_request_collision_at_coord, docs_physics_collision_and_materials_has_collision_loaded_around_entity, docs_physics_collision_and_materials_set_entity_load_collision_flag, docs_physics_collision_and_materials_warp_load_pattern [EXTRACTED 1.00]
- **Script camera lifecycle** — docs_rendering_cameras_create_cam, scripting_native_usage_camera_render_script_cams, docs_rendering_cameras_set_cam_active_with_interp, docs_rendering_cameras_stop_rendering_script_cams_using_catch_up, docs_rendering_cameras_script_camera_pattern [EXTRACTED 1.00]
- **Scaleform load-call-draw-release flow** — docs_ui_scaleform_request_scaleform_movie, scripting_native_usage_graphics_begin_scaleform_movie_method, docs_ui_scaleform_begin_text_command_scaleform_string, docs_ui_scaleform_draw_scaleform_movie_fullscreen, docs_ui_scaleform_set_scaleform_movie_as_no_longer_needed [EXTRACTED 1.00]

## Communities (192 total, 2 thin omitted)

### Community 0 - "Rockstar Creator internals"
Cohesion: 0.05
Nodes (69): Rockstar Creator internals, am_mp_creator_trailer / _aircraft (not the content creator), Stunt track bone snapping (bones 2 to 5), CREATE_MODEL_HIDE (Fixtures removed, dhprop), creator (hub script), Creator limits (200 props, 20 dynamic ...), DATAFILE natives, Dynamic props in deathmatch and mission controllers (+61 more)

### Community 1 - "Runtime scripts: main_persistent"
Cohesion: 0.05
Nodes (67): Force cleanup, ConfigScriptStackSizes, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, R0.2 Script cards for the runtime scripts, Runtime scripts: the scripts that keep the game running, achievement_controller, autosave_controller, blip_controller (+59 more)

### Community 2 - "Native namespace map"
Cohesion: 0.04
Nodes (64): SETUP_SHOP_PED_APPAREL_QUERY_TU, Native namespace map, 54 natives only in indirect-call code, Call_Loc indirect calls, DISABLE_CONTROL_ACTION, GET_CLOCK_YEAR, GET_ENTITY_PROOFS, IS_CONTENT_ITEM_LOCKED (+56 more)

### Community 3 - "Properties in GTA Online"
Cohesion: 0.06
Nodes (65): appbikerbusiness, Properties in GTA Online, ADD_BLIP_FOR_COORD, AM_MP_ARCADE, AM_MP_BUNKER, AM_MP_FIXER_HQ, AM_MP_HANGAR, AM_MP_NIGHTCLUB (+57 more)

### Community 4 - "The global variable map: FMMC globals"
Cohesion: 0.05
Nodes (57): The global variable map, Blocks 13 and 15 (dead code), GlobalplayerBD .f_204 / .f_203 flag words, GPBD_FM .f_260 (stat-backed state), GlobalplayerBD .f_325 (interior the player is in), freemode, Global_102429 (replay controller state), Global_102481 (shop data) (+49 more)

### Community 5 - "Surviving game updates"
Cohesion: 0.06
Nodes (53): Core engine, R11.2 An update-check tool, Surviving game updates, Things addressed by number (offsets, globals), Asset dependency list, Byte-pattern scans (FindPattern), Delaying updates in launchers, Native 0x0F7082C60FB479EF dropped in 3889 (+45 more)

### Community 6 - "Economy and pickups"
Cohesion: 0.07
Nodes (53): Economy and pickups, ADD_PICKUP_TO_INTERIOR_ROOM_BY_NAME, atm_trigger, BAWSAQ exchange, BSS_BSTR company labels, code_controller, Collectable scripts, CPickupData (+45 more)

### Community 7 - "The script VM"
Cohesion: 0.07
Nodes (50): Natives (script-to-engine interface), ASI loader load chain (dinput8, ScriptHookV), ScriptHookV, YSC reader (needed to settle pointer-only natives), R1.1, The script VM, director_mode script, error_listener script (+42 more)

### Community 8 - "The story mission flow"
Cohesion: 0.08
Nodes (52): R5.1, The story mission flow: how missions unlock, Activate strand command, Activate stranger mission command, agency_heist2 special builder, code_controller, What a fail does to the flow (pass/fail labels), Blitz Play prep 3 (fbi4_prep3, never activated) (+44 more)

### Community 9 - "How GTA Online works"
Cohesion: 0.07
Nodes (47): mpstatscharactermappingdata.xml, How GTA Online works, am_mp_* property scripts, Ambient events (am_* scripts), ambient_mp.ipl, Phone and computer app* scripts, Broadcast data (host and player), fmmc_launcher (corona) (+39 more)

### Community 10 - "Props, archetypes and doors"
Cohesion: 0.07
Nodes (48): IPLs (optional map sections), Props, archetypes and doors, 2D effects (extensions), ACTIVATE_PHYSICS, ADD_DOOR_TO_SYSTEM, Archetype, Archetype flag bits, Door auto-open flags (+40 more)

### Community 11 - "APPS and BUILTIN natives"
Cohesion: 0.05
Nodes (48): APPS natives used by the game scripts, APP_SET_APP / APP_SET_BLOCK / APP_CLOSE_BLOCK companion-app data, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, social_controller script, BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, TIMESTEP, TO_FLOAT (+40 more)

### Community 12 - "Rockstar services"
Cohesion: 0.07
Nodes (46): NET_GAMESERVER_GET_PRICE, Rockstar services, Catalogue keys (<name>_t<type>_v<version>), CATEGORY_VEHICLE_MOD, CATEGORY_WAREHOUSE_INTERIOR, Cloud files, Cloud stat slots, Crews (NETWORK_CLAN_*) (+38 more)

### Community 13 - "Music and radio: RadioStation object"
Cohesion: 0.06
Nodes (43): Music and radio, AUDIO_GAMEDATA content.xml entries, AUDIO_IS_SCRIPTED_MUSIC_PLAYING, .awc wave containers, CANCEL_MUSIC_EVENT, FM_COUNTDOWN_30S music event, fm_mission_controller, game.dat151.rel (audio game data) (+35 more)

### Community 14 - "Boot and script control"
Cohesion: 0.10
Nodes (44): Boot and script control: from launch to control, and between story and Online, Shared activity-type helper (212 scripts), Benchmark boot path, asiloader.log / ScriptHookV.log / ScriptHookVDotNet.log, director_mode, flow_controller, freemode, GET_INDEX_OF_CURRENT_LEVEL (+36 more)

### Community 15 - "Fire, explosions and projectiles"
Cohesion: 0.08
Nodes (40): Fire, explosions and projectiles, ADD_EXPLOSION, ADD_OWNED_EXPLOSION, bAppliesContinuousDamage, bForceNonTimedVfx, bIsSmokeGrenade, bSuppressCrime, CAmmoProjectileInfo (+32 more)

### Community 16 - "Examples and data-file sets"
Cohesion: 0.07
Nodes (40): Examples, Six SHVDN v3 C# sample scripts, materials.dat and related material files, Collision material table (213 materials), Ped AI data files, Ped AI data file set (relationships, perception, combat), File formats, ScriptHookVDotNet (+32 more)

### Community 17 - "Credits and build version"
Cohesion: 0.05
Nodes (42): Game version (Legacy 1.0.3725.0), Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Reading the decompiled game scripts, Community decompile repository (one commit per build), freemode started by maintransition with stack 35,250; creator 28,000 (+34 more)

### Community 18 - "Physics cost"
Cohesion: 0.08
Nodes (38): Physics cost, ACTIVATE_PHYSICS, ADD_EXPLOSION, ADD_ROPE, CLEAR_AREA, CLEAR_AREA_OF_OBJECTS, CLEAR_AREA_OF_PROJECTILES, CLEAR_AREA_OF_VEHICLES (+30 more)

### Community 19 - "Native usage"
Cohesion: 0.07
Nodes (42): SCR-001: Split `MISC` into sub-families with their own owners (weather, cheats,..., SCR-002: Which natives are reached only through shared helper code and never ca..., SCR-003: Which namespaces' unused natives still work in story mode (useful to m..., SCR-004: What `0x8F5D1AD832AEB06C` and `0x0F7082C60FB479EF` do (not in NativeDB..., SCR-005: Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` styl..., SCR-006: A story-only vs Online-only split of every native (which natives story..., SCR-007: What the table order is (not first use; maybe first use in compiled co..., Scripting open questions (+34 more)

### Community 20 - "Animation"
Cohesion: 0.08
Nodes (40): Animation, Animation memory groups, Base clip archives, Clip dictionaries (.ycd), Clip sets, clip_sets.ymt, common_anim.meta, conditionalanims.meta (+32 more)

### Community 21 - "Measuring performance"
Cohesion: 0.08
Nodes (35): Measuring performance, ARE_ANY_CCS_PENDING, -benchmark command-line switches, benchmark script, Benchmark 8-state loop, BMARK text block, Content change sets (GROUP_ON_DEMAND, 43 packs), CPU-bound vs GPU-bound test (+27 more)

### Community 22 - "Memory, pools and limits"
Cohesion: 0.07
Nodes (37): Memory, pools and limits, ArchiveCount, CAN_REGISTER_MISSION_PEDS / VEHICLES / OBJECTS, CEvent pool, ConfigModelInfo, ConfigPopulation, ConfigStreamingEngine, CTask pool (8,192) (+29 more)

### Community 23 - "Time, weather and wind"
Cohesion: 0.07
Nodes (39): WATER_OVERRIDE_SET_* natives, weather.xml wave values, Time, weather and wind, ADD_TO_CLOCK_TIME, branchbend_windsettings.xml, cheat_controller, clouds.xml, exile1 (+31 more)

### Community 24 - "Timecycle and post effects"
Cohesion: 0.06
Nodes (34): Timecycle and post effects, ADD_TCMODIFIER_OVERRIDE, AnimMode, ANIMPOSTFX_STOP, animpostfx.ymt, CAMERA_secuirity_FUZZ, DrugsMichaelAliensFight, FocusOut (+26 more)

### Community 25 - "Population"
Cohesion: 0.08
Nodes (37): zonebind.ymt, LOD settings (LodScale, MaxLodScale), Population, Birds and fish population groups (AERIAL, AQUATIC, WILDLIFE), cellphone_flashhand (phone signal bars), GET_ZONE_SCUMMINESS, lawResponseTime / lawResponseType, Missing schedule hash_7D143EDB (+29 more)

### Community 26 - "Scenarios and ambient life"
Cohesion: 0.09
Nodes (37): Scenarios and ambient life, act_cinema, ADD_SCENARIO_BLOCKING_AREA, Ambient aircraft and boats, Chaining graphs, HEIST_ISLAND_PEDS, MP_POLICE, ng_planes region files (+29 more)

### Community 27 - "Text labels"
Cohesion: 0.09
Nodes (38): Text labels, ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL, americandlc.rpf DLC text, *aud subtitle blocks, BEGIN_TEXT_COMMAND_DISPLAY_HELP, BEGIN_TEXT_COMMAND_DISPLAY_TEXT, BEGIN_TEXT_COMMAND_PRINT, BEGIN_TEXT_COMMAND_SET_BLIP_NAME (+30 more)

### Community 28 - "Strangers, freaks and side content"
Cohesion: 0.11
Nodes (35): 146 script brains (99 world-point, 47 object), Strangers, freaks and side content, appinternet (Epsilon website), atm_trigger, BailBond_Launcher, Brain set bit mask (story 1, Online 8), code_controller, completionpercentage_controller (+27 more)

### Community 29 - "Script launch graph"
Cohesion: 0.11
Nodes (37): Script launch graph (build 3725), am_mp_drone script, buddydeathresponse script, cellphone_controller script, cellphone_flashhand script, creator script, director_mode script, Engine-started scripts (startup, main, initial) (+29 more)

### Community 30 - "Anatomy of a story mission"
Cohesion: 0.11
Nodes (27): Anatomy of a story mission, armenian1 (Franklin and Lamar), Jewel Store Job crew tiers and take, flow_controller, Force cleanup handler (HAS_FORCE_CLEANUP_OCCURRED), Global_80529 mission pass bits, Heist approach (flow integer f_205[7]), jewelry_heist (The Jewel Store Job) (+19 more)

### Community 31 - "Organisations and businesses"
Cohesion: 0.11
Nodes (36): gb_* and fm_content_* business scripts, Organisations and businesses, am_launcher event-type table, am_pi_menu, Biker businesses and bunker production, Boss registration (free, gb_become_boss_threshold), Business Battles, Business loop (supplies, production, stock, sell) (+28 more)

### Community 32 - "The job lobby"
Cohesion: 0.11
Nodes (35): fmmc_launcher, appMPJobListNEW, The job lobby (fmmc_launcher), The corona (lobby screens), Corona settings path (GPBD_FM_2 to Global_2685150.f_669), The 11 top-level launcher states, FM_Impromptu_DM_Controler, FM_Maintain_Transition_Players (+27 more)

### Community 33 - "Interaction menu, phone and apps"
Cohesion: 0.10
Nodes (35): Interaction menu, phone and apps, am_contact_requests (contact services), am_pi_menu (interaction menu), appContacts, appHackerDen (Darnell Inc.), appInternet, AppJIPMP (Quick Join), appTrackify (+27 more)

### Community 34 - "AI cost and level of detail"
Cohesion: 0.11
Nodes (33): AI cost and level of detail, AI LOD by distance (near, middle, far), CTaskMotionBasicLocomotionLowLod, Dummy and super-dummy vehicles, FORCE_ENTITY_AI_AND_ANIMATION_UPDATE (340 scripts), FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts, 4,119 calls), gameconfig.xml (update copy), IS_ENTITY_ON_SCREEN (316 scripts) (+25 more)

### Community 35 - "Random events"
Cohesion: 0.08
Nodes (34): ambient.ipl, Random events, code_controller, Cut random events without scripts, Global_114904 random event save, lesterhandler, Open question: world brain activation range, photographymonkey (+26 more)

### Community 36 - "Cookbook: Pattern 110"
Cohesion: 0.08
Nodes (27): Cookbook: audio, .awc containers plus .dat*.rel config, Pattern: looping alarm, PLAY_SOUND_FRONTEND / GET_SOUND_ID / START_AUDIO_SCENE natives, Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu, Pattern: mission skeleton (idle, setup, stages, fail, pass, cleanup) (+19 more)

### Community 37 - "How audio is organised"
Cohesion: 0.10
Nodes (33): How audio is organised, AUDIO native namespace (281 natives), audio_rel.rpf, Audio scenes and patches, AWC wave containers (.awc), categories.dat22.rel, content.xml (DLC audio registration), curves.dat16.rel (+25 more)

### Community 38 - "Weapons: AmmoMax six ammo caps"
Cohesion: 0.09
Nodes (34): WeaponLimitsAdjuster, Gameplay, R3.1, Weapons (folder README), R2.5 Fire, explosions and projectiles (topic row), R3.1 Weapons (topic row), Weapons, Aim assist and lock-on (R3.2) (+26 more)

### Community 39 - "Cutscenes and dialogue"
Cohesion: 0.12
Nodes (32): Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A), CREATE_NEW_SCRIPTED_CONVERSATION (+24 more)

### Community 40 - "Flying"
Cohesion: 0.11
Nodes (34): Flying, bj (base jumps), CFlyingHandlingData, CONTROL_LANDING_GEAR / GET_LANDING_GEAR_STATE, CTaskParachute tunables (movementtasks.ymt), DLC aircraft flying blocks (63 entries), Flight school lessons MGFS_0 to 11, GET_PED_PARACHUTE_STATE (+26 more)

### Community 41 - "Particles and decals"
Cohesion: 0.11
Nodes (33): materialfx.dat effects table, Particles and decals, ADD_DECAL, bloodfx.dat, core particle dictionary, decals.dat, entityfx.dat, MTLFX_TABLE (+25 more)

### Community 42 - "Wanted level and police"
Cohesion: 0.09
Nodes (33): crimeinformation.meta / witnessinformation.meta, CRIME_KILL_COP, GET_PLAYER_WANTED_LEVEL, SET_MAX_WANTED_LEVEL, SET_WANTED_LEVEL_MULTIPLIER, Wanted level and police, CanWitnessCrimes / WillCallLawEnforcement, CRIME_FIREARM_DISCHARGE (+25 more)

### Community 43 - "Controls and camera"
Cohesion: 0.09
Nodes (33): Control IDs shift +37 in build 3717, Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+25 more)

### Community 44 - "Text and names in content"
Cohesion: 0.09
Nodes (32): Text and names in content, dlctext.meta (TEXTFILE_METAFILE), gameName (vehicles.meta), GET_LIVERY_NAME, GET_MAKE_NAME_FROM_VEHICLE_MODEL, GET_MOD_TEXT_LABEL, HumanNameHash (weapons.meta), Jenkins one-at-a-time label hashing (+24 more)

### Community 45 - "1. How mods work"
Cohesion: 0.09
Nodes (26): handling.meta, CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, Data mods vs script mods, Per-frame script loop, 2. The tools you need, OpenIV (+18 more)

### Community 46 - "Peds"
Cohesion: 0.10
Nodes (31): SET_PED_RELATIONSHIP_GROUP_HASH, Peds, 1,109 ped models, AbilityType special abilities, CombatInfo, CPedModelInfo InitData, CREATE_PED, DecisionMakerName (+23 more)

### Community 47 - "Interiors and IPLs"
Cohesion: 0.10
Nodes (29): PIN_INTERIOR_IN_MEMORY, CMloArchetypeDef, Interiors and IPLs, ACTIVATE_INTERIOR_ENTITY_SET, building_controller, CAP_INTERIOR, CMloInstanceDef, DISABLE_INTERIOR (+21 more)

### Community 48 - "Online cosmetics and shops"
Cohesion: 0.11
Nodes (32): DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, restrictionTags, Online cosmetics and the shops that sell them, Base wardrobe price tables, CLO_MNU block / CSHOP_TITLE labels, clothes_shop_mp, Clothing catalogue (shop.meta, 36,232 items), Interaction menu Appearance page (am_pi_menu) (+24 more)

### Community 49 - "Minigames and activities"
Cohesion: 0.11
Nodes (32): Minigames and activities, Activity IDs 0 to 18, am_mp_arc_cab_manager (Online arcade), code_controller, controller_ambientarea, golf script (clubs, lies, AI aim, wind), golf_ai_foursome ambient golfers, GP-088 (unarmed code entries 6, 12, 18) (+24 more)

### Community 50 - "Heists in GTA Online / Open questions"
Cohesion: 0.12
Nodes (30): Heists in GTA Online, Casino crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo secondary loot value rolls, ch_lester_cut (5%), Classic heists (Fleeca to Pacific Standard), Classic apartment planning board (heist_mp, heistmap_mp, heist_pre), Heist cut rules (55% leader, 15% min, 70% max) (+22 more)

### Community 51 - "Story systems that clash with an Online  / Open questions"
Cohesion: 0.09
Nodes (31): R5.7 Systems that clash with Online mode (topic row), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems) (+23 more)

### Community 52 - "Perception and events"
Cohesion: 0.11
Nodes (30): SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, Perception and events, ADD_SHOCKING_EVENT_FOR_ENTITY / _AT_POSITION, AddPedGenBlockedArea, CanCallPolice, Decision makers (DEFAULT, GANG, BASE, COP ...), Event response delays (CEventGunAimedAt, CEventGunShot ...), Event system (+22 more)

### Community 53 - "How Rockstar's scripts drive AI"
Cohesion: 0.11
Nodes (29): How Rockstar's scripts drive AI, am_casino_peds, am_mp_peds, Buddies join the player's group, CAN_PED_SEE_HATED_PED, fm_survival_controller, friendactivity, GET_PLAYER_GROUP (+21 more)

### Community 54 - "Completion, autosave and achievements"
Cohesion: 0.13
Nodes (30): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values) (+22 more)

### Community 55 - "Character switching"
Cohesion: 0.11
Nodes (27): Character switching, CHANGE_PLAYER_PED, family_scene_* scripts, GET_IDEAL_PLAYER_SWITCH_TYPE, GET_PLAYER_SWITCH_STATE, IS_PLAYER_SWITCH_IN_PROGRESS, IS_SAFE_TO_START_PLAYER_SWITCH, main_persistent (+19 more)

### Community 56 - "Inside freemode"
Cohesion: 0.12
Nodes (27): Inside freemode, am_mp_island (Cayo Perico), am_pi_menu (interaction menu), DLC story flow functions (CH_FLOW_, HIF_ ...), Network event 174 (script events carrier), FMMC_Launcher (job lobby), freemode script, freemode_clearGlobals (+19 more)

### Community 57 - "VEHICLE natives used by the game scripts"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 58 - "CONTRIBUTING.md"
Cohesion: 0.09
Nodes (25): Branch naming (research/<ID>-pass2-<what> ...), File rules table, Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, AI, AI folder topics R3.2, R3.3, R3.7, R17.1-R17.10 (all done first pass) (+17 more)

### Community 59 - "Vehicles"
Cohesion: 0.12
Nodes (30): Vehicles, Add-on vehicle pack recipe, carcols.ymt / carcols.meta, carvariations.ymt / carvariations.meta, content.xml, dlc_patch copies, FLAG_DONT_SPAWN_AS_AMBIENT / FLAG_DONT_SPAWN_IN_CARGEN, GET_VEHICLE_CLASS (+22 more)

### Community 60 - "PED natives used by the game scripts"
Cohesion: 0.14
Nodes (30): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+22 more)

### Community 61 - "Data batch PC1 rows"
Cohesion: 0.10
Nodes (29): AI-024: The AI handling profile of every DLC vehicle, Data batch PC1, ENT-038: Light and siren id ranges per DLC pack, ENT-039: Which carcols mod parts each kit links, PHY-001: The two unnamed columns (0.95, 0.0), PHY-013: What each statMods modifier changes, REN-011: How the first-person car interior camera is chosen per..., Tracker: 442 rows (200 answered, 53 mostly, 59 partly, 130 open) (+21 more)

### Community 62 - "Ambient life"
Cohesion: 0.11
Nodes (29): Ambient life, Ambient ped task loop, Animal models (A_C_*), CAmbientLookAt, CTaskAmbientClips, CTaskChat, CTaskFlyingWander, CTaskSwimmingWander (+21 more)

### Community 63 - "Appearance and clothing"
Cohesion: 0.11
Nodes (28): Appearance and clothing, ADD_PED_DECORATION_FROM_HASHES, clothes_shop_mp, clothes_shop_sp, FINALIZE_HEAD_BLEND, forcedComponents, GET_SHOP_PED_COMPONENT, hairdo_shop_mp (+20 more)

### Community 64 - "DLC storylines in GTA Online"
Cohesion: 0.13
Nodes (28): DLC storylines in GTA Online, AW_FLOW flow (Arena War), BATFMAU After Hours call block (143 roots), BT24_FLOW flow (Bottom Dollar), CH_FLOW flow (Casino Heist), EXEC_FLW flow, FIX_FLOW flow (The Contract), GR_FLOW flow (Gunrunning) (+20 more)

### Community 65 - "Stats, tunables and the server's role"
Cohesion: 0.14
Nodes (29): Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, clothes_shop_mp, Hash-only tunables (7,296; 311 recovered), MONEY NETWORK_SPENT_* / NETWORK_EARN_* natives, mpstatssetup.xml (17,928 Online stats), Offline Online mode replacements (local save, tunable defaults, local prices), Packed stats (6,403) (+21 more)

### Community 66 - "Load times and stutter"
Cohesion: 0.09
Nodes (29): Heavily modded install script load (52 + 61), 15 W laptop throttling, Load times and stutter, First three minutes hold most hitches, Load phases (80 to 107 s), ON_ENTER_MP map switch (8.6 s), Open questions (load times), Driver shader cache (+21 more)

### Community 67 - "Collision, materials and shape tests"
Cohesion: 0.13
Nodes (26): Collision, materials and shape tests (R2.1), GET_GROUND_Z_FOR_3D_COORD, GLASS_BULLETPROOF, GLASS_SHOOT_THROUGH, HAS_COLLISION_LOADED_AROUND_ENTITY, Material flags (SEE_THRU, SHOOT_THRU, SHOOT_THRU_FX, NO_DECAL, POROUS, HEATS_TYRE), Material groups (FILTER column), material_override_pairs.dat (+18 more)

### Community 68 - "Scaleform movies"
Cohesion: 0.14
Nodes (28): Scaleform movies (R8.2), ActionScript 2 method extraction from .gfx, BEGIN_TEXT_COMMAND_SCALEFORM_STRING, breaking_news, countdown, DRAW_SCALEFORM_MOVIE_FULLSCREEN, Engine-loaded movies (hud, minimap, pause menu), Scaleform .gfx movies (+20 more)

### Community 69 - "07 Legacy / 03 Menus and UI"
Cohesion: 0.08
Nodes (27): 9. Next steps and sharing your mod, Where to publish mods, Mod readme required sections, LemonUI, 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading (+19 more)

### Community 70 - "GTA Online / Open questions"
Cohesion: 0.08
Nodes (28): GET_EVENT_AT_INDEX, GTA Online (folder README), R15.1 Sessions and sync (topic row), R15.2 Rockstar services (topic row), R7.1 freemode inside (topic row), R7.10 Interaction menu, phone and apps (topic row), R7.11 Rockstar Creator internals (topic row), R7.2 Transitions and sessions (topic row) (+20 more)

### Community 71 - "Police and service AI"
Cohesion: 0.12
Nodes (27): Police and service AI, Assassins dispatch type, Crime-info entries (9, CRIME_KILL_COP weight 5), dispatch.meta, Dispatch spawning rules (250 m ideal), Dispatch vehicle sets (15), dispatchtuning.ymt, ENABLE_DISPATCH_SERVICE (+19 more)

### Community 72 - "Vehicle generators and traffic"
Cohesion: 0.12
Nodes (27): Vehicle generators and traffic, Car generator flag bits, Car generators (CCarGen), CREATE_MISSION_TRAIN, CREATE_SCRIPT_VEHICLE_GENERATOR, Dispatch services, DLC road-section ymap copies, ENABLE_DISPATCH_SERVICE (+19 more)

### Community 73 - "Respawn, death and arrest / Open questions"
Cohesion: 0.14
Nodes (28): PP_INFO_STRUCT (per-character save), The player, R6.5 Online character creator, Respawn, death and arrest (R6.2), Arrest penalty: up to $300 and weapons cleared, Death fee: 5% of cash, max $5,000, exile_city_denial, 5 hospital restart points (ADD_HOSPITAL_RESTART) (+20 more)

### Community 74 - "Cameras"
Cohesion: 0.13
Nodes (27): Cursor line test (2,400 m probe), Cameras (R13.5), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT, Camera directors, Camera shakes, cameras.ymt, camCinematicMountedCameraMetadata, camVehicleCustomSettingsMetadata (+19 more)

### Community 75 - "Vehicle handling data"
Cohesion: 0.14
Nodes (26): Vehicle physics: handling, damage and upgrades (R2.2), AIHandling field, CAdvancedData, carcols.meta, CBikeHandlingData, CBoatHandlingData, CCarHandlingData, CFlyingHandlingData (+18 more)

### Community 76 - "Map data"
Cohesion: 0.12
Nodes (24): Timecycle modifier boxes, Map data, Box occluders, Car generators, controller_ambientarea, cs1_12.ymap, HDTxdAssetBindings, HoursOnOff (+16 more)

### Community 77 - "NETWORK natives used by the game scripts"
Cohesion: 0.16
Nodes (28): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+20 more)

### Community 78 - "CLAUDE.md"
Cohesion: 0.11
Nodes (26): CLAUDE.md: assistant instructions, GTA V PC Legacy build 1.0.3725.0, common.rpf (base data), Count things rule, Decompile commit 'Update for 1.72-3725.0', Decompiled scripts (community decompile), Decompiler names (func_/Global_/Local_), file-rules check (+18 more)

### Community 79 - "Data needs: Data batch D8"
Cohesion: 0.17
Nodes (27): AI-027: Road nodes, routes; node and link counts, update vs base, AI-028: Polygons, links and cover points per navmesh tile, AI-029: Road nodes, routes; node and link counts, update vs base, Data batch D8, ENT-001: Archetype flag bits across all .ytyp, ENT-003: Every rayfire object placed in the map, ENT-028: How many of the 111,898 scenario points are Online-only, ENT-029: The scenario chaining graph format (+19 more)

### Community 80 - "System requirements outside the game fol"
Cohesion: 0.10
Nodes (26): Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, Launch with -nobattleye for story-mode mods, Run under Proton or Wine with DXVK (D3D11 to Vulkan), check-system.ps1: PC requirement check (+18 more)

### Community 81 - "Navigation and pathfinding"
Cohesion: 0.14
Nodes (27): TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE, Navigation and pathfinding, ADD_COVER_POINT, ADD_NAVMESH_REQUIRED_REGION, GET_NAVMESH_ROUTE_RESULT, GET_NUM_NAVMESHES_EXISTING_IN_AREA, GET_SAFE_COORD_FOR_PED, IS_NAVMESH_LOADED_IN_AREA (+19 more)

### Community 82 - "Speech and dialogue"
Cohesion: 0.14
Nodes (27): Speech and dialogue, Ambient voice name pattern (<model>_<ethnicity>_<full|mini>_<n>), .awc speech containers, Dialogue block to mission mapping (AUD suffix), BOUNCER_EJECT_GENERIC, comms_controller, dialogue_handler, DISABLE_PED_PAIN_AUDIO (+19 more)

### Community 83 - "Swimming and diving"
Cohesion: 0.12
Nodes (25): Swimming and diving, Dive height (MinDiveHeight / MaxDiveHeight), GET_ENTITY_SUBMERGED_LEVEL, GET_PLAYER_UNDERWATER_TIME_REMAINING, HighFallWaterDepthMin / Max, Hold breath duration (MinHoldBreathDuration 10 / Max 40), IS_ENTITY_IN_WATER, movementtasks.ymt (+17 more)

### Community 84 - "Natives as the engine API"
Cohesion: 0.09
Nodes (26): SCR-008: Measured cost of the heavy natives (synchronous shape test, `GET_CLOSE..., SCR-009: Which natives crash on a stale handle and which fail quietly, SCR-010: The size limits of the nearby-entity arrays, Natives as the engine API: kinds, contracts and costs questions (R1.3), R1.3 Natives as the engine API, 05 Native functions, Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument) (+18 more)

### Community 85 - "STATS natives used by the game scripts"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 86 - "Tools and resources"
Cohesion: 0.11
Nodes (26): CodeWalker, Tools and resources, Call-graph labeller (awk script), Claude Code, Claude Code skills (game-recon, reverse-engineering ...), CodeWalker (CodeWalker.Core.dll), CodeWalker.Core MetaXml/YmapFile/RpfFile from PowerShell, GTA-V-Decompiled-Scripts community decompile (+18 more)

### Community 87 - "Glossary"
Cohesion: 0.10
Nodes (25): Verified / Known claim marking, Glossary, ASI plug-in, Broadcast data, Decompile, DLC pack, Flow / strand, Global / global block (+17 more)

### Community 88 - "Data batches D10 and D11"
Cohesion: 0.17
Nodes (26): Data batch D10, Data batch D11, GP-027: The editor's 10 post effects; the 39 unnamed post..., Data needs group: Animation, cameras, effects, timecycle, REN-001: The 22 memory group names and their budget unit, REN-002: Which clip sets the 4,526 hashed keys are, REN-004: Clip archive layout in DLC packs, dictionaries per pack, REN-005: The 12 expression dictionaries the update replaced (+18 more)

### Community 89 - "Data batch D7 (engine config)"
Cohesion: 0.14
Nodes (26): Data batch D7, FF-003: How update copies override base ones, type by type, FF-004: Each content section key (me, sro, amb ...), Data needs group: Engine config and archives, PERF-013: Which files ON_ENTER_MP switches: the change sets the 43..., PERF-025: Whether raised physics pools change anything on a low-end PC, SCR-014: Which duplicated pool entry in gameconfig.xml applies to PC, Batch D7: gameconfig.xml (base and update), a listing of every archive with entr... (+18 more)

### Community 90 - "Relationships and groups"
Cohesion: 0.13
Nodes (25): Relationships and groups, ADD_RELATIONSHIP_GROUP, AMBIENT_GANG_* groups (9), CIVMALE / CIVFEMALE groups, Follower limit (7 besides leader), GUARD_DOG group, HATES_PLAYER group, main_persistent (+17 more)

### Community 91 - "Ped physics and ragdoll"
Cohesion: 0.14
Nodes (26): Ped physics and ragdoll, CGrabHelper, CREATE_NM_MESSAGE / GIVE_PED_NM_MESSAGE, CTaskFall__Tunables, CTaskNM* ragdoll tasks, CTaskNMBrace, CTaskNMFlinch, CTaskNMHighFall (+18 more)

### Community 92 - "Open questions: Block A"
Cohesion: 0.13
Nodes (24): CPU: population, AI, physics and scripts, Population density as biggest lever, Game threads (24, Update TIME_CRITICAL), Open questions (CPU), Mod overhead: what each kind of mod costs, Open questions (mod overhead), SHVDN per-script switch cost (61 scripts), Performance (+16 more)

### Community 93 - "Water and buoyancy"
Cohesion: 0.13
Nodes (26): Water and buoyancy, ADD_EXTRA_CALMING_QUAD, Buoyancy by sampling water height, Calming quads (542), fDampening, Whole-map flood via water.xml, fPercentSubmerged, Low-LOD anchored boat float (+18 more)

### Community 94 - "Native usage index"
Cohesion: 0.24
Nodes (26): Game build 3725, Decompile commit 6c18d3e8b (build 3725), tools/native-usage.ps1, NativeDB natives.json, MONEY natives used by the game scripts, NETSHOPPING natives used by the game scripts, OBJECT natives used by the game scripts, PAD natives used by the game scripts (+18 more)

### Community 95 - "PLAYER natives used by the game scripts"
Cohesion: 0.18
Nodes (26): PLAYER natives used by the game scripts, GET_PLAYER_NAME, GET_PLAYER_PED, GET_PLAYER_TEAM, GET_PLAYER_WANTED_LEVEL, INT_TO_PLAYERINDEX, IS_PLAYER_CONTROL_ON, IS_PLAYER_PLAYING (+18 more)

### Community 96 - "Combat and AI"
Cohesion: 0.13
Nodes (25): Decision maker, Combat and AI (first pass), Agitation system (agitatedtriggers/responses/personalities.meta), defaulttaskdata.meta, events.meta, Melee action tables (action\definitions.meta etc.), pedaccuracy.meta, pedbrawlingstyle.meta (+17 more)

### Community 97 - "The Online character creator"
Cohesion: 0.13
Nodes (25): The Online character creator, Starter outfits and crew T-shirt, Appearance change fee and cooldown, CHAR_CREATOR_PORTRAITS, FEATURE_0 to FEATURE_20 stats, FINALIZE_HEAD_BLEND / HAS_PED_HEAD_BLEND_FINISHED, HEADBLEND_* and MESH_* stats, Heritage head blend (Mom/Dad) (+17 more)

### Community 98 - "Open questions: Questions by category"
Cohesion: 0.11
Nodes (20): Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass), Second pass: answering OPEN_QUESTIONS rows, Open questions: the second pass, AI-008: How peds pick partners for chats, AI open questions, Already answered rows, Questions by category (+12 more)

### Community 99 - "Data batches D1 and D12"
Cohesion: 0.13
Nodes (24): Data batch D1, Data batch D12, ENT-005: The 13 vehicle maker labels with no text, ENT-036: Why 901 models here vs 879 in R14.4, ENT-037: The less common vehicle flags, GP-045: The CFlyingHandlingData block of every DLC aircraft, GP-046: What the SPMED and SPSMALL handling entries belong to, GP-047: The 12 flight school lesson names, then which lesson... (+16 more)

### Community 100 - "Decisions and personalities"
Cohesion: 0.16
Nodes (24): Combat behaviour flags (BF_*), combatbehaviour.meta, Decisions and personalities, ArmourEfficiency / HealthRegenEfficiency / StaminaEfficiency, BF_COWARDLY_FOR_SHOCKING_EVENTS, 18 bravery types, Criminality types, DLC pedpersonality.meta (23 files, holster anims) (+16 more)

### Community 101 - "Graphics settings"
Cohesion: 0.12
Nodes (24): CityDensity setting, Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Open questions (graphics), Biggest GPU/CPU/memory costs, CORE-026: How `TextureQuality` values map to the menu, and how much memory each ... (+16 more)

### Community 102 - "Replay, director mode and the Rockstar E"
Cohesion: 0.15
Nodes (23): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder (Rockstar Editor), Director mode quick-travel locations (27), director_mode, GP-087 Replay type meaning in the engine, maintransition, mission_repeat_controller (+15 more)

### Community 103 - "Transitions and sessions / Open questions"
Cohesion: 0.18
Nodes (24): Transitions and sessions (R7.2), freemode_clearGlobals (31 reset steps), ingamehud connection-problem warnings, maintransition (transition state machine script), NETWORK_IS_GAME_IN_PROGRESS (905 scripts), Offline-mode branch (unreachable in build 3725), Online privilege checks (NETWORK_HAVE_ONLINE_PRIVILEGES ...), RETRY_LOADING_SLOT states and cloud save slots (+16 more)

### Community 104 - "Handoff: Status"
Cohesion: 0.13
Nodes (20): Handoff: current status and what to do next, Ask the contributor or community (GP-076, REN-019, ON-053), What needs game files vs what a cloud session can do, Decompile commit 6c18d3e8 (Update for 1.72-3725.0), graphifyy (pip package), Docs housekeeping KG-001 to KG-004, Leftovers pass (research/pass2-leftovers), Files are LF in git; keep existing endings (+12 more)

### Community 105 - "Block B and AI cost questions"
Cohesion: 0.09
Nodes (24): AI-004: The distances where ped AI LOD changes, AI-006: What the second `CTask` pool (2,100) is for, AI-007: How far from the player ambient peds despawn, AI cost and level of detail questions (R17.9), Block B: Boot, scripts and natives, CORE-001: Which data file types overlay (merge) and which replace; how..., CORE-013: A PoolManager crash log from the test install names cscenarioinfo..., CORE-014: Real usage of the busiest pools in a heavy session (turn on... (+16 more)

### Community 106 - "Driving AI"
Cohesion: 0.15
Nodes (22): Driving AI: missions, chases, aircraft and boats, Flee mission (8), fm_content_* scripts, Roadmap R17.6 driving AI, SET_BOAT_ANCHOR, SET_DRIVER_RACING_MODIFIER, SET_HELI_BLADES_FULL_SPEED, TASK_BOAT_MISSION (+14 more)

### Community 107 - "Rendering, visual settings and LOD"
Cohesion: 0.15
Nodes (21): Rendering, visual settings and LOD, Adrian Courreges GTA V graphics study, CASCADE_SHADOWS_INIT_SESSION, CASCADE_SHADOWS_SET_CASCADE_BOUNDS, Cascaded shadow maps, Distant lights, Extended distance scaling, G-buffer (+13 more)

### Community 108 - "Driving and AI driving"
Cohesion: 0.14
Nodes (22): Driving and AI driving, AIHandling field in handling.meta, Corner speed curve, CTaskPlayerDrive, DLC AIHandling profiles (PC data pass), Driving style flags, Four AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), Roadmap topic R3.3 (+14 more)

### Community 109 - "Animation and camera questions"
Cohesion: 0.11
Nodes (22): Batch D11: clip_sets.ymt and the DLC clip_sets.xml files, cameras.ymt, the archiv..., Batch D12: The American text dump (every block), every carcols.meta, the clothes ..., Animation questions (R13.4), Cameras questions (R13.5), Rendering, visual settings and LOD questions (R13.1), Leftovers: the data-file batches (DATA-NEEDS), REN-001: The names behind the 22 memory groups and their budget unit, REN-002: Which clip sets the hashed entries are (resolving the 4,526 keys from ... (+14 more)

### Community 110 - "Server-backed Online screens: Server calls per screen table"
Cohesion: 0.10
Nodes (21): Global_2097536 (leaderboard rows), am_contact_requests, am_pi_menu (interaction menu), appbusinesshub (business computer), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780 (+13 more)

### Community 111 - "Player skills and abilities"
Cohesion: 0.17
Nodes (21): 100 stat points across seven skills, Player skills and abilities (R3.6), Open question GP-092: ability entries 8-16, peds.ymt AbilityType per model, playerinfo.ymt PlayerStatInfos ranges, playerspecialabilities.ymt (17 entries), Seven character skills (0-100, SP0_/SP1_/SP2_ stats), Skill growth formula (start + bonus + activity score) (+13 more)

### Community 112 - "7. Your first C++"
Cohesion: 0.17
Nodes (21): 7. Your first C++ (.asi) mod, ASI loader, ASI plugin (64-bit DLL), asiloader.log / ScriptHookV.log, DllMain (register only), DOES_ENTITY_EXIST check, Per-frame text drawing, getGlobalPtr (+13 more)

### Community 113 - "Archives and the content system"
Cohesion: 0.15
Nodes (18): Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins), RPF archives (+10 more)

### Community 114 - "Streaming"
Cohesion: 0.12
Nodes (18): Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, Pop-in and streaming hitches, Population and model budgets, Request, check, release pattern (+10 more)

### Community 115 - "Swimming and diving questions"
Cohesion: 0.12
Nodes (20): Swimming and diving questions (R3.5), GP-071: The exact curve from the lung capacity stat to seconds of breath (`Div..., GP-072: How fast drowning drains health, GP-074: How the fall heights combine with ragdoll and fall damage, GP-075: Swim speed from the stamina and lung stats, PHY-004: The ragdoll and `NATURAL_MOTION` materials, Block D: Gameplay, GP-006: Exact meanings of the START_CUTSCENE and... (+12 more)

### Community 116 - "Saves"
Cohesion: 0.16
Nodes (17): Saves: the story save (R1.7), FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values), Keep mod data in its own file, Save upgrade function in startup, Save version fSaveVersion (1.7), standard_global_reg (+9 more)

### Community 117 - "UGC mission files / Archive and data file atlas"
Cohesion: 0.15
Nodes (18): Archive and data file atlas, 5,290 archives and 389,555 files, 89 DLC packs, .awc audio wave container, common.rpf, g9ec packs, .gxt2 text block, mpheist (+10 more)

### Community 118 - "TASK natives"
Cohesion: 0.12
Nodes (19): TASK::GET_SCRIPT_TASK_STATUS, TASK natives used by the game scripts, Assisted movement routes, CLEAR_PED_TASKS / CLEAR_PED_TASKS_IMMEDIATELY, Combat tasks (TASK_COMBAT_PED, TASK_COMBAT_HATED_TARGETS_AROUND_PED), Cover (ADD_COVER_POINT, TASK_SEEK_COVER_*, cover blocking areas), Flee tasks (TASK_SMART_FLEE_PED/COORD), GET_IS_TASK_ACTIVE (+11 more)

### Community 119 - "The AI architecture"
Cohesion: 0.16
Nodes (18): The AI architecture, AI layers: perception, events, decisions, relationships, tasks, navigation, motion, LOD, Events interrupt tasks via decision maker; blocked by SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks (+10 more)

### Community 120 - "Health, armour, death and arrest / Open questions"
Cohesion: 0.18
Nodes (18): Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS, IS_PED_INJURED (903 scripts) (+10 more)

### Community 121 - "Online tab and in-game websites"
Cohesion: 0.14
Nodes (17): appinternet (in-game websites), Busy spinners and warning screens, NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED), Map page paid-action check refuses when signed out, NET_GAMESERVER_IS_SESSION_VALID, Transaction server NET_GAMESERVER_*, NETWORK_HAS_VALID_ROS_CREDENTIALS (+9 more)

### Community 122 - "Tools / PC session plan"
Cohesion: 0.15
Nodes (17): RPF archives, RPF archive format v7, Update-check tool, Tools, check-system.ps1: what Windows needs, CodeWalker (external dependency), Community decompiled-scripts repository (external dependency), dlc-scan.ps1: inventory of DLC packs (+9 more)

### Community 123 - "Driving AI questions"
Cohesion: 0.12
Nodes (18): AI-020: How the driving ranges map onto the driving tasks (R3.3, R17.6), AI-021: The name of each temp action number, checked in game, AI-022: How the flee mission picks a route, AI-023: Mission numbers passed in variables (about a quarter of the calls), AI-024: AI profiles of every DLC vehicle (all `handling.meta` files), AI-025: How `SET_DRIVER_ABILITY` and `_AGGRESSIVENESS` change the curve or bra..., AI-026: What `TASK_VEHICLE_TEMP_ACTION`'s action numbers mean, with Rockstar's..., AI-027: Road nodes and how routes are planned (+10 more)

### Community 124 - "Boot and getting-started questions"
Cohesion: 0.16
Nodes (18): CORE-017: Meaning of force-cleanup bits 8, 16, 32, 64 and 128, CORE-018: What exactly the engine does to start `main`, `initial` and `startup`,..., CORE-032: What the engine raises force-cleanup bits 16 and 32 for (no script rai..., Boot and script control: from launch to control, and between story and Online questions (R1.2), Getting started open questions, GS-001: Which level index 5 is, GS-002: The exact path from a new game to `prologue1`, GS-003: Whether the return to story mode restarts every script (test card 2) (+10 more)

### Community 125 - "Ped personality questions"
Cohesion: 0.24
Nodes (17): AI-011: Decode personalities, bravery, driving ability, AI-016: Decode personalities, bravery, driving ability, AI-017: The 5 unnamed civilian bravery types and the criminality..., AI-019: How MotivationMin/Max is used, AI-020: How driving ranges map onto driving tasks, AI-034: The 9 crime-info entries; crime points per crime, AI-035: The 9 crime-info entries; crime points per crime, AI-036: The police vehicle sets with model names (+9 more)

### Community 126 - "Missions"
Cohesion: 0.13
Nodes (17): Missions, R0.1, R5.2, R5.4, R5.5, R5.6, R5.8, Script catalog: story mode and shared scripts (+9 more)

### Community 127 - "HUD, colours and blips"
Cohesion: 0.16
Nodes (17): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, Radar and minimap interiors, DISABLE_FRONTEND_THIS_FRAME, frontend.xml HUD and menu placement (+9 more)

### Community 128 - "Pause and Online menus"
Cohesion: 0.15
Nodes (17): Pause and Online menus, ACTIVATE_FRONTEND_MENU usage, Menu versions (FE_MENU_VERSION_*), ONLINE tab is MISSION_CREATOR screen, Pause menu page scripts, pausemenu.xml menu description, Credits & Legal tunable Global_262145.f_9321, Jobs and Playlists UGC lists (+9 more)

### Community 129 - "Open questions / PC session plan: Partial data results and what would fini"
Cohesion: 0.19
Nodes (17): AUD-001: The number of sounds and sound sets in `sounds.dat54`, AUD-002: What each audio scene changes, AUD-004: Speech archives and voices, AUD-005: The 10 base and many DLC station objects whose names didn't resolve, AUD-006: How a music event maps to moods and tracks, step by step, AUD-007: Which DLC stations are available in story mode in build 3725, AUD-008: The format of a radio track's data (length, markers for the DJ), AUD-009: The list of contexts each voice has, from `speech2.dat4.rel` (+9 more)

### Community 130 - "Open questions: Batch D8"
Cohesion: 0.15
Nodes (17): Batch D8: Every .ymap, .ytyp, .ymf, .ynd, .ynv and scenario region file, loaded ..., Props, archetypes and doors questions (R14.3), Interiors and IPLs questions (R4.5), Map data questions (R4.6), ENT-001: Archetype flag bits counted across all `.ytyp` files, ENT-003: Every rayfire object placed in the map, not only those named in script..., REN-025: How many timecycle boxes and interior room modifiers the map has, The world open questions (+9 more)

### Community 131 - "AUDIO natives"
Cohesion: 0.14
Nodes (17): AUDIO natives used by the game scripts, Ambient speech (PLAY_PED_AMBIENT_SPEECH_*_NATIVE), Ambient zones (SET_AMBIENT_ZONE_STATE[_PERSISTENT], SET_AMBIENT_ZONE_LIST_STATE_PERSISTENT), Audio mix groups (ADD_ENTITY_TO_AUDIO_MIX_GROUP), Audio scenes (START_AUDIO_SCENE / STOP_AUDIO_SCENE / IS_AUDIO_SCENE_ACTIVE), Streams (LOAD_STREAM / PLAY_STREAM_FRONTEND / STOP_STREAM), IS_MOBILE_PHONE_CALL_ONGOING, PLAY_SOUND_FROM_ENTITY (+9 more)

### Community 132 - "Story-mode UI"
Cohesion: 0.20
Nodes (15): hudcolor.dat colour table, Story-mode UI, Character wheel (selector), Completion percent and medal formula, Mission-passed screen (mission_stat_watcher), 913-entry mission stat table, SHOW_MISSION_PASSED_MESSAGE parameters, spstatssetupui.xml Stats page (+7 more)

### Community 133 - "AI open questions"
Cohesion: 0.21
Nodes (15): AI-010: Names of the common combat attributes (50, 17, 53, 52, 46) and config ..., AI-011: Decode `pedpersonality.ymt` (binary PSO): personalities, bravery, driv..., AI-012: Cover: how cover points are found and scored, `TASK_SEEK_COVER_*`, AI-013: How aim assist and lock-on work for the player, AI-015: Whether the modded `events.meta` really drops gunfight reactions, in g..., AI-016: Decode `pedpersonality.ymt` (binary PSO; not decoded in the first pass..., AI-017: The names of the 5 unnamed civilian bravery types and the criminality ..., AI-018: What `IsWeird` changes for Trevor (+7 more)

### Community 134 - "Open questions / PC session plan: Weapons questions"
Cohesion: 0.21
Nodes (14): Batch D2: explosion.ymt (update), all 19 explosion.meta (16 packs + 3 dlc_patch)..., Weapons questions (R3.1), Fire, explosions and projectiles questions (R2.5), GP-053: How armour splits damage between armour and health for each damage typ..., GP-076: Which mod installed the weapon overhaul (and the other 93 replaced fil..., GP-077: The hatchet's extra condition, and whether the Gusenberg really waits ..., GP-079: Explosion damage and radius per explosive (`explosion.meta`), PHY-006: The exact falloff curve between centre and edge, and how armour takes ... (+6 more)

### Community 135 - "Open questions: Batch P4.2"
Cohesion: 0.27
Nodes (14): Anatomy of a story mission questions (R5.2), Replay, director mode and the Rockstar Editor questions (R5.8), GP-016: Where `armenian1`, `jewelry_heist` and `trevor1` set the skip flag (`G..., GP-017: The exact meaning of `replay_controller` states 1 to 6 and 11 to 13, GP-021: What the mission triggerers build before a mission starts (lead-in sce..., GP-022: Where `armenian1`, `jewelry_heist` and `trevor1` unlock their skip (th..., GP-023: What exactly NoEditorRestrictions patches, and the vanilla limits it l..., GP-024: The meaning of `replay_controller` states 1 to 6 and 11 to 13 (+6 more)

### Community 136 - "Audio questions"
Cohesion: 0.29
Nodes (13): AUD-001: Number of sounds and sound sets, AUD-004: Speech archives, voices, the contexts each voice has, AUD-005: The radio station objects whose names didn't resolve, AUD-006: Music event → mood → track, step by step, AUD-008: Radio track data (length, DJ markers), AUD-009: Speech archives, voices, the contexts each voice has, AUD-010: Which dialogue block belongs to which mission (331..., Data batch D9 (+5 more)

### Community 137 - "Water and buoyancy questions"
Cohesion: 0.26
Nodes (13): Data batch D3, Data needs group: Water, PHY-015: What the five water quad types mean, Batch D3: water.xml, water_heistisland.xml, waterheight.dat, water.dat, watertun..., Water and buoyancy questions (R2.4), PHY-005: How water collision differs from water simulation, PHY-015: What the 5 water quad types mean, PHY-016: The format of `waterheight.dat` (+5 more)

### Community 138 - "Graphics settings, one by one"
Cohesion: 0.17
Nodes (11): settings.xml (version 27) keys, Profiles for different PCs, Low-end laptop profile, Mid-range PC profile, Open questions (profiles), Strong PC profile, Profiles for different PCs questions (R18.7), PERF-021: Measured FPS and hitches of the low-end profile vs typical settings on... (+3 more)

### Community 139 - "Server-backed Online screens"
Cohesion: 0.29
Nodes (12): Server-backed Online screens (R8.5), Engine-filled network pages (friends, crews, party, store, invites), What a local replacement would need, Seven server services behind the Online UI, Server-backed screens open questions, Server-backed Online screens questions (R8.5), Batch P1.6: Server-backed Online screens (R8.5), UI-005: What `pausemenu_multiplayer` fills on each Online page (+4 more)

### Community 140 - "Reading the repo in Obsidian"
Cohesion: 0.23
Nodes (9): Reading the repo in Obsidian, Bookmarks: README, ROADMAP, OPEN_QUESTIONS, HANDOFF, DATA-NEEDS, Excluded files (graphify-out/cache, templates, tools ...), GitHub-style anchors vs Obsidian heading matching, Obsidian graph view (separate from graphify), Open folder as vault (repo root), Recommended Obsidian settings, Root-relative links (~2,590) (+1 more)

### Community 141 - "Streaming, memory and video memory"
Cohesion: 0.17
Nodes (12): Cost order on low-end laptop: memory, CPU, GPU, heat, Streaming, memory and video memory, HeapAdjuster (478 to 1,950 MB), Three memory budgets: heap, streaming, VRAM, Memory over a session (private 9.1 GB), Open questions (memory), Paging causes freezes with many mods, gameconfig.xml streaming buffers and ArchiveCount (+4 more)

### Community 142 - "ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 143 - "Heist crews and enemy groups"
Cohesion: 0.18
Nodes (10): agency_heist3a, agency_heist3b, Crew skill tier (0, 1, 2), Crew stat raise after crew finales, finale_heist2a, flow_controller, HC_STA_* planning board stat labels, Heist crew table in main (13 members) (+2 more)

### Community 144 - "WEAPON natives used by the game scripts"
Cohesion: 0.18
Nodes (11): SET_VEHICLE_DAMAGE_SCALE, WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON (+3 more)

### Community 145 - "Completion and autosave questions"
Cohesion: 0.31
Nodes (11): CORE-005: What each completion entry's flags and map numbers mean, CORE-006: Every autosave trigger, from the request fields, CORE-007: Which 23 achievements the controller awards, by name, CORE-008: `SC_MSC_` labels whose text is in a text block not read in the first p..., CORE-025: What triggers an autosave, and completion, Completion, autosave and achievements questions (R5.3), GP-018: How the snapshot in `Global_108447` is restored on retry, and what it ..., GP-020: How `mission_repeat_controller` replays a mission without moving the f... (+3 more)

### Community 146 - "Timecycle and post effects questions"
Cohesion: 0.31
Nodes (11): Batch D10: entityfx.dat, materialfx.dat, wheelfx.dat, every .ypt (CodeWalker), DL..., Timecycle and post effects questions (R13.2), GP-027: The 10 post effects `startup` registers for the editor, REN-021: What the two numbers on each modifier line mean (value and strength? v..., REN-022: What `userFlags` 1, 2, 4, 8 and 16 do, REN-023: The game hours of the 13 keyframes, REN-024: What the 39 unnamed post effects are, and whether anything plays them, REN-026: `GroupId` and `EventType` on post effects (+3 more)

### Community 147 - "Hashed function name questions"
Cohesion: 0.31
Nodes (11): AI-023: The functions behind the scripts' function pointers (Call_Loc..., AI-045: The functions behind the scripts' function pointers (Call_Loc..., FF-006: The English names of the mission rule types (labels PMC_RULE1 to..., GP-021: The functions behind the scripts' function pointers (Call_Loc..., Data group: Found since DATA-NEEDS was written, ON-021: Names behind hashed tunables and the price category 426439576, ON-035: Names behind hashed tunables and the price category 426439576, ON-049: Names behind hashed tunables and the price category 426439576 (+3 more)

### Community 148 - "Block C world and AI questions"
Cohesion: 0.18
Nodes (11): AI-025: How SET_DRIVER_ABILITY and _AGGRESSIVENESS change the curve or braking, AI-041: Where story missions keep enemy spawn tables (positions, triggers)..., Block C: World, AI and entities, ENT-032: How the schedule caps, the budget and the CityDensity setting combine, PHY-006: The exact falloff curve between centre and edge, and how armour..., PHY-007: How far and how fast fire spreads, and its limits (number of fires..., PHY-012: How the engine turns fInitialDriveMaxFlatVel and the drive force..., WLD-013: How long one TimeMult unit lasts, and whether the cycle position... (+3 more)

### Community 149 - "Animal models and populations"
Cohesion: 0.22
Nodes (10): AI-009: Animal models by kind and where each spawns, ENT-025: How bird and fish groups spawn, ENT-025: How the engine places the aerial, aquatic and wildlife population..., AI-009: animal models by kind and spawn source, ambientpedmodelsets.meta (34 animal sets), ENT-025: bird and fish population groups, peds.ymt (32 A_C_* models), popcycle.dat (116 schedules) (+2 more)

### Community 150 - "Data needs: common.rpf"
Cohesion: 0.38
Nodes (10): Data batch D2, GP-079: Damage and radius per explosion type, base and the 16..., Data needs group: Weapons, explosions, physics, PHY-008: The unnamed boolean fields, PHY-009: Damage and radius per explosion type, base and the 16..., PHY-010: Every DLC projectile and its explosion, GP-078: How story stats and Online rank change `AmmoMax`, GP-079: Damage and radius per explosion type, base and the 16 DLC files (+2 more)

### Community 151 - "Data batch D6 (appearance)"
Cohesion: 0.31
Nodes (10): Data batch D6, GP-055: Two unlabelled morph-19 entries; the last..., GP-081: What each restriction tag blocks or forces, GP-083: Base-wardrobe labels and prices of the non-DLC clothes, Data needs group: Character appearance and shops, ON-049: Catalogue item keys and categories, ENT-010: Overlay list 0 to 12 and micro-morph list 0 to 19, checked, GP-055: Two unlabelled morph-19 entries; the last appearance-table column (+2 more)

### Community 152 - "Ragdoll tuning and fall damage"
Cohesion: 0.24
Nodes (10): ENT-017: Which ragdoll tuning set applies to which weapon and..., ENT-020: Where fall damage is set, pedhealth.meta, ENT-017: Which ragdoll tuning set applies to which weapon and vehicle;..., ENT-020: Where and how fall damage is computed (no data file sets it), ENT-017: ragdoll tuning sets per weapon and vehicle, ENT-020: fall damage not in data files, NmShotTuningSet (CWeaponInfo) (+2 more)

### Community 153 - "Wanted level and relationships"
Cohesion: 0.20
Nodes (9): SET_PLAYER_WANTED_LEVEL, COP relationship group, franklin1, lamar1, Open question: how wanted level overrides COP-PLAYER, finale_heist2b, Open question: enemies alive at once in a story shootout, rural_bank_heist (+1 more)

### Community 154 - "Shape tests and collision layers"
Cohesion: 0.22
Nodes (9): Shape test collision layer flags, START_SHAPE_TEST_LOS_PROBE, `.ybn` static collision bounds, GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE (+1 more)

### Community 155 - "Text labels questions"
Cohesion: 0.27
Nodes (10): CORE-004: The text of each completion label (block not found), Text labels questions (R8.3), ENT-007: Load order when two packs define the same label, GP-013: The sea-race labels (`SNCA`, `SSC`, `SCAA`, `SCAB`) and street-race la..., Batch P1.2: Text labels (R8.3), UI-016: The full slot list and which systems own which slot, UI-017: How DLC global blocks are merged and which wins on a clash, UI-018: A label-name index (most names are only known by hash) (+2 more)

### Community 156 - "Tattoos and barber shops"
Cohesion: 0.25
Nodes (9): GET_TATTOO_SHOP_DLC_ITEM_DATA, shop_tattoo.meta, 32 eye colours, Barber rank locks, Hair fades (hairOverlay decorations), hairdo_shop_mp (barber), shop_controller, Shop table (indices 0 to 64) (+1 more)

### Community 157 - "Weather timecycle files"
Cohesion: 0.25
Nodes (7): w_*.xml weather files, 17 weather types, cloudkeyframes.xml, TimeMult, weather.xml, WeatherGpuFx, WeatherTypes

### Community 158 - "Police and service AI questions"
Cohesion: 0.33
Nodes (9): AI-034: The names and values of the 9 crime-info entries, AI-035: How crime points are added per crime, AI-036: The full vehicle sets with model names, AI-047: Crime points added per crime (set in the engine), Batch D4: dispatch.meta, crimeinformation.meta, wantedtuning.ymt, playerinfo.ymt..., Police and service AI questions (R17.7), GP-073: What the 5 non-story entries in `PlayerStatInfos` are (their names did..., R17.7 Police and service AI (+1 more)

### Community 159 - "Data needs and extraction tools"
Cohesion: 0.25
Nodes (7): Data needs: open questions that need game files, Data needs group: Questions that need assets, tools/rpf-cw.ps1 CodeWalker extraction, CodeWalker library from PowerShell (YmapFile, YtypFile, RelFile ...), Data rows never attempted (PHY-011, PHY-014, PHY-005, GP-055 ...), CodeWalker (data file extraction), CodeWalker 30 dev46 (CodeWalker.Core, MetaXml)

### Community 160 - "Post-death weather reroll"
Cohesion: 0.29
Nodes (7): CLEAR_TIMECYCLE_MODIFIER, respawn_controller, CLEAR_WEATHER_TYPE_PERSIST, Global_4525837, replay_controller, respawn_controller, SET_RANDOM_WEATHER_TYPE

### Community 161 - "Ragdoll and fall damage questions"
Cohesion: 0.32
Nodes (8): Ped physics and ragdoll questions (R2.3), ENT-017: Which tuning set is chosen for which weapon and vehicle, and the 3 has..., ENT-018: Fall damage by height, ENT-019: What `nm_blend_out_sets.meta` sets for getting up, ENT-020: Where fall damage is set (not in the ragdoll files), CNmBlendOutSetManager / nm_blend_out_sets.meta, ENT-019: nm_blend_out_sets.meta (103 NMBS sets), R3.8 Health, armour, death and arrest

### Community 162 - "Open questions / PC session plan: Time, weather and wind questions"
Cohesion: 0.32
Nodes (8): Time, weather and wind questions (R2.6), WLD-013: How long one `TimeMult` unit lasts, and whether the cycle position is ..., WLD-014: Whether wind changes the flight of aircraft, the drift of boats, or bu..., WLD-015: What the global flag that skips the post-death weather reroll is, and ..., WLD-016: How `SET_OVERRIDE_WEATHER` and the persistent lock interact when both ..., WLD-018: The base length of one weather `TimeMult` unit (not in the file), WLD-019: Whether wind pushes aircraft or boats, R2.6 Time, weather and wind

### Community 163 - "DLC natives used by the game scripts / LOBBY natives used by the game scripts"
Cohesion: 0.25
Nodes (8): DLC natives used by the game scripts, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, LOBBY natives used by the game scripts, LOBBY_AUTO_MULTIPLAYER_FREEMODE, LOBBY_SET_AUTO_MULTIPLAYER, LOBBY native namespace: LOBBY natives: auto multiplayer lobby flow

### Community 164 - "Patrol routes"
Cohesion: 0.29
Nodes (7): Patrol route natives, data.Patrol block in fm_content scripts, docks_setup, fm_content_* scripts, Patrol routes (miss_ names, closed loop), TASK_PATROL, WORLD_HUMAN_GUARD_STAND

### Community 165 - "User interface topics"
Cohesion: 0.29
Nodes (7): User interface, R8.1, R8.2, R8.3, R8.4, R8.5, R8.6

### Community 166 - "AI cookbook and patterns"
Cohesion: 0.29
Nodes (5): Cookbook: spawning peds and giving them AI, Pattern: bodyguard ped, pedpersonality.ymt, combatbehaviour.meta, pedaccuracy.meta, Relationship groups natives, Category: LSPDFR and police roleplay

### Community 167 - "Cookbook: Vehicle traps"
Cohesion: 0.29
Nodes (4): Cookbook: world and map, Pattern: placed scene of props, CREATE_OBJECT, CREATE_MODEL_HIDE, REQUEST_IPL, door system natives, ymap/ytyp additions in DLC pack

### Community 168 - "DLC storylines questions"
Cohesion: 0.48
Nodes (7): DLC storylines in GTA Online questions (R7.9), ON-014: Which stats each flow keys on, step by step, ON-015: The text of the voice-only flows (`XM4V_FLW`, `S25R_FLW`, `SR2CH_FLW` ..., ON-016: Which update each `fm_content_*` script arrived in (compare decompile ..., ON-017: The flows for After Hours, Doomsday and the 2015 heists (no flow label..., ON-018: The mp2025_02 update's name and story, Batch P3.10: DLC storylines (R7.9)

### Community 169 - "MISC natives used by the game scripts"
Cohesion: 0.33
Nodes (7): MISC natives used by the game scripts, CLEAR_BIT, IS_PC_VERSION, MISC native namespace: MISC natives: bitwise, random, weather, save registration, platform checks, dispatch, REGISTER_INT_TO_SAVE, SET_BIT, SET_WEATHER_TYPE_OVERTIME_PERSIST

### Community 170 - "Weapons: Bullet damage model"
Cohesion: 0.33
Nodes (6): Bullet damage model (instant hit), CWeaponInfo, Damage fall-off, Headshot damage modifier, Penetration, WeaponRange

### Community 171 - "Weapons data files"
Cohesion: 0.33
Nodes (6): weaponarchetypes.meta, weapons.meta and weaponcomponents.meta, CWeaponInfo / CAmmoInfo definitions, Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta, Pattern: weapon loadout

### Community 172 - "Business computer apps"
Cohesion: 0.33
Nodes (6): appbusinesshub, appsecuroserv, apparcadebusiness, appbunkerbusiness, appsmuggler, Business computer apps (Scaleform)

### Community 173 - "Cutscenes and dialogue questions"
Cohesion: 0.40
Nodes (6): Cutscenes and dialogue questions (R5.6), GP-005: How many cutscene files ship (`.cut` in the `x64` archives and DLC pac..., GP-006: Exact meanings of the `START_CUTSCENE` and `REGISTER_ENTITY_FOR_CUTSCE..., GP-007: The layout of `dialogue_handler`'s request globals (speakers, root, bl..., Batch P4.5: Cutscenes and dialogue (R5.6), R5.6 Cutscenes and dialogue

### Community 174 - "DATAFILE natives used by the game script / HUD natives used by the game scripts"
Cohesion: 0.33
Nodes (6): HUD natives used by the game scripts, CLEAR_HELP, IS_PAUSE_MENU_ACTIVE, HUD native namespace: HUD natives: blips, text commands, help, theFeed, minimap, pause menu, SET_BLIP_COLOUR, SET_BLIP_NAME_FROM_TEXT_FILE

### Community 175 - "INTERIOR natives used by the game script"
Cohesion: 0.33
Nodes (6): INTERIOR natives used by the game scripts, DEACTIVATE_INTERIOR_ENTITY_SET, ENABLE_SHADOW_CULL_MODEL_THIS_FRAME, GET_INTERIOR_AT_COORDS_WITH_TYPE, IS_VALID_INTERIOR, INTERIOR native namespace: INTERIOR natives: interior proxies, entity sets, rooms

### Community 176 - "MONEY natives"
Cohesion: 0.33
Nodes (6): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC

### Community 177 - "PHYSICS natives used by the game scripts"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 178 - "Ped component variations"
Cohesion: 0.40
Nodes (5): Component slots, CPedVariationInfo component .ymt, SET_PED_COMPONENT_VARIATION, Ped component .ymt, SET_PED_COMPONENT_VARIATION

### Community 179 - "Script launch graph questions"
Cohesion: 0.50
Nodes (5): CORE-021: Resolve table-driven launches (second pass of the graph), GP-009: Who starts `minigame_stats_tracker` and `minigame_ending_stinger` (not..., GP-040: Who starts the `family_scene_*` scripts, Batch P2.6: Script launch graph (R0.5), R0.5 Script launch graph

### Community 180 - "Vehicle handling questions"
Cohesion: 0.70
Nodes (5): Vehicle physics: handling, damage and upgrades questions (R2.2), PHY-011: Bit names for the model, handling, damage and advanced flags, checked ..., PHY-012: How the engine turns `fInitialDriveMaxFlatVel` and the drive force int..., PHY-013: What exactly each `statMods` modifier changes (percent of what), R2.2 Vehicle physics / handling

### Community 181 - "NETSHOPPING natives"
Cohesion: 0.40
Nodes (5): NETSHOPPING native namespace, NET_GAMESERVER_BASKET_START, NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, NET_GAMESERVER_CHECKOUT_START, NET_GAMESERVER_IS_SESSION_VALID

### Community 182 - "OBJECT natives used by the game scripts"
Cohesion: 0.40
Nodes (5): CREATE_OBJECT, DELETE_OBJECT, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 183 - "PAD natives"
Cohesion: 0.40
Nodes (5): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace

### Community 184 - "RECORDING natives used by the game scrip"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 185 - "SCRIPT natives"
Cohesion: 0.40
Nodes (5): GET_EVENT_DATA, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 186 - "SOCIALCLUB natives used by the game scri"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 187 - "ITEMSETS natives"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 188 - "REPLAY natives used by the game scripts"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 189 - "SECURITY natives used by the game script"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

## Ambiguous Edges - Review These
- `Level 5: network testbed level` → `common:/data/levels/stripped`  [AMBIGUOUS]
  docs/00-getting-started/boot.md · relation: references

## Knowledge Gaps
- **877 isolated node(s):** `AUDIO namespace`, `BRAIN namespace`, `CUTSCENE namespace`, `DATAFILE namespace`, `DECORATOR namespace` (+872 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 911 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Surviving game updates` to `Rockstar Creator internals`, `Runtime scripts: main_persistent`, `Native namespace map`, `Properties in GTA Online`, `The global variable map: FMMC globals`, `Economy and pickups`, `The script VM`, `The story mission flow`, `How GTA Online works`, `Props, archetypes and doors`, `Rockstar services`, `Music and radio: RadioStation object`, `Boot and script control`, `Fire, explosions and projectiles`, `Examples and data-file sets`, `Credits and build version`, `Physics cost`, `Native usage`, `Animation`, `Measuring performance`, `Memory, pools and limits`, `Time, weather and wind`, `Timecycle and post effects`, `Population`, `Scenarios and ambient life`, `Text labels`, `Strangers, freaks and side content`, `Script launch graph`, `Anatomy of a story mission`, `Organisations and businesses`, `The job lobby`, `Interaction menu, phone and apps`, `AI cost and level of detail`, `Random events`, `Cookbook: Pattern 110`, `How audio is organised`, `Weapons: AmmoMax six ammo caps`, `Cutscenes and dialogue`, `Flying`, `Particles and decals`, `Wanted level and police`, `Controls and camera`, `Text and names in content`, `Peds`, `Interiors and IPLs`, `Online cosmetics and shops`, `Minigames and activities`, `Heists in GTA Online / Open questions`, `Story systems that clash with an Online  / Open questions`, `Perception and events`, `How Rockstar's scripts drive AI`, `Completion, autosave and achievements`, `Character switching`, `Inside freemode`, `CONTRIBUTING.md`, `Vehicles`, `Ambient life`, `Appearance and clothing`, `DLC storylines in GTA Online`, `Stats, tunables and the server's role`, `Load times and stutter`, `Collision, materials and shape tests`, `Scaleform movies`, `07 Legacy / 03 Menus and UI`, `GTA Online / Open questions`, `Police and service AI`, `Vehicle generators and traffic`, `Respawn, death and arrest / Open questions`, `Cameras`, `Vehicle handling data`, `Map data`, `CLAUDE.md`, `Data needs: Data batch D8`, `Navigation and pathfinding`, `Speech and dialogue`, `Swimming and diving`, `Natives as the engine API`, `Data batch D7 (engine config)`, `Relationships and groups`, `Ped physics and ragdoll`, `Open questions: Block A`, `Water and buoyancy`, `Combat and AI`, `The Online character creator`, `Open questions: Questions by category`, `Decisions and personalities`, `Graphics settings`, `Replay, director mode and the Rockstar E`, `Transitions and sessions / Open questions`, `Handoff: Status`, `Driving AI`, `Rendering, visual settings and LOD`, `Driving and AI driving`, `Animation and camera questions`, `Player skills and abilities`, `Archives and the content system`, `Streaming`, `Swimming and diving questions`, `Saves`, `UGC mission files / Archive and data file atlas`, `The AI architecture`, `Health, armour, death and arrest / Open questions`, `Tools / PC session plan`, `Driving AI questions`, `Boot and getting-started questions`, `Missions`, `HUD, colours and blips`, `Pause and Online menus`, `Open questions / PC session plan: Partial data results and what would fini`, `Open questions: Batch D8`, `Story-mode UI`, `AI open questions`, `Open questions / PC session plan: Weapons questions`, `Open questions: Batch P4.2`, `Water and buoyancy questions`, `Graphics settings, one by one`, `Server-backed Online screens`, `Reading the repo in Obsidian`, `Streaming, memory and video memory`, `Completion and autosave questions`, `Timecycle and post effects questions`, `Text labels questions`, `Police and service AI questions`, `Data needs and extraction tools`, `Ragdoll and fall damage questions`, `Open questions / PC session plan: Time, weather and wind questions`, `Cutscenes and dialogue questions`, `Script launch graph questions`, `Vehicle handling questions`?**
  _High betweenness centrality (0.300) - this node is a cross-community bridge._
- **What connects `AUDIO namespace`, `BRAIN namespace`, `CUTSCENE namespace` to the rest of the system?**
  _877 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Rockstar Creator internals` be split into smaller, more focused modules?**
  _Cohesion score 0.051106639839034206 - nodes in this community are weakly interconnected._
- **Why does `PC session plan: what to do at the game PC` connect `PC session safety rules` to `Rockstar Creator internals`, `Runtime scripts: main_persistent`, `Native namespace map`, `Surviving game updates`, `The script VM`, `Music and radio: RadioStation object`, `Boot and script control`, `Fire, explosions and projectiles`, `Physics cost`, `Native usage`, `Animation`, `Measuring performance`, `Memory, pools and limits`, `Time, weather and wind`, `Timecycle and post effects`, `Population`, `Scenarios and ambient life`, `Text labels`, `Strangers, freaks and side content`, `Anatomy of a story mission`, `AI cost and level of detail`, `Random events`, `Weapons: AmmoMax six ammo caps`, `Cutscenes and dialogue`, `Particles and decals`, `Wanted level and police`, `Controls and camera`, `Text and names in content`, `Interiors and IPLs`, `Online cosmetics and shops`, `Minigames and activities`, `Story systems that clash with an Online  / Open questions`, `Perception and events`, `How Rockstar's scripts drive AI`, `Character switching`, `Vehicles`, `Data batch PC1 rows`, `Ambient life`, `Appearance and clothing`, `Stats, tunables and the server's role`, `Load times and stutter`, `Collision, materials and shape tests`, `GTA Online / Open questions`, `Vehicle generators and traffic`, `Respawn, death and arrest / Open questions`, `Cameras`, `Vehicle handling data`, `Data needs: Data batch D8`, `Navigation and pathfinding`, `Speech and dialogue`, `Swimming and diving`, `Natives as the engine API`, `Tools and resources`, `Data batches D10 and D11`, `Data batch D7 (engine config)`, `Relationships and groups`, `Ped physics and ragdoll`, `Open questions: Block A`, `Water and buoyancy`, `Combat and AI`, `The Online character creator`, `Open questions: Questions by category`, `Data batches D1 and D12`, `Decisions and personalities`, `Graphics settings`, `Replay, director mode and the Rockstar E`, `Handoff: Status`, `Block B and AI cost questions`, `Driving AI`, `Rendering, visual settings and LOD`, `Driving and AI driving`, `Animation and camera questions`, `Player skills and abilities`, `Archives and the content system`, `Streaming`, `Swimming and diving questions`, `Saves`, `The AI architecture`, `Health, armour, death and arrest / Open questions`, `Tools / PC session plan`, `Ped personality questions`, `HUD, colours and blips`, `Audio questions`, `Water and buoyancy questions`, `Graphics settings, one by one`, `Server-backed Online screens`, `Streaming, memory and video memory`, `Hashed function name questions`, `Block C world and AI questions`, `Data needs: common.rpf`, `Data batch D6 (appearance)`, `Data needs and extraction tools`?**
  _High betweenness centrality (0.114) - this node is a cross-community bridge._
- **Should `Runtime scripts: main_persistent` be split into smaller, more focused modules?**
  _Cohesion score 0.049689440993788817 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Cookbook: Pattern 110` to `Rockstar Creator internals`, `The global variable map: FMMC globals`, `Surviving game updates`, `Economy and pickups`, `The script VM`, `The story mission flow`, `Props, archetypes and doors`, `Music and radio: RadioStation object`, `Fire, explosions and projectiles`, `Examples and data-file sets`, `Physics cost`, `Animation`, `Memory, pools and limits`, `Time, weather and wind`, `Timecycle and post effects`, `Population`, `Scenarios and ambient life`, `Text labels`, `Strangers, freaks and side content`, `Script launch graph`, `Anatomy of a story mission`, `The job lobby`, `How audio is organised`, `Weapons: AmmoMax six ammo caps`, `Cutscenes and dialogue`, `Flying`, `Particles and decals`, `Wanted level and police`, `Controls and camera`, `Text and names in content`, `1. How mods work`, `Peds`, `Interiors and IPLs`, `Minigames and activities`, `Perception and events`, `How Rockstar's scripts drive AI`, `Completion, autosave and achievements`, `Character switching`, `CONTRIBUTING.md`, `Vehicles`, `Ambient life`, `Appearance and clothing`, `DLC storylines in GTA Online`, `Collision, materials and shape tests`, `Scaleform movies`, `07 Legacy / 03 Menus and UI`, `Police and service AI`, `Vehicle generators and traffic`, `Respawn, death and arrest / Open questions`, `Vehicle handling data`, `Map data`, `Navigation and pathfinding`, `Speech and dialogue`, `Swimming and diving`, `Natives as the engine API`, `Tools and resources`, `Glossary`, `Relationships and groups`, `Ped physics and ragdoll`, `Open questions: Block A`, `Water and buoyancy`, `Combat and AI`, `Decisions and personalities`, `Graphics settings`, `Driving AI`, `Rendering, visual settings and LOD`, `Driving and AI driving`, `Player skills and abilities`, `Archives and the content system`, `Streaming`, `Saves`, `UGC mission files / Archive and data file atlas`, `The AI architecture`, `Health, armour, death and arrest / Open questions`, `Tools / PC session plan`, `Missions`, `Story-mode UI`, `Streaming, memory and video memory`, `AI cookbook and patterns`, `Cookbook: Vehicle traps`, `Weapons data files`, `Mission cookbook`?**
  _High betweenness centrality (0.114) - this node is a cross-community bridge._

### Low-confidence Hints
_AMBIGUOUS edges — the extractor was unsure. Verify before acting on these._

- **What is the exact relationship between `Level 5: network testbed level` and `common:/data/levels/stripped`?**
  _Edge tagged AMBIGUOUS (relation: references) - confidence is low._