# 3. Install the basics and check they load

Install ScriptHookV and ScriptHookVDotNet, then prove they work by reading their logs, before writing any code. When a mod "does nothing" later, this is the baseline you compare against. Part of the [modding path](README.md).

## Short version

- Copy three files from ScriptHookV (`ScriptHookV.dll`, `dinput8.dll`, optionally `NativeTrainer.asi`) and the SHVDN files into the folder that holds `GTA5.exe`, and make a `scripts` folder there.
- Start the game in **story mode** with BattlEye off.
- Read `asiloader.log`, `ScriptHookV.log` and `ScriptHookVDotNet.log` in the game folder. If they show your plugins loading, you're ready.
- Keep a list of every file you add, so you can remove them all later.

## 1. Find your game folder

The folder that contains `GTA5.exe`. Common places (**Known**):

| Store | Usual folder |
| --- | --- |
| Steam | `...\Steam\steamapps\common\Grand Theft Auto V` (in Steam: right-click the game, Manage, Browse local files) |
| Epic | `...\Epic Games\GTAV` |
| Rockstar Games Launcher | `...\Rockstar Games\Grand Theft Auto V` |

Every path on this path is relative to that folder.

## 2. Keep a list and a way back

- Make a text file somewhere outside the game folder called `my-mod-files.txt`. Write down every file you add to the game folder, from now on. Uninstalling is then just deleting what's on the list.
- You don't need to back up the 90+ GB game: your store's "verify files" feature (Steam: Properties, Installed Files, Verify integrity) restores changed or missing **original** files. It does not remove files you added, which is what the list is for.
- Back up your **story save** before testing mods that change missions or money: `Documents\Rockstar Games\GTA V\Profiles\<id>\` holds `SGTA5*` files. Copy them somewhere safe.

## 3. Install ScriptHookV

1. Download ScriptHookV from http://www.dev-c.com/gtav/scripthookv/ (the same page has the SDK for step 7).
2. Check that its supported version list includes your game build. If your game updated last night and ScriptHookV hasn't, wait for the update: there is no workaround.
3. From the archive's `bin` folder, copy into the game folder:

   | File | What it is |
   | --- | --- |
   | `ScriptHookV.dll` | The script hook itself |
   | `dinput8.dll` | The ASI loader, which loads every `.asi` |
   | `NativeTrainer.asi` (optional) | A small sample trainer. Handy for a first test (F4 opens it by default, **Known**); remove it later if another mod wants that key |

4. Add all three to your list.

## 4. Install ScriptHookVDotNet (for C#)

1. Download the latest nightly from https://github.com/scripthookvdotnet/scripthookvdotnet-nightly/releases.
2. Copy `ScriptHookVDotNet.asi`, `ScriptHookVDotNet2.dll`, `ScriptHookVDotNet3.dll` and `ScriptHookVDotNet.ini` into the game folder (the `.xml` files beside the DLLs are API documentation for your editor; copying them does no harm).
3. Create a folder named `scripts` in the game folder. Your C# and Lua mods go there.
4. Add them all to your list.

Doing the Lua path? Install the Lua plugin now too, following its readme (it adds `LUA.asi` and a few files in `scripts`). Step 6 covers it.

## 5. Start the game

- Script mods need the game started **with BattlEye off**. BattlEye is the anti-cheat for GTA Online; with it off, Online is not available, which is what you want. Steam: launch options `-nobattleye`; Rockstar Games Launcher: the game's settings page has a BattlEye switch (**Known**, wording changes between launcher versions).
- Load **story mode**. Never Online.
- Wait until you control your character, play for a minute, then quit to the desktop.

## 6. Read the logs

Every launch rewrites these files in the game folder. Open them with your text editor:

| Log | What to look for | If it's wrong |
| --- | --- | --- |
| `asiloader.log` | One line per `.asi` it loaded: `ScriptHookVDotNet.asi`, `NativeTrainer.asi`, later your own | Missing file: wrong folder, or blocked by Windows (right-click the file, Properties, Unblock) |
| `ScriptHookV.log` | The game version it detected, then each plugin registering a script | "Unknown" or unsupported version: ScriptHookV is older than the game; update it |
| `ScriptHookVDotNet.log` | SHVDN starting, then one line per script file loaded from `scripts` (none yet) | Missing: the `.asi` didn't load (see `asiloader.log`) or a runtime is missing ([system requirements](/docs/00-getting-started/system-requirements.md)) |

What "good" looks like (shape, not exact text):

```text
asiloader.log          ... Loaded "ScriptHookVDotNet.asi"
ScriptHookV.log        ... GAME VERSION ...  /  ... REGISTERED SCRIPT ...
ScriptHookVDotNet.log  ... Initializing NativeMemory members ... / ... Loading scripts from ...\scripts
```

## 7. One in-game check

In story mode, press **F4**. With SHVDN installed and `NativeTrainer.asi` removed, the SHVDN console should drop down (its key is set in `ScriptHookVDotNet.ini`, `ConsoleKeyBinding`). Type `Help()` and press Enter. A list of commands means C# scripting is ready. (If `NativeTrainer.asi` is still there, both react to F4; that's the first keybind clash of your modding life. Remove the trainer or change SHVDN's key.)

## Uninstalling everything

Delete every file on your list, then verify the game files with your store. The game is back to vanilla.

## Exercises

1. Open `ScriptHookV.log` and find the game version line. Does it match the build from step 2's exercise?
2. Rename `ScriptHookVDotNet.asi` to `ScriptHookVDotNet.asi.off`, start the game, and read `asiloader.log` again. What changed? Rename it back. (You've just learned how to turn a plugin off without deleting it.)
3. Change `ConsoleKeyBinding` in `ScriptHookVDotNet.ini` to a key you don't use, and check that the console opens with it.

Next: [4. Your first data edit](04-first-data-edit.md), or skip to [5. Your first C# mod](05-first-csharp-mod.md).
