# Techniques worth learning from established mods

Large script mods for GTA V solve the same problems over and over: changing what Rockstar's own scripts do without editing them, getting at engine data that no native exposes, spawning many entities without hitches, and staying out of the way of story missions. This page collects the techniques that work, how each one is built, what it costs, and when to use it. Roadmap topic **R10.2** in the [roadmap](/ROADMAP.md). It builds on [how mods work](01-how-mods-work.md), [native usage](/scripting/native-usage.md), [streaming](/docs/core/streaming.md), [controls and camera](/docs/gameplay/player/controls-and-camera.md) and [surviving updates](/docs/core/surviving-updates.md).

**How it was made.** The patterns come from studying how a set of popular single-player script mods are built: police and dispatch overhauls, a phone-contact library, heist and casino mods built on a shared helper library, trainers, a zombie mode and map editors. Each technique is described here in our own words, and **no mod code is reproduced**. To learn from a particular mod, read its source if the author published it (Menyoo's is [public](https://github.com/MAFINS/MenyooSP)), or ask the author; don't share decompiled copies. Rockstar's own use of the same natives was counted with the [native usage](/scripting/native-usage.md) pages (build 1.0.3725.0 Legacy, scripts and calls), so the counts are **Verified**. How a technique behaves inside a mod is **Known** unless stated.

## Short version

- **Check before you act.** `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH` (929 Rockstar scripts, 12,638 calls) tells a mod whether a given Rockstar script is running. It is the cheapest way to make a mod behave differently inside one mission or random event.
- **Respect the mission flag.** `GET_MISSION_FLAG` (82 scripts) is how Rockstar's ambient systems stay quiet during missions, and every story mission sets it (`SET_MISSION_FLAG` in 200 scripts). Ambient mods that spawn enemies or change the wanted level should skip their work while it is set. Many don't.
- **Restart a Rockstar script to make it reread data.** Stop it with `TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME` (40 Rockstar scripts use it), then `REQUEST_SCRIPT` and `START_NEW_SCRIPT` it again. Phone-contact libraries use this to make the phone pick up added contacts.
- **Spawn through a queue.** Request one model, wait for `HAS_MODEL_LOADED` (739 Rockstar scripts, 20,953 calls), spawn, release the model, then do the next one. One spawn per frame or slower avoids the hitches that a burst of `CREATE_PED` calls causes.
- **Put engine work in a small C++ `.asi` and call it from C#.** A native plugin exports plain functions, and the C# side calls them with `[DllImport("YourPlugin.asi")]`. This keeps memory patterns and hooks in one small native file that is easy to update after a patch.
- **Hooking a native for chosen scripts only** is the strongest technique: it changes what Rockstar's scripts spawn without touching them. It is also the most fragile one. Use it for a few natives, keep the list of scripts in a data file, and expect to update it after every game patch.
- **Drive behaviour from data.** Unit counts per wanted level, spawn lists and model swaps live best in XML or ini files, so players can tune them and the mod survives balance changes without a rebuild.
- **Watch for controls from 257 up.** Build 3717 inserted 37 controls at 257, so every control from there on moved by 37. Older mods (and enums written for older builds) still pass the old numbers.

## The techniques

| Technique | What it solves | Natives or tools | Cost and risk |
| --- | --- | --- | --- |
| Script-running check | Act differently inside one Rockstar mission or random event | `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH`, the script's name hashed with `joaat` | Cheap; check every second or so, not every frame |
| Mission-flag guard | Keep ambient spawns, wanted-level changes and phone calls out of story missions | `GET_MISSION_FLAG` | Cheap. Skipping it is the most common compatibility bug |
| Stop and restart a Rockstar script | Make a script reread data the mod changed (contacts, shop stock) or remove it from an area | `TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME`, `REQUEST_SCRIPT`, `HAS_SCRIPT_LOADED`, `START_NEW_SCRIPT` with the script's stack size, `SET_SCRIPT_AS_NO_LONGER_NEEDED` | A stopped script loses its state. Restart it with the stack size the game uses ([script launch graph](/scripting/script-launch-graph.md)), and put back anything you stopped when the mod turns off |
| Spawn queue | Many peds or vehicles without hitches | `REQUEST_MODEL`, `HAS_MODEL_LOADED`, `CREATE_PED` / `CREATE_VEHICLE`, `SET_MODEL_AS_NO_LONGER_NEEDED` | One spawn per frame or slower; cap the queue. Matters most on low-end PCs |
| Dispatch control | Choose which police and emergency units the game sends | `ENABLE_DISPATCH_SERVICE` (290 Rockstar scripts), `SET_DISPATCH_*`, `SET_MAX_WANTED_LEVEL` | Easy; but several mods writing the same services fight each other, and the last write each frame wins |
| C++ helper for C# | Memory patterns, engine functions and hooks that SHVDN can't reach | A ScriptHookV `.asi` exporting C functions; `[DllImport]` in C# | Fast; the native side must be rebuilt or re-patterned after updates |
| Memory patterns | Engine data with no native (pool limits, wanted internals, dispatch tables) | Byte-pattern search (`Game.FindPattern` in SHVDN), then read or write at an offset | Breaks when a patch moves code. Check that every pattern was found and log any that wasn't, so a broken pattern disables one feature instead of crashing the game |
| Per-script native hook | Change what Rockstar's scripts spawn or give (models, weapons, outfits) without editing them | Hook the native's handler (an EasyHook-style local hook on the address ScriptHookV resolves), look up the calling script's name hash, and only replace the result for scripts on a list | Powerful but fragile: wrong handlers crash the game, and patches move them. Use it only for a handful of natives, with the list in data |
| Shared helper library | Several mods by one author share money, mission screens, controls and saving | A `.dll` the mods reference, kept in step with them | Mods built against one helper version can break with another; ship the version they need |
| Per-unit state machines | Police helicopters, boats and ground units that act differently | One controller class per unit type, each a small finite-state machine run from a tick | Scales well; keep each tick light |
| Data-driven tuning | Players tune escalation, spawn lists and swaps without rebuilding | XML (`XmlSerializer` in .NET) or ini (`ScriptSettings` in SHVDN) | Validate on load and fall back to defaults |
| Trainer formats | Saving spawned scenes and outfits | Menyoo's spooner XML (entities with position, rotation and attachments) and outfit XML (component and prop lists for `SET_PED_COMPONENT_VARIATION` and `SET_PED_PROP_INDEX`) | Read and write the same format to share content with Menyoo users |

## Where mods most often collide

These are the systems where two mods reach for the same thing most often. They are the first place to look when two mods break each other.

| System | Why it collides | What to do |
| --- | --- | --- |
| Wanted level and dispatch | Police overhauls, chase mods and ambient-crime mods all set the level and the services, often every frame | Read before you write. Change the level only on an event, never every frame |
| The phone | Contact libraries restart `cellphone_controller` and `appcontacts`, other mods disable the phone button under menus, and phone-based mods add contacts | Don't stop phone scripts yourself; use a contact library and check `IS_PHONE_ONSCREEN` before opening menus |
| Restricted areas | Several mods stop `restrictedareas` or the army-base and prison event scripts so the player can get in | Only stop them while your mod needs to, and start them again afterwards |
| Story missions | Ambient spawners ignore the mission flag; mods with their own "mission passed" screen clear the flag with `SET_MISSION_FLAG(false)` | Guard with `GET_MISSION_FLAG`. Only clear the flag if your own mod set it |
| Controls from 257 up | A control enum written before build 3717 points at the wrong control above 256 (old 257, the second attack button, is now a creator control) | Use the numbers from [controls and camera](/docs/gameplay/player/controls-and-camera.md#the-numbering-changed-in-build-3717-second-pass), or test what your enum sends (test card 2) |
| Interiors and the island | Casino, heist and Online-style mods load and remove the same IPLs and entity sets | Load only what you use and remove only what you loaded |

## What this means for modders

- Add a mission-flag guard and a script-running check to any ambient mod before release. They cost almost nothing, and they prevent most bug reports that start with "during the mission...".
- Restart a Rockstar script only with the stack size the game uses, and always put back what you stopped.
- Keep engine-level work (patterns, hooks) in one place, log which patterns were found at startup, and turn the feature off cleanly when one isn't. That makes the mod survive game updates in a reduced form instead of crashing.
- Prefer data files to hard-coded lists for anything players may want to tune.
- **Single player only.** Never run script mods in GTA Online.

## Open questions

| Question | Where it goes |
| --- | --- |
| Does ScriptHookVDotNet 3.7's `GTA.Control` enum translate values from 257 up to the build-3717 numbers, or pass them through? (MOD-001) | Test card 2 |
| How much a per-script native hook costs per call on a low-end PC (MOD-002) | [Measuring](/docs/performance/README.md) and test card 3 |
| Which Rockstar scripts break when restarted mid-session, beyond the phone scripts (MOD-003) | Second pass with the [script launch graph](/scripting/script-launch-graph.md) |

## Test cards

1. **Mission guard.** Start any story mission and print `GET_MISSION_FLAG` once a second from a test script. Expected: true from the mission's start until its pass or fail screen ends, then false.
2. **Control numbers.** On foot with a melee-capable weapon, log `Game.IsControlJustPressed(GTA.Control.MeleeAttack1)` (263 in the old enum) and `Game.IsControlJustPressed((GTA.Control)300)` every frame, and press the light melee key (`R` by default). Expected if the enum passes the old numbers through: only 300 logs true, because 263 is now `INPUT_CREATOR_MENU_DELETE`. If the enum value logs true, SHVDN translates the old numbers. This is the same check as test card 4 in [controls and camera](/docs/gameplay/player/controls-and-camera.md).
3. **Hook cost.** With a mod that hooks `CREATE_PED` for a list of scripts, play the same mission with the mod on and off and compare frame times in the spawn-heavy part. Expected: no visible difference if the per-call filter is cheap.
