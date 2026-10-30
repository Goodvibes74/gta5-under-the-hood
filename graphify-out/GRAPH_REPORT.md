# Graph Report - phase2  (2026-10-30)

## Corpus Check
- 245 files · ~417,187 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 4 file(s) not represented in the graph (top: (none) 4)

## Summary
- 2023 nodes · 4236 edges · 124 communities (115 shown, 9 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 432 edges (avg confidence: 0.83)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- RPF Archives and Music Mods
- Ped Health and Death
- Combat and AI Tuning
- HUD Colours and Blips
- Story Mission Anatomy
- Natives as Engine API
- Time Weather Wind
- Ambient Life
- Navigation and Streaming
- Handling and How Mods Work
- SHVDN Scripting Guide
- Native Usage Index
- AI Architecture and Tasks
- DLC Packs and Vehicles
- Credits and File Rules
- Economy and Pickups
- Globals and Save Data 3
- UI Questions and Batches
- Economy and Pickups 2
- TASK Natives
- Example Mod Classes
- Story Mission Anatomy (2)
- C# Example Mods
- Online DLC Storylines
- Story Mission Anatomy (3)
- AI Architecture and Tasks 3
- Script Launch Graph
- Boot and Script Control 2
- Minigames and Activities 2
- Driving AI
- Audio System
- Boot and Script Control
- AUDIO Natives
- File-rules Workflow
- Boot and Script Control 4
- Credits and File Rules 2
- Globals and Save Data
- Online Properties
- Performance and Script Load
- Physics Cost and Cleanup
- Issue and PR Templates
- Globals and Save Data (2)
- Repo Rules and Workflow 2
- AI Architecture and Tasks 2
- RPF Archives and Music Mods (2)
- How GTA Online Works
- Strangers and Side Content
- WEAPON Natives
- Rockstar Creator
- Repo Rules and Workflow
- Rockstar Creator (2)
- Physics Cost and Cleanup (2)
- Rendering and LOD
- APPS and DATAFILE Natives
- Economy and Pickups (2)
- Ambient Life (2)
- Story vs Online Scripts
- Online UI Screens
- SHVDN Scripting Guide (2)
- Gameplay Questions
- Boot and Script Control 3
- Online UI Screens (2)
- AI Architecture and Tasks (2)
- DLC and EXTRAMETADATA Natives
- GRAPHICS Natives
- Repo Rules and Workflow 3
- Ambient Life (3)
- How GTA Online Works (2)
- BRAIN and BUILTIN Natives
- Rockstar Creator (3)
- Online Property Questions
- DECORATOR and ENTITY Natives
- MONEY Natives
- Script VM Contracts 2
- Issue and PR Templates 2
- Script VM Contracts
- Globals and Save Data (3)
- Text Label Questions
- BRAIN and BUILTIN Natives (2)
- DLC Packs and Vehicles (2)
- Freemode Internals
- Performance and Script Load (2)
- Online Shops Open Questions
- Repo Rules and Workflow 4
- Handling and How Mods Work (2)
- Weapons
- Performance and Script Load (3)
- Performance and Script Load (4)
- Rendering and LOD (2)
- EVENT and FIRE Natives
- Boot and Script Control 5
- Performance and Script Load (5)
- Economy and Pickups (3)
- File Rules Check
- STREAMING Natives
- Navigation and Streaming (2)
- SHAPETEST Natives
- Issue and PR Templates (2)
- New Game to Prologue
- Issue Config
- OBJECT Natives
- PAD Natives
- PATH Natives
- PHYSICS Natives
- SCRIPT Natives
- Online UI Screens (3)
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- Boot and Script Control (2)
- Natives as Engine API (2)
- SHVDN Scripting Guide 2
- Native Namespace Map
- REPLAY Natives
- Inbox Template
- Native Namespace Map 2
- SAVEMIGRATION Natives
- Native Namespace Map (2)

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 122 edges
2. `Mod map: what to read for the mod you want to make` - 114 edges
3. `Tools` - 85 edges
4. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
5. `Native usage: which scripts call which natives` - 66 edges
6. `Native namespace map` - 60 edges
7. `Native usage index` - 57 edges
8. `Anatomy of a story mission (R5.2)` - 44 edges
9. `Streaming (R1.5)` - 43 edges
10. `Archives and the content system (R1.6)` - 42 edges

## Surprising Connections (you probably didn't know these)
- `Verified / Known definitions` --semantically_similar_to--> `Rule: mark every claim Verified or Known`  [INFERRED] [semantically similar]
  docs/00-getting-started/glossary.md → CLAUDE.md
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `AI assistance with Claude Code and skills` --semantically_similar_to--> `Research done with Claude Code, claims checked against sources`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CREDITS.md
- `Five rules every page assumes` --semantically_similar_to--> `Rules in every language (yield, natives over memory, clean up)`  [INFERRED] [semantically similar]
  modding/cookbook/README.md → scripting/languages.md
- `Steps 5/6/7 are alternatives (C#, Lua, C++)` --semantically_similar_to--> `Language-for-job table (XML, C#, Lua, C++, natives, JSON...)`  [INFERRED] [semantically similar]
  modding/README.md → scripting/languages.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Script brain to launcher to activity** — docs_gameplay_missions_strangers_and_freaks_script_brains, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_story_script_catalog_launchers [EXTRACTED 0.95]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Native usage trio (guide, index, namespace map)** — scripting_native_usage, scripting_native_usage_index, scripting_native_namespace_map [EXTRACTED 1.00]
- **Path from story to freemode to job** — docs_online_transitions_and_sessions_maintransition, docs_online_07_freemode_freemode_script, docs_online_job_lobby_fmmc_launcher [EXTRACTED 1.00]
- **P2.6 launch-graph second pass: questions answered** — open_questions_p2_6, open_questions_core_021, open_questions_gp_009, open_questions_gp_040, scripting_script_launch_graph_variable_launches [EXTRACTED 1.00]
- **Ped reaction data chain (personality, decision maker, combat info, relationship group)** — docs_ai_decisions_and_personalities_ped_ai_chain, docs_ai_combat_and_perception_events_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_relationships_and_groups_default_groups [EXTRACTED 1.00]
- **Rockstar's physics-cost controls (freeze, clear, density, disable)** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_area_cleanup, docs_performance_physics_cost_density_multipliers [EXTRACTED 1.00]
- **Strand 27 activated in standard_global_reg, initial and flow_controller** — docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_flow_controller, docs_00_getting_started_boot_strand_27_prologue [EXTRACTED 1.00]
- **Guard, spinner, poll, warn pattern of server screens** — docs_ui_server_backed_screens_server_call_guards, docs_ui_server_backed_screens_busy_spinner_warning, docs_ui_server_backed_screens_net_gameserver_is_session_valid, docs_ui_server_backed_screens_set_warning_message_with_header [EXTRACTED 1.00]
- **Tables that name the scripts launched by variable** — scripting_script_launch_graph_phone_app_slots, scripting_script_launch_graph_strangers_table, scripting_script_launch_graph_story_mission_table, scripting_script_launch_graph_family_scenes, scripting_script_launch_graph_unresolved_tables [EXTRACTED 1.00]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **Registering add-on content (meta, text, content.xml)** — docs_entities_vehicles_vehicles_add_on_vehicle_pack, docs_entities_objects_text_and_names_dlc_text_registration, docs_entities_peds_peds_add_on_ped [INFERRED 0.75]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Crime to wanted stars to dispatch pipeline** — docs_ai_perception_and_events_can_call_police, docs_ai_wanted_level_and_police_crimeinformation_meta, docs_ai_wanted_level_and_police_points_to_stars, docs_ai_police_and_services_dispatch_meta [INFERRED 0.85]
- **Ambient population system (zones, schedules, scenarios, car generators)** — docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_scenarios_scenario_points, docs_entities_spawning_vehicle_generators_and_traffic_car_generators, docs_entities_spawning_population_zonebind_ymt [INFERRED 0.85]
- **Force-cleanup bit questions and their answer** — open_questions_core_017, open_questions_on_060, open_questions_scr_011, docs_core_runtime_scripts_force_cleanup_bits [INFERRED 0.85]
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

## Communities (124 total, 9 thin omitted)

### Community 0 - "RPF Archives and Music Mods"
Cohesion: 0.06
Nodes (52): Archives and the content system (R1.6), Add-on vs replacement mods, Content change-set groups (12 groups), content.xml file list, dlclist.xml (98 vanilla packs), OpenIV mods folder, Pack load order (higher wins), setup2.xml pack identity and order (+44 more)

### Community 1 - "Ped Health and Death"
Cohesion: 0.08
Nodes (57): PED natives used by the game scripts, ADD_PED_DECORATION_FROM_HASHES, CREATE_PED, CREATE_SYNCHRONIZED_SCENE, FORCE_PED_AI_AND_ANIMATION_UPDATE, GET_PED_CONFIG_FLAG, GET_PED_DRAWABLE_VARIATION, GET_SYNCHRONIZED_SCENE_PHASE (+49 more)

### Community 2 - "Combat and AI Tuning"
Cohesion: 0.06
Nodes (55): Ambient task tunables (defaulttasks.ymt), Combat and AI (first pass), combatbehaviour.meta combat profiles, events.meta decision makers and responses, Melee action tables (action definitions.meta), pedaccuracy.meta accuracy modifiers, pedperception.meta profiles, relationships.dat groups (+47 more)

### Community 3 - "HUD Colours and Blips"
Cohesion: 0.06
Nodes (50): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, Pause and Online menus (+42 more)

### Community 4 - "Story Mission Anatomy"
Cohesion: 0.06
Nodes (44): Controls and camera, INPUT_* control actions and IDs up to 401, Three control groups, Control meta files, DISABLE_CONTROL_ACTION usage, SET_INPUT_EXCLUSIVE, Camera view mode per context, Health, armour, death and arrest (+36 more)

### Community 5 - "Natives as Engine API"
Cohesion: 0.05
Nodes (43): replay_controller retry screen states, Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder natives, Director mode script, Mission replay (replay_controller), NoEditorRestrictions community patch, REPLAY_RECORD_BACK_FOR_TIME usage (+35 more)

### Community 6 - "Time Weather Wind"
Cohesion: 0.11
Nodes (37): Time, weather and wind, Game clock natives, Online clock override, respawn_controller weather reroll, WeatherCycles fixed list, Persistent weather lock natives, weather.xml (types, cycles, GPU fx), Wind (WindMin/WindMax, SET_WIND) (+29 more)

### Community 7 - "Ambient Life"
Cohesion: 0.08
Nodes (36): The AI architecture, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Primary task tree and secondary tasks, Task pool of 8,192 running tasks (gameconfig.xml), Task system: everything a ped does is a task (CTask classes, nested), Test cards: poll vs re-give, keep task (+28 more)

### Community 8 - "Navigation and Streaming"
Cohesion: 0.07
Nodes (29): Interior map movies (int<hash>.gfx), Interiors and IPLs, building_controller and maintransition IPL swaps, Interior entity sets, REQUEST_IPL / REMOVE_IPL, MLO interior archetypes, Opening Online interiors in story mode, Map data (+21 more)

### Community 9 - "Handling and How Mods Work"
Cohesion: 0.10
Nodes (25): CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, Data mods vs script mods, Per-frame script loop, 3. Install the basics and check they load, Verify install via asiloader/ScriptHookV/SHVDN logs, 4. Your first data edit (+17 more)

### Community 10 - "SHVDN Scripting Guide"
Cohesion: 0.08
Nodes (29): Beginner modding path (R12.6), Steps 5/6/7 are alternatives (C#, Lua, C++), 02 Scripting with ScriptHookVDotNet v3 (C#), Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini, SHVDN namespaces (GTA, GTA.UI, GTA.Native, GTA.Input...) (+21 more)

### Community 11 - "Native Usage Index"
Cohesion: 0.22
Nodes (33): Native namespace map, MISC namespace is a junk drawer, 45 named namespaces + 2 unknown natives, AUDIO natives used by the game scripts, CAMERA natives used by the game scripts, CUTSCENE natives used by the game scripts, Native usage index, Game build 3725 (+25 more)

### Community 12 - "AI Architecture and Tasks"
Cohesion: 0.10
Nodes (30): Second-pass batch (one branch, one PR), Batch (one branch, one PR), Creator internals guide (R7.11), DLC storylines guide (R7.9), Inside freemode guide (R7.1), Heists guide (R7.8), Job lobby guide (R7.5), Organisations and businesses guide (R7.7) (+22 more)

### Community 13 - "DLC Packs and Vehicles"
Cohesion: 0.14
Nodes (31): VEHICLE natives used by the game scripts, BRING_VEHICLE_TO_HALT, CONTROL_LANDING_GEAR, CREATE_VEHICLE, DETACH_VEHICLE_FROM_TRAILER, GET_MOD_SLOT_NAME, GET_PED_IN_VEHICLE_SEAT, GET_VEHICLE_MOD (+23 more)

### Community 14 - "Credits and File Rules"
Cohesion: 0.09
Nodes (28): File rules table, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Reading the decompiled game scripts, Property table in am_mp_property_ext (index to entrance coordinates), Good scripts to read next, Search with git grep and git show without checkout, Shop purchase on PC: server basket start, add item, checkout (clothes_shop_mp), Getting started (+20 more)

### Community 15 - "Economy and Pickups"
Cohesion: 0.08
Nodes (26): Name labels (gameName, vehicleMakeName, HumanNameHash), Appearance and clothing, 12 ped component slots and prop anchors, EXTRAMETADATA shop natives, Preload ped variation data, Restriction tags and forced components, Shop catalogue files (*_shop.meta), Shop scripts (clothes_shop, hairdo_shop, tattoo_shop) (+18 more)

### Community 16 - "Globals and Save Data 3"
Cohesion: 0.12
Nodes (24): Story save block (38,592 values), Completion, autosave and achievements (R5.3), autosave_controller, Autosave request global (Global_102468), completionpercentage_controller, Completion JSON summary (tot_pc), Completion list (320 entries, 7 counted groups), completionpercentage_controller (+16 more)

### Community 17 - "UI Questions and Batches"
Cohesion: 0.15
Nodes (27): User interface questions (UI-, 19), HUD, colours and blips guide (R8.4), Pause menu guide (R8.1), Scaleform guide (R8.2), Server-backed screens guide (R8.5), Story-mode UI guide (R8.6), P1.1 Pause and Online menus (Done #107), P1.3 HUD, colours and blips (Done #109) (+19 more)

### Community 18 - "Economy and Pickups 2"
Cohesion: 0.17
Nodes (27): STATS natives used by the game scripts, GET_PACKED_NG_INT_STAT_KEY, _GET_STAT_HASH_FOR_CHARACTER_STAT, LEADERBOARDS_WRITE_ADD_COLUMN, STATS native namespace, PACKED_STAT_GET_INT_STAT_INDEX, PLAYSTATS_AWARD_XP, PLAYSTATS_FLOW_MEDIUM (+19 more)

### Community 19 - "TASK Natives"
Cohesion: 0.17
Nodes (27): TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS, TASK native namespace (+19 more)

### Community 20 - "Example Mod Classes"
Cohesion: 0.08
Nodes (5): HelloWorld, PlayerAndWorld, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 21 - "Story Mission Anatomy (2)"
Cohesion: 0.10
Nodes (26): Anatomy of a story mission (R5.2), armenian1 (Franklin and Lamar), Mission checkpoints, Mission cleanup, Fail function with reason labels, Force cleanup handler, Heist approach A/B and crew, jewelry_heist (The Jewel Store Job) (+18 more)

### Community 22 - "C# Example Mods"
Cohesion: 0.14
Nodes (5): Samples, NativeCalls, Examples, Six SHVDN v3 C# sample scripts, GTA natives used by the game scripts

### Community 23 - "Online DLC Storylines"
Cohesion: 0.09
Nodes (24): 183 systems in running state, DLC storylines in GTA Online, dlclist.xml pack order, fm_content_* scripts (85-91), Open questions (DLC storylines), Property intro cutscenes (289 distinct names), Rebuilding an arc offline, Per-update story flows in freemode (EXEC_FLW...HK24_FLW) (+16 more)

### Community 24 - "Story Mission Anatomy (3)"
Cohesion: 0.11
Nodes (24): Story mission table (95 entries), Flow and strand: 32 strands run by flow_controller, Missions that don't autosave (flag bit 0), Global_102466/108447/96580/96581 (checkpoint, snapshot, skip), Global_22983/22602/21591 (dialogue request and state), Global_102429 (replay controller state), Global_102481 (shop data), Global_21610 (phone state) (+16 more)

### Community 25 - "AI Architecture and Tasks 3"
Cohesion: 0.10
Nodes (23): Open questions: engine task list, status values, slot numbering, Open questions: LOD distances, frame time per ped, second CTask pool, Open questions: the second pass, AI-001 Full list of engine task classes, AI-002 Task status values measured, AI-003 Primary and secondary task slot numbering, AI-004 Distances where ped AI LOD changes, AI-005 Frame time per combat ped on low-end PC (+15 more)

### Community 26 - "Script Launch Graph"
Cohesion: 0.12
Nodes (23): Boot sequence: startup, registration scripts, standard_global_reg, main_persistent, Launch graph, first pass (R0.5): 679 edges, Gameplay questions (GP-, 86), CORE-021 Resolve table-driven launches (Mostly answered), GP-040 Who starts family_scene_* (Answered: main), Script launch graph (R0.5), P2.6 Script launch graph (Mostly done), Script launch graph (build 3725) (+15 more)

### Community 27 - "Boot and Script Control 2"
Cohesion: 0.16
Nodes (24): Every force-cleanup bit (1, 2, 4, 8, 16, 32, 64, 128), Common HAS_FORCE_CLEANUP_OCCURRED masks (3, 19, 11, 83, 2), profiler_registration (empty script, global block 2 unused), Story/Online split: NETWORK_SET_SCRIPT_IS_SAFE_FOR_NETWORK_GAME and force cleanup bit 2, Core engine questions (CORE-, 30), Category: Getting started (GS-), GTA Online questions (ON-, 66), Scripting questions (SCR-, 14) (+16 more)

### Community 28 - "Minigames and Activities 2"
Cohesion: 0.10
Nodes (24): Minigames and activities, Activity ids 0 to 18, Activity fees and pay table, Hunting score and weapon factor, Minigames are 42 entries worth 10% of completion, Mission candidate slot, Odd-job pay goes through story properties, Open questions R5.5 (+16 more)

### Community 29 - "Driving AI"
Cohesion: 0.12
Nodes (23): Driving and AI driving, Driving AI: missions, chases, aircraft and boats, How Rockstar builds a chase or race, Helicopter, plane and boat missions, TASK_VEHICLE_TEMP_ACTION manoeuvres, Vehicle mission types (TASK_VEHICLE_MISSION list), Driving style flags (786603, 786468, 262144), vehicletasks.ymt tunables (+15 more)

### Community 30 - "Audio System"
Cohesion: 0.11
Nodes (22): How audio is organised, Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, 54 sound archives (x64/audio/sfx, .awc), Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Music and radio (+14 more)

### Community 31 - "Boot and Script Control"
Cohesion: 0.10
Nodes (22): Research sources: decompile, data files, natives, in-game tests, Community decompile repository (one commit per build), Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts), Glossary, ASI, ScriptHookV, ScriptHookVDotNet, Broadcast data (player and host synced globals), Decision maker: event to ped reaction table, Global block: shared script memory owned by a registration script (+14 more)

### Community 32 - "AUDIO Natives"
Cohesion: 0.10
Nodes (21): GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CREATE_CAM, DO_SCREEN_FADE_IN (+13 more)

### Community 33 - "File-rules Workflow"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 34 - "Boot and Script Control 4"
Cohesion: 0.15
Nodes (19): Engine starts startup, initial and main, Global_1 (game started flag), Global_3 (boot into Online), Global_80281, initial script, main_persistent, main script, New game or loaded game (+11 more)

### Community 35 - "Credits and File Rules 2"
Cohesion: 0.13
Nodes (18): Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, Run under Proton or Wine with DXVK (D3D11 to Vulkan), check-system.ps1: PC requirement check, ScriptHookVDotNet 3.7.0 (+10 more)

### Community 36 - "Globals and Save Data"
Cohesion: 0.12
Nodes (19): Global_2658291[p].f_204/.f_203 per-player flag words, Global_1845250[p].f_260 stat-backed state, Global_2658291[p].f_325.f_11: interior owner, Global_2658291[p].f_325: interior the player is in, Global_1845250[p].f_97 bit-field sub-structure, Global_1583765 (personal vehicles), Global_1679103 (mission HUD timers), Global_1845250 (player broadcast data, 880/player) (+11 more)

### Community 37 - "Online Properties"
Cohesion: 0.12
Nodes (19): Interaction menu, phone and apps, app* scripts (38) business computers, Cellphone app table (cellphone_controller, flashhand), Contact services (am_contact_requests), In-game internet (appinternet, web_browser, www_*.gfx), Open questions (phone/menu), Eight vehicle-selling websites and stock slots, Business computer apps and Scaleform movies (+11 more)

### Community 38 - "Performance and Script Load"
Cohesion: 0.13
Nodes (19): 15 W laptop throttling, Load times and stutter, First three minutes hold most hitches, ON_ENTER_MP map switch (8.6 s), Open questions (load times), Driver shader cache, Measuring performance, CPU-bound vs GPU-bound resolution test (+11 more)

### Community 39 - "Physics Cost and Cleanup"
Cohesion: 0.12
Nodes (19): TYRE_GRIP / WET_GRIP / TOP_SPEED_MULT columns, Physics (folder index), Physics roadmap topics R2.1-R2.7, Vehicle physics: handling, damage and upgrades, AI driving styles (vehicleaihandlinginfo.meta), Mod-kit statMods in carcols.meta, DLC handling.meta files, Handling flag words (model/handling/damage/advanced) (+11 more)

### Community 40 - "Issue and PR Templates"
Cohesion: 0.18
Nodes (17): Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, Objects, Entities, Spawning, Vehicles (folder index) (+9 more)

### Community 41 - "Globals and Save Data (2)"
Cohesion: 0.15
Nodes (14): landing_pre_startup (empty), The global variable map (R0.4), Blocks 13 and 15: dead code, Global_3407872 (block 13), Global_3932160 (block 15), 21 global blocks of 262,144 slots, Global map open questions, gameconfig.xml PoolSizes (+6 more)

### Community 42 - "Repo Rules and Workflow 2"
Cohesion: 0.12
Nodes (18): Research tools, After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), script-launch-graph.ps1: launches via git grep, Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts, ugc-keys.ps1: key paths in UGC files (+10 more)

### Community 43 - "AI Architecture and Tasks 2"
Cohesion: 0.12
Nodes (17): Crowd thinning natives (density, non-creation area, suppress), Navmesh required region and blocking objects, Online venue peds (am_mp_peds etc.), Ambient speech voices (full and mini), RPF archives, Memory, pools and limits (R1.4), Entity limits: 256 peds, 300 vehicles, Fixed-size pools (~230) (+9 more)

### Community 44 - "RPF Archives and Music Mods (2)"
Cohesion: 0.12
Nodes (16): Surviving game updates, Asset dependency list, Protecting a working install (backup, delay, rollback), ScriptHookV build gate, update-check.ps1 tool, Update day checklist, Freemode models and head blend, Ambient speech natives (+8 more)

### Community 45 - "How GTA Online Works"
Cohesion: 0.12
Nodes (18): 63 saved creator stats (62 server-authoritative), Clothing catalogue 36,232 items, Shop ownership stats, Scuba gear outfit for 5 models, How GTA Online works, Online stats in mpstatssetup.xml (17,933), Network session and broadcast data, Script VM, natives, globals (+10 more)

### Community 46 - "Strangers and Side Content"
Cohesion: 0.11
Nodes (13): Mod-builder's cookbook, Cookbook (R12.1), update-check.ps1 tool, Cookbook: shops, Pattern: story-mode shop, Per-character cash stats SP0_TOTAL_CASH, Cookbook: spawning peds and giving them AI, Pattern: bodyguard ped (+5 more)

### Community 47 - "WEAPON Natives"
Cohesion: 0.12
Nodes (18): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+10 more)

