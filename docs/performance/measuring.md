# Measuring performance

How to measure GTA V's performance before changing anything: frame rate and frame time, hitches and freezes, CPU-bound vs GPU-bound, the game's own benchmark, frame timing from a script, and Windows tools. Roadmap topic **R18.1** in the [roadmap](/ROADMAP.md). Every other performance topic measures with what this page sets up.

**How it was made.** The game's benchmark script (`benchmark`, 102,659 decompiled lines) and the scripts that call the frame-timing natives were read in the build-3725 decompile (commit `6c18d3e8b`), with native use counted by [`tools/native-usage.ps1`](/tools/README.md) ([native usage](/scripting/native-usage.md)). The example measurements come from a small SHVDN monitoring script on a low-end test PC (a 15 W quad-core laptop with integrated graphics and 16 GB shared memory, half-rate VSync). Benchmark command-line switches, the results folder and the Windows tools are community or vendor knowledge (**Known**); what the benchmark script does is **Verified**.

## Short version

- **Measure frame time, not only frame rate.** 20 FPS on average can hide an 8-second freeze. Track the average, the worst frame, and every frame over a threshold (a hitch; 250 ms is a useful line, 2 s is a freeze).
- **A hitch behind a black screen is a load, not stutter.** On the test PC the two biggest "freezes" (8.6 s and 6.9 s) both happened while the screen was faded out and a loading screen was up, while a script mod switched the map to its Online state. The hitches felt in play were shorter ones with the screen on (1.4 s when an animation dictionary took 3.4 s to stream in).
- **Take frame caps off before measuring headroom.** Under a 30 FPS VSync cap, "highest 30 FPS" is the cap, not the limit.
- **CPU-bound or GPU-bound:** lower the resolution (or frame scaling) and nothing else. If the frame rate rises, the GPU was the limit; if it stays, the CPU (or scripts) was (**Known**).
- **The game has a real benchmark.** The `benchmark` script runs up to 5 passes at 5 fixed places with set peds and vehicles, started from the graphics menu, the landing screen or the command line (**Verified**). It reads an iteration count (at least 1) and a pass number (-1 for all, 0 to 4 for one) from the engine. Results go to `Documents\Rockstar Games\GTA V\Benchmarks\` (**Known**).
- **Scripts time frames with two natives:** `GET_FRAME_TIME` (466 scripts) and `GET_FRAME_COUNT` (510). A mod that wants to catch stalls of the whole game should time real ticks with a stopwatch instead, because `GET_FRAME_TIME` is the game's own (capped) frame delta.

## What to measure

| Measure | Why | Where it comes from |
| --- | --- | --- |
| Average FPS | Overall load | A monitoring script, overlays, the benchmark |
| Frame time (ms), worst frame | Stutter and freezes average away; 33 ms = 30 FPS, 50 ms = 20 FPS | A monitoring script, PresentMon |
| Hitch count and size | How often play breaks | Frames over a threshold |
| What happened at the hitch | Separates loads from stutter | Event lines next to the numbers: fades, loading screens, vehicles, interiors, other mods' logs at the same second |
| Memory: working set and private | Shared-memory laptops run out of RAM before anything else | Task Manager, `Process.WorkingSet64` / `PrivateMemorySize64` from a script |
| Entity counts | Population and mod spawns load the CPU | `World.GetAllPeds()` and friends, every 30 s (not every frame) |
| Load time | Time to playable | Exe start to "player control on, screen faded in, no loading screen" |
| CPU and GPU use, clocks, temperature | Throttling on laptops | Task Manager, HWiNFO, Windows' "processor speed limited by firmware" events |

## The game's benchmark

The benchmark is an ordinary game script, `benchmark`, started by the engine from three places (**Verified** from the natives it checks):

| Start | Native that says so | What the script does first |
| --- | --- | --- |
| Graphics settings menu ("Run benchmark test") | `UI_STARTED_END_USER_BENCHMARK` | Waits until the pause menu is closed |
| The landing screen | `LANDING_SCREEN_STARTED_END_USER_BENCHMARK` | Runs at once (also checked by `startup`, `startup_positioning` and `standard_global_reg`) |
| The command line | `IS_COMMANDLINE_END_USER_BENCHMARK` | Runs at once (also checked by `startup` and `startup_positioning`) |

Started any other way it shows a warning (`FBR_BENCHMARK`) and quits when you accept. It loads the `BMARK` text block, then reads two values the engine got from the command line or menu:

- `GET_BENCHMARK_ITERATIONS`: how many times to run, raised to 1 if lower.
- `GET_BENCHMARK_PASS`: which pass, -1 (all) or 0 to 4; anything else becomes -1.

It holds five scenes, each with a player position, a camera position and rotation, and a second camera: around (-10, -1474) in south Los Santos, (806, 1101, 306) in the Vinewood hills, (2006, 3804) in Sandy Shores, (-1713, -1077) at the Del Perro pier, and (-664, 4484) in the forest near Mount Chiliad (**Verified** coordinates; place names **Known**). It spawns fixed models (Armenian gang peds `g_m_m_armboss_01`, `g_m_m_armgoon_01`, `g_m_m_armlieut_01`, a `phantom` truck and a `boxville` van with workers) so every run has the same load. Recording is bracketed by `START_END_USER_BENCHMARK` and `STOP_END_USER_BENCHMARK`, then `SAVE_END_USER_BENCHMARK` writes the results and `RESET_END_USER_BENCHMARK` clears them (**Verified**). The main loop is an 8-state switch: the five passes and the stages around them.

**Known** (community, not checked here): the command-line switches are `-benchmark`, `-benchmarkIterations <n>` and `-benchmarkPass <n>` (in `commandline.txt` in the game folder or the launcher's arguments), and each run writes `Benchmark-<date>.txt` with per-pass minimum, maximum and average FPS and frame-time percentiles.

**For mods:** the benchmark runs with every ASI and script mod loaded. Two benchmark runs, one with a mod set and one without, are the cleanest way to price a mod set, because the scenes and spawns are identical every time.

## Frame timing from a script

| Native or API | Scripts using it (build 3725) | What it gives |
| --- | ---: | --- |
| `MISC::GET_FRAME_TIME` | 466 | Seconds the last game frame took (the game's own delta, after any cap) |
| `MISC::GET_FRAME_COUNT` | 510 | Frames since start; scripts use it to do work every Nth frame |
| `MISC::GET_GAME_TIMER` | 912 | Milliseconds since start, for timeouts |
| SHVDN `Game.LastFrameTime`, `Game.FPS` | | The same game delta in C# |
| A `Stopwatch` between two ticks | | Real time, including stalls of the whole game and of other mods |

A monitoring script should use the stopwatch: the real time between its own ticks catches a stall anywhere (streaming, another mod, Windows), while `GET_FRAME_TIME` only reports the game's frame. Log a sample every few seconds (average FPS, worst frame, hitches, memory, position), entity counts every 30 s, and an event line per hitch, fade, loading screen, vehicle and interior change, so each hitch can be matched to what was happening. Write to the log only on samples and events, never every frame.

Rockstar's scripts use `GET_FRAME_COUNT` mainly to spread work over frames: `GET_FRAME_COUNT() % 60` appears 5,030 times in the decompile, `% 10` 788 times, `% 5` 531, `% 120` 330, `% 2` 294 and `% 30` 84 (**Verified**, `git grep -o` count). "Once a second at 60 FPS" is the house pattern, and also the cheapest pattern for mods ([script VM](/scripting/script-vm.md) on script cost).

## Reading a session: an example from a low-end test PC

Two 10-minute sessions with about 15 script mods and an Online-style mod, half-rate VSync:

| | Session 1 | Session 2 |
| --- | ---: | ---: |
| Playable after exe start | 80.2 s | 93.6 s |
| Average FPS | 18 | 17 |
| Lowest / highest sample | 5 / 30 | 1 / 30 |
| Worst frame | 6,865 ms | 8,636 ms |
| Hitches over 250 ms | 4 | 6 |
| Peak memory (working set / private) | 6,388 / 9,165 MB | 5,929 / 9,134 MB |
| Peak entities (peds / vehicles / props) | 34 / 95 / 599 | 33 / 82 / 574 |

What the event lines showed:

1. **The first freeze (4 to 5 s) is the end of loading,** a second before the player can move.
2. **The worst freeze is a mod switching the map to its Online state** (the `ON_ENTER_MP` native family): the screen fades out, control goes off, and 9 s later the 8.6 s frame is logged together with a loading screen. The game swaps the map data in one blocking step. It looks like a freeze in the numbers but is a load behind a black screen.
3. **The real in-play hitch is streaming:** a 1.4 s frame lines up with a mod requesting an animation dictionary that took 3.4 s to load, in the middle of play.
4. **Memory never falls back:** private memory climbs from 7.4 GB to 8.8 GB in the first two minutes and stays there.

So the rule for reading a hitch: find its second in every log and ask whether the screen was on.

## Windows tools

| Tool | What it shows | Get it |
| --- | --- | --- |
| Task Manager, Performance tab | CPU, GPU (3D and "shared" video memory), RAM, disk, per-process memory | Built in |
| PresentMon (Intel) | Every frame's time, from the driver's side; CSV for comparing runs | https://github.com/GameTechDev/PresentMon |
| Event Viewer, Windows Logs > Application and System | Game crashes (Application Error naming the faulting module), driver resets (event 4101), unexpected shutdowns (Kernel-Power 41), "processor speed limited by firmware" | Built in |
| Reliability Monitor (`perfmon /rel`) | The same crashes on a timeline | Built in |
| Windows Performance Recorder / Analyzer | Where CPU time goes, per thread and module | Windows SDK (**Known**) |
| HWiNFO | Clocks, temperatures, throttling flags | https://www.hwinfo.com |

## A measuring routine

1. **Same place, same time, same weather.** Use the benchmark, or a fixed spot (teleport with a trainer, set time and weather) and stand still for 60 s, then drive the same route for 60 s.
2. **One change per run.** A setting, a mod, a mod set.
3. **Remove caps** while measuring headroom (VSync off), put them back for play.
4. **Record** the numbers and the settings and mods used.
5. **Separate loads from play:** ignore hitches behind fades and loading screens unless load time is what you're measuring.
6. **Check heat** on a laptop: a run after 20 minutes of play is slower than a cold one when the CPU throttles.

## What this means for modders

- **Log real time, not game time,** in any monitoring mod, and log events next to the numbers. A hitch without context can't be fixed.
- **Request assets before they're needed.** A 3.4-second animation load mid-play is the pattern to avoid: load dictionaries during a fade or at mission start, and keep them while they're used.
- **Spread work over frames** with a frame counter or a timer; never scan the world every frame.
- **Price a mod with the benchmark:** two runs, with and without, same settings.

## Open questions

| Question | Where it goes |
| --- | --- |
| Confirm the benchmark switches and results file, and record a baseline with and without mods | Test card below, R18.5 |
| What happens in each of the 8 states of the benchmark loop, and how long each pass lasts | Second pass of this topic |
| Why `ON_ENTER_MP` blocks for about 9 s: which map data it swaps | R1.5 streaming, R18.8 load times |

## Test cards

1. **Benchmark:** Settings > Graphics > Run benchmark test (or add `-benchmark` to `commandline.txt` in the game folder). Let all passes run. You should get a `Benchmark-*.txt` in `Documents\Rockstar Games\GTA V\Benchmarks\`. Run once with your mods and once without, VSync off both times, and compare the files.
2. **CPU or GPU:** stand at the same spot, note the FPS, drop the resolution two steps, note the FPS again. If it barely moves, the CPU is the limit.
