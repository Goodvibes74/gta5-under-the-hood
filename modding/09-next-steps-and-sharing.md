# 9. Next steps and sharing your mod

You've installed the basics, changed a data file and written a script. This page points to where to go deeper, and how to release a mod so it's safe and easy for others to use. Part of the [modding path](README.md).

## Going deeper

| You want to | Read | Then try |
| --- | --- | --- |
| Use more of the C# API | [C# with SHVDN 3](/scripting/csharp-shvdn3.md) | Rewrite your step 5 mod to spawn, follow and clean up a ped |
| Add menus, notifications, phone contacts | [Menus and UI](/scripting/menus-and-ui.md), examples [04](/examples/04_LemonMenu.cs) and [05](/examples/05_PhoneContact.cs) | A three-item menu that changes time, weather and wanted level |
| Find and call any native | [Natives](/scripting/natives.md) | Pick a native you've never used from NativeDB and get it working |
| See how Rockstar does it | [Decompiled scripts](/docs/00-getting-started/decompiled-scripts.md), [mission anatomy](/docs/gameplay/missions/mission-anatomy.md), [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) | Search the decompile for a native you use and read two places the game calls it |
| Understand the engine you're running inside | [Script VM](/scripting/script-vm.md), [runtime scripts](/docs/core/runtime-scripts.md), [memory and pools](/docs/core/memory-and-pools.md) | Explain why spawning 500 cars fails |
| Tune vehicles, weapons, AI | [Vehicle handling](/docs/physics/vehicle-handling.md), [weapons](/docs/gameplay/weapons/weapons.md), [combat and perception](/docs/ai/combat-and-perception.md) | Make a gang hate another gang with relationship groups |
| Keep your mod working after updates | [Surviving updates](/docs/core/surviving-updates.md) | Check your mod against its seven code rules |
| Make a story-mode "Online" style mod | [Story systems in an Online mode](/docs/online/story-systems-in-online-mode.md), [inside freemode](/docs/online/07-freemode.md) | Read which story systems keep running and why |
| Add new cars, maps, models | [Archives and content](/docs/core/archives-and-content.md), [DLC packs](/docs/entities/vehicles/dlc-packs.md), [file formats](/file-formats/README.md) | Install an add-on car pack by hand and read its `setup2.xml` |

## Project ideas, in rough order of difficulty

1. A key that toggles a speedometer, coordinates and current street name on screen.
2. A menu that spawns your three favourite cars, each with its own colour and upgrades.
3. A "bodyguard" key: spawn a ped who follows you and fights with you, and is removed when the script stops.
4. A timed checkpoint race: blips, a timer on screen, a best time saved to an `.ini`.
5. A small mission: go to a place, a short scene, an enemy group, a reward, with fail conditions and cleanup. Model it on [mission anatomy](/docs/gameplay/missions/mission-anatomy.md).

## Sharing a mod

### Before you release

- **Only your own work.** No game files (no extracted `.meta`, models or textures from Rockstar's archives, unless your mod's format genuinely requires a changed copy, and then say so), no decompiled game code, no other people's mods or libraries bundled in. Point to dependencies' official pages instead.
- **Never ship ScriptHookV, SHVDN, LemonUI or the ASI loader** with your mod. Players install them from their official pages, which keeps them updated and keeps malware out.
- **Clean build.** Release build, no debug logging every frame, no test keys left on, no hard-coded paths from your PC.
- **Test on a clean install** if you can: only the dependencies your readme lists, nothing else.
- **Pick a default key that's rarely used,** and make every key configurable in an `.ini`.

### What the readme needs

| Section | What |
| --- | --- |
| What it does | Two or three sentences and a screenshot or short clip |
| Requirements | Game edition and build you tested, ScriptHookV, SHVDN version (or Lua plugin), any library (LemonUI ...), each with its official link |
| Install | Exactly which files go where (`scripts\`, game folder), as numbered steps |
| Controls | Every key and controller button, and how to change them |
| Settings | Every `.ini` option with its default |
| Uninstall | Which files to delete |
| Known problems | Conflicts with other mods, things that don't work yet |
| Credits and licence | Who you built on (libraries, ideas, tutorials), and the licence for your work (MIT for code is common) |
| Single-player notice | "Story mode only. Do not use in GTA Online." |

### Versions and updates

- Number releases (`1.0.0`, `1.0.1` for fixes, `1.1.0` for features) and keep a short changelog.
- Say which game build and which ScriptHookV / SHVDN version each release was tested on.
- After a game update, re-test before telling players it works.

### Where to publish (**Known**)

| Where | Good for |
| --- | --- |
| gta5-mods.com | The main GTA V single-player mod site; most players look here |
| GitHub releases | Open source mods, issue tracking, version history |
| Nexus Mods | Also hosts GTA V mods; good mod manager support for some games |

Publish source code where you can. Other modders learn from it, and it shows players there's nothing hidden in your DLL.

## Give back to this repo

Everything you learned while building your mod is useful to the next person:

- A trick, tool or website that saved you time: add it to [tools and resources](/docs/00-getting-started/toolbox.md#contributed-tools-and-resources).
- Something the game does that no guide explains yet: open an inbox issue ([roadmap](/ROADMAP.md#inbox)).
- A topic you'd like to research properly: claim it ([CONTRIBUTING.md](/CONTRIBUTING.md)).
- A step on this path that confused you: fix the page.

Back to the [start of the path](README.md).