### Community 48 - "Rockstar Creator"
Cohesion: 0.12
Nodes (17): Inside freemode (first pass), Player/server broadcast data globals, freemode_init, freemode (GTA Online main script), Host state machine (0,4,5), Open questions (freemode), Player state machine (0,11,10,2,4,5), Script events (381 kinds) (+9 more)

### Community 49 - "Repo Rules and Workflow"
Cohesion: 0.15
Nodes (9): CLAUDE.md (AI assistant instructions), GTA V Legacy build 1.0.3725.0, Game build 1.0.3725.0 (Legacy), Decompiler names change every build, Repository map, Game version (Legacy 1.0.3725.0), Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Globals, func and local numbers change every build (+1 more)

### Community 50 - "Rockstar Creator (2)"
Cohesion: 0.13
Nodes (14): Tunables block Global_262145, UGC_CREATE_MISSION / UGC_PUBLISH upload, Rockstar services, Behaviour when a service is missing, Open questions (services), Service native families (counts per service), Service guard natives, Store and transaction server (NET_GAMESERVER_*) (+6 more)

### Community 51 - "Physics Cost and Cleanup (2)"
Cohesion: 0.14
Nodes (16): Physics cost: what the simulation spends, and how scripts keep it down, Per-frame density multipliers, Freeze by default (FREEZE_ENTITY_POSITION), Physics cost test cards, Physics pools (phInstGta, StaticBounds, FragmentStore ...), Euphoria ragdoll cost, Collision, materials and shape tests, Collision loading around the focus (+8 more)

