# Graph Report - gta5-under-the-hood  (2026-11-04)

## Corpus Check
- 2 files · ~495,135 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 4729 nodes · 10685 edges · 185 communities (183 shown, 2 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 576 edges (avg confidence: 0.85)
- Token cost: 106,217 input · 0 output

## Community Hubs (Navigation)
- Native namespace map
- Properties in GTA Online
- Economy and pickups
- Boot and script control
- Police and service AI / Wanted level and police
- Runtime scripts: main_persistent
- How Rockstar's scripts drive AI
- UGC mission files / Archive and data file atlas
- Data needs: handling.meta
- The script VM
- Rockstar Creator internals
- Timecycle and post effects
- Props, archetypes and doors
- The story mission flow
- Stats, tunables and the server's role
- Physics cost
- Fire, explosions and projectiles
- Animation
- How GTA Online works
- Surviving game updates
- Cutscenes and dialogue
- Research roadmap
- Rockstar services
- Combat and AI
- How audio is organised
- Open questions: Phase 1
- Time, weather and wind
- Script launch graph
- Music and radio: RadioStation object
- Text labels
- Vehicle generators and traffic
- Interaction menu, phone and apps
- Open questions: Block A
- Cameras
- Completion, autosave and achievements
- Interiors and IPLs
- Anatomy of a story mission
- Strangers, freaks and side content
- Open questions: Batch P1.5
- Memory, pools and limits
- Controls and camera
- Native usage
- CONTRIBUTING.md
- Scenarios and ambient life
- AI cost and level of detail
- Minigames and activities
- DLC storylines in GTA Online
- Measuring performance
- Population
- Collision, materials and shape tests
- The job lobby
- Server-backed Online screens: The ONLINE tab, 22 entries
- The global variable map: FMMC globals
- Vehicles
- Flying
- Organisations and businesses
- Water and buoyancy
- Perception and events
- Relationships and groups
- Online cosmetics and the shops that sell / Open questions
- GTA Online / Open questions
- Open questions: AI open questions
- Weapons: AmmoMax six ammo caps
- Appearance and clothing
- Inside freemode
- Random events
- Glossary
- Native usage index
- Open questions / PC session plan: Data rows never attempted
- Rendering, visual settings and LOD
- Graphics settings, one by one
- Character switching
- Heists in GTA Online / Open questions
- 1. How mods work
- VEHICLE natives used by the game scripts
- NETWORK natives used by the game scripts
- PED natives used by the game scripts
- Swimming and diving
- Story systems that clash with an Online  / Open questions
- Particles and decals
- Map data
- Setup
- Ambient life: Ambient ped task loop
- TASK natives used by the game scripts
- Speech and dialogue
- 05 Native functions
- PLAYER natives used by the game scripts
- STATS natives used by the game scripts
- Data needs: Data batch D8
- The AI architecture
- Decisions and personalities
- Open questions / PC session plan: Part 2
- Tools / PC session plan
- CLAUDE.md
- Open questions: Questions by category
- Driving AI
- Peds
- Replay, director mode and the Rockstar E
- Streaming
- Transitions and sessions / Open questions
- CAMERA natives used by the game scripts
- Server-backed Online screens: Server calls per screen table
- Text and names in content
- Respawn, death and arrest / Open questions
- Tools and resources
- Navigation and pathfinding
- Missions
- Driving and AI driving
- Vehicle physics: CHandlingData
- Handoff: Status
- Cookbook: Pattern 110
- Natives as the engine API
- Health, armour, death and arrest / Open questions
- 07 Legacy / 03 Menus and UI
- Archives and the content system
- Saves
- The Online character creator
- 7. Your first C++
- Data needs: vehicles.meta
- System requirements outside the game fol
- Player skills and abilities
- 06 The Lua plugin
- Open questions / PC session plan: Batch D10
- Open questions / PC session plan: Data group
- Open questions / PC session plan: The Online character creator questions
- Vehicle physics: Sub-handling blocks
- Open questions / PC session plan: Partial data results and what would fini
- Open questions / PC session plan: Weapons questions
- DATAFILE natives used by the game script / HUD natives used by the game scripts
- Data needs: Data batch D10
- Streaming, memory and video memory
- Windows and drivers / Open questions
- Open questions: Block D
- Research tools
- Handoff: Part 1
- Ped physics and ragdoll
- GTA V Under the Hood
- Open questions: Batch P4.2
- Reading the decompiled game scripts
- Open questions / PC session plan: Time, weather and wind questions
- ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip
- Data needs: tools/rpf-cw.ps1
- EXTRAMETADATA natives used by the game s
- WEAPON natives used by the game scripts
- Open questions: Batch D8
- Data needs: Data batch D9
- Data needs: common.rpf
- PATH natives used by the game scripts / Navigation and pathfinding
- The global variable map: Player broadcast data
- 9. Next steps and sharing your mod / RPF archives
- Ambient life: Mission set-piece pattern
- CLOCK natives used by the game scripts / Time, weather and wind
- DLC natives used by the game scripts / LOBBY natives used by the game scripts
- Data needs: Data batch D11
- BUILTIN natives used by the game scripts / BRAIN natives used by the game scripts
- FIRE natives used by the game scripts / EVENT natives used by the game scripts
- Data needs: gameconfig.xml
- Runtime scripts: Global blocks
- Cookbook: Vehicle traps
- Open questions / PC session plan: Driving and AI driving questions
- Open questions: Batch P2.2
- Open questions: Performance open questions
- MISC natives used by the game scripts
- Music and radio: Music events
- Weapons: Bullet damage model
- Open questions: Knowledge graph open questions
- INTERIOR natives used by the game script
- PHYSICS natives used by the game scripts
- STREAMING natives used by the game scrip
- Runtime scripts / Memory, pools and limits
- Mod-builder's cookbook
- Cookbook: Pattern 171
- Open questions: Ambient life questions
- OBJECT natives used by the game scripts
- RECORDING natives used by the game scrip
- SOCIALCLUB natives used by the game scri
- Open questions: Ask the contributor or community
- REPLAY natives used by the game scripts
- SECURITY natives used by the game script
- SHAPETEST natives used by the game scrip
- AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail
- Research roadmap / Ambient life
- The global variable map / Saves
- The global variable map: Server
- AI cost and level of detail / Ambient life: SET_PED_POPULATION_BUDGET / SET_VEHICLE_

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 243 edges
2. `Data needs: open questions that need game files` - 195 edges
3. `Native namespace map` - 143 edges
4. `Mod map: what to read for the mod you want to make` - 112 edges
5. `Runtime scripts: the scripts that keep the game running` - 104 edges
6. `Native usage: which scripts call which natives` - 98 edges
7. `Tools` - 92 edges
8. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 86 edges
9. `Properties in GTA Online` - 83 edges
10. `The global variable map` - 83 edges

## Surprising Connections (you probably didn't know these)
- `CodeWalker (CodeWalker.Core.dll)` --semantically_similar_to--> `CodeWalker`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CLAUDE.md
- `GTA-V-Decompiled-Scripts community decompile` --semantically_similar_to--> `Decompiled scripts (community decompile)`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CLAUDE.md
- `ScriptHookVDotNet.asi` --semantically_similar_to--> `ScriptHookVDotNet (SHVDN)`  [INFERRED] [semantically similar]
  docs/00-getting-started/system-requirements.md → scripting/script-vm.md
- `Open question: animal models by kind and where each spawns` --semantically_similar_to--> `AI-009: Animal models by kind and where they spawn`  [INFERRED] [semantically similar]
  docs/ai/ambient-life.md → DATA-NEEDS.md
- `joaat candidate-name hashing` --semantically_similar_to--> `joaat name hashing (check: weapon_pistol = 453432689)`  [INFERRED] [semantically similar]
  docs/ai/decisions-and-personalities.md → HANDOFF.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **Activity start flow** — docs_gameplay_missions_minigames_and_activities_mf_control_bitsetids_0, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_minigames_and_activities_mission_candidate_slot, docs_gameplay_missions_minigames_and_activities_playstats_oddjob_done [EXTRACTED 1.00]
- **Add-on vehicle data files** — docs_entities_vehicles_vehicles_vehicles_meta, docs_entities_vehicles_vehicles_handling_meta, docs_entities_vehicles_vehicles_carvariations, docs_entities_vehicles_vehicles_carcols, docs_entities_vehicles_vehicles_vehicle_metadata_file [EXTRACTED 1.00]
- **Load, check and free a mission text block** — docs_ui_text_labels_request_additional_text, docs_ui_text_labels_has_this_additional_text_loaded, docs_ui_text_labels_clear_additional_text, docs_ui_text_labels_text_slots [EXTRACTED 1.00]
- **Mission set-piece crowd control** — docs_ai_ambient_life_clear_area_of_peds, docs_ai_ambient_life_set_ped_density_multiplier_this_frame, docs_ai_ambient_life_set_ped_non_creation_area, docs_ai_ambient_life_set_ped_model_is_suppressed, docs_ai_ambient_life_set_scenario_type_enabled, docs_ai_ambient_life_task_wander_standard [EXTRACTED 1.00]
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
- **Hostile ped recipe: side, attributes, accuracy, defensive area, task, events blocked, keep task** — docs_ai_relationships_and_groups_set_ped_relationship_group_hash, docs_ai_script_ai_patterns_set_ped_combat_attributes, docs_ai_script_ai_patterns_set_ped_accuracy, docs_ai_script_ai_patterns_set_ped_sphere_defensive_area, docs_ai_script_ai_patterns_task_combat_ped, docs_ai_perception_and_events_set_blocking_of_non_temporary_events, docs_ai_perception_and_events_set_ped_keep_task [EXTRACTED 1.00]
- **Interior activation flow (IPL, pin, entity set, refresh)** — docs_world_interiors_and_ipls_request_ipl, docs_core_streaming_pin_interior_in_memory, docs_world_interiors_and_ipls_is_interior_ready, docs_world_interiors_and_ipls_activate_interior_entity_set, docs_world_interiors_and_ipls_refresh_interior [EXTRACTED 1.00]
- **Job launch pipeline: corona to controller** — docs_online_heists_fmmc_launcher, docs_online_job_lobby_activity_table, scripting_native_usage_builtin_start_new_script_with_args, docs_online_job_lobby_start_argument_block, docs_online_heists_fm_mission_controller [EXTRACTED 1.00]
- **Mod runtimes beside the script VM** — modding_02_tools_you_need_scripthookv, scripting_script_vm_shvdn, scripting_script_vm_lua_asi, scripting_script_vm_scripttimeoutthreshold [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Music event playback chain** — docs_audio_music_and_radio_trigger_music_event, docs_audio_music_and_radio_music_events, docs_audio_music_and_radio_starttrackaction, docs_audio_music_and_radio_mood, docs_audio_music_and_radio_stem_mix [EXTRACTED 1.00]
- **Native name resolution pipeline** — scripting_native_usage_native_tables, scripting_natives_nativedb, scripting_native_usage_decompiler_name_aliases, scripting_native_usage_unk_0x_hash_calls [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Load-area-before-task navigation pattern** — docs_ai_navigation_add_navmesh_required_region, docs_ai_navigation_is_navmesh_loaded_in_area, scripting_native_usage_task_task_follow_nav_mesh_to_coord, docs_ai_navigation_navmesh_tiles_ynv [EXTRACTED 1.00]
- **Online systems that depend on Rockstar's servers** — docs_online_01_how_online_works_online_stats, docs_online_01_how_online_works_gameserver_transactions, docs_online_01_how_online_works_tunables, docs_online_01_how_online_works_ugc_cloud_content, docs_online_01_how_online_works_network_session [EXTRACTED 1.00]
- **Three kinds of work at the game PC** — pc_session_part1_data_file_run, pc_session_part2_executable, pc_session_part3_in_game_session [EXTRACTED 1.00]
- **Ped AI data: personality, decision maker, combat info, relationship group** — docs_ai_decisions_and_personalities_pedpersonality_ymt, docs_ai_combat_and_perception_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_combat_and_perception_relationship_group_list, docs_ai_combat_and_perception_events_meta [EXTRACTED 1.00]
- **Character switch pipeline** — docs_gameplay_player_character_switching_selector, docs_gameplay_player_character_switching_player_controller_b, docs_gameplay_player_character_switching_start_player_switch, docs_gameplay_player_character_switching_change_player_ped, docs_gameplay_player_character_switching_player_timetable_scene, docs_gameplay_player_character_switching_arrival_scene_picker [EXTRACTED 1.00]
- **Pool and limit adjuster plugins** — docs_core_memory_and_pools_heapadjuster, docs_core_memory_and_pools_packfilelimitadjuster, docs_core_memory_and_pools_weaponlimitsadjuster, docs_core_memory_and_pools_decalslimit_patch, docs_core_memory_and_pools_poolmanager [EXTRACTED 1.00]
- **Population data layers** — docs_entities_spawning_population_popzone_ipl, docs_ai_police_and_services_zonebind_ymt, docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_population_popgroups_ymt [EXTRACTED 1.00]
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
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Scripted scene: synchronized scene, animated camera, fades** — docs_rendering_animation_synchronized_scenes, docs_rendering_animation_create_synchronized_scene, docs_rendering_cameras_render_script_cams, docs_rendering_cameras_default_animated_camera, docs_rendering_cameras_screen_fades [INFERRED 0.75]
- **How the engine keeps AI affordable** — docs_ai_ai_cost_and_lod_maxtotalpeds, docs_ai_ai_cost_and_lod_vehicletimeslicemaxupdatesperframe, docs_ai_ai_cost_and_lod_ctaskmotionbasiclocomotionlowlod, docs_ai_ai_cost_and_lod_dummy_vehicles, docs_ai_ai_cost_and_lod_timeslicing [INFERRED 0.85]
- **Business supplies-production-sell loop** — docs_online_organisations_and_businesses_business_loop, docs_online_organisations_and_businesses_biker_businesses, docs_online_organisations_and_businesses_production_timers, docs_online_organisations_and_businesses_business_computer_apps, docs_online_organisations_and_businesses_app_transactions [INFERRED 0.85]
- **Creator build, save and replay flow** — docs_online_creator_internals_cursor_ray, docs_online_creator_internals_prop_columns, docs_online_creator_internals_ugc_create_mission, docs_online_creator_internals_local_static_props, docs_online_creator_internals_fm_race_controler [INFERRED 0.85]
- **Remaining work split by what it needs** — handoff_scripts_only, handoff_executable_list, handoff_in_game_tests_list, handoff_data_rows_not_attempted [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Material table drives grip, fire and impact effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_collision_and_materials_materialfx_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_wheelfx_dat, docs_rendering_particles_and_decals_mtlfx_table [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Fall damage and ragdoll questions** — open_questions_ent_018, open_questions_ent_020, open_questions_gp_074 [INFERRED 0.85]
- **Force-cleanup bit questions** — open_questions_core_017, open_questions_core_032, open_questions_scr_011, open_questions_on_060 [INFERRED 0.85]
- **pedpersonality.ymt decoding questions** — open_questions_ai_011, open_questions_ai_016, open_questions_ai_017, open_questions_ent_013 [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]
- **Crime to stars to dispatch: witness reporting, crime points, dispatch responses and search** — docs_ai_perception_and_events_cancallpolice, docs_ai_police_and_services_wantedlevelthresholds, docs_ai_police_and_services_wantedresponses, docs_ai_police_and_services_search_helpers, docs_ai_police_and_services_wantedtuning_ymt [INFERRED 0.85]
- **Weather to screen look pipeline** — docs_world_time_and_weather_weathercycles, docs_rendering_timecycle_and_post_effects_weather_timecycle, docs_rendering_timecycle_and_post_effects_timecycle_modifiers, docs_rendering_timecycle_and_post_effects_animated_post_effects [INFERRED 0.85]

## Communities (185 total, 2 thin omitted)

### Community 0 - "Native namespace map"
Cohesion: 0.04
Nodes (70): SCR-001: Split MISC into sub-families with their own owners (weather, cheats..., SCR-002: Which natives are reached only through shared helper code and never..., SCR-003: Which namespaces' unused natives still work in story mode (useful to..., Scripting open questions, Native namespace map questions (R0.8), SCR-002: The functions behind the scripts' function pointers..., Native namespace map, 54 natives only in indirect-call code (+62 more)

### Community 1 - "Properties in GTA Online"
Cohesion: 0.06
Nodes (66): appbikerbusiness, Properties in GTA Online, ADD_BLIP_FOR_COORD, AM_MP_ARCADE, AM_MP_BUNKER, AM_MP_FIXER_HQ, AM_MP_HANGAR, AM_MP_NIGHTCLUB (+58 more)

### Community 2 - "Economy and pickups"
Cohesion: 0.05
Nodes (64): clothes_shop_sp, Economy and pickups, ADD_PICKUP_TO_INTERIOR_ROOM_BY_NAME, atm_trigger, BAWSAQ exchange, BSS_BSTR company labels, code_controller, Collectable scripts (+56 more)

### Community 3 - "Boot and script control"
Cohesion: 0.06
Nodes (61): Boot and script control: from launch to control, and between story and Online, Shared activity-type helper (212 scripts), Benchmark boot path, asiloader.log / ScriptHookV.log / ScriptHookVDotNet.log, director_mode, flow_controller, freemode, GET_INDEX_OF_CURRENT_LEVEL (+53 more)

### Community 4 - "Police and service AI / Wanted level and police"
Cohesion: 0.06
Nodes (59): Police and service AI, Assassins dispatch type, Crime-info entries (9, CRIME_KILL_COP weight 5), CRIME_KILL_COP, dispatch.meta, Dispatch spawning rules (250 m ideal), Dispatch vehicle sets (15), dispatchtuning.ymt (+51 more)

### Community 5 - "Runtime scripts: main_persistent"
Cohesion: 0.06
Nodes (56): Force cleanup, freemode, Runtime scripts: the scripts that keep the game running, achievement_controller, autosave_controller, blip_controller, buddydeathresponse, building_controller (+48 more)

### Community 6 - "How Rockstar's scripts drive AI"
Cohesion: 0.06
Nodes (56): Patrol route natives, SET_PED_KEEP_TASK, SET_PED_SEEING_RANGE, How Rockstar's scripts drive AI, agency_heist3a, agency_heist3b, am_casino_peds, am_mp_peds (+48 more)

### Community 7 - "UGC mission files / Archive and data file atlas"
Cohesion: 0.06
Nodes (55): Decompile, .ydr drawable, Archive and data file atlas, 5,290 archives and 389,555 files, 89 DLC packs, .awc audio wave container, common.rpf, g9ec packs (+47 more)

### Community 8 - "Data needs: handling.meta"
Cohesion: 0.07
Nodes (51): Data needs: open questions that need game files, AI-009: Animal models by kind and where they spawn, AI-011: Personalities, bravery and driving ability, AI-014: Meaning of taskdata.meta and scriptedguntasks.meta, AI-016: Personalities, bravery and driving ability, AI-017: Unnamed civilian bravery and criminality types, AI-019: How MotivationMin/Max is used, AI-020: Driving ranges vs driving tasks (+43 more)

### Community 9 - "The script VM"
Cohesion: 0.07
Nodes (48): SCR-012: What thread priority values change, SCR-013: The event queue indexes and the script event layout, SCR-014: Which of the duplicated pool entries in gameconfig.xml applies to the..., The script VM questions (R1.1), R1.1 The script VM, YSC reader (needed to settle pointer-only natives), The script VM, director_mode script (+40 more)

### Community 10 - "Rockstar Creator internals"
Cohesion: 0.07
Nodes (50): Rockstar Creator internals, am_mp_creator_trailer / _aircraft (not the content creator), Stunt track bone snapping (bones 2 to 5), CREATE_MODEL_HIDE (Fixtures removed, dhprop), creator (hub script), Creator limits (200 props, 20 dynamic ...), DATAFILE natives, Dynamic props in deathmatch and mission controllers (+42 more)

### Community 11 - "Timecycle and post effects"
Cohesion: 0.05
Nodes (44): Timecycle and post effects, ADD_TCMODIFIER_OVERRIDE, AnimMode, ANIMPOSTFX_STOP, animpostfx.ymt, CAMERA_secuirity_FUZZ, CLEAR_TIMECYCLE_MODIFIER, DrugsMichaelAliensFight (+36 more)

### Community 12 - "Props, archetypes and doors"
Cohesion: 0.07
Nodes (48): IPLs (optional map sections), Props, archetypes and doors, 2D effects (extensions), ACTIVATE_PHYSICS, ADD_DOOR_TO_SYSTEM, Archetype, Archetype flag bits, Door auto-open flags (+40 more)

### Community 13 - "The story mission flow"
Cohesion: 0.09
Nodes (46): The story mission flow: how missions unlock, Activate strand command, Activate stranger mission command, agency_heist2 special builder, code_controller, What a fail does to the flow (pass/fail labels), Blitz Play prep 3 (fbi4_prep3, never activated), finale_choice (+38 more)

### Community 14 - "Stats, tunables and the server's role"
Cohesion: 0.07
Nodes (47): Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, clothes_shop_mp, Hash-only tunables (7,296; 311 recovered), MONEY NETWORK_SPENT_* / NETWORK_EARN_* natives, mpstatssetup.xml (17,928 Online stats), Offline Online mode replacements (local save, tunable defaults, local prices), Packed stats (6,403) (+39 more)

### Community 15 - "Physics cost"
Cohesion: 0.07
Nodes (41): Physics cost, ACTIVATE_PHYSICS, ADD_EXPLOSION, ADD_ROPE, CLEAR_AREA, CLEAR_AREA_OF_OBJECTS, CLEAR_AREA_OF_PROJECTILES, CLEAR_AREA_OF_VEHICLES (+33 more)

### Community 16 - "Fire, explosions and projectiles"
Cohesion: 0.08
Nodes (41): Fire, explosions and projectiles, ADD_EXPLOSION, ADD_OWNED_EXPLOSION, bAppliesContinuousDamage, bForceNonTimedVfx, bIsSmokeGrenade, bSuppressCrime, CAmmoProjectileInfo (+33 more)

### Community 17 - "Animation"
Cohesion: 0.08
Nodes (42): ENT-019: Get-up sets in nm_blend_out_sets.meta, Animation, Animation memory groups, Base clip archives, Clip dictionaries (.ycd), Clip sets, clip_sets.ymt, common_anim.meta (+34 more)

### Community 18 - "How GTA Online works"
Cohesion: 0.07
Nodes (42): mpstatscharactermappingdata.xml, How GTA Online works, am_mp_* property scripts, Ambient events (am_* scripts), ambient_mp.ipl, Phone and computer app* scripts, Broadcast data (host and player), fmmc_launcher (corona) (+34 more)

### Community 19 - "Surviving game updates"
Cohesion: 0.07
Nodes (43): Core engine, R0.2 Script cards for the runtime scripts, R11.2 An update-check tool, R5.3 Saves, completion and autosave, Surviving game updates, Things addressed by number (offsets, globals), Asset dependency list, Byte-pattern scans (FindPattern) (+35 more)

### Community 20 - "Cutscenes and dialogue"
Cohesion: 0.09
Nodes (41): Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A), CREATE_NEW_SCRIPTED_CONVERSATION (+33 more)

### Community 21 - "Research roadmap"
Cohesion: 0.08
Nodes (42): The player, R6.5 Online character creator, Large jobs (priority) list: 13 jobs, Research roadmap, Good first topics, Inbox issues for uncovered findings, R0.7 Archive and data file atlas, R0.8 Native namespace map (+34 more)

### Community 22 - "Rockstar services"
Cohesion: 0.08
Nodes (42): Rockstar services, Catalogue keys (<name>_t<type>_v<version>), CATEGORY_VEHICLE_MOD, CATEGORY_WAREHOUSE_INTERIOR, Cloud files, Cloud stat slots, Crews (NETWORK_CLAN_*), GET_CLOUD_TIME_AS_INT (+34 more)

### Community 23 - "Combat and AI"
Cohesion: 0.09
Nodes (42): Combat and AI (first pass), ADD_RELATIONSHIP_GROUP, AI_GLOBAL_MODIFIER 2.0, Combat behaviour flags (BF_CanUseCover ...), combatbehaviour.meta (16 CCombatInfo), Decision makers (25), DEFAULT_PERCEPTION (60 m sight/hearing), Defensive areas (SET_PED_SPHERE_DEFENSIVE_AREA) (+34 more)

### Community 24 - "How audio is organised"
Cohesion: 0.08
Nodes (40): AUD-001: Number of sounds and sound sets, AUD-005: Unresolved radio station objects, dynamix.dat15.rel, How audio is organised, AUDIO native namespace (281 natives), audio_rel.rpf, Audio scenes and patches, AWC wave containers (.awc) (+32 more)

### Community 25 - "Open questions: Phase 1"
Cohesion: 0.08
Nodes (41): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, Radar and minimap interiors, Pause and Online menus, ACTIVATE_FRONTEND_MENU usage (+33 more)

### Community 26 - "Time, weather and wind"
Cohesion: 0.07
Nodes (39): Time, weather and wind, 17 weather types, branchbend_windsettings.xml, cheat_controller, CLEAR_WEATHER_TYPE_PERSIST, cloudkeyframes.xml, clouds.xml, exile1 (+31 more)

### Community 27 - "Script launch graph"
Cohesion: 0.10
Nodes (41): CORE-021: Resolve table-driven launches (second pass of the graph), GP-040: Who starts the family_scene_ scripts, Batch P2.6: Script launch graph (R0.5), R0.5 Script launch graph, Script launch graph (build 3725), am_mp_drone script, buddydeathresponse script, cellphone_controller script (+33 more)

### Community 28 - "Music and radio: RadioStation object"
Cohesion: 0.07
Nodes (38): Music and radio, AUDIO_GAMEDATA content.xml entries, AUDIO_IS_SCRIPTED_MUSIC_PLAYING, .awc wave containers, CANCEL_MUSIC_EVENT, FM_COUNTDOWN_30S music event, fm_mission_controller, game.dat151.rel (audio game data) (+30 more)

### Community 29 - "Text labels"
Cohesion: 0.09
Nodes (40): Completion label text (199 of 320 in global.gxt2, 121 internal names), Text labels, ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL, americandlc.rpf DLC text, *aud subtitle blocks, BEGIN_TEXT_COMMAND_DISPLAY_HELP, BEGIN_TEXT_COMMAND_DISPLAY_TEXT, BEGIN_TEXT_COMMAND_PRINT (+32 more)

### Community 30 - "Vehicle generators and traffic"
Cohesion: 0.08
Nodes (39): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, Vehicle generators and traffic, Car generator flag bits, Car generators (CCarGen), CREATE_MISSION_TRAIN, CREATE_SCRIPT_VEHICLE_GENERATOR, Dispatch services, DLC road-section ymap copies (+31 more)

### Community 31 - "Interaction menu, phone and apps"
Cohesion: 0.09
Nodes (39): Interaction menu, phone and apps, am_contact_requests (contact services), appbusinesshub, appContacts, appHackerDen (Darnell Inc.), appInternet, AppJIPMP (Quick Join), appsecuroserv (+31 more)

### Community 32 - "Open questions: Block A"
Cohesion: 0.09
Nodes (38): CPU: population, AI, physics and scripts, Population density as biggest lever, Game threads (24, Update TIME_CRITICAL), Open questions (CPU), Heavily modded install script load (52 + 61), 15 W laptop throttling, Load times and stutter, First three minutes hold most hitches (+30 more)

### Community 33 - "Cameras"
Cohesion: 0.10
Nodes (37): REN-008: Unresolved camera shake names, REN-009: CREATE_CAMERA hashes scripts use, Cursor line test (2,400 m probe), Cameras, camCinematicMountedCameraMetadata, camEnvelopeMetadata, Camera shakes, cameras.ymt (+29 more)

### Community 34 - "Completion, autosave and achievements"
Cohesion: 0.10
Nodes (38): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values) (+30 more)

### Community 35 - "Interiors and IPLs"
Cohesion: 0.08
Nodes (36): PIN_INTERIOR_IN_MEMORY, CMloArchetypeDef, Interiors and IPLs, ACTIVATE_INTERIOR_ENTITY_SET, building_controller, CAP_INTERIOR, CMloInstanceDef, DISABLE_INTERIOR (+28 more)

### Community 36 - "Anatomy of a story mission"
Cohesion: 0.10
Nodes (30): Anatomy of a story mission, armenian1 (Franklin and Lamar), Jewel Store Job crew tiers and take, flow_controller, Force cleanup handler (HAS_FORCE_CLEANUP_OCCURRED), Global_80529 mission pass bits, Heist approach (flow integer f_205[7]), jewelry_heist (The Jewel Store Job) (+22 more)

### Community 37 - "Strangers, freaks and side content"
Cohesion: 0.10
Nodes (37): 146 script brains (99 world-point, 47 object), Strangers, freaks and side content, appinternet (Epsilon website), atm_trigger, BailBond_Launcher, Brain set bit mask (story 1, Online 8), code_controller, completionpercentage_controller (+29 more)

### Community 38 - "Open questions: Batch P1.5"
Cohesion: 0.07
Nodes (38): hudcolor.dat colour table, pausemenu.xml menu description, Scaleform movies, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), DLC movies (mpheist, mpapartment), Scaleform .gfx archives, Interior map movies (int<hash>.gfx), Request-wait-call-draw-release pattern (+30 more)

### Community 39 - "Memory, pools and limits"
Cohesion: 0.07
Nodes (37): Memory, pools and limits, ArchiveCount, CAN_REGISTER_MISSION_PEDS / VEHICLES / OBJECTS, CEvent pool, ConfigModelInfo, ConfigPopulation, ConfigStreamingEngine, CTask pool (8,192) (+29 more)

### Community 40 - "Controls and camera"
Cohesion: 0.08
Nodes (38): Control IDs shift +37 in build 3717, Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+30 more)

### Community 41 - "Native usage"
Cohesion: 0.08
Nodes (37): SCR-004: What 0x8F5D1AD832AEB06C and 0x0F7082C60FB479EF do (not in NativeDB), SCR-005: Whether the 29 "build 3889" natives exist in 3725 (IS_NATIVE... style..., SCR-006: A story-only vs Online-only split of every native (which natives..., Native usage questions (R0.3), SCR-004: What 0x8F5D1AD832AEB06C and 0x0F7082C60FB479EF do (not in..., SCR-005: Whether the 29 "build 3889" natives exist in 3725..., R0.3 Native usage / native tables, Native usage: which scripts call which natives (+29 more)

### Community 42 - "CONTRIBUTING.md"
Cohesion: 0.08
Nodes (31): Branch naming (research/<ID>-pass2-<what> ...), File rules table, Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, AI, AI folder topics R3.2, R3.3, R3.7, R17.1-R17.10 (all done first pass) (+23 more)

### Community 43 - "Scenarios and ambient life"
Cohesion: 0.09
Nodes (36): Scenarios and ambient life, act_cinema, ADD_SCENARIO_BLOCKING_AREA, Ambient aircraft and boats, ambientpedmodelsets.meta, Chaining graphs, HEIST_ISLAND_PEDS, MP_POLICE (+28 more)

### Community 44 - "AI cost and level of detail"
Cohesion: 0.10
Nodes (34): AI cost and level of detail, AI LOD by distance (near, middle, far), CTaskMotionBasicLocomotionLowLod, Dummy and super-dummy vehicles, FORCE_ENTITY_AI_AND_ANIMATION_UPDATE (340 scripts), FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts, 4,119 calls), gameconfig.xml (update copy), IS_ENTITY_ON_SCREEN (316 scripts) (+26 more)

### Community 45 - "Minigames and activities"
Cohesion: 0.10
Nodes (36): Minigames and activities, Activity IDs 0 to 18, am_mp_arc_cab_manager (Online arcade), code_controller, controller_ambientarea, golf script (clubs, lies, AI aim, wind), golf_ai_foursome ambient golfers, GP-088 (unarmed code entries 6, 12, 18) (+28 more)

### Community 46 - "DLC storylines in GTA Online"
Cohesion: 0.11
Nodes (35): DLC storylines in GTA Online, AW_FLOW flow (Arena War), BATFMAU After Hours call block (143 roots), BT24_FLOW flow (Bottom Dollar), CH_FLOW flow (Casino Heist), EXEC_FLW flow, FIX_FLOW flow (The Contract), GR_FLOW flow (Gunrunning) (+27 more)

### Community 47 - "Measuring performance"
Cohesion: 0.09
Nodes (30): Measuring performance, ARE_ANY_CCS_PENDING, -benchmark command-line switches, benchmark script, Benchmark 8-state loop, BMARK text block, Content change sets (GROUP_ON_DEMAND, 43 packs), CPU-bound vs GPU-bound test (+22 more)

### Community 48 - "Population"
Cohesion: 0.09
Nodes (34): ENT-024: Unnamed zone fields, ENT-025: How bird and fish groups spawn, zonebind.ymt, LOD settings (LodScale, MaxLodScale), Population, cellphone_flashhand (phone signal bars), CLEAR_AREA_OF_PEDS / VEHICLES, GET_ZONE_SCUMMINESS (+26 more)

### Community 49 - "Collision, materials and shape tests"
Cohesion: 0.10
Nodes (31): PHY-001: Two unnamed materials.dat columns, Collision, materials and shape tests, GET_GROUND_Z_FOR_3D_COORD, GET_SHAPE_TEST_RESULT, GLASS_BULLETPROOF, HAS_COLLISION_LOADED_AROUND_ENTITY, hi@ and ma@ collision sets, Material groups (FILTER) (+23 more)

### Community 50 - "The job lobby"
Cohesion: 0.11
Nodes (34): fmmc_launcher, appMPJobListNEW, The job lobby (fmmc_launcher), The corona (lobby screens), Corona settings path (GPBD_FM_2 to Global_2685150.f_669), The 11 top-level launcher states, FM_Impromptu_DM_Controler, FM_Maintain_Transition_Players (+26 more)

### Community 51 - "Server-backed Online screens: The ONLINE tab, 22 entries"
Cohesion: 0.09
Nodes (33): Server-backed Online screens (R8.5), appinternet (in-game websites), Busy spinners and warning screens, NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, Credits & Legal tunable Global_262145.f_9321, Engine-filled network pages (friends, crews, party, store, invites), Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED), Jobs and Playlists UGC lists (+25 more)

### Community 52 - "The global variable map: FMMC globals"
Cohesion: 0.06
Nodes (33): The global variable map, Blocks 13 and 15 (dead code), Global_102429 (replay controller state), Global_102481 (shop data), Global_1583765 (personal vehicles), Global_1679103 (mission HUD timers), Global_21610 (phone state), Global_22983 (dialogue request) (+25 more)

### Community 53 - "Vehicles"
Cohesion: 0.09
Nodes (32): Vehicle groups, Vehicles, 921 vehicle models, Add-on vehicle pack, carcols, carvariations, CREATE_VEHICLE, dlc_patch vehicles.meta copies (+24 more)

### Community 54 - "Flying"
Cohesion: 0.11
Nodes (34): Flying, bj (base jumps), CFlyingHandlingData, CONTROL_LANDING_GEAR / GET_LANDING_GEAR_STATE, CTaskParachute tunables (movementtasks.ymt), DLC aircraft flying blocks (63 entries), Flight school lessons MGFS_0 to 11, GET_PED_PARACHUTE_STATE (+26 more)

### Community 55 - "Organisations and businesses"
Cohesion: 0.12
Nodes (34): gb_* and fm_content_* business scripts, am_pi_menu (interaction menu), Organisations and businesses, am_launcher event-type table, am_pi_menu, Biker businesses and bunker production, Boss registration (free, gb_become_boss_threshold), Business Battles (+26 more)

### Community 56 - "Water and buoyancy"
Cohesion: 0.10
Nodes (34): Water and buoyancy, ADD_EXTRA_CALMING_QUAD, Buoyancy by sampling water height, Calming quads (542), fDampening, Whole-map flood via water.xml, fPercentSubmerged, IS_ENTITY_IN_WATER / GET_ENTITY_SUBMERGED_LEVEL (+26 more)

### Community 57 - "Perception and events"
Cohesion: 0.09
Nodes (33): Perception and events, ADD_SHOCKING_EVENT_AT_POSITION, ADD_SHOCKING_EVENT_FOR_ENTITY, AddPedGenBlockedArea, CanCallPolice, CEventAgitated, CEventCrimeCryForHelp, CEventGunShot (+25 more)

### Community 58 - "Relationships and groups"
Cohesion: 0.11
Nodes (31): Relationships and groups, ADD_RELATIONSHIP_GROUP, AMBIENT_GANG_* groups (9), CIVMALE / CIVFEMALE groups, COP relationship group, Follower limit (7 besides leader), franklin1, GUARD_DOG group (+23 more)

### Community 59 - "Online cosmetics and the shops that sell / Open questions"
Cohesion: 0.11
Nodes (33): GET_TATTOO_SHOP_DLC_ITEM_DATA, shop_tattoo.meta, 32 eye colours, Online cosmetics and the shops that sell them, Barber rank locks, Base wardrobe price tables, CLO_MNU block / CSHOP_TITLE labels, clothes_shop_mp (+25 more)

### Community 60 - "GTA Online / Open questions"
Cohesion: 0.07
Nodes (33): GTA Online (folder README), R15.1 Sessions and sync (topic row), R15.2 Rockstar services (topic row), R7.1 freemode inside (topic row), R7.10 Interaction menu, phone and apps (topic row), R7.11 Rockstar Creator internals (topic row), R7.2 Transitions and sessions (topic row), R7.3 Stats, tunables and the server (topic row) (+25 more)

### Community 61 - "Open questions: AI open questions"
Cohesion: 0.10
Nodes (33): AI-010: Names of the common combat attributes (50, 17, 53, 52, 46) and config..., AI-011: Decode pedpersonality.ymt (binary PSO): personalities, bravery..., AI-012: Cover: how cover points are found and scored, TASK_SEEK_COVER_, AI-014: The full meaning of taskdata.meta and scriptedguntasks.meta, AI-015: Whether the modded events.meta really drops gunfight reactions, in..., AI-016: Decode pedpersonality.ymt (binary PSO; not decoded in the first pass), AI-017: The names of the 5 unnamed civilian bravery types and the criminality..., AI-018: What IsWeird changes for Trevor (+25 more)

### Community 62 - "Weapons: AmmoMax six ammo caps"
Cohesion: 0.09
Nodes (32): WeaponLimitsAdjuster, Weapons (folder README), R2.5 Fire, explosions and projectiles (topic row), R3.1 Weapons (topic row), Weapons, Aim assist and lock-on (R3.2), AmmoMax six ammo caps, CAimingInfo (+24 more)

### Community 63 - "Appearance and clothing"
Cohesion: 0.10
Nodes (31): Appearance and clothing, ADD_PED_DECORATION_FROM_HASHES, clothes_shop_mp, Component slots, CPedVariationInfo component .ymt, FINALIZE_HEAD_BLEND, forcedComponents, GET_SHOP_PED_COMPONENT (+23 more)

### Community 64 - "Inside freemode"
Cohesion: 0.12
Nodes (28): Inside freemode, am_mp_island (Cayo Perico), am_pi_menu (interaction menu), DLC story flow functions (CH_FLOW_, HIF_ ...), Network event 174 (script events carrier), FMMC_Launcher (job lobby), freemode script, freemode_clearGlobals (+20 more)

### Community 65 - "Random events"
Cohesion: 0.09
Nodes (31): ambient.ipl, Random events, code_controller, Cut random events without scripts, Global_114904 random event save, lesterhandler, Open question: world brain activation range, photographymonkey (+23 more)

### Community 66 - "Glossary"
Cohesion: 0.09
Nodes (30): Natives (script-to-engine interface), Verified / Known claim marking, Glossary, ASI plug-in, Broadcast data, Decision maker, DLC pack, Global / global block (+22 more)

### Community 67 - "Native usage index"
Cohesion: 0.20
Nodes (31): Native usage index, Game build 3725, Decompile commit 6c18d3e8b, Decompiler names differing from NativeDB, Per-namespace native usage index, tools/native-usage.ps1 generator, NativeDB reference, Scripts with most natives (fm_mission_controller_2020 3166) (+23 more)

### Community 68 - "Open questions / PC session plan: Data rows never attempted"
Cohesion: 0.10
Nodes (30): PHY-013: What each statMods modifier changes, Data rows never attempted (26 rows), Ped physics and ragdoll questions (R2.3), Collision, materials and shape tests questions (R2.1), Vehicle physics questions (R2.2), ENT-017: Which tuning set is chosen for which weapon and vehicle, and the 3..., ENT-018: Fall damage by height, ENT-019: What nm_blend_out_sets.meta sets for getting up (+22 more)

### Community 69 - "Rendering, visual settings and LOD"
Cohesion: 0.12
Nodes (28): REN-017: Changed visualsettings.dat keys, Rendering, visual settings and LOD, Adrian Courreges GTA V graphics study, CASCADE_SHADOWS_INIT_SESSION, CASCADE_SHADOWS_SET_CASCADE_BOUNDS, Cascaded shadow maps, Distant lights, Extended distance scaling (+20 more)

### Community 70 - "Graphics settings, one by one"
Cohesion: 0.09
Nodes (28): CityDensity setting, Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Open questions (graphics), Biggest GPU/CPU/memory costs, settings.xml (version 27) keys (+20 more)

### Community 71 - "Character switching"
Cohesion: 0.11
Nodes (26): Character switching, CHANGE_PLAYER_PED, family_scene_* scripts, GET_IDEAL_PLAYER_SWITCH_TYPE, GET_PLAYER_SWITCH_STATE, IS_PLAYER_SWITCH_IN_PROGRESS, IS_SAFE_TO_START_PLAYER_SWITCH, MainTransition (Online slot) (+18 more)

### Community 72 - "Heists in GTA Online / Open questions"
Cohesion: 0.13
Nodes (28): Heists in GTA Online, Casino crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo secondary loot value rolls, ch_lester_cut (5%), Classic heists (Fleeca to Pacific Standard), Classic apartment planning board (heist_mp, heistmap_mp, heist_pre), Heist cut rules (55% leader, 15% min, 70% max) (+20 more)

### Community 73 - "1. How mods work"
Cohesion: 0.11
Nodes (26): handling.meta, CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, Data mods vs script mods, Per-frame script loop, 2. The tools you need, OpenIV (+18 more)

### Community 74 - "VEHICLE natives used by the game scripts"
Cohesion: 0.14
Nodes (30): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, _GET_VEHICLE_TRAILER_PARENT_VEHICLE (+22 more)

### Community 75 - "NETWORK natives used by the game scripts"
Cohesion: 0.16
Nodes (29): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+21 more)

### Community 76 - "PED natives used by the game scripts"
Cohesion: 0.15
Nodes (29): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+21 more)

### Community 77 - "Swimming and diving"
Cohesion: 0.11
Nodes (26): GP-073: Non-story PlayerStatInfos entries, Swimming and diving, CTaskMotionSwimming tunables, Dive height (MinDiveHeight / MaxDiveHeight), GET_ENTITY_SUBMERGED_LEVEL, GET_PLAYER_UNDERWATER_TIME_REMAINING, HighFallWaterDepthMin / Max, Hold breath duration (MinHoldBreathDuration 10 / Max 40) (+18 more)

### Community 78 - "Story systems that clash with an Online  / Open questions"
Cohesion: 0.10
Nodes (27): R5.7 Systems that clash with Online mode (topic row), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems) (+19 more)

