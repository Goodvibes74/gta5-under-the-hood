# Graph Report - gta5-under-the-hood  (2026-11-04)

## Corpus Check
- 80 files · ~496,717 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 4716 nodes · 10010 edges · 193 communities (186 shown, 7 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 655 edges (avg confidence: 0.85)
- Token cost: 1,719,560 input · 0 output

## Community Hubs (Navigation)
- Handoff: Scripts-only leftovers
- Runtime scripts
- Rockstar Creator internals
- Native namespace map
- Properties in GTA Online
- Data needs: tools/rpf-cw.ps1
- The global variable map
- Server-backed Online screens
- Economy and pickups
- Mod map
- The script VM
- Research tools
- Props, archetypes and doors
- Native usage
- Open questions: Phase 1
- Rockstar services
- Music and radio
- How Rockstar's scripts drive AI: Hostile ped recipe
- Fire, explosions and projectiles
- Physics cost
- Open questions / Respawn, death and arrest
- Research roadmap
- Online cosmetics and the shops that sell: clothes_shop_mp
- CONTRIBUTING.md
- Weapons
- The job lobby
- Interaction menu, phone and apps
- Measuring performance
- Minigames and activities
- DLC storylines in GTA Online
- Ambient life
- Interiors and IPLs
- The story mission flow
- GTA Online
- Script launch graph
- Police and service AI
- Memory, pools and limits
- Appearance and clothing
- Anatomy of a story mission
- Time, weather and wind: Game clock
- Cameras
- AI cost and level of detail
- Controls and camera
- Cutscenes and dialogue
- Collision, materials and shape tests
- Animation: Clip sets
- Timecycle and post effects
- How audio is organised
- Population
- Boot and script control: initial script
- Perception and events
- Relationships and groups
- Vehicle generators and traffic
- Scenarios and ambient life
- CPU
- Particles and decals
- Map data
- Glossary / The AI architecture
- Speech and dialogue
- Random events
- Wanted level and police
- Completion, autosave and achievements
- Peds
- Strangers, freaks and side content
- Inside freemode
- Stats, tunables and the server's role
- 5. Your first C# mod
- Native usage index
- VEHICLE natives used by the game scripts
- Swimming and diving
- Decisions and personalities
- Archive and data file atlas / Open questions
- Vehicles
- Flying
- PED natives used by the game scripts
- GTA natives used by the game scripts
- Heists in GTA Online / Open questions
- NETWORK natives used by the game scripts
- Data needs: Data batch D8
- Open questions: Performance open questions
- GTA V Under the Hood
- Navigation and pathfinding
- Replay, director mode and the Rockstar E
- UGC mission files
- 02 Scripting with ScriptHookVDotNet v3
- PLAYER natives used by the game scripts
- STATS natives used by the game scripts
- TASK natives used by the game scripts
- 02_PlayerAndWorld.cs
- Data needs: Data rows never attempted
- Research roadmap / Surviving game updates guide
- Open questions: Streaming, memory and video memo
- Rendering, visual settings and LOD
- Saves
- Transitions and sessions / Open questions
- Archives and the content system
- Streaming
- Water and buoyancy
- Open questions: Gameplay open questions
- Driving and AI driving
- Driving AI
- Text and names in content
- Character switching
- The Online character creator / Open questions
- Vehicle physics
- Natives as the engine API / 05 Native functions
- CLAUDE.md
- Data needs: vehicles.meta
- Tools
- Boot and script control: MainTransition
- Missions / Script catalog
- Organisations and businesses: VIP and MC challenges
- file-rules.yml
- Open questions: AI open questions
- AUDIO natives used by the game scripts / CAMERA natives used by the game scripts
- Tools and resources: CodeWalker
- Open questions / Boot and script control
- Combat and AI
- Organisations and businesses: Business computer apps
- Open questions: Leftovers
- Open questions: GTA Online open questions
- Open questions: Collision, materials and shape t
- Data needs: Data batch D9
- Story systems that clash with an Online 
- DATAFILE natives used by the game script / HUD natives used by the game scripts
- Data needs: Data batch D10
- Organisations and businesses: Business loop
- Organisations and businesses: Organisation rules
- Open questions: Batch D10
- WEAPON natives used by the game scripts / ZONE natives used by the game scripts
- Text labels / Open questions
- Scaleform movies / Open questions
- Open questions: How audio is organised questions
- Open questions: Runtime scripts questions
- Open questions: Batch P4.10
- DLC natives used by the game scripts / EXTRAMETADATA natives used by the game s
- Player skills and abilities
- Organisations and businesses: Nightclub safe and warehouse
- Open questions: Batch D11
- ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip
- Ped physics and ragdoll
- Online cosmetics and the shops that sell: shop_controller script
- Open questions: Organisations and businesses que
- Reading the decompiled game scripts
- Data needs: pedpersonality.ymt
- Time, weather and wind: weather.xml
- Open questions: Driving and AI driving questions
- Open questions: Character switching questions
- Open questions: Minigames and activities questio
- FIRE natives used by the game scripts / EVENT natives used by the game scripts
- Open questions: Ped physics and ragdoll question
- Time, weather and wind: respawn_controller
- Open questions: AI cost and level of detail ques
- Open questions: Time, weather and wind questions
- BUILTIN natives used by the game scripts / BRAIN natives used by the game scripts
- Boot and script control: Level index 5
- How Rockstar's scripts drive AI: Patrol routes
- The story mission flow / Completion, autosave and achievements
- Organisations and businesses: Event-type to script table
- Cookbook
- Open questions: The story mission flow questions
- MISC natives used by the game scripts
- Handoff: PERF-025
- Animation: Clip dictionaries
- config.yml
- Open questions: Strangers, freaks and side conte
- GRAPHICS natives used by the game script
- INTERIOR natives used by the game script
- PATH natives used by the game scripts
- PHYSICS natives used by the game scripts
- SCRIPT natives used by the game scripts
- Appearance and clothing / Peds
- Open questions: Appearance and clothing question
- Open questions: Vehicles questions
- Open questions: Online cosmetics and the shops t
- MONEY natives used by the game scripts
- OBJECT natives used by the game scripts
- RECORDING natives used by the game scrip
- SOCIALCLUB natives used by the game scri
- WATER natives used by the game scripts
- How Rockstar's scripts drive AI: CAN_PED_SEE_HATED_PED
- ITEMSETS natives used by the game script
- LOCALIZATION natives used by the game sc
- REPLAY natives used by the game scripts
- SECURITY natives used by the game script
- SHAPETEST natives used by the game scrip
- AI cost and level of detail / Ambient life
- Boot and script control: landing_pre_startup
- Tools and resources: Call-graph labeller
- Surviving game updates guide

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 245 edges
2. `Data needs: open questions that need game files` - 192 edges
3. `Native namespace map` - 142 edges
4. `Mod map: what to read for the mod you want to make` - 113 edges
5. `Organisations and businesses` - 110 edges
6. `Runtime scripts: the scripts that keep the game running` - 99 edges
7. `Native usage: which scripts call which natives` - 95 edges
8. `Rockstar Creator internals` - 94 edges
9. `Handoff: current status and what to do next` - 92 edges
10. `Tools` - 87 edges

## Surprising Connections (you probably didn't know these)
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `Workflow: following native arguments through wrappers` --semantically_similar_to--> `Decompiler vs NativeDB name aliases`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → scripting/native-usage.md
- `Open question: animal models by kind and where each spawns` --semantically_similar_to--> `AI-009: Animal models by kind and where they spawn`  [INFERRED] [semantically similar]
  docs/ai/ambient-life.md → DATA-NEEDS.md
- `Five rules every page assumes` --semantically_similar_to--> `Rules in every language (yield, natives over memory, clean up)`  [INFERRED] [semantically similar]
  modding/cookbook/README.md → scripting/languages.md
- `Inbox issue template (found a system no topic covers)` --semantically_similar_to--> `Inbox issues for uncovered findings`  [INFERRED] [semantically similar]
  .github/ISSUE_TEMPLATE/inbox.md → ROADMAP.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Autosave request flow (request, controller, refusal, DO_AUTO_SAVE)** — docs_core_completion_and_autosave_autosave_requesters, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_autosave_refusal, docs_core_completion_and_autosave_do_auto_save [EXTRACTED 1.00]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Three scripts that force strand 27 active for a new game** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Creator slider to saved stat pipeline** — docs_gameplay_player_online_character_creator_micro_morph_map, docs_gameplay_player_online_character_creator_heritage, docs_gameplay_player_online_character_creator_slider_to_stat, docs_gameplay_player_online_character_creator_mpstatssetup [EXTRACTED 1.00]
- **Scripted conversation request pipeline** — docs_gameplay_missions_cutscenes_and_dialogue_dialogue_request_globals, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler, docs_gameplay_missions_cutscenes_and_dialogue_dialogue_handler_states, docs_gameplay_missions_cutscenes_and_dialogue_conversation_root_labels, docs_gameplay_missions_cutscenes_and_dialogue_create_new_scripted_conversation [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Strand 27 activated in standard_global_reg, initial and flow_controller** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Skill system data flow** — docs_gameplay_player_skills_and_abilities_spstatssetup_xml, docs_gameplay_player_skills_and_abilities_playerinfo_ymt, docs_gameplay_player_skills_and_abilities_stats_controller, docs_gameplay_player_skills_and_abilities_seven_skills, docs_gameplay_player_skills_and_abilities_skill_growth_formula [EXTRACTED 1.00]
- **Story death/arrest restart flow** — docs_gameplay_player_respawn_death_and_arrest_standard_global_init, docs_gameplay_player_respawn_death_and_arrest_hospital_restarts, docs_gameplay_player_respawn_death_and_arrest_police_restarts, docs_gameplay_player_respawn_death_and_arrest_respawn_controller, docs_gameplay_player_respawn_death_and_arrest_death_fee, docs_gameplay_player_respawn_death_and_arrest_arrest_penalty, docs_gameplay_player_respawn_death_and_arrest_respawn_resets, docs_gameplay_player_respawn_death_and_arrest_pause_death_arrest_restart [EXTRACTED 1.00]
- **Story unlock pipeline: build, run and gate strands** — docs_gameplay_missions_story_flow_initial, docs_gameplay_missions_story_flow_flow_program, docs_gameplay_missions_story_flow_flow_controller, docs_gameplay_missions_story_flow_flow_strands, docs_gameplay_missions_story_flow_flow_flags, docs_gameplay_missions_story_flow_mission_triggerers [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules, _github_workflows_file_rules_file_rules_check [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **How the story save is registered and written** — docs_core_saves_standard_global_reg, docs_core_saves_story_save_global, docs_core_completion_and_autosave_autosave_request, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_do_auto_save, docs_core_completion_and_autosave_save_anywhere [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]
- **Mission set-piece crowd control** — docs_ai_ambient_life_clear_area_of_peds, docs_ai_ambient_life_set_ped_density_multiplier_this_frame, docs_ai_ambient_life_set_ped_non_creation_area, docs_ai_ambient_life_set_ped_model_is_suppressed, docs_ai_ambient_life_set_scenario_type_enabled, docs_ai_ambient_life_task_wander_standard [EXTRACTED 1.00]
- **How the engine keeps AI affordable** — docs_ai_ai_cost_and_lod_maxtotalpeds, docs_ai_ai_cost_and_lod_vehicletimeslicemaxupdatesperframe, docs_ai_ai_cost_and_lod_ctaskmotionbasiclocomotionlowlod, docs_ai_ai_cost_and_lod_dummy_vehicles, docs_ai_ai_cost_and_lod_timeslicing [INFERRED 0.85]
- **Answering a question: guide row, tracker row, DATA-NEEDS tag** — handoff_rule_answering_question, open_questions, data_needs, handoff_tracker_442_rows [EXTRACTED 1.00]
- **Ped decision pipeline: personality, bravery, decision maker, combat info** — docs_ai_decisions_and_personalities_ped_personalities, docs_ai_decisions_and_personalities_bravery_types, docs_ai_decisions_and_personalities_decision_makers, docs_ai_decisions_and_personalities_combatbehaviour_meta, docs_ai_decisions_and_personalities_ped_decision_flow [EXTRACTED 1.00]
- **Crime to stars to dispatch: witness reporting, crime points, dispatch responses and search** — docs_ai_perception_and_events_cancallpolice, docs_ai_police_and_services_wantedlevelthresholds, docs_ai_police_and_services_wantedresponses, docs_ai_police_and_services_search_helpers, docs_ai_police_and_services_wantedtuning_ymt [INFERRED 0.85]
- **Hostile ped recipe: side, attributes, accuracy, defensive area, task, events blocked, keep task** — docs_ai_relationships_and_groups_set_ped_relationship_group_hash, docs_ai_script_ai_patterns_set_ped_combat_attributes, docs_ai_script_ai_patterns_set_ped_accuracy, docs_ai_script_ai_patterns_set_ped_sphere_defensive_area, docs_ai_script_ai_patterns_task_combat_ped, docs_ai_perception_and_events_set_blocking_of_non_temporary_events, docs_ai_perception_and_events_set_ped_keep_task [EXTRACTED 1.00]
- **Music event playback chain** — docs_audio_music_and_radio_trigger_music_event, docs_audio_music_and_radio_music_events, docs_audio_music_and_radio_starttrackaction, docs_audio_music_and_radio_mood, docs_audio_music_and_radio_stem_mix [EXTRACTED 1.00]
- **Freemode player broadcast blocks** — docs_core_global_map_global_1845250, docs_core_global_map_global_2658291, docs_core_global_map_global_1892653, docs_core_global_map_network_register_player_broadcast_variables, docs_core_global_map_freemode [EXTRACTED 1.00]
- **Pool and limit adjuster plugins** — docs_core_memory_and_pools_heapadjuster, docs_core_memory_and_pools_packfilelimitadjuster, docs_core_memory_and_pools_weaponlimitsadjuster, docs_core_memory_and_pools_decalslimit_patch, docs_core_memory_and_pools_poolmanager [EXTRACTED 1.00]
- **Population spawn data pipeline** — docs_entities_spawning_population_popzone_ipl, docs_ai_police_and_services_zonebind_ymt, docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_population_popgroups_ymt [EXTRACTED 1.00]
- **Add-on vehicle data files** — docs_entities_vehicles_vehicles_vehicles_meta, docs_entities_vehicles_vehicles_handling_meta, docs_entities_vehicles_vehicles_carvariations, docs_entities_vehicles_vehicles_carcols, docs_entities_vehicles_vehicles_vehicle_metadata_file [EXTRACTED 1.00]
- **DLC name registration** — docs_entities_objects_text_and_names_global_gxt2, docs_entities_objects_text_and_names_dlctext_meta, docs_entities_objects_text_and_names_textfile_metafile, docs_entities_objects_text_and_names_americandlc_rpf [EXTRACTED 1.00]
- **Story mission fail, retry and replay flow** — docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_replay_controller, docs_gameplay_missions_mission_anatomy_flow_controller, docs_gameplay_missions_mission_anatomy_retry_screen_states, docs_gameplay_missions_mission_anatomy_player_snapshot, docs_gameplay_missions_mission_anatomy_skip_section [EXTRACTED 1.00]
- **Activity launch pipeline: brain, launcher, candidate slot, activity** — docs_gameplay_missions_strangers_and_freaks_world_point_brains, docs_gameplay_missions_strangers_and_freaks_launcher_scripts, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_minigames_and_activities_mission_candidate, docs_gameplay_missions_minigames_and_activities_activity_unlock_bit [INFERRED 0.85]
- **Character switch pipeline** — docs_gameplay_player_character_switching_selector, docs_gameplay_player_character_switching_player_controller_b, docs_gameplay_player_character_switching_start_player_switch, docs_gameplay_player_character_switching_change_player_ped, docs_gameplay_player_character_switching_player_timetable_scene, docs_gameplay_player_character_switching_arrival_scene_picker [EXTRACTED 1.00]
- **shop_controller launches the cosmetic shop scripts** — docs_gameplay_player_online_cosmetic_shops_shop_controller, docs_gameplay_player_online_cosmetic_shops_hairdo_shop_mp, docs_gameplay_player_online_cosmetic_shops_clothes_shop_mp, docs_gameplay_player_online_cosmetic_shops_tattoo_shop [EXTRACTED 1.00]
- **Creator flow from hub to published race** — docs_online_creator_internals_creator, docs_online_creator_internals_fm_main_menu, docs_online_creator_internals_fm_race_creator, docs_online_creator_internals_ugc_create_mission, docs_online_creator_internals_fm_race_controler [EXTRACTED 1.00]
- **freemode player and host state machines on broadcast data** — docs_online_07_freemode_player_state_machine, docs_online_07_freemode_host_state_machine, docs_online_07_freemode_global_2658291, docs_online_07_freemode_global_2649159, docs_online_07_freemode_host_participant_rotation [EXTRACTED 1.00]
- **Job launch pipeline: corona to controller** — docs_online_heists_fmmc_launcher, docs_online_job_lobby_activity_table, scripting_native_usage_builtin_start_new_script_with_args, docs_online_job_lobby_start_argument_block, docs_online_heists_fm_mission_controller [EXTRACTED 1.00]
- **Four heist generations and their planning scripts** — docs_online_heists_classic_planning_board, docs_online_heists_gb_gang_ops_planning, docs_online_heists_gb_casino_heist_planning, docs_online_heists_heist_island_planning [EXTRACTED 1.00]
- **Flow progress storage in stats** — docs_online_dlc_storylines_freemode_story_flow, docs_online_dlc_storylines_stat_7880, docs_online_dlc_storylines_packed_stat_bools, docs_online_dlc_storylines_exec_flw [EXTRACTED 1.00]
- **Business loop: resupply, produce, sell** — docs_online_organisations_and_businesses_gb_illicit_goods_resupply, docs_online_organisations_and_businesses_production_timer, docs_online_organisations_and_businesses_gb_biker_contraband_sell, docs_online_organisations_and_businesses_business_loop [INFERRED 0.85]
- **Property purchase and trade-in flow** — docs_online_properties_price_layers, docs_online_properties_net_gameserver_get_price, docs_online_properties_network_earn_from_property, docs_online_properties_network_buy_property [EXTRACTED 1.00]
- **Rockstar's physics brakes** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_before_after, docs_performance_physics_cost_ragdoll_control, docs_performance_physics_cost_density_per_frame, docs_performance_physics_cost_frame_count_spreading [EXTRACTED 1.00]
- **Material table drives grip, fire and impact effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_collision_and_materials_materialfx_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_wheelfx_dat, docs_rendering_particles_and_decals_mtlfx_table [INFERRED 0.85]
- **Explosion definition: type data, VFX, camera shake and projectiles** — docs_physics_fire_explosions_projectiles_explosion_ymt, docs_physics_fire_explosions_projectiles_explosionfx_dat, docs_rendering_cameras_camera_shakes, docs_physics_fire_explosions_projectiles_weapons_meta_projectile_ammo [EXTRACTED 1.00]
- **Scripted scene: synchronized scene, animated camera, fades** — docs_rendering_animation_synchronized_scenes, docs_rendering_animation_create_synchronized_scene, docs_rendering_cameras_render_script_cams, docs_rendering_cameras_default_animated_camera, docs_rendering_cameras_screen_fades [INFERRED 0.75]
- **Weather to screen look pipeline** — docs_world_time_and_weather_weathercycles, docs_rendering_timecycle_and_post_effects_weather_timecycle, docs_rendering_timecycle_and_post_effects_timecycle_modifiers, docs_rendering_timecycle_and_post_effects_animated_post_effects [INFERRED 0.85]
- **Interior activation flow (IPL, pin, entity set, refresh)** — docs_world_interiors_and_ipls_request_ipl, docs_core_streaming_pin_interior_in_memory, docs_world_interiors_and_ipls_is_interior_ready, docs_world_interiors_and_ipls_activate_interior_entity_set, docs_world_interiors_and_ipls_refresh_interior [EXTRACTED 1.00]
- **Respawn resets weather and look** — docs_world_time_and_weather_respawn_controller, docs_world_time_and_weather_clear_weather_type_persist, docs_world_time_and_weather_set_random_weather_type, docs_rendering_timecycle_and_post_effects_clear_timecycle_modifier, docs_world_time_and_weather_global_4525837 [EXTRACTED 1.00]
- **Story mode launch backbone** — scripting_script_launch_graph_startup, scripting_script_launch_graph_standard_global_reg, scripting_script_launch_graph_main_persistent, scripting_script_launch_graph_main, scripting_script_launch_graph_initial, scripting_script_launch_graph_flow_controller [EXTRACTED 1.00]
- **Native name resolution pipeline** — tools_native_usage, scripting_native_usage_native_tables, scripting_natives_nativedb, scripting_native_usage_decompiler_name_aliases, scripting_native_usage_unk_0x_hash_calls [EXTRACTED 1.00]
- **Mod runtimes beside the script VM** — modding_02_tools_you_need_scripthookv, scripting_script_vm_shvdn, scripting_script_vm_lua_asi, scripting_script_vm_scripttimeoutthreshold [EXTRACTED 1.00]
- **Second-pass priority phases** — open_questions_phase_1, open_questions_phase_2, open_questions_phase_3, open_questions_phase_4, open_questions_leftovers_data_batches [EXTRACTED 1.00]
- **Knowledge graph doc-quality questions** — open_questions_kg_001, open_questions_kg_002, open_questions_kg_003, open_questions_kg_004 [EXTRACTED 1.00]
- **Engine-raised force-cleanup bits questions** — open_questions_core_017, open_questions_core_032, open_questions_on_060, open_questions_scr_011 [INFERRED 0.85]

## Communities (193 total, 7 thin omitted)

### Community 0 - "Handoff: Scripts-only leftovers"
Cohesion: 0.05
Nodes (56): FF-003: How update copies override base ones, Handoff: current status and what to do next, AI-031: hash guesses, low yield, AI-032: flag names, low yield, AI-041: live enemy count, Ask the contributor or community: GP-076, REN-019, ON-053, CORE-009: .f_203 bits and mod shop bits, CORE-021: player_controller's other scenes; launch graph 296 vs 240 (+48 more)

### Community 1 - "Runtime scripts"
Cohesion: 0.05
Nodes (66): comms_controller, ConfigScriptStackSizes, GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE, Runtime scripts: the scripts that keep the game running, achievement_controller, autosave_controller, blip_controller, buddydeathresponse (+58 more)

### Community 2 - "Rockstar Creator internals"
Cohesion: 0.06
Nodes (61): TRANSFORM_TO_SUBMARINE, maintransition, Rockstar Creator internals, CAN_REGISTER_MISSION_OBJECTS, Checkpoint fields (chs, chpp, cpbs1-3), CREATE_MODEL_HIDE / CREATE_MODEL_SWAP, creator (hub script), Creator limits (200 props, 20 dynamic, 40 removed ...) (+53 more)

### Community 3 - "Native namespace map"
Cohesion: 0.04
Nodes (65): SCR-001: Split MISC into sub-families with their own owners, SCR-002: Which natives are reached only through shared helper code..., SCR-003: Which namespaces' unused natives still work in story mode, Native namespace map questions (R0.8), Native namespace map, 54 natives only in indirect-call code, Call_Loc indirect calls, DISABLE_CONTROL_ACTION (+57 more)

### Community 4 - "Properties in GTA Online"
Cohesion: 0.06
Nodes (65): Properties in GTA Online, ADD_BLIP_FOR_COORD, AM_MP_ARCADE, AM_MP_BUNKER, AM_MP_FIXER_HQ, AM_MP_HANGAR, AM_MP_NIGHTCLUB, AM_MP_PEDS (+57 more)

### Community 5 - "Data needs: tools/rpf-cw.ps1"
Cohesion: 0.07
Nodes (57): Data needs: open questions that need game files, AI-014: Meaning of taskdata.meta and scriptedguntasks.meta, AI-034: Crime-info entries and crime points, AI-035: Crime-info entries and crime points, AI-036: Police vehicle sets with model names, Data batch D11: animation and camera files, Data batch D2: explosion and weapon files, Data batch D3: water files (+49 more)

### Community 6 - "The global variable map"
Cohesion: 0.05
Nodes (55): The global variable map, Blocks 13 and 15 (dead code), GlobalplayerBD .f_204 / .f_203 flag words, GPBD_FM .f_260 (stat-backed state), GlobalplayerBD .f_325 (interior the player is in), freemode, Global_102429 (replay controller state), Global_102481 (shop data) (+47 more)

### Community 7 - "Server-backed Online screens"
Cohesion: 0.05
Nodes (55): Global_2097536 (leaderboard rows), Server-backed Online screens (R8.5), am_contact_requests, am_pi_menu (interaction menu), appbusinesshub (business computer), appinternet (in-game websites), appmpemail (Online email), appmpjoblistnew (phone job list) (+47 more)

### Community 8 - "Economy and pickups"
Cohesion: 0.06
Nodes (55): Economy and pickups, ADD_PICKUP_TO_INTERIOR_ROOM_BY_NAME, atm_trigger, BAWSAQ exchange, BSS_BSTR company labels, code_controller, Collectable scripts, CPickupData (+47 more)

### Community 9 - "Mod map"
Cohesion: 0.05
Nodes (44): weapons.meta and weaponcomponents.meta, CWeaponInfo / CAmmoInfo definitions, Cookbook: audio, .awc containers plus .dat*.rel config, Pattern: looping alarm, PLAY_SOUND_FRONTEND / GET_SOUND_ID / START_AUDIO_SCENE natives, Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME (+36 more)

### Community 10 - "The script VM"
Cohesion: 0.06
Nodes (50): Stale anchor fixed in scripting/script-vm.md, ASI loader load chain (dinput8, ScriptHookV), ScriptHookV, ScriptHookV SDK, R1.1 The script VM, The script VM, director_mode script, error_listener script (+42 more)

### Community 11 - "Research tools"
Cohesion: 0.05
Nodes (50): Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, ASI, ScriptHookV, ScriptHookVDotNet, Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder (+42 more)

### Community 12 - "Props, archetypes and doors"
Cohesion: 0.06
Nodes (52): IPLs (optional map sections), Props, archetypes and doors, 2D effects (extensions), ACTIVATE_PHYSICS, ADD_DOOR_TO_SYSTEM, Archetype, Archetype flag bits, Door auto-open flags (+44 more)

### Community 13 - "Native usage"
Cohesion: 0.06
Nodes (47): Contributed tools and resources table, Workflow: grouping DISABLE_CONTROL_ACTION runs, Workflow: pricing shop items from tuneables_processing, Workflow: following native arguments through wrappers, update-check.ps1 tool, SCR-004: What 0x8F5D1AD832AEB06C and 0x0F7082C60FB479EF do, SCR-005: Whether the 29 "build 3889" natives exist in 3725, SCR-006: A story-only vs Online-only split of every native (+39 more)

### Community 14 - "Open questions: Phase 1"
Cohesion: 0.06
Nodes (49): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, Pause and Online menus (+41 more)

### Community 15 - "Rockstar services"
Cohesion: 0.07
Nodes (47): GET_CLOUD_TIME_AS_INT, Rockstar services, Catalogue keys (<name>_t<type>_v<version>), CATEGORY_VEHICLE_MOD, CATEGORY_WAREHOUSE_INTERIOR, Cloud files, Cloud stat slots, Crews (NETWORK_CLAN_*) (+39 more)

### Community 16 - "Music and radio"
Cohesion: 0.06
Nodes (43): Music and radio, AUDIO_GAMEDATA content.xml entries, AUDIO_IS_SCRIPTED_MUSIC_PLAYING, .awc wave containers, CANCEL_MUSIC_EVENT, FM_COUNTDOWN_30S music event, fm_mission_controller, game.dat151.rel (audio game data) (+35 more)

### Community 17 - "How Rockstar's scripts drive AI: Hostile ped recipe"
Cohesion: 0.08
Nodes (43): SET_PED_KEEP_TASK, How Rockstar's scripts drive AI, agency_heist3a, agency_heist3b, am_casino_peds, am_mp_peds, Buddies join the player's group, Crew skill tier (0, 1, 2) (+35 more)

### Community 18 - "Fire, explosions and projectiles"
Cohesion: 0.08
Nodes (41): Fire, explosions and projectiles, ADD_EXPLOSION, ADD_OWNED_EXPLOSION, bAppliesContinuousDamage, bForceNonTimedVfx, bIsSmokeGrenade, bSuppressCrime, CAmmoProjectileInfo (+33 more)

### Community 19 - "Physics cost"
Cohesion: 0.08
Nodes (39): Physics cost, ACTIVATE_PHYSICS, ADD_EXPLOSION, ADD_ROPE, CLEAR_AREA, CLEAR_AREA_OF_OBJECTS, CLEAR_AREA_OF_PROJECTILES, CLEAR_AREA_OF_VEHICLES (+31 more)

### Community 20 - "Open questions / Respawn, death and arrest"
Cohesion: 0.09
Nodes (43): PP_INFO_STRUCT (per-character save), Health, armour, death and arrest (R3.8), Armour pool and Ammu-Nation percentages (20-100%), DLC pedpersonality.meta files (holster data only), gunclub_shop, Health floor of 100 (injured/dying threshold), Health regeneration (to 150 of 200), SET_ENTITY_INVINCIBLE / SET_ENTITY_PROOFS (+35 more)

### Community 21 - "Research roadmap"
Cohesion: 0.09
Nodes (40): Issue template: Inbox, Inbox issue template (found a system no topic covers), The player, R6.5 Online character creator, Large jobs (priority) list: 13 jobs, Research roadmap, Good first topics, Inbox issues for uncovered findings (+32 more)

### Community 22 - "Online cosmetics and the shops that sell: clothes_shop_mp"
Cohesion: 0.10
Nodes (36): Online cosmetics and the shops that sell them, am_pi_menu (interaction menu), Barber chair animations and camera, Barber rank locks (HAIR_UNLOCK), Base wardrobe price tables (77 functions, 3,541 entries), CHAR_FM_STORED_HAIRDO stat, CHAR_HAIR_UNLCK stats, CLO_MNU text block (clo_mnu.gxt2) (+28 more)

### Community 23 - "CONTRIBUTING.md"
Cohesion: 0.07
Nodes (34): Issue template: Claim a research topic, Claim a research topic issue template, Pull request template, Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Branch naming (research/<ID>-pass2-<what> ...), Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging (+26 more)

### Community 24 - "Weapons"
Cohesion: 0.08
Nodes (35): WeaponLimitsAdjuster, HumanNameHash, Weapons (folder README), R2.5 Fire, explosions and projectiles (topic row), R3.1 Weapons (topic row), Weapons, CAimingInfo (16 aiming profiles), CAmmoInfo (ammo types) (+27 more)

### Community 25 - "The job lobby"
Cohesion: 0.09
Nodes (39): Classic apartment planning board (heist_mp, heistmap_mp, heist_pre), DRAW_SCALEFORM_MOVIE_3D_SOLID, fm_mission_controller / _2020, fmmc_launcher, appMPJobListNEW, The job lobby (fmmc_launcher), The corona (lobby screens), Corona settings path (GPBD_FM_2 to Global_2685150.f_669) (+31 more)

### Community 26 - "Interaction menu, phone and apps"
Cohesion: 0.09
Nodes (38): Interaction menu, phone and apps, am_contact_requests (contact services), am_pi_menu (interaction menu), appbusinesshub, appContacts, appHackerDen (Darnell Inc.), appInternet, AppJIPMP (Quick Join) (+30 more)

### Community 27 - "Measuring performance"
Cohesion: 0.08
Nodes (34): Measuring performance, ARE_ANY_CCS_PENDING, -benchmark command-line switches, benchmark script, Benchmark 8-state loop, BMARK text block, Content change sets (GROUP_ON_DEMAND, 43 packs), CPU-bound vs GPU-bound test (+26 more)

### Community 28 - "Minigames and activities"
Cohesion: 0.09
Nodes (33): Minigames and activities, Activity list (ids 0 to 18), am_mp_arc_cab_manager (Online arcade), bj (base jumps), CAN_PLAYER_START_MISSION, code_controller, controller_ambientarea, controller_taxi / taxi_procedural (+25 more)

### Community 29 - "DLC storylines in GTA Online"
Cohesion: 0.10
Nodes (38): DLC storylines in GTA Online, AW_FLOW flow (Arena War), BATFMAU After Hours call block (143 roots), BT24_FLOW flow (Bottom Dollar), CH_FLOW flow (Casino Heist), dlclist.xml, EXEC_FLW flow, FIX_FLOW flow (The Contract) (+30 more)

### Community 30 - "Ambient life"
Cohesion: 0.11
Nodes (36): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, Ambient life, Ambient ped task loop (Known), Animals: 41 ped models of type animal, CAmbientLookAt (scan 15 m, look 2 s), TASK_CHAT_TO_PED callers: taxi_gotyounow, taxi_clowncar, nigel2, franklin0, re_stag_do, CLEAR_AREA_OF_PEDS (456 scripts), CTaskAmbientClips (idle every 4 s, 40 s after gunshot) (+28 more)

### Community 31 - "Interiors and IPLs"
Cohesion: 0.08
Nodes (35): PIN_INTERIOR_IN_MEMORY, CMloArchetypeDef, Interiors and IPLs, ACTIVATE_INTERIOR_ENTITY_SET, building_controller, CAP_INTERIOR, CMloInstanceDef, DISABLE_INTERIOR (+27 more)

### Community 32 - "The story mission flow"
Cohesion: 0.10
Nodes (37): R5.1, The story mission flow: how missions unlock, Activate strand command, Activate stranger mission command, agency_heist2 special builder, code_controller, What a fail does to the flow (pass/fail labels), Blitz Play prep 3 (fbi4_prep3, never activated) (+29 more)

### Community 33 - "GTA Online"
Cohesion: 0.06
Nodes (38): How GTA Online works, Online stats in mpstatssetup.xml (17,933), Network session and broadcast data, Script VM, natives, globals, What depends on Rockstar servers, Server transactions for money, Cloud tunables, UGC cloud content and local files (+30 more)

### Community 34 - "Script launch graph"
Cohesion: 0.11
Nodes (38): R0.5 Script launch graph, Script launch graph (build 3725), am_mp_drone script, buddydeathresponse script, cellphone_controller script, cellphone_flashhand script, creator script, director_mode script (+30 more)

### Community 35 - "Police and service AI"
Cohesion: 0.09
Nodes (36): SET_POLICE_IGNORE_PLAYER, Police and service AI, Assassins dispatch type, Crime-info entries (9, CRIME_KILL_COP weight 5), CRIME_KILL_COP, dispatch.meta, Dispatch spawning rules (250 m ideal), Dispatch vehicle sets (15) (+28 more)

### Community 36 - "Memory, pools and limits"
Cohesion: 0.07
Nodes (35): Memory, pools and limits, ArchiveCount, CAN_REGISTER_MISSION_PEDS / VEHICLES / OBJECTS, CEvent pool, ConfigModelInfo, ConfigPopulation, ConfigStreamingEngine, CTask pool (8,192) (+27 more)

### Community 37 - "Appearance and clothing"
Cohesion: 0.09
Nodes (36): Appearance and clothing, ADD_PED_DECORATION_FROM_HASHES, clothes_shop_mp, clothes_shop_sp, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, FINALIZE_HEAD_BLEND, forcedComponents, GET_SHOP_PED_COMPONENT (+28 more)

### Community 38 - "Anatomy of a story mission"
Cohesion: 0.11
Nodes (28): Anatomy of a story mission, armenian1 (Franklin and Lamar), Jewel Store Job crew tiers and take, flow_controller, Force cleanup handler (HAS_FORCE_CLEANUP_OCCURRED), Global_80529 mission pass bits, Heist approach (flow integer f_205[7]), jewelry_heist (The Jewel Store Job) (+20 more)

### Community 39 - "Time, weather and wind: Game clock"
Cohesion: 0.08
Nodes (37): Time, weather and wind, ADD_TO_CLOCK_TIME, branchbend_windsettings.xml, cheat_controller, clouds.xml, exile1, EXTRASUNNY, _FORCE_GROUND_SNOW_PASS (+29 more)

### Community 40 - "Cameras"
Cohesion: 0.11
Nodes (34): Cameras, camCinematicMountedCameraMetadata, camEnvelopeMetadata, Camera shakes, cameras.ymt, camFollowVehicleCameraMetadata, camOscillatorMetadata, camScriptDirectorMetadata (+26 more)

### Community 41 - "AI cost and level of detail"
Cohesion: 0.11
Nodes (33): AI cost and level of detail, AI LOD by distance (near, middle, far), CTaskMotionBasicLocomotionLowLod, Dummy and super-dummy vehicles, FORCE_ENTITY_AI_AND_ANIMATION_UPDATE (340 scripts), FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts, 4,119 calls), gameconfig.xml (update copy), IS_ENTITY_ON_SCREEN (316 scripts) (+25 more)

### Community 42 - "Controls and camera"
Cohesion: 0.09
Nodes (35): Control ID renumbering in build 3717 (+37 from 257), Controls and camera (R6.4), GET/SET_CAM_VIEW_MODE_FOR_CONTEXT view modes, INPUT_* control actions (IDs 0-401), Three control groups (player, camera, frontend), default.meta keyboard/mouse bindings (192 actions), DISABLE_CONTROL_ACTION (706 scripts, 601,543 calls), View mode 4 = first person (+27 more)

### Community 43 - "Cutscenes and dialogue"
Cohesion: 0.11
Nodes (33): Cutscenes and dialogue (R5.6), Dressing cutscene actors (SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED), Ambient speech (PLAY_PED_AMBIENT_SPEECH_NATIVE), armenian1 (traced cutscenes), CAN_REQUEST_ASSETS_FOR_CUTSCENE_ENTITY window, Concat cutscenes and playback sections, Conversation root and line labels (<root>_<n>A), CREATE_NEW_SCRIPTED_CONVERSATION (+25 more)

### Community 44 - "Collision, materials and shape tests"
Cohesion: 0.10
Nodes (31): Collision, materials and shape tests, GET_GROUND_Z_FOR_3D_COORD, GET_SHAPE_TEST_RESULT, GLASS_BULLETPROOF, HAS_COLLISION_LOADED_AROUND_ENTITY, hi@ and ma@ collision sets, Material groups (FILTER), material_override_pairs.dat (+23 more)

### Community 45 - "Animation: Clip sets"
Cohesion: 0.09
Nodes (33): Animation, Animation memory groups, Clip sets, clip_sets.ymt, conditionalanims.meta, CREATE_SYNCHRONIZED_SCENE, Expression dictionaries (.yed), expression_sets.xml (+25 more)

### Community 46 - "Timecycle and post effects"
Cohesion: 0.07
Nodes (30): Timecycle and post effects, ADD_TCMODIFIER_OVERRIDE, AnimMode, ANIMPOSTFX_STOP, animpostfx.ymt, CAMERA_secuirity_FUZZ, DrugsMichaelAliensFight, FocusOut (+22 more)

### Community 47 - "How audio is organised"
Cohesion: 0.10
Nodes (33): AUD-001: Number of sounds and sound sets, How audio is organised, AUDIO native namespace (281 natives), audio_rel.rpf, Audio scenes and patches, AWC wave containers (.awc), categories.dat22.rel, content.xml (DLC audio registration) (+25 more)

### Community 48 - "Population"
Cohesion: 0.09
Nodes (33): ENT-024: Unnamed zone fields, zonebind.ymt, GET_NAME_OF_ZONE, Population, ADD_POP_MULTIPLIER_SPHERE, cellphone_flashhand, CityDensity, CLEAR_AREA_OF_PEDS (+25 more)

### Community 49 - "Boot and script control: initial script"
Cohesion: 0.09
Nodes (33): director_mode, Engine starts startup, initial and main, flow_controller, flowintrotitle, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, Global_1 (game started flag), Global_3 (boot into Online), Global_80281 (+25 more)

### Community 50 - "Perception and events"
Cohesion: 0.09
Nodes (34): Decision makers, events.meta (decision makers), Perception and events, ADD_SHOCKING_EVENT_AT_POSITION, ADD_SHOCKING_EVENT_FOR_ENTITY, AddPedGenBlockedArea, CEventAgitated, CEventCrimeCryForHelp (+26 more)

### Community 51 - "Relationships and groups"
Cohesion: 0.10
Nodes (32): SET_PLAYER_WANTED_LEVEL, Relationships and groups, ADD_RELATIONSHIP_GROUP, AMBIENT_GANG_* groups (9), CIVMALE / CIVFEMALE groups, COP relationship group, Follower limit (7 besides leader), franklin1 (+24 more)

### Community 52 - "Vehicle generators and traffic"
Cohesion: 0.09
Nodes (33): SET_PED_DENSITY_MULTIPLIER_THIS_FRAME, SET_PED_MODEL_IS_SUPPRESSED, SET_PED_POPULATION_BUDGET, Vehicle generators and traffic, Car generator flag bits, Car generators (CCarGen), CREATE_MISSION_TRAIN, CREATE_SCRIPT_VEHICLE_GENERATOR (+25 more)

### Community 53 - "Scenarios and ambient life"
Cohesion: 0.10
Nodes (33): Scenarios and ambient life, act_cinema, ADD_SCENARIO_BLOCKING_AREA, Ambient aircraft and boats, ambientpedmodelsets.meta, Chaining graphs, HEIST_ISLAND_PEDS, MP_POLICE (+25 more)

### Community 54 - "CPU"
Cohesion: 0.09
Nodes (30): CPU: population, AI, physics and scripts, Population density as biggest lever, Game threads (24, Update TIME_CRITICAL), Open questions (CPU), Heavily modded install script load (52 + 61), 15 W laptop throttling, settings.xml (version 27) keys, Load times and stutter (+22 more)

### Community 55 - "Particles and decals"
Cohesion: 0.10
Nodes (33): materialfx.dat, Particles and decals, ADD_DECAL, bloodfx.dat, core particle dictionary, decals.dat, entityfx.dat, MTLFX_TABLE (+25 more)

### Community 56 - "Map data"
Cohesion: 0.10
Nodes (31): Timecycle modifier boxes, Map data, Box occluders, Car generators, controller_ambientarea, cs1_12.ymap, HDTxdAssetBindings, HoursOnOff (+23 more)

### Community 57 - "Glossary / The AI architecture"
Cohesion: 0.08
Nodes (33): Community decompile repository (one commit per build), Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts), Glossary, Broadcast data (player and host synced globals), Decision maker: event to ped reaction table, Global block: shared script memory owned by a registration script, Glossary of modding and engine terms, IPL map placement groups toggled by REQUEST_IPL (+25 more)

### Community 58 - "Speech and dialogue"
Cohesion: 0.09
Nodes (30): Speech and dialogue, BOUNCER_EJECT_GENERIC, dialogue_handler, DISABLE_PED_PAIN_AUDIO, FAM1AUD, GENERIC_HI, IS_SCRIPTED_CONVERSATION_ONGOING, Open question: contexts per voice in speech2.dat4.rel (+22 more)

### Community 59 - "Random events"
Cohesion: 0.09
Nodes (30): ambient.ipl, Random events, code_controller, Cut random events without scripts, Global_114904 random event save, lesterhandler, Open question: world brain activation range, photographymonkey (+22 more)

### Community 60 - "Wanted level and police"
Cohesion: 0.10
Nodes (31): CanCallPolice, SET_WANTED_LEVEL_MULTIPLIER, wantedtuning.ymt, Wanted level and police, CanWitnessCrimes / WillCallLawEnforcement, CRIME_FIREARM_DISCHARGE, CRIME_HASSLE, Crime numbers 13, 28, 36, 37 (+23 more)

### Community 61 - "Completion, autosave and achievements"
Cohesion: 0.13
Nodes (30): Completion, autosave and achievements (R5.3), achievement_controller (23 IDs, started by main_persistent), The 23 achievement IDs and conditions (names Known), Achievement stats named via _GET_STAT_HASH_FOR_CHARACTER_STAT (types 8/10 unnamed), GET_IS_AUTO_SAVE_OFF / IS_AUTO_SAVE_IN_PROGRESS, One completion entry's 12 values (func_699), Completion JSON summary (tot_pc, Sect msnc/mgc/ojc/rcc/revc/misc, every 5 min), Completion list (320 entries, 7 counted groups make 100%) (+22 more)

### Community 62 - "Peds"
Cohesion: 0.10
Nodes (30): Peds, 1,109 ped models, AbilityType special abilities, CombatInfo, CPedModelInfo InitData, CREATE_PED, DecisionMakerName, GET_PED_TYPE (+22 more)

### Community 63 - "Strangers, freaks and side content"
Cohesion: 0.12
Nodes (29): 146 script brains (99 world-point, 47 object), Strangers, freaks and side content, appinternet (Epsilon website), atm_trigger, BailBond_Launcher, Brain set bit mask (story 1, Online 8), code_controller, completionpercentage_controller (+21 more)

### Community 64 - "Inside freemode"
Cohesion: 0.12
Nodes (27): Inside freemode, am_mp_island (Cayo Perico), am_pi_menu (interaction menu), DLC story flow functions (CH_FLOW_, HIF_ ...), Network event 174 (script events carrier), FMMC_Launcher (job lobby), freemode script, freemode_clearGlobals (+19 more)

### Community 65 - "Stats, tunables and the server's role"
Cohesion: 0.11
Nodes (31): Stats, tunables and the server's role (R7.3), character_appearance_charge appearance fee ($100,000) and cooldown tunables, clothes_shop_mp, Hash-only tunables (7,296; 311 recovered), MONEY NETWORK_SPENT_* / NETWORK_EARN_* natives, mpstatssetup.xml (17,928 Online stats), Offline Online mode replacements (local save, tunable defaults, local prices), Packed stats (6,403) (+23 more)

### Community 66 - "5. Your first C# mod"
Cohesion: 0.10
Nodes (24): 1. How mods work, Data mods vs script mods, Per-frame script loop, 3. Install the basics and check they load, Verify install via asiloader/ScriptHookV/SHVDN logs, 5. Your first C# mod, Loose .cs file and Reload() console, net48 csproj build to .dll (+16 more)

### Community 67 - "Native usage index"
Cohesion: 0.20
Nodes (31): Native usage index, Game build 3725, Decompile commit 6c18d3e8b, Decompiler names differing from NativeDB, Per-namespace native usage index, tools/native-usage.ps1 generator, NativeDB reference, Scripts with most natives (fm_mission_controller_2020 3166) (+23 more)

### Community 68 - "VEHICLE natives used by the game scripts"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 69 - "Swimming and diving"
Cohesion: 0.11
Nodes (29): motiontasks.ymt, Swimming and diving, CTaskMotionSwimming tunables, Dive height (MinDiveHeight / MaxDiveHeight), GET_ENTITY_SUBMERGED_LEVEL, GET_PLAYER_UNDERWATER_TIME_REMAINING, HighFallWaterDepthMin / Max, Hold breath duration (MinHoldBreathDuration 10 / Max 40) (+21 more)

### Community 70 - "Decisions and personalities"
Cohesion: 0.11
Nodes (29): Decisions and personalities, agitatedpersonalities.meta, Agitation system (Confront, default, none), ArmourEfficiency, BF_CONFRONTATIONAL, BF_COWARDLY_FOR_SHOCKING_EVENTS, 18 bravery types, combatbehaviour.meta (+21 more)

### Community 71 - "Archive and data file atlas / Open questions"
Cohesion: 0.09
Nodes (28): .ydr drawable, dlc_patch, Archive and data file atlas, 5,290 archives and 389,555 files, 89 DLC packs, .awc audio wave container, common.rpf, dlc_patch folders (+20 more)

### Community 72 - "Vehicles"
Cohesion: 0.10
Nodes (28): 879 vehicle models with name labels, Vehicle groups, Vehicles, 921 vehicle models, Add-on vehicle pack, carcols, carvariations, CREATE_VEHICLE (+20 more)

### Community 73 - "Flying"
Cohesion: 0.11
Nodes (29): Flight school medal thresholds, pilot_school, Flying, bj (base jumps), CFlyingHandlingData, CONTROL_LANDING_GEAR / GET_LANDING_GEAR_STATE, CTaskParachute tunables (movementtasks.ymt), DLC aircraft flying blocks (63 entries) (+21 more)

### Community 74 - "PED natives used by the game scripts"
Cohesion: 0.14
Nodes (30): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+22 more)

### Community 75 - "GTA natives used by the game scripts"
Cohesion: 0.12
Nodes (9): Samples, NativeCalls, Examples, Six SHVDN v3 C# sample scripts, GTA natives used by the game scripts, CELL_SET_INPUT, GET_MOBILE_PHONE_POSITION, GTA native namespace: GTA natives: mobile phone and cellphone camera (+1 more)

### Community 76 - "Heists in GTA Online / Open questions"
Cohesion: 0.14
Nodes (27): Heists in GTA Online, Casino crew cuts (gunman, driver, hacker), The Cayo Perico Heist, Cayo secondary loot value rolls, ch_lester_cut (5%), Classic heists (Fleeca to Pacific Standard), Heist cut rules (55% leader, 15% min, 70% max), The Diamond Casino Heist (+19 more)

### Community 77 - "NETWORK natives used by the game scripts"
Cohesion: 0.16
Nodes (29): NETWORK natives used by the game scripts, GET_CLOUD_TIME_AS_INT, GET_NETWORK_TIME, NETWORK native namespace, NET_TO_VEH, NETWORK_ADD_PED_TO_SYNCHRONISED_SCENE, NETWORK_DOES_ENTITY_EXIST_WITH_NETWORK_ID, NETWORK_GET_PLAYER_INDEX_FROM_PED (+21 more)

### Community 78 - "Data needs: Data batch D8"
Cohesion: 0.14
Nodes (28): AI-009: Animal models by kind and where they spawn, AI-027: Road nodes, routes and counts, AI-028: Navmesh polygons, links, cover points per tile, AI-029: Road nodes, routes and counts, Data batch D8: map data, ENT-001: Archetype flag bits across all .ytyp, ENT-002: Fragment map props and how many break, ENT-003: Rayfire objects placed in the map (+20 more)

### Community 79 - "Open questions: Performance open questions"
Cohesion: 0.08
Nodes (28): Windows and drivers, Background programs as biggest Windows-side cost, Game Bar background recording off, Integrated vs dedicated graphics, Page file and 20 GB free rule, Power plan, power mode and processor max state, Pre-play checklist for a low-end laptop, CPU questions (R18.4) (+20 more)

### Community 80 - "GTA V Under the Hood"
Cohesion: 0.11
Nodes (25): ScriptHookVDotNet, Steps 5/6/7 are alternatives (C#, Lua, C++), GTA V Under the Hood: how Grand Theft Auto V works underneath, C++ (ScriptHookV), First pass: all 109 research topics, Lua, PowerShell and bash, XML and data files (+17 more)

### Community 81 - "Navigation and pathfinding"
Cohesion: 0.12
Nodes (26): TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE, Navigation and pathfinding, ADD_COVER_POINT, ADD_NAVMESH_BLOCKING_OBJECT, ADD_NAVMESH_REQUIRED_REGION, GET_SAFE_COORD_FOR_PED, IS_NAVMESH_LOADED_IN_AREA, Navmesh and road node counts (79,788 nodes, 3,129 junctions) (+18 more)

### Community 82 - "Replay, director mode and the Rockstar E"
Cohesion: 0.13
Nodes (26): Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder (Rockstar Editor), Director mode quick-travel locations (27), director_mode, GP-087 Replay type meaning in the engine, maintransition, mission_repeat_controller (+18 more)

### Community 83 - "UGC mission files"
Cohesion: 0.13
Nodes (25): .ugc job file, UGC mission files (JSON), am_launcher, Classic creator missions family, endcon section, ene section, fm_content_bounty_targets, fm_content_* scripts (+17 more)

### Community 84 - "02 Scripting with ScriptHookVDotNet v3"
Cohesion: 0.08
Nodes (24): LemonUI, 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini, SHVDN namespaces (GTA, GTA.UI, GTA.Native, GTA.Input...) (+16 more)

### Community 85 - "PLAYER natives used by the game scripts"
Cohesion: 0.17
Nodes (27): PLAYER natives used by the game scripts, GET_PLAYER_NAME, GET_PLAYER_PED, GET_PLAYER_TEAM, GET_PLAYER_WANTED_LEVEL, INT_TO_PLAYERINDEX, IS_PLAYER_CONTROL_ON, IS_PLAYER_PLAYING (+19 more)

### Community 86 - "STATS natives used by the game scripts"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 87 - "TASK natives used by the game scripts"
Cohesion: 0.17
Nodes (27): TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS, TASK native namespace (+19 more)

### Community 88 - "02_PlayerAndWorld.cs"
Cohesion: 0.08
Nodes (5): HelloWorld, PlayerAndWorld, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 89 - "Data needs: Data rows never attempted"
Cohesion: 0.10
Nodes (26): AI-024: AI handling profile of every DLC vehicle, AI-033: Decision maker event-to-response mapping, carcols.ymt / carcols.meta, carvariations.meta, Ped component .ymt files, ENT-010: Overlay and micro-morph lists, ENT-015: Component .ymt format, ENT-017: Ragdoll tuning set per weapon and vehicle (+18 more)

### Community 90 - "Research roadmap / Surviving game updates guide"
Cohesion: 0.10
Nodes (25): Core engine, R0.2 Script cards for the runtime scripts, R11.2 An update-check tool, R5.3 Saves, completion and autosave, Surviving game updates guide (R11), Asset dependency list, dlclist.xml, Finding risky code in a mod (memory offsets, patterns, globals) (+17 more)

### Community 91 - "Open questions: Streaming, memory and video memo"
Cohesion: 0.08
Nodes (26): Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat, Open questions (graphics), Biggest GPU/CPU/memory costs, Streaming, memory and video memory (+18 more)

### Community 92 - "Rendering, visual settings and LOD"
Cohesion: 0.14
Nodes (23): REN-017: Changed visualsettings.dat keys, Rendering, visual settings and LOD, Adrian Courreges GTA V graphics study, CASCADE_SHADOWS_INIT_SESSION, CASCADE_SHADOWS_SET_CASCADE_BOUNDS, Cascaded shadow maps, Distant lights, Extended distance scaling (+15 more)

### Community 93 - "Saves"
Cohesion: 0.11
Nodes (23): autosave_controller (four states, stack 1,424), When the autosave controller refuses or waits, save_anywhere / savegame_bed (manual saves), Where it lives: completion, save and achievement scripts, Saves: the story save (R1.7), FLOW_STRUCT, fSaveVersion (1.7), g_savedMPGlobals Online block (5,575 values) (+15 more)

### Community 94 - "Transitions and sessions / Open questions"
Cohesion: 0.16
Nodes (25): Transitions and sessions (R7.2), freemode_clearGlobals (31 reset steps), ingamehud connection-problem warnings, maintransition (transition state machine script), NETWORK_IS_GAME_IN_PROGRESS (905 scripts), NETWORK_REQUEST_CLOUD_TUNABLES, Offline-mode branch (unreachable in build 3725), Online privilege checks (NETWORK_HAVE_ONLINE_PRIVILEGES ...) (+17 more)

### Community 95 - "Archives and the content system"
Cohesion: 0.12
Nodes (20): Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins), RPF archives (+12 more)

### Community 96 - "Streaming"
Cohesion: 0.10
Nodes (22): Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, Pop-in and streaming hitches, Population and model budgets, Request, check, release pattern (+14 more)

### Community 97 - "Water and buoyancy"
Cohesion: 0.11
Nodes (22): Water and buoyancy, ADD_EXTRA_CALMING_QUAD, Calming quads, CBoatHandlingData, CSeaPlaneHandlingData, CSubmarineHandlingData, fPercentSubmerged, GET_WATER_HEIGHT_NO_WAVES (+14 more)

### Community 98 - "Open questions: Gameplay open questions"
Cohesion: 0.12
Nodes (24): Cutscenes and dialogue questions (R5.6), Anatomy of a story mission questions (R5.2), Replay, director mode and the Rockstar Editor questions (R5.8), Gameplay open questions, GP-005: How many cutscene files ship, GP-006: Exact meanings of the START_CUTSCENE and..., GP-007: The layout of dialogue_handler's request globals, GP-016: Where armenian1, jewelry_heist and trevor1 set the skip flag (+16 more)

### Community 99 - "Driving and AI driving"
Cohesion: 0.13
Nodes (22): Driving and AI driving, Driving style 262,144 (shortcuts only), Driving style 786,468 (rushed), Driving style 786,603 (careful), AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), TASK_VEHICLE_FOLLOW_WAYPOINT_RECORDING, Corner-speed curve, CTaskPlayerDrive (+14 more)

