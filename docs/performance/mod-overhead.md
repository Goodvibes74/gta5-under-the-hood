# Mod overhead: what each kind of mod costs

What each kind of mod costs in load time, memory and frame time (ASI plugins, script hosts, SHVDN scripts, Lua, add-on packs, replaced archives, map and visual mods), how to find the heavy one, and how to write mods that cost nothing when idle. Roadmap topic **R18.5** in the [roadmap](/ROADMAP.md). Builds on [measuring](/docs/performance/measuring.md), [graphics settings](/docs/performance/graphics-settings.md), [memory](/docs/performance/memory-and-vram.md), [CPU](/docs/performance/cpu.md) and the script-brain pattern in [runtime scripts](/docs/core/runtime-scripts.md).

**How it was made.** On a heavily modded low-end test PC: `asiloader.log`, `ScriptHookV.log`, `ScriptHookVDotNet.log` and a monitoring script's startup timeline from two launches; the install's mod inventory; script-brain counts from [runtime scripts](/docs/core/runtime-scripts.md). What each mod type costs per frame is **Known** (how the loaders work) until the profile comparisons in the test cards are run; the counts and times are **Verified**.

## 5.1 Short version

- **Mods cost in three places:** load time (once), memory (all session) and frame time (every frame). Most mods cost in only one or two.
- **Memory patches cost nothing per frame.** HeapAdjuster, PackfileLimitAdjuster, WeaponLimitsAdjuster, the decals patch and PoolManager change limits at start and then sit idle; they cost reserved memory ([memory](/docs/performance/memory-and-vram.md)).
- **Script plugins cost every frame,** in proportion to how much they do in their loop. ScriptHookV registered 4 on the test PC: the Lua plugin, Menyoo, TrainerV and ScriptHookVDotNet; the RDE plugins (combat tweaks, laser sights) hook the game directly.
- **SHVDN scripts cost a switch per script per frame** plus their own work. 61 .NET scripts loaded in 6 seconds on the test PC, three of them slowly (1 to 2 s each).
- **Add-on packs and replaced archives cost load time and memory,** not frame time: every pack mounts archives and registers models; a replaced `update.rpf` copy is read instead of the original. 12 add-on packs and 4 replaced archives on the test PC.
- **The loading screen took 72 to 85 s on the test laptop** before the first .NET script starts (exe start to SHVDN's first script), and the game is playable 8 s later: 80 to 94 s in total.
- **The cheapest mod is one that waits:** Rockstar's own world scripts (146 script brains) don't run at all until the player is near their spot; a mod should do the same, with an empty `Tick` until its trigger.

## 5.2 Cost by kind of mod

| Kind | Examples on the test PC | Load time | Memory | Frame time (**Known**) |
| --- | --- | --- | --- | --- |
| ASI memory patch | HeapAdjuster, PackfileLimitAdjuster, WeaponLimitsAdjuster, DecalsLimit patch, PoolManager | Tiny | Reserves what it raises | None |
| ASI that hooks the game | `combat_tweaks.asi`, `LaserSights.asi` (RDE, EasyHook), `NoEditorRestrictions.asi`, `openCameraV.asi`, `OpenIV.asi` | Small | Small | Small, inside the hooked function; OpenIV.asi only on file reads |
| Script host | ScriptHookV, ScriptHookVDotNet (.NET runtime), `LUA.asi` | SHVDN: the .NET runtime and every script assembly | .NET heap for all scripts | The host's own switching |
| Trainer (native plugin) | Menyoo, TrainerV | Menyoo loads its data folder | Small | Small when closed; drawing menus when open |
| SHVDN script | 61 (51 from one large mod) | Assembly load and constructor | Its objects, lists, LemonUI menus | A switch per frame plus its `Tick` work |
| Lua script | `scripts/main.lua` and addins | `main.lua` loads libs and addins | Small | One `tick()` per frame for all addins |
| Add-on DLC pack | 12 (cars, maps, RDE, zombimod, vremastered) | Mounting, `setup2.xml`, `content.xml` | Model and texture slots; streamed when near | None by itself; more streaming |
| Replaced archive in `Mods\` | `common.rpf`, `x64a.rpf`, `update.rpf`, `update2.rpf` | Read instead of the original | Whatever the changed files need | None by itself |
| Map mod | `forest_n`, `forest_s`, `vremastered` | More map data to register | More to stream | Denser scenes to draw |
| Visual mod | `vremastered` timecycles and effects; ReShade/ENB (not installed) | Small | Small | Post-processing costs GPU every frame |

## 5.3 A heavily modded startup, step by step

One launch on the test PC, 28 mod files on:

| Step | Since exe start |
| --- | ---: |
| `GTA5.exe` started (93.6 s before playable) | 0 s |
| ScriptHookV started, version check passed | 8 s |
| 14 ASI plugins loaded by the ASI loader; archives mounted; story save loaded | |
| `main()` of `LUA.asi` and `Menyoo.asi` launched (the loading screen is ending) | 77 s |
| SHVDN started | 78 s |
| SHVDN loaded 61 scripts (6 s) | 80 to 86 s |
| `main()` of `TrainerV.asi` launched | 87 s |
| Playable | 94 s |

Another launch took 72.5 s to the first .NET script and 80.2 s to playable. Most of the loading time is the game's own (archives, map, save); mods add the SHVDN step (6 s here) and the extra archives they mount.

## 5.4 Finding the heavy mod

1. **Measure a baseline** with the [measuring](/docs/performance/measuring.md) routine (same spot, 2 minutes standing, 2 minutes driving).
2. **Switch a group off** by renaming its files (`.asi`, `.dll` to `.disabled`), or with a script that switches whole mod sets, and measure again.
3. **Halve the remaining suspects** until one is left (the same method as in [debugging](/modding/08-debugging.md#finding-which-mod-breaks-things)).
4. **For SHVDN scripts,** `AutoLoadScripts=false` in `ScriptHookVDotNet.ini` and `Start("Name.dll")` in the F4 console load them one at a time.
5. **Check the mod's own log** at the hitch times, if it writes one.

## 5.5 Writing mods that cost nothing when idle

| Pattern | How | Rockstar's version |
| --- | --- | --- |
| Trigger, then run | `Tick` returns at once until a key, a place or a time; then the feature runs | 146 script brains: world-point brains (99) start a script only when the player is near a point, object brains (47) when a model is near ([runtime scripts](/docs/core/runtime-scripts.md)) |
| Check every N frames | `if (Game.FrameCount % 60 != 0) return;` or `Interval = 1000` | `GET_FRAME_COUNT() % 60`, 5,030 times in the decompile |
| One script, many features | One `Tick` dispatches to whichever feature is active | Launchers start mission scripts only when needed |
| Release when done | Delete entities, release models and dictionaries, clear focus | Every mission's cleanup routine |
| Log on events, not frames | Write a line when something changes | |
| Start late | Do heavy setup when the feature is first used, not in the constructor | Scripts request assets a stage ahead |

**A finding from the test install:** one large mod registered 51 classes with their own `Tick`, so 51 SHVDN script switches happen every frame even while the mod is idle. Moving idle features behind one dispatcher, or raising `Interval` on features that only poll for a key or a place, is the cheapest frame-time win in a mod like that (test card 1 measures it first).

## 5.6 Open questions

| Question | Where it goes |
| --- | --- |
| Frame time per mod set at the same spot | Test card 1 |
| Load time added by the add-on packs (with `Mods\` off vs on) | Test card 2 |
| The per-frame cost of one idle SHVDN script | Test card 1 ([CPU](/docs/performance/cpu.md) open question) |

## 5.7 Test cards

1. **Mod sets:** with a frame-time log on, start with each mod set in turn (none, small, full), stand for 2 minutes at the same spot, then drive the same 2-minute route. Keep each log. Compare average FPS, worst frame, hitches and peak memory.
2. **Load time:** compare exe start to playable between no mods and the full set, two launches each.
