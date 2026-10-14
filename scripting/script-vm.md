# The script VM: how GTA V runs its scripts, and how mods run beside them

How Rockstar's compiled scripts are stored and run: the file format, threads and stacks, waiting, priorities, events, force cleanup, and how ScriptHookV, ScriptHookVDotNet (SHVDN) and Lua mods run next to them. Roadmap topic **R1.1** in the [roadmap](/ROADMAP.md). It builds on [guide 1](/docs/core/runtime-scripts.md) (which scripts run, stack pools, global blocks) and [online guide 5](/docs/00-getting-started/research-tools.md) (the header layout and the script reader).

**How it was made.** **Verified** facts come from the build-3725 decompile (1,145 sources), the headers of the 1,143 compiled scripts dumped with `tools/ysc-dump.ps1`, `common\data\gameconfig.xml`, the test install's `ScriptHookV.log`, `ScriptHookVDotNet.log` and `ScriptHookVDotNet.ini`, and the generated SHVDN runtime reference. **Known** marks community knowledge not checked here. Counts of calls are counts in the decompiled source, so a call inside shared header code counts once per script that includes it.

## 2.1 Short version

- **A script is a compiled program for a stack-based virtual machine** (`.ysc`, inside `script_rel.rpf`). It has code, statics (its own variables), optionally a global block, a table of the natives it calls and a table of text strings. This build has 1,143 of them with 851 MB of uncompressed bytecode; `freemode` alone is 7.9 MB (**Verified**).
- **Each running script is a thread** with its own stack, taken from the fixed pools in `gameconfig.xml` (guide 1, section 1.4). Threads are **cooperative**: a script runs until it calls `WAIT`, then the next one runs. `WAIT(0)` means "carry on next frame" and is by far the most common call: 6,810 times in 995 scripts, against about 300 waits of a set time (**Verified** counts; the cooperative model is **Known**).
- **Force cleanup is a broadcast "stop what you're doing".** A script raises a bit with `FORCE_CLEANUP`, and every script that registered for that bit with `HAS_FORCE_CLEANUP_OCCURRED` jumps to its cleanup code. 508 scripts listen. The bits seen here: 1 (kill ambient and side scripts), 2 (story to Online), 8 (a mission or activity starts), 64 (reset the world), 128 (director mode ready), and 4, 16 and 32, which only the engine raises (**Verified**; table in 2.6).
- **Mods run beside the VM, not inside it.** ScriptHookV registers each `.asi` script, waits until the game's own scripts run, and then calls each mod's `main()` on the game's script update. SHVDN runs every .NET script on its own thread and hands native calls to the game thread. A mod that takes long inside its tick delays the whole frame, which is why one slow mod freezes the game (**Verified** from the logs and the SHVDN API; the fiber mechanism is **Known**).

## 2.2 The compiled script