### Community 79 - "Particles and decals"
Cohesion: 0.13
Nodes (27): materialfx.dat, Particles and decals, ADD_DECAL, bloodfx.dat, core particle dictionary, decals.dat, entityfx.dat, MTLFX_TABLE (+19 more)

### Community 80 - "Map data"
Cohesion: 0.12
Nodes (24): Timecycle modifier boxes, Map data, Box occluders, Car generators, controller_ambientarea, cs1_12.ymap, HDTxdAssetBindings, HoursOnOff (+16 more)

### Community 81 - "Setup"
Cohesion: 0.08
Nodes (26): Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads (+18 more)

### Community 82 - "Ambient life: Ambient ped task loop"
Cohesion: 0.16
Nodes (27): Ambient life, Ambient ped task loop (Known), Animals: 41 ped models of type animal, CAmbientLookAt (scan 15 m, look 2 s), TASK_CHAT_TO_PED callers: taxi_gotyounow, taxi_clowncar, nigel2, franklin0, re_stag_do, CTaskAmbientClips (idle every 4 s, 40 s after gunshot), CTaskBirdLocomotion, CTaskChat (face within 5°, wait 30 s) (+19 more)

### Community 83 - "TASK natives used by the game scripts"
Cohesion: 0.17
Nodes (27): VEHICLE_WAYPOINT_PLAYBACK_OVERRIDE_SPEED, TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS (+19 more)