### Community 52 - "Rendering and LOD"
Cohesion: 0.15
Nodes (16): Move networks (.mrf), Rendering (folder index), Rendering roadmap topics R13.1-R13.5, Rendering, visual settings and LOD, Deferred rendering pipeline, Distant lights (20:00-06:00), LOD distance and OVERRIDE_LODSCALE_THIS_FRAME, LOD lights (250/750/2500 m) (+8 more)

### Community 53 - "APPS and DATAFILE Natives"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 54 - "Economy and Pickups (2)"
Cohesion: 0.17
Nodes (14): achievement_controller (23 IDs), Story save Global_114904 (38,592 values), Economy and pickups (R3.9), Collectable scripts (letterscraps, spaceshipparts, underwaterpickups), Collectables scripts, CREATE_PICKUP_ROTATE, Shared story money helper, SPx_MONEY_SPENT_* categories (10 + total) (+6 more)

### Community 55 - "Ambient Life (2)"
Cohesion: 0.15
Nodes (13): Streaming (R1.5), Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (optional map sections), IPLs (map sections), Load scenes (NEW_LOAD_SCENE_START), Open question: TextureQuality mapping and memory use, PIN_INTERIOR_IN_MEMORY, Request, check, release pattern (+5 more)

### Community 56 - "Story vs Online Scripts"
Cohesion: 0.16
Nodes (15): GTA Online, Online folder topic index (R7.x, R5.7, R15.x), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Force cleanup bit 2 (move to Online), Open questions (story systems), Script brain sets (1,2,4,8,9), shop_controller (always-on shops) (+7 more)

