# 1. How mods work

Before installing anything, it helps to know what a "mod" actually is in GTA V, because there are two very different kinds and they load in different ways. Part of the [modding path](README.md).

## Short version

- GTA V has **two kinds of mods**: **data mods** change the game's files (how a car drives, what a gun does, a new car model), and **script mods** run your own code inside the game while it plays.
- Script mods are loaded by an **ASI loader** (`dinput8.dll`), which loads every `.asi` file in the game folder. **ScriptHookV** is the `.asi`-level library almost every script mod depends on.
- On top of ScriptHookV sit the script runtimes: **ScriptHookVDotNet** for C#, the **Lua plugin** for Lua, or your own C++ `.asi`.
- Every script mod, in any language, works the same way: **a loop that runs once per frame, calls the game's own functions (natives), then gives the frame back**.
- Data mods go either into a **new add-on pack** (safe, survives updates) or into a **modified copy of a Rockstar archive** in OpenIV's mods folder (changes existing things, goes stale with game updates).
- Never edit the original game archives. Never take mods into GTA Online.

## What loads what

```text
GTA5.exe
 └─ dinput8.dll                 the ASI loader: Windows loads it with the game, it loads every *.asi
     ├─ ScriptHookV.dll         lets plugins call the game's script functions ("natives") and wait a frame
     │   ├─ YourMod.asi         a C++ plugin (step 7)
     │   ├─ ScriptHookVDotNet.asi  hosts .NET: loads scripts\*.dll and scripts\*.cs  (step 5)
     │   │    └─ YourMod.dll / YourMod.cs   your C# script
     │   └─ LUA.asi             the Lua plugin: runs scripts\main.lua and its addins   (step 6)
     └─ OpenIV.asi              redirects archive reads to the Mods\ folder (for data mods, step 4)
```

The game itself is written mostly in a script language of its own (compiled `.ysc` scripts that run in a virtual machine), and those scripts talk to the engine through about 6,700 **natives** such as `PLAYER_PED_ID` or `CREATE_VEHICLE`. ScriptHookV lets your code call the very same natives. That's why the [decompiled game scripts](/docs/00-getting-started/decompiled-scripts.md) are such a good teacher: they show how Rockstar used each native. More in [script VM](/scripting/script-vm.md) and [boot](/docs/00-getting-started/boot.md).

## The two kinds of mods

| | Data mod | Script mod |
| --- | --- | --- |
| What you change | Files the game reads at load: `handling.meta`, `weapons.meta`, models, textures, maps | Nothing on disk: your code runs alongside the game's scripts |
| Language | XML / `.meta` text, or binary assets made in OpenIV, CodeWalker or Blender | C#, Lua or C++ |
| Takes effect | Next game start | Next game start (C# `.cs` files and Lua can be reloaded in game) |
| Breaks on game update? | Replacement edits go stale; add-on packs usually survive | Usually breaks until ScriptHookV is updated, then works again |
| Typical examples | Faster car, stronger weapon, new add-on car, map edit | Trainer, menu, spawner, new mission, HUD change |
| First step on this path | [Step 4](04-first-data-edit.md) | [Step 5](05-first-csharp-mod.md) |

Many real mods are both: a script plus an add-on pack of models.

## The frame loop (the one idea that matters most)

The game draws a frame, runs every script once, and repeats, about 30 to 144 times a second. Every script mod is a guest in that loop:

1. **Your code runs once per frame.** C# gets a `Tick` event; C++ writes `while (true) { ...; scriptWait(0); }`; Lua writes a `tick()` function.
2. **Inside, you call natives** to read and change the world.
3. **Then you hand the frame back.** A slow loop makes the game stutter. A loop that never hands back freezes the game.

Two consequences you'll meet on every page:

- **Natives only work on a script thread**, inside that loop. Not from a background thread, not from a C++ `DllMain`.
- **Anything you draw must be drawn every frame.** Text drawn once is gone the next frame.

More: [script VM](/scripting/script-vm.md), section on cooperative threads.

## Data mods: add-on vs replacement

The game reads its files from RPF archives (`common.rpf`, `x64*.rpf`, `update\update.rpf`, and one `dlc.rpf` per DLC pack). There are two ways to change what it reads ([archives and content](/docs/core/archives-and-content.md)):

| | Add-on | Replacement |
| --- | --- | --- |
| How | A new DLC pack folder plus one line in `dlclist.xml` | A changed file inside a copy of a Rockstar archive in `Mods\` |
| Adds new things (a new car with its own name) | Yes | No |
| Changes existing things (the Adder's top speed) | No | Yes |
| After a game update | Keeps working | The copy is stale: it hides the update's changes until you redo it |

OpenIV's `OpenIV.asi` and its "mods folder" make the game read `Mods\<path>` instead of the original whenever a copy exists there. This is what keeps the original files untouched.

## Safety rules for every step

- **Single player only.** Never start GTA Online with mods installed. Accounts get banned. (**Known.**)
- **Never edit the original archives** in the game folder. Use OpenIV's mods folder or add-on packs.
- **Back up** anything you're about to change that you can't re-download (step 3 shows how).
- **Get tools and mods from their official pages only.** Re-uploads are how malware spreads. Every link in this repo is to an official page.
- **After every game update,** expect script mods to stop until ScriptHookV catches up ([surviving updates](/docs/core/surviving-updates.md)).

## Exercises

1. Draw the load chain above from memory, then check it.
2. For three mods you'd like to make, say whether each is a data mod, a script mod or both, and which language you'd use. Check against [languages](/scripting/languages.md).
3. Look up `PLAYER_PED_ID` and `SET_ENTITY_HEALTH` on [NativeDB](https://nativedb.dotindustries.dev/gta5/natives). What does each take and return?

Next: [2. The tools you need](02-tools-you-need.md).