### Community 84 - "Speech and dialogue"
Cohesion: 0.13
Nodes (27): Speech and dialogue, Ambient voice name pattern (<model>_<ethnicity>_<full|mini>_<n>), .awc speech containers, Dialogue block to mission mapping (AUD suffix), BOUNCER_EJECT_GENERIC, comms_controller, dialogue_handler, DISABLE_PED_PAIN_AUDIO (+19 more)

### Community 85 - "05 Native functions"
Cohesion: 0.09
Nodes (24): R12.4 Languages for modding, 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, SHVDN namespaces (GTA, GTA.UI, GTA.Native, GTA.Input...), Languages for modding GTA V, ActionScript 2 for Scaleform UI (+16 more)

### Community 86 - "PLAYER natives used by the game scripts"
Cohesion: 0.17
Nodes (27): PLAYER natives used by the game scripts, GET_PLAYER_NAME, GET_PLAYER_PED, GET_PLAYER_TEAM, GET_PLAYER_WANTED_LEVEL, INT_TO_PLAYERINDEX, IS_PLAYER_CONTROL_ON, IS_PLAYER_PLAYING (+19 more)

### Community 87 - "STATS natives used by the game scripts"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 88 - "Data needs: Data batch D8"
Cohesion: 0.14
Nodes (26): AI-027: Road nodes, routes and counts, AI-028: Navmesh polygons, links, cover points per tile, AI-029: Road nodes, routes and counts, Data batch D8: map data, ENT-001: Archetype flag bits across all .ytyp, ENT-002: Fragment map props and how many break, ENT-003: Rayfire objects placed in the map, ENT-030: Car generator flag bits and unresolved population groups (+18 more)