### Community 100 - "Driving AI"
Cohesion: 0.14
Nodes (22): Driving AI: missions, chases, aircraft and boats, Flee mission (8), fm_content_* scripts, Roadmap R17.6 driving AI, SET_BOAT_ANCHOR, SET_DRIVER_RACING_MODIFIER, SET_HELI_BLADES_FULL_SPEED, TASK_BOAT_MISSION (+14 more)

### Community 101 - "Text and names in content"
Cohesion: 0.12
Nodes (20): Text and names in content, americandlc.rpf, dlctext.meta, gameName, GET_DISPLAY_NAME_FROM_VEHICLE_MODEL, GET_LIVERY_NAME, GET_MAKE_NAME_FROM_VEHICLE_MODEL, GET_MOD_TEXT_LABEL (+12 more)

### Community 102 - "Character switching"
Cohesion: 0.15
Nodes (19): Character switching, CHANGE_PLAYER_PED, family_scene_* scripts, GET_IDEAL_PLAYER_SWITCH_TYPE, GET_PLAYER_SWITCH_STATE, IS_PLAYER_SWITCH_IN_PROGRESS, IS_SAFE_TO_START_PLAYER_SWITCH, main_persistent (+11 more)

### Community 103 - "The Online character creator / Open questions"
Cohesion: 0.13
Nodes (23): The Online character creator, Apparel (64 outfits per sex, crew T-shirt, crew emblem), Appearance change fee and cooldown (100,000, 48 minutes), 63 saved creator stats (62 server-authoritative), Seven skill stats with 100-point pool, 32 eye colours (FACE_E_C_0 to 31), Head blend natives (SET_PED_HEAD_BLEND_DATA, FINALIZE_HEAD_BLEND), Heritage head blend (+15 more)

