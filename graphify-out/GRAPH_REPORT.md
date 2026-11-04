# Graph Report - gta5-under-the-hood  (2026-11-04)

## Corpus Check
- 24 files · ~488,722 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 4558 nodes · 9945 edges · 192 communities (190 shown, 2 thin omitted)
- Extraction: 94% EXTRACTED · 6% INFERRED · 0% AMBIGUOUS · INFERRED: 569 edges (avg confidence: 0.85)
- Token cost: 688,392 input · 0 output

## Community Hubs (Navigation)
- TASK natives used by the game scripts
- Anatomy of a story mission / Replay, director mode and the Rockstar E
- Properties in GTA Online
- Native namespace map
- Runtime scripts
- The global variable map
- Open questions / Rendering, visual settings and LOD
- Economy and pickups
- 03 Menus and UI
- Character switching
- Research tools
- How audio is organised
- How GTA Online works
- Rockstar services
- Rockstar Creator internals
- Fire, explosions and projectiles
- Physics cost
- Combat and AI
- Research roadmap: Large jobs
- GTA V Under the Hood
- CONTRIBUTING.md
- The story mission flow
- Animation
- Data needs: handling.meta
- Music and radio: RadioStation object
- Measuring performance
- Cameras
- Boot and script control: startup
- Completion, autosave and achievements
- Graphics settings, one by one
- Timecycle and post effects
- Text labels
- Script launch graph
- Surviving game updates
- Props, archetypes and doors: Rayfire map objects
- Minigames and activities / Open questions
- Time, weather and wind: Game clock
- Decisions and personalities / Open questions
- Strangers, freaks and side content
- The job lobby
- Interaction menu, phone and apps
- Collision, materials and shape tests
- Ambient life
- Scenarios and ambient life
- Cutscenes and dialogue
- Perception and events
- Server-backed Online screens: The ONLINE tab, 22 entries
- How Rockstar's scripts drive AI: Crew skill tier
- Wanted level and police
- Interiors and IPLs
- Vehicles
- Flying
- Open questions: HUD, colours and blips questions
- Native usage
- AI cost and level of detail
- Relationships and groups
- Organisations and businesses / Open questions
- Inside freemode
- Water and buoyancy
- Map data
- Handoff: Scripts-only questions
- Police and service AI
- Memory, pools and limits
- Data needs: Data batch D8
- Population
- Swimming and diving
- Peds
- Stats, tunables and the server's role
- VEHICLE natives used by the game scripts
- DLC storylines in GTA Online
- Random events
- NETWORK natives used by the game scripts
- Weapons: AmmoMax six ammo caps
- Heists in GTA Online / Open questions
- 7. Your first C++
- Native usage index
- PED natives used by the game scripts
- System requirements outside the game fol
- Speech and dialogue
- Appearance and clothing
- Particles and decals
- UGC mission files
- Cookbook: Mod map
- The script VM: The script VM questions
- PLAYER natives used by the game scripts
- STATS natives used by the game scripts
- Vehicle generators and traffic
- Glossary
- Driving AI
- The Online character creator / Open questions
- Natives as the engine API / 05 Native functions
- Controls and camera
- Respawn, death and arrest / Open questions
- Transitions and sessions / Open questions
- Tools
- Open questions: Batch D8
- CAMERA natives used by the game scripts
- Server-backed Online screens: Server calls per screen table
- GTA Online / Sessions and sync
- CLAUDE.md
- Tools and resources
- Archive and data file atlas
- Load times and stutter
- The AI architecture
- Text and names in content
- Missions / Script catalog
- Online cosmetics and the shops that sell / Open questions
- Data needs: common.rpf
- Data needs: vehicles.meta
- Saves / Open questions
- Player skills and abilities / Open questions
- Open questions: Phase 3
- Vehicle physics: CHandlingData
- Archives and the content system
- Open questions: Performance open questions
- Vehicle physics: Sub-handling blocks
- Story systems that clash with an Online 
- DATAFILE natives used by the game script / HUD natives used by the game scripts
- Data needs: Data batch D10
- Story-mode UI / Open questions
- Open questions: Phase 2
- Open questions: Phase 4
- Boot and script control: maintransition
- Health, armour, death and arrest
- Scaleform movies / Open questions
- Open questions: AI open questions
- Open questions: Batch D7
- Open questions: Weapons questions
- Open questions: Batch P2.1
- Open questions: Batch D9
- The script VM: FORCE_CLEANUP
- Open questions: Batch D11
- Data needs: tools/rpf-cw.ps1
- Windows and drivers / Open questions
- ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip
- Ped physics and ragdoll
- Props, archetypes and doors: Archetype
- EXTRAMETADATA natives used by the game s
- WEAPON natives used by the game scripts
- Open questions: Random events questions
- How Rockstar's scripts drive AI: fm_content_* scripts
- Online cosmetics and the shops that sell
- Open questions: Phase 1
- How Rockstar's scripts drive AI: Hostile ped recipe
- Time, weather and wind: weather.xml
- Open questions: Batch P4.1
- Open questions: Batch D10
- Open questions: DLC storylines in GTA Online questions
- The script VM: Compiled script
- Data needs: pedpersonality.ymt
- Data needs: Data batch D11
- Time, weather and wind: respawn_controller
- DLC natives used by the game scripts / LOBBY natives used by the game scripts
- FIRE natives used by the game scripts / EVENT natives used by the game scripts
- Handoff: Second pass
- Cookbook: Vehicle traps
- Open questions: How Rockstar's scripts drive AI question
- Open questions: Cutscenes and dialogue questions
- Open questions: Time, weather and wind questions
- MISC natives used by the game scripts
- The script VM: ScriptHookV
- Handoff: joaat name hashing
- Music and radio: Music events
- Weapons: Bullet damage model
- Cookbook / weapons.meta and weaponcomponents.meta
- Organisations and businesses / Interaction menu, phone and apps
- Open questions: Entities open questions
- Open questions: Particles and decals questions
- INTERIOR natives used by the game script
- PHYSICS natives used by the game scripts
- Runtime scripts / Memory, pools and limits
- Appearance and clothing / Peds
- Key codes and control IDs
- Cookbook: Pattern
- BUILTIN natives used by the game scripts
- MONEY natives used by the game scripts
- OBJECT natives used by the game scripts
- PAD natives used by the game scripts
- RECORDING natives used by the game scrip
- SCRIPT natives used by the game scripts
- SOCIALCLUB natives used by the game scri
- The script VM: Script event queues
- Research roadmap: R4.2 Scenarios and ambient life
- Open questions: Ambient life questions
- ITEMSETS natives used by the game script
- REPLAY natives used by the game scripts
- SECURITY natives used by the game script
- SHAPETEST natives used by the game scrip
- AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail
- Cookbook / DLC storylines in GTA Online
- UNKNOWN natives used by the game scripts
- AI cost and level of detail / Ambient life: SET_PED_POPULATION_BUDGET / SET_VEHICLE_

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 243 edges
2. `Data needs: open questions that need game files` - 192 edges
3. `Native namespace map` - 141 edges
4. `Mod map: what to read for the mod you want to make` - 112 edges
5. `Runtime scripts: the scripts that keep the game running` - 101 edges
6. `Native usage: which scripts call which natives` - 94 edges
7. `Tools` - 88 edges
8. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 86 edges
9. `Properties in GTA Online` - 83 edges
10. `The global variable map` - 83 edges

## Surprising Connections (you probably didn't know these)
- `ScriptHookV (SHV)` --semantically_similar_to--> `ScriptHookV`  [INFERRED] [semantically similar]
  docs/00-getting-started/glossary.md → modding/02-tools-you-need.md
- `ScriptHookVDotNet.asi` --semantically_similar_to--> `ScriptHookVDotNet (SHVDN)`  [INFERRED] [semantically similar]
  docs/00-getting-started/system-requirements.md → scripting/script-vm.md
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `GTA-V-Decompiled-Scripts community decompile` --semantically_similar_to--> `Decompiled scripts (community decompile)`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CLAUDE.md
- `CodeWalker (CodeWalker.Core.dll)` --semantically_similar_to--> `CodeWalker`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CLAUDE.md

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

## Communities (192 total, 2 thin omitted)

### Community 0 - "TASK natives used by the game scripts"
Cohesion: 0.05
Nodes (79): Driving and AI driving, AIHandling field in handling.meta, Corner speed curve, CTaskPlayerDrive, Driving style flags, Four AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), SET_DRIVE_TASK_CRUISE_SPEED, SPORTS_CAR profile (+71 more)

### Community 1 - "Anatomy of a story mission / Replay, director mode and the Rockstar E"
Cohesion: 0.05
Nodes (69): Anatomy of a story mission, armenian1 (Franklin and Lamar), Jewel Store Job crew tiers and take, flow_controller, Force cleanup handler (HAS_FORCE_CLEANUP_OCCURRED), Global_80529 mission pass bits, Heist approach (flow integer f_205[7]), jewelry_heist (The Jewel Store Job) (+61 more)

### Community 2 - "Properties in GTA Online"
Cohesion: 0.06
Nodes (66): appbikerbusiness, Properties in GTA Online, ADD_BLIP_FOR_COORD, AM_MP_ARCADE, AM_MP_BUNKER, AM_MP_FIXER_HQ, AM_MP_HANGAR, AM_MP_NIGHTCLUB (+58 more)

### Community 3 - "Native namespace map"
Cohesion: 0.04
Nodes (64): SCR-001: Split MISC into sub-families with their own owners (weather, cheats..., SCR-002: Which natives are reached only through shared helper code and never..., SCR-003: Which namespaces' unused natives still work in story mode (useful to..., Native namespace map questions (R0.8), Native namespace map, 54 natives only in indirect-call code, Call_Loc indirect calls, DISABLE_CONTROL_ACTION (+56 more)

### Community 4 - "Runtime scripts"
Cohesion: 0.06
Nodes (58): freemode, Runtime scripts: the scripts that keep the game running, achievement_controller, autosave_controller, blip_controller, buddydeathresponse, building_controller, cellphone_controller (+50 more)

### Community 5 - "The global variable map"
Cohesion: 0.05
Nodes (53): The global variable map, Blocks 13 and 15 (dead code), GlobalplayerBD .f_204 / .f_203 flag words, GPBD_FM .f_260 (stat-backed state), GlobalplayerBD .f_325 (interior the player is in), Global_102429 (replay controller state), Global_102481 (shop data), Global_114904 (story save) (+45 more)

### Community 6 - "Open questions / Rendering, visual settings and LOD"
Cohesion: 0.05
Nodes (53): Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass), REN-017: Changed visualsettings.dat keys, Rendering, visual settings and LOD, Adrian Courreges GTA V graphics study, CASCADE_SHADOWS_INIT_SESSION, CASCADE_SHADOWS_SET_CASCADE_BOUNDS, Cascaded shadow maps (+45 more)