### Community 89 - "The AI architecture"
Cohesion: 0.10
Nodes (24): The AI architecture, AI layers: perception, events, decisions, relationships, tasks, navigation, motion, LOD, Events interrupt tasks via decision maker; blocked by SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks (+16 more)

### Community 90 - "Decisions and personalities"
Cohesion: 0.14
Nodes (26): Agitation system (agitatedtriggers/responses/personalities.meta), pedpersonality.ymt (not decoded in this pass), Decisions and personalities, Agitated personality (default / Confront / none), ArmourEfficiency / HealthRegenEfficiency / StaminaEfficiency, BF_COWARDLY_FOR_SHOCKING_EVENTS, 18 bravery types, Criminality types (+18 more)

### Community 91 - "Open questions / PC session plan: Part 2"
Cohesion: 0.12
Nodes (26): Remaining executable (read-only RE) questions, AI-013: How aim assist and lock-on work for the player, CORE-017: Meaning of force-cleanup bits 8, 16, 32, 64 and 128, CORE-018: What exactly the engine does to start main, initial and startup, and..., CORE-019: What profiler_registration (global block 2) is and whether anything..., CORE-020: The story flags that pick the active mission triggerer, CORE-032: What the engine raises force-cleanup bits 16 and 32 for (no script..., CORE-033: What the values of the current mission type (Global_44869 in build... (+18 more)

### Community 92 - "Tools / PC session plan"
Cohesion: 0.10
Nodes (26): Remaining in-game test questions, Back up the story save, Before you start (PC session rules), dlc-scan.ps1, Frame-time capture, Part 3: in-game test session (story mode), Record ID, action, result, build and mods for every test, Results stay in a scratch folder outside the repo (+18 more)

### Community 93 - "CLAUDE.md"
Cohesion: 0.12
Nodes (24): CLAUDE.md: assistant instructions, GTA V PC Legacy build 1.0.3725.0, common.rpf (base data), Count things rule, Decompile commit 'Update for 1.72-3725.0', Decompiled scripts (community decompile), Decompiler names (func_/Global_/Local_), file-rules check (+16 more)

### Community 94 - "Open questions: Questions by category"
Cohesion: 0.11
Nodes (25): Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass), Handoff: current status and what to do next, What needs game files: cloud session vs maintainer PC, Decompile commit 6c18d3e8 ("Update for 1.72-3725.0"), native_tables/ folder (native hashes per script and build), Second pass: answering OPEN_QUESTIONS rows, Open questions: the second pass (+17 more)

### Community 95 - "Driving AI"
Cohesion: 0.13
Nodes (24): Driving AI: missions, chases, aircraft and boats, Flee mission (8), fm_content_* scripts, Roadmap R17.6 driving AI, SET_BOAT_ANCHOR, SET_DRIVER_RACING_MODIFIER, SET_HELI_BLADES_FULL_SPEED, TASK_BOAT_MISSION (+16 more)

### Community 96 - "Peds"
Cohesion: 0.12
Nodes (24): Peds, 1,109 ped models, AbilityType special abilities, CombatInfo, CPedModelInfo InitData, CREATE_PED, DecisionMakerName, GET_PED_TYPE (+16 more)

### Community 97 - "Replay, director mode and the Rockstar E"
Cohesion: 0.14
Nodes (24): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder (Rockstar Editor), Director mode quick-travel locations (27), director_mode, GP-087 Replay type meaning in the engine, maintransition, mission_repeat_controller (+16 more)

### Community 98 - "Streaming"
Cohesion: 0.11
Nodes (22): Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), ON_ENTER_MP / ON_ENTER_SP map switch, Open question: TextureQuality mapping and memory use, Pop-in and streaming hitches, Population and model budgets (+14 more)