### Community 104 - "Vehicle physics"
Cohesion: 0.10
Nodes (22): Physics (folder index), Physics roadmap topics R2.1-R2.7, Vehicle physics: handling, damage and upgrades, AI driving styles (vehicleaihandlinginfo.meta), Mod-kit statMods in carcols.meta, DLC handling.meta files, Handling flag words (model/handling/damage/advanced), handling.meta (CHandlingData) (+14 more)

### Community 105 - "Natives as the engine API / 05 Native functions"
Cohesion: 0.10
Nodes (21): 05 Native functions, Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument), Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED), Contracts Rockstar keeps (request, release, create, clean up), Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT), START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE (+13 more)

### Community 106 - "CLAUDE.md"
Cohesion: 0.10
Nodes (14): Blocked extensions list, file-rules check (GitHub workflow), graphify-out exempt paths, Download-and-run (RISKY) patterns, 500 KB size limit, CLAUDE.md (AI assistant instructions), Decompile commit 'Update for 1.72-3725.0', file-rules check workflow (+6 more)

### Community 107 - "Data needs: vehicles.meta"
Cohesion: 0.13
Nodes (21): Data batch D1: American text blocks and vehicle data files, Data batch D12: remaining text questions, Decompile commit 6c18d3e8, ENT-005: The 13 vehicle maker labels with no text, ENT-006: Mod-part and livery label naming, ENT-036: 901 vs 879 vehicle models, ENT-037: Less common vehicle flags, GP-045: CFlyingHandlingData of every DLC aircraft (+13 more)