### Community 7 - "Economy and pickups"
Cohesion: 0.07
Nodes (54): clothes_shop_sp, Economy and pickups, ADD_PICKUP_TO_INTERIOR_ROOM_BY_NAME, atm_trigger, BAWSAQ exchange, BSS_BSTR company labels, code_controller, Collectable scripts (+46 more)

### Community 8 - "03 Menus and UI"
Cohesion: 0.06
Nodes (46): handling.meta, CHandlingData entries, materials.dat and related material files, Collision material table (213 materials), File formats, RPF archives, RPF archive format v7, Per-frame script loop (+38 more)

### Community 9 - "Character switching"
Cohesion: 0.06
Nodes (44): Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, Pop-in and streaming hitches, Population and model budgets, Request, check, release pattern (+36 more)

### Community 10 - "Research tools"
Cohesion: 0.05
Nodes (47): Game version (Legacy 1.0.3725.0), Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Reading the decompiled game scripts, Community decompile repository (one commit per build), freemode started by maintransition with stack 35,250; creator 28,000 (+39 more)

### Community 11 - "How audio is organised"
Cohesion: 0.07
Nodes (46): AUD-001: Number of sounds and sound sets, AUD-004: Speech archives, voices and contexts, AUD-005: Unresolved radio station objects, AUD-008: Radio track data, AUD-009: Speech archives, voices and contexts, AUD-010: Dialogue block per mission, .awc audio archives, Data batch D9: audio files (+38 more)

### Community 12 - "How GTA Online works"
Cohesion: 0.07
Nodes (46): mpstatscharactermappingdata.xml, How GTA Online works, am_mp_* property scripts, Ambient events (am_* scripts), ambient_mp.ipl, Phone and computer app* scripts, Broadcast data (host and player), fmmc_launcher (corona) (+38 more)

### Community 13 - "Rockstar services"
Cohesion: 0.07
Nodes (46): Rockstar services, Catalogue keys (<name>_t<type>_v<version>), CATEGORY_VEHICLE_MOD, CATEGORY_WAREHOUSE_INTERIOR, Cloud files, Cloud stat slots, Crews (NETWORK_CLAN_*), GET_CLOUD_TIME_AS_INT (+38 more)

### Community 14 - "Rockstar Creator internals"
Cohesion: 0.08
Nodes (46): Rockstar Creator internals, am_mp_creator_trailer / _aircraft (not the content creator), Stunt track bone snapping (bones 2 to 5), CREATE_MODEL_HIDE (Fixtures removed, dhprop), creator (hub script), Creator limits (200 props, 20 dynamic ...), Creator enable tunables (426), DATAFILE natives (+38 more)

### Community 15 - "Fire, explosions and projectiles"
Cohesion: 0.08
Nodes (41): Fire, explosions and projectiles, ADD_EXPLOSION, ADD_OWNED_EXPLOSION, bAppliesContinuousDamage, bForceNonTimedVfx, bIsSmokeGrenade, bSuppressCrime, CAmmoProjectileInfo (+33 more)

### Community 16 - "Physics cost"
Cohesion: 0.08
Nodes (39): Physics cost, ACTIVATE_PHYSICS, ADD_EXPLOSION, ADD_ROPE, CLEAR_AREA, CLEAR_AREA_OF_OBJECTS, CLEAR_AREA_OF_PROJECTILES, CLEAR_AREA_OF_VEHICLES (+31 more)

### Community 17 - "Combat and AI"
Cohesion: 0.08
Nodes (43): Combat and AI (first pass), ADD_RELATIONSHIP_GROUP, AI_GLOBAL_MODIFIER 2.0, Combat behaviour flags (BF_CanUseCover ...), combatbehaviour.meta (16 CCombatInfo), Decision makers (25), DEFAULT_PERCEPTION (60 m sight/hearing), Defensive areas (SET_PED_SPHERE_DEFENSIVE_AREA) (+35 more)

### Community 18 - "Research roadmap: Large jobs"
Cohesion: 0.08
Nodes (42): The player, R6.5 Online character creator, Large jobs (priority) list: 13 jobs, Research roadmap, Good first topics, Inbox issues for uncovered findings, R0.7 Archive and data file atlas, R0.8 Native namespace map (+34 more)

### Community 19 - "GTA V Under the Hood"
Cohesion: 0.06
Nodes (39): ScriptHookVDotNet, LemonUI, Steps 5/6/7 are alternatives (C#, Lua, C++), GTA V Under the Hood: how Grand Theft Auto V works underneath, C++ (ScriptHookV), First pass: all 109 research topics, freemode: 1.47-million-line main Online script, Lua (+31 more)

### Community 20 - "CONTRIBUTING.md"
Cohesion: 0.07
Nodes (36): Branch naming (research/<ID>-pass2-<what> ...), File rules table, Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, AI, AI folder topics R3.2, R3.3, R3.7, R17.1-R17.10 (all done first pass) (+28 more)

### Community 21 - "The story mission flow"
Cohesion: 0.09
Nodes (41): R5.1, The story mission flow: how missions unlock, Activate strand command, Activate stranger mission command, agency_heist2 special builder, code_controller, What a fail does to the flow (pass/fail labels), Blitz Play prep 3 (fbi4_prep3, never activated) (+33 more)

### Community 22 - "Animation"
Cohesion: 0.08
Nodes (39): Animation, Animation memory groups, Base clip archives, Clip dictionaries (.ycd), Clip sets, clip_sets.ymt, common_anim.meta, conditionalanims.meta (+31 more)

### Community 23 - "Data needs: handling.meta"
Cohesion: 0.09
Nodes (39): Data needs: open questions that need game files, AI-014: Meaning of taskdata.meta and scriptedguntasks.meta, AI-024: AI handling profile of every DLC vehicle, AI-033: Decision maker event-to-response mapping, AUD-006: Music event to mood to track, Data batch D6: shop catalogues, carcols.ymt / carcols.meta, carvariations.meta (+31 more)

### Community 24 - "Music and radio: RadioStation object"
Cohesion: 0.07
Nodes (38): Music and radio, AUDIO_GAMEDATA content.xml entries, AUDIO_IS_SCRIPTED_MUSIC_PLAYING, .awc wave containers, CANCEL_MUSIC_EVENT, FM_COUNTDOWN_30S music event, fm_mission_controller, game.dat151.rel (audio game data) (+30 more)

### Community 25 - "Measuring performance"
Cohesion: 0.08
Nodes (34): Measuring performance, ARE_ANY_CCS_PENDING, -benchmark command-line switches, benchmark script, Benchmark 8-state loop, BMARK text block, Content change sets (GROUP_ON_DEMAND, 43 packs), CPU-bound vs GPU-bound test (+26 more)

### Community 26 - "Cameras"
Cohesion: 0.10
Nodes (37): REN-008: Unresolved camera shake names, REN-009: CREATE_CAMERA hashes scripts use, Cursor line test (2,400 m probe), Cameras, camCinematicMountedCameraMetadata, camEnvelopeMetadata, Camera shakes, cameras.ymt (+29 more)

### Community 27 - "Boot and script control: startup"
Cohesion: 0.10
Nodes (39): Boot and script control: from launch to control, and between story and Online, Shared activity-type helper (212 scripts), asiloader.log / ScriptHookV.log / ScriptHookVDotNet.log, director_mode, flow_controller, GET_INDEX_OF_CURRENT_LEVEL, Global_1 (new or loaded game flag), Global_3 (boot into Online) (+31 more)

### Community 28 - "Completion, autosave and achievements"
Cohesion: 0.10
Nodes (38): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), autosave_controller (four states, stack 1,424), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, When the autosave controller refuses or waits, Autosave request global Global_102468 (11 values) (+30 more)

### Community 29 - "Graphics settings, one by one"
Cohesion: 0.07
Nodes (35): CityDensity setting, Game threads (24, Update TIME_CRITICAL), Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat, Open questions (graphics) (+27 more)

### Community 30 - "Timecycle and post effects"
Cohesion: 0.06
Nodes (34): Timecycle and post effects, ADD_TCMODIFIER_OVERRIDE, AnimMode, ANIMPOSTFX_STOP, animpostfx.ymt, CAMERA_secuirity_FUZZ, DrugsMichaelAliensFight, FocusOut (+26 more)

### Community 31 - "Text labels"
Cohesion: 0.09
Nodes (38): Completion label text (199 of 320 in global.gxt2, 121 internal names), Text labels, ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL, americandlc.rpf DLC text, *aud subtitle blocks, BEGIN_TEXT_COMMAND_DISPLAY_HELP, BEGIN_TEXT_COMMAND_DISPLAY_TEXT, BEGIN_TEXT_COMMAND_PRINT (+30 more)

### Community 32 - "Script launch graph"
Cohesion: 0.11
Nodes (38): R0.5 Script launch graph, Script launch graph (build 3725), am_mp_drone script, buddydeathresponse script, cellphone_controller script, cellphone_flashhand script, creator script, director_mode script (+30 more)

### Community 33 - "Surviving game updates"
Cohesion: 0.08
Nodes (37): Core engine, R0.2 Script cards for the runtime scripts, R11.2 An update-check tool, R5.3 Saves, completion and autosave, Surviving game updates, Things addressed by number (offsets, globals), Asset dependency list, Byte-pattern scans (FindPattern) (+29 more)

### Community 34 - "Props, archetypes and doors: Rayfire map objects"
Cohesion: 0.09
Nodes (37): Props, archetypes and doors, ADD_DOOR_TO_SYSTEM, Door auto-open flags, BarrierArmCustomBox, ChopShopGarageCustomBox, CREATE_OBJECT / CREATE_OBJECT_NO_OFFSET, DefaultStandardLatchShut, des_farmhs (+29 more)

