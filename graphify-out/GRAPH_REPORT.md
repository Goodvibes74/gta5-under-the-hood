# Graph Report - tracking  (2026-10-30)

## Corpus Check
- 245 files · ~411,534 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1931 nodes · 4033 edges · 110 communities (101 shown, 9 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 411 edges (avg confidence: 0.83)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Example Mod Classes
- C# Example Mods
- RPF Archives and Music Mods
- Strangers and Side Content
- File-rules Workflow
- Issue Config
- Ped Health and Death
- Combat and AI Tuning
- How GTA Online Works
- Native Namespace Map 2
- SAVEMIGRATION Natives
- Unknown Natives
- Time Weather Wind
- Navigation and Streaming
- Credits and File Rules
- Audio System
- Issue and PR Templates
- Online UI Screens
- SHVDN Scripting Guide
- Native Usage Index
- Performance and Script Load
- Rockstar Creator
- Physics Cost and Cleanup
- Natives as Engine API
- Rendering and LOD
- Economy and Pickups 2
- TASK Natives
- UI Questions and Batches
- Online DLC Storylines
- Handling and How Mods Work
- Script VM Contracts
- AI Architecture and Tasks
- AI Architecture and Tasks 2
- AI Architecture and Tasks 3
- Driving AI
- Online Properties
- AUDIO Natives
- Boot and Script Control
- Story Mission Anatomy
- BRAIN and BUILTIN Natives
- Completion and Autosave
- WEAPON Natives
- Credits and File Rules 2
- Weapons
- Story vs Online Scripts
- Boot and Script Control 2
- Repo Rules and Workflow
- Online Batches
- APPS and DATAFILE Natives
- DLC Packs and Vehicles
- Gameplay Questions
- Issue and PR Templates 2
- Freemode Internals
- RPF Archives and Music Mods 2
- DLC and EXTRAMETADATA Natives
- GRAPHICS Natives
- Minigames and Activities
- Boot and Script Control 3
- Entity and Shop Questions
- DECORATOR and ENTITY Natives
- HUD Colours and Blips
- MONEY Natives
- Script Launch Graph
- Script VM Contracts 2
- Random Events and IPL Swaps
- Online Property Questions
- Repo Rules and Workflow 2
- Minigames and Activities 2
- Native Namespace Map
- Repo Rules and Workflow 3
- Boot and Script Control 4
- Economy and Pickups
- Globals and Save Data 2
- Text Label Questions
- EVENT and FIRE Natives
- Boot and Script Control 5
- File Rules Check
- Boot and Script Control 6
- Replay and Editor
- Calling Natives from Mods
- Repo Rules and Workflow 4
- New Game to Prologue
- Globals and Save Data
- Boot and Script Control 7
- Boot and Script Control 8
- Replay and Editor 2
- OBJECT Natives
- PAD Natives
- PATH Natives
- PHYSICS Natives
- SCRIPT Natives
- STREAMING Natives
- Ambient Life
- Globals and Save Data 3
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- Boot and Script Control 9
- SHVDN Scripting Guide 2
- REPLAY Natives
- SECURITY Natives
- SHAPETEST Natives
- Inbox Template

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 122 edges
2. `Mod map: what to read for the mod you want to make` - 114 edges
3. `Tools` - 85 edges
4. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
5. `Native usage: which scripts call which natives` - 66 edges
6. `Native namespace map` - 60 edges
7. `Native usage index` - 57 edges
8. `PED natives used by the game scripts` - 41 edges
9. `VEHICLE natives used by the game scripts` - 41 edges
10. `PLAYER natives used by the game scripts` - 40 edges

## Surprising Connections (you probably didn't know these)
- `Verified / Known definitions` --semantically_similar_to--> `Rule: mark every claim Verified or Known`  [INFERRED] [semantically similar]
  docs/00-getting-started/glossary.md → CLAUDE.md
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `Topics that unblock others: R0.8, R0.7, R17.1` --references--> `The AI architecture`  [INFERRED]
  ROADMAP.md → docs/ai/ai-architecture.md
- `AI assistance with Claude Code and skills` --semantically_similar_to--> `Research done with Claude Code, claims checked against sources`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CREDITS.md
- `Five rules every page assumes` --semantically_similar_to--> `Rules in every language (yield, natives over memory, clean up)`  [INFERRED] [semantically similar]
  modding/cookbook/README.md → scripting/languages.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Mission pass, fail and retry flow** — docs_gameplay_missions_mission_anatomy_checkpoints, docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_pass_routine, docs_gameplay_missions_replay_director_and_editor_mission_replay [EXTRACTED 0.95]
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **Script brain to launcher to activity** — docs_gameplay_missions_strangers_and_freaks_script_brains, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_story_script_catalog_launchers [EXTRACTED 0.95]
- **Boot entry chain: startup, standard_global_reg, initial, main** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_initial_script, docs_00_getting_started_boot_main_script, docs_00_getting_started_boot_main_persistent [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Force-cleanup bits answered in P2.1** — open_questions_p2_1, open_questions_core_017, open_questions_on_060, open_questions_guide_runtime_scripts [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Native usage trio (guide, index, namespace map)** — scripting_native_usage, scripting_native_usage_index, scripting_native_namespace_map [EXTRACTED 1.00]
- **Path from story to freemode to job** — docs_online_transitions_and_sessions_maintransition, docs_online_07_freemode_freemode_script, docs_online_job_lobby_fmmc_launcher [EXTRACTED 1.00]
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
- **Online cosmetics creation, shops and saved stats** — docs_gameplay_player_online_character_creator_overlay_map, docs_gameplay_player_online_cosmetic_shops_barber, docs_gameplay_player_online_cosmetic_shops_shop_save_stats, docs_online_03_online_data_files_clothing_catalogues [INFERRED 0.85]
- **Server-backed Online dependencies** — docs_online_rockstar_services_service_families, docs_online_stats_and_tunables_tuneables_processing, docs_online_stats_and_tunables_server_transactions [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]
- **Repo contribution rules and their enforcement** — claude_markdown_only_rule, contributing_four_rules, contributing_file_rules, _github_workflows_file_rules_file_rules_check [INFERRED 0.85]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **Second-pass tracking flow** — open_questions_second_pass_process, open_questions_priority_order, open_questions_batch_concept, contributing_second_pass_phase, contributing_branch_names [INFERRED 0.85]
- **Story save, autosave and completion system** — docs_core_saves_story_save_structure, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_completion_controller, docs_core_global_map_story_save_global [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]

## Communities (110 total, 9 thin omitted)

### Community 26 - "Example Mod Classes"
Cohesion: 0.08
Nodes (5): HelloWorld, PlayerAndWorld, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 28 - "C# Example Mods"
Cohesion: 0.14
Nodes (5): NativeCalls, Samples, Six SHVDN v3 C# sample scripts, Examples, GTA natives used by the game scripts

### Community 13 - "RPF Archives and Music Mods"
Cohesion: 0.07
Nodes (31): Adding or replacing music (DLC station pack), Add-on versus replacement mods, content.xml (file list and fileType loaders), dlclist.xml (98 packs), RPF archives layout (common, x64a-w, update), setup2.xml (pack identity, order, change set groups), Save version fSaveVersion (1.7), Asset dependency list (+23 more)

### Community 36 - "Strangers and Side Content"
Cohesion: 0.11
Nodes (17): Pattern: mission skeleton (idle, setup, stages, fail, pass, cleanup), Script brain sets disabling, Cookbook (R12.1), update-check.ps1 tool, Pattern: bodyguard ped, Mod ideas list (R12.3), Script mod ideas (11), Category: graphics and visual mods (+9 more)

### Community 39 - "File-rules Workflow"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 83 - "Issue Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 0 - "Ped Health and Death"
Cohesion: 0.06
Nodes (74): script am_mp_property_int (PED), script clothes_shop_mp (PED), script fm_mission_controller (PED), script fm_mission_controller_2020 (PED), script freemode (PED), script maintransition (PED), script mp_menuped (PED), script public_mission_controller (PED) (+66 more)

### Community 1 - "Combat and AI Tuning"
Cohesion: 0.06
Nodes (58): SET_PED_KEEP_TASK and releasing mission peds to ambient population, What runs when no script is in charge: default and ambient tasks, Primary task tree and secondary tasks, Task pool of 8,192 running tasks (gameconfig.xml), Task system: everything a ped does is a task (CTask classes, nested), Test cards: poll vs re-give, keep task, 119 tuned task classes in tune files (53 combat, 23 vehicle, 21 physics...), combatbehaviour.meta combat profiles (+50 more)

### Community 10 - "How GTA Online Works"
Cohesion: 0.06
Nodes (38): selector character wheel script, Creator is part of maintransition, 63 saved creator stats (62 server-authoritative), Heritage head blend, Police line-up room, Feature micro-morph index map, Appearance overlay map, Barber shop hairdo_shop_mp (+30 more)

### Community 101 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

### Community 102 - "Unknown Natives"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

### Community 11 - "Time Weather Wind"
Cohesion: 0.11
Nodes (37): script creator (NETWORK), script fm_mission_controller (NETWORK), script fm_mission_controller_2020 (NETWORK), script fmmc_launcher (NETWORK), script freemode (NETWORK), script main_persistent (NETWORK), script maintransition (NETWORK), script pausemenu_multiplayer (NETWORK) (+29 more)

### Community 12 - "Navigation and Streaming"
Cohesion: 0.07
Nodes (34): Navmesh tiles (.ynv, 4,404), Path nodes (.ynd, road nodes), Patrol routes and cover point natives, Why peds get stuck (causes and script fixes), Patrol route building (miss_ routes), IPLs (optional map sections), Archetype definition, Door auto-open flags (+26 more)

### Community 14 - "Credits and File Rules"
Cohesion: 0.07
Nodes (35): File rules table, Using an AI assistant, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Property table in am_mp_property_ext (index to entrance coordinates), Good scripts to read next, Search with git grep and git show without checkout (+27 more)

### Community 15 - "Audio System"
Cohesion: 0.08
Nodes (34): Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, 54 sound archives (x64/audio/sfx, .awc), Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Mission music events (TRIGGER_MUSIC_EVENT), Player radio stations (RADIO_NN_*) (+26 more)

### Community 16 - "Issue and PR Templates"
Cohesion: 0.09
Nodes (30): Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Pull request checklist, Reviews and squash-merge policy, Reviews and squash-merging, Writing style, Online folder topic index (R7.x, R5.7, R15.x), Performance folder topic index (R18.x), Physics roadmap topics R2.1-R2.7 (+22 more)

### Community 17 - "Online UI Screens"
Cohesion: 0.08
Nodes (33): Global_262145 (tunables), am_contact_requests, appbusinesshub (business computer), appinternet (in-game websites), appmpemail (Online email), appmpjoblistnew (phone job list), appsecuroserv (CEO office computer), NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID (+25 more)

### Community 18 - "SHVDN Scripting Guide"
Cohesion: 0.07
Nodes (31): LemonUI, Beginner modding path (R12.6), Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini, SHVDN namespaces (GTA, GTA.UI, GTA.Native, GTA.Input...), ActionScript 2 for Scaleform UI (+23 more)

### Community 19 - "Native Usage Index"
Cohesion: 0.23
Nodes (33): MISC namespace is a junk drawer, 45 named namespaces + 2 unknown natives, Game build 3725, Decompile commit 6c18d3e8b, tools/native-usage.ps1 generator, NativeDB reference, Scripts with most natives (fm_mission_controller_2020 3166), Top 40 natives by scripts / by calls (+25 more)

### Community 2 - "Performance and Script Load"
Cohesion: 0.05
Nodes (48): Game threads (24, Update TIME_CRITICAL), Heavily modded install script load (52 + 61), 15 W laptop throttling, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat, Open questions (graphics) (+40 more)

### Community 20 - "Rockstar Creator"
Cohesion: 0.07
Nodes (32): Player/server broadcast data globals, Script events (381 kinds), Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Job type and subtype table, Open questions (creator) (+24 more)

### Community 21 - "Physics Cost and Cleanup"
Cohesion: 0.08
Nodes (29): Freeze by default (FREEZE_ENTITY_POSITION), Physics pools (phInstGta, StaticBounds, FragmentStore ...), Collision loading around the focus, material_override_pairs.dat, procedural.meta (procedural grass/plants), Shape test collision-layer flags, Shape tests (START_SHAPE_TEST_*), TYRE_GRIP / WET_GRIP / TOP_SPEED_MULT columns (+21 more)

### Community 22 - "Natives as Engine API"
Cohesion: 0.08
Nodes (26): Proposed physics budgets for a low-end PC, Background programs as biggest Windows-side cost, explosion.ymt explosion types, Synchronized scenes, Camera directors (10), Named camera shakes, cameras.ymt camera metadata, Gameplay camera hints (+18 more)

### Community 23 - "Rendering and LOD"
Cohesion: 0.09
Nodes (27): Clip dictionaries (.ycd), clip_sets.ymt clip sets, conditionalanims.meta ambient idles, Facial clip sets and expressions (.yed), Move networks (.mrf), TASK_PLAY_ANIM usage and flag bits, Decal limit (executable-fixed), Particle dictionaries (.ypt) (+19 more)

### Community 24 - "Economy and Pickups 2"
Cohesion: 0.17
Nodes (27): script am_pi_menu (STATS), script fm_mission_controller (STATS), script fm_race_creator (STATS), script fmmc_launcher (STATS), script freemode (STATS), script ingamehud (STATS), script main_persistent (STATS), script maintransition (STATS) (+19 more)

### Community 25 - "TASK Natives"
Cohesion: 0.17
Nodes (27): script agency_heist3a (TASK), script am_mp_property_int (TASK), script chinese1 (TASK), script exile2 (TASK), script fbi5a (TASK), script fm_mission_controller (TASK), script fm_mission_controller_2020 (TASK), script freemode (TASK) (+19 more)

### Community 27 - "UI Questions and Batches"
Cohesion: 0.16
Nodes (26): Category: User interface (UI-), Batch P1.1: Pause and Online menus (Done), Batch P1.3: HUD, colours and blips (Done), Batch P1.4: Scaleform movies (Done), Batch P1.5: Story-mode UI (Done), Batch P1.6: Server-backed Online screens (Done), Phase 1: the user interface, UI-001 blip sprite names (Answered) (+18 more)

### Community 29 - "Online DLC Storylines"
Cohesion: 0.09
Nodes (24): 183 systems in running state, dlclist.xml pack order, fm_content_* scripts (85-91), Open questions (DLC storylines), Property intro cutscenes (289 distinct names), Rebuilding an arc offline, Per-update story flows in freemode (EXEC_FLW...HK24_FLW), Diamond Casino Heist (targets, crew cuts) (+16 more)

### Community 3 - "Handling and How Mods Work"
Cohesion: 0.07
Nodes (41): Timeline of one measured launch, CHandlingData entries, Add-on pack vs replacement archive, ASI loader load chain (dinput8, ScriptHookV), Data mods vs script mods, Per-frame script loop, OpenIV, ScriptHookV (+33 more)

### Community 30 - "Script VM Contracts"
Cohesion: 0.09
Nodes (24): GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, Boot sequence short version, Mods start late, Flow command vocabulary, flow_controller runs strands, 57 flow flags and mission prerequisites, Flow program of 1,882 commands in 32 strands, Mission triggerers A to D (+16 more)

### Community 31 - "AI Architecture and Tasks"
Cohesion: 0.15
Nodes (21): Batch (one branch, one PR), Batch P2.3: Saves (Open), Batch P2.5: Archives and content (Open), Batch P2.6: Script launch graph (Open), Batch P2.7: Streaming and memory (Open), Batch P4.1: Story flow (Open), Batch P4.10: Skills, flying and weapons (Open), Batch P4.2: Mission anatomy and replay (Open) (+13 more)

### Community 32 - "AI Architecture and Tasks 2"
Cohesion: 0.11
Nodes (21): Modder advice: poll not re-give, sequences, block events, tune in right layer, Hard caps: 256 peds, 300 vehicles, 8,192 tasks, 950 events, 1,024 navmesh routes, MaxTotalPeds 200 (base 70) population cap below the 256 pool, Proposed safe limits for mods: 20-30 combat peds, under 150 peds, 10-15 AI vehicles, 4 ragdolls, Scripts trim cost: reduce model budget, population budgets, IS_ENTITY_ON_SCREEN, Test cards: combat cost, forced update, VehicleTimesliceMaxUpdatesPerFrame 10 (base 4); dummy and super-dummy vehicles, Crowd thinning natives (density, non-creation area, suppress) (+13 more)

### Community 33 - "AI Architecture and Tasks 3"
Cohesion: 0.11
Nodes (21): Open questions: engine task list, status values, slot numbering, Open questions: LOD distances, frame time per ped, second CTask pool, AI-001 Full list of engine task classes, AI-002 Task status values measured, AI-003 Primary and secondary task slot numbering, AI-004 Distances where ped AI LOD changes, AI-005 Frame time per combat ped on low-end PC, AI-006 What the second CTask pool (2,100) is for (+13 more)

### Community 34 - "Driving AI"
Cohesion: 0.12
Nodes (21): Personality driving ability and aggressiveness ranges, How Rockstar builds a chase or race, AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), Helicopter, plane and boat missions, TASK_VEHICLE_TEMP_ACTION manoeuvres, Vehicle mission types (TASK_VEHICLE_MISSION list), Driving style flags (786603, 786468, 262144), vehicletasks.ymt tunables (+13 more)

### Community 35 - "Online Properties"
Cohesion: 0.10
Nodes (21): app* scripts (38) business computers, Cellphone app table (cellphone_controller, flashhand), Contact services (am_contact_requests), In-game internet (appinternet, web_browser, www_*.gfx), Interaction menu (am_pi_menu), Open questions (phone/menu), Eight vehicle-selling websites and stock slots, Activity table (270 activities, 266 scripts) (+13 more)

### Community 37 - "AUDIO Natives"
Cohesion: 0.10
Nodes (21): GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CREATE_CAM, DO_SCREEN_FADE_IN (+13 more)

### Community 38 - "Boot and Script Control"
Cohesion: 0.10
Nodes (20): Research sources: decompile, data files, natives, in-game tests, Community decompile repository (one commit per build), Network-layer native usage counts (423, 360, 354, 792, 291, 142, 21 scripts), ASI, ScriptHookV, ScriptHookVDotNet, Broadcast data (player and host synced globals), Global block: shared script memory owned by a registration script, Glossary of modding and engine terms, IPL map placement groups toggled by REQUEST_IPL (+12 more)

### Community 4 - "Story Mission Anatomy"
Cohesion: 0.05
Nodes (46): Global_102466/108447/96580/96581 (checkpoint, snapshot, skip), Global_22983/22602/21591 (dialogue request and state), Global_102429 (replay controller state), Global_102481 (shop data), Global_21610 (phone state), Global_80529 (mission-passed signal), Global_80551 (flow program), Global_93156 (running-mission list) (+38 more)

### Community 40 - "BRAIN and BUILTIN Natives"
Cohesion: 0.11
Nodes (20): IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, REGISTER_WORLD_POINT_SCRIPT_BRAIN, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, START_NEW_SCRIPT_WITH_ARGS, TIMESTEP, TO_FLOAT (+12 more)

### Community 41 - "Completion and Autosave"
Cohesion: 0.13
Nodes (18): achievement_controller, completionpercentage_controller, Strand blip sprites (66 first meeting), ENABLE/DISABLE_SCRIPT_BRAIN_SET, randomchar_controller, 63-entry strangers-and-freaks table in 18 strands, Scripts that read UGC (fm_content_*, creators), Data-file mod ideas (7) (+10 more)

### Community 42 - "WEAPON Natives"
Cohesion: 0.12
Nodes (18): Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER, WEAPON native usage table (script and call counts) (+10 more)

### Community 43 - "Credits and File Rules 2"
Cohesion: 0.15
Nodes (16): C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder, WINEDLLOVERRIDES dinput8=n,b so ASI loader loads, Install dotnet48, vcrun2022, vcrun2013 into prefix with protontricks, Run under Proton or Wine with DXVK (D3D11 to Vulkan), check-system.ps1: PC requirement check, ScriptHookVDotNet 3.7.0, After reinstalling Windows checklist (+8 more)

### Community 44 - "Weapons"
Cohesion: 0.12
Nodes (16): Shared ammo pools, Bullet damage and fall-off model, Weapon components, clips, tints, 246 DLC weapon entries in 33 packs, WeaponLimitsAdjuster, weapons.meta: 91 base CWeaponInfo, Ped AI data file set (relationships, perception, combat), CWeaponInfo / CAmmoInfo definitions (+8 more)

### Community 45 - "Story vs Online Scripts"
Cohesion: 0.13
Nodes (15): freemode (GTA Online main script), Scripts that never stop (phone, building_controller), Force cleanup bit 2 (move to Online), Open questions (story systems), Script brain sets (1,2,4,8,9), shop_controller (always-on shops), Usual path into freemode, maintransition script (70 states) (+7 more)

### Community 46 - "Boot and Script Control 2"
Cohesion: 0.25
Nodes (17): Category: Core engine (CORE-), Category: Getting started (GS-), CORE-009 player broadcast data layout (Partly answered), CORE-011 blocks 13 and 15 (dead code) (Answered), CORE-012 Known rows of the global map (Answered), CORE-017 force-cleanup bits (Answered), CORE-018 how the engine starts main/initial/startup (Partly answered), CORE-019 profiler_registration (empty script) (Answered) (+9 more)

### Community 47 - "Repo Rules and Workflow"
Cohesion: 0.15
Nodes (9): GTA V Legacy build 1.0.3725.0, Game build 1.0.3725.0 (Legacy), Decompiler names change every build, Repository map, Game version (Legacy 1.0.3725.0), Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical, Globals, func and local numbers change every build, Game version table: Legacy, 1.0.3725.0, 89 DLC packs (+1 more)

### Community 48 - "Online Batches"
Cohesion: 0.13
Nodes (16): ON-028 website pages and what they sell (Partly answered), Batch P3.1: Interaction menu, phone and apps (Open), Batch P3.10: DLC storylines (Open), Batch P3.11: Creator internals (Open), Batch P3.2: The job lobby (Open), Batch P3.3: Inside freemode and sessions (Open), Batch P3.5: Stats and tunables (Open), Batch P3.9: Heists (Open) (+8 more)

### Community 49 - "APPS and DATAFILE Natives"
Cohesion: 0.12
Nodes (16): APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING, DATAFILE native namespace: DATAFILE natives: DATADICT/DATAARRAY JSON-like data and UGC, UGC_CREATE_MISSION (+8 more)

### Community 5 - "DLC Packs and Vehicles"
Cohesion: 0.09
Nodes (43): script am_vehicle_spawn (VEHICLE), script arena_carmod (VEHICLE), script carmod_shop (VEHICLE), script fm_bj_race_controler (VEHICLE), script fm_mission_controller (VEHICLE), script fm_mission_controller_2020 (VEHICLE), script fm_race_controler (VEHICLE), script freemode (VEHICLE) (+35 more)

### Community 50 - "Gameplay Questions"
Cohesion: 0.18
Nodes (15): Category: Gameplay (GP-), GP-007 dialogue_handler request globals (Partly answered), GP-008 subtitles and phone calls (Answered), GP-009 who starts minigame_stats_tracker (Answered), GP-013 sea-race and street-race labels (Answered), GP-015 medal result screen starter (Answered), GP-031 mission pass and fail labels (Partly answered), GP-059 menu -1392473901 (LOBBY LIST) (Partly answered) (+7 more)

### Community 51 - "Issue and PR Templates 2"
Cohesion: 0.15
Nodes (11): Claim a research topic issue template, Rule: one roadmap topic per branch, Verified / Known claim marking, Branch naming (research/<ID>-pass2-<what> ...), Phase 6: second pass, Phases of a topic (claim, research, write, PR, merge, second pass), Verified / Known definitions, Status: first pass of 109 topics, ~95 open-question tables (+3 more)

### Community 52 - "Freemode Internals"
Cohesion: 0.16
Nodes (14): Global_1845250 (player broadcast data, 880/player), Global_1845250[p].f_260 stat-backed state, Global_1845250[p].f_97 bit-field sub-structure, freemode_init, Host state machine (0,4,5), 29 helper scripts launched by freemode, Open questions (freemode), Player state machine (0,11,10,2,4,5) (+6 more)

### Community 53 - "RPF Archives and Music Mods 2"
Cohesion: 0.14
Nodes (12): Static vs dynamic and breakable props, Add-on ped requirements, Ped name prefixes (a_, ig_, s_, csb_ ...), pedpersonality.ymt, Special abilities on the model (AbilityType), High fall thresholds (CTaskFall tunables), NaturalMotion / Euphoria behaviours, physicstasks.ymt tuning file (+4 more)

### Community 54 - "DLC and EXTRAMETADATA Natives"
Cohesion: 0.14
Nodes (14): GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA, GET_SHOP_PED_COMPONENT, EXTRAMETADATA native namespace: EXTRAMETADATA natives: DLC shop ped, vehicle, weapon metadata (+6 more)

### Community 55 - "GRAPHICS Natives"
Cohesion: 0.14
Nodes (14): ANIMPOSTFX_PLAY, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, SET_TIMECYCLE_MODIFIER, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME, DEACTIVATE_INTERIOR_ENTITY_SET (+6 more)

### Community 56 - "Minigames and Activities"
Cohesion: 0.18
Nodes (13): Shared activity launcher template, 86 scripts empty in release, 37 launcher scripts, 146 script brains (99 world-point, 47 object), 12 groups of 584 story and shared scripts, Scripts marked to check, wardrobe_sp and wardrobe_mp, World-point and object script brains (+5 more)

### Community 57 - "Boot and Script Control 3"
Cohesion: 0.18
Nodes (12): benchmark, director_mode, freemode (MP_LAUNCH_SCRIPT stack), MainTransition, SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME, SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE (BG_SCRIPT_KICK), maintransition (character select, joining), Back to story mode (+4 more)

### Community 58 - "Entity and Shop Questions"
Cohesion: 0.23
Nodes (12): Category: Entities (ENT-), ENT-008 inside clothes_shop_mp (Answered), ENT-009 inside hairdo_shop_mp (Answered), ENT-010 overlay and micro-morph lists (Partly answered), ENT-011 restriction tag names (Answered), ENT-012 shop files across DLC packs (Answered), ON-057 the shop table (65 entries) (Answered), Batch P3.12: Story systems in an Online mode (Partly done) (+4 more)

### Community 59 - "DECORATOR and ENTITY Natives"
Cohesion: 0.17
Nodes (12): DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION, GET_ENTITY_COORDS, GET_ENTITY_MODEL (+4 more)

### Community 6 - "HUD Colours and Blips"
Cohesion: 0.07
Nodes (42): Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, ACTIVATE_FRONTEND_MENU usage, DISABLE_FRONTEND_THIS_FRAME (+34 more)

### Community 60 - "MONEY Natives"
Cohesion: 0.17
Nodes (12): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC, NETSHOPPING native namespace, NET_GAMESERVER_BASKET_START (+4 more)

### Community 61 - "Script Launch Graph"
Cohesion: 0.17
Nodes (12): Backbone, Online: selector, maintransition, freemode, fmmc_launcher, Backbone, story mode: startup, main, initial, main_persistent, Script brains: 99 world-point and 47 object brains, buddydeathresponse launched by story missions (1424), flow_controller starts story missions by hash, Launches the table misses: engine starts, script brains, name tables, Stack size per launch (e.g. 1424, 5050, 64500), Generated launch table: 679 edges, 283 callers, 230 started scripts (+4 more)

### Community 62 - "Script VM Contracts 2"
Cohesion: 0.23
Nodes (12): Compiled script (.ysc): code, statics, native table, strings, check-system.ps1: what Windows needs, CodeWalker (external dependency), dlc-scan.ps1: inventory of DLC packs, Tools stay read-only and ship no game data, rpf-cw.ps1: list and extract any archive (CodeWalker), rpf.ps1: dependency-free viewer for open archives, Ideas for new tools: global map, data-file differ (+4 more)

### Community 63 - "Random Events and IPL Swaps"
Cohesion: 0.20
Nodes (10): IPL map section switching, Restricted areas (re_armybase, re_prison), Area scripts re_armybase/re_prison/re_lossantosintl/re_yetarian, Shared random event launch check, SET_RANDOM_EVENT_FLAG / SET_MISSION_FLAG, re_* random event scripts, World brain points (ambient.ipl), UGC classic creator missions (16) (+2 more)

### Community 64 - "Online Property Questions"
Cohesion: 0.36
Nodes (11): Category: GTA Online (ON-), ON-041 yachts and vehicles as properties (Answered), ON-042 garage capacities and vehicle slots (Partly answered), ON-043 simple-interior entrances (Partly answered), ON-044 am_mp_property_int instances (Answered), ON-045 daily property fees (Answered), ON-046 business side of simple interiors (Answered), Batch P3.7: Properties (Partly done) (+3 more)

### Community 65 - "Repo Rules and Workflow 2"
Cohesion: 0.20
Nodes (10): After a game update checklist, dlc-scan.ps1: DLC pack inventory, native-usage.ps1: per-native and per-script call counts, Open tooling work (ypt lister, hash-name dictionary), script-launch-graph.ps1: launches via git grep, Techniques needing no new tool: MetaXml, hash dictionaries, archive scans, literal-argument counts, ugc-keys.ps1: key paths in UGC files, ysc-dump.ps1: script headers and strings for all 1,143 scripts (+2 more)

### Community 66 - "Minigames and Activities 2"
Cohesion: 0.20
Nodes (10): Activity ids 0 to 18, Activity fees and pay table, Hunting score and weapon factor, Minigames are 42 entries worth 10% of completion, Mission candidate slot, Odd-job pay goes through story properties, Open questions R5.5, Five rampage scripts are one script compiled five times (+2 more)

### Community 67 - "Native Namespace Map"
Cohesion: 0.16
Nodes (10): EXTRAMETADATA namespace (shop items), CREATE_ITEMSET, GET_ITEMSET_SIZE, ITEMSETS native namespace: ITEMSETS natives: item set containers, GET_CURRENT_LANGUAGE, LOCALIZATION_GET_SYSTEM_LANGUAGE, LOCALIZATION native namespace: LOCALIZATION natives: language and date type, Native tables hold NativeDB hashes (+2 more)

### Community 68 - "Repo Rules and Workflow 3"
Cohesion: 0.22
Nodes (9): Data files via tools/rpf-cw.ps1 and CodeWalker, Decompiled scripts (build 3725 commit), Research workflow (one topic), Research a topic in an hour checklist, NativeDB, Kinds of work (second pass, link, in-game test, engine RE), In-game test card, Entry template (templates/entry-template.md) (+1 more)

### Community 69 - "Boot and Script Control 4"
Cohesion: 0.28
Nodes (9): initial script, main_persistent, main script, standard_global_reg, startup_positioning, Engine starts startup, initial and main, Global_1 (game started flag), Global_80281 (+1 more)

### Community 7 - "Economy and Pickups"
Cohesion: 0.05
Nodes (30): Name labels (gameName, vehicleMakeName, HumanNameHash), 12 ped component slots and prop anchors, EXTRAMETADATA shop natives, Freemode models and head blend, Preload ped variation data, Restriction tags and forced components, Shop catalogue files (*_shop.meta), Shop scripts (clothes_shop, hairdo_shop, tattoo_shop) (+22 more)

### Community 70 - "Globals and Save Data 2"
Cohesion: 0.22
Nodes (9): gameconfig.xml PoolSizes, Boot sequence (startup, standard_global_reg, main_persistent, initial, main), Force-cleanup bits, Global block owner scripts, Script launch graph, first pass (R0.5), main watchdog launching, Script stack pools (MISSION 64,500 has one slot), Story versus Online script flags (network-safe, cleanup bit 2) (+1 more)

### Community 71 - "Text Label Questions"
Cohesion: 0.33
Nodes (9): CORE-004 completion label text (Answered), CORE-008 SC_MSC_ labels (Answered), Batch P1.2: Text labels (Done), Batch P2.4: Completion and autosave (Open), UI-016 text slots (Answered), UI-018 label-name index (Partly answered), UI-019 the eight update2.rpf blocks (Answered), Completion and autosave guide (R5.3) (+1 more)

### Community 72 - "EVENT and FIRE Natives"
Cohesion: 0.22
Nodes (9): ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions, STOP_FIRE_IN_RANGE, EVENT natives used by the game scripts (+1 more)

### Community 73 - "Boot and Script Control 5"
Cohesion: 0.25
Nodes (8): GET_INDEX_OF_CURRENT_LEVEL, Global_2635562 (activity timers / job session state), Shared activity-type helper (212 scripts), Level index 1 (levels/gta5), Level index 5: network testbed level, Level indexes, common:/data/levels/stripped (stripped.meta), Testbed transition states 39-52 (state 40 LOOK_FOR_FRESH_JOIN_TESTBED)

### Community 74 - "File Rules Check"
Cohesion: 0.29
Nodes (6): Blocked extensions list, file-rules check (GitHub workflow), graphify-out exempt paths, Download-and-run (RISKY) patterns, 500 KB size limit, graphify-out knowledge graph

### Community 75 - "Boot and Script Control 6"
Cohesion: 0.38
Nodes (7): sp_dlc_registration, sp_pilotschool_reg, startup script, Global_3 (boot into Online), Online save block g_savedMPGlobals (5,575 values), startup ready bits 0-2, 14 registration scripts started by startup

### Community 76 - "Replay and Editor"
Cohesion: 0.29
Nodes (7): replay_controller retry screen states, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder natives, Mission replay (replay_controller), NoEditorRestrictions community patch, REPLAY_RECORD_BACK_FOR_TIME usage, Replay, director mode and the Rockstar Editor

### Community 77 - "Calling Natives from Mods"
Cohesion: 0.33
Nodes (7): Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument), Calling natives from Lua (old names), Natives: built-in script functions in namespaces, Old namespace names vs current (GAMEPLAY to MISC, UI to HUD, ...), Reading a native's entry (return type, hash, pointer outputs), 05 Native functions

### Community 79 - "New Game to Prologue"
Cohesion: 0.40
Nodes (6): flow_controller, flowintrotitle, prologue1 (mission 53), From a new game to prologue1, 19 story controllers, Strand 27, the Prologue

### Community 8 - "Globals and Save Data"
Cohesion: 0.06
Nodes (36): landing_pre_startup (empty), Global_1583765 (personal vehicles), Global_1679103 (mission HUD timers), Global_1892653 (player Online state), Global_1950198 (local simple-interior state), Global_2097536 (leaderboard rows for display), Global_24529 (creator menu and text state), Global_2649159 (server broadcast data) (+28 more)

### Community 80 - "Boot and Script Control 7"
Cohesion: 0.33
Nodes (6): standard_global_init, Global_93192 (story mission table), 146 script brains, Story mission table (95 entries), Flow and strand: 32 strands run by flow_controller, Block owner scripts table

### Community 81 - "Boot and Script Control 8"
Cohesion: 0.33
Nodes (6): Decision maker: event to ped reaction table, Script brain: starts a script when player nears a place/object/ped, AI layers: perception, events, decisions, relationships, tasks, navigation, motion, LOD, Events interrupt tasks via decision maker; blocked by SET_BLOCKING_OF_NON_TEMPORARY_EVENTS, AI LOD by distance table (near, middle, far), Low-detail locomotion for far peds (CTaskMotionBasicLocomotionLowLod)

### Community 82 - "Replay and Editor 2"
Cohesion: 0.33
Nodes (6): Director mode script, player_controller_b performs the switch, Switch native usage counts, Player switch swoop natives, player_timetable_scene and player_scene_* arrival scenes, Character switching

### Community 84 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 85 - "PAD Natives"
Cohesion: 0.33
Nodes (6): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace, SET_INPUT_EXCLUSIVE

### Community 86 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 87 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 88 - "SCRIPT Natives"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 89 - "STREAMING Natives"
Cohesion: 0.40
Nodes (6): HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 9 - "Ambient Life"
Cohesion: 0.07
Nodes (35): Ambient task tunables (defaulttasks.ymt), Flying and swimming wander (birds, fish), CAmbientLookAt, CTaskAmbientClips, Open question: ambient ped despawn distance (R17.9), General and weapon event tunables, Interior pinning (PIN_INTERIOR_IN_MEMORY), Load scenes (NEW_LOAD_SCENE_START) (+27 more)

### Community 90 - "Globals and Save Data 3"
Cohesion: 0.40
Nodes (5): Global_114904 (story save), Story save block (38,592 values), autosave_controller (DO_AUTO_SAVE), Completion list (320 entries, weights to 100%), Story save structure (START_SAVE_DATA)

### Community 91 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 92 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 93 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 94 - "Boot and Script Control 9"
Cohesion: 0.50
Nodes (4): selector, LOBBY_AUTO_MULTIPLAYER_* flags, Launching into Online, freemode started by maintransition with stack 35,250; creator 28,000

### Community 95 - "SHVDN Scripting Guide 2"
Cohesion: 0.50
Nodes (4): Function.Call(Hash.X) native calls, Native namespace coverage map (R0.8), Per-namespace native usage index, Native usage (R0.3)

### Community 96 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 97 - "SECURITY Natives"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 98 - "SHAPETEST Natives"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 99 - "Inbox Template"
Cohesion: 0.67
Nodes (3): Inbox issue template (found a system no topic covers), Inbox for topics nobody covers, Issue template: Inbox

## Knowledge Gaps
- **694 isolated node(s):** `10 ped health configs in pedhealth.meta`, `Script health natives`, `IS_PED_INJURED as dead check`, `Health regeneration`, `Special ability natives` (+689 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 771 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **9 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `GTA V Under the Hood: how Grand Theft Auto V works underneath` connect `Combat and AI Tuning` to `Handling and How Mods Work`, `Story Mission Anatomy`, `HUD Colours and Blips`, `Economy and Pickups`, `Ambient Life`, `How GTA Online Works`, `Navigation and Streaming`, `RPF Archives and Music Mods`, `Credits and File Rules`, `Audio System`, `Issue and PR Templates`, `SHVDN Scripting Guide`, `Native Usage Index`, `Rockstar Creator`, `Physics Cost and Cleanup`, `Natives as Engine API`, `Rendering and LOD`, `C# Example Mods`, `Online DLC Storylines`, `Script VM Contracts`, `AI Architecture and Tasks 2`, `AI Architecture and Tasks 3`, `Driving AI`, `Online Properties`, `Strangers and Side Content`, `Boot and Script Control`, `Completion and Autosave`, `Credits and File Rules 2`, `Weapons`, `Issue and PR Templates 2`, `Freemode Internals`, `Script Launch Graph`, `Script VM Contracts 2`, `Minigames and Activities 2`, `Globals and Save Data 2`, `Repo Rules and Workflow 4`?**
  _High betweenness centrality (0.187) - this node is a cross-community bridge._
- **What connects `10 ped health configs in pedhealth.meta`, `Script health natives`, `IS_PED_INJURED as dead check` to the rest of the system?**
  _694 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Example Mod Classes` be split into smaller, more focused modules?**
  _Cohesion score 0.08307692307692308 - nodes in this community are weakly interconnected._
- **Why does `Research roadmap` connect `Completion and Autosave` to `Ped Health and Death`, `Combat and AI Tuning`, `Performance and Script Load`, `Handling and How Mods Work`, `Story Mission Anatomy`, `DLC Packs and Vehicles`, `HUD Colours and Blips`, `Economy and Pickups`, `Ambient Life`, `How GTA Online Works`, `Time Weather Wind`, `Navigation and Streaming`, `RPF Archives and Music Mods`, `Credits and File Rules`, `Audio System`, `Issue and PR Templates`, `SHVDN Scripting Guide`, `Native Usage Index`, `Rockstar Creator`, `Physics Cost and Cleanup`, `Natives as Engine API`, `Rendering and LOD`, `Online DLC Storylines`, `Script VM Contracts`, `AI Architecture and Tasks 2`, `Driving AI`, `Online Properties`, `Strangers and Side Content`, `Weapons`, `Story vs Online Scripts`, `Issue and PR Templates 2`, `Freemode Internals`, `RPF Archives and Music Mods 2`, `Minigames and Activities`, `Script Launch Graph`, `Script VM Contracts 2`, `Random Events and IPL Swaps`, `Repo Rules and Workflow 2`, `Minigames and Activities 2`, `Globals and Save Data 2`, `Replay and Editor`, `Replay and Editor 2`, `Inbox Template`?**
  _High betweenness centrality (0.180) - this node is a cross-community bridge._
- **Should `C# Example Mods` be split into smaller, more focused modules?**
  _Cohesion score 0.14333333333333334 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Strangers and Side Content` to `Ped Health and Death`, `Combat and AI Tuning`, `Performance and Script Load`, `Handling and How Mods Work`, `Story Mission Anatomy`, `DLC Packs and Vehicles`, `HUD Colours and Blips`, `Economy and Pickups`, `Globals and Save Data`, `Ambient Life`, `Time Weather Wind`, `Navigation and Streaming`, `RPF Archives and Music Mods`, `Credits and File Rules`, `Audio System`, `Issue and PR Templates`, `SHVDN Scripting Guide`, `Rockstar Creator`, `Physics Cost and Cleanup`, `Natives as Engine API`, `Rendering and LOD`, `C# Example Mods`, `Online DLC Storylines`, `Script VM Contracts`, `AI Architecture and Tasks 2`, `Driving AI`, `Boot and Script Control`, `Completion and Autosave`, `Weapons`, `Freemode Internals`, `RPF Archives and Music Mods 2`, `Minigames and Activities`, `Script Launch Graph`, `Minigames and Activities 2`, `Calling Natives from Mods`, `Replay and Editor 2`?**
  _High betweenness centrality (0.144) - this node is a cross-community bridge._
- **Should `RPF Archives and Music Mods` be split into smaller, more focused modules?**
  _Cohesion score 0.06756756756756757 - nodes in this community are weakly interconnected._