### Community 57 - "Online UI Screens"
Cohesion: 0.15
Nodes (15): am_contact_requests, appbusinesshub (business computer), appinternet (in-game websites), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID, Signed-out GTA Online alert (HUD_CONNT, NOT_CONNECTED) (+7 more)

### Community 58 - "SHVDN Scripting Guide (2)"
Cohesion: 0.15
Nodes (15): LemonUI, 07 Legacy: SHVDN v2 and NativeUI, NativeUI 1.9.0, NativeUI to LemonUI mapping, Porting v2 mod to v3, Old "v1" name redirected to v2, v2 vs v3 API differences, GUI.lua button menu library (+7 more)

### Community 59 - "Gameplay Questions"
Cohesion: 0.18
Nodes (15): Category: Gameplay (GP-), GP-007 dialogue_handler request globals (Partly answered), GP-008 subtitles and phone calls (Answered), GP-009 Who starts minigame_stats_tracker and minigame_ending_stinger (Answered: nobody), GP-013 sea-race and street-race labels (Answered), GP-015 medal result screen starter (Answered), GP-031 mission pass and fail labels (Partly answered), GP-059 menu -1392473901 (LOBBY LIST) (Partly answered) (+7 more)

### Community 60 - "Boot and Script Control 3"
Cohesion: 0.15
Nodes (14): LOBBY_AUTO_MULTIPLAYER_* flags, benchmark, director_mode, Force cleanup bits (2, 8, 64, 1, 128), freemode (MP_LAUNCH_SCRIPT stack), Launching into Online, MainTransition, Other boot paths (benchmark, Rockstar Editor, director mode) (+6 more)