### Community 99 - "Transitions and sessions / Open questions"
Cohesion: 0.17
Nodes (24): Transitions and sessions (R7.2), freemode_clearGlobals (31 reset steps), ingamehud connection-problem warnings, maintransition (transition state machine script), NETWORK_IS_GAME_IN_PROGRESS (905 scripts), NETWORK_REQUEST_CLOUD_TUNABLES, Offline-mode branch (unreachable in build 3725), Online privilege checks (NETWORK_HAVE_ONLINE_PRIVILEGES ...) (+16 more)

### Community 100 - "CAMERA natives used by the game scripts"
Cohesion: 0.08
Nodes (24): AUDIO natives used by the game scripts, GET_SOUND_ID, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CAMERA natives used by the game scripts, CREATE_CAM (+16 more)

### Community 101 - "Server-backed Online screens: Server calls per screen table"
Cohesion: 0.09
Nodes (23): Global_2097536 (leaderboard rows), am_contact_requests, am_pi_menu (interaction menu), appbusinesshub (business computer), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780 (+15 more)

### Community 102 - "Text and names in content"
Cohesion: 0.14
Nodes (23): Text and names in content, dlctext.meta (TEXTFILE_METAFILE), gameName (vehicles.meta), GET_LIVERY_NAME, GET_MAKE_NAME_FROM_VEHICLE_MODEL, GET_MOD_TEXT_LABEL, HumanNameHash (weapons.meta), Jenkins one-at-a-time label hashing (+15 more)

### Community 103 - "Respawn, death and arrest / Open questions"
Cohesion: 0.18
Nodes (23): PP_INFO_STRUCT (per-character save), Respawn, death and arrest (R6.2), Arrest penalty: up to $300 and weapons cleared, Death fee: 5% of cash, max $5,000, exile_city_denial, 5 hospital restart points (ADD_HOSPITAL_RESTART), mission_repeat_controller, Online respawn (NETWORK_START_RESPAWN_SEARCH, NETWORK_RESURRECT_LOCAL_PLAYER) (+15 more)

### Community 104 - "Tools and resources"
Cohesion: 0.14
Nodes (22): Tools and resources, alloc8or's gta5-nativedb-data, Call-graph labeller (awk script), Claude Code, Claude Code skills (game-recon, reverse-engineering ...), CodeWalker (CodeWalker.Core.dll), CodeWalker.Core MetaXml/YmapFile/RpfFile from PowerShell, GTA-V-Decompiled-Scripts community decompile (+14 more)

### Community 105 - "Navigation and pathfinding"
Cohesion: 0.17
Nodes (22): Navigation and pathfinding, ADD_COVER_POINT, ADD_NAVMESH_REQUIRED_REGION, GET_NAVMESH_ROUTE_RESULT, GET_NUM_NAVMESHES_EXISTING_IN_AREA, GET_SAFE_COORD_FOR_PED, IS_NAVMESH_LOADED_IN_AREA, Navmesh counts (6.39M polygons, 521,586 cover points) (+14 more)

### Community 106 - "Missions"
Cohesion: 0.10
Nodes (22): Missions, R0.1, R5.1, R5.2, R5.4, R5.5, R5.6, R5.8 (+14 more)

### Community 107 - "Driving and AI driving"
Cohesion: 0.16
Nodes (21): Driving and AI driving, AIHandling field in handling.meta, Corner speed curve, CTaskPlayerDrive, Driving style flags, Four AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), SET_DRIVE_TASK_CRUISE_SPEED, SPORTS_CAR profile (+13 more)

### Community 108 - "Vehicle physics: CHandlingData"
Cohesion: 0.14
Nodes (21): Change weapons through add-on data and merge, Vehicle physics: handling, damage and upgrades, AIHandling field, carcols.meta statMods (mod-kit upgrades), CHandlingData, Damage multipliers, Handling flag words (model, handling, damage, advanced), Handling memory access (SHVDN Vehicle.HandlingData) (+13 more)

### Community 109 - "Handoff: Status"
Cohesion: 0.10
Nodes (21): Call a question answered only if it really is, Check numbers against raw output; write "our reading", Refresh graph once per phase, not on data branches, Knowledge graph current as of PR #132 (4,716 nodes, 10,010 edges), graphifyy (pip package), Leftovers pass (research/pass2-leftovers), Files are LF in git; keep existing endings, Re-run the link check after each phase (+13 more)

