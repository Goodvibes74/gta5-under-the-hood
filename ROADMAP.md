# Research roadmap

Every research topic, its status, and what is left to find out. **53 of 106 topics** have a first-pass guide. Pick any **Open** topic, claim it as [CONTRIBUTING.md](/CONTRIBUTING.md) explains, and send a pull request.

**Status values:** **Open** (nobody on it), **Claimed** (`@user`, branch name: someone is on it), **Done (first pass)** (a guide exists; second passes, checks and corrections are welcome), **Done** (reviewed and checked in game). Sizes: **S** an evening, **M** a few sessions, **L** a week or more.

## Where to begin

- **New to this?** Want to make a mod first? Follow the [modding path](/modding/README.md). Want to research? Read [getting started](/docs/00-getting-started/README.md), then one finished guide in an area you like (for example [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) or [vehicle handling](/docs/physics/vehicle-handling.md)) to see how a topic is written up.
- **Good first topics** (S or M, mostly data files, no deep script reading): R2.6 time and weather, R3.8 health and arrest, R9.3 music and radio, R13.2 timecycles, R14.4 text and names, R8.3 text labels, R18.6 Windows and drivers.
- **Topics that unblock others:** R0.8 the native namespace map, R0.7 the data file atlas, R17.1 the AI architecture.
- **Second passes:** every finished guide ends with an "Open questions" table. Each row is a ready-made small task.

## What is done (first pass)