### Community 35 - "Minigames and activities / Open questions"
Cohesion: 0.09
Nodes (37): Minigames and activities, Activity IDs 0 to 18, am_mp_arc_cab_manager (Online arcade), code_controller, controller_ambientarea, golf script (clubs, lies, AI aim, wind), golf_ai_foursome ambient golfers, GP-088 (unarmed code entries 6, 12, 18) (+29 more)

### Community 36 - "Time, weather and wind: Game clock"
Cohesion: 0.08
Nodes (37): Time, weather and wind, ADD_TO_CLOCK_TIME, branchbend_windsettings.xml, cheat_controller, clouds.xml, exile1, EXTRASUNNY, _FORCE_GROUND_SNOW_PASS (+29 more)

### Community 37 - "Decisions and personalities / Open questions"
Cohesion: 0.10
Nodes (36): Agitation system (agitatedtriggers/responses/personalities.meta), Decisions and personalities, Agitated personality (default / Confront / none), ArmourEfficiency / HealthRegenEfficiency / StaminaEfficiency, BF_COWARDLY_FOR_SHOCKING_EVENTS, 18 bravery types, Criminality types, DLC pedpersonality.meta (23 files, holster anims) (+28 more)

### Community 38 - "Strangers, freaks and side content"
Cohesion: 0.11
Nodes (34): Strangers, freaks and side content, appinternet (Epsilon website), atm_trigger, BailBond_Launcher, Brain set bit mask (story 1, Online 8), code_controller, completionpercentage_controller, DISABLE_SCRIPT_BRAIN_SET / ENABLE_SCRIPT_BRAIN_SET (+26 more)

### Community 39 - "The job lobby"
Cohesion: 0.10
Nodes (35): Classic apartment planning board (heist_mp, heistmap_mp, heist_pre), DRAW_SCALEFORM_MOVIE_3D_SOLID, fmmc_launcher, am_pi_menu (interaction menu), The job lobby (fmmc_launcher), The corona (lobby screens), Corona settings path (GPBD_FM_2 to Global_2685150.f_669), The 11 top-level launcher states (+27 more)

### Community 40 - "Interaction menu, phone and apps"
Cohesion: 0.11
Nodes (35): Interaction menu, phone and apps, am_contact_requests (contact services), appContacts, appHackerDen (Darnell Inc.), appInternet, AppJIPMP (Quick Join), appMPJobListNEW, appTrackify (+27 more)

### Community 41 - "Collision, materials and shape tests"
Cohesion: 0.10
Nodes (31): PHY-001: Two unnamed materials.dat columns, Collision, materials and shape tests, GET_GROUND_Z_FOR_3D_COORD, GET_SHAPE_TEST_RESULT, GLASS_BULLETPROOF, HAS_COLLISION_LOADED_AROUND_ENTITY, hi@ and ma@ collision sets, Material groups (FILTER) (+23 more)

### Community 42 - "Ambient life"
Cohesion: 0.12
Nodes (33): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, Ambient life, Ambient ped task loop (Known), Animals: 41 ped models of type animal, CAmbientLookAt (scan 15 m, look 2 s), TASK_CHAT_TO_PED callers: taxi_gotyounow, taxi_clowncar, nigel2, franklin0, re_stag_do, CLEAR_AREA_OF_PEDS (456 scripts), CTaskAmbientClips (idle every 4 s, 40 s after gunshot) (+25 more)

### Community 43 - "Scenarios and ambient life"
Cohesion: 0.09
Nodes (34): Scenarios and ambient life, act_cinema, ADD_SCENARIO_BLOCKING_AREA, Ambient aircraft and boats, ambientpedmodelsets.meta, Chaining graphs, HEIST_ISLAND_PEDS, MP_POLICE (+26 more)

### Community 44 - "Cutscenes and dialogue"
Cohesion: 0.11
Nodes (33): Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A), CREATE_NEW_SCRIPTED_CONVERSATION (+25 more)

### Community 45 - "Perception and events"
Cohesion: 0.09
Nodes (34): Perception and events, ADD_SHOCKING_EVENT_AT_POSITION, ADD_SHOCKING_EVENT_FOR_ENTITY, AddPedGenBlockedArea, CanCallPolice, CEventAgitated, CEventCrimeCryForHelp, CEventGunShot (+26 more)

### Community 46 - "Server-backed Online screens: The ONLINE tab, 22 entries"
Cohesion: 0.09
Nodes (32): Server-backed Online screens (R8.5), appinternet (in-game websites), Busy spinners and warning screens, NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, Credits & Legal tunable Global_262145.f_9321, Engine-filled network pages (friends, crews, party, store, invites), Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED), Jobs and Playlists UGC lists (+24 more)

### Community 47 - "How Rockstar's scripts drive AI: Crew skill tier"
Cohesion: 0.10
Nodes (31): SET_PED_SEEING_RANGE, How Rockstar's scripts drive AI, agency_heist3a, agency_heist3b, am_casino_peds, am_mp_peds, Buddies join the player's group, CAN_PED_SEE_HATED_PED (+23 more)

### Community 48 - "Wanted level and police"
Cohesion: 0.09
Nodes (33): CRIME_KILL_COP, SET_MAX_WANTED_LEVEL, SET_WANTED_LEVEL_MULTIPLIER, wantedtuning.ymt, Wanted level and police, CanWitnessCrimes / WillCallLawEnforcement, CRIME_FIREARM_DISCHARGE, CRIME_HASSLE (+25 more)

### Community 49 - "Interiors and IPLs"
Cohesion: 0.09
Nodes (30): PIN_INTERIOR_IN_MEMORY, CMloArchetypeDef, Interiors and IPLs, ACTIVATE_INTERIOR_ENTITY_SET, building_controller, CAP_INTERIOR, CMloInstanceDef, DISABLE_INTERIOR (+22 more)

### Community 50 - "Vehicles"
Cohesion: 0.09
Nodes (31): Vehicle groups, Vehicles, 921 vehicle models, Add-on vehicle pack, carcols, carvariations, CREATE_VEHICLE, dlc_patch vehicles.meta copies (+23 more)

### Community 51 - "Flying"
Cohesion: 0.10
Nodes (33): Flying, bj (base jumps), CFlyingHandlingData, CONTROL_LANDING_GEAR / GET_LANDING_GEAR_STATE, CTaskParachute tunables (movementtasks.ymt), DLC aircraft flying blocks (63 entries), Flight school lessons MGFS_0 to 11, GET_PED_PARACHUTE_STATE (+25 more)

### Community 52 - "Open questions: HUD, colours and blips questions"
Cohesion: 0.09
Nodes (33): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, Radar and minimap interiors, Pause and Online menus, ACTIVATE_FRONTEND_MENU usage (+25 more)