### Community 108 - "Tools"
Cohesion: 0.12
Nodes (18): RPF archives, RPF archive format v7, Update-check tool, R11.2 Update-check tool, Tools, check-system.ps1: what Windows needs, CodeWalker (external dependency), Community decompiled-scripts repository (external dependency) (+10 more)

### Community 109 - "Boot and script control: MainTransition"
Cohesion: 0.12
Nodes (19): LOBBY_AUTO_MULTIPLAYER_* flags, Back to story mode, benchmark, Force cleanup bits (2, 8, 64, 1, 128), freemode (MP_LAUNCH_SCRIPT stack), Launching into Online, MainTransition, Other boot paths (benchmark, Rockstar Editor, director mode) (+11 more)

### Community 110 - "Missions / Script catalog"
Cohesion: 0.12
Nodes (20): Missions, R0.1, R5.2, R5.4, R5.5, R5.6, R5.8, Script catalog: story mode and shared scripts (+12 more)

### Community 111 - "Organisations and businesses: VIP and MC challenges"
Cohesion: 0.18
Nodes (20): Organisations and businesses, am_pi_menu (interaction menu), Registering as boss is free in this build, gb_become_boss_threshold, gb_biker_criminal_mischief, gb_biker_search_and_destroy, gb_biker_wheelie_rider, gb_bosscost (unused) (+12 more)

