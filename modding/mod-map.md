# Mod map: what to read for the mod you want to make

Pick the kind of mod you are building and this page tells you which guides to read, in order, and which files and natives you will touch. It links the common mod categories to the guides in this repo; it adds no research of its own. Part of the [modding path](README.md). Once you know your category, the [cookbook](cookbook/README.md) has a minimal pattern for most of them.

**How it was made.** Each category was matched to the guides whose "What this means for modders" sections and file lists cover the same systems, and every link was checked to exist. The mod names given as examples are other people's projects; this repo holds none of them, so look up each author's own page. Which guide belongs to which category is a judgement call (**Known**); the facts inside each guide carry their own Verified or Known marks. Build 1.0.3725.0 Legacy.

**Single player only.** Never run mods in GTA Online; it gets accounts banned. The Online guides in this map are for reading how Rockstar built something, never for running a mod there.

## How to use it

1. Find your kind of mod in the [picker](#picker) below.
2. Read **Start with** in order. Stop when you have what you need; the later pages are for depth.
3. Check **Files and natives** so you know what you will actually edit or call.
4. Read **Gaps** before you start. Where this repo has no guide yet, it says so, rather than leaving you to hunt.

Every mod is one of two kinds ([how mods work](01-how-mods-work.md)): a **data mod** (changes files the game reads) or a **script mod** (your code runs beside the game's scripts). Many are both. The picker shows which.

## Picker

| I want to make... | Kind | Go to |
| --- | --- | --- |
| A script, menu or trainer | Script | [1](#1-script-frameworks-and-tools), [2](#2-trainers-and-menu-utilities) |
| Better lighting, weather or visuals | Data (+ script) | [3](#3-graphics-and-visual-mods) |
| Changed driving, gunplay or police AI | Data (+ script) | [4](#4-gameplay-and-realism-mods) |
| A police or law-enforcement simulator | Script | [5](#5-lspdfr-and-police-roleplay) |
| A new or replaced car, bike, plane | Data (+ script) | [6](#6-vehicle-and-model-add-ons) |
| Paint jobs and liveries | Data | [7](#7-paintjobs-and-liveries) |
| New map areas, open interiors, props | Data (+ script) | [8](#8-map-and-world-modifications) |
| New clothes, skins or player models | Data | [9](#9-skins-and-player-clothes) |
| New or changed weapons | Data (+ script) | [10](#10-weapons) |
| New sounds, radio, sirens | Data | [11](#11-sound-and-audio) |
| New missions, side content or a story | Script | [12](#12-missions-heists-and-new-stories) |
| A heist | Script | [12](#12-missions-heists-and-new-stories) |
| Save files, progress or unlocks | Data (read-only advice) | [13](#13-save-games) |

## 1. Script frameworks and tools

The loaders every script mod stands on (examples: Script Hook V, ScriptHookVDotNet, OpenIV). You use them far more often than you write them.

| Start with | Why |
| --- | --- |
| [How mods work](01-how-mods-work.md) | What loads what: the ASI loader, ScriptHookV, the .NET and Lua hosts |
| [Tools you need](02-tools-you-need.md), [install and check](03-install-and-check.md) | Install, back up, prove it loads from the logs |
| [Languages](/scripting/languages.md) | C#, Lua or C++ for your job |
| [Script VM](/scripting/script-vm.md), [natives](/scripting/natives.md) | How the game's own scripts and natives work, which your code calls too |
| [Natives as the engine API](/scripting/natives-engine-api.md) | Request, wait, use, release; the contracts that keep mods stable |
| [Debugging](08-debugging.md), [mod overhead](/docs/performance/mod-overhead.md) | When nothing happens, and what each mod costs |

**Files and natives.** `scripts\` folder, `.asi` files, the loader logs. **Gaps:** how to *write* a script hook or loader is not covered; this repo explains how to use one.

## 2. Trainers and menu utilities

Spawn cars, teleport, change time and weather, toggle god mode (examples: Menyoo, Simple Trainer). A trainer is a menu plus a list of native calls.

| Start with | Why |
| --- | --- |
| [First C# mod](05-first-csharp-mod.md) | A key press and a reaction |
| [Menus and UI](/scripting/menus-and-ui.md), [cookbook: menus](cookbook/menus.md), [LemonMenu example](/examples/04_LemonMenu.cs) | Menu libraries, controls, text |
| [Controls and camera](/docs/gameplay/player/controls-and-camera.md), [keycodes and controls](/docs/gameplay/player/keycodes-and-controls.md) | Reading input without clashing with the game |
| [Spawning and AI](cookbook/spawning-and-ai.md), [peds](/docs/entities/peds/peds.md), [vehicles](/docs/entities/vehicles/vehicles.md) | What to spawn and the model names |
| [Time, weather and wind](/docs/world/time-and-weather.md) | Weather and clock natives and how scripts lock them |
| [Health, armour, death](/docs/gameplay/player/health-armour-death.md) | What "god mode" really changes |
| [Memory, pools and limits](/docs/core/memory-and-pools.md) | Why spawning forever eventually fails |

**Files and natives.** Natives from `ENTITY`, `PED`, `VEHICLE`, `TIME`/`MISC` (weather); no data files. **Cost:** keep the per-frame work small ([mod overhead](/docs/performance/mod-overhead.md)).

## 3. Graphics and visual mods

Lighting, weather, colour grading, effects and textures (examples: Natural Vision Evolved, VisualV). Mostly data; some add a script for effects.

| Start with | Why |
| --- | --- |
| [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md) | The files that decide sky, fog, light and colour per weather and hour |
| [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md) | `visualsettings.dat`: lights, coronas, distant lights, draw distance |
| [Time, weather and wind](/docs/world/time-and-weather.md) | The weather types and cycle the timecycle plugs into |
| [Particles and decals](/docs/rendering/particles-and-decals.md) | Smoke, fire, blood and impact effects |
| [Archives and content](/docs/core/archives-and-content.md) | Add-on pack or replacement; the mods folder |
| [Graphics settings](/docs/performance/graphics-settings.md), [memory and VRAM](/docs/performance/memory-and-vram.md) | What high-resolution textures and long draw distance cost |
| [Surviving updates](/docs/core/surviving-updates.md) | Replacement files go stale after a game update |

**Files and natives.** `timecycle` XML files, `visualsettings.dat`, particle assets; natives from `GRAPHICS`. **Gaps:** the texture dictionary (`.ytd`) and model (`.ydr`) formats have no page of their own; the [file format list](/file-formats/README.md) names `timecycle` among the wanted pages.

## 4. Gameplay and realism mods

Driving physics, gunplay, damage, police behaviour (examples: realism and dispatch packs). Mostly edits to tuning files.

| Change | Read |
| --- | --- |
| How cars drive | [Vehicle handling](/docs/physics/vehicle-handling.md), [handling.meta](/file-formats/handling-meta.md), first edit in [your first data edit](04-first-data-edit.md) |
| Aircraft, boats, swimming | [Flying](/docs/gameplay/player/flying.md), [swimming and diving](/docs/gameplay/player/swimming-and-diving.md), [water and buoyancy](/docs/physics/water-and-buoyancy.md) |
| Guns and damage | [Weapons](/docs/gameplay/weapons/weapons.md), [weapons.meta](/file-formats/weapons-meta.md), [combat and perception](/docs/ai/combat-and-perception.md) |
| Health, ragdoll, falling | [Health, armour, death](/docs/gameplay/player/health-armour-death.md), [ragdoll](/docs/entities/peds/ragdoll.md), [collision and materials](/docs/physics/collision-and-materials.md) |
| Police and dispatch | [Police and services](/docs/ai/police-and-services.md), [wanted level and police](/docs/ai/wanted-level-and-police.md) |
| How pedestrians and traffic behave | [Ambient life](/docs/ai/ambient-life.md), [driving AI](/docs/ai/driving-ai.md), [driving and AI driving](/docs/ai/driving.md), [population](/docs/entities/spawning/population.md) |
| Fire, explosions | [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) |
| Economy and pickups | [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) |

Before you tune, read [AI architecture](/docs/ai/ai-architecture.md) and [physics cost](/docs/performance/physics-cost.md) to avoid values that look good and tank the frame rate. The [ideas list](ideas.md) has sized data-only projects such as a police overhaul pack.

## 5. LSPDFR and police roleplay

A law-enforcement simulator (pull-overs, dispatch calls, arrests) is a large script mod, built on a plugin framework by its own authors; find that framework on its author's site. This repo helps you understand the game systems such a mod hooks into, and write your own police-style scripts.

| Start with | Why |
| --- | --- |
| [Police and services](/docs/ai/police-and-services.md) | The 14 dispatch services, what each wanted level sends, search behaviour |
| [Wanted level and police](/docs/ai/wanted-level-and-police.md) | The crimes, witnesses, how the wanted natives work |
| [Perception and events](/docs/ai/perception-and-events.md), [relationships and groups](/docs/ai/relationships-and-groups.md) | What peds see and hear; who is hostile to whom |
| [Decisions and personalities](/docs/ai/decisions-and-personalities.md), [combat and perception](/docs/ai/combat-and-perception.md) | How a ped chooses to flee, surrender or fight |
| [Navigation](/docs/ai/navigation.md), [driving AI](/docs/ai/driving-ai.md) | Pursuits, pull-overs, pathing |
| [Script AI patterns](/docs/ai/script-ai-patterns.md) | How Rockstar's own scripts drive AI, to copy the pattern |
| [Spawning and AI](cookbook/spawning-and-ai.md), [vehicles and handling](cookbook/vehicles-and-handling.md) | Spawning units and cars, with budgets |
| [Menus](cookbook/menus.md), [UI and HUD](cookbook/ui-and-hud.md) | Dispatch menus, radio-call text, notifications |
| [Audio](cookbook/audio.md), [speech and dialogue](/docs/audio/speech-and-dialogue.md) | Scanner and dispatch speech |

**Files and natives.** `dispatch.meta`, `wantedtuning.ymt`; natives from `PED`, `TASK`, `PLAYER`. **Gaps:** this repo documents the game, not any police framework's own interface.

## 6. Vehicle and model add-ons

Real-world brands or custom cars, bikes and planes added as new models.

| Start with | Why |
| --- | --- |
| [Archives and content](/docs/core/archives-and-content.md) | Add-on pack: `dlclist.xml`, `setup2.xml`, `content.xml`, and why add-on beats replace |
| [Vehicles](/docs/entities/vehicles/vehicles.md) | The data files an add-on car needs (`vehicles.meta`, `carvariations`, `carcols`, `vehiclelayouts`, `handling`), step by step |
| [Handling](/docs/physics/vehicle-handling.md), [handling.meta](/file-formats/handling-meta.md) | How it drives |
| [DLC packs and their vehicles](/docs/entities/vehicles/dlc-packs.md) | What Rockstar's own packs contain, as examples to copy |
| [Text and names](/docs/entities/objects/text-and-names.md) | Name labels so your car has a proper name |
| [Flying](/docs/gameplay/player/flying.md) | Aircraft handling sections |
| [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) | Making your car appear in traffic or at fixed spots |
| [Cookbook: vehicles and handling](cookbook/vehicles-and-handling.md), [RPF](/file-formats/rpf.md) | Spawn pattern, archive format |
| [Memory, pools and limits](/docs/core/memory-and-pools.md), [memory and VRAM](/docs/performance/memory-and-vram.md) | Many add-ons hit pool and VRAM limits |

**Files and natives.** The five vehicle data files above; natives from `VEHICLE`. **Gaps:** making the 3D model itself (`.yft`, `.ytd`) is not covered; there is no model format page yet. Use the tool authors' own documentation.

## 7. Paintjobs and liveries

Textures and decal layers, with or without changing the underlying vehicle.

| Start with | Why |
| --- | --- |
| [Vehicles](/docs/entities/vehicles/vehicles.md) | How `carvariations` and `carcols` hold colours, extras, liveries and mod kits |
| [Archives and content](/docs/core/archives-and-content.md) | Texture replacement vs an add-on pack |
| [Text and names](/docs/entities/objects/text-and-names.md) | Labels for a new livery's name |
| [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) | Getting a livery onto traffic, police and emergency cars |
| [Police and services](/docs/ai/police-and-services.md) | The vehicle sets for each service, to restyle a fleet |
| [Surviving updates](/docs/core/surviving-updates.md) | Keeping texture replacements working |

**Files and natives.** Texture dictionaries (`.ytd`), `carvariations.meta`; natives `SET_VEHICLE_LIVERY`, `SET_VEHICLE_MOD` (counted in the vehicles guide). **Gaps:** how to paint a texture in an editor and the `.ytd` layout are not covered.

## 8. Map and world modifications

Opened interiors, forests, new islands and tracks.

| Start with | Why |
| --- | --- |
| [Map data](/docs/world/map-data.md) | The ymap and ytyp files; packs and patches that add or replace map parts |
| [Interiors and IPLs](/docs/world/interiors-and-ipls.md) | Opening locked interiors, entity sets, how Online interiors open offline |
| [Props and doors](/docs/entities/objects/props-and-doors.md) | Placing props, door tuning |
| [Streaming](/docs/core/streaming.md) | Load scenes, LOD, why a new area pops in or vanishes |
| [Collision and materials](/docs/physics/collision-and-materials.md) | Collision for your new geometry |
| [Navigation](/docs/ai/navigation.md) | Paths so peds and AI cars use the new area |
| [Scenarios and ambient life](/docs/entities/spawning/scenarios.md), [population](/docs/entities/spawning/population.md) | Filling the area with life |
| [Cookbook: world and map](cookbook/world-and-map.md), [creator internals](/docs/online/creator-internals.md) | Props from a script; the creator's prop catalogue and snapping |
| [Memory, pools and limits](/docs/core/memory-and-pools.md) | Entity and map pool limits |
| [Data file atlas](/file-formats/data-file-atlas.md) | Which file type does what |

**Gaps:** the ymap, ytyp and navmesh formats are on the wanted list in [file formats](/file-formats/README.md); there are no format pages yet, so use the topic guides and the map tool authors' own documentation.

## 9. Skins and player clothes

Clothing packs, tattoos, hair, or whole new models for the three protagonists or freemode-style peds.

| Start with | Why |
| --- | --- |
| [Appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) | Component slots, prop anchors, freemode faces, tattoos, the shop catalogue |
| [Peds](/docs/entities/peds/peds.md) | The `peds.ymt` entry, component files, and how a new ped model is registered |
| [Skills and abilities](/docs/gameplay/player/skills-and-abilities.md) | Per-character data a replacement model inherits or loses |
| [Character switching](/docs/gameplay/player/character-switching.md) | What a model swap must keep working |
| [Ragdoll](/docs/entities/peds/ragdoll.md), [animation](/docs/rendering/animation.md) | Skeleton and animation requirements |
| [Archives and content](/docs/core/archives-and-content.md) | Add-on ped pack vs replacement |
| [Cookbook: shops](cookbook/shops.md) | Selling the clothes in game |

**Gaps:** the drawable (`.ydd`) and texture (`.ytd`) layouts are not covered.

## 10. Weapons

New or changed firearms, melee weapons and gear.

| Start with | Why |
| --- | --- |
| [Weapons](/docs/gameplay/weapons/weapons.md) | The data and damage model; Ammu-Nation unlocks |
| [weapons.meta](/file-formats/weapons-meta.md) | Every field, components and attachments |
| [Cookbook: weapons](cookbook/weapons.md) | Giving, equipping and removing weapons from script |
| [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) | Explosive and projectile ammo |
| [Combat and perception](/docs/ai/combat-and-perception.md) | Accuracy, how AI reacts to the weapon |
| [Text and names](/docs/entities/objects/text-and-names.md) | Weapon name labels |
| [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) | Weapon pickups and shop prices |
| [Archives and content](/docs/core/archives-and-content.md) | Add-on vs replacement |

**Gaps:** the weapon model and texture formats are not covered.

## 11. Sound and audio

Weapon fire, engines, sirens, environmental sound and radio.

| Start with | Why |
| --- | --- |
| [How audio is organised](/docs/audio/how-audio-is-organised.md) | The sound archives, `.dat*.rel` files, banks, scenes |
| [Music and radio](/docs/audio/music-and-radio.md) | Stations, tracks, how to add one |
| [Speech and dialogue](/docs/audio/speech-and-dialogue.md) | Voices and ambient speech |
| [Cookbook: audio](cookbook/audio.md) | Playing sounds from script with cleanup |
| [Vehicles](/docs/entities/vehicles/vehicles.md) | The audio name each car points to (engine, horn, siren) |
| [Weapons](/docs/gameplay/weapons/weapons.md) | The audio hash each weapon points to |
| [Archives and content](/docs/core/archives-and-content.md) | How DLC packs register audio |

**Gaps:** the audio `.rel` files are on the wanted list in [file formats](/file-formats/README.md); there is no format page yet.

## 12. Missions, heists and new stories

Single-player story extensions, side activities (trafficking, racing, trucking) and heists. These are script mods with the most to learn from Rockstar's own scripts.

| Start with | Why |
| --- | --- |
| [Mission anatomy](/docs/gameplay/missions/mission-anatomy.md) | Stages, checkpoints, retry, fail, pass, cleanup |
| [Cookbook: missions](cookbook/missions.md) | A mod-sized mission skeleton |
| [Story flow](/docs/gameplay/missions/story-flow.md), [story script catalog](/docs/gameplay/missions/story-script-catalog.md) | How Rockstar sequences and launches the story |
| [Strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) | The distance-triggered side-mission pattern |
| [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md) | The shared activity launcher, payouts |
| [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) | Dressing actors and building conversations |
| [Story-mode UI](/docs/ui/story-mode-ui.md), [text labels](/docs/ui/text-labels.md), [scaleform](/docs/ui/scaleform.md) | Objectives, mission-passed screens, subtitles |
| [Character switching](/docs/gameplay/player/character-switching.md) | Multi-character missions |
| [Wanted level and police](/docs/ai/wanted-level-and-police.md), [spawning and AI](cookbook/spawning-and-ai.md), [script AI patterns](/docs/ai/script-ai-patterns.md) | Enemies, chases, crews |
| [Saves](/docs/core/saves.md), [completion](/docs/core/completion-and-autosave.md) | Keeping mission progress in your own file |
| [Ideas list](ideas.md) | Sized project ideas, such as a side-mission framework |

**Heists specifically.** A story-mode heist is a mission with a planning board, crew choice, a prep step and a finale. Read [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) and [story flow](/docs/gameplay/missions/story-flow.md) first. Then read how Rockstar built them: [Heists](/docs/online/heists.md) (planning scripts, preps, finales, crew cuts and takes), [job lobby](/docs/online/job-lobby.md) and [creator internals](/docs/online/creator-internals.md). Those are Online scripts; read them to learn the design and reproduce it in story mode, never to run in Online. The [UGC files](/file-formats/ugc-json.md) page and the ideas list's local job player show how a job's data can be rebuilt offline.

**A new story.** You also need [DLC storylines](/docs/online/dlc-storylines.md) (how Rockstar's flows deliver beats), [script launch graph](/scripting/script-launch-graph.md) (who starts whom) and the [global map](/docs/core/global-map.md). **Gaps:** you cannot add fields to the story save ([saves](/docs/core/saves.md)); keep your story's state in your own file.

## 13. Save games

Downloadable saves with full completion, money or a set progression point. This repo explains what is inside a save so you can understand them; it does not provide saves or edit tools.

| Start with | Why |
| --- | --- |
| [Saves](/docs/core/saves.md) | What the story save holds, sizes, when it is written, where mods should keep their data |
| [Completion, autosave and achievements](/docs/core/completion-and-autosave.md) | What "100%" is made of and the weights |
| [Story flow](/docs/gameplay/missions/story-flow.md) | What a "progression point" means in the mission flow |
| [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) | Cash stats and how money changes |
| [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md) | What a respawn resets |

**Cautions.** Back up your saves before testing anything. A bad value in a saved global stays in the save at the next autosave. Never use edited saves in GTA Online.

## Common reading for every mod

| Page | Why |
| --- | --- |
| [Debugging](08-debugging.md) | Read the right log first |
| [Surviving updates](/docs/core/surviving-updates.md) | Use names, not numbers, so the mod outlasts patches |
| [Next steps and sharing](09-next-steps-and-sharing.md) | How to release a mod safely: your own work only, no Rockstar files |
| [Glossary](/docs/00-getting-started/glossary.md) | Handle, hash, native, pack |
| [Tools and resources](/docs/00-getting-started/toolbox.md) | Every tool, with its official link |

## Gaps in this repo (what the map cannot point to yet)

| Missing page | Affects categories |
| --- | --- |
| Texture dictionary (`.ytd`) and model (`.ydr`, `.yft`, `.ydd`) formats | 3, 6, 7, 9, 10 |
| `ymap`, `ytyp` and navmesh formats | 8 |
| Audio `.rel` format | 11 |
| `vehicles.meta`, `carcols`, `carvariations`, `peds.meta`, `timecycle` format pages (the topic guides cover the fields) | 3, 6, 7, 9 |

These are on the "wanted" list in [file formats](/file-formats/README.md). If you know one of them, a page would unblock many mods: see [CONTRIBUTING.md](/CONTRIBUTING.md).
