# 2. The tools you need

A shopping list per path, so you only install what your first mod needs. Everything is free. Links go to official pages only; never download these from re-upload sites. Exact versions used for this repo's research are in [setup](/docs/00-getting-started/setup.md). Part of the [modding path](README.md).

## Everyone

| Tool | Why | Get it |
| --- | --- | --- |
| GTA V for PC (Legacy edition, `GTA5.exe`) | The game. This repo's facts are for build 1.0.3725.0; see [setup](/docs/00-getting-started/setup.md) for Enhanced | Steam, Epic or Rockstar Games Launcher |
| ScriptHookV (includes the ASI loader `dinput8.dll`) | Needed by every script mod. Update it after every game update | http://www.dev-c.com/gtav/scripthookv/ |
| A text editor that shows line numbers | Editing `.ini`, `.xml`, `.meta`, `.lua`, `.cs` | Visual Studio Code: https://code.visualstudio.com |
| Windows runtimes | The game and mods need the Visual C++ 2015-2022 x64 runtime, .NET Framework 4.8 and DirectX June 2010 | [System requirements](/docs/00-getting-started/system-requirements.md) |

## Path A: data mods (step 4)

| Tool | Why | Get it |
| --- | --- | --- |
| OpenIV | Opens the game's archives, edits files inside them, and installs the "mods folder" (`OpenIV.asi`) so the originals stay untouched | https://openiv.com |
| CodeWalker (optional) | Map and model work; also opens encrypted archives for reading | https://github.com/dexyfex/CodeWalker/releases |

## Path B: C# script mods (step 5)

| Tool | Why | Get it |
| --- | --- | --- |
| ScriptHookVDotNet (SHVDN) | Runs C# scripts. Use the nightly builds for current game versions | https://github.com/scripthookvdotnet/scripthookvdotnet-nightly/releases |
| .NET SDK | `dotnet build` turns your project into a `.dll` (step 5, part 2). Not needed for loose `.cs` files | https://dotnet.microsoft.com/download |
| Visual Studio Community (optional) | An IDE with autocomplete and a debugger. Workload: ".NET desktop development" | https://visualstudio.microsoft.com/downloads/ |
| LemonUI (when you want menus) | The menu library for SHVDN v3 | https://github.com/LemonUIbyLemon/LemonUI/releases |

## Path C: Lua scripts (step 6)

| Tool | Why | Get it |
| --- | --- | --- |
| Lua Plugin for Script Hook V | Runs Lua 5.2 scripts. Old (2015) but works | gta5-mods.com, search "Lua Plugin for Script Hook V" |

## Path D: C++ plugins (step 7)

| Tool | Why | Get it |
| --- | --- | --- |
| Visual Studio Community with "Desktop development with C++" | The C++ compiler and debugger | https://visualstudio.microsoft.com/downloads/ |
| ScriptHookV SDK | Headers and `ScriptHookV.lib` to link against | http://www.dev-c.com/gtav/scripthookv/ (same page as ScriptHookV) |

## For testing any mod

| Tool | Why | Get it |
| --- | --- | --- |
| A trainer (Menyoo or similar) | Teleport, spawn cars, change time and weather, so you can reach a test quickly | https://github.com/itsjustcurtis/MenyooSP/releases |
| NativeDB | Look up every native: name, parameters, notes | https://nativedb.dotindustries.dev/gta5/natives |

## For learning how the game does it (later)

| Tool | Why | Get it |
| --- | --- | --- |
| Git | Clone the community decompile of the game scripts | https://git-scm.com/downloads |
| The decompiled scripts | Read how Rockstar's own scripts use natives | [Decompiled scripts](/docs/00-getting-started/decompiled-scripts.md) |
| This repo's read-only tools | List and extract archive files, dump script strings | [Tools](/tools/README.md), [research tools](/docs/00-getting-started/research-tools.md) |

## Learning the languages

| Language | A good free start |
| --- | --- |
| C# | Microsoft Learn, "Take your first steps with C#": https://learn.microsoft.com/dotnet/csharp/ |
| Lua 5.2 | "Programming in Lua", first edition (free online): https://www.lua.org/pil/ |
| C++ | https://www.learncpp.com |

You don't need to finish a course first. Learn classes, events and lists in C# (or tables and functions in Lua), then come back and do step 5 or 6. The examples teach the rest.

## Exercises

1. Pick your path (A, B, C or D) and write down the tools from its table plus "Everyone".
2. Find the version number of your game: right-click `GTA5.exe`, Properties, Details. Compare it with the build named in [setup](/docs/00-getting-started/setup.md).

Next: [3. Install the basics and check they load](03-install-and-check.md).
