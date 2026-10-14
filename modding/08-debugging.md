# 8. Debugging: when nothing happens

Most "my mod doesn't work" problems are one of a dozen causes, and the logs name almost all of them. This page is the order to check things in. Part of the [modding path](README.md). Language-specific tools: [C#](/scripting/csharp-shvdn3.md#debugging), [Lua](/scripting/lua.md#debugging), [C++](07-first-asi-mod.md#6-debugging).

## Short version

- **Read the logs first, every time.** They're in the game folder and rewritten on every launch, so their timestamps tell you whether they're from the run you just did.
- Work from the bottom of the load chain up: did the loader load the plugin, did ScriptHookV accept the game version, did the runtime load your script, did your script throw?
- Change one thing at a time. Turn mods off by renaming (`.asi` to `.asi.off`, `.dll` to `.dll.off`), not by deleting.

## The logs, in the order to read them

| # | Log (game folder) | Answers | Written by |
| --- | --- | --- | --- |
| 1 | `asiloader.log` | Did my `.asi` (or `ScriptHookVDotNet.asi`, `LUA.asi`) load at all? | The ASI loader (`dinput8.dll`) |
| 2 | `ScriptHookV.log` | Which game version was detected? Did each plugin register its script? | ScriptHookV |
| 3 | `ScriptHookVDotNet.log` | Which script files loaded? Every exception with a stack trace | SHVDN |
| 4 | Your own log | What your code thought was happening | You (see each language's page) |
| 5 | Windows Event Viewer, Application | Which module crashed the game | Windows |
| 6 | Other mods' logs (`OpenIV.log`, trainer logs) | Did a data mod's archive get redirected? | Each mod |

Also useful for C#: the **F4 console** shows exceptions live; `ListScripts()` shows what's running.

## Symptom, likely cause, fix

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| No mod works at all after a game update | ScriptHookV doesn't support the new build yet (`ScriptHookV.log` shows the version problem) | Wait for a ScriptHookV update; nothing else helps ([surviving updates](/docs/core/surviving-updates.md)) |
| My `.asi` isn't in `asiloader.log` | Wrong folder, wrong extension, a 32-bit build, or Windows blocked the downloaded file | Next to `GTA5.exe`; build x64; Properties, Unblock |
| SHVDN loads but my script isn't listed | Class not `public`, doesn't extend `Script`, or the `.cs` doesn't compile | Read the error in `ScriptHookVDotNet.log` / F4 |
| Script runs then stops | An exception in `Tick` (SHVDN aborts the script), or the script hung past `ScriptTimeoutThreshold` | Stack trace in the log names the line; move slow work out of `Tick` |
| Key does nothing | Another mod uses that key, or a menu has focus | Check every mod's ini for the key; pick another |
| Text appears for one frame | Drawn once, not every frame | Draw it in `Tick` / the loop |
| Spawned entity never appears | Model not loaded, or bad model name (hash 0) | Request the model and wait until loaded; check the name |
| Game stutters with my mod on | Heavy work every frame: file access, scanning all peds, logging every frame | Do it every N ms (`Interval`, a timer), cache results |
| Game freezes (C++) | A loop without `scriptWait` | Wait in every loop iteration |
| Game crashes to desktop (C++) | Natives outside the script thread, a bad pointer, an unloaded model | Event Viewer names the module; attach the debugger |
| Every Lua addin stopped | A syntax error in one Lua file | Undo the last change; wrap code in `pcall` and log errors |
| Data edit has no effect | Edited the original instead of the `Mods\` copy, or the car takes its handling from its DLC pack | See [step 4](04-first-data-edit.md#5-test-it) |
| Worked yesterday, not today, nothing changed | The game updated in the background | Check the build in `ScriptHookV.log` |

## Finding which mod breaks things

With many mods installed, halve the problem:

1. Turn off half of your mods (rename to `.off`), start the game.
2. Problem gone? It's in the half you turned off. Still there? It's in the half still on.
3. Repeat on the guilty half until one mod is left.

For SHVDN scripts there's a shortcut: set `AutoLoadScripts=false` in `ScriptHookVDotNet.ini`, then start them one at a time with `Start("Name.dll")` in the F4 console.

## Habits that prevent bugs

- **Log events, not frames.** One line when something starts, changes or fails, with the time. Never one line per frame.
- **Check before you use.** In C#, `CurrentVehicle` is `null` on foot and entities can be deleted under you (`Exists()`); in C++ and Lua, `DOES_ENTITY_EXIST`.
- **Clean up on stop.** Delete what you spawned, restore what you changed. Mods that don't are the usual cause of "the world is full of cars" and "the police never come any more".
- **One change, one test.** Then you know which change did it.
- **Keep a test save** near where you test, and back up your real saves.

## Exercises

1. Break your step 5 script on purpose: read a property of `CurrentVehicle` while on foot. Find the exception in the F4 console and in `ScriptHookVDotNet.log`, and read the stack trace down to your line.
2. Add a one-line log entry to your mod when it loads and each time the key is pressed. Check the times against when you pressed it.
3. Put `System.Threading.Thread.Sleep(30)` at the start of your `Tick` handler and watch the frame rate drop: the game waits for your handler every frame. Swap it for `Script.Wait(30)` and the game runs smoothly again, because `Wait` pauses only your script and hands the frame back. Remove both. That's what "keep `Tick` cheap" means.

Next: [9. Next steps and sharing your mod](09-next-steps-and-sharing.md).