### Community 53 - "Native usage"
Cohesion: 0.09
Nodes (32): SCR-004: What 0x8F5D1AD832AEB06C and 0x0F7082C60FB479EF do (not in NativeDB), SCR-005: Whether the 29 "build 3889" natives exist in 3725 (IS_NATIVE... style..., SCR-006: A story-only vs Online-only split of every native (which natives..., SCR-007: What the table order is (not first use; maybe first use in compiled..., Native usage questions (R0.3), 1,013 scripts call 6,575 natives (12.3 million calls), R0.3 Native usage / native tables, Native usage: which scripts call which natives (+24 more)

### Community 54 - "AI cost and level of detail"
Cohesion: 0.12
Nodes (30): AI cost and level of detail, AI LOD by distance (near, middle, far), CTaskMotionBasicLocomotionLowLod, Dummy and super-dummy vehicles, FORCE_ENTITY_AI_AND_ANIMATION_UPDATE (340 scripts), FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts, 4,119 calls), gameconfig.xml (update copy), IS_ENTITY_ON_SCREEN (316 scripts) (+22 more)

### Community 55 - "Relationships and groups"
Cohesion: 0.10
Nodes (30): SET_PLAYER_WANTED_LEVEL, Relationships and groups, ADD_RELATIONSHIP_GROUP, AMBIENT_GANG_* groups (9), CIVMALE / CIVFEMALE groups, COP relationship group, Follower limit (7 besides leader), franklin1 (+22 more)

### Community 56 - "Organisations and businesses / Open questions"
Cohesion: 0.13
Nodes (32): gb_* and fm_content_* business scripts, Organisations and businesses, am_launcher event-type table, am_pi_menu, Biker businesses and bunker production, Boss registration (free, gb_become_boss_threshold), Business Battles, Business loop (supplies, production, stock, sell) (+24 more)

### Community 57 - "Inside freemode"
Cohesion: 0.12
Nodes (28): Inside freemode, am_mp_island (Cayo Perico), am_pi_menu (interaction menu), DLC story flow functions (CH_FLOW_, HIF_ ...), Network event 174 (script events carrier), FMMC_Launcher (job lobby), freemode script, freemode_clearGlobals (+20 more)

### Community 58 - "Water and buoyancy"
Cohesion: 0.10
Nodes (32): Water and buoyancy, ADD_EXTRA_CALMING_QUAD, Buoyancy by sampling water height, Calming quads (542), fDampening, Whole-map flood via water.xml, fPercentSubmerged, Five water quad types (+24 more)

### Community 59 - "Map data"
Cohesion: 0.10
Nodes (29): Timecycle modifier boxes, Map data, Box occluders, Car generators, controller_ambientarea, cs1_12.ymap, HDTxdAssetBindings, HoursOnOff (+21 more)

### Community 60 - "Handoff: Scripts-only questions"
Cohesion: 0.09
Nodes (31): Decompile commit 6c18d3e8, ON-068: Website items 323, 324, 357, 402 models, Handoff: current status and what to do next, Answered / mostly / partly marking rule, AUD-004 / AUD-009 speech2.dat4.rel byte arrays, Cloud vs maintainer-PC work split, CodeWalker library classes (YmapFile, RelFile ...), Questions for the community (GP-076, REN-019, ON-053) (+23 more)

### Community 61 - "Police and service AI"
Cohesion: 0.11
Nodes (30): Police and service AI, Assassins dispatch type, Crime-info entries (9, CRIME_KILL_COP weight 5), dispatch.meta, Dispatch spawning rules (250 m ideal), Dispatch vehicle sets (15), dispatchtuning.ymt, ENABLE_DISPATCH_SERVICE (+22 more)

### Community 62 - "Memory, pools and limits"
Cohesion: 0.08
Nodes (30): Memory, pools and limits, ArchiveCount, CAN_REGISTER_MISSION_PEDS / VEHICLES / OBJECTS, CEvent pool, ConfigModelInfo, ConfigPopulation, ConfigStreamingEngine, CTask pool (8,192) (+22 more)

### Community 63 - "Data needs: Data batch D8"
Cohesion: 0.12
Nodes (30): AI-027: Road nodes, routes and counts, AI-028: Navmesh polygons, links, cover points per tile, AI-029: Road nodes, routes and counts, Data batch D8: map data, ENT-001: Archetype flag bits across all .ytyp, ENT-002: Fragment map props and how many break, ENT-003: Rayfire objects placed in the map, ENT-028: Online-only scenario points (+22 more)

### Community 64 - "Population"
Cohesion: 0.10
Nodes (30): ENT-024: Unnamed zone fields, zonebind.ymt, Population, cellphone_flashhand (phone signal bars), CLEAR_AREA_OF_PEDS / VEHICLES, GET_ZONE_SCUMMINESS, lawResponseTime / lawResponseType, Missing schedule hash_7D143EDB (+22 more)

### Community 65 - "Swimming and diving"
Cohesion: 0.11
Nodes (28): GP-073: Non-story PlayerStatInfos entries, motiontasks.ymt, Swimming and diving, CTaskMotionSwimming tunables, Dive height (MinDiveHeight / MaxDiveHeight), GET_ENTITY_SUBMERGED_LEVEL, GET_PLAYER_UNDERWATER_TIME_REMAINING, HighFallWaterDepthMin / Max (+20 more)

### Community 66 - "Peds"
Cohesion: 0.10
Nodes (29): SET_PED_RELATIONSHIP_GROUP_HASH, Peds, 1,109 ped models, AbilityType special abilities, CombatInfo, CPedModelInfo InitData, CREATE_PED, DecisionMakerName (+21 more)

### Community 67 - "Stats, tunables and the server's role"
Cohesion: 0.12
Nodes (30): Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, clothes_shop_mp, Hash-only tunables (7,296; 311 recovered), MONEY NETWORK_SPENT_* / NETWORK_EARN_* natives, mpstatssetup.xml (17,928 Online stats), Offline Online mode replacements (local save, tunable defaults, local prices), Packed stats (6,403) (+22 more)

### Community 68 - "VEHICLE natives used by the game scripts"
Cohesion: 0.14
Nodes (30): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, _GET_VEHICLE_TRAILER_PARENT_VEHICLE (+22 more)

### Community 69 - "DLC storylines in GTA Online"
Cohesion: 0.13
Nodes (28): DLC storylines in GTA Online, AW_FLOW flow (Arena War), BATFMAU After Hours call block (143 roots), BT24_FLOW flow (Bottom Dollar), CH_FLOW flow (Casino Heist), EXEC_FLW flow, FIX_FLOW flow (The Contract), GR_FLOW flow (Gunrunning) (+20 more)

### Community 70 - "Random events"
Cohesion: 0.10
Nodes (27): ambient.ipl, Random events, code_controller, Cut random events without scripts, Global_114904 random event save, lesterhandler, Open question: world brain activation range, photographymonkey (+19 more)

### Community 71 - "NETWORK natives used by the game scripts"
Cohesion: 0.16
Nodes (29): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+21 more)

### Community 72 - "Weapons: AmmoMax six ammo caps"
Cohesion: 0.11
Nodes (28): WeaponLimitsAdjuster, Weapons, Aim assist and lock-on (R3.2), AmmoMax six ammo caps, CAimingInfo, CAmmoInfo, Clip components (ClipSize), DLC weapons (246 entries in 33 packs) (+20 more)

### Community 73 - "Heists in GTA Online / Open questions"
Cohesion: 0.15
Nodes (26): Heists in GTA Online, Casino crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo secondary loot value rolls, ch_lester_cut (5%), Classic heists (Fleeca to Pacific Standard), Heist cut rules (55% leader, 15% min, 70% max), The Diamond Casino Heist (+18 more)

### Community 74 - "7. Your first C++"
Cohesion: 0.12
Nodes (25): 1. How mods work, Add-on pack vs replacement archive, Data mods vs script mods, 7. Your first C++ (.asi) mod, ASI loader, ASI plugin (64-bit DLL), asiloader.log / ScriptHookV.log, DllMain (register only) (+17 more)

### Community 75 - "Native usage index"
Cohesion: 0.24
Nodes (28): Native usage index, Game build 3725, Decompile commit 6c18d3e8b, Decompiler names differing from NativeDB, Per-namespace native usage index, tools/native-usage.ps1 generator, NativeDB reference, Scripts with most natives (fm_mission_controller_2020 3166) (+20 more)

### Community 76 - "PED natives used by the game scripts"
Cohesion: 0.16
Nodes (28): PED natives used by the game scripts, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE, GET_VEHICLE_PED_IS_IN (+20 more)

### Community 77 - "System requirements outside the game fol"
Cohesion: 0.10
Nodes (26): Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, Launch with -nobattleye for story-mode mods, Run under Proton or Wine with DXVK (D3D11 to Vulkan), check-system.ps1: PC requirement check (+18 more)

### Community 78 - "Speech and dialogue"
Cohesion: 0.13
Nodes (27): Speech and dialogue, Ambient voice name pattern (<model>_<ethnicity>_<full|mini>_<n>), .awc speech containers, Dialogue block to mission mapping (AUD suffix), BOUNCER_EJECT_GENERIC, comms_controller, dialogue_handler, DISABLE_PED_PAIN_AUDIO (+19 more)

### Community 79 - "Appearance and clothing"
Cohesion: 0.12
Nodes (26): Appearance and clothing, ADD_PED_DECORATION_FROM_HASHES, clothes_shop_mp, FINALIZE_HEAD_BLEND, forcedComponents, GET_SHOP_PED_COMPONENT, hairdo_shop_mp, Head blend (+18 more)

### Community 80 - "Particles and decals"
Cohesion: 0.13
Nodes (26): materialfx.dat, Particles and decals, ADD_DECAL, bloodfx.dat, core particle dictionary, decals.dat, entityfx.dat, MTLFX_TABLE (+18 more)

### Community 81 - "UGC mission files"
Cohesion: 0.13
Nodes (25): .ugc job file, UGC mission files (JSON), am_launcher, Classic creator missions family, endcon section, ene section, fm_content_bounty_targets, fm_content_* scripts (+17 more)

### Community 82 - "Cookbook: Mod map"
Cohesion: 0.08
Nodes (18): Cookbook: audio, .awc containers plus .dat*.rel config, Pattern: looping alarm, PLAY_SOUND_FRONTEND / GET_SOUND_ID / START_AUDIO_SCENE natives, Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu, Mod-builder's cookbook (+10 more)

### Community 83 - "The script VM: The script VM questions"
Cohesion: 0.12
Nodes (24): SCR-011: Meaning of force-cleanup bits 4, 16 and 32 (engine-raised), SCR-012: What thread priority values change, SCR-013: The event queue indexes and the script event layout, SCR-014: Which of the duplicated pool entries in gameconfig.xml applies to the..., The script VM questions (R1.1), R1.1 The script VM, The script VM, freemode script (+16 more)

### Community 84 - "PLAYER natives used by the game scripts"
Cohesion: 0.17
Nodes (27): PLAYER natives used by the game scripts, GET_PLAYER_NAME, GET_PLAYER_PED, GET_PLAYER_TEAM, GET_PLAYER_WANTED_LEVEL, INT_TO_PLAYERINDEX, IS_PLAYER_CONTROL_ON, IS_PLAYER_PLAYING (+19 more)

### Community 85 - "STATS natives used by the game scripts"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 86 - "Vehicle generators and traffic"
Cohesion: 0.12
Nodes (25): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, Vehicle generators and traffic, Car generator flag bits, Car generators (CCarGen), CREATE_MISSION_TRAIN, CREATE_SCRIPT_VEHICLE_GENERATOR, Dispatch services, DLC road-section ymap copies (+17 more)

### Community 87 - "Glossary"
Cohesion: 0.11
Nodes (24): Verified / Known claim marking, Glossary, ASI plug-in, Broadcast data, Decision maker, DLC pack, Global / global block, Handling (+16 more)

### Community 88 - "Driving AI"
Cohesion: 0.13
Nodes (24): Driving AI: missions, chases, aircraft and boats, Flee mission (8), Roadmap R17.6 driving AI, SET_BOAT_ANCHOR, SET_DRIVER_RACING_MODIFIER, SET_HELI_BLADES_FULL_SPEED, TASK_BOAT_MISSION, TASK_HELI_MISSION (+16 more)

### Community 89 - "The Online character creator / Open questions"
Cohesion: 0.12
Nodes (25): The Online character creator, Starter outfits and crew T-shirt, Appearance change fee and cooldown, CHAR_CREATOR_PORTRAITS, FEATURE_0 to FEATURE_20 stats, FINALIZE_HEAD_BLEND / HAS_PED_HEAD_BLEND_FINISHED, HEADBLEND_* and MESH_* stats, Heritage head blend (Mom/Dad) (+17 more)

### Community 90 - "Natives as the engine API / 05 Native functions"
Cohesion: 0.09
Nodes (24): R1.3 Natives as the engine API, 05 Native functions, Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument), Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED), Contracts Rockstar keeps (request, release, create, clean up), Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT) (+16 more)

### Community 91 - "Controls and camera"
Cohesion: 0.13
Nodes (24): Control IDs shift +37 in build 3717, Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+16 more)

### Community 92 - "Respawn, death and arrest / Open questions"
Cohesion: 0.16
Nodes (24): PP_INFO_STRUCT (per-character save), Respawn, death and arrest (R6.2), Arrest penalty: up to $300 and weapons cleared, Death fee: 5% of cash, max $5,000, exile_city_denial, 5 hospital restart points (ADD_HOSPITAL_RESTART), mission_repeat_controller, Online respawn (NETWORK_START_RESPAWN_SEARCH, NETWORK_RESURRECT_LOCAL_PLAYER) (+16 more)