### Community 112 - "file-rules.yml"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 113 - "Open questions: AI open questions"
Cohesion: 0.13
Nodes (20): AI-001: The full list of task classes the engine has, AI-002: Task status values and what each means, measured, AI-003: How primary and secondary task slots are numbered, AI-011: Decode pedpersonality.ymt, AI-012: Cover, AI-014: The full meaning of taskdata.meta and scriptedguntasks.meta, AI-015: Whether the modded events.meta really drops gunfight..., AI-016: Decode pedpersonality.ymt (+12 more)

### Community 114 - "AUDIO natives used by the game scripts / CAMERA natives used by the game scripts"
Cohesion: 0.10
Nodes (20): AUDIO natives used by the game scripts, GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CAMERA natives used by the game scripts (+12 more)

### Community 115 - "Tools and resources: CodeWalker"
Cohesion: 0.12
Nodes (18): Tools and resources (toolbox), Claude Code (AI assistance) and skills, CodeWalker, Community decompile (GTA-V-Decompiled-Scripts), git grep / git show / git diff, ILSpy, LemonUI, NativeUI, iFruitAddon2, Repo PowerShell tools (+10 more)

### Community 116 - "Open questions / Boot and script control"
Cohesion: 0.14
Nodes (18): Boot and script control (R1.2), Boot sequence short version, Timeline of one measured launch, Mod start timing: SHVDN about 13 s, playable about 14 s later, Mods start late, Boot open questions, Boot test cards, Boot and script control questions (R1.2) (+10 more)

