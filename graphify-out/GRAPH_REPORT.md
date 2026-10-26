# Graph Report - gta5-under-the-hood  (2026-10-26)

## Corpus Check
- 245 files · ~408,452 words
- Verdict: corpus is large enough that graph structure adds value.
- Unclassified: 3 file(s) not represented in the graph (top: (none) 3)

## Summary
- 1668 nodes · 3697 edges · 86 communities (79 shown, 7 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 363 edges (avg confidence: 0.83)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Ped Health and Death
- Performance and Script Load
- Combat and AI Tuning
- Boot and Script Control
- Repo Rules and Workflow
- Issue and PR Templates
- DLC Packs and Vehicles
- Handling and How Mods Work
- Physics Cost and Cleanup
- AI Architecture and Tasks
- HUD Colours and Blips
- Economy and Pickups
- Time Weather Wind
- Credits and File Rules
- Navigation and Streaming
- SHVDN Scripting Guide
- Audio System
- Strangers and Side Content
- RPF Archives and Music Mods
- Population Budgets and Shops
- C# Example Mods
- Native Namespace Map
- Ambient Life
- TASK Natives
- Example Mod Classes
- Minigames and Activities
- Online DLC Storylines
- Appearance and Clothing
- Completion and Autosave
- Driving AI
- Globals and Save Data
- AUDIO Natives
- File-rules Workflow
- BRAIN and BUILTIN Natives
- Native Usage Index
- Freemode Internals
- Rockstar Creator
- Interiors and Collision
- Weapons
- Script VM Contracts
- How GTA Online Works
- APPS and DATAFILE Natives
- Natives as Engine API
- Story Mission Anatomy
- Story vs Online Scripts
- Online UI Screens
- WEAPON Natives
- Rendering and LOD
- DLC and EXTRAMETADATA Natives
- GRAPHICS Natives
- Script Launch Graph
- Mission Flow Controller
- Replay and Editor
- Online Sync and Events
- Tunables and Online Store
- Online Properties
- DECORATOR and ENTITY Natives
- MONEY Natives
- Controls and Camera Input
- Calling Natives from Mods
- EVENT and FIRE Natives
- Random Events and IPL Swaps
- Cameras and Synced Scenes
- Issue Config
- OBJECT Natives
- PAD Natives
- PATH Natives
- PHYSICS Natives
- SCRIPT Natives
- STREAMING Natives
- RECORDING Natives
- SOCIALCLUB Natives
- WATER Natives
- REPLAY Natives
- SECURITY Natives
- SHAPETEST Natives
- Inbox Template
- SAVEMIGRATION Natives
- Community 78

## God Nodes (most connected - your core abstractions)
1. `Research roadmap` - 128 edges
2. `Open questions: the second pass` - 120 edges
3. `Mod map: what to read for the mod you want to make` - 114 edges
4. `Tools` - 86 edges
5. `GTA V Under the Hood: how Grand Theft Auto V works underneath` - 71 edges
6. `Native usage: which scripts call which natives` - 67 edges
7. `Native namespace map` - 61 edges
8. `Native usage index` - 57 edges
9. `Contributing` - 47 edges
10. `PED natives used by the game scripts` - 41 edges

## Surprising Connections (you probably didn't know these)
- `Research a topic in an hour checklist` --semantically_similar_to--> `Research workflow (one topic)`  [INFERRED] [semantically similar]
  docs/00-getting-started/research-tools.md → CLAUDE.md
- `Verified / Known definitions` --semantically_similar_to--> `Rule: mark every claim Verified or Known`  [INFERRED] [semantically similar]
  docs/00-getting-started/glossary.md → CLAUDE.md
- `AI assistance with Claude Code and skills` --semantically_similar_to--> `Research done with Claude Code, claims checked against sources`  [INFERRED] [semantically similar]
  docs/00-getting-started/toolbox.md → CREDITS.md
- `Match the build: commit "Update for 1.72-3725.0", 1,143 scripts SHA-256 identical` --semantically_similar_to--> `Game build 1.0.3725.0 (Legacy)`  [INFERRED] [semantically similar]
  docs/00-getting-started/decompiled-scripts.md → CLAUDE.md
- `Game version table: Legacy, 1.0.3725.0, 89 DLC packs` --semantically_similar_to--> `Game build 1.0.3725.0 (Legacy)`  [INFERRED] [semantically similar]
  docs/00-getting-started/setup.md → CLAUDE.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **The four rules that never bend (Markdown only, no Rockstar code, no mods, mark claims)** — contributing_rule_markdown_only, contributing_rule_no_rockstar_code, contributing_rule_no_other_mods, contributing_rule_mark_every_claim [EXTRACTED 1.00]
- **Story boot script chain: startup, standard_global_init/reg, main_persistent, initial** — docs_00_getting_started_boot_startup_script, docs_00_getting_started_boot_standard_global_init, docs_00_getting_started_boot_standard_global_reg, docs_00_getting_started_boot_main_persistent, docs_00_getting_started_boot_initial_script [EXTRACTED 1.00]
- **Runtime prerequisites for modded Windows install** — docs_00_getting_started_system_requirements_directx_june_2010, docs_00_getting_started_system_requirements_vcpp_2015_2022, docs_00_getting_started_system_requirements_vcpp_2013_lua, docs_00_getting_started_system_requirements_dotnet_framework_48 [EXTRACTED 1.00]
- **Crime to wanted stars to dispatch pipeline** — docs_ai_perception_and_events_can_call_police, docs_ai_wanted_level_and_police_crimeinformation_meta, docs_ai_wanted_level_and_police_points_to_stars, docs_ai_police_and_services_dispatch_meta [INFERRED 0.85]
- **Ped reaction data chain (personality, decision maker, combat info, relationship group)** — docs_ai_decisions_and_personalities_ped_ai_chain, docs_ai_combat_and_perception_events_decision_makers, docs_ai_combat_and_perception_combatbehaviour_meta, docs_ai_relationships_and_groups_default_groups [EXTRACTED 1.00]
- **Story save, autosave and completion system** — docs_core_saves_story_save_structure, docs_core_completion_and_autosave_autosave_controller, docs_core_completion_and_autosave_completion_controller, docs_core_global_map_story_save_global [INFERRED 0.85]
- **Ambient population system (zones, schedules, scenarios, car generators)** — docs_entities_spawning_population_popcycle_dat, docs_entities_spawning_scenarios_scenario_points, docs_entities_spawning_vehicle_generators_and_traffic_car_generators, docs_entities_spawning_population_zonebind_ymt [INFERRED 0.85]
- **Registering add-on content (meta, text, content.xml)** — docs_entities_vehicles_vehicles_add_on_vehicle_pack, docs_entities_objects_text_and_names_dlc_text_registration, docs_entities_peds_peds_add_on_ped [INFERRED 0.75]
- **Mission pass, fail and retry flow** — docs_gameplay_missions_mission_anatomy_checkpoints, docs_gameplay_missions_mission_anatomy_fail_function, docs_gameplay_missions_mission_anatomy_pass_routine, docs_gameplay_missions_replay_director_and_editor_mission_replay [EXTRACTED 0.95]
- **Script brain to launcher to activity** — docs_gameplay_missions_strangers_and_freaks_script_brains, docs_gameplay_missions_minigames_and_activities_shared_launcher, docs_gameplay_missions_story_script_catalog_launchers [EXTRACTED 0.95]
- **Online cosmetics creation, shops and saved stats** — docs_gameplay_player_online_character_creator_overlay_map, docs_gameplay_player_online_cosmetic_shops_barber, docs_gameplay_player_online_cosmetic_shops_shop_save_stats, docs_online_03_online_data_files_clothing_catalogues [INFERRED 0.85]
- **Path from story to freemode to job** — docs_online_transitions_and_sessions_maintransition, docs_online_07_freemode_freemode_script, docs_online_job_lobby_fmmc_launcher [EXTRACTED 1.00]
- **Server-backed Online dependencies** — docs_online_rockstar_services_service_families, docs_online_stats_and_tunables_tuneables_processing, docs_online_stats_and_tunables_server_transactions [INFERRED 0.85]
- **Low-end PC tuning cluster** — docs_performance_graphics_settings_settings_xml, docs_performance_memory_and_vram_memory_budgets, docs_performance_mod_overhead_mod_cost_kinds, docs_performance_pc_profiles_low_end_profile [INFERRED 0.85]
- **Rockstar's physics-cost controls (freeze, clear, density, disable)** — docs_performance_physics_cost_freeze_by_default, docs_performance_physics_cost_clear_area_cleanup, docs_performance_physics_cost_density_multipliers [EXTRACTED 1.00]
- **Material-keyed data: physics, fire and effects** — docs_physics_collision_and_materials_materials_dat, docs_physics_fire_explosions_projectiles_firefx_dat, docs_rendering_particles_and_decals_effects_data_files [INFERRED 0.85]
- **Scaleform + frontend.xml + hudcolor.dat UI stack** — docs_ui_scaleform_gfx_archives, docs_ui_pause_menu_frontend_xml_placement, docs_ui_hud_colours_blips_hudcolor_dat [INFERRED 0.75]
- **Modding path steps 1-9** — modding_01_how_mods_work, modding_02_tools_you_need, modding_03_install_and_check, modding_04_first_data_edit, modding_05_first_csharp_mod, modding_06_first_lua_script, modding_07_first_asi_mod, modding_08_debugging, modding_09_next_steps_and_sharing [EXTRACTED 1.00]
- **File format reference pages** — file_formats_data_file_atlas, file_formats_handling_meta, file_formats_materials_dat, file_formats_ped_ai_data, file_formats_rpf, file_formats_ugc_json, file_formats_weapons_meta, file_formats_ysc [EXTRACTED 1.00]
- **Cookbook pattern pages** — modding_cookbook_menus_menu_pattern, modding_cookbook_missions_mission_skeleton_pattern, modding_cookbook_vehicles_and_handling_addon_car_pattern, modding_cookbook_weapons_weapon_loadout_pattern, modding_cookbook_spawning_and_ai_bodyguard_pattern, modding_cookbook_world_and_map_placed_scene_pattern [EXTRACTED 1.00]
- **Native usage trio (guide, index, namespace map)** — scripting_native_usage, scripting_native_usage_index, scripting_native_namespace_map [EXTRACTED 1.00]
- **Script runtimes: C#, Lua, legacy v2** — scripting_csharp_shvdn3, scripting_lua, scripting_legacy_shvdn2, scripting_languages [INFERRED 0.85]
- **Native namespace usage tables (build 3725)** — scripting_native_usage_apps, scripting_native_usage_audio, scripting_native_usage_camera, scripting_native_usage_entity, scripting_native_usage_graphics, scripting_native_usage_hud, scripting_native_usage_misc [EXTRACTED 0.95]
- **In-game economy native flow** — scripting_native_usage_money, scripting_native_usage_netshopping, scripting_native_usage_stats [INFERRED 0.75]
- **Replay recording natives** — scripting_native_usage_recording, scripting_native_usage_replay, scripting_native_usage_savemigration [INFERRED 0.65]
- **Generated native usage tables** — scripting_native_usage_weapon, scripting_native_usage_zone, tools_readme_nativeusage [EXTRACTED 1.00]
- **Rules for mods running beside the VM** — scripting_script_vm_waitpattern, scripting_script_vm_forcecleanup, scripting_natives_engine_api_contracts [INFERRED 0.85]
- **Script task sequence build-and-run flow** — scripting_native_usage_task_open_sequence_task, scripting_native_usage_task_close_sequence_task, scripting_native_usage_task_task_perform_sequence [INFERRED 0.85]
- **Network entity ownership and lookup** — scripting_native_usage_network_network_has_control_of_entity, scripting_native_usage_network_network_request_control_of_entity, scripting_native_usage_network_net_to_veh [INFERRED 0.85]
- **Player identity natives used everywhere** — scripting_native_usage_player_player_id, scripting_native_usage_player_player_ped_id, scripting_native_usage_player_get_player_ped [INFERRED 0.85]

## Communities (86 total, 7 thin omitted)

### Community 0 - "Ped Health and Death"
Cohesion: 0.06
Nodes (74): Health, armour, death and arrest, 10 ped health configs in pedhealth.meta, Health floor of 100, Script health natives, IS_PED_INJURED as dead check, Health regeneration, Seven skill stats with 100-point pool, Player skills and abilities (+66 more)

### Community 1 - "Performance and Script Load"
Cohesion: 0.05
Nodes (48): Game threads (24, Update TIME_CRITICAL), Heavily modded install script load (52 + 61), 15 W laptop throttling, Graphics settings, one by one, commandline.txt launch switches, Settings file vs menu label mismatch, Settings the menu does not show, Cost order on low-end laptop: memory, CPU, GPU, heat (+40 more)

### Community 2 - "Combat and AI Tuning"
Cohesion: 0.06
Nodes (50): Combat and AI (first pass), combatbehaviour.meta combat profiles, events.meta decision makers and responses, Melee action tables (action definitions.meta), pedaccuracy.meta accuracy modifiers, pedperception.meta profiles, relationships.dat groups, Script fight recipe (relationship, attributes, task, keep task) (+42 more)

### Community 3 - "Boot and Script Control"
Cohesion: 0.05
Nodes (48): Boot and script control: from launch to control, and between story and Online, Return to story via SHUTDOWN_AND_LAUNCH_SINGLE_PLAYER_GAME, Boot sequence: engine and loaders, startup, standard_global_reg, main_persistent, initial/main, mods, Online, Timeline of one measured launch (about 107 s to playable), Force cleanup bits (2 ends story, 8/64/1 replay, 8/64 benchmark), initial and main scripts, Launching into Online: selector starts MainTransition, freemode on MP_LAUNCH_SCRIPT stack, Level index 5 is checked 215 times, mostly Online content (+40 more)

### Community 4 - "Repo Rules and Workflow"
Cohesion: 0.06
Nodes (36): Game build 1.0.3725.0 (Legacy), Decompiler names change every build, Repository map, Research sources: decompile, data files, natives, in-game tests, Research workflow (one topic), Game version: Legacy build 1.0.3725.0, Using an AI assistant, Reading the decompiled game scripts (+28 more)

### Community 5 - "Issue and PR Templates"
Cohesion: 0.07
Nodes (41): Issue template: Claim a research topic, Claim a research topic issue template, Pull request template, Pull request checklist (Markdown only, template, Verified/Known, build, no personal data, links, roadmap, toolbox), Rule: one roadmap topic per branch, Contributing, Branch naming scheme, Reviews and squash-merge policy (+33 more)

### Community 6 - "DLC Packs and Vehicles"
Cohesion: 0.08
Nodes (42): Stale modded update.rpf, DLC text registration (dlctext.meta, TEXTFILE_METAFILE), Car generators (CCarGen), DLC pack inventory (89 packs), Vehicles, Add-on vehicle pack requirements, carcols mod kits and sirens, carvariations (+34 more)

### Community 7 - "Handling and How Mods Work"
Cohesion: 0.08
Nodes (35): handling.meta, CHandlingData entries, 1. How mods work, Add-on pack vs replacement archive, ASI loader load chain (dinput8, ScriptHookV), Data mods vs script mods, Per-frame script loop, 2. The tools you need (+27 more)

### Community 8 - "Physics Cost and Cleanup"
Cohesion: 0.05
Nodes (42): CLEAR_AREA cleanup before and after set pieces, Freeze by default (FREEZE_ENTITY_POSITION), Proposed physics budgets for a low-end PC, Background programs as biggest Windows-side cost, Collision, materials and shape tests, Collision loading around the focus, material_override_pairs.dat, materials.dat material table (+34 more)

### Community 9 - "AI Architecture and Tasks"
Cohesion: 0.08
Nodes (40): The AI architecture, SET_PED_KEEP_TASK and releasing mission peds to ambient population, Modder advice: poll not re-give, sequences, block events, tune in right layer, What runs when no script is in charge: default and ambient tasks, Open questions: engine task list, status values, slot numbering, Primary task tree and secondary tasks, Task pool of 8,192 running tasks (gameconfig.xml), Task system: everything a ped does is a task (CTask classes, nested) (+32 more)

### Community 10 - "HUD Colours and Blips"
Cohesion: 0.08
Nodes (40): HUD, colours and blips, Blip natives lifecycle, Blip sprites and BLIP_<n> labels, frontend.xml HUD components (54), HIDE_HUD_COMPONENT_THIS_FRAME, hudcolor.dat colour table, Radar and minimap interiors, Pause and Online menus (+32 more)

### Community 11 - "Economy and Pickups"
Cohesion: 0.10
Nodes (35): Economy and pickups, Collectables scripts, pickup_controller script, stock_controller (BAWSAQ/LCN), Story money stats (SPx_TOTAL_CASH), Cookbook: weapons, weapons.meta, weaponcomponents.meta, loadouts.meta, Pattern: weapon loadout (+27 more)

### Community 12 - "Time Weather Wind"
Cohesion: 0.11
Nodes (37): Time, weather and wind, Game clock natives, Online clock override, respawn_controller weather reroll, WeatherCycles fixed list, Persistent weather lock natives, weather.xml (types, cycles, GPU fx), Wind (WindMin/WindMax, SET_WIND) (+29 more)

### Community 13 - "Credits and File Rules"
Cohesion: 0.07
Nodes (36): File rules check (file-rules workflow), Credits, Research done with Claude Code, claims checked against sources, Credits to community projects (CodeWalker, OpenIV, ScriptHookV, SHVDN, NativeDB, decompiler, LemonUI, NativeUI, iFruitAddon2, ILSpy, Menyoo), Rockstar/Take-Two trademark and non-affiliation notice, Playing and modding on Linux, C++ .asi on Linux via clang-cl and xwin (untested), Developing mods on Linux: C# via NuGet reference assemblies, Lua, C++ harder (+28 more)

### Community 14 - "Navigation and Streaming"
Cohesion: 0.08
Nodes (33): Navigation and pathfinding, Navmesh tiles (.ynv, 4,404), Path nodes (.ynd, road nodes), Why peds get stuck (causes and script fixes), Streaming: how assets get into memory, Interior pinning (PIN_INTERIOR_IN_MEMORY), IPLs (optional map sections), Load scenes (NEW_LOAD_SCENE_START) (+25 more)

### Community 15 - "SHVDN Scripting Guide"
Cohesion: 0.07
Nodes (33): LemonUI, Steps 5/6/7 are alternatives (C#, Lua, C++), 02 Scripting with ScriptHookVDotNet v3 (C#), Function.Call(Hash.X) native calls, Script lifecycle (constructor, Tick, KeyDown, Aborted), ScriptSettings ini loading, ScriptHookVDotNet v3 (SHVDN 3.7.0.189), SHVDN F4 console and ScriptHookVDotNet.ini (+25 more)

### Community 16 - "Audio System"
Cohesion: 0.08
Nodes (33): How audio is organised, Audio config files (.dat*.rel), Audio scenes (START_AUDIO_SCENE), PLAY_SOUND* natives and sound sets, Script audio banks and streams, 54 sound archives (x64/audio/sfx, .awc), Sound ID lifecycle pattern (GET_SOUND_ID to RELEASE_SOUND_ID), Music and radio (+25 more)

### Community 17 - "Strangers and Side Content"
Cohesion: 0.07
Nodes (26): Strangers, freaks and side content, Strand blip sprites (66 first meeting), ENABLE/DISABLE_SCRIPT_BRAIN_SET, randomchar_controller, 63-entry strangers-and-freaks table in 18 strands, Cookbook: menus, DISABLE_CONTROL_ACTION / DISABLE_FRONTEND_THIS_FRAME, Pattern: trainer-style menu (+18 more)

### Community 18 - "RPF Archives and Music Mods"
Cohesion: 0.08
Nodes (26): Adding or replacing music (DLC station pack), Archives and the content system, Add-on versus replacement mods, content.xml (file list and fileType loaders), dlclist.xml (98 packs), RPF archives layout (common, x64a-w, update), setup2.xml (pack identity, order, change set groups), Static vs dynamic and breakable props (+18 more)

### Community 19 - "Population Budgets and Shops"
Cohesion: 0.07
Nodes (29): LOD scale settings in settings.xml, Population and model budgets, Name labels (gameName, vehicleMakeName, HumanNameHash), 12 ped component slots and prop anchors, Shop catalogue files (*_shop.meta), Peds, Add-on ped requirements, Ped name prefixes (a_, ig_, s_, csb_ ...) (+21 more)

### Community 20 - "C# Example Mods"
Cohesion: 0.11
Nodes (10): Samples, NativeCalls, Examples, Six SHVDN v3 C# sample scripts, Beginner modding path (R12.6), Languages for modding GTA V, ActionScript 2 for Scaleform UI, Languages for modding (R12.4) (+2 more)

### Community 21 - "Native Namespace Map"
Cohesion: 0.10
Nodes (28): Native namespace map, EXTRAMETADATA namespace (shop items), MISC namespace is a junk drawer, Decompiler vs NativeDB namespace names (CAM=CAMERA...), Native namespace coverage map (R0.8), 45 named namespaces + 2 unknown natives, AUDIO natives used by the game scripts, BRAIN natives used by the game scripts (+20 more)

### Community 22 - "Ambient Life"
Cohesion: 0.09
Nodes (26): Ambient life, Ambient task tunables (defaulttasks.ymt), Flying and swimming wander (birds, fish), CAmbientLookAt, CTaskAmbientClips, Open question: ambient ped despawn distance (R17.9), General and weapon event tunables, Scenarios and ambient life (+18 more)

### Community 23 - "TASK Natives"
Cohesion: 0.17
Nodes (27): TASK natives used by the game scripts, CLEAR_PED_TASKS, CLEAR_PED_TASKS_IMMEDIATELY, CLOSE_SEQUENCE_TASK, CREATE_PATROL_ROUTE, GET_IS_TASK_ACTIVE, GET_SCRIPT_TASK_STATUS, TASK native namespace (+19 more)

### Community 24 - "Example Mod Classes"
Cohesion: 0.08
Nodes (5): HelloWorld, PlayerAndWorld, LemonMenuSample, PhoneContactSample, SettingsAndText

### Community 25 - "Minigames and Activities"
Cohesion: 0.09
Nodes (26): Minigames and activities, Activity ids 0 to 18, Activity fees and pay table, Hunting score and weapon factor, Minigames are 42 entries worth 10% of completion, Mission candidate slot, Odd-job pay goes through story properties, Open questions R5.5 (+18 more)

### Community 26 - "Online DLC Storylines"
Cohesion: 0.09
Nodes (24): 183 systems in running state, DLC storylines in GTA Online, dlclist.xml pack order, fm_content_* scripts (85-91), Open questions (DLC storylines), Property intro cutscenes (289 distinct names), Rebuilding an arc offline, Per-update story flows in freemode (EXEC_FLW...HK24_FLW) (+16 more)

### Community 27 - "Appearance and Clothing"
Cohesion: 0.09
Nodes (24): Appearance and clothing, EXTRAMETADATA shop natives, Freemode models and head blend, Preload ped variation data, Restriction tags and forced components, Shop scripts (clothes_shop, hairdo_shop, tattoo_shop), Tattoos and decals as decorations, Online cutscene handles MP_1 to MP_4 (+16 more)

### Community 28 - "Completion and Autosave"
Cohesion: 0.12
Nodes (20): Completion, autosave and achievements, achievement_controller, completionpercentage_controller, Core engine (folder index), Saves: what the story save holds and how scripts write it, Save version fSaveVersion (1.7), Surviving game updates, Asset dependency list (+12 more)

### Community 29 - "Driving AI"
Cohesion: 0.12
Nodes (21): Personality driving ability and aggressiveness ranges, Driving and AI driving, Driving AI: missions, chases, aircraft and boats, How Rockstar builds a chase or race, AI handling profiles (SPORTS_CAR, AVERAGE, CRAP, TRUCK), Helicopter, plane and boat missions, TASK_VEHICLE_TEMP_ACTION manoeuvres, Vehicle mission types (TASK_VEHICLE_MISSION list) (+13 more)

### Community 30 - "Globals and Save Data"
Cohesion: 0.10
Nodes (21): autosave_controller (DO_AUTO_SAVE), Completion list (320 entries, weights to 100%), The global variable map, Dead blocks 13 and 15, Global blocks (21 blocks of 262,144 slots), Never hard-code global indices, Player broadcast data globals, Global_114904 story save (+13 more)

### Community 31 - "AUDIO Natives"
Cohesion: 0.10
Nodes (21): GET_SOUND_ID, IS_SCRIPTED_CONVERSATION_ONGOING, AUDIO native namespace: AUDIO natives: sounds, speech, music, radio, conversations, PLAY_SOUND_FRONTEND, START_AUDIO_SCENE, TRIGGER_MUSIC_EVENT, CREATE_CAM, DO_SCREEN_FADE_IN (+13 more)

### Community 32 - "File-rules Workflow"
Cohesion: 0.10
Nodes (19): BASE_PR, BASE_PUSH, runs-on, steps, jobs, file-rules, name, permissions (+11 more)

### Community 33 - "BRAIN and BUILTIN Natives"
Cohesion: 0.11
Nodes (20): IS_WORLD_POINT_WITHIN_BRAIN_ACTIVATION_RANGE, BRAIN native namespace: BRAIN natives: script brains (object and world point), REGISTER_OBJECT_SCRIPT_BRAIN, REGISTER_WORLD_POINT_SCRIPT_BRAIN, BUILTIN native namespace: BUILTIN natives: math, timers, script launch, START_NEW_SCRIPT_WITH_ARGS, TIMESTEP, TO_FLOAT (+12 more)

### Community 34 - "Native Usage Index"
Cohesion: 0.36
Nodes (20): Game build 3725, Decompile commit 6c18d3e8b, tools/native-usage.ps1 generator, NativeDB reference, MONEY natives used by the game scripts, NETSHOPPING natives used by the game scripts, OBJECT natives used by the game scripts, PAD natives used by the game scripts (+12 more)

### Community 35 - "Freemode Internals"
Cohesion: 0.13
Nodes (18): Inside freemode (first pass), freemode_init, Host state machine (0,4,5), 29 helper scripts launched by freemode, Open questions (freemode), Player state machine (0,11,10,2,4,5), Interaction menu, phone and apps, Cellphone app table (cellphone_controller, flashhand) (+10 more)

### Community 36 - "Rockstar Creator"
Cohesion: 0.12
Nodes (18): Rockstar Creator internals: how tracks and maps are built from props, Columnar save format (sparse columns), creator hub script + eight creator scripts, Fixtures removed / CREATE_MODEL_HIDE (40 max), Fly camera and 2,400 m cursor ray, Job type and subtype table, Open questions (creator), Placement checks and limits (200 props, 20 dynamic) (+10 more)

### Community 37 - "Interiors and Collision"
Cohesion: 0.11
Nodes (14): Physics pools (phInstGta, StaticBounds, FragmentStore ...), Collision bounds (.ybn), Interior map movies (int<hash>.gfx), Interiors and IPLs, building_controller and maintransition IPL swaps, Interior entity sets, Pin / unpin interiors in memory, REQUEST_IPL / REMOVE_IPL (+6 more)

### Community 38 - "Weapons"
Cohesion: 0.12
Nodes (16): Weapons (folder README), Weapons, Shared ammo pools, Bullet damage and fall-off model, Weapon components, clips, tints, 246 DLC weapon entries in 33 packs, WeaponLimitsAdjuster, weapons.meta: 91 base CWeaponInfo (+8 more)

### Community 39 - "Script VM Contracts"
Cohesion: 0.12
Nodes (17): Contracts Rockstar keeps (request, release, create, clean up), The script VM: how GTA V runs its scripts, and how mods run beside them, Compiled script (.ysc): code, statics, native table, strings, Force cleanup bits (1, 2, 4, 8, 16, 32, 64, 128), Lua plugin (LUA.asi) as a ScriptHookV script, Advice for modders: yield, gate, do not raise bits 1, 64, 128, Open questions: bits 4/16/32, priorities, event layout, duplicate pools, Thread priority (SET_THIS_THREAD_PRIORITY, SET_SCRIPT_HIGH_PRIO) (+9 more)

### Community 40 - "How GTA Online Works"
Cohesion: 0.13
Nodes (16): selector character wheel script, Creator is part of maintransition, How GTA Online works, maintransition starts freemode, Online stats in mpstatssetup.xml (17,933), Network session and broadcast data, Script VM, natives, globals, What depends on Rockstar servers (+8 more)

### Community 41 - "APPS and DATAFILE Natives"
Cohesion: 0.12
Nodes (16): APPS natives used by the game scripts, APP_HAS_LINKED_SOCIAL_CLUB_ACCOUNT, APP_SET_BLOCK, APPS native namespace: Social Club app data natives (APP_*), DATAFILE natives used by the game scripts, DATAARRAY_GET_INT, DATADICT_GET_ARRAY, DATAFILE_IS_SAVE_PENDING (+8 more)

### Community 42 - "Natives as Engine API"
Cohesion: 0.13
Nodes (15): Natives as the engine API: kinds, contracts and costs, Ask-then-wait (REQUEST_ / HAS_..._LOADED), Deferred shape tests (START_SHAPE_TEST_* / GET_SHAPE_TEST_RESULT), START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, What each native family can't do, Handle guards (DOES_ENTITY_EXIST, IS_ENTITY_DEAD), Slow, heavy or risky natives, Advice for modders: follow Rockstar's contracts (+7 more)

### Community 43 - "Story Mission Anatomy"
Cohesion: 0.14
Nodes (15): Anatomy of a story mission, Full cleanup function, Single fail function with reason numbers, Heist approach A/B and crew, Mission main loop and stage switch, Mission flag SET_MISSION_FLAG, Skip this section after two fails, Five-state step variable (restart, setup, run, finish, skip) (+7 more)

### Community 44 - "Story vs Online Scripts"
Cohesion: 0.15
Nodes (15): freemode (GTA Online main script), Story systems that clash with an Online mode, Scripts that never stop (phone, building_controller), Force cleanup bit 2 (move to Online), Open questions (story systems), Script brain sets (1,2,4,8,9), shop_controller (always-on shops), Transitions and sessions (+7 more)

### Community 45 - "Online UI Screens"
Cohesion: 0.14
Nodes (14): ONLINE tab is MISSION_CREATOR screen, Busiest movies (mp_mm_card_freemode, instructional_buttons ...), Server-backed Online screens, Busy spinners and warning screens, Local replacement requirements, NET_GAMESERVER_* transaction server, Seven Online server services, ONLINE tab entry-by-entry (+6 more)

### Community 46 - "WEAPON Natives"
Cohesion: 0.13
Nodes (15): WEAPON natives used by the game scripts, Air defence sphere natives, Ammo natives (ADD_AMMO_TO_PED, SET_PED_AMMO, ...), GET_CURRENT_PED_WEAPON, GIVE_WEAPON_TO_PED, HAS_PED_GOT_WEAPON, SET_CURRENT_PED_WEAPON, SET_WEAPON_DAMAGE_MODIFIER (+7 more)

### Community 47 - "Rendering and LOD"
Cohesion: 0.16
Nodes (14): Move networks (.mrf), Rendering, visual settings and LOD, Deferred rendering pipeline, Distant lights (20:00-06:00), LOD distance and OVERRIDE_LODSCALE_THIS_FRAME, LOD lights (250/750/2500 m), visualsettings.dat tuning file, Timecycle and post effects (+6 more)

### Community 48 - "DLC and EXTRAMETADATA Natives"
Cohesion: 0.14
Nodes (14): DLC natives used by the game scripts, GET_IS_LOADING_SCREEN_ACTIVE, IS_DLC_PRESENT, DLC native namespace: DLC natives: DLC presence and loading screen state, ON_ENTER_MP, EXTRAMETADATA natives used by the game scripts, DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG, GET_DLC_VEHICLE_DATA (+6 more)

### Community 49 - "GRAPHICS Natives"
Cohesion: 0.14
Nodes (14): GRAPHICS natives used by the game scripts, ANIMPOSTFX_PLAY, BEGIN_SCALEFORM_MOVIE_METHOD, CASCADE_SHADOWS_INIT_SESSION, GRAPHICS native namespace: GRAPHICS natives: scaleforms, particle FX, decals, timecycle, bink, SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT, SET_TIMECYCLE_MODIFIER, ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME (+6 more)

### Community 50 - "Script Launch Graph"
Cohesion: 0.15
Nodes (13): script-launch-graph.ps1: launches via git grep, Script launch graph (build 3725), Backbone, Online: selector, maintransition, freemode, fmmc_launcher, Backbone, story mode: startup, main, initial, main_persistent, Script brains: 99 world-point and 47 object brains, buddydeathresponse launched by story missions (1424), flow_controller starts story missions by hash, Launches the table misses: engine starts, script brains, name tables (+5 more)

### Community 51 - "Mission Flow Controller"
Cohesion: 0.15
Nodes (13): Checkpoints and player snapshot, Pass routine and running-mission list, The story mission flow: how missions unlock, Flow command vocabulary, flow_controller runs strands, 57 flow flags and mission prerequisites, Flow program of 1,882 commands in 32 strands, Flow state in story save f_9092 (+5 more)

### Community 52 - "Replay and Editor"
Cohesion: 0.15
Nodes (13): replay_controller retry screen states, Replay, director mode and the Rockstar Editor, ACTIVATE_ROCKSTAR_EDITOR, Clip recorder natives, Director mode script, Mission replay (replay_controller), NoEditorRestrictions community patch, REPLAY_RECORD_BACK_FOR_TIME usage (+5 more)

### Community 53 - "Online Sync and Events"
Cohesion: 0.17
Nodes (12): Player/server broadcast data globals, Script events (381 kinds), Race rebuilds props locally (static local, dynamic host-networked), Sessions and sync, Host and player broadcast blocks, Mission entity reservation budget, Network scripts and participants, Networked entities, ownership and control (+4 more)

### Community 54 - "Tunables and Online Store"
Cohesion: 0.17
Nodes (10): Tunables block Global_262145, In-game internet (appinternet, web_browser, www_*.gfx), Buying, prices and 50% trade-in, Store and transaction server (NET_GAMESERVER_*), Stats, tunables and the server's role, mpstatssetup.xml (17,928 stats), Open questions (stats), Server transactions (basket, checkout) (+2 more)

### Community 55 - "Online Properties"
Cohesion: 0.17
Nodes (12): app* scripts (38) business computers, Business computer apps and Scaleform movies, Properties in GTA Online, Garage sizes and 607 personal vehicle records, Per-owner interior instances (rows 0 to 31), Open questions (properties), Ownership slots and stats, Property exterior/interior script pair (+4 more)

### Community 56 - "DECORATOR and ENTITY Natives"
Cohesion: 0.17
Nodes (12): DECORATOR natives used by the game scripts, DECOR_EXIST_ON, DECOR_REGISTER, DECOR_SET_INT, DECORATOR native namespace: DECORATOR natives: entity decorators (key-value tags), ENTITY natives used by the game scripts, DOES_ENTITY_EXIST, FREEZE_ENTITY_POSITION (+4 more)

### Community 57 - "MONEY Natives"
Cohesion: 0.17
Nodes (12): MONEY native namespace, NETWORK_BUY_ITEM, NETWORK_CAN_SPEND_MONEY, NETWORK_CASINO_BUY_CHIPS, NETWORK_EARN_FROM_AMBIENT_JOB, NETWORK_SPENT_GENERIC, NETSHOPPING native namespace, NET_GAMESERVER_BASKET_START (+4 more)

### Community 58 - "Controls and Camera Input"
Cohesion: 0.20
Nodes (11): Controls and camera, INPUT_* control actions and IDs up to 401, Three control groups, Control meta files, DISABLE_CONTROL_ACTION usage, SET_INPUT_EXCLUSIVE, Camera view mode per context, Key codes and control IDs (+3 more)

### Community 59 - "Calling Natives from Mods"
Cohesion: 0.24
Nodes (10): 05 Native functions, Calling natives from C++ (natives.hpp, invoke), Calling natives from C# (Function.Call, OutputArgument), Finding the native you need, Calling natives from Lua (old names), NativeDB (natives.json), Natives: built-in script functions in namespaces, Old namespace names vs current (GAMEPLAY to MISC, UI to HUD, ...) (+2 more)

### Community 60 - "EVENT and FIRE Natives"
Cohesion: 0.22
Nodes (9): EVENT natives used by the game scripts, ADD_SHOCKING_EVENT_FOR_ENTITY, EVENT native namespace: EVENT natives: shocking events and decision maker, SUPPRESS_SHOCKING_EVENTS_NEXT_FRAME, FIRE natives used by the game scripts, ADD_EXPLOSION, IS_ENTITY_ON_FIRE, FIRE native namespace: FIRE natives: fire and explosions (+1 more)

### Community 61 - "Random Events and IPL Swaps"
Cohesion: 0.29
Nodes (7): IPL map section switching, Restricted areas (re_armybase, re_prison), Random events, Area scripts re_armybase/re_prison/re_lossantosintl/re_yetarian, Shared random event launch check, SET_RANDOM_EVENT_FLAG / SET_MISSION_FLAG, World brain points (ambient.ipl)

### Community 62 - "Cameras and Synced Scenes"
Cohesion: 0.29
Nodes (7): Synchronized scenes, Cameras, Camera directors (10), cameras.ymt camera metadata, Gameplay camera hints, Screen fades and widescreen borders, Script camera create/render/destroy pattern

### Community 63 - "Issue Config"
Cohesion: 0.33
Nodes (5): blank_issues_enabled, contact_links, about, name, url

### Community 64 - "OBJECT Natives"
Cohesion: 0.33
Nodes (6): CREATE_OBJECT, DELETE_OBJECT, DOOR_SYSTEM_SET_DOOR_STATE, GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS, IS_POINT_IN_ANGLED_AREA, OBJECT native namespace

### Community 65 - "PAD Natives"
Cohesion: 0.33
Nodes (6): DISABLE_CONTROL_ACTION, INIT_PC_SCRIPTED_CONTROLS, IS_CONTROL_JUST_PRESSED, IS_USING_KEYBOARD_AND_MOUSE, PAD native namespace, SET_INPUT_EXCLUSIVE

### Community 66 - "PATH Natives"
Cohesion: 0.33
Nodes (6): ADD_NAVMESH_BLOCKING_OBJECT, GET_CLOSEST_VEHICLE_NODE, GET_NTH_CLOSEST_VEHICLE_NODE, PATH native namespace, REQUEST_PATH_NODES_IN_AREA_THIS_FRAME, SET_ROADS_IN_ANGLED_AREA

### Community 67 - "PHYSICS Natives"
Cohesion: 0.33
Nodes (6): ACTIVATE_PHYSICS, ADD_ROPE, PHYSICS native namespace, SET_DISABLE_FRAG_DAMAGE, SET_IN_ARENA_MODE, SET_USE_KINEMATIC_PHYSICS

### Community 68 - "SCRIPT Natives"
Cohesion: 0.33
Nodes (6): GET_EVENT_DATA, GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH, SCRIPT native namespace, REQUEST_SCRIPT, _SEND_TU_SCRIPT_EVENT_NEW, TERMINATE_THIS_THREAD

### Community 69 - "STREAMING Natives"
Cohesion: 0.40
Nodes (6): HAS_MODEL_LOADED, IS_PLAYER_SWITCH_IN_PROGRESS, STREAMING native namespace, NEW_LOAD_SCENE_START_SPHERE, REQUEST_MODEL, SET_MODEL_AS_NO_LONGER_NEEDED

### Community 70 - "RECORDING Natives"
Cohesion: 0.40
Nodes (5): RECORDING native namespace, REPLAY_PREVENT_RECORDING_THIS_FRAME, REPLAY_RECORD_BACK_FOR_TIME, REPLAY_START_EVENT, STOP_REPLAY_RECORDING

### Community 71 - "SOCIALCLUB Natives"
Cohesion: 0.40
Nodes (5): SOCIALCLUB native namespace, SC_INBOX_SET_MESSAGE_AS_READ_AT_INDEX, SC_LICENSEPLATE_ADD, SC_PRESENCE_ATTR_SET_INT, SC_PROFANITY_CHECK_STRING

### Community 72 - "WATER Natives"
Cohesion: 0.40
Nodes (5): GET_WATER_HEIGHT_NO_WAVES, MODIFY_WATER, WATER native namespace, SET_DEEP_OCEAN_SCALER, TEST_PROBE_AGAINST_WATER

### Community 73 - "REPLAY Natives"
Cohesion: 0.50
Nodes (4): ACTIVATE_ROCKSTAR_EDITOR, REPLAY native namespace, REPLAY_SYSTEM_HAS_REQUESTED_A_SCRIPT_CLEANUP, SET_REPLAY_SYSTEM_PAUSED_FOR_SAVE

### Community 74 - "SECURITY Natives"
Cohesion: 0.50
Nodes (4): FORCE_CHECK_SCRIPT_VARIABLES, SECURITY native namespace, REGISTER_SCRIPT_VARIABLE, UNREGISTER_SCRIPT_VARIABLE

### Community 75 - "SHAPETEST Natives"
Cohesion: 0.50
Nodes (4): GET_SHAPE_TEST_RESULT, SHAPETEST native namespace, START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE, START_SHAPE_TEST_CAPSULE

### Community 76 - "Inbox Template"
Cohesion: 0.67
Nodes (3): Issue template: Inbox, Inbox issue template (found a system no topic covers), Inbox for topics nobody covers

### Community 77 - "SAVEMIGRATION Natives"
Cohesion: 0.67
Nodes (3): SAVEMIGRATION native namespace, SAVEMIGRATION_IS_MP_ENABLED, SAVEMIGRATION_MP_REQUEST_ACCOUNTS

### Community 78 - "Community 78"
Cohesion: 0.67
Nodes (3): _0x0F7082C60FB479EF, _0x8F5D1AD832AEB06C, UNKNOWN native namespace

## Knowledge Gaps
- **630 isolated node(s):** `Issue template: Inbox`, `Repository map`, `Writing style guide`, `Reviews and squash-merge policy`, `Learn to code by modding GTA V` (+625 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 702 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Research roadmap` connect `Ambient Life` to `Ped Health and Death`, `Performance and Script Load`, `Combat and AI Tuning`, `Boot and Script Control`, `Repo Rules and Workflow`, `Issue and PR Templates`, `DLC Packs and Vehicles`, `Handling and How Mods Work`, `Physics Cost and Cleanup`, `AI Architecture and Tasks`, `HUD Colours and Blips`, `Economy and Pickups`, `Time Weather Wind`, `Credits and File Rules`, `Navigation and Streaming`, `SHVDN Scripting Guide`, `Audio System`, `Strangers and Side Content`, `RPF Archives and Music Mods`, `Population Budgets and Shops`, `C# Example Mods`, `Native Namespace Map`, `Minigames and Activities`, `Online DLC Storylines`, `Appearance and Clothing`, `Completion and Autosave`, `Driving AI`, `Globals and Save Data`, `Freemode Internals`, `Rockstar Creator`, `Interiors and Collision`, `Weapons`, `Script VM Contracts`, `How GTA Online Works`, `Natives as Engine API`, `Story Mission Anatomy`, `Story vs Online Scripts`, `Online UI Screens`, `Rendering and LOD`, `Script Launch Graph`, `Mission Flow Controller`, `Replay and Editor`, `Online Sync and Events`, `Tunables and Online Store`, `Online Properties`, `Controls and Camera Input`, `Random Events and IPL Swaps`, `Cameras and Synced Scenes`, `Inbox Template`?**
  _High betweenness centrality (0.182) - this node is a cross-community bridge._
- **What connects `Issue template: Inbox`, `Repository map`, `Writing style guide` to the rest of the system?**
  _630 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Ped Health and Death` be split into smaller, more focused modules?**
  _Cohesion score 0.055905220288781934 - nodes in this community are weakly interconnected._
- **Why does `Mod map: what to read for the mod you want to make` connect `Strangers and Side Content` to `Ped Health and Death`, `Performance and Script Load`, `Combat and AI Tuning`, `Boot and Script Control`, `Repo Rules and Workflow`, `Issue and PR Templates`, `DLC Packs and Vehicles`, `Handling and How Mods Work`, `Physics Cost and Cleanup`, `AI Architecture and Tasks`, `HUD Colours and Blips`, `Economy and Pickups`, `Time Weather Wind`, `Navigation and Streaming`, `SHVDN Scripting Guide`, `Audio System`, `RPF Archives and Music Mods`, `Population Budgets and Shops`, `C# Example Mods`, `Ambient Life`, `Minigames and Activities`, `Online DLC Storylines`, `Appearance and Clothing`, `Completion and Autosave`, `Driving AI`, `Globals and Save Data`, `Freemode Internals`, `Rockstar Creator`, `Interiors and Collision`, `Weapons`, `Script VM Contracts`, `Natives as Engine API`, `Story Mission Anatomy`, `Online UI Screens`, `Rendering and LOD`, `Script Launch Graph`, `Mission Flow Controller`, `Replay and Editor`, `Controls and Camera Input`, `Calling Natives from Mods`?**
  _High betweenness centrality (0.147) - this node is a cross-community bridge._
- **Should `Performance and Script Load` be split into smaller, more focused modules?**
  _Cohesion score 0.054426705370101594 - nodes in this community are weakly interconnected._
- **Why does `Native namespace map` connect `Native Namespace Map` to `Ped Health and Death`, `Repo Rules and Workflow`, `DLC Packs and Vehicles`, `AI Architecture and Tasks`, `Economy and Pickups`, `Time Weather Wind`, `SHVDN Scripting Guide`, `Audio System`, `RPF Archives and Music Mods`, `Ambient Life`, `TASK Natives`, `Native Usage Index`, `Interiors and Collision`, `APPS and DATAFILE Natives`, `Natives as Engine API`, `WEAPON Natives`, `DLC and EXTRAMETADATA Natives`, `GRAPHICS Natives`, `DECORATOR and ENTITY Natives`, `Calling Natives from Mods`, `EVENT and FIRE Natives`?**
  _High betweenness centrality (0.137) - this node is a cross-community bridge._
- **Should `Combat and AI Tuning` be split into smaller, more focused modules?**
  _Cohesion score 0.06448979591836734 - nodes in this community are weakly interconnected._