### Community 93 - "Transitions and sessions / Open questions"
Cohesion: 0.17
Nodes (24): Transitions and sessions (R7.2), freemode_clearGlobals (31 reset steps), ingamehud connection-problem warnings, maintransition (transition state machine script), NETWORK_IS_GAME_IN_PROGRESS (905 scripts), NETWORK_REQUEST_CLOUD_TUNABLES, Offline-mode branch (unreachable in build 3725), Online privilege checks (NETWORK_HAVE_ONLINE_PRIVILEGES ...) (+16 more)

### Community 94 - "Tools"
Cohesion: 0.11
Nodes (24): Pattern: mission skeleton (idle, setup, stages, fail, pass, cleanup), Ideas list: mods the research says are possible, Data-file mod ideas (7), Harder or riskier ideas (4), Script mod ideas (11), Category: missions, heists, new stories, 22 story-mode mod ideas, Update-check tool (+16 more)

### Community 95 - "Open questions: Batch D8"
Cohesion: 0.11
Nodes (24): AI-024: AI profiles of every DLC vehicle (all handling.meta files), AI-025: How SET_DRIVER_ABILITY and _AGGRESSIVENESS change the curve or braking, AI-027: Road nodes and how routes are planned, Batch D8: Every .ymap, .ytyp, .ymf, .ynd, .ynv and scenario..., Driving and AI driving questions (R3.3), Props, archetypes and doors questions (R14.3), Vehicle generators and traffic questions (R4.3), Collision, materials and shape tests questions (R2.1) (+16 more)

### Community 96 - "CAMERA natives used by the game scripts"
Cohesion: 0.08
Nodes (24): AUDIO natives used by the game scripts, GET_SOUND_ID, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CAMERA natives used by the game scripts, CREATE_CAM (+16 more)

### Community 97 - "Server-backed Online screens: Server calls per screen table"
Cohesion: 0.09
Nodes (23): Global_2097536 (leaderboard rows), am_contact_requests, am_pi_menu (interaction menu), appbusinesshub (business computer), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780 (+15 more)

### Community 98 - "GTA Online / Sessions and sync"
Cohesion: 0.09
Nodes (23): GTA Online (folder README), R15.1 Sessions and sync (topic row), R15.2 Rockstar services (topic row), R7.1 freemode inside (topic row), R7.10 Interaction menu, phone and apps (topic row), R7.11 Rockstar Creator internals (topic row), R7.2 Transitions and sessions (topic row), R7.3 Stats, tunables and the server (topic row) (+15 more)

### Community 99 - "CLAUDE.md"
Cohesion: 0.13
Nodes (22): CLAUDE.md: assistant instructions, GTA V PC Legacy build 1.0.3725.0, common.rpf (base data), Count things rule, Decompile commit 'Update for 1.72-3725.0', Decompiled scripts (community decompile), Decompiler names (func_/Global_/Local_), file-rules check (+14 more)

### Community 100 - "Tools and resources"
Cohesion: 0.14
Nodes (22): CodeWalker, Tools and resources, alloc8or's gta5-nativedb-data, Call-graph labeller (awk script), Claude Code, Claude Code skills (game-recon, reverse-engineering ...), CodeWalker (CodeWalker.Core.dll), CodeWalker.Core MetaXml/YmapFile/RpfFile from PowerShell (+14 more)

### Community 101 - "Archive and data file atlas"
Cohesion: 0.12
Nodes (20): Decompile, .ydr drawable, dlc_patch, Archive and data file atlas, 5,290 archives and 389,555 files, 89 DLC packs, .awc audio wave container, common.rpf (+12 more)

### Community 102 - "Load times and stutter"
Cohesion: 0.10
Nodes (22): CPU: population, AI, physics and scripts, Population density as biggest lever, Open questions (CPU), Heavily modded install script load (52 + 61), 15 W laptop throttling, Load times and stutter, First three minutes hold most hitches, Load phases (80 to 107 s) (+14 more)

### Community 103 - "The AI architecture"
Cohesion: 0.12
Nodes (19): The AI architecture, AI layers: perception, events, decisions, relationships, tasks, navigation, motion, LOD, Events interrupt tasks via decision maker; blocked by SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks (+11 more)

### Community 104 - "Text and names in content"
Cohesion: 0.15
Nodes (21): Text and names in content, dlctext.meta (TEXTFILE_METAFILE), gameName (vehicles.meta), GET_LIVERY_NAME, GET_MAKE_NAME_FROM_VEHICLE_MODEL, GET_MOD_TEXT_LABEL, HumanNameHash (weapons.meta), Jenkins one-at-a-time label hashing (+13 more)

### Community 105 - "Missions / Script catalog"
Cohesion: 0.11
Nodes (21): Missions, R0.1, R5.2, R5.4, R5.5, R5.6, R5.8, Script catalog: story mode and shared scripts (+13 more)

### Community 106 - "Online cosmetics and the shops that sell / Open questions"
Cohesion: 0.16
Nodes (21): Online cosmetics and the shops that sell them, Base wardrobe price tables, CLO_MNU block / CSHOP_TITLE labels, clothes_shop_mp, Clothing catalogue (shop.meta, 36,232 items), Interaction menu Appearance page (am_pi_menu), lockHash and IS_CONTENT_ITEM_LOCKED, Online clothing price functions (tunables) (+13 more)

### Community 107 - "Data needs: common.rpf"
Cohesion: 0.14
Nodes (19): AI-034: Crime-info entries and crime points, AI-035: Crime-info entries and crime points, AI-036: Police vehicle sets with model names, Data batch D2: explosion and weapon files, Data batch D4: police and population files, common.rpf (base archive), ENT-021: Story schedule hashes not in popcycle.dat, ENT-025: How bird and fish groups spawn (+11 more)

### Community 108 - "Data needs: vehicles.meta"
Cohesion: 0.14
Nodes (20): Data batch D1: American text blocks and vehicle data files, Data batch D12: remaining text questions, ENT-005: The 13 vehicle maker labels with no text, ENT-006: Mod-part and livery label naming, ENT-036: 901 vs 879 vehicle models, ENT-037: Less common vehicle flags, GP-046: SPMED and SPSMALL handling entries, GP-047: Flight school lesson names (+12 more)

### Community 109 - "Saves / Open questions"
Cohesion: 0.14
Nodes (18): Saves: the story save (R1.7), FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values), Keep mod data in its own file, Save upgrade function in startup, Save version fSaveVersion (1.7), standard_global_reg (+10 more)

### Community 110 - "Player skills and abilities / Open questions"
Cohesion: 0.19
Nodes (20): 100 stat points across seven skills, Player skills and abilities (R3.6), Open question GP-092: ability entries 8-16, peds.ymt AbilityType per model, playerinfo.ymt PlayerStatInfos ranges, playerspecialabilities.ymt (17 entries), Seven character skills (0-100, SP0_/SP1_/SP2_ stats), Skill growth formula (start + bonus + activity score) (+12 more)

### Community 111 - "Open questions: Phase 3"
Cohesion: 0.14
Nodes (20): CORE-031: Which brain set the engine gives the random-ped brains added with..., Inside freemode (first pass) questions (R7.1), Sessions and sync questions (R15.1), Story systems that clash with an Online mode questions (R5.7), GP-054: How many normal and special parent heads each list has, and which..., GTA Online open questions, ON-001: What each of the 183 running-state functions does in detail (this..., ON-002: Names of the 60 network event ids and the main script event hashes (+12 more)

### Community 112 - "Vehicle physics: CHandlingData"
Cohesion: 0.16
Nodes (19): Vehicle physics: handling, damage and upgrades, AIHandling field, carcols.meta statMods (mod-kit upgrades), CHandlingData, Damage multipliers, Handling flag words (model, handling, damage, advanced), Handling memory access (SHVDN Vehicle.HandlingData), handlingId (vehicles.meta) (+11 more)

### Community 113 - "Archives and the content system"
Cohesion: 0.18
Nodes (16): Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins), RPF archives (+8 more)

### Community 114 - "Open questions: Performance open questions"
Cohesion: 0.13
Nodes (17): CORE-026: How TextureQuality values map to the menu, and how much memory each..., Graphics settings, one by one questions (R18.2), Load times and stutter questions (R18.8), Streaming, memory and video memory questions (R18.3), Mod overhead questions (R18.5), PERF-005: The exact menu label for each value of every quality key, PERF-006: What rewrites settings.xml without the player asking (auto-detection..., PERF-007: How much shared memory each texture level takes on integrated graphics (+9 more)

### Community 115 - "Vehicle physics: Sub-handling blocks"
Cohesion: 0.14
Nodes (16): CVehicleWeaponInfo, CAdvancedData, CBikeHandlingData, CBoatHandlingData, CCarHandlingData, CFlyingHandlingData, CSeaPlaneHandlingData, CSpecialFlightHandlingData (+8 more)

### Community 116 - "Story systems that clash with an Online "
Cohesion: 0.16
Nodes (15): R5.7 Systems that clash with Online mode (topic row), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems) (+7 more)

### Community 117 - "DATAFILE natives used by the game script / HUD natives used by the game scripts"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 118 - "Data needs: Data batch D10"
Cohesion: 0.23
Nodes (15): Animpostfx post-effect metadata, Data batch D10: effects and timecycle files, entityfx.dat, materialfx.dat, wheelfx.dat, GP-027: Editor post effects, unnamed post effects, GroupId and EventType, REN-014: entityfx, materialfx and wheelfx rows, REN-015: DLC particle dictionaries in story mode, REN-016: Effect names per particle dictionary, REN-021: Timecycle modifier values and userFlags (+7 more)

### Community 119 - "Story-mode UI / Open questions"
Cohesion: 0.19
Nodes (15): hudcolor.dat colour table, R8.6, Movie method names from ActionScript, Story-mode UI, Character wheel (selector), Completion percent and medal formula, 913-entry mission stat table, SHOW_MISSION_PASSED_MESSAGE parameters (+7 more)

