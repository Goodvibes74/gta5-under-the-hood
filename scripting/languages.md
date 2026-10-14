# Languages for modding GTA V

Which languages and formats you need to mod GTA V, what each one is for, and an order to learn them in. It works the other way round too: **if you want to learn C#, Lua, C++ or scripting, modding GTA V is a fun way to do it**, because every exercise ends in something you can see in the game. The learning path below doubles as a programming course. Roadmap topic **R12.4** in the [roadmap](/ROADMAP.md) (first version; additions welcome).

## Short version

- **Data files (XML and `.meta`)** change how things are tuned: vehicles, weapons, peds, AI, physics, population. No programming needed. Start here.
- **C#** with ScriptHookVDotNet is how most script mods are written: new gameplay, menus, missions, spawning.
- **Lua** with the Lua plugin is the quickest way to try an idea: no compiler, edit and reload.
- **C++** with ScriptHookV is for performance-critical mods and anything that touches the game's memory or needs hooks.
- **Reading C-like code** is how you learn what the game itself does: the decompiled game scripts read like C.
- **PowerShell or bash** are for research and tooling: searching the decompile, extracting and comparing data files.

## Which language for which job

| You want to... | Use | What you write | Runs through | Guide |
| --- | --- | --- | --- | --- |
| Change how a car drives, a gun shoots, how far peds see | **XML / `.meta`** | Edited data files in an add-on pack or the mods folder | The game's own loader | [file formats](/file-formats/README.md), [vehicle handling](/docs/physics/vehicle-handling.md), [weapons](/docs/gameplay/weapons/weapons.md) |
| Add gameplay: spawns, missions, menus, phone contacts, HUD | **C#** | A class that extends `GTA.Script` (`.dll` or a loose `.cs` file) | ScriptHookVDotNet (v3) | [C# with SHVDN 3](csharp-shvdn3.md), [menus and UI](menus-and-ui.md), [examples](/examples/README.md) |
| Try something quickly, small scripts and menus | **Lua** | A `.lua` file the plugin runs | The Lua plugin for ScriptHookV | [Lua](lua.md) |
| Fast or low-level mods: memory, pools, hooks, engine patches | **C++** | An `.asi` (a DLL) | ScriptHookV, the ASI loader | ScriptHookV SDK (see [setup](/docs/00-getting-started/setup.md)) |
| Call any engine function from any of the above | **Natives** | `ENTITY::SET_ENTITY_COORDS(...)` and 6,700 more | All script runtimes | [natives](natives.md) |
| Understand what the game does before changing it | **C-like reading** | Nothing: you read decompiled scripts | `git grep` on a decompile | [decompiled scripts](/docs/00-getting-started/decompiled-scripts.md), [script VM](script-vm.md) |
| Configure mods | **INI** | `Key = value` settings | Each mod | Each mod's readme |
| Read and write mission-creator jobs | **JSON** | UGC mission files | The game's mission controllers | [UGC JSON](/file-formats/ugc-json.md) |
| Map placements, object types, binary metadata | **CodeWalker XML** | `.ymap`, `.ytyp`, `.ymt` converted to XML and back | CodeWalker, OpenIV | [file formats](/file-formats/README.md) |
| Research, extraction, comparing builds | **PowerShell, bash** | Small read-only scripts | Your shell | [tools](/tools/README.md), [research tools](/docs/00-getting-started/research-tools.md) |

## Less common, but they show up

| Language | Where (**Known**) |
| --- | --- |
| **ActionScript 2** | The game's UI is Scaleform (Flash) movies (`.gfx`). Reading or making UI movies means ActionScript 2 and a Flash decompiler such as JPEXS |
| **JavaScript** | Some mods embed a JavaScript engine (for example through ClearScript) for user scripts; multiplayer platforms such as FiveM use it, but those are outside single player |
| **Rockstar's script language** | The game's own scripts were written in a C-like language and compiled to YSC. Community compilers exist for writing new YSC scripts; most modders use C#, C++ or Lua instead |
| **HLSL** | Shader and post-processing mods (and tools like ReShade) |
| **Python** | Some community tools and Blender add-ons (Sollumz, for importing and exporting game models); not needed for scripting |
| **GXT2 text** | The game's text label files, when a mod adds its own text (roadmap R8.3) |

## A learning path

1. **Data files.** Open a vehicle's `handling.meta` entry and a weapon in `weapons.meta` (extract them with CodeWalker or the [tools](/tools/README.md)), change one value in a copy, and test it. You'll learn the folders, the archives and how the game loads data. ([vehicle handling](/docs/physics/vehicle-handling.md))
2. **C# basics, then SHVDN.** Learn C# fundamentals (classes, events, lists) from any beginner course, then write the [hello world example](/examples/01_HelloWorld.cs): one `Tick` handler and one key. Then [player and world](/examples/02_PlayerAndWorld.cs) and [natives](/examples/03_Natives.cs).
3. **A menu.** [LemonUI](menus-and-ui.md) and the [menu example](/examples/04_LemonMenu.cs).
4. **Reading the game.** Pick a system you care about, read its guide here, then search the decompile for its natives. This is what turns copying into understanding.
5. **Then specialise:** C++ if you need speed or memory access, Lua for fast experiments, CodeWalker XML for map work, ActionScript for UI.

## Rules that apply in every language

- **Yield every frame.** All script runtimes share the game thread; a slow tick freezes the game ([script VM](script-vm.md)).
- **Natives over memory.** Memory offsets and global indices change with every game update; natives and data files survive (roadmap R11.5).
- **Clean up.** Delete what you spawn, put back what you changed (wanted level, traffic, relationships) when your mod stops ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)).
- **Single player only.** Mods in GTA Online get accounts banned.