### Community 117 - "Combat and AI"
Cohesion: 0.12
Nodes (17): Combat and AI (first pass), combatbehaviour.meta combat profiles, events.meta decision makers and responses, Melee action tables (action definitions.meta), pedaccuracy.meta accuracy modifiers, pedperception.meta profiles, relationships.dat groups, Script fight recipe (relationship, attributes, task, keep task) (+9 more)

### Community 118 - "Organisations and businesses: Business computer apps"
Cohesion: 0.15
Nodes (17): apparcadebusiness, appavengeroperations, appbailoffice, appbikerbusiness, appbunkerbusiness, appbusinesshub, appcovertops, appfixersecurity (+9 more)

### Community 119 - "Open questions: Leftovers"
Cohesion: 0.14
Nodes (16): AI-013: How aim assist and lock-on work for the player, Batch kinds (scripts, data, test, engine), Batch D2: explosion.ymt, Weapons questions (R3.1), Fire, explosions and projectiles questions (R2.5), GP-076: Which mod installed the weapon overhaul, GP-077: The hatchet's extra condition, and whether the Gusenberg..., GP-078: How story stats and Online rank change AmmoMax (+8 more)

### Community 120 - "Open questions: GTA Online open questions"
Cohesion: 0.15
Nodes (17): CORE-031: Which brain set the engine gives the random-ped brains..., Inside freemode (first pass) questions (R7.1), Sessions and sync questions (R15.1), Story systems that clash with an Online mode questions (R5.7), GTA Online open questions, ON-001: What each of the 183 running-state functions does in detail, ON-002: Names of the 60 network event ids and the main script event..., ON-005: How the host's rotation through participants works (+9 more)

### Community 121 - "Open questions: Collision, materials and shape t"
Cohesion: 0.13
Nodes (17): Batch D3: water.xml, water_heistisland.xml..., Collision, materials and shape tests questions (R2.1), Vehicle physics questions (R2.2), Water and buoyancy questions (R2.4), PHY-001: The two unnamed columns, PHY-002: How many .ybn files the map has and how they are grouped, PHY-003: The exact shape test flag bits, checked in game, PHY-004: The ragdoll and NATURAL_MOTION materials (+9 more)

### Community 122 - "Data needs: Data batch D9"
Cohesion: 0.17
Nodes (15): AUD-004: Speech archives, voices and contexts, AUD-005: Unresolved radio station objects, AUD-006: Music event to mood to track, AUD-008: Radio track data, AUD-009: Speech archives, voices and contexts, AUD-010: Dialogue block per mission, .awc audio archives, Data batch D9: audio files (+7 more)

### Community 123 - "Story systems that clash with an Online "
Cohesion: 0.16
Nodes (15): R5.7 Systems that clash with Online mode (topic row), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Scripts that switch brain sets (maintransition, main_persistent ...), Force cleanup bit 2 (move to Online), Force-cleanup masks of 30 story systems, Object brains (ATMs, vending machines, beds, laptops), Open questions (story systems) (+7 more)

### Community 124 - "DATAFILE natives used by the game script / HUD natives used by the game scripts"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 125 - "Data needs: Data batch D10"
Cohesion: 0.23
Nodes (15): Animpostfx post-effect metadata, Data batch D10: effects and timecycle files, entityfx.dat, materialfx.dat, wheelfx.dat, GP-027: Editor post effects, unnamed post effects, GroupId and EventType, REN-014: entityfx, materialfx and wheelfx rows, REN-015: DLC particle dictionaries in story mode, REN-016: Effect names per particle dictionary, REN-021: Timecycle modifier values and userFlags (+7 more)

### Community 126 - "Organisations and businesses: Business loop"
Cohesion: 0.13
Nodes (14): Acid lab, Bunker manufacturing and research, exec_stock_remove_at_fail_sell, exec_warehouse_stock_defend_threshold, fm_content_smuggler_resupply, GB_BIKER_CONTRABAND_SELL, GB_CONTRABAND_BUY, GB_CONTRABAND_SELL (+6 more)

### Community 127 - "Organisations and businesses: Organisation rules"
Cohesion: 0.15
Nodes (13): gb_become_boss_cooldown, gb_boss_radius (health regen), gb_bosssetupcost (unused), gb_challenge_goon_rp_reward_percentage, gb_cooldown_until_next_boss_challenge, gb_cooldown_until_next_boss_work, gb_ghost_org_cost (Ghost Organization), gb_rival_org_cash_reward_percentage (+5 more)

### Community 128 - "Open questions: Batch D10"
Cohesion: 0.19
Nodes (15): Batch D10: entityfx.dat, materialfx.dat, wheelfx.dat, every..., Rendering, visual settings and LOD questions (R13.1), Timecycle and post effects questions (R13.2), REN-017: What each changed key between base and update copies does, REN-018: How "extended distance scaling" maps to the LOD scale value, REN-019: What popular lighting and graphics overhauls change in..., REN-020: Per-pass cost measured on a low-end PC, REN-021: What the two numbers on each modifier line mean (+7 more)

### Community 129 - "WEAPON natives used by the game scripts / ZONE natives used by the game scripts"
Cohesion: 0.13
Nodes (15): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+7 more)

### Community 130 - "Text labels / Open questions"
Cohesion: 0.22
Nodes (14): Completion label text (199 of 320 in global.gxt2, 121 internal names), Request-wait-call-draw-release pattern, Mission-passed screen (mission_stat_watcher), Text labels, REQUEST_ADDITIONAL_TEXT slots, DLC text (dlctext.meta, americandlc.rpf), Label name index by hashing, STRING label (~a~) trick (+6 more)

### Community 131 - "Scaleform movies / Open questions"
Cohesion: 0.21
Nodes (14): pausemenu.xml menu description, Scaleform movies, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), DLC movies (mpheist, mpapartment), Scaleform .gfx archives, Interior map movies (int<hash>.gfx), Movie method names from ActionScript, SHOW_MISSION_PASSED_MESSAGE parameters (+6 more)

