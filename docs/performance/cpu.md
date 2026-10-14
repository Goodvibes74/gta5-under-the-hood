# CPU: population, AI, physics and scripts

What loads GTA V's CPU: the game's threads and which one is the bottleneck, population and AI, physics, and scripts (Rockstar's and every mod's); how density settings and spawn caps help; what a 4-core 15 W laptop chip can carry. Roadmap topic **R18.4** in the [roadmap](/ROADMAP.md). Builds on the [script VM](/scripting/script-vm.md) (script threads), [physics cost](/docs/performance/physics-cost.md) and [graphics settings](/docs/performance/graphics-settings.md); R17.9 (AI cost) will add detail.

**How it was made.** The `Threads` sections of the vanilla and a modded `gameconfig.xml` (extracted with [`tools/rpf-cw.ps1`](/tools/README.md)). The script load of a heavily modded low-end test PC from `ScriptHookV.log`, `ScriptHookVDotNet.log` and a monitoring script's log. Its CPU and throttling from Windows (`Win32_Processor`, System log, `Kernel-Processor-Power` event 37, 14 days). Density natives counted with [`tools/native-usage.ps1`](/scripting/native-usage.md). Which work runs on which game thread is **Known** (engine knowledge); thread names, priorities and counts are **Verified**.

## 4.1 Short version