### Community 61 - "Online UI Screens (2)"
Cohesion: 0.19
Nodes (13): Server-backed Online screens (R8.5), Busy spinners and warning screens, Engine-filled network pages (friends, crews, party, store, invites), What a local replacement would need, NET_GAMESERVER_IS_SESSION_VALID, Transaction server NET_GAMESERVER_*, NETWORK_HAS_VALID_ROS_CREDENTIALS, NETWORK_IS_CLOUD_AVAILABLE (+5 more)

### Community 62 - "AI Architecture and Tasks (2)"
Cohesion: 0.14
Nodes (14): CORE-002 Load phases per change-set group (Partly answered), CORE-003 What update2.rpf holds (Answered), CORE-016 Vanilla weapon array sizes (Partly answered), CORE-022 Full story save section tree (Answered), CORE-023 Save upgrade function (Answered), CORE-028 Which SRLs exist (Answered: 207), GP-004 SPx_MONEY_SPENT categories (Answered), Archives and content guide (R1.6) (+6 more)

### Community 63 - "DLC and EXTRAMETADATA Natives"
Cohesion: 0.14
Nodes (14): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA (+6 more)

### Community 64 - "GRAPHICS Natives"
Cohesion: 0.14
Nodes (14): GRAPHICS natives used by the game scripts, ANIMPOSTFX_PLAY, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, SET_TIMECYCLE_MODIFIER, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME (+6 more)