### Community 132 - "Open questions: How audio is organised questions"
Cohesion: 0.18
Nodes (14): AUD-001: The number of sounds and sound sets in sounds.dat54, AUD-004: Speech archives and voices, AUD-005: The 10 base and many DLC station objects whose names didn't..., AUD-006: How a music event maps to moods and tracks, step by step, AUD-007: Which DLC stations are available in story mode in build 3725, AUD-008: The format of a radio track's data, AUD-009: The list of contexts each voice has, from speech2.dat4.rel, AUD-010: Which block name maps to which mission, for all 331... (+6 more)

### Community 133 - "Open questions: Runtime scripts questions"
Cohesion: 0.20
Nodes (14): CORE-017: Meaning of force-cleanup bits 8, 16, 32, 64 and 128, CORE-018: What exactly the engine does to start main, initial and..., CORE-019: What profiler_registration, CORE-020: The story flags that pick the active mission triggerer, CORE-032: What the engine raises force-cleanup bits 16 and 32 for, CORE-033: What the values of the current mission type, Runtime scripts questions (R0.2), ON-060: How bits 16, 32 and 64 in these masks are raised (+6 more)

### Community 134 - "Open questions: Batch P4.10"
Cohesion: 0.23
Nodes (14): Batch D1: Every American .gxt2 text block, Flying questions (R3.4), Player skills and abilities questions (R3.6), GP-045: Flying blocks of all DLC aircraft, GP-046: What SPMED and SPSMALL are, GP-047: The 12 lessons by name, their aircraft and targets, GP-048: The mission type numbers used with TASK_HELI_MISSION and..., GP-067: How much each activity raises each skill (+6 more)

### Community 135 - "DLC natives used by the game scripts / EXTRAMETADATA natives used by the game s"
Cohesion: 0.14
Nodes (14): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA (+6 more)

### Community 136 - "Player skills and abilities"
Cohesion: 0.28
Nodes (13): Player skills and abilities (R3.6), Open question GP-092: ability entries 8-16, peds.ymt AbilityType per model, playerinfo.ymt PlayerStatInfos ranges, playerspecialabilities.ymt (17 entries), Seven character skills (0-100, SP0_/SP1_/SP2_ stats), Skill growth formula (start + bonus + activity score), Special abilities: driving focus, red mist, bullet time (+5 more)

### Community 137 - "Organisations and businesses: Nightclub safe and warehouse"
Cohesion: 0.17
Nodes (11): Biker businesses (weed, documents, cash, meth, cocaine), biker_weed_production_time, fm_content_club_source, freemode, GET_NETWORK_TIME, Nightclub safe and warehouse, Nightclub technician slots and production time, nightclubincomeuptopop (+3 more)

### Community 138 - "Open questions: Batch D11"
Cohesion: 0.23
Nodes (12): Batch D11: clip_sets.ymt and the DLC clip_sets.xml files..., Animation questions (R13.4), Cameras questions (R13.5), REN-001: The names behind the 22 memory groups and their budget unit, REN-002: Which clip sets the hashed entries are, REN-003: Exactly what each TASK_PLAY_ANIM flag bit does, REN-004: The clip archive layout in DLC packs and how many..., REN-005: The 12 expression dictionaries the update replaced and why (+4 more)

### Community 139 - "ENTITY natives used by the game scripts / DECORATOR natives used by the game scrip"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 140 - "Ped physics and ragdoll"
Cohesion: 0.20
Nodes (9): Ped physics and ragdoll, High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file, Ragdoll blocking flags and masks, CTaskNM ragdoll tasks, nm_blend_out_sets.meta, Pose matcher database (.ypdb) (+1 more)

### Community 141 - "Online cosmetics and the shops that sell: shop_controller script"
Cohesion: 0.20
Nodes (7): ADD_PED_DECORATION_FROM_HASHES, CLEAR_PED_DECORATIONS, multiplayer_overlays collection, shop_controller script, Shop table (35 cosmetic shops, indices 0-64), tattoo_shop script, Tattoo zones (six zone pages)

### Community 142 - "Open questions: Organisations and businesses que"
Cohesion: 0.36
Nodes (10): Organisations and businesses questions (R7.7), ON-035: The nightclub's production and popularity numbers, ON-036: Special cargo warehouse capacities, ON-037: How production is stored in stats and advanced while..., ON-038: What gb_bosscost and gb_bosssetupcost charge, ON-039: The MC challenge and VIP challenge rules, ON-040: Business battles and the fm_content_ business missions, ON-075: Where registering as a boss is charged now (+2 more)

### Community 143 - "Reading the decompiled game scripts"
Cohesion: 0.22
Nodes (9): Game version (Legacy 1.0.3725.0), Reading the decompiled game scripts, Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Property table in am_mp_property_ext (index to entrance coordinates), Good scripts to read next, Search with git grep and git show without checkout, Shop purchase on PC: server basket start, add item, checkout (clothes_shop_mp), Globals, func and local numbers change every build (+1 more)

### Community 144 - "Data needs: pedpersonality.ymt"
Cohesion: 0.39
Nodes (9): AI-011: Personalities, bravery and driving ability, AI-016: Personalities, bravery and driving ability, AI-017: Unnamed civilian bravery and criminality types, AI-019: How MotivationMin/Max is used, AI-020: Driving ranges vs driving tasks, Data batch D5: personality and ped files, ENT-013: Unresolved personality hashes and relationship groups, pedpersonality.ymt (+1 more)

### Community 145 - "Time, weather and wind: weather.xml"
Cohesion: 0.25
Nodes (7): w_*.xml weather files, 17 weather types, cloudkeyframes.xml, TimeMult, weather.xml, WeatherGpuFx, WeatherTypes

### Community 146 - "Open questions: Driving and AI driving questions"
Cohesion: 0.22
Nodes (9): AI-021: The name of each temp action number, checked in game, AI-022: How the flee mission picks a route, AI-023: Mission numbers passed in variables, AI-024: AI profiles of every DLC vehicle, AI-025: How SET_DRIVER_ABILITY and _AGGRESSIVENESS change the curve..., AI-026: What TASK_VEHICLE_TEMP_ACTION's action numbers mean, with..., AI-027: Road nodes and how routes are planned, Driving AI questions (R17.6) (+1 more)

### Community 147 - "Open questions: Character switching questions"
Cohesion: 0.25
Nodes (9): CORE-021: Resolve table-driven launches, Character switching questions (R6.1), GP-009: Who starts minigame_stats_tracker and..., GP-037: What each character's saved state holds, GP-038: The 42-entry scene table's conditions, GP-039: The meaning of switch flag bits 1, 2, 4, 8, GP-040: Who starts the family_scene_ scripts, Batch P2.6: Script launch graph (+1 more)

### Community 148 - "Open questions: Minigames and activities questio"
Cohesion: 0.33
Nodes (9): Minigames and activities questions (R5.5), GP-010: The flight-school, range and triathlon medal thresholds, GP-011: Golf, GP-012: How the flow unlocks each activity, GP-013: The sea-race labels, GP-014: The towing quick-bonus check, GP-015: What starts minigame_stats_tracker's medal result screen, GP-088: Which scripts arm the code_controller entries that unlock... (+1 more)

### Community 149 - "FIRE natives used by the game scripts / EVENT natives used by the game scripts"
Cohesion: 0.22
Nodes (9): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions (+1 more)

### Community 150 - "Open questions: Ped physics and ragdoll question"
Cohesion: 0.29
Nodes (7): GP-073: Non-story PlayerStatInfos entries, playerinfo.ymt, Ped physics and ragdoll questions (R2.3), ENT-017: Which tuning set is chosen for which weapon and vehicle..., ENT-018: Fall damage by height, ENT-019: What nm_blend_out_sets.meta sets for getting up, ENT-020: Where fall damage is set

### Community 151 - "Time, weather and wind: respawn_controller"
Cohesion: 0.29
Nodes (7): CLEAR_TIMECYCLE_MODIFIER, respawn_controller, CLEAR_WEATHER_TYPE_PERSIST, Global_4525837, replay_controller, respawn_controller, SET_RANDOM_WEATHER_TYPE

### Community 152 - "Open questions: AI cost and level of detail ques"
Cohesion: 0.25
Nodes (8): AI-004: The distances where ped AI LOD changes, AI-005: Measured frame time per combat ped on a low-end PC, AI-006: What the second CTask pool, AI-007: How far from the player ambient peds despawn, AI-008: How peds pick partners for chats, AI-009: The animal models by kind and where each spawns, AI cost and level of detail questions (R17.9), Ambient life questions (R17.8)

### Community 153 - "Open questions: Time, weather and wind questions"
Cohesion: 0.32
Nodes (8): Time, weather and wind questions (R2.6), WLD-013: How long one TimeMult unit lasts, and whether the cycle..., WLD-014: Whether wind changes the flight of aircraft, the drift of..., WLD-015: What the global flag that skips the post-death weather..., WLD-016: How SET_OVERRIDE_WEATHER and the persistent lock interact..., WLD-017: What the 380 timecycle variables per region do, and how..., WLD-018: The base length of one weather TimeMult unit, WLD-019: Whether wind pushes aircraft or boats

### Community 154 - "BUILTIN natives used by the game scripts / BRAIN natives used by the game scripts"
Cohesion: 0.25
Nodes (8): BRAIN natives used by the game scripts, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, TIMESTEP, TO_FLOAT, WAIT

### Community 155 - "Boot and script control: Level index 5"
Cohesion: 0.29
Nodes (7): Shared activity-type helper (212 scripts), GET_INDEX_OF_CURRENT_LEVEL, Level index 1 (levels/gta5), Level index 5: network testbed level, Level indexes, common:/data/levels/stripped (stripped.meta), Testbed transition states 39-52 (state 40 LOOK_FOR_FRESH_JOIN_TESTBED)

### Community 156 - "How Rockstar's scripts drive AI: Patrol routes"
Cohesion: 0.29
Nodes (7): Patrol route natives, data.Patrol block in fm_content scripts, docks_setup, fm_content_* scripts, Patrol routes (miss_ names, closed loop), TASK_PATROL, WORLD_HUMAN_GUARD_STAND

### Community 157 - "The story mission flow / Completion, autosave and achievements"
Cohesion: 0.29
Nodes (7): Autosave request global Global_102468 (11 values), Autosave requesters (220 scripts via the shared helper), Missions that don't autosave (flag bit 0, 9 missions), Story mission table (94 missions, Global_93192), Mission table field 12 (characters in mission bits), Mission table field 15 option flags, standard_global_init

### Community 158 - "Organisations and businesses: Event-type to script table"
Cohesion: 0.29
Nodes (6): am_launcher event-type table, bb_business_battle_event_cargo_weighting, Business Battles (4 scripts, 34 variations), fm_content_* scripts, GB_ILLICIT_GOODS_RESUPPLY, gb_* work scripts (70)

### Community 159 - "Cookbook"
Cohesion: 0.29
Nodes (5): Cookbook: spawning peds and giving them AI, Pattern: bodyguard ped, pedpersonality.ymt, combatbehaviour.meta, pedaccuracy.meta, Relationship groups natives, Category: LSPDFR and police roleplay

### Community 160 - "Open questions: The story mission flow questions"
Cohesion: 0.48
Nodes (7): The story mission flow questions (R5.1), GP-028: The remaining 40-odd command types, GP-029: The meaning of mission-table field 12 above bit 4, and of..., GP-030: How agency_heist2 and Blitz prep 3 are reached, GP-031: The pass and fail labels of each mission command, GP-032: What the flow integers, Batch P4.1: Story flow