- **One thread does most of the work.** The PC section of `gameconfig.xml` names 24 game threads with priorities but pins none to a core (Windows schedules them). `Update` is `PRIO_TIME_CRITICAL`: it runs the game simulation, AI decisions and **every script**, Rockstar's and all mods' (**Known**: ScriptHookV, SHVDN and the Lua plugin all run their scripts inside the game's script processing). `Render` is `PRIO_ABOVE_NORMAL`; the streamers, path server and replay threads are low.
- **So GTA V is limited by one core's speed** more than by core count (**Known**). A 15 W chip that throttles loses frame rate in step with its clock.
- **The test laptop throttled constantly:** 32 "processor speed limited by firmware" events in the last 14 days (1 to 8 a day), on a 15 W laptop chip with 4 cores, 8 threads and a 1.9 GHz base clock.
- **Script load on the test install, every frame:** 52 Rockstar script threads, 4 ASI script plugins (the Lua plugin, two trainers, ScriptHookVDotNet) and **61 .NET scripts**, 51 of them classes of one large Online-style mod, each with its own `Tick`. All of them take turns on the `Update` thread.
- **Population is the biggest lever the player has:** `CityDensity` (peds and traffic), `PedVarietyMultiplier` and `VehicleVarietyMultiplier`. Every ambient ped and car runs AI, pathfinding and physics. The test PC already had density at 0.
- **Rockstar thins the crowd during missions** with per-frame density multipliers: vehicles 549 calls, peds 321, scenario peds 172, random vehicles 164, parked vehicles 137.
- **For mods:** spread work over frames, keep `Tick` handlers empty when idle, cap spawns, and merge many tiny scripts into a few (each SHVDN script costs a context switch every frame).

## 4.2 The game's threads (PC)

From the `x64` section of `gameconfig.xml` (identical in the vanilla and modded files):

| Thread | Priority | Does (**Known**) |
| --- | --- | --- |
| `Update` | TIME_CRITICAL | Main game loop: simulation, AI, scripts, population |
| `RageAudioMixThread` | TIME_CRITICAL | Audio mixing |
| `RageDvdReader`, `RageHddReader` | TIME_CRITICAL | Reading archives from disk |
| `ControlMgrUpdateThread` | HIGHEST | Input |
| `AsyncShapeTestMgr` | HIGHEST | Shape tests (ray and shape casts) off the main thread |
| `RmptfxUpdateThread` | HIGHEST | Particle effects |
| `Render` | ABOVE_NORMAL | Building the frame for the GPU |
| `RecordingThread*` (Default, GameAndObject, Ped, Vehicle) | ABOVE_NORMAL | Replay (Rockstar Editor) recording |
| `RageAudioEngineThread`, `NorthAudioUpdate`, `SaveBlockDataThread` | NORMAL | Audio engine, saving |
| `RageDvdStreamer`, `ReplayQuantizeThread`, `RageNetSend`, `RageNetRecv`, `RageVoiceChatWorker` | BELOW_NORMAL | Streaming scheduling, replay, network |
| `PathServer`, `ResourcePlacementThread`, `RageHddStreamer`, `ReplayFileManager` | LOWEST | Path-finding requests, placing streamed resources, disk streaming, replay files |

The Xbox One and PS4 sections pin about 32 threads to 6 cores each (`Update` alone on core 0); the PC section leaves placement to Windows. `-disableHyperthreading` (command line, **Known**) keeps game tasks off hyperthreaded logical cores; worth a test on a 4-core, 8-thread laptop ([graphics settings](/docs/performance/graphics-settings.md#24-commandlinetxt)).

Notice that path-finding (`PathServer`) and streaming (`RageHddStreamer`) run at the lowest priority: when the CPU is saturated they fall behind first, which shows as peds that stand still before walking and as pop-in (**Known** consequence).

## 4.3 What loads the `Update` thread

| Load | Grows with | How to cut it |
| --- | --- | --- |
| Ambient population (peds, cars) | `CityDensity`, variety multipliers, scenario points | Lower density; mission scripts use the `*_DENSITY_MULTIPLIER_THIS_FRAME` natives |
| AI (tasks, perception, events, driving) | Peds with active tasks, combat, chases | Fewer combatants; `SET_PED_KEEP_TASK`, blocking non-temporary events only where needed; R17.9 |
| Physics | Active ragdolls, crashes, explosions | [Physics cost](/docs/performance/physics-cost.md) budgets |
| Rockstar scripts | Story controllers, launchers, missions; 52 threads after loading on the test PC | Can't be cut safely in story mode; a fake-Online mod should switch brain sets rather than kill scripts ([story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)) |
| Mod scripts | Number of scripts, work per `Tick` | Spread work over frames; idle when inactive; fewer, larger scripts |
| Streaming bookkeeping | Fast travel, many add-on packs | Lower `LodScale` and density ([streaming](/docs/core/streaming.md)) |

## 4.4 A heavily modded install's script load

| Layer | Count | Notes |
| --- | ---: | --- |
| Rockstar script threads after loading | 52 (12 more ended in the first 10 minutes) | A monitoring script listing running threads |
| ASI plugins that register scripts with ScriptHookV | 4 | The Lua plugin, two trainers, ScriptHookVDotNet |
| .NET scripts (SHVDN v2 and v3) | 61 | 51 classes of one large Online-style mod, plus about ten small mods and libraries |
| Slow starts | three mods took 1 to 2 s to start | From `ScriptHookVDotNet.log` times |

Each SHVDN script is its own cooperative script: SHVDN switches to it once per frame to run its `Tick` (or skips it until its `Interval` is due). 51 scripts from one mod mean 51 switches every frame even when nothing in them has work to do (**Known** mechanism; the per-switch cost on this PC is open, 4.7).

## 4.5 The test laptop's CPU

| | |
| --- | --- |
| CPU | A 15 W laptop chip, 4 cores, 8 threads, 1.9 GHz base (Windows `MaxClockSpeed` 1,896 MHz) |
| Throttling | 32 `Kernel-Processor-Power` event 37 ("speed limited by firmware") in 14 days: up to 8 a day, 1 to 3 on most days |
| What helps (**Known**) | Plugged in, high-performance power plan, a cooling pad, half-rate VSync (less work per second, less heat), lower density |

## 4.6 What this means for modders

- **Your `Tick` shares the game's main thread** with the whole simulation. Anything slow in it is a slow frame.
- **Idle cheaply:** when a feature is off, return at the top of `Tick`, or raise `Interval`. Rockstar's pattern is `GET_FRAME_COUNT() % N` ([measuring performance](/docs/performance/measuring.md#frame-timing-from-a-script)).
- **Fewer scripts:** one script with a list of features costs one switch per frame; ten scripts cost ten.
- **Cap AI:** each combatant runs perception, tasks and path requests; keep groups small and delete the dead and far away.
- **Turn density down during your set pieces** with the per-frame multipliers, like Rockstar's missions do.

## 4.7 Open questions

| Question | Where it goes |
| --- | --- |
| What one idle SHVDN script costs per frame on a low-end PC (and so what 51 cost) | Test card 1, R18.5 |
| Whether `-disableHyperthreading` helps on a 4-core, 8-thread laptop | Test card 2 |
| AI cost per ped type (ambient, combat, driving) | R17.9 |
| How much of the frame the 52 Rockstar threads take | Needs a profiler (Windows Performance Recorder); second pass |

## 4.8 Test cards

1. **Idle script cost:** with a frame-time log on, stand at a quiet spot for 2 minutes with a large multi-script mod loaded but idle, then with it removed. Compare average FPS and worst frame.
2. **Hyperthreading switch:** create `commandline.txt` in the game folder with `-disableHyperthreading`, play the same 2 minutes, compare; delete the file afterwards.
3. **Throttling:** play 20 minutes; at the end, check Event Viewer (System, source Kernel-Processor-Power, ID 37) for new events and compare the FPS of the first and last minutes.
