# Streaming, memory and video memory

How GTA V spends memory: the game heap, the streaming system and its stores, video memory (dedicated or shared), and Windows' commit and page file; what the heap and pool adjusters really change; why more mods means freezes on a machine short of RAM, and what to do about it. Roadmap topic **R18.3** in the [roadmap](/ROADMAP.md). Builds on [memory, pools and limits](/docs/core/memory-and-pools.md), [streaming](/docs/core/streaming.md) and [graphics settings](/docs/performance/graphics-settings.md).

**How it was made.** On a low-end test PC (4-core 15 W laptop CPU, Intel UHD 620 integrated graphics, 16 GB RAM, about 15 script mods and a dozen add-on packs): the HeapAdjuster plugin's log, the vanilla and a modded `gameconfig.xml` (extracted with [`tools/rpf-cw.ps1`](/tools/README.md)), the memory columns of a monitoring script's log (see [measuring performance](/docs/performance/measuring.md)), and Windows' own figures (`Win32_VideoController`, `Win32_PageFileUsage`, `Win32_OperatingSystem`, the System event log). How the engine splits memory internally is **Known**; the numbers are **Verified**.

## 3.1 Short version

- **Three budgets, one machine:** the game's own heap (fixed at start), the streaming system (models, textures and maps loaded on demand, the biggest and most variable part), and video memory. On integrated graphics, video memory is ordinary RAM, so all three come out of the same 16 GB.
- **The heap is small and fixed.** Vanilla it's 478 MB; HeapAdjuster set it to 1,950 MB on the test PC (**Verified**, its log). The heap holds engine objects, not textures; running out of it is a crash on start or when many add-on packs mount (**Known**), not a slowdown.
- **The streaming engine has fixed buffers** in `gameconfig.xml`: `PhysicalStreamingBuffer` 252 and `VirtualStreamingBuffer` 1,000 (unchanged by the mod), `ArchiveCount` 4,184 vanilla, 6,024 modded, 7,344 with PackfileLimitAdjuster. More archives and bigger stores mean more bookkeeping memory reserved at start.
- **On the test laptop the game's private memory reached 9.1 GB** (peak 9,134 to 9,165 MB) and its working set 5.9 to 6.4 GB within 10 minutes, with population density and distance scaling at 0. Private memory climbs from 7.4 GB to 8.8 GB in the first two minutes after loading and never falls back.
- **9.1 GB private on a 15.8 GB machine leaves about 6.7 GB** for Windows, the graphics (shared), the launcher and everything else, so Windows pages to the 11.7 GB page file (peak use 4.2 GB since boot). Paging is where the multi-second freezes and the hard lock-ups the test PC had (five forced power-offs in a week, no bluescreens) most likely come from.
- **Windows reports the UHD 620 with 1 GB** (`AdapterRAM` 1,073,741,824). That figure is the pre-allocated part; the driver can take up to about half of RAM as shared graphics memory on demand (**Known**), competing with the game.
- **What frees the most:** texture quality ([graphics settings](/docs/performance/graphics-settings.md)), fewer add-on packs and replaced archives, fewer loaded script mods, and closing other programs. Raising pools and the heap further does the opposite.

## 3.2 Where the memory goes

| Budget | Set by | Test PC | Grows with | When it runs out (**Known**) |
| --- | --- | --- | --- | --- |
| Game heap | The executable; HeapAdjuster | 1,950 MB (vanilla 478) | Number of DLC packs and archives, entities and pools | Crash on start or while loading (`ERR_MEM_EMBEDDEDALLOC` style errors) |
| Pools | `gameconfig.xml` | 137 values raised in the modded file ([memory and pools](/docs/core/memory-and-pools.md)) | Reserved at start, whether used or not | "Pool full" crash (`PoolManager_Crash.log`) |
| Streaming stores and buffers | `gameconfig.xml` `ConfigStreamingEngine` and stores | Stores x1.4 to x11; buffers unchanged | Models, textures, maps loaded around the player | Pop-in, low-detail models, long loads |
| Video memory | The GPU (dedicated) or the driver (shared) | UHD 620: 1 GB reported, more shared on demand | Resolution, texture quality, MSAA, shadows, reflections | Stutter, textures missing, driver reset (event 4101) |
| Script mods | .NET and Lua runtimes, each mod's data | All .NET mods in one SHVDN domain | Number and size of loaded mods | Higher commit, more paging |
| Windows commit (RAM + page file) | Windows | 15.8 GB RAM, 11.7 GB page file | Everything above | Paging freezes, then "out of memory" or a hard lock-up |