### Community 161 - "MISC natives used by the game scripts"
Cohesion: 0.33
Nodes (7): MISC natives used by the game scripts, CLEAR_BIT, IS_PC_VERSION, MISC native namespace: MISC natives: bitwise, random, weather, save registration, platform checks, dispatch, REGISTER_INT_TO_SAVE, SET_BIT, SET_WEATHER_TYPE_OVERTIME_PERSIST

### Community 162 - "Handoff: PERF-025"
Cohesion: 0.33
Nodes (6): PERF-025: Raised physics pools on a low-end PC, GP-088 and GP-089 remainders: Global_114904.f_8620 entries, GP-091: do old control numbers still work on 3717+, Questions needing in-game tests (story mode), PERF-025: physics cost, test card 5, Build 3717 renumbered control IDs from 257 up (+37)

### Community 163 - "Animation: Clip dictionaries"
Cohesion: 0.33
Nodes (6): Base clip archives, Clip dictionaries (.ycd), common_anim.meta, DLC clip archives, REQUEST_ANIM_DICT, PLAY_CAM_ANIM

### Community 164 - "config.yml"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 165 - "Open questions: Strangers, freaks and side conte"
Cohesion: 0.53
Nodes (6): Strangers, freaks and side content questions (R5.4), GP-034: The unlock condition of each entry, GP-035: Where the world points are placed and how many there are..., GP-036: What the object-brain percentage and flags mean, GP-089: Which scripts set the flag IDs that gate stranger entries, Batch P4.4: Strangers and freaks

### Community 166 - "GRAPHICS natives used by the game script"
Cohesion: 0.33
Nodes (6): GRAPHICS natives used by the game scripts, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME

### Community 167 - "INTERIOR natives used by the game script"
Cohesion: 0.33
Nodes (6): INTERIOR natives used by the game scripts, DEACTIVATE_INTERIOR_ENTITY_SET, ENABLE_SHADOW_CULL_MODEL_THIS_FRAME, GET_INTERIOR_AT_COORDS_WITH_TYPE, IS_VALID_INTERIOR, INTERIOR native namespace: INTERIOR natives: interior proxies, entity sets, rooms

### Community 168 - "PATH natives used by the game scripts"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 169 - "PHYSICS natives used by the game scripts"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 170 - "SCRIPT natives used by the game scripts"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 171 - "Appearance and clothing / Peds"
Cohesion: 0.40
Nodes (5): Component slots, CPedVariationInfo component .ymt, SET_PED_COMPONENT_VARIATION, Ped component .ymt, SET_PED_COMPONENT_VARIATION

### Community 172 - "Open questions: Appearance and clothing question"
Cohesion: 0.40
Nodes (5): Appearance and clothing questions (R6.3), ENT-008: Inside clothes_shop_mp, ENT-009: Inside hairdo_shop_mp, ENT-011: The restriction tag names, ENT-012: How many packs carry shop files, and how many items in all

### Community 173 - "Open questions: Vehicles questions"
Cohesion: 0.40
Nodes (5): Vehicles questions (R14.1), ENT-036: The difference between the 901 models here and the 879..., ENT-037: The meaning of the less common flags, ENT-038: Light and siren setting id ranges used by DLC packs, ENT-039: Which carcols mod parts each kit really links

### Community 174 - "Open questions: Online cosmetics and the shops t"
Cohesion: 0.40
Nodes (5): Online cosmetics and the shops that sell them questions (R6.7), GP-082: The full locate number to menu title map, and why a few..., GP-084: Which barber items need a rank, and the ranks, GP-085: The hair and make-up colour counts on this build, GP-086: Which hair fade goes with which hairstyle

### Community 175 - "MONEY natives used by the game scripts"
Cohesion: 0.40
Nodes (5): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC

### Community 176 - "OBJECT natives used by the game scripts"
Cohesion: 0.40
Nodes (5): CREATE_OBJECT, DELETE_OBJECT, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 177 - "RECORDING natives used by the game scrip"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 178 - "SOCIALCLUB natives used by the game scri"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 179 - "WATER natives used by the game scripts"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 180 - "How Rockstar's scripts drive AI: CAN_PED_SEE_HATED_PED"
Cohesion: 0.50
Nodes (3): SET_PED_SEEING_RANGE, CAN_PED_SEE_HATED_PED, re_rescuehostage

### Community 181 - "ITEMSETS natives used by the game script"
Cohesion: 0.50
Nodes (4): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers

### Community 182 - "LOCALIZATION natives used by the game sc"
Cohesion: 0.50
Nodes (4): LOCALIZATION natives used by the game scripts, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type

### Community 183 - "REPLAY natives used by the game scripts"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 184 - "SECURITY natives used by the game script"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 185 - "SHAPETEST natives used by the game scrip"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

## Ambiguous Edges - Review These
- `Vehicle physics: handling, damage and upgrades` → `camVehicleCustomSettingsMetadata`  [AMBIGUOUS]
  docs/rendering/cameras.md · relation: conceptually_related_to
- `DLC_APPAREL_ACQUIRED stats` → `Creation saved as JSON columns`  [AMBIGUOUS]
  docs/online/creator-internals.md · relation: conceptually_related_to

## Knowledge Gaps
- **980 isolated node(s):** `Modder advice: poll not re-give, sequences, block events, tune in right layer`, `Open questions: engine task list, status values, slot numbering`, `Primary task tree and secondary tasks`, `Test cards: poll vs re-give, keep task`, `combatbehaviour.meta combat profiles` (+975 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 1061 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Research roadmap` to `Handoff: Scripts-only leftovers`, `Runtime scripts`, `Rockstar Creator internals`, `Native namespace map`, `Properties in GTA Online`, `Data needs: tools/rpf-cw.ps1`, `The global variable map`, `Server-backed Online screens`, `Economy and pickups`, `Mod map`, `The script VM`, `Research tools`, `Props, archetypes and doors`, `Native usage`, `Open questions: Phase 1`, `Rockstar services`, `Music and radio`, `How Rockstar's scripts drive AI: Hostile ped recipe`, `Fire, explosions and projectiles`, `Physics cost`, `Open questions / Respawn, death and arrest`, `Online cosmetics and the shops that sell: clothes_shop_mp`, `CONTRIBUTING.md`, `Weapons`, `The job lobby`, `Interaction menu, phone and apps`, `Measuring performance`, `Minigames and activities`, `DLC storylines in GTA Online`, `Ambient life`, `Interiors and IPLs`, `The story mission flow`, `GTA Online`, `Script launch graph`, `Police and service AI`, `Memory, pools and limits`, `Appearance and clothing`, `Anatomy of a story mission`, `Time, weather and wind: Game clock`, `Cameras`, `AI cost and level of detail`, `Controls and camera`, `Cutscenes and dialogue`, `Collision, materials and shape tests`, `Animation: Clip sets`, `Timecycle and post effects`, `How audio is organised`, `Population`, `Perception and events`, `Relationships and groups`, `Vehicle generators and traffic`, `Scenarios and ambient life`, `CPU`, `Particles and decals`, `Map data`, `Glossary / The AI architecture`, `Speech and dialogue`, `Random events`, `Wanted level and police`, `Completion, autosave and achievements`, `Peds`, `Strangers, freaks and side content`, `Inside freemode`, `Stats, tunables and the server's role`, `5. Your first C# mod`, `Swimming and diving`, `Decisions and personalities`, `Archive and data file atlas / Open questions`, `Vehicles`, `Flying`, `Heists in GTA Online / Open questions`, `Open questions: Performance open questions`, `GTA V Under the Hood`, `Navigation and pathfinding`, `Replay, director mode and the Rockstar E`, `UGC mission files`, `Research roadmap / Surviving game updates guide`, `Open questions: Streaming, memory and video memo`, `Rendering, visual settings and LOD`, `Saves`, `Transitions and sessions / Open questions`, `Archives and the content system`, `Streaming`, `Water and buoyancy`, `Driving and AI driving`, `Driving AI`, `Text and names in content`, `Character switching`, `The Online character creator / Open questions`, `Vehicle physics`, `Natives as the engine API / 05 Native functions`, `CLAUDE.md`, `Tools`, `Missions / Script catalog`, `Organisations and businesses: VIP and MC challenges`, `Open questions / Boot and script control`, `Combat and AI`, `Story systems that clash with an Online `, `Text labels / Open questions`, `Scaleform movies / Open questions`, `Player skills and abilities`, `Ped physics and ragdoll`, `Open questions: Minigames and activities questio`?**
  _High betweenness centrality (0.361) - this node is a cross-community bridge._
- **What connects `Modder advice: poll not re-give, sequences, block events, tune in right layer`, `Open questions: engine task list, status values, slot numbering`, `Primary task tree and secondary tasks` to the rest of the system?**
  _980 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Handoff: Scripts-only leftovers` be split into smaller, more focused modules?**
  _Cohesion score 0.04841772151898734 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Mod map` to `Rockstar Creator internals`, `The global variable map`, `Economy and pickups`, `The script VM`, `Props, archetypes and doors`, `Open questions: Phase 1`, `Music and radio`, `How Rockstar's scripts drive AI: Hostile ped recipe`, `Fire, explosions and projectiles`, `Physics cost`, `Open questions / Respawn, death and arrest`, `CONTRIBUTING.md`, `Weapons`, `The job lobby`, `Minigames and activities`, `DLC storylines in GTA Online`, `Ambient life`, `Interiors and IPLs`, `The story mission flow`, `Script launch graph`, `Police and service AI`, `Memory, pools and limits`, `Appearance and clothing`, `Anatomy of a story mission`, `Time, weather and wind: Game clock`, `Controls and camera`, `Cutscenes and dialogue`, `Collision, materials and shape tests`, `Animation: Clip sets`, `Timecycle and post effects`, `How audio is organised`, `Population`, `Perception and events`, `Relationships and groups`, `Vehicle generators and traffic`, `Scenarios and ambient life`, `CPU`, `Particles and decals`, `Map data`, `Glossary / The AI architecture`, `Speech and dialogue`, `Wanted level and police`, `Completion, autosave and achievements`, `Peds`, `Strangers, freaks and side content`, `5. Your first C# mod`, `Swimming and diving`, `Decisions and personalities`, `Archive and data file atlas / Open questions`, `Vehicles`, `Flying`, `GTA natives used by the game scripts`, `GTA V Under the Hood`, `Navigation and pathfinding`, `UGC mission files`, `02 Scripting with ScriptHookVDotNet v3`, `Research roadmap / Surviving game updates guide`, `Open questions: Streaming, memory and video memo`, `Rendering, visual settings and LOD`, `Saves`, `Archives and the content system`, `Streaming`, `Water and buoyancy`, `Driving and AI driving`, `Driving AI`, `Text and names in content`, `Character switching`, `Vehicle physics`, `Natives as the engine API / 05 Native functions`, `Tools`, `Missions / Script catalog`, `Tools and resources: CodeWalker`, `Combat and AI`, `Text labels / Open questions`, `Scaleform movies / Open questions`, `Player skills and abilities`, `Ped physics and ragdoll`, `Cookbook`?**
  _High betweenness centrality (0.118) - this node is a cross-community bridge._
- **Should `Runtime scripts` be split into smaller, more focused modules?**
  _Cohesion score 0.049872122762148335 - nodes in this community are weakly interconnected._

### Low-confidence Hints
_AMBIGUOUS edges — the extractor was unsure. Verify before acting on these._

- **What is the exact relationship between `Vehicle physics: handling, damage and upgrades` and `camVehicleCustomSettingsMetadata`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **What is the exact relationship between `DLC_APPAREL_ACQUIRED stats` and `Creation saved as JSON columns`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._