### Community 65 - "Repo Rules and Workflow 3"
Cohesion: 0.15
Nodes (13): Data files via tools/rpf-cw.ps1 and CodeWalker, Decompiled scripts (build 3725 commit), Entry template (templates/entry-template.md), Research workflow (one topic), ROADMAP.md, Using an AI assistant, Credits, Research done with Claude Code, claims checked against sources (+5 more)

### Community 66 - "Ambient Life (3)"
Cohesion: 0.17
Nodes (13): LOD settings (LodScale, MaxLodScale), Population and model budgets, Population, Open question: how caps, CityDensity and budgets combine, popcycle.dat population schedules, Script natives shaping population, popzone.ipl zone boxes, Zone attributes (scumminess, law response) (+5 more)

### Community 67 - "How GTA Online Works (2)"
Cohesion: 0.22
Nodes (13): Character switching (R6.1), CHANGE_PLAYER_PED, Wheel Online slot (MainTransition), player_controller, player_controller_b, player_scene_* arrival scenes (42-entry table), player_timetable_scene, selector (character wheel) (+5 more)

### Community 68 - "BRAIN and BUILTIN Natives"
Cohesion: 0.17
Nodes (13): CLOCK natives used by the game scripts, GET_CLOCK_HOURS, GET_POSIX_TIME, CLOCK native namespace: CLOCK natives: in-game and real time, SET_CLOCK_TIME, MISC natives used by the game scripts, CLEAR_BIT, GET_HASH_KEY (+5 more)

### Community 69 - "Rockstar Creator (3)"
Cohesion: 0.17
Nodes (12): Rockstar Creator internals: how tracks and maps are built from props, Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Open questions (creator), Placement checks and limits (200 props, 20 dynamic), Prop catalogue (1,883 entries, 59 libraries) (+4 more)

### Community 70 - "Online Property Questions"
Cohesion: 0.33
Nodes (12): Category: GTA Online (ON-), Interaction menu, phone and apps guide (R7.10), Properties guide (R7.6), ON-028 website pages and what they sell (Partly answered), ON-041 yachts and vehicles as properties (Answered), ON-042 garage capacities and vehicle slots (Partly answered), ON-043 simple-interior entrances (Partly answered), ON-044 am_mp_property_int instances (Answered) (+4 more)

### Community 71 - "DECORATOR and ENTITY Natives"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 72 - "MONEY Natives"
Cohesion: 0.17
Nodes (12): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC, NETSHOPPING native namespace, NET_GAMESERVER_BASKET_START (+4 more)

### Community 73 - "Script VM Contracts 2"
Cohesion: 0.23
Nodes (12): Compiled script (.ysc): code, statics, native table, strings, Tools, check-system.ps1: what Windows needs, CodeWalker (external dependency), dlc-scan.ps1: inventory of DLC packs, Tools stay read-only and ship no game data, rpf-cw.ps1: list and extract any archive (CodeWalker), rpf.ps1: dependency-free viewer for open archives (+4 more)

### Community 74 - "Issue and PR Templates 2"
Cohesion: 0.20
Nodes (9): Issue template: Claim a research topic, Claim a research topic issue template, Rule: one roadmap topic per branch, Verified / Known claim marking, Branch naming (research/<ID>-pass2-<what> ...), Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass), Roadmap status values (Open, Claimed, Done first pass, Done) (+1 more)

### Community 75 - "Script VM Contracts"
Cohesion: 0.20
Nodes (11): Boot and script control (R1.2), Back to story mode, Boot sequence short version, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, Mods start late, Boot open questions, Boot test cards, maintransition (story to Online, FORCE_CLEANUP(2), starts freemode) (+3 more)

### Community 76 - "Globals and Save Data (3)"
Cohesion: 0.18
Nodes (11): Global_2097536 (leaderboard rows for display), Global_2686090 (job transition gamer handles), Global_2733002 (interaction-menu local state), am_pi_menu (interaction menu), Deathmatch/KOTH/LTS/Survival boards 762, 822, 823, 791, 777, 780, fmmc_launcher (job lobby and corona), Leaderboard board IDs per screen (39 IDs), Shared leaderboard library (30 scripts) (+3 more)