### Community 110 - "Cookbook: Pattern 110"
Cohesion: 0.10
Nodes (15): Cookbook: audio, .awc containers plus .dat*.rel config, Pattern: looping alarm, PLAY_SOUND_FRONTEND / GET_SOUND_ID / START_AUDIO_SCENE natives, Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu, Cookbook: shops (+7 more)

### Community 111 - "Natives as the engine API"
Cohesion: 0.13
Nodes (20): SCR-008: Measured cost of the heavy natives (synchronous shape test..., SCR-009: Which natives crash on a stale handle and which fail quietly, SCR-010: The size limits of the nearby-entity arrays, Natives as the engine API questions (R1.3), Block B: Boot, scripts and natives, R1.3 Natives as the engine API, Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED) (+12 more)

### Community 112 - "Health, armour, death and arrest / Open questions"
Cohesion: 0.16
Nodes (20): Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS, IS_PED_INJURED (903 scripts) (+12 more)

### Community 113 - "07 Legacy / 03 Menus and UI"
Cohesion: 0.11
Nodes (20): LemonUI, Steps 5/6/7 are alternatives (C#, Lua, C++), ScriptHookVDotNet v3 (SHVDN 3.7.0.189), Language-for-job table (XML, C#, Lua, C++, natives, JSON...), 07 Legacy: SHVDN v2 and NativeUI, NativeUI 1.9.0, NativeUI to LemonUI mapping, Porting v2 mod to v3 (+12 more)

### Community 114 - "Archives and the content system"
Cohesion: 0.17
Nodes (17): Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins), RPF archives (+9 more)

### Community 115 - "Saves"
Cohesion: 0.16
Nodes (17): Saves: the story save (R1.7), FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values), Keep mod data in its own file, Save upgrade function in startup, Save version fSaveVersion (1.7), standard_global_reg (+9 more)

### Community 116 - "The Online character creator"
Cohesion: 0.16
Nodes (19): The Online character creator, Starter outfits and crew T-shirt, Appearance change fee and cooldown, CHAR_CREATOR_PORTRAITS, FEATURE_0 to FEATURE_20 stats, FINALIZE_HEAD_BLEND / HAS_PED_HEAD_BLEND_FINISHED, HEADBLEND_* and MESH_* stats, Heritage head blend (Mom/Dad) (+11 more)

### Community 117 - "7. Your first C++"
Cohesion: 0.18
Nodes (19): 7. Your first C++ (.asi) mod, ASI loader, ASI plugin (64-bit DLL), asiloader.log / ScriptHookV.log, DllMain (register only), DOES_ENTITY_EXIST check, getGlobalPtr, Keyboard handler (keyboardHandlerRegister) (+11 more)

### Community 118 - "Data needs: vehicles.meta"
Cohesion: 0.16
Nodes (18): Data batch D1: American text blocks and vehicle data files, Data batch D12: remaining text questions, ENT-005: The 13 vehicle maker labels with no text, ENT-006: Mod-part and livery label naming, ENT-036: 901 vs 879 vehicle models, ENT-037: Less common vehicle flags, GP-046: SPMED and SPSMALL handling entries, GP-047: Flight school lesson names (+10 more)

### Community 119 - "System requirements outside the game fol"
Cohesion: 0.16
Nodes (18): check-system.ps1: PC requirement check, System requirements outside the game folder, D3DCompiler 47, DirectX 11 graphics driver, DirectX End-User Runtime (June 2010), Import tables via dumpbin /dependents, LUA.asi, Media Feature Pack (N editions) (+10 more)

### Community 120 - "Player skills and abilities"
Cohesion: 0.21
Nodes (17): 100 stat points across seven skills, Player skills and abilities (R3.6), Open question GP-092: ability entries 8-16, peds.ymt AbilityType per model, playerinfo.ymt PlayerStatInfos ranges, playerspecialabilities.ymt (17 entries), Seven character skills (0-100, SP0_/SP1_/SP2_ stats), Skill growth formula (start + bonus + activity score) (+9 more)

### Community 121 - "06 The Lua plugin"
Cohesion: 0.13
Nodes (13): Verify install via asiloader/ScriptHookV/SHVDN logs, 6. Your first Lua script, Lua Plugin for Script Hook V (Lua 5.2), 2015 native names (UI, GAMEPLAY), Attach debugger to GTA5.exe, 8. Debugging: when nothing happens, Order of logs to read, Symptom-cause-fix table (+5 more)

### Community 122 - "Open questions / PC session plan: Batch D10"
Cohesion: 0.14
Nodes (17): Batch D10: entityfx.dat, materialfx.dat, wheelfx.dat, every .ypt..., Particles and decals questions (R13.3), REN-012: The exact decal limit in build 3725 and what limit patches change, REN-013: How the particle quality setting picks between ptfx, ptfx_hi and..., REN-014: The format of entityfx.dat, materialfx.dat and wheelfx.dat row by row, REN-015: Which DLC dictionaries are mounted in story mode, REN-016: Which effect names each dictionary holds (an index), REN-022: What userFlags 1, 2, 4, 8 and 16 do (+9 more)

