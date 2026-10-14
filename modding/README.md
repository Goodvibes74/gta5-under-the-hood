# Modding GTA V: start here

A guided path from "I have the game" to "I wrote, tested and shared my own mod". Each step is one short page that ends with something working in the game and a few exercises. The rest of this repo explains *how the game works*; this folder is the on-ramp that tells you what to read, in what order, and what to do with it. Roadmap topic **R12.6** in the [roadmap](/ROADMAP.md).

You need a legitimately purchased copy of GTA V for PC. Everything else on this path is free. No programming experience is assumed: if you've never written code, the C# and Lua steps double as a first programming course (see [learn to code by modding](/README.md#learn-to-code-by-modding-gta-v)).

**Single player only.** Never start GTA Online with mods installed: accounts get banned. Every page here assumes story mode.

## The path

| Step | Page | You will end with | Time |
| --- | --- | --- | --- |
| 1 | [How mods work](01-how-mods-work.md) | A picture of what loads what, and which kind of mod fits your idea | 15 min |
| 2 | [The tools you need](02-tools-you-need.md) | A short shopping list (all free, all linked) for the path you picked | 15 min |
| 3 | [Install the basics and check they load](03-install-and-check.md) | ScriptHookV and ScriptHookVDotNet installed, a backup, and logs that prove it works | 30 min |
| 4 | [Your first data edit](04-first-data-edit.md) | A car that drives differently, made by changing one value in `handling.meta` | 30 min |
| 5 | [Your first C# mod](05-first-csharp-mod.md) | A script that reacts to a key, first as a loose `.cs` file, then as a built `.dll` | 1 hour |
| 6 | [Your first Lua script](06-first-lua-script.md) | The same idea in Lua, with no compiler at all | 30 min |
| 7 | [Your first C++ (.asi) mod](07-first-asi-mod.md) | A native plugin built with the ScriptHookV SDK | 1 to 2 hours |
| 8 | [Debugging: when nothing happens](08-debugging.md) | A habit of reading the right log first, and a table of the usual causes | 20 min |
| 9 | [Next steps and sharing your mod](09-next-steps-and-sharing.md) | Where to go deeper, and how to release a mod safely | 20 min |

Steps 5, 6 and 7 are alternatives. Most people do 5 and stop there for a while; 6 is a quick detour; 7 is for when you need speed or low-level access. Step 4 needs no programming and is a good first win.

## Which step for which idea

| Your idea | Go to |
| --- | --- |
| "This car is too slow", "this gun is too weak", "peds see too far" | Step 4 (data files), then [file formats](/file-formats/README.md) |
| "Spawn things", "add a menu", "a new mission", "a phone contact", "change the HUD" | Step 5 (C#), then [scripting](/scripting/README.md) and the [examples](/examples/README.md) |
| "Try a small tweak tonight without installing a compiler" | Step 6 (Lua) |
| "Draw with DirectX", "read the game's memory", "it must be fast" | Step 7 (C++) |
| "I want to know *why* the game does X" | [The guides](/README.md#start-here), then [decompiled scripts](/docs/00-getting-started/decompiled-scripts.md) |

## What's elsewhere in this repo (and not repeated here)

These pages link into the existing guides instead of copying them:

| Need | Page |
| --- | --- |
| Exact versions of every tool and dependency | [Setup](/docs/00-getting-started/setup.md) |
| Windows runtimes the game and mods need | [System requirements](/docs/00-getting-started/system-requirements.md) |
| Running the game and mods on Linux | [Linux](/docs/00-getting-started/linux.md) |
| Words you'll meet (handle, hash, native, pack ...) | [Glossary](/docs/00-getting-started/glossary.md) |
| Which language for which job | [Languages](/scripting/languages.md) |
| The full C# API tour | [C# with SHVDN 3](/scripting/csharp-shvdn3.md) |
| Menus, notifications, phone contacts | [Menus and UI](/scripting/menus-and-ui.md) |
| Natives: finding and calling them | [Natives](/scripting/natives.md) |
| Lua plugin in depth | [Lua](/scripting/lua.md) |
| Six worked C# samples | [Examples](/examples/README.md) |
| Every tool and website used, with links | [Tools and resources](/docs/00-getting-started/toolbox.md) |

## Topics for this folder

| ID | Topic | Status |
| --- | --- | --- |
| R12.6 | **Modding path for beginners** | **Done** (first pass): this folder |

## Help improve this path

Got stuck on a step? That's a bug in the page, not in you. Open an issue saying which step and what happened, or send a fix (branch `fix/modding-<what>`, see [CONTRIBUTING.md](/CONTRIBUTING.md)). New exercises and worked examples are welcome too.