| ID | Guide |
| --- | --- |
| R0.1 | [Story and shared script catalog](/docs/gameplay/missions/story-script-catalog.md): the 584 non-Online scripts in 12 groups |
| R0.2 | [Runtime scripts](/docs/core/runtime-scripts.md): boot order, the always-running scripts, stack pools, global blocks |
| R0.4 | [Global variable map](/docs/core/global-map.md): the 21 global blocks, the busiest globals and their roles, story mode's traced globals |
| R0.6 | [Research toolkit](/docs/00-getting-started/research-tools.md) (first pass): all eight tools, techniques for binary metadata, hash names, archive-wide counts, map files, text and literal arguments, and a "research a topic in an hour" checklist |
| R0.8 | [Native namespace map](/scripting/native-namespace-map.md): all 45 namespaces with size, scripts, calls, what each covers and which topic owns it |
| R1.4 | [Memory, pools and limits](/docs/core/memory-and-pools.md): the pools in `gameconfig.xml`, the 256-ped and 300-vehicle limits, what limit adjusters change, how scripts stay under the limits |
| R1.5 | [Streaming](/docs/core/streaming.md): request, check, release for every asset type; Rockstar polls instead of blocking; load scenes, focus, streaming volumes, SRLs, IPLs, interiors, LOD and population budgets |
| R1.6 | [Archives and the content system](/docs/core/archives-and-content.md): RPFs, `dlclist.xml`, `setup2.xml` orders, `content.xml` file types, the mods folder, add-on vs replacement |
| R0.3 | [Native usage](/scripting/native-usage.md): the native tables hold NativeDB hashes; 1,013 scripts import 6,575 natives and make 12.3 million calls, with a [per-namespace index](/scripting/native-usage-index.md) of who uses what |
| R0.5 (started) | [Script launch graph](/scripting/script-launch-graph.md): 679 "who starts whom" edges |
| R1.1 | [The script VM](/scripting/script-vm.md): script format, threads, waits, events, force cleanup |
| R1.2 | [Boot](/docs/00-getting-started/boot.md): launch to control, new vs loaded game, story to Online and back |
| R2.1 | [Collision and materials](/docs/physics/collision-and-materials.md): 213 materials, shape tests, collision streaming |
| R2.2 | [Vehicle handling](/docs/physics/vehicle-handling.md): handling.meta, flags, damage, upgrades, DLC handling |
| R2.5 | [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) (first pass): the 85 explosion types (36 base, 49 DLC) with damage, radius and push, the 22 flammable materials, the 80 projectile ammo types, how scripts start and detect fire and explosions |
| R2.6 | [Time, weather and wind](/docs/world/time-and-weather.md) (first pass): the 17 weather types, the 173-entry weather cycle and its odds, how scripts lock and release weather, the death reroll, the clock and Online's clock override, wind |
| R2.7 | [Physics cost](/docs/performance/physics-cost.md) (first pass): physics pools vanilla vs modded, what each simulation costs, how Rockstar keeps physics cheap, proposed budgets and tests |
| R3.1 | [Weapons](/docs/gameplay/weapons/weapons.md): weapons.meta, damage model, ammo, story Ammu-Nation unlocks |
| R3.2 | [Combat and perception](/docs/ai/combat-and-perception.md): relationships, events, combat profiles, accuracy, melee |
| R3.5 | [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md) (first pass): breath 10 to 40 s and stamina 10 to 90 s, drowning, scuba gear and its 5 models, dive heights, the 60-second sea edge, how missions remove the breath limit, boat and sub hooks |
| R3.8 | [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (first pass): the 10 health configs and their thresholds (the 100 floor), which peds use which, armour and Ammu-Nation, regeneration, the death and arrest checks, how scripts change health |
| R4.3 | [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (first pass): 22,506 car generators in the map files, the 116 population schedules and 55 vehicle groups, trains (2 of 12 tracks run), the 14 dispatch services, how scripts thin and block traffic |
| R5.1 | [Story flow](/docs/gameplay/missions/story-flow.md): the 94-mission table and the flow program |
| R5.2 | [Mission anatomy](/docs/gameplay/missions/mission-anatomy.md): stages, checkpoints, retry, fail, pass, cleanup |
| R5.6 | [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md): the cutscene sequence, dressing actors, exit states, Online `MP_1` handles, how every conversation is built |
| R5.7 | [Story systems in an Online mode](/docs/online/story-systems-in-online-mode.md): what keeps running, force cleanup and brain sets, `shop_controller` and its shops |
| R5.8 | [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) (first pass): the mission replay vs the clip recorder vs director mode, how missions mark and block recording, director mode menus, 27 travel locations and rules, the editor patch |
| R6.1 | [Character switching](/docs/gameplay/player/character-switching.md) (first pass): the wheel, the script that performs the switch, the swoop natives step by step, arrival scenes |
| R6.2 | [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md) (first pass): the 5 hospitals and 7 police stations, the death charge (5%, max $5,000) and the arrest charge and weapon loss, what a respawn resets, how missions hold the restart, Online respawn |
| R6.3 | [Appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) (first pass): component slots and prop anchors, freemode faces, tattoos and shirt prints, the shop catalogue files and the natives that read them, the shop scripts |
| R6.4 | [Controls and camera](/docs/gameplay/player/controls-and-camera.md) (first pass): control actions and IDs (to 401), the binding files, the three control groups, which controls Rockstar's scripts disable and check most, claiming input, and first and third person view modes |
| R7.1 | [Inside freemode](/docs/online/07-freemode.md): GTA Online's main script |
| R7.2 | [Transitions and sessions](/docs/online/transitions-and-sessions.md) (first pass): `maintransition`'s 70 named states, the paths into freemode, the creator and back, session and server natives, what 382 scripts read |
| R7.3 | [Stats, tunables and the server's role](/docs/online/stats-and-tunables.md) (first pass): 17,928 stats by type and family, 28,502 tunables with their defaults in one script, transactions, what an offline mode must replace |
| R7.4 | [UGC mission files](/file-formats/ugc-json.md) (first pass): 16,500 key paths in the 1,001 local files, content files vs classic creator missions, and which scripts read each |
| R8.3 | [Text labels](/docs/ui/text-labels.md) (first pass): the `.gxt2` format, 610 text blocks and 278,749 labels (plus 186,875 from DLC), 13 languages, mission text slots, the text commands scripts use, and how a mod shows or adds text |
| R9.3 | [Music and radio](/docs/audio/music-and-radio.md) (first pass): the radio stations in the audio game data and their names, hidden interior stations, 1,547 mission music events, how scripts tune, lock and duck the radio, and how music is added or replaced |
| R11 | [Surviving game updates](/docs/core/surviving-updates.md): what an update breaks, the update-day checklist, rules for update-proof code, how to find risky code in a mod |
| R12.4 | [Languages for modding](/scripting/languages.md): what to learn for which kind of mod, and in what order |
| R12.6 | [Modding path](/modding/README.md): from nothing to a first data edit and a first C#, Lua and C++ mod, debugging, and releasing a mod safely |
| R13.2 | [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md) (first pass): weather timecycles, the 1,072 timecycle modifiers and what they change, the 252 animated post effects as stacks of modifiers, how scripts set and clear them |
| R13.3 | [Particles and decals](/docs/rendering/particles-and-decals.md) (first pass): the 364 particle dictionaries and their quality copies, the effect data files, the 259 decal definitions, the pool and per-script limits, how scripts load, start and clean up effects and decals |
| R13.5 | [Cameras](/docs/rendering/cameras.md) (first pass): the 1,545 camera settings in `cameras.ymt` and the 10 directors, the 4 script camera kinds and how missions use them, the gameplay camera, hints, view modes, shakes and fades |
| R14.4 | [Text and names in content](/docs/entities/objects/text-and-names.md) (first pass): the name labels in `vehicles.meta` and `weapons.meta`, 879 vehicles checked against the text (4 unnamed), makers, weapons, how DLC packs register names, and what an add-on needs |
| R18.1 | [Measuring performance](/docs/performance/measuring.md): frame time and hitches, the game's 5-scene benchmark script, frame timing from a script, reading a session, Windows tools |
| R18.2 | [Graphics settings](/docs/performance/graphics-settings.md) (first pass): every `settings.xml` key with its range, cost and values for weak, mid and strong PCs; hidden keys; `commandline.txt` |
| R18.3 | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md) (first pass): heap, pools, streaming buffers, shared video memory and Windows commit; why more mods means paging freezes on a shared-memory laptop |
| R18.4 | [CPU](/docs/performance/cpu.md) (first pass): the 24 PC game threads and their priorities, why the main `Update` thread (simulation, AI, every script) is the limit, population and density, a heavily modded install's script load, throttling |
| R18.5 | [Mod overhead](/docs/performance/mod-overhead.md) (first pass): load time, memory and frame time by kind of mod, a heavily modded startup step by step, finding the heavy mod, idle-free patterns |
| R18.6 | [Windows and drivers](/docs/performance/windows-and-drivers.md) (first pass): power, Game Mode, background recording, startup programs, page file and free space, drivers, integrated vs dedicated graphics, a pre-play checklist |
| R18.7 | [Profiles for different PCs](/docs/performance/pc-profiles.md) (first pass): settings for a low-end laptop, a mid-range and a strong PC, and mod sets per use |
| R18.8 | [Load times and stutter](/docs/performance/load-times.md) (first pass): what a load is made of, why the first minutes hitch, shader cache, what helps |

Also written before the topic list existed: [how Online works](/docs/online/01-how-online-works.md), the [Online script catalog](/docs/online/02-script-catalog.md) (all 1,143 scripts), [Online data files on disk](/docs/online/03-online-data-files.md), [DLC packs and their vehicles](/docs/entities/vehicles/dlc-packs.md), and the [scripting guides](/scripting/README.md).

## R0. Foundations: map every script and the tools to read them

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R0.1 | **Script catalog, story and shared scripts** | Break the 584 scripts outside the Online groups into groups (story missions by strand, strangers and freaks, random events, minigames, activities, launchers, controllers and systems, world objects, arcade games, debug and test), with one line per script on what it does. Extends guide 2. | M | **Done** (first pass): [guide](/docs/gameplay/missions/story-script-catalog.md) |
| R0.2 | **Script cards for the runtime scripts** | A short card for each script that runs always or controls others (`startup`, `main`, `main_persistent`, `standard_global_init`, `flow_controller`, `respawn_controller`, `cellphone_controller`, `shop_controller`, `selector`, `maintransition`, `freemode`, `ingamehud` ...): when it starts, what starts it, what it starts, globals it owns, its main loop. | M | **Done** (first pass): [guide](/docs/core/runtime-scripts.md) |
| R0.3 | **Native names for the native tables** | Turn each script's native table (hashes for this build) into names with a crossmap, so we can list every script that uses a native family (`NET_GAMESERVER_*`, `STAT_*`, `TASK_*`, `CUTSCENE_*`). Output: a per-script native list and a per-native script list. | M | **Done** (first pass): [guide](/scripting/native-usage.md) |
| R0.4 | **Global variable map** | Which global blocks exist, which script registers each (`standard_global_init`, `globals_fmmc_struct_registration`, `tunables_registration`), and what the big blocks hold (player data, tunables, flow flags). Read only. | L | **Done** (first pass): [guide](/docs/core/global-map.md) |
| R0.5 | **Script launch graph** | Who starts whom (`REQUEST_SCRIPT` and `START_NEW_SCRIPT` with stack sizes), and the script brains placed in the world (`ambient*.ipl`, `scriptbrains` data), drawn as one graph for story and one for Online. | M | Started: [launch graph](/scripting/script-launch-graph.md) |
| R0.6 | **Research toolkit guide** | Update guide 5 with the new tools and a "how to research a new topic in an hour" checklist. | S | **Done** (first pass): [guide](/docs/00-getting-started/research-tools.md) |
| R0.7 | **Archive and data file atlas** | List every archive (root, `update/`, all 89 DLC packs) and every file type inside them with counts (`.meta`, `.ymt`, `.ytyp`, `.ymap`, `.ydr`, `.yft`, `.ytd`, `.ycd`, `.ynv`, `.awc`, `.gfx`, `.gxt2`, `.cut`, `.rel`, ...), what each type is, which engine system reads it, and which topic covers it. The data-side twin of the script catalog. | L | Open |
| R0.8 | **Native namespace coverage map** | Every native namespace (about 40) with its size, how many scripts use it, and which topic explains it, so no engine API family is left unread. | S | **Done** (first pass): [guide](/scripting/native-namespace-map.md) |

## R1. Engine runtime: how the game runs scripts and data

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R1.1 | **The script VM** | The YSC format (header, code pages, statics, globals, natives, strings), threads and stack sizes, how a script waits (`WAIT`), how many scripts can run, what a script costs per frame. How ScriptHookV and SHVDN run next to it (fibers on the main thread), and why a slow mod freezes the game. | M | **Done** (first pass): [guide](/scripting/script-vm.md) |
| R1.2 | **Boot and script control** | What happens from launch to control: `startup`, `main`, `main_persistent`, `initial`, `landing_pre_startup`, title update and DLC registration scripts, and how story mode hands over to Online (`maintransition`). | M | **Done** (first pass): [guide](/docs/00-getting-started/boot.md) |
| R1.3 | **Natives as the engine API** | The namespaces, which ones matter for modding, what each family can and can't do, natives that are unsafe or slow. Builds on guide 05-Natives. | M | Open |
| R1.4 | **Memory, pools and limits** | `gameconfig.xml` pool sizes, what HeapAdjuster, PackfileLimitAdjuster, PoolManager and the other adjusters change, how many peds, vehicles, objects and blips the game can hold, and what happens at the limit. | M | **Done** (first pass): [guide](/docs/core/memory-and-pools.md) |
| R1.5 | **Streaming** | How models, textures, maps (`ymap`, `ytyp`), interiors and IPLs are requested and loaded, LOD distances, `REQUEST_MODEL` timing, load scenes, why pop-in happens and how to preload. | M | **Done** (first pass): [guide](/docs/core/streaming.md) |
| R1.6 | **Archives and the content system** | How RPFs, `dlclist.xml`, each pack's `content.xml` and `setup2.xml` decide what loads, the order DLC data overrides base data, what OpenIV's `Mods/` folder does, and how add-on vs replacement mods work. | S | **Done** (first pass): [guide](/docs/core/archives-and-content.md) |
| R1.7 | **Saves** | The story save file (what is in it, how scripts write it, autosave), and how Online stores the same data in stats. Where mods should keep their own saves. | M | Open |

## R2. Physics and simulation

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R2.1 | **Collision and materials** | Bounds and collision types, `materials.dat` (friction, elasticity, per-material effects), how probes and raycasts work (`SHAPETEST_*`), collision loading around the player. | M | **Done** (first pass): [guide](/docs/physics/collision-and-materials.md) |
| R2.2 | **Vehicle physics** | `handling.meta` and its sub-handling blocks (bikes, boats, aircraft, special flags), mass, centre of mass, traction curves, gears, suspension, drift; damage and deformation; what mod-shop upgrades change. | L | **Done** (first pass): [guide](/docs/physics/vehicle-handling.md) |
| R2.3 | **Ped physics and ragdoll** | Euphoria behaviours, when peds ragdoll, ragdoll natives, falling and impact damage, `pedhealth.meta`, the limits on ragdolling peds at once. | M | Open |
| R2.4 | **Water, buoyancy and swimming** | Water data (`water.xml`), waves, boats and submarine buoyancy, how swimming and diving work underneath. | M | Open |
| R2.5 | **Fire, explosions and projectiles** | `explosion.meta`, fire spread, projectiles and thrown weapons, damage falloff. | S | **Done** (first pass): [guide](/docs/physics/fire-explosions-projectiles.md) |
| R2.6 | **Time, weather and wind** | The clock, `weather.xml`, timecycle modifiers, wind and how it affects physics, how scripts lock weather and time. | S | **Done** (first pass): [guide](/docs/world/time-and-weather.md) |
| R2.7 | **Physics cost on a low-end PC** | Which simulations cost the most (ragdolls, debris, vehicle crashes, fire), measured through tests, written as spawn and effect budgets for mods. | M | **Done** (first pass): [guide](/docs/performance/physics-cost.md) |

## R3. Gameplay mechanics

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R3.1 | **Weapons** | `weapons.meta` and its DLC additions, components, damage, range, recoil, spread, reload, ammo types and limits, aiming and lock-on, explosives; what WeaponLimitsAdjuster, combat_tweaks and LaserSights change; how Ammu-Nation unlocks are stored in story and Online. | L | **Done** (first pass): [guide](/docs/gameplay/weapons/weapons.md) |
| R3.2 | **Combat and AI** | Melee and takedowns, cover, `combatbehaviour.meta`, ped personalities, accuracy, perception (sight, hearing), relationship groups, tasks (`TASK_*`) and decision making, how scripts run fights. | L | **Done** (first pass): [guide](/docs/ai/combat-and-perception.md) |
| R3.3 | **Driving and AI driving** | Driving model, vehicle classes, AI driving tasks and styles, traffic paths (`paths` nodes), how AI follows routes and races. | M | Open |
| R3.4 | **Flying** | Aircraft and helicopter flight model, landing gear, countermeasures, parachuting and skydiving, the flight-school skill. | M | Open |
| R3.5 | **Swimming and diving** | Stamina and breath, underwater rules, scuba gear, boats and submarines. | S | **Done** (first pass): [guide](/docs/gameplay/player/swimming-and-diving.md) |
| R3.6 | **Player skills and abilities** | Stamina, shooting, strength, stealth, flying, driving, lung capacity (story stats vs Online stats), special abilities, and how stats change the mechanics above. | M | Open |
| R3.7 | **Wanted level and police** | How crimes are detected and reported, wanted level rules, dispatch (`dispatch.meta`, service types), police tactics, how police overhaul mods replace each piece. | L | Open |
| R3.8 | **Health, armour, death and arrest** | Health and armour values, regeneration, injury, how death and arrest are handled (respawn controller, hospitals, police stations). | S | **Done** (first pass): [guide](/docs/gameplay/player/health-armour-death.md) |
| R3.9 | **Economy and pickups** | Money, prices, ATMs, robberies, pickups and collectables, story-mode stock market (`stock_controller`). | M | Open |

## R4. The world

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R4.1 | **Population** | Population zones and groups (`popzone`, `popgroups.ymt`, `popcycle`), ped and vehicle density, how density changes by time and area, what AI mods change. | M | Open |
| R4.2 | **Scenarios and ambient life** | Scenario points and types (sitting, smoking, guards), ambient animations, ambient speech. | M | Open |
| R4.3 | **Vehicle generators and traffic** | Parked car generators, traffic spawning, emergency vehicles, trains, boats and planes on routes. | S | **Done** (first pass): [guide](/docs/entities/spawning/vehicle-generators-and-traffic.md) |
| R4.4 | **Random events** (`re_*`, 41 scripts) | How random events are picked and launched, their conditions and cooldowns, what each one does. | M | Open |
| R4.5 | **Interiors and IPLs** | Which interiors exist, how they load (IPLs, entity sets, `interiorproxies`), the Online interiors and how to open them offline. | M | Open |
| R4.6 | **Map data** | `ymap` and `ytyp` structure, LOD, how map mods (forest packs, vremastered) add or replace parts of the map, restricted areas. | M | Open |

## R5. Story mode

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R5.1 | **The mission flow** | `flow_controller`, mission triggers (`mission_triggerer_a` to `d`), flow flags, how missions unlock, strands (Michael, Franklin, Trevor, heists), `mission_repeat_controller`. | L | **Done** (first pass): [guide](/docs/gameplay/missions/story-flow.md) |
| R5.2 | **Anatomy of a story mission** | Take three missions of different kinds (`armenian1`, a heist such as `jewelry_heist`, `trevor1`) and document the stages, checkpoints, fail conditions, cutscenes, dialogue and cleanup: the template every mission follows. | L | **Done** (first pass): [guide](/docs/gameplay/missions/mission-anatomy.md) |
| R5.3 | **Saves, completion and autosave** | `autosave_controller`, `savegame_bed`, `save_anywhere`, `completionpercentage_controller`, `achievement_controller`. | M | Open |
| R5.4 | **Strangers, freaks and side content** | Launchers (`launcher_*`), random characters (`randomchar_controller`), side strands (Epsilon, Paparazzo, Nigel, Tonya, Barry ...), how they appear and unlock. | M | Open |
| R5.5 | **Minigames and activities** | Golf, tennis, darts, yoga, triathlon, races, flight school, shooting range, strip club, taxi, towing, trafficking, hunting, rampages, arcade machines; how each is launched, scored and rewarded. | L | Open |
| R5.6 | **Cutscenes and dialogue** | How cutscenes are loaded, staged (entities, crew, vehicles), skipped and cleaned up; the dialogue system (`CREATE_CONVERSATION`, subtitle and speech files); `cutscene_test` and debug scripts as documentation. | M | **Done** (first pass): [guide](/docs/gameplay/missions/cutscenes-and-dialogue.md) |
| R5.7 | **Systems that clash with Online mode** | Phone (`cellphone_controller`), shops (`shop_controller`, clothes, barber, tattoo, guns), friends and family scenes, emails and texts, ATMs, restricted areas: which ones must be stopped or replaced in our Online mode. | M | **Done** (first pass): [guide](/docs/online/story-systems-in-online-mode.md) |
| R5.8 | **Replay, director mode and the Rockstar Editor** | `replay_controller`, `director_mode`, what NoEditorRestrictions changes. | S | **Done** (first pass): [guide](/docs/gameplay/missions/replay-director-and-editor.md) |

## R6. The player

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R6.1 | **Character switching** | `selector`, the swoop camera, what each character's state holds (position, outfit, weapons, vehicle, money), player scenes (`player_controller`, `player_timetable_scene`, `family_scene_*`). | M | **Done** (first pass): [guide](/docs/gameplay/player/character-switching.md) |
| R6.2 | **Respawn, death and arrest** | `respawn_controller`, hospitals and police stations, what is lost, how Online's respawn differs. | S | **Done** (first pass): [guide](/docs/gameplay/player/respawn-death-and-arrest.md) |
| R6.3 | **Appearance and clothing** | Ped components and props, freemode ped models (`mp_m_freemode_01`), head blend, overlays, tattoos, the shop catalogues (`shop_ped_apparel` and its DLC files), outfits. | L | **Done** (first pass): [guide](/docs/entities/peds/appearance-and-clothing.md) |
| R6.4 | **Controls and camera** | Control IDs and how scripts disable them, camera modes, first person, the phone and menus fighting over inputs. | S | **Done** (first pass): [guide](/docs/gameplay/player/controls-and-camera.md) |

## R7. GTA Online

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R7.1 | **`freemode` inside** | Its main loop, the systems it runs (blips, personal vehicles, properties, events, the player list), the order it starts them, what it reads from globals and stats. | L | **Done** (first pass): [guide](/docs/online/07-freemode.md) |
| R7.2 | **Transitions and sessions** | `maintransition`, joining and leaving, the character select, what "network game in progress" switches on, what fails without a session. | M | **Done** (first pass): [guide](/docs/online/transitions-and-sessions.md) |
| R7.3 | **Stats, tunables and the server's role** | `mpstatssetup.xml` stat families, what is server-authoritative, tunables and their defaults, the transaction (basket) flow, what we must replace locally. | M | **Done** (first pass): [guide](/docs/online/stats-and-tunables.md) |
| R7.4 | **The UGC mission format and controllers** | Map every key in the local `.ugc` files, how `fm_mission_controller` and `_2020` read rules, objectives, teams and spawns. | L | **Done** (first pass): [guide](/file-formats/ugc-json.md) |
| R7.5 | **The job lobby (`fmmc_launcher`)** | How a job is chosen, set up, launched and ended, and how the lobby screens are filled. | M | Open |
| R7.6 | **Properties** | `am_mp_property_ext/int`, the property table, entering, buying, garages, the business properties. | L | Open |
| R7.7 | **Organisations and businesses** | VIP, CEO and MC work (`gb_*`), the business loop (supplies, stock, sell), the business computers (`app*`). | L | Open |
| R7.8 | **Heists** | Classic heists, Doomsday, Casino, Cayo Perico: planning boards, preps, finales, crew cuts. | L | Open |
| R7.9 | **DLC storylines** | Each DLC's story arc, triggers, scripts, local vs cloud missions, cutscenes and contacts, and how to rebuild it here. | L | Open |
| R7.10 | **Interaction menu, phone and apps** | `am_pi_menu`, the Online phone, contacts and requests (`am_contact_requests`), the internet sites. | M | Open |

## R8. The game's own UI

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R8.1 | **Pause and Online menus** | How the frontend menus are built and filled by scripts (`pausemenu`, `pausemenu_multiplayer`), layout data. | M | Open |
| R8.2 | **Scaleform movies** | The `.gfx` movies, how scripts call them (`BEGIN_SCALEFORM_MOVIE_METHOD`), which movie draws what. | M | Open |
| R8.3 | **Text labels** | GXT2 text files, label naming, how to add your own text. | S | **Done** (first pass): [guide](/docs/ui/text-labels.md) |
| R8.4 | **HUD, colours and blips** | HUD components, the colour table, blip sprites and how the radar and map draw them. | M | Open |
| R8.5 | **Server-backed Online screens** | Which Online screens wait for the server, and what they need to run locally. | M | Open |
| R8.6 | **Story-mode UI** | Character wheel, stats and completion screens, phone apps. | M | Open |

## R9. Audio

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R9.1 | **How audio is organised** | Sound banks, `.dat` audio config files, sound sets and names used by scripts (`PLAY_SOUND_FRONTEND`), audio scenes. | M | Open |
| R9.2 | **Speech and dialogue** | Speech files, conversation roots, ambient speech, which voices exist per character. | M | Open |
| R9.3 | **Music and radio** | Music events and mission scores, radio stations and how to add or replace them. | S | **Done** (first pass): [guide](/docs/audio/music-and-radio.md) |

## R11. Surviving updates

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R11.1 | **What an update breaks** | ScriptHookV's version gate, native tables, memory offsets, global indices, stale modified archives, missing DLC entries, renamed assets. | M | **Done** (first pass): [guide](/docs/core/surviving-updates.md) |
| R11.2 | **An update-check tool** | Compare the game version, re-scan DLC packs and scripts, and check every asset name a mod uses against the new build. | M | **Started**: [guide](/docs/core/surviving-updates.md) |
| R11.3 | **Protecting a working install** | Delaying updates, backing up the exe and `update/`, rolling back. | S | **Started**: [guide](/docs/core/surviving-updates.md) |
| R11.4 | **Update-day checklist** | The order of steps after an update. | S | **Done** (first pass): [guide](/docs/core/surviving-updates.md) |
| R11.5 | **Rules for update-proof code** | Natives over memory, data files over hard-coded names, timeouts and logging when an asset is missing. | S | **Done** (first pass): [guide](/docs/core/surviving-updates.md) |

## R13. Rendering, animation and effects

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R13.1 | **Rendering and graphics settings** | The render pipeline at a high level, what each graphics setting costs on the UHD 620, LOD and draw distance, `visualsettings.dat`, what vremastered changes. | M | Open |
| R13.2 | **Timecycle and post effects** | Timecycle files and modifiers, screen effects (`ANIMPOSTFX_*`), how scripts change the look of a scene. | S | **Done** (first pass): [guide](/docs/rendering/timecycle-and-post-effects.md) |
| R13.3 | **Particles and decals** | Particle assets (`ptfx`), how scripts start effects, decals and their limits (what the DecalsLimit patch changes). | S | **Done** (first pass): [guide](/docs/rendering/particles-and-decals.md) |
| R13.4 | **Animation** | Clip dictionaries (`.ycd`), how tasks play animations, synchronized scenes, move networks, facial animation, scenario animations. | L | Open |
| R13.5 | **Cameras** | Script cameras, the gameplay camera, cinematic cameras, camera shakes, how cutscenes and the phone camera use them. | S | **Done** (first pass): [guide](/docs/rendering/cameras.md) |

## R14. Content definitions: vehicles, peds, weapons and props

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R14.1 | **Vehicles** | `vehicles.meta`, `carcols.meta` (mod kits, colours, lights, sirens), `carvariations.meta`, `vehiclelayouts.meta`, how an add-on car is defined. | M | Open |
| R14.2 | **Peds** | `peds.meta`, ped personalities, ped component and prop data (`.ymt`), ped types and relationship defaults. | M | Open |
| R14.3 | **Props and archetypes** | `.ytyp` archetypes, prop flags, dynamic and breakable props, doors and the door system. | M | Open |
| R14.4 | **Text and names in content** | How models get their display names (labels) and how add-on content registers them. | S | **Done** (first pass): [guide](/docs/entities/objects/text-and-names.md) |

## R15. The network layer and Rockstar's services

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R15.1 | **Sessions and sync** | Network objects, ownership and migration, broadcast data, events (`NETWORK_*` natives) at the engine level. | M | Open |
| R15.2 | **Rockstar services** | Social Club and ROS, cloud files, UGC queries, leaderboards, presence, the store and transactions: which natives talk to them and what fails when they're absent. | M | Open |

## R17. NPC AI: how peds and drivers think

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R17.1 | **The AI architecture** | How a ped's behaviour is put together: the task system (task tree, primary and secondary tasks, priorities), how scripts give tasks (`TASK_*`, sequences, `SET_BLOCKING_OF_NON_TEMPORARY_EVENTS`), what runs when no script is in charge. | L | Open |
| R17.2 | **Perception and events** | How peds see and hear (ranges, cones, `SET_PED_SEEING_RANGE`, hearing), the event system (gunshots, explosions, "shocking events", dead bodies), how events turn into reactions, how scripts block or add events. | M | Open |
| R17.3 | **Decisions and personalities** | Ped personalities and decision makers in the data files, combat behaviour (`combatbehaviour.meta`), combat attributes and ranges, flee and cower rules, bravery, what AI mods change. | M | Open |
| R17.4 | **Relationships and groups** | Relationship groups (`relationships.dat`, `ADD_RELATIONSHIP_GROUP`), how gangs, cops and civilians treat each other and the player, player groups, followers and formations, bodyguards. | M | Open |
| R17.5 | **Navigation and pathfinding** | Navmeshes (`.ynv`), how peds plan routes on foot, climbing, cover points, doors, interiors; why peds get stuck; navmesh streaming around the player. | M | Open |
| R17.6 | **Driving AI** | Vehicle path nodes, driving tasks and styles (flags), traffic behaviour, chases and escorts, races, flying AI (helicopters, planes), boat AI. Extends R3.3. | L | Open |
| R17.7 | **Police and service AI** | Dispatch, cop search and chase behaviour, roadblocks, ambulances and fire trucks, and how police mods replace each part. Extends R3.7. | M | Open |
| R17.8 | **Ambient life** | Wandering, scenarios, ambient speech and reactions, ped conversations, animals, how the population AI is thinned out with distance. Extends R4.2. | M | Open |
| R17.9 | **AI cost and level of detail** | How many peds can run full AI, low-detail peds and "dummy" vehicles far from the player, what AI costs per frame on a low-end PC, safe limits for spawning mods. | M | Open |
| R17.10 | **How Rockstar's scripts drive AI** | Patterns from missions and Online content: enemy waves, guards and patrols, hostage and escort logic, AI in heists, the Online "fake player" peds. A pattern library for mod missions and AI players. | L | Open |

## R18. Game optimization

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R18.1 | **Measuring performance** | How to measure before changing anything: frame rate and frame time, CPU vs GPU bound, the game's own benchmark (`benchmark` script), Windows tools (Task Manager, PresentMon, Event Viewer for hangs), and reading mod logss for stalls. | S | **Done** (first pass): [guide](/docs/performance/measuring.md) |
| R18.2 | **Graphics settings, one by one** | Every option in `settings.xml` and the in-game menu: what it changes, its CPU, GPU and VRAM cost, and the best value for weak, mid and strong PCs; the settings not shown in the menu; `commandline.txt` switches. | M | **Done** (first pass): [guide](/docs/performance/graphics-settings.md) |
| R18.3 | **Streaming, memory and VRAM** | How the game budgets memory and video memory, why textures stream in late, what the heap and pool adjusters really fix, when more mods means freezes. Builds on R1.4 and R1.5. | M | **Done** (first pass): [guide](/docs/performance/memory-and-vram.md) |
| R18.4 | **CPU: population, AI, physics and scripts** | What loads the CPU: ped and traffic density, AI (R17.9), physics (R2.7), script mods; how density settings and spawn caps help. | M | **Done** (first pass): [guide](/docs/performance/cpu.md) |
| R18.5 | **Mod overhead** | What each kind of mod costs (ASI plugins, SHVDN scripts, Lua, add-on packs, map mods, graphics mods), how to find the heavy one, and how to write mods that cost nothing when idle (the script-brain pattern from core guide 1). | M | **Done** (first pass): [guide](/docs/performance/mod-overhead.md) |
| R18.6 | **Windows and drivers** | Power plans, background apps, Game Mode, GPU driver settings, integrated vs dedicated graphics on laptops, page file, storage (HDD vs SSD load times). | S | **Done** (first pass): [guide](/docs/performance/windows-and-drivers.md) |
| R18.7 | **Profiles for different PCs** | Ready settings for a low-end laptop, a mid-range PC and a strong PC, with the reasons; how to switch mod sets per use. | S | **Done** (first pass): [guide](/docs/performance/pc-profiles.md) |
| R18.8 | **Load times and stutter** | What happens during loading, why the first minutes stutter, shader cache, and what helps. | S | **Done** (first pass): [guide](/docs/performance/load-times.md) |

## R12. Synthesis: from research to mods

| ID | Topic | What to find out | Size | Status |
| --- | --- | --- | --- | --- |
| R12.1 | **Mod-builder's cookbook** | One page per kind of mod (spawning and AI, missions, menus, shops, vehicles and handling, weapons, world and map, UI and HUD, audio): which systems it touches, the natives and data files to use, the traps, a minimal working pattern. | L | Open |
| R12.3 | **Ideas list** | Mods that the research shows are possible and worth building, each with a size estimate, added to the roadmaps after review with the user. | M | Open |
| R12.4 | **Languages for modding GTA V** | Which language does what (C# with ScriptHookVDotNet, C++ with ScriptHookV, Lua, the XML and meta data formats, ini files, and the rarer ones: JavaScript, ActionScript for scaleform, PowerShell and bash for tooling), with a learning path for beginners. Written for the public research repo (`docs/PORTABILITY_PLAN.md`). | M | **Done** (first pass): [guide](/scripting/languages.md) |
| R12.6 | **Modding path for beginners** | A guided path from nothing to a first working mod: how mods load, the tools needed (linked, never uploaded), installing and checking ScriptHookV and SHVDN, a first data edit, a first C#, Lua and C++ mod, debugging, and how to release a mod safely. | M | **Done** (first pass): [modding path](/modding/README.md) |

## Inbox

Found something no topic covers? Open an issue titled `Inbox: <what you found>` with where you found it. It gets a topic ID at the next review.