### Community 123 - "Open questions / PC session plan: Data group"
Cohesion: 0.16
Nodes (17): Batch D11: clip_sets.ymt and the DLC clip_sets.xml files..., Animation questions (R13.4), GP-027: The 10 post effects startup registers for the editor, REN-001: The names behind the 22 memory groups and their budget unit, REN-002: Which clip sets the hashed entries are (resolving the 4,526 keys from..., REN-003: Exactly what each TASK_PLAY_ANIM flag bit does (262144 and 16777216..., REN-004: The clip archive layout in DLC packs and how many dictionaries each..., REN-005: The 12 expression dictionaries the update replaced and why (+9 more)

### Community 124 - "Open questions / PC session plan: The Online character creator questions"
Cohesion: 0.15
Nodes (17): Batch D6: The 164 freemode shop catalogue files, 22 DLC..., The Online character creator questions (R6.5), ENT-010: The overlay index list (0 to 12) and micro-morph list (0 to 19)..., ENT-015: The component .ymt format (slots, drawables, restrictions), GP-054: How many normal and special parent heads each list has, and which..., GP-055: The two unlabelled morph-19 entries and the last column of the..., GP-056: How the slider values (0 to 100, -1 to 1) are scaled into the saved..., GP-057: The outfit group names (BEA, CAS ...) and the components of each... (+9 more)

### Community 125 - "Vehicle physics: Sub-handling blocks"
Cohesion: 0.14
Nodes (16): CVehicleWeaponInfo, CAdvancedData, CBikeHandlingData, CBoatHandlingData, CCarHandlingData, CFlyingHandlingData, CSeaPlaneHandlingData, CSpecialFlightHandlingData (+8 more)

### Community 126 - "Open questions / PC session plan: Partial data results and what would fini"
Cohesion: 0.20
Nodes (16): Partial data results and what would finish them, speech2.dat4.rel voice context byte arrays, AUD-004: Speech archives and voices, AUD-005: The 10 base and many DLC station objects whose names didn't resolve, AUD-006: How a music event maps to moods and tracks, step by step, AUD-007: Which DLC stations are available in story mode in build 3725, AUD-008: The format of a radio track's data (length, markers for the DJ), AUD-009: The list of contexts each voice has, from speech2.dat4.rel (+8 more)

### Community 127 - "Open questions / PC session plan: Weapons questions"
Cohesion: 0.15
Nodes (16): Batch D2: explosion.ymt (update), all 19 explosion.meta (16..., Weapons questions (R3.1), Fire, explosions and projectiles questions (R2.5), GP-077: The hatchet's extra condition, and whether the Gusenberg really waits..., GP-078: How story stats and Online rank change AmmoMax, GP-079: Explosion damage and radius per explosive (explosion.meta), PHY-006: The exact falloff curve between centre and edge, and how armour takes..., PHY-007: How far and how fast fire spreads, and its limits (number of fires at... (+8 more)

### Community 128 - "DATAFILE natives used by the game script / HUD natives used by the game scripts"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 129 - "Data needs: Data batch D10"
Cohesion: 0.23
Nodes (15): Animpostfx post-effect metadata, Data batch D10: effects and timecycle files, entityfx.dat, materialfx.dat, wheelfx.dat, GP-027: Editor post effects, unnamed post effects, GroupId and EventType, REN-014: entityfx, materialfx and wheelfx rows, REN-015: DLC particle dictionaries in story mode, REN-016: Effect names per particle dictionary, REN-021: Timecycle modifier values and userFlags (+7 more)

### Community 130 - "Streaming, memory and video memory"
Cohesion: 0.16
Nodes (15): Cost order on low-end laptop: memory, CPU, GPU, heat, Streaming, memory and video memory, HeapAdjuster (478 to 1,950 MB), Three memory budgets: heap, streaming, VRAM, Memory over a session (private 9.1 GB), Open questions (memory), Paging causes freezes with many mods, gameconfig.xml streaming buffers and ArchiveCount (+7 more)

### Community 131 - "Windows and drivers / Open questions"
Cohesion: 0.17
Nodes (15): Windows and drivers, Background programs as biggest Windows-side cost, Game Bar background recording off, Integrated vs dedicated graphics, Page file and 20 GB free rule, Power plan, power mode and processor max state, Pre-play checklist for a low-end laptop, Windows and drivers questions (R18.6) (+7 more)

### Community 132 - "Open questions: Block D"
Cohesion: 0.24
Nodes (15): Swimming and diving questions (R3.5), GP-039: The meaning of switch flag bits 1, 2, 4, 8, GP-043: How SET_INPUT_EXCLUSIVE and DISABLE_CONTROL_ACTION interact when two..., GP-064: Whether the engine picks the nearest enabled point or uses other..., GP-068: What shooting, strength and stealth change, in numbers, GP-071: The exact curve from the lung capacity stat to seconds of breath..., GP-072: How fast drowning drains health, GP-073: What the 5 non-story entries in PlayerStatInfos are (their names... (+7 more)

### Community 133 - "Research tools"
Cohesion: 0.15
Nodes (13): Getting started, Research tools, After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), script-launch-graph.ps1: launches via git grep, Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts (+5 more)

### Community 134 - "Handoff: Part 1"
Cohesion: 0.18
Nodes (13): CodeWalker, Workflow: pricing shop items from tuneables_processing, CodeWalker library from PowerShell (data batches), Scan for control characters before committing, Flow commands identified by builder hash, Dump all American .gxt2 text once, joaat name hashing (check: weapon_pistol = 453432689), One copy per file name wins: update over DLC over base (+5 more)

### Community 135 - "Ped physics and ragdoll"
Cohesion: 0.15
Nodes (12): Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file, Ragdoll blocking flags and masks, CTaskNM ragdoll tasks, Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta (+4 more)

### Community 136 - "GTA V Under the Hood"
Cohesion: 0.22
Nodes (10): ScriptHookVDotNet, GTA V Under the Hood: how Grand Theft Auto V works underneath, C++ (ScriptHookV), First pass: all 109 research topics, freemode: 1.47-million-line main Online script, Lua, 1,013 scripts call 6,575 natives (12.3 million calls), PowerShell and bash (+2 more)

### Community 137 - "Open questions: Batch P4.2"
Cohesion: 0.27
Nodes (13): Anatomy of a story mission questions (R5.2), Replay, director mode and the Rockstar Editor questions (R5.8), GP-016: Where armenian1, jewelry_heist and trevor1 set the skip flag..., GP-017: The exact meaning of replay_controller states 1 to 6 and 11 to 13, GP-019: How crew skill changes the heist take and the fail labels in..., GP-021: What the mission triggerers build before a mission starts (lead-in..., GP-022: Where armenian1, jewelry_heist and trevor1 unlock their skip (they..., GP-024: The meaning of replay_controller states 1 to 6 and 11 to 13 (+5 more)

### Community 138 - "Reading the decompiled game scripts"
Cohesion: 0.17
Nodes (12): Game version (Legacy 1.0.3725.0), Reading the decompiled game scripts, Community decompile repository (one commit per build), freemode started by maintransition with stack 35,250; creator 28,000, Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts), Property table in am_mp_property_ext (index to entrance coordinates), Good scripts to read next (+4 more)

### Community 139 - "Open questions / PC session plan: Time, weather and wind questions"
Cohesion: 0.20
Nodes (12): Time, weather and wind questions (R2.6), WLD-013: How long one TimeMult unit lasts, and whether the cycle position is..., WLD-014: Whether wind changes the flight of aircraft, the drift of boats, or..., WLD-015: What the global flag that skips the post-death weather reroll is, and..., WLD-016: How SET_OVERRIDE_WEATHER and the persistent lock interact when both..., WLD-018: The base length of one weather TimeMult unit (not in the file), WLD-019: Whether wind pushes aircraft or boats, WLD-013: How long one TimeMult unit lasts, and whether the cycle... (+4 more)

### Community 140 - "ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 141 - "Data needs: tools/rpf-cw.ps1"
Cohesion: 0.22
Nodes (11): AI-034: Crime-info entries and crime points, AI-035: Crime-info entries and crime points, AI-036: Police vehicle sets with model names, Data batch D3: water files, Data batch D4: police and population files, ENT-021: Story schedule hashes not in popcycle.dat, PHY-015: The five water quad types, PHY-016: Format of waterheight.dat (+3 more)

### Community 142 - "EXTRAMETADATA natives used by the game s"
Cohesion: 0.18
Nodes (11): DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, restrictionTags, SETUP_SHOP_PED_APPAREL_QUERY_TU, IS_CONTENT_ITEM_LOCKED, EXTRAMETADATA namespace, Roadmap topic R6.3, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG (+3 more)

### Community 143 - "WEAPON natives used by the game scripts"
Cohesion: 0.18
Nodes (11): SET_VEHICLE_DAMAGE_SCALE, WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON (+3 more)

### Community 144 - "Open questions: Batch D8"
Cohesion: 0.25
Nodes (11): Batch D8: Every .ymap, .ytyp, .ymf, .ynd, .ynv and scenario..., Props, archetypes and doors questions (R14.3), Map data questions (R4.6), ENT-001: Archetype flag bits counted across all .ytyp files, ENT-002: Which map props are fragments (.yft) and how many break, ENT-003: Every rayfire object placed in the map, not only those named in..., WLD-004: The exact meaning of the ymap flags values 1, 2, 3, WLD-005: How many entities the story-mode map loads (only ymaps active outside... (+3 more)

### Community 145 - "Data needs: Data batch D9"
Cohesion: 0.31
Nodes (10): AUD-004: Speech archives, voices and contexts, AUD-006: Music event to mood to track, AUD-008: Radio track data, AUD-009: Speech archives, voices and contexts, AUD-010: Dialogue block per mission, .awc audio archives, Data batch D9: audio files, Music .rel files (+2 more)

### Community 146 - "Data needs: common.rpf"
Cohesion: 0.29
Nodes (10): Data batch D2: explosion and weapon files, common.rpf (base archive), explosion.meta, GP-078: Ammo cap vs story stats and Online rank, GP-079: Damage and radius per explosion type, PHY-008: Unnamed explosion boolean fields, PHY-009: Damage and radius per explosion type, PHY-010: Every DLC projectile and its explosion (+2 more)

### Community 147 - "PATH natives used by the game scripts / Navigation and pathfinding"
Cohesion: 0.22
Nodes (10): TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE, LOAD_ALL_PATH_NODES, Path nodes (.ynd, 274 in update), Road node counts (79,788 nodes, 3,129 junctions), SET_ROADS_IN_AREA / SET_ROADS_BACK_TO_ORIGINAL, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace (+2 more)

### Community 148 - "The global variable map: Player broadcast data"
Cohesion: 0.22
Nodes (9): GlobalplayerBD .f_204 / .f_203 flag words, GPBD_FM .f_260 (stat-backed state), GlobalplayerBD .f_325 (interior the player is in), Global_1845250 GPBD_FM, Global_1892653 GPBD_FM_3, Global_1950198 (local simple-interior state), Global_2658291 GlobalplayerBD, NETWORK_REGISTER_PLAYER_BROADCAST_VARIABLES (+1 more)

### Community 149 - "9. Next steps and sharing your mod / RPF archives"
Cohesion: 0.20
Nodes (8): materials.dat and related material files, Collision material table (213 materials), File formats, RPF archives, RPF archive format v7, 9. Next steps and sharing your mod, Where to publish mods, Mod readme required sections

### Community 150 - "Ambient life: Mission set-piece pattern"
Cohesion: 0.22
Nodes (7): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, CLEAR_AREA_OF_PEDS (456 scripts), SET_PED_DENSITY_MULTIPLIER_THIS_FRAME (158 scripts), SET_PED_MODEL_IS_SUPPRESSED (74 scripts), SET_SCENARIO_TYPE_ENABLED (52 scripts), TASK_WANDER_STANDARD / _IN_AREA / _SPECIFIC, Test card: density multiplier 0 every tick

### Community 151 - "CLOCK natives used by the game scripts / Time, weather and wind"
Cohesion: 0.25
Nodes (9): ADD_TO_CLOCK_TIME, Game clock, GET_MILLISECONDS_PER_GAME_MINUTE, savegame_bed, CLOCK natives used by the game scripts, GET_CLOCK_HOURS, GET_POSIX_TIME, CLOCK native namespace: CLOCK natives: in-game and real time (+1 more)

### Community 152 - "DLC natives used by the game scripts / LOBBY natives used by the game scripts"
Cohesion: 0.22
Nodes (9): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, LOBBY natives used by the game scripts, LOBBY_AUTO_MULTIPLAYER_FREEMODE, LOBBY_SET_AUTO_MULTIPLAYER (+1 more)

### Community 153 - "Data needs: Data batch D11"
Cohesion: 0.46
Nodes (7): Data batch D11: animation and camera files, REN-001: The 22 animation memory groups, REN-002: The 4,526 hashed clip set keys, REN-004: Clip archive layout in DLC packs, REN-005: The 12 replaced expression dictionaries, .ycd clip dictionaries, REN-006: Animation memory cost per dictionary

### Community 154 - "BUILTIN natives used by the game scripts / BRAIN natives used by the game scripts"
Cohesion: 0.25
Nodes (8): BRAIN natives used by the game scripts, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, TIMESTEP, TO_FLOAT, WAIT

### Community 155 - "FIRE natives used by the game scripts / EVENT natives used by the game scripts"
Cohesion: 0.25
Nodes (8): EVENT natives used by the game scripts, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions, STOP_FIRE_IN_RANGE

### Community 156 - "Data needs: gameconfig.xml"
Cohesion: 0.33
Nodes (6): Data batch D7: gameconfig.xml and archive listings, FF-002: Per-pack breakdown of the 89 DLC packs, FF-003: How update copies override base ones, PERF-025: Raised physics pools on a low-end PC, SCR-014: Duplicated gameconfig.xml pool entry on PC, gameconfig.xml

### Community 157 - "Runtime scripts: Global blocks"
Cohesion: 0.33
Nodes (7): Global blocks (1.5), profiler_registration, Registration scripts (14), standard_global_init, standard_global_reg, startup, startup_positioning

### Community 158 - "Cookbook: Vehicle traps"
Cohesion: 0.29
Nodes (4): Cookbook: world and map, Pattern: placed scene of props, CREATE_OBJECT, CREATE_MODEL_HIDE, REQUEST_IPL, door system natives, ymap/ytyp additions in DLC pack

### Community 159 - "Open questions / PC session plan: Driving and AI driving questions"
Cohesion: 0.29
Nodes (7): AI-024: AI profiles of every DLC vehicle (all handling.meta files), AI-025: How SET_DRIVER_ABILITY and _AGGRESSIVENESS change the curve or braking, AI-027: Road nodes and how routes are planned, Driving and AI driving questions (R3.3), AI-024: The AI handling profile of every DLC vehicle, AI-025: How SET_DRIVER_ABILITY and _AGGRESSIVENESS change the curve..., AI-027: Road nodes, routes; node and link counts, update vs base

### Community 160 - "Open questions: Batch P2.2"
Cohesion: 0.38
Nodes (7): CORE-009: Field layout of the player broadcast data (Global_1845250..., CORE-010: The tunable index list: which Global_262145.f_<n> is which tunable, CORE-011: What the references into blocks 13 and 15 are, CORE-012: Roles of the Known rows above, by reading one use each, The global variable map questions (R0.4), ON-050: The layout of the big broadcast blocks, Batch P2.2: The global map (R0.4)

### Community 161 - "Open questions: Performance open questions"
Cohesion: 0.29
Nodes (7): Measuring performance questions (R18.1), PERF-011: Confirm the benchmark switches and results file, and record a..., PERF-012: What happens in each of the 8 states of the benchmark loop, and how..., PERF-013: Why ON_ENTER_MP blocks for about 9 s: which map data it swaps, Performance open questions, PERF-011: Confirm the benchmark switches and results file, and record..., PERF-013: Which files ON_ENTER_MP switches: the change sets the 43...

### Community 162 - "MISC natives used by the game scripts"
Cohesion: 0.33
Nodes (7): MISC natives used by the game scripts, CLEAR_BIT, IS_PC_VERSION, MISC native namespace: MISC natives: bitwise, random, weather, save registration, platform checks, dispatch, REGISTER_INT_TO_SAVE, SET_BIT, SET_WEATHER_TYPE_OVERTIME_PERSIST

### Community 163 - "Music and radio: Music events"
Cohesion: 0.33
Nodes (5): Mood (stem mixes), PREPARE_MUSIC_EVENT, StartTrackAction, Stem mix (8 stems), TRIGGER_MUSIC_EVENT

### Community 164 - "Weapons: Bullet damage model"
Cohesion: 0.33
Nodes (6): Bullet damage model (instant hit), CWeaponInfo, Damage fall-off, Headshot damage modifier, Penetration, WeaponRange

### Community 165 - "Open questions: Knowledge graph open questions"
Cohesion: 0.60
Nodes (6): Docs housekeeping from the knowledge graph (KG-001 to KG-004), KG-001: Tie in the 722 weakly connected nodes (one link or none; 4 fully..., KG-002: Pick one owner page for each of the 72 facts that two docs describe..., KG-003: Should the loosest clusters be split or given clearer sections?..., KG-004: Should non-doc files be left out of the graph?..., Knowledge graph open questions

### Community 166 - "INTERIOR natives used by the game script"
Cohesion: 0.33
Nodes (6): INTERIOR natives used by the game scripts, DEACTIVATE_INTERIOR_ENTITY_SET, ENABLE_SHADOW_CULL_MODEL_THIS_FRAME, GET_INTERIOR_AT_COORDS_WITH_TYPE, IS_VALID_INTERIOR, INTERIOR native namespace: INTERIOR natives: interior proxies, entity sets, rooms

### Community 167 - "PHYSICS natives used by the game scripts"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 168 - "STREAMING natives used by the game scrip"
Cohesion: 0.40
Nodes (6): HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 169 - "Runtime scripts / Memory, pools and limits"
Cohesion: 0.50
Nodes (5): ConfigScriptStackSizes, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, Script stack pools, START_NEW_SCRIPT

### Community 170 - "Mod-builder's cookbook"
Cohesion: 0.40
Nodes (5): Cookbook (R12.1), Mod ideas list (R12.3), Mod map: 13 mod categories, Beginner modding path (R12.6), Languages for modding (R12.4)

### Community 171 - "Cookbook: Pattern 171"
Cohesion: 0.40
Nodes (5): Cookbook: vehicles and handling, Pattern: add-on car via DLC pack, Driving styles 786603 careful / 786468 rushed, handling.meta, vehicles.meta, carcols.meta, carvariations.meta, Category: vehicle and model add-ons

### Community 172 - "Open questions: Ambient life questions"
Cohesion: 0.40
Nodes (5): AI-007: How far from the player ambient peds despawn, AI-008: How peds pick partners for chats, AI-009: The animal models by kind and where each spawns, Ambient life questions (R17.8), AI-009: Animal models by kind and where each spawns

### Community 173 - "OBJECT natives used by the game scripts"
Cohesion: 0.40
Nodes (5): CREATE_OBJECT, DELETE_OBJECT, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 174 - "RECORDING natives used by the game scrip"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 175 - "SOCIALCLUB natives used by the game scri"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 176 - "Open questions: Ask the contributor or community"
Cohesion: 0.50
Nodes (4): Ask the contributor or community (GP-076, REN-019, ON-053), GP-076: Which mod installed the weapon overhaul (and the other 93 replaced..., ON-053: A tool that writes the tunable name, type and default list for one..., REN-019: What popular lighting and graphics overhauls change in these files

### Community 177 - "REPLAY natives used by the game scripts"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 178 - "SECURITY natives used by the game script"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 179 - "SHAPETEST natives used by the game scrip"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 180 - "AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail"
Cohesion: 0.67
Nodes (3): Open question: distances where ped AI LOD changes, Open question: how far ambient peds despawn, R17.9 AI cost and level of detail

### Community 181 - "Research roadmap / Ambient life"
Cohesion: 0.67
Nodes (3): Open question: animal models by kind and where each spawns, R17.8 Ambient life, R4.2 Scenarios and ambient life

### Community 183 - "The global variable map: Server"
Cohesion: 0.67
Nodes (3): Global_2649159 GSBD, NETWORK_REGISTER_HOST_BROADCAST_VARIABLES, Server (host) broadcast data

## Ambiguous Edges - Review These
- `Vehicle physics: handling, damage and upgrades` → `camVehicleCustomSettingsMetadata`  [AMBIGUOUS]
  docs/rendering/cameras.md · relation: conceptually_related_to
- `Level 5: network testbed level` → `common:/data/levels/stripped`  [AMBIGUOUS]
  docs/00-getting-started/boot.md · relation: references

## Knowledge Gaps
- **850 isolated node(s):** `TASK_ENTER_VEHICLE`, `TASK_PLANE_MISSION / TASK_PLANE_TAXI`, `TASK_VEHICLE_TEMP_ACTION`, `GET_NTH_CLOSEST_VEHICLE_NODE`, `SET_ROADS_IN_ANGLED_AREA` (+845 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 881 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Research roadmap` to `Native namespace map`, `Properties in GTA Online`, `Economy and pickups`, `Boot and script control`, `Police and service AI / Wanted level and police`, `Runtime scripts: main_persistent`, `How Rockstar's scripts drive AI`, `UGC mission files / Archive and data file atlas`, `Data needs: handling.meta`, `The script VM`, `Rockstar Creator internals`, `Timecycle and post effects`, `Props, archetypes and doors`, `The story mission flow`, `Stats, tunables and the server's role`, `Physics cost`, `Fire, explosions and projectiles`, `Animation`, `How GTA Online works`, `Surviving game updates`, `Cutscenes and dialogue`, `Rockstar services`, `Combat and AI`, `How audio is organised`, `Open questions: Phase 1`, `Time, weather and wind`, `Script launch graph`, `Music and radio: RadioStation object`, `Text labels`, `Vehicle generators and traffic`, `Interaction menu, phone and apps`, `Open questions: Block A`, `Cameras`, `Completion, autosave and achievements`, `Interiors and IPLs`, `Anatomy of a story mission`, `Strangers, freaks and side content`, `Open questions: Batch P1.5`, `Memory, pools and limits`, `Controls and camera`, `Native usage`, `CONTRIBUTING.md`, `Scenarios and ambient life`, `AI cost and level of detail`, `Minigames and activities`, `DLC storylines in GTA Online`, `Measuring performance`, `Population`, `Collision, materials and shape tests`, `The job lobby`, `Server-backed Online screens: The ONLINE tab, 22 entries`, `The global variable map: FMMC globals`, `Vehicles`, `Flying`, `Organisations and businesses`, `Water and buoyancy`, `Perception and events`, `Relationships and groups`, `Online cosmetics and the shops that sell / Open questions`, `GTA Online / Open questions`, `Weapons: AmmoMax six ammo caps`, `Appearance and clothing`, `Inside freemode`, `Random events`, `Rendering, visual settings and LOD`, `Graphics settings, one by one`, `Character switching`, `Heists in GTA Online / Open questions`, `1. How mods work`, `Swimming and diving`, `Story systems that clash with an Online  / Open questions`, `Particles and decals`, `Map data`, `Setup`, `Ambient life: Ambient ped task loop`, `Speech and dialogue`, `05 Native functions`, `The AI architecture`, `Decisions and personalities`, `Tools / PC session plan`, `CLAUDE.md`, `Open questions: Questions by category`, `Driving AI`, `Peds`, `Replay, director mode and the Rockstar E`, `Streaming`, `Transitions and sessions / Open questions`, `Text and names in content`, `Respawn, death and arrest / Open questions`, `Navigation and pathfinding`, `Missions`, `Driving and AI driving`, `Vehicle physics: CHandlingData`, `Natives as the engine API`, `Health, armour, death and arrest / Open questions`, `Archives and the content system`, `Saves`, `The Online character creator`, `Player skills and abilities`, `Streaming, memory and video memory`, `Windows and drivers / Open questions`, `Research tools`, `Ped physics and ragdoll`, `GTA V Under the Hood`, `9. Next steps and sharing your mod / RPF archives`, `AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail`, `Research roadmap / Ambient life`?**
  _High betweenness centrality (0.323) - this node is a cross-community bridge._
- **What connects `TASK_ENTER_VEHICLE`, `TASK_PLANE_MISSION / TASK_PLANE_TAXI`, `TASK_VEHICLE_TEMP_ACTION` to the rest of the system?**
  _850 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Native namespace map` be split into smaller, more focused modules?**
  _Cohesion score 0.03729071537290715 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `1. How mods work` to `Economy and pickups`, `Police and service AI / Wanted level and police`, `How Rockstar's scripts drive AI`, `UGC mission files / Archive and data file atlas`, `The script VM`, `Rockstar Creator internals`, `Timecycle and post effects`, `Props, archetypes and doors`, `The story mission flow`, `Physics cost`, `Fire, explosions and projectiles`, `Animation`, `Surviving game updates`, `Cutscenes and dialogue`, `Combat and AI`, `How audio is organised`, `Time, weather and wind`, `Script launch graph`, `Music and radio: RadioStation object`, `Text labels`, `Vehicle generators and traffic`, `Open questions: Block A`, `Completion, autosave and achievements`, `Interiors and IPLs`, `Anatomy of a story mission`, `Strangers, freaks and side content`, `Open questions: Batch P1.5`, `Memory, pools and limits`, `Controls and camera`, `CONTRIBUTING.md`, `Scenarios and ambient life`, `Minigames and activities`, `DLC storylines in GTA Online`, `Population`, `Collision, materials and shape tests`, `The job lobby`, `The global variable map: FMMC globals`, `Vehicles`, `Flying`, `Water and buoyancy`, `Perception and events`, `Relationships and groups`, `Weapons: AmmoMax six ammo caps`, `Appearance and clothing`, `Glossary`, `Rendering, visual settings and LOD`, `Graphics settings, one by one`, `Character switching`, `Swimming and diving`, `Particles and decals`, `Map data`, `Ambient life: Ambient ped task loop`, `Speech and dialogue`, `05 Native functions`, `The AI architecture`, `Decisions and personalities`, `Driving AI`, `Peds`, `Streaming`, `Text and names in content`, `Respawn, death and arrest / Open questions`, `Tools and resources`, `Navigation and pathfinding`, `Missions`, `Driving and AI driving`, `Vehicle physics: CHandlingData`, `Cookbook: Pattern 110`, `Natives as the engine API`, `Health, armour, death and arrest / Open questions`, `07 Legacy / 03 Menus and UI`, `Archives and the content system`, `Saves`, `Player skills and abilities`, `06 The Lua plugin`, `Streaming, memory and video memory`, `Ped physics and ragdoll`, `9. Next steps and sharing your mod / RPF archives`, `Cookbook: Vehicle traps`, `Mod-builder's cookbook`, `Cookbook: Pattern 171`?**
  _High betweenness centrality (0.122) - this node is a cross-community bridge._
- **Should `Properties in GTA Online` be split into smaller, more focused modules?**
  _Cohesion score 0.05706760316066725 - nodes in this community are weakly interconnected._

### Low-confidence Hints
_AMBIGUOUS edges — the extractor was unsure. Verify before acting on these._

- **What is the exact relationship between `Vehicle physics: handling, damage and upgrades` and `camVehicleCustomSettingsMetadata`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **What is the exact relationship between `Level 5: network testbed level` and `common:/data/levels/stripped`?**
  _Edge tagged AMBIGUOUS (relation: references) - confidence is low._