## 3.3 What the adjusters change

| Plugin | What it raises | Value here | Helps with | Costs |
| --- | --- | --- | --- | --- |
| HeapAdjuster | The game heap | 478 to 1,950 MB | Many add-on packs, big map mods | 1.5 GB more reserved from the start |
| PackfileLimitAdjuster | How many archives can mount | 7,344 | Many add-on packs | Small bookkeeping |
| Modded `gameconfig.xml` | Pools and streaming stores | 137 values ([memory and pools](/docs/core/memory-and-pools.md)) | Add-on maps, many entities, big scenarios | Reserved memory for every slot |
| PoolManager | Nothing; logs the pool that overflowed | | Diagnosing pool crashes | |

None of them adds memory; they move limits. On a machine with plenty of RAM that's harmless. On this one every raised limit is memory not available to streaming and the shared graphics.

## 3.4 Memory over a session on the test PC

One 10-minute session with an Online-style mod:

| Time after scripts start | Working set | Private | What was happening |
| --- | ---: | ---: | --- |
| +8 s | 4,697 MB | 7,382 MB | Just playable |
| +28 s | 5,245 MB | 8,175 MB | The mod's Online mode starting |
| +48 s | 4,707 MB | 8,742 MB | |
| +2 min | 5,281 MB | 8,751 MB | Steady |
| +2.5 min | 5,364 MB | 8,795 MB | Steady |
| Peak (10 min) | 5,929 MB | 9,134 MB | |

A second session peaked at 6,388 MB working set and 9,165 MB private. The gap between private (committed) and working set (in RAM) is 3 to 3.5 GB: that much of the game's committed memory is not in RAM at any moment, which means it's in the page file or not yet touched (**Known** interpretation).

Windows with the game closed: 2.4 GB of RAM free, page file 11,678 MB allocated with a peak of 4,249 MB used since boot, no resource-exhaustion events in 30 days. Earlier the machine had five forced power-offs in a week and repeated "processor speed limited by firmware" events.

## 3.5 When more mods means freezes

1. Every add-on pack mounts archives and adds models to the streaming stores; every .NET mod adds code and data to the one SHVDN domain; every replaced archive in `Mods\` is a full copy the game reads instead of the original.
2. The game commits more at start and streams more during play.
3. On a machine with spare RAM nothing happens. On the test PC, commit passes RAM and Windows starts paging. A page fault on a texture or a script's data stops the frame until the disk answers: a hitch of hundreds of milliseconds to seconds.
4. If commit nears RAM plus page file, Windows can't satisfy allocations and the machine locks up. The test PC's forced power-offs fit this.

So the order of fixes: lower what streams (textures, density, distance), lower what's loaded (separate mod sets for separate uses, so only the mods a session needs are on), keep the page file on the SSD with room to grow, close the browser and launchers' overlays, and don't raise limits further.

## 3.6 What this means for modders

- **A mod's memory is everyone's memory.** On shared-memory machines a mod that keeps models, dictionaries or big lists loaded takes it from the game's streaming.
- **Release requests** ([streaming](/docs/core/streaming.md#107-what-this-means-for-modders)), keep data on disk until needed, and don't cache the world in lists.
- **Ship add-on content as small packs** and only what's used; every model in a pack is something the streamer may load.
- **Document the RAM your mod pack expects.** "Tested on 16 GB with integrated graphics" is useful to players.

## 3.7 Open questions

| Question | Where it goes |
| --- | --- |
| How much each texture level costs on integrated graphics (working set and private) | [Graphics settings](/docs/performance/graphics-settings.md) test card 2 |
| How much a smaller mod set saves, measured the same way | Test card 1, R18.5 |
| How much of the 1,950 MB heap is used (HeapAdjuster only logs the size) | Needs a memory tool; second pass |
| Whether the game's in-menu video memory bar counts shared memory on integrated graphics | Test card 2 |

## 3.8 Test cards

1. **Mod set memory:** play the same 5 minutes (same spot, same time of day) with your full mod set, note the peak working set and private memory; repeat with half the mods, and with none.
2. **Video memory bar:** open Settings > Graphics and note the video memory figure at the top (used / available) at the current settings and with texture quality at Normal.
3. **Paging:** during a session, keep Task Manager's Performance > Memory open on a second screen or after a hitch; note "Committed" against "In use". If committed is far above RAM when hitches happen, paging is the cause.