### Community 120 - "Open questions: Phase 2"
Cohesion: 0.20
Nodes (15): CORE-001: Which data file types overlay (merge) and which replace; how..., CORE-013: A PoolManager crash log from the test install names cscenarioinfo at..., CORE-014: Real usage of the busiest pools in a heavy session (turn on..., CORE-015: Memory cost of each raised pool (bytes per slot), CORE-016: The vanilla built-in sizes of the weapon arrays that..., CORE-027: The streaming memory budget (how the engine splits RAM between..., CORE-028: Which SRLs exist (13 names in scripts) and what each covers, CORE-029: Measure a pop-in case: drive fast through the city at LodScale 0 and... (+7 more)

### Community 121 - "Open questions: Phase 4"
Cohesion: 0.20
Nodes (15): Health, armour, death and arrest questions (R3.8), Swimming and diving questions (R3.5), Gameplay open questions, GP-043: How SET_INPUT_EXCLUSIVE and DISABLE_CONTROL_ACTION interact when two..., GP-049: The player's regeneration rate, delay and cap in numbers, GP-050: What exactly changes below the fatigued and hurt thresholds, GP-052: Which personalities each DLC pack adds and their health configs, GP-053: How armour splits damage between armour and health for each damage... (+7 more)

### Community 122 - "Boot and script control: maintransition"
Cohesion: 0.16
Nodes (14): Benchmark boot path, freemode, InGameHud, LOBBY_AUTO_MULTIPLAYER_* flags, selector, SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME, SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE, Force cleanup (+6 more)

### Community 123 - "Health, armour, death and arrest"
Cohesion: 0.22
Nodes (14): Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS, IS_PED_INJURED (903 scripts) (+6 more)

### Community 124 - "Scaleform movies / Open questions"
Cohesion: 0.21
Nodes (14): pausemenu.xml menu description, Scaleform movies, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), DLC movies (mpheist, mpapartment), Scaleform .gfx archives, Interior map movies (int<hash>.gfx), Request-wait-call-draw-release pattern, Mission-passed screen (mission_stat_watcher) (+6 more)

### Community 125 - "Open questions: AI open questions"
Cohesion: 0.15
Nodes (14): AI-001: The full list of task classes the engine has (not only tuned ones), AI-002: Task status values and what each means, measured, AI-003: How primary and secondary task slots are numbered, AI-010: Names of the common combat attributes (50, 17, 53, 52, 46) and config..., AI-012: Cover: how cover points are found and scored, TASK_SEEK_COVER_, AI-014: The full meaning of taskdata.meta and scriptedguntasks.meta, AI-015: Whether the modded events.meta really drops gunfight reactions, in..., AI-031: The three other unnamed shocking events (+6 more)

### Community 126 - "Open questions: Batch D7"
Cohesion: 0.19
Nodes (14): AI-004: The distances where ped AI LOD changes, AI-005: Measured frame time per combat ped on a low-end PC, AI-006: What the second CTask pool (2,100) is for, Batch D7: gameconfig.xml (base and update), a listing of every..., AI cost and level of detail questions (R17.9), FF-001: Reliable sizes per type (audio sizes read as zero), FF-002: A per-pack breakdown for all 89 DLC packs, FF-003: How the update's copies override the base ones, type by type (+6 more)

### Community 127 - "Open questions: Weapons questions"
Cohesion: 0.18
Nodes (14): AI-013: How aim assist and lock-on work for the player, Batch D2: explosion.ymt (update), all 19 explosion.meta (16..., Weapons questions (R3.1), Fire, explosions and projectiles questions (R2.5), GP-076: Which mod installed the weapon overhaul (and the other 93 replaced..., GP-077: The hatchet's extra condition, and whether the Gusenberg really waits..., GP-078: How story stats and Online rank change AmmoMax, GP-079: Explosion damage and radius per explosive (explosion.meta) (+6 more)

### Community 128 - "Open questions: Batch P2.1"
Cohesion: 0.23
Nodes (14): Already answered (story mission table numbers), CORE-017: Meaning of force-cleanup bits 8, 16, 32, 64 and 128, CORE-018: What exactly the engine does to start main, initial and startup, and..., CORE-019: What profiler_registration (global block 2) is and whether anything..., CORE-032: What the engine raises force-cleanup bits 16 and 32 for (no script..., Boot and script control questions (R1.2), Runtime scripts questions (R0.2), Getting started open questions (+6 more)

### Community 129 - "Open questions: Batch D9"
Cohesion: 0.22
Nodes (14): AUD-001: The number of sounds and sound sets in sounds.dat54, AUD-004: Speech archives and voices, AUD-005: The 10 base and many DLC station objects whose names didn't resolve, AUD-006: How a music event maps to moods and tracks, step by step, AUD-007: Which DLC stations are available in story mode in build 3725, AUD-008: The format of a radio track's data (length, markers for the DJ), AUD-009: The list of contexts each voice has, from speech2.dat4.rel, AUD-010: Which block name maps to which mission, for all 331 containers (+6 more)

### Community 130 - "The script VM: FORCE_CLEANUP"
Cohesion: 0.14
Nodes (14): director_mode script, FORCE_CLEANUP, Force cleanup bit 1 (kill ambient and side scripts), Force cleanup bit 128 (director mode ready), Force cleanup bit 16 (engine-raised, pause-resume), Force cleanup bit 2 (story to Online), Force cleanup bit 32 (engine-raised, return from Online), Force cleanup bit 4 (engine-raised) (+6 more)

### Community 131 - "Open questions: Batch D11"
Cohesion: 0.21
Nodes (13): Batch D11: clip_sets.ymt and the DLC clip_sets.xml files..., Animation questions (R13.4), Cameras questions (R13.5), REN-001: The names behind the 22 memory groups and their budget unit, REN-002: Which clip sets the hashed entries are (resolving the 4,526 keys from..., REN-003: Exactly what each TASK_PLAY_ANIM flag bit does (262144 and 16777216..., REN-004: The clip archive layout in DLC packs and how many dictionaries each..., REN-005: The 12 expression dictionaries the update replaced and why (+5 more)

### Community 132 - "Data needs: tools/rpf-cw.ps1"
Cohesion: 0.18
Nodes (11): Data batch D3: water files, Data batch D7: gameconfig.xml and archive listings, FF-002: Per-pack breakdown of the 89 DLC packs, FF-003: How update copies override base ones, PERF-025: Raised physics pools on a low-end PC, PHY-015: The five water quad types, PHY-016: Format of waterheight.dat, tools/rpf-cw.ps1 (CodeWalker extraction) (+3 more)

### Community 133 - "Windows and drivers / Open questions"
Cohesion: 0.18
Nodes (12): Windows and drivers, Background programs as biggest Windows-side cost, Game Bar background recording off, Integrated vs dedicated graphics, Page file and 20 GB free rule, Power plan, power mode and processor max state, Pre-play checklist for a low-end laptop, Windows and drivers questions (R18.6) (+4 more)

### Community 134 - "ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 135 - "Ped physics and ragdoll"
Cohesion: 0.18
Nodes (10): ENT-019: Get-up sets in nm_blend_out_sets.meta, Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file, Ragdoll blocking flags and masks, CTaskNM ragdoll tasks, nm_blend_out_sets.meta (+2 more)

### Community 136 - "Props, archetypes and doors: Archetype"
Cohesion: 0.18
Nodes (11): IPLs (optional map sections), 2D effects (extensions), ACTIVATE_PHYSICS, Archetype, Archetype flag bits, CBaseArchetypeDef, CTimeArchetypeDef, FREEZE_ENTITY_POSITION (+3 more)

### Community 137 - "EXTRAMETADATA natives used by the game s"
Cohesion: 0.18
Nodes (11): DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, restrictionTags, SETUP_SHOP_PED_APPAREL_QUERY_TU, IS_CONTENT_ITEM_LOCKED, EXTRAMETADATA namespace, Roadmap topic R6.3, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG (+3 more)

### Community 138 - "WEAPON natives used by the game scripts"
Cohesion: 0.18
Nodes (11): SET_VEHICLE_DAMAGE_SCALE, WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON (+3 more)

### Community 139 - "Open questions: Random events questions"
Cohesion: 0.18
Nodes (11): Interiors and IPLs questions (R4.5), Random events questions (R4.4), The world open questions, WLD-001: A list of IPL names with the interior or building each one controls, WLD-002: What building_controller swaps, building by building, WLD-003: Which Online interiors work offline with IPLs alone, WLD-008: The event index of each script, and the full character and time rules..., WLD-009: How long each event's cooldown is (+3 more)

### Community 140 - "How Rockstar's scripts drive AI: fm_content_* scripts"
Cohesion: 0.20
Nodes (10): fm_content_* scripts, Open question: mission numbers passed in variables, Patrol route natives, data.Patrol block in fm_content scripts, docks_setup, fm_content_* scripts, Patrol routes (miss_ names, closed loop), TASK_PATROL (+2 more)

### Community 141 - "Online cosmetics and the shops that sell"
Cohesion: 0.24
Nodes (10): GET_TATTOO_SHOP_DLC_ITEM_DATA, shop_tattoo.meta, 32 eye colours, Barber rank locks, Hair fades (hairOverlay decorations), hairdo_shop_mp (barber), shop_controller, Shop table (indices 0 to 64) (+2 more)

### Community 142 - "Open questions: Phase 1"
Cohesion: 0.27
Nodes (10): Text labels questions (R8.3), GP-013: The sea-race labels (SNCA, SSC, SCAA, SCAB) and street-race labels in..., Batch P1.2: Text labels (R8.3), Phase 1: the user interface, UI-002: What the listId draw lists and depths do, UI-016: The full slot list and which systems own which slot, UI-017: How DLC global blocks are merged and which wins on a clash, UI-018: A label-name index (most names are only known by hash) (+2 more)

### Community 143 - "How Rockstar's scripts drive AI: Hostile ped recipe"
Cohesion: 0.22
Nodes (8): Open question: TASK_COMBAT_PED flag values, SET_PED_ACCURACY, SET_PED_COMBAT_ATTRIBUTES, SET_PED_SPHERE_DEFENSIVE_AREA, SET_PED_SUFFERS_CRITICAL_HITS, SET_PED_TARGET_LOSS_RESPONSE, TASK_COMBAT_HATED_TARGETS_IN_AREA, TASK_COMBAT_PED

### Community 144 - "Time, weather and wind: weather.xml"
Cohesion: 0.25
Nodes (7): w_*.xml weather files, 17 weather types, cloudkeyframes.xml, TimeMult, weather.xml, WeatherGpuFx, WeatherTypes

### Community 145 - "Open questions: Batch P4.1"
Cohesion: 0.36
Nodes (9): CORE-020: The story flags that pick the active mission triggerer, CORE-033: What the values of the current mission type (Global_44869 in build..., The story mission flow questions (R5.1), GP-028: The remaining 40-odd command types (blips, contacts, texts, unlocks..., GP-029: The meaning of mission-table field 12 above bit 4, and of the option..., GP-030: How agency_heist2 and Blitz prep 3 are reached, GP-031: The pass and fail labels of each mission command: what happens on a..., GP-032: What the flow integers (f_99.f_58) hold; index 120 is read 1,434 times (+1 more)

### Community 146 - "Open questions: Batch D10"
Cohesion: 0.36
Nodes (9): Batch D10: entityfx.dat, materialfx.dat, wheelfx.dat, every .ypt..., Timecycle and post effects questions (R13.2), REN-021: What the two numbers on each modifier line mean (value and strength?..., REN-022: What userFlags 1, 2, 4, 8 and 16 do, REN-023: The game hours of the 13 keyframes, REN-024: What the 39 unnamed post effects are, and whether anything plays them, REN-026: GroupId and EventType on post effects, REN-027: Meaning of the timecycle modifier userFlags values (0, 2, 1, 16, 4, 8) (+1 more)

### Community 147 - "Open questions: DLC storylines in GTA Online questions"
Cohesion: 0.33
Nodes (9): Batch D12: The American text dump (every block), every..., DLC storylines in GTA Online questions (R7.9), GP-083: The base-wardrobe tables (labels and prices of the non-DLC clothes), ON-014: Which stats each flow keys on, step by step, ON-015: The text of the voice-only flows (XM4V_FLW, S25R_FLW, SR2CH_FLW ...), ON-016: Which update each fm_content_ script arrived in (compare decompile..., ON-017: The flows for After Hours, Doomsday and the 2015 heists (no flow..., ON-018: The mp2025_02 update's name and story (+1 more)

### Community 148 - "The script VM: Compiled script"
Cohesion: 0.22
Nodes (9): YSC reader (needed to settle pointer-only natives), Native tables (native_tables/<script>.txt), R11.2 update check, Native table (rotated hashes), Script arguments copied into statics, START_NEW_SCRIPT_WITH_ARGS, Script statics, Script string table (+1 more)

### Community 149 - "Data needs: pedpersonality.ymt"
Cohesion: 0.46
Nodes (8): AI-011: Personalities, bravery and driving ability, AI-016: Personalities, bravery and driving ability, AI-017: Unnamed civilian bravery and criminality types, AI-019: How MotivationMin/Max is used, AI-020: Driving ranges vs driving tasks, Data batch D5: personality and ped files, ENT-013: Unresolved personality hashes and relationship groups, pedpersonality.ymt (95 personalities)

### Community 150 - "Data needs: Data batch D11"
Cohesion: 0.46
Nodes (7): Data batch D11: animation and camera files, REN-001: The 22 animation memory groups, REN-002: The 4,526 hashed clip set keys, REN-004: Clip archive layout in DLC packs, REN-005: The 12 replaced expression dictionaries, .ycd clip dictionaries, REN-006: Animation memory cost per dictionary

### Community 151 - "Time, weather and wind: respawn_controller"
Cohesion: 0.29
Nodes (7): CLEAR_TIMECYCLE_MODIFIER, respawn_controller, CLEAR_WEATHER_TYPE_PERSIST, Global_4525837, replay_controller, respawn_controller, SET_RANDOM_WEATHER_TYPE

### Community 152 - "DLC natives used by the game scripts / LOBBY natives used by the game scripts"
Cohesion: 0.25
Nodes (8): DLC natives used by the game scripts, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, LOBBY natives used by the game scripts, LOBBY_AUTO_MULTIPLAYER_FREEMODE, LOBBY_SET_AUTO_MULTIPLAYER, LOBBY native namespace: LOBBY natives: auto multiplayer lobby flow

### Community 153 - "FIRE natives used by the game scripts / EVENT natives used by the game scripts"
Cohesion: 0.25
Nodes (8): EVENT natives used by the game scripts, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions, STOP_FIRE_IN_RANGE

### Community 154 - "Handoff: Second pass"
Cohesion: 0.33
Nodes (7): Graph refresh procedure (/graphify . --update), Knowledge graph state (4,716 nodes, PR #132), Leftovers pass (PR #132, research/pass2-leftovers), Tracker status (442 rows: 192 answered), Second pass (answering OPEN_QUESTIONS), Second pass (phases 1 to 4 done), Second-pass priority order (set 2026-10-25)

### Community 155 - "Cookbook: Vehicle traps"
Cohesion: 0.29
Nodes (4): Cookbook: world and map, Pattern: placed scene of props, CREATE_OBJECT, CREATE_MODEL_HIDE, REQUEST_IPL, door system natives, ymap/ytyp additions in DLC pack

### Community 156 - "Open questions: How Rockstar's scripts drive AI question"
Cohesion: 0.29
Nodes (7): AI-041: Where story missions keep enemy spawn tables (positions, triggers)..., AI-042: What hackers' and drivers' stats do in each heist, AI-043: When the crew stat raise is called (every survived heist, or only..., AI-044: The TASK_COMBAT_PED flag values (16, 67108864, 201326592), AI-045: How fm_content_ scripts set up patrols from content data, AI-046: Buddy behaviour in vehicles (driver choice, drive-bys), How Rockstar's scripts drive AI questions (R17.10)

### Community 157 - "Open questions: Cutscenes and dialogue questions"
Cohesion: 0.33
Nodes (7): Cutscenes and dialogue questions (R5.6), GP-005: How many cutscene files ship (.cut in the x64 archives and DLC packs)..., GP-006: Exact meanings of the START_CUTSCENE and REGISTER_ENTITY_FOR_CUTSCENE..., GP-007: The layout of dialogue_handler's request globals (speakers, root..., GP-008: How subtitles are hidden or shown (frontend setting) and how phone..., Batch P1.7: Subtitles and phone-call lines (R5.6 with R8.6), Batch P4.5: Cutscenes and dialogue (R5.6)

### Community 158 - "Open questions: Time, weather and wind questions"
Cohesion: 0.38
Nodes (7): Time, weather and wind questions (R2.6), WLD-013: How long one TimeMult unit lasts, and whether the cycle position is..., WLD-014: Whether wind changes the flight of aircraft, the drift of boats, or..., WLD-015: What the global flag that skips the post-death weather reroll is, and..., WLD-016: How SET_OVERRIDE_WEATHER and the persistent lock interact when both..., WLD-018: The base length of one weather TimeMult unit (not in the file), WLD-019: Whether wind pushes aircraft or boats

### Community 159 - "MISC natives used by the game scripts"
Cohesion: 0.33
Nodes (7): MISC natives used by the game scripts, CLEAR_BIT, IS_PC_VERSION, MISC native namespace: MISC natives: bitwise, random, weather, save registration, platform checks, dispatch, REGISTER_INT_TO_SAVE, SET_BIT, SET_WEATHER_TYPE_OVERTIME_PERSIST

### Community 160 - "The script VM: ScriptHookV"
Cohesion: 0.33
Nodes (6): Natives (script-to-engine interface), ASI loader load chain (dinput8, ScriptHookV), ScriptHookV, Lua (LUA.asi), ScriptTimeoutThreshold (SHVDN, 5,000 ms), ScriptHookVDotNet (SHVDN)

### Community 161 - "Handoff: joaat name hashing"
Cohesion: 0.40
Nodes (6): Workflow: following a native's argument through wrappers, American .gxt2 text dump for label lookup, joaat name hashing, ON-049 price category hashes, Python tracing helpers (kept outside repo), Count vector arguments from the end

### Community 162 - "Music and radio: Music events"
Cohesion: 0.33
Nodes (5): Mood (stem mixes), PREPARE_MUSIC_EVENT, StartTrackAction, Stem mix (8 stems), TRIGGER_MUSIC_EVENT

### Community 163 - "Weapons: Bullet damage model"
Cohesion: 0.33
Nodes (6): Bullet damage model (instant hit), CWeaponInfo, Damage fall-off, Headshot damage modifier, Penetration, WeaponRange

### Community 164 - "Cookbook / weapons.meta and weaponcomponents.meta"
Cohesion: 0.33
Nodes (6): weaponarchetypes.meta, weapons.meta and weaponcomponents.meta, CWeaponInfo / CAmmoInfo definitions, Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta, Pattern: weapon loadout

### Community 165 - "Organisations and businesses / Interaction menu, phone and apps"
Cohesion: 0.33
Nodes (6): appbusinesshub, appsecuroserv, apparcadebusiness, appbunkerbusiness, appsmuggler, Business computer apps (Scaleform)

### Community 166 - "Open questions: Entities open questions"
Cohesion: 0.40
Nodes (6): Ped physics and ragdoll questions (R2.3), ENT-017: Which tuning set is chosen for which weapon and vehicle, and the 3..., ENT-018: Fall damage by height, ENT-019: What nm_blend_out_sets.meta sets for getting up, ENT-020: Where fall damage is set (not in the ragdoll files), Entities open questions

### Community 167 - "Open questions: Particles and decals questions"
Cohesion: 0.33
Nodes (6): Particles and decals questions (R13.3), REN-012: The exact decal limit in build 3725 and what limit patches change, REN-013: How the particle quality setting picks between ptfx, ptfx_hi and..., REN-014: The format of entityfx.dat, materialfx.dat and wheelfx.dat row by row, REN-015: Which DLC dictionaries are mounted in story mode, REN-016: Which effect names each dictionary holds (an index)

### Community 168 - "INTERIOR natives used by the game script"
Cohesion: 0.33
Nodes (6): INTERIOR natives used by the game scripts, DEACTIVATE_INTERIOR_ENTITY_SET, ENABLE_SHADOW_CULL_MODEL_THIS_FRAME, GET_INTERIOR_AT_COORDS_WITH_TYPE, IS_VALID_INTERIOR, INTERIOR native namespace: INTERIOR natives: interior proxies, entity sets, rooms

### Community 169 - "PHYSICS natives used by the game scripts"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 170 - "Runtime scripts / Memory, pools and limits"
Cohesion: 0.50
Nodes (5): ConfigScriptStackSizes, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, Script stack pools, START_NEW_SCRIPT

### Community 171 - "Appearance and clothing / Peds"
Cohesion: 0.40
Nodes (5): Component slots, CPedVariationInfo component .ymt, SET_PED_COMPONENT_VARIATION, Ped component .ymt, SET_PED_COMPONENT_VARIATION

### Community 172 - "Key codes and control IDs"
Cohesion: 0.60
Nodes (5): Key codes and control IDs, FiveM controls list (old numbering above 256), Frontend control IDs 187-217, TrainerV trainerv.ini [KeyBindings], Windows virtual-key codes (keyboard)

### Community 173 - "Cookbook: Pattern"
Cohesion: 0.40
Nodes (5): Cookbook: vehicles and handling, Pattern: add-on car via DLC pack, Driving styles 786603 careful / 786468 rushed, handling.meta, vehicles.meta, carcols.meta, carvariations.meta, Category: vehicle and model add-ons

### Community 174 - "BUILTIN natives used by the game scripts"
Cohesion: 0.40
Nodes (5): BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, TIMESTEP, TO_FLOAT, WAIT

### Community 175 - "MONEY natives used by the game scripts"
Cohesion: 0.40
Nodes (5): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC

### Community 176 - "OBJECT natives used by the game scripts"
Cohesion: 0.40
Nodes (5): CREATE_OBJECT, DELETE_OBJECT, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 177 - "PAD natives used by the game scripts"
Cohesion: 0.40
Nodes (5): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace

### Community 178 - "RECORDING natives used by the game scrip"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 179 - "SCRIPT natives used by the game scripts"
Cohesion: 0.40
Nodes (5): GET_EVENT_DATA, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 180 - "SOCIALCLUB natives used by the game scri"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 181 - "The script VM: Script event queues"
Cohesion: 0.40
Nodes (5): error_listener script, Script event queues (0 AI, 1 network, 2 error), GET_EVENT_DATA, Script event layout (field 0 id, field 1 sender), _SEND_TU_SCRIPT_EVENT_NEW

### Community 182 - "Research roadmap: R4.2 Scenarios and ambient life"
Cohesion: 0.50
Nodes (4): AI-009: Animal models by kind and where they spawn, Open question: animal models by kind and where each spawns, R17.8 Ambient life, R4.2 Scenarios and ambient life

### Community 183 - "Open questions: Ambient life questions"
Cohesion: 0.50
Nodes (4): AI-007: How far from the player ambient peds despawn, AI-008: How peds pick partners for chats, AI-009: The animal models by kind and where each spawns, Ambient life questions (R17.8)

### Community 184 - "ITEMSETS natives used by the game script"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 185 - "REPLAY natives used by the game scripts"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 186 - "SECURITY natives used by the game script"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 187 - "SHAPETEST natives used by the game scrip"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 188 - "AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail"
Cohesion: 0.67
Nodes (3): Open question: distances where ped AI LOD changes, Open question: how far ambient peds despawn, R17.9 AI cost and level of detail

### Community 190 - "UNKNOWN natives used by the game scripts"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

## Ambiguous Edges - Review These
- `camVehicleCustomSettingsMetadata` → `Vehicle physics: handling, damage and upgrades`  [AMBIGUOUS]
  docs/rendering/cameras.md · relation: conceptually_related_to
- `Level 5: network testbed level` → `common:/data/levels/stripped`  [AMBIGUOUS]
  docs/00-getting-started/boot.md · relation: references

## Knowledge Gaps
- **920 isolated node(s):** `buddydeathresponse`, `GET_CAUSE_OF_MOST_RECENT_FORCE_CLEANUP`, `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH`, `NETWORK_SET_SCRIPT_IS_SAFE_FOR_NETWORK_GAME`, `CORE-032` (+915 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 951 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Research roadmap: Large jobs` to `TASK natives used by the game scripts`, `Anatomy of a story mission / Replay, director mode and the Rockstar E`, `Properties in GTA Online`, `Native namespace map`, `Runtime scripts`, `The global variable map`, `Open questions / Rendering, visual settings and LOD`, `Economy and pickups`, `03 Menus and UI`, `Character switching`, `Research tools`, `How audio is organised`, `How GTA Online works`, `Rockstar services`, `Rockstar Creator internals`, `Fire, explosions and projectiles`, `Physics cost`, `Combat and AI`, `GTA V Under the Hood`, `CONTRIBUTING.md`, `The story mission flow`, `Animation`, `Data needs: handling.meta`, `Music and radio: RadioStation object`, `Measuring performance`, `Cameras`, `Boot and script control: startup`, `Completion, autosave and achievements`, `Graphics settings, one by one`, `Timecycle and post effects`, `Text labels`, `Script launch graph`, `Surviving game updates`, `Props, archetypes and doors: Rayfire map objects`, `Minigames and activities / Open questions`, `Time, weather and wind: Game clock`, `Decisions and personalities / Open questions`, `Strangers, freaks and side content`, `The job lobby`, `Interaction menu, phone and apps`, `Collision, materials and shape tests`, `Ambient life`, `Scenarios and ambient life`, `Cutscenes and dialogue`, `Perception and events`, `Server-backed Online screens: The ONLINE tab, 22 entries`, `How Rockstar's scripts drive AI: Crew skill tier`, `Wanted level and police`, `Interiors and IPLs`, `Vehicles`, `Flying`, `Open questions: HUD, colours and blips questions`, `Native usage`, `AI cost and level of detail`, `Relationships and groups`, `Organisations and businesses / Open questions`, `Inside freemode`, `Water and buoyancy`, `Map data`, `Handoff: Scripts-only questions`, `Police and service AI`, `Memory, pools and limits`, `Population`, `Swimming and diving`, `Peds`, `Stats, tunables and the server's role`, `DLC storylines in GTA Online`, `Random events`, `Weapons: AmmoMax six ammo caps`, `Heists in GTA Online / Open questions`, `Speech and dialogue`, `Appearance and clothing`, `Particles and decals`, `UGC mission files`, `Cookbook: Mod map`, `The script VM: The script VM questions`, `Vehicle generators and traffic`, `Driving AI`, `The Online character creator / Open questions`, `Natives as the engine API / 05 Native functions`, `Controls and camera`, `Respawn, death and arrest / Open questions`, `Transitions and sessions / Open questions`, `Tools`, `GTA Online / Sessions and sync`, `CLAUDE.md`, `Archive and data file atlas`, `Load times and stutter`, `The AI architecture`, `Text and names in content`, `Missions / Script catalog`, `Online cosmetics and the shops that sell / Open questions`, `Saves / Open questions`, `Player skills and abilities / Open questions`, `Vehicle physics: CHandlingData`, `Archives and the content system`, `Story systems that clash with an Online `, `Story-mode UI / Open questions`, `Health, armour, death and arrest`, `Scaleform movies / Open questions`, `Windows and drivers / Open questions`, `Ped physics and ragdoll`, `Open questions: Phase 1`, `Handoff: Second pass`, `Research roadmap: R4.2 Scenarios and ambient life`, `AI cost and level of detail / Ambient life: R17.9 AI cost and level of detail`?**
  _High betweenness centrality (0.346) - this node is a cross-community bridge._
- **What connects `buddydeathresponse`, `GET_CAUSE_OF_MOST_RECENT_FORCE_CLEANUP`, `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH` to the rest of the system?**
  _920 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `TASK natives used by the game scripts` be split into smaller, more focused modules?**
  _Cohesion score 0.0519311911716975 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `03 Menus and UI` to `TASK natives used by the game scripts`, `Anatomy of a story mission / Replay, director mode and the Rockstar E`, `The global variable map`, `Open questions / Rendering, visual settings and LOD`, `Economy and pickups`, `Character switching`, `Research tools`, `How audio is organised`, `Rockstar Creator internals`, `Fire, explosions and projectiles`, `Physics cost`, `Combat and AI`, `GTA V Under the Hood`, `CONTRIBUTING.md`, `The story mission flow`, `Animation`, `Music and radio: RadioStation object`, `Completion, autosave and achievements`, `Graphics settings, one by one`, `Timecycle and post effects`, `Text labels`, `Script launch graph`, `Surviving game updates`, `Props, archetypes and doors: Rayfire map objects`, `Minigames and activities / Open questions`, `Time, weather and wind: Game clock`, `Decisions and personalities / Open questions`, `Strangers, freaks and side content`, `The job lobby`, `Collision, materials and shape tests`, `Ambient life`, `Scenarios and ambient life`, `Cutscenes and dialogue`, `Perception and events`, `How Rockstar's scripts drive AI: Crew skill tier`, `Wanted level and police`, `Interiors and IPLs`, `Vehicles`, `Flying`, `Open questions: HUD, colours and blips questions`, `Relationships and groups`, `Water and buoyancy`, `Map data`, `Police and service AI`, `Memory, pools and limits`, `Population`, `Swimming and diving`, `Peds`, `DLC storylines in GTA Online`, `Weapons: AmmoMax six ammo caps`, `7. Your first C++`, `Speech and dialogue`, `Appearance and clothing`, `Particles and decals`, `UGC mission files`, `Cookbook: Mod map`, `The script VM: The script VM questions`, `Vehicle generators and traffic`, `Glossary`, `Driving AI`, `Natives as the engine API / 05 Native functions`, `Controls and camera`, `Respawn, death and arrest / Open questions`, `Tools`, `Tools and resources`, `Archive and data file atlas`, `The AI architecture`, `Text and names in content`, `Missions / Script catalog`, `Saves / Open questions`, `Player skills and abilities / Open questions`, `Vehicle physics: CHandlingData`, `Archives and the content system`, `Story-mode UI / Open questions`, `Health, armour, death and arrest`, `Scaleform movies / Open questions`, `Ped physics and ragdoll`, `Cookbook: Vehicle traps`, `Cookbook / weapons.meta and weaponcomponents.meta`, `Key codes and control IDs`, `Cookbook: Pattern`, `Cookbook / DLC storylines in GTA Online`?**
  _High betweenness centrality (0.128) - this node is a cross-community bridge._
- **Should `Anatomy of a story mission / Replay, director mode and the Rockstar E` be split into smaller, more focused modules?**
  _Cohesion score 0.05160662122687439 - nodes in this community are weakly interconnected._

### Low-confidence Hints
_AMBIGUOUS edges — the extractor was unsure. Verify before acting on these._

- **What is the exact relationship between `camVehicleCustomSettingsMetadata` and `Vehicle physics: handling, damage and upgrades`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **What is the exact relationship between `Level 5: network testbed level` and `common:/data/levels/stripped`?**
  _Edge tagged AMBIGUOUS (relation: references) - confidence is low._