The header layout is in [online guide 5, section 5.2](/docs/00-getting-started/research-tools.md#52-how-the-script-reader-works). What the 1,143 headers add up to (**Verified**, `ysc-dump` summary):

| Measure | Value |
| --- | --- |
| Scripts | 1,143 |
| Bytecode, all scripts (uncompressed) | 851 MB |
| Largest by code | `freemode` 7.9 MB, `fm_mission_controller_2020` 6.7 MB, `fm_mission_controller` 6.4 MB, `public_mission_controller` 6.3 MB, `fm_race_creator` 5.5 MB, `fmmc_launcher` 4.6 MB, `am_mp_property_int` 4.5 MB |
| Most statics | `fm_mission_controller_2020`, 82,387 |
| Most natives | `fm_mission_controller_2020`, 3,166 distinct natives |
| Native table entries, all scripts | 641,762 |
| Text strings, all scripts | 3.4 MB |
| Scripts with fewer than 10 bytes of code | 93 (debug and test scripts compiled out; the catalog counts 86 with an entry function and nothing else) |
| Scripts that declare a global block | 18 (guide 1, section 1.5) |

Size by order of magnitude: 277 scripts have 1 to 10 MB of code, 345 have 100 KB to 1 MB, 267 have 10 to 100 KB, and the rest are smaller.

**What is in a script.** Code is split into pages; statics are the script's own variables, created fresh for each thread that runs it; the native table lists hashes of the engine functions it calls (rotated per entry in the PC build, see online guide 5); the string table holds every text constant: script names, model names, animation dictionaries, text labels, audio names. **Verified** from the reader.

**Parameters.** A script can be started with arguments (`START_NEW_SCRIPT_WITH_ARGS`, `..._WITH_NAME_HASH_AND_ARGS`). The arguments are copied into the start of its statics: story stranger launchers pass 61 values to the mission they start, and the base-jump launchers 170 (**Verified**, guide 1's launch graph).

## 2.3 Threads, stacks and limits

- **Starting.** `REQUEST_SCRIPT` streams the compiled script in; `HAS_SCRIPT_LOADED` says when it's ready; `START_NEW_SCRIPT(name, stackSize)` creates a thread and returns its id; `SET_SCRIPT_AS_NO_LONGER_NEEDED` lets the streamed copy go. Every launcher in the decompile follows this request, wait, start, release pattern (**Verified**).
- **Stacks.** The stack size must match one of the 32 pool sizes in `gameconfig.xml`; there are 223 stacks in all, and several sizes have only one (guide 1, section 1.4). `GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE` tells a script whether a start will succeed (**Verified**).
- **How many threads.** ScriptHookV reports `GtaThread collection size 189` at start-up on the test install (build 3725) (**Verified**, `ScriptHookV.log`). That is the size of the engine's thread table as ScriptHookV sees it, after ScriptHookV extended four pools (`Pool 1 extended` to `Pool 4 extended`). How many Rockstar threads actually run can be measured by listing them from a mod (2.9).
- **Ending.** A script ends by returning from its entry function or with `TERMINATE_THIS_THREAD` (1,492 calls). `TERMINATE_THREAD(id)` ends another thread (8 calls only): Rockstar's scripts rarely kill each other, they ask with force cleanup or flags instead (**Verified**).
- **Script-related pools** in `gameconfig.xml`: `CGameScriptResource` (resources a script owns: 3,084 vanilla, 5,526 in our modded file), `ScriptStore` (1,150 vanilla, 1,200 ours), `atDScriptObjectNode` (1,000 and 1,600), `CScriptEntityExtension` (700 and up to 3,072). The file lists several pools more than once (per platform or build type), which R1.4 sorts out (**Verified** values).

## 2.4 Waiting and frame cost

| Call | Count in the decompile | Meaning |
| --- | --- | --- |
| `WAIT(0)` | 6,810 | Yield; run again next frame |
| `WAIT(1000)` | 82 | About a second |
| `WAIT(500)` | 74 | |
| `WAIT(2000)` | 41 | |
| `WAIT(100)`, `(250)`, `(3000)`, `(10)`, `(750)`, `(1500)`, `(200)`, `(1)` | 34 down to 8 each | |

995 of the 1,145 decompiled scripts call `WAIT` at all; the rest run once and end (**Verified**).

**The pattern Rockstar uses for cost** is the one in `main` (guide 1): a loop with `WAIT(0)`, light checks every frame, and heavier work behind game-timer gates (`main` runs some checks every 1,000 ms and some every 5,000 ms; `main_persistent` has a 60,000 ms gate). **Verified.** The same pattern is the right one for mods (2.8).

**Pausing.** `SET_THIS_SCRIPT_CAN_BE_PAUSED` (466 scripts) decides whether the script stops while the pause menu is open; `maintransition` sets it to false so the transition carries on behind the menu (**Verified**).

**Priority.** `SET_THIS_THREAD_PRIORITY` is used only by `freemode` (0) and `fm_maintain_transition_players` (2). `SET_SCRIPT_HIGH_PRIO` appears in 36 scripts: the 34 random events, `altruist_cult` and `gunclub_shop`, and the random events call it with `false` as they clean up (**Verified**). What the priority values change in the scheduler is **Known** only loosely (order within the frame) and stays open.

## 2.5 Talking between scripts

| Channel | How | Seen |
| --- | --- | --- |
| Globals | Any script reads and writes any global; the owner block script sets the layout | Everywhere (guide 1, section 1.5) |
| Script events | Sent with `_SEND_TU_SCRIPT_EVENT_NEW` (6,982 calls; this build's sender), read with `GET_NUMBER_OF_EVENTS`, `GET_EVENT_AT_INDEX` and `GET_EVENT_DATA` (265 scripts) | Mostly Online: events go to other players' copies of a script, or between local scripts |
| Engine events | The same event queue carries engine events (damage, network errors, invites) | `error_listener` reads them to bail out of a session |
| Thread checks | `GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH`, `IS_THREAD_ACTIVE` | `main`'s watchdog, every launcher |
| Force cleanup | Section 2.6 | 508 scripts |
| Arguments | Copied into the new script's statics at start | Launchers |

**Verified.** Which event queue index means what (the first argument of `GET_EVENT_AT_INDEX`: 0 AI, 1 network, 2 error, and so on) is **Known** and left for R15.1.

## 2.6 Force cleanup

`FORCE_CLEANUP(bits)` raises cleanup bits for every script; `FORCE_CLEANUP_FOR_ALL_THREADS_WITH_THIS_NAME` and `FORCE_CLEANUP_FOR_THREAD_WITH_THIS_ID` aim at one script or thread. A script listens by calling `HAS_FORCE_CLEANUP_OCCURRED(mask)` once at the start; when a matching bit is raised later, execution jumps back to that call, which now returns true, and the script runs its cleanup (**Known** mechanism; the patterns in the decompile match it: the call sits at the top of the entry function, followed by cleanup and `TERMINATE_THIS_THREAD`). `GET_CAUSE_OF_MOST_RECENT_FORCE_CLEANUP` says which bit fired.

| Bit | Raised by (**Verified**) | Listeners (masks that include it) | What it means here |
| --- | --- | --- | --- |
| 1 | `main` (when the Rockstar Editor asks scripts to clean up), `am_prostitute` and `controller_ambientarea` on single threads | 362 | Stop ambient and side scripts. The mission triggerers and `friendactivity` check for it by cause |
| 2 | `maintransition` and `selector` | 495 | Story mode is handing over to Online (guide 1). The most listened-to bit |
| 4 | No script | 3 (`mp_awards`, `mp_menuped`, `pausemenu_multiplayer`) | Raised by the engine; meaning to check |
| 8 | 146 call sites: the shared "a mission is starting" routine (it first takes a new mission id), shops, intros, `startup_positioning`, the replay path | 46 | A mission or activity is taking over: ambient content steps aside |
| 16 | No script | 218 | Raised by the engine. `replay_controller` and `pickupvehicles` keep their state when this is the cause, so it looks like a pause-and-resume case (Rockstar Editor or replay; to check) |
| 32 | No script | 47 | Raised by the engine. `replay_controller` treats it like bit 2; the network-safe shared scripts (`ingamehud`, `social_controller`, `stats_controller`, `achievement_controller`, `drunk_controller`) listen for it. Likely the return from Online or a sign-out (to check) |
| 64 | `main`, `benchmark`, `mission_repeat_controller` (always together with 8 in the reset path) | 143 | Reset the world: before a replay, the benchmark or a mission replay. `shop_controller`, `vehicle_gen_controller`, `taxiservice` and the family scenes check for it by cause |
| 128 | `director_mode`, once its setup is finished | 21 | Director mode has taken over |

The most common masks are 3 (bits 1 and 2, 138 scripts), 19 (1, 2 and 16, 92), 11 (1, 2 and 8, 43), 83 (1, 2, 16 and 64, 42) and 2 alone (32) (**Verified**). Community lists give names for some bits (for example "debug menu" for 1 and "SP to MP" for 2); they agree with what the scripts do for 1 and 2 and are **Known** for the rest.

## 2.7 How ScriptHookV, SHVDN and Lua run

From the test install's logs on 2026-10-13 (**Verified**):

| Time | Event | Source |
| --- | --- | --- |
| 04:20:07 | `GTA5.exe` starts | monitoring script |
| 04:20:15 to 04:20:22 | The ASI loader (`dinput8.dll`) loads 15 `.asi` files; ScriptHookV checks the game version and registers `LUA.asi`, `Menyoo.asi` (plus an additional thread), `ScriptHookVDotNet.asi` and `TrainerV.asi` | `asiloader.log`, `ScriptHookV.log` |
| 04:20:36 to 04:20:42 | ScriptHookV extends four pools, finds the thread table (189) and hooks DirectX | `ScriptHookV.log` |
| 04:21:15 | ScriptHookV creates 6 threads (5 registered entries plus a control thread) and waits | `ScriptHookV.log` |
| 04:21:29 to 04:21:44 | It calls each mod's `main()`: Lua and Menyoo first, SHVDN at 04:21:30 to 31, TrainerV at 04:21:44 | `ScriptHookV.log` |
| 04:21:31 to 04:21:44 | SHVDN loads its two APIs, compiles `.cs` files, loads every assembly in `scripts/` and constructs the scripts; first script tick at 04:21:44 | `ScriptHookVDotNet.log`, monitoring script |
| 04:21:54 | The player can move (106.9 s after the exe started) | monitoring script |

What this shows:

- **ScriptHookV doesn't run mods during the loading screen.** It registers them early but launches their `main()` only once the game's own scripts are running, about 70 seconds later on a low-end test PC (integrated graphics).
- **ScriptHookV's mod "scripts" are separate from Rockstar's threads.** They are registered with ScriptHookV, not started with `START_NEW_SCRIPT`, so they use none of the stack pools. Each runs as a fiber that ScriptHookV switches to during the game's script update, which is why natives can be called from them (**Known**; the ScriptHookV SDK states the rule that natives may only be called from that loop).
- **SHVDN is one ScriptHookV script that hosts many.** All .NET scripts live in one script domain. The SHVDN API shows each `Script` can run on its own thread (`Script.Start(useThread)`, `IsUsingThread`) and that native calls are executed with the game thread's context (`ExecuteTaskWithGameThreadTlsContext`), so each tick waits for the game thread (**Verified** from the API reference). `ScriptTimeoutThreshold` (5,000 ms by default; mods that call long natives need it raised, for example to 30,000) is how long one tick may run before SHVDN aborts that script.
- **Why one slow mod freezes the game.** The frame can't finish while a mod's code holds the game thread. For example, the native that switches story mode into multiplayer mode took 1 to 22 s on a low-end PC, and the game stood still for that long. The other side: if SHVDN loads a set of .NET mods twice (two copies of SHVDN, or a duplicate folder), everything they do per frame is paid twice.
- **Lua** (`LUA.asi`) is a ScriptHookV script like SHVDN, running `scripts/main.lua` in its own loop.

## 2.8 What this means for modders

- **Yield every frame, gate the heavy work.** Rockstar's own budget pattern is a `WAIT(0)` loop with timer gates; in SHVDN it is the script's `Interval` or a timer inside `Tick`. No file access or full-world scans per frame.
- **Long native calls are freezes.** A native that loads something (entering MP mode, loading a scene, requesting many models) blocks the frame for as long as it takes. Spread such work over frames, and keep `ScriptTimeoutThreshold` high only where a single call can't be split.
- **Use force cleanup as a signal, not a weapon.** Bit 2 ends all story controllers at once (guide 1). Bit 8 is what every Rockstar mission raises when it starts, so a mod that starts its own "mission" can raise 8 to clear ambient content the same way. Bits 1, 64 and 128 have side effects (replay and director mode paths) and should not be raised by mods. All of this needs a test before use.
- **Starting Rockstar scripts from a mod** follows the same request, wait, start, release pattern, with the right stack size, after checking `GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE`.
- **Listening to script events** is the way to watch what Rockstar's scripts tell each other without touching their globals; the event layout is R15.1.

## 2.9 Test card: which Rockstar scripts really run

A small SHVDN script can list every running Rockstar script thread (`SCRIPT_THREAD_ITERATOR_*` natives) when the player can first move and again some minutes later, with the free stacks of the 1,424, 5,050, 8,032, 35,250, 64,500 and 89,500 pools (`GET_NUMBER_OF_FREE_STACKS_OF_THIS_SIZE`). Compare the list with the cards in guide 1: every script there marked as always running should appear; `respawn_controller` should not (it runs only on death or arrest); one mission triggerer should. Whether ScriptHookV's own entries show up in the list (unnamed threads) is also worth noting.

## 2.10 Open questions

| Question | Where it goes |
| --- | --- |
| Meaning of force-cleanup bits 4, 16 and 32 (engine-raised) | R1.2 and R5.8 (replay), with an in-game test |
| What thread priority values change | R1.4 or R18.4 |
| The event queue indexes and the script event layout | R15.1 |
| Which of the duplicated pool entries in `gameconfig.xml` applies to the PC build | R1.4 |