### Community 77 - "Text Label Questions"
Cohesion: 0.27
Nodes (11): CORE-004 completion label text (Answered), CORE-006 Every autosave trigger (Answered), CORE-007 The 23 achievements (Answered), CORE-008 SC_MSC_ labels (Answered), Completion and autosave guide (R5.3), Text labels guide (R8.3), P1.2 Text labels (Done #108), P2.4 Completion and autosave (Done) (+3 more)

### Community 78 - "BRAIN and BUILTIN Natives (2)"
Cohesion: 0.18
Nodes (11): BRAIN natives used by the game scripts, IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, REGISTER_WORLD_POINT_SCRIPT_BRAIN, BUILTIN natives used by the game scripts, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, START_NEW_SCRIPT_WITH_ARGS (+3 more)

### Community 79 - "DLC Packs and Vehicles (2)"
Cohesion: 0.22
Nodes (10): Weapons (folder README), materials.dat material table, Fire, explosions and projectiles, Explosion damage falloff (centre to edge), explosionfx.dat VFX tags and fires, firefx.dat flammability table, Projectile ammo types (weapons.meta), Rayfire destruction objects (+2 more)

### Community 80 - "Freemode Internals"
Cohesion: 0.20
Nodes (10): 29 helper scripts launched by freemode, Job type and subtype table, Interaction menu (am_pi_menu), The job lobby (fmmc_launcher), Activity table (270 activities, 266 scripts), The corona lobby screens, End-of-job screens (FM_NXT_*), fmmc_launcher script (11 states) (+2 more)

### Community 81 - "Performance and Script Load (2)"
Cohesion: 0.22
Nodes (8): Game threads (24, Update TIME_CRITICAL), Heavily modded install script load (52 + 61), Load phases (80 to 107 s), GET_FRAME_COUNT() % 60 pattern (5,030 uses), Mod overhead: what each kind of mod costs, Open questions (mod overhead), SHVDN per-script switch cost (61 scripts), Modded startup timeline

### Online Shops Open Questions - "Online Shops Open Questions"
Cohesion: 0.29
Nodes (10): Category: Entities (ENT-), ENT-008 inside clothes_shop_mp (Answered), ENT-009 inside hairdo_shop_mp (Answered), ENT-010 overlay and micro-morph lists (Partly answered), ENT-011 restriction tag names (Answered), ENT-012 shop files across DLC packs (Answered), Online character creator guide (R6.5), Online cosmetic shops guide (R6.7) (+2 more)

### Community 84 - "Handling and How Mods Work (2)"
Cohesion: 0.25
Nodes (9): Timeline of one measured launch, ASI loader load chain (dinput8, ScriptHookV), 2. The tools you need, OpenIV, ScriptHookV, ScriptHookVDotNet, Tool paths A-D (data, C#, Lua, C++), OpenIV mods folder editing (+1 more)

### Community 85 - "Weapons"
Cohesion: 0.22
Nodes (9): Armour purchase and pickups, Weapons, Shared ammo pools, Ammu-Nation story unlocks, Bullet damage and fall-off model, Weapon components, clips, tints, 246 DLC weapon entries in 33 packs, WeaponLimitsAdjuster (+1 more)

### Community 86 - "Performance and Script Load (3)"
Cohesion: 0.22
Nodes (9): Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat, Open questions (graphics), Biggest GPU/CPU/memory costs, Game benchmark script (5 scenes) (+1 more)

### Community 87 - "Performance and Script Load (4)"
Cohesion: 0.22
Nodes (6): settings.xml (version 27) keys, Profiles for different PCs, Low-end laptop profile, Mid-range PC profile, Open questions (profiles), Strong PC profile

### Community 88 - "Rendering and LOD (2)"
Cohesion: 0.22
Nodes (9): CLEAR_AREA cleanup before and after set pieces, ADD_EXPLOSION / START_SCRIPT_FIRE usage, Clip dictionaries (.ycd), Particles and decals, Decal limit (executable-fixed), decals.dat decal table, Particle dictionaries (.ypt), Particle limits (PtFxAssetStore 400, PTFX 61 per script) (+1 more)

### Community 89 - "EVENT and FIRE Natives"
Cohesion: 0.22
Nodes (9): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions (+1 more)

### Community 90 - "Boot and Script Control 5"
Cohesion: 0.25
Nodes (8): Shared activity-type helper (212 scripts), GET_INDEX_OF_CURRENT_LEVEL, Level index 1 (levels/gta5), Level index 5: network testbed level, Level indexes, common:/data/levels/stripped (stripped.meta), Testbed transition states 39-52 (state 40 LOOK_FOR_FRESH_JOIN_TESTBED), Global_2635562 (activity timers / job session state)

### Community 91 - "Performance and Script Load (5)"
Cohesion: 0.25
Nodes (8): Windows measuring tools (PresentMon, HWiNFO), Streaming, memory and video memory, HeapAdjuster (478 to 1,950 MB), Memory over a session (private 9.1 GB), Open questions (memory), Paging causes freezes with many mods, gameconfig.xml streaming buffers and ArchiveCount, Mod cost by kind (load, memory, frame)

### Community 92 - "Economy and Pickups (3)"
Cohesion: 0.21
Nodes (5): ITEMSETS natives used by the game scripts, CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers, TRIGGER_SCRIPT_EVENT never used; _SEND_TU_SCRIPT_EVENT_NEW instead

### Community 93 - "File Rules Check"
Cohesion: 0.29
Nodes (6): Blocked extensions list, file-rules check (GitHub workflow), graphify-out exempt paths, Download-and-run (RISKY) patterns, 500 KB size limit, graphify-out knowledge graph

### Community 94 - "STREAMING Natives"
Cohesion: 0.33
Nodes (7): CAN_REGISTER_MISSION_PEDS/VEHICLES/OBJECTS, HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 95 - "Navigation and Streaming (2)"
Cohesion: 0.38
Nodes (7): Props, archetypes and doors, Door auto-open flags, Door system (ADD_DOOR_TO_SYSTEM), doortuning.meta, Rayfire destruction objects, Static vs dynamic and breakable props, CTaskNM ragdoll tasks

### Community 96 - "SHAPETEST Natives"
Cohesion: 0.24
Nodes (7): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE, _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

### Community 97 - "Issue and PR Templates (2)"
Cohesion: 0.33
Nodes (4): Pull request template, Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Verified / Known definitions, Status: first pass of 109 topics, ~95 open-question tables

### Community 98 - "New Game to Prologue"
Cohesion: 0.40
Nodes (6): flow_controller, flowintrotitle, prologue1 (mission 53), From a new game to prologue1, 19 story controllers, Strand 27, the Prologue

### Community 99 - "Issue Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 100 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 101 - "PAD Natives"
Cohesion: 0.33
Nodes (6): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace, SET_INPUT_EXCLUSIVE

### Community 102 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 103 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 104 - "SCRIPT Natives"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 105 - "Online UI Screens (3)"
Cohesion: 0.40
Nodes (5): Global_262145 (tunables), Credits & Legal tunable Global_262145.f_9321, Jobs and Playlists UGC lists, Online Options settings (PM_SETTING_*), The ONLINE tab, 22 entries

### Community 106 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 107 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 108 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 109 - "Boot and Script Control (2)"
Cohesion: 0.50
Nodes (4): Native (engine function identified by 64-bit hash; ~6,700), How scripts give tasks: give once and poll GET_SCRIPT_TASK_STATUS, Sequence tasks: OPEN/CLOSE_SEQUENCE_TASK, TASK_PERFORM_SEQUENCE, FORCE_PED_AI_AND_ANIMATION_UPDATE (552 scripts) and LOD multiplier natives

### Community 110 - "Natives as Engine API (2)"
Cohesion: 0.50
Nodes (4): Proposed physics budgets for a low-end PC, Background programs as biggest Windows-side cost, explosion.ymt explosion types, Named camera shakes

### Community 111 - "SHVDN Scripting Guide 2"
Cohesion: 0.50
Nodes (4): Function.Call(Hash.X) native calls, Native namespace coverage map (R0.8), Per-namespace native usage index, Native usage (R0.3)

### Community 112 - "Native Namespace Map"
Cohesion: 0.50
Nodes (4): LOCALIZATION natives used by the game scripts, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type

### Community 113 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 114 - "Inbox Template"
Cohesion: 0.67
Nodes (3): Issue template: Inbox, Inbox issue template (found a system no topic covers), Inbox for topics nobody covers

### Community 116 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

## Knowledge Gaps
- **692 isolated node(s):** `10 ped health configs in pedhealth.meta`, `Script health natives`, `IS_PED_INJURED as dead check`, `Health regeneration`, `Special ability natives` (+687 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 768 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Ambient Life` to `RPF Archives and Music Mods`, `Combat and AI Tuning`, `HUD Colours and Blips`, `Story Mission Anatomy`, `Natives as Engine API`, `Time Weather Wind`, `Navigation and Streaming`, `Handling and How Mods Work`, `SHVDN Scripting Guide`, `Native Usage Index`, `Credits and File Rules`, `Economy and Pickups`, `Globals and Save Data 3`, `Story Mission Anatomy (2)`, `Online DLC Storylines`, `Story Mission Anatomy (3)`, `Script Launch Graph`, `Minigames and Activities 2`, `Driving AI`, `Audio System`, `Online Properties`, `Performance and Script Load`, `Physics Cost and Cleanup`, `Issue and PR Templates`, `Globals and Save Data (2)`, `Repo Rules and Workflow 2`, `AI Architecture and Tasks 2`, `RPF Archives and Music Mods (2)`, `How GTA Online Works`, `Strangers and Side Content`, `Rockstar Creator`, `Rockstar Creator (2)`, `Physics Cost and Cleanup (2)`, `Rendering and LOD`, `Economy and Pickups (2)`, `Ambient Life (2)`, `Story vs Online Scripts`, `Ambient Life (3)`, `How GTA Online Works (2)`, `Rockstar Creator (3)`, `Script VM Contracts 2`, `Issue and PR Templates 2`, `DLC Packs and Vehicles (2)`, `Freemode Internals`, `Performance and Script Load (2)`, `Weapons`, `Performance and Script Load (3)`, `Performance and Script Load (4)`, `Rendering and LOD (2)`, `Performance and Script Load (5)`, `Navigation and Streaming (2)`, `Inbox Template`?**
  _High betweenness centrality (0.183) - this node is a cross-community bridge._
- **What connects `10 ped health configs in pedhealth.meta`, `Script health natives`, `IS_PED_INJURED as dead check` to the rest of the system?**
  _692 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `RPF Archives and Music Mods` be split into smaller, more focused modules?**
  _Cohesion score 0.056866303690260134 - nodes in this community are weakly interconnected._
- **Why does `GTA V Under the Hood: how Grand Theft Auto V works underneath` connect `Combat and AI Tuning` to `RPF Archives and Music Mods`, `HUD Colours and Blips`, `Story Mission Anatomy`, `Natives as Engine API`, `Ambient Life`, `Handling and How Mods Work`, `SHVDN Scripting Guide`, `Native Usage Index`, `Credits and File Rules`, `Economy and Pickups`, `Globals and Save Data 3`, `Story Mission Anatomy (2)`, `C# Example Mods`, `Online DLC Storylines`, `Story Mission Anatomy (3)`, `AI Architecture and Tasks 3`, `Script Launch Graph`, `Minigames and Activities 2`, `Driving AI`, `Audio System`, `Boot and Script Control`, `Credits and File Rules 2`, `Online Properties`, `Physics Cost and Cleanup`, `Issue and PR Templates`, `Globals and Save Data (2)`, `RPF Archives and Music Mods (2)`, `Strangers and Side Content`, `Rockstar Creator`, `Physics Cost and Cleanup (2)`, `Repo Rules and Workflow 3`, `Rockstar Creator (3)`, `Script VM Contracts 2`, `Script VM Contracts`, `Freemode Internals`, `Repo Rules and Workflow 4`, `Weapons`, `Issue and PR Templates (2)`?**
  _High betweenness centrality (0.161) - this node is a cross-community bridge._
- **Should `Ped Health and Death` be split into smaller, more focused modules?**
  _Cohesion score 0.07957393483709273 - nodes in this community are weakly interconnected._
- **Why does `Native usage index` connect `Native Usage Index` to `Ped Health and Death`, `Combat and AI Tuning`, `Time Weather Wind`, `Ambient Life`, `SHVDN Scripting Guide`, `DLC Packs and Vehicles`, `Economy and Pickups 2`, `TASK Natives`, `C# Example Mods`, `Driving AI`, `Repo Rules and Workflow 2`, `WEAPON Natives`, `APPS and DATAFILE Natives`, `DLC and EXTRAMETADATA Natives`, `GRAPHICS Natives`, `BRAIN and BUILTIN Natives`, `DECORATOR and ENTITY Natives`, `Script VM Contracts 2`, `BRAIN and BUILTIN Natives (2)`, `EVENT and FIRE Natives`, `Economy and Pickups (3)`, `SHVDN Scripting Guide 2`, `Native Namespace Map`, `Native Namespace Map 2`?**
  _High betweenness centrality (0.134) - this node is a cross-community bridge._
- **Should `Combat and AI Tuning` be split into smaller, more focused modules?**
  _Cohesion score 0.05723905723905724 - nodes in this community are weakly interconnected._