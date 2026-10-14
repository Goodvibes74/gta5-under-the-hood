# Setup: game version and everything you need

What to install to read the game the way these guides did, and to try things in game. You need a legitimately purchased copy of GTA V. Everything else is free.

## The game version

| | |
| --- | --- |
| Edition | **GTA V Legacy** (the original PC edition, `GTA5.exe`). GTA V Enhanced (`GTA5_Enhanced.exe`) is a different build with different tools; research on it is welcome but must say so |
| Build | **1.0.3725.0** (game update 1.72). ScriptHookV reports it as `VER_1_0_3717_0` |
| Matching decompile | The commit titled "Update for 1.72-3725.0" in the community decompiled-scripts repository; verified byte for byte against the game's 1,143 scripts |
| DLC | 89 packs in `update\x64\dlcpacks`, up to the December 2025 update, all active |

Facts that change between builds (decompiler names, global indices, script sizes, pool sizes) are tied to this build. Most data-file facts (handling, weapons, materials) change rarely.

## To read the game (research)

| Tool | Version used | What for | Get it |
| --- | --- | --- | --- |
| CodeWalker | 30 dev46 | Opening encrypted archives; its `CodeWalker.Core.dll` powers the tools in [`/tools`](/tools) | https://github.com/dexyfex/CodeWalker/releases |
| OpenIV | 4.x (tool), `OpenIV.asi` 1.2.0.1 | Browsing and editing archives; the "mods" folder for safe edits | https://openiv.com |
| Git | any recent | Cloning the decompile and reading builds from its history | https://git-scm.com/downloads |
| A decompile of the game scripts | build 3725 commit | Reading the game's logic | Search GitHub for `GTA-V-Decompiled-Scripts` (community repository; see [decompiled scripts](decompiled-scripts.md)) |
| PowerShell | 5.1 (Windows) or 7 | Running the tools | Built into Windows; PowerShell 7: https://github.com/PowerShell/PowerShell |
| Bash with grep, awk, sed | Git for Windows' bash | Counting and searching the decompile | Comes with Git for Windows |
| NativeDB | online | Native names, parameters, notes | https://nativedb.dotindustries.dev/gta5/natives (data: https://github.com/alloc8or/gta5-nativedb-data) |

## To run mods (testing in game)

| Dependency | Version used | Get it |
| --- | --- | --- |
| ScriptHookV and its ASI loader (`dinput8.dll`) | 3889.0 (supports build 3725) | http://www.dev-c.com/gtav/scripthookv/ (update it after every game update) |
| ScriptHookVDotNet (SHVDN) | 3.7.0 nightly 189 | https://github.com/scripthookvdotnet/scripthookvdotnet-nightly/releases |
| LemonUI (menus for SHVDN v3) | 2.2.0 | https://github.com/LemonUIbyLemon/LemonUI/releases |
| NativeUI (legacy menus, only for old mods) | 1.9.0 | https://github.com/Guad/NativeUI/releases |
| iFruitAddon2 (phone contacts) | 3.1.1 | https://github.com/Bob74/iFruitAddon2/releases |
| Lua plugin for ScriptHookV | 1.0.0.1 (Lua 5.2) | gta5-mods.com, "Lua Plugin for Script Hook V" |
| A trainer for testing (Menyoo or similar) | Menyoo 2.4.x | https://github.com/itsjustcurtis/MenyooSP/releases |

Windows runtimes the game and mods need: Visual C++ Redistributable 2015-2022 x64 (https://learn.microsoft.com/cpp/windows/latest-supported-vc-redist), .NET Framework 4.8 (included in Windows 10 and 11), and the DirectX June 2010 runtime (from Microsoft's download center).

## To write mods

| Tool | What for | Get it |
| --- | --- | --- |
| Visual Studio Community | C# and C++ mods, debugging (attach to `GTA5.exe`) | https://visualstudio.microsoft.com/downloads/ (workloads ".NET desktop development" and "Desktop development with C++") |
| .NET SDK | `dotnet build` for SHVDN scripts (they target .NET Framework 4.8) | https://dotnet.microsoft.com/download |
| ScriptHookV SDK | C++ `.asi` mods | http://www.dev-c.com/gtav/scripthookv/ |
| ILSpy | Reading compiled .NET mods and libraries to learn their APIs (never republish what you read) | https://github.com/icsharpcode/ILSpy/releases |

## Quick start (research, about 30 minutes)

1. Install Git, CodeWalker and (optionally) OpenIV.
2. Clone the decompile repository next to this one, with its history. Find the commit for your build (`git log --oneline | grep 3725`).
3. Set `CODEWALKER_DIR` to your CodeWalker folder, open PowerShell in your game folder, and list an archive: `powershell -ExecutionPolicy Bypass -File <this repo>\tools\rpf-cw.ps1 -Archive update\update.rpf -Pattern "common\data\handling.meta"`.
4. Pick a topic in the [roadmap](/ROADMAP.md) and read [CONTRIBUTING.md](/CONTRIBUTING.md).
