# Windows and drivers

What Windows settings and other programs do to GTA V's performance, and what to set: power plan and power mode, plugged in vs battery, Game Mode, Game Bar and background recording, background and startup programs, the graphics driver, integrated vs dedicated graphics, page file and free disk space, SSD vs HDD, antivirus. Roadmap topic **R18.6** in the [roadmap](/ROADMAP.md). Builds on [memory](/docs/performance/memory-and-vram.md) and [CPU](/docs/performance/cpu.md).

**How it was made.** A low-end test laptop (15 W 4-core CPU, integrated graphics, 16 GB shared RAM, one NVMe SSD) was read with read-only commands: `powercfg /getactivescheme`, `/list` and `/query` (processor maximum state), the `GameBar`, `GameConfigStore` and `GraphicsDrivers` registry keys, `Win32_StartupCommand`, `Get-Process`, `Get-PhysicalDisk`, `Get-Volume`, `Win32_ComputerSystem`, `Win32_Battery` and `Win32_VideoController`. What each setting does to games is general Windows knowledge (**Known**); the test PC's values are **Verified**.

## Short version

- **Background programs are the biggest Windows-side cost on 16 GB.** The test laptop started **about 30 programs at sign-in** (cloud sync clients, chat apps, game launchers, a VPN, design and AI tools, browsers' auto-launch). At the moment of reading, one design app alone held about 3 GB of RAM. Every one of those MB is gone from the game ([memory](/docs/performance/memory-and-vram.md)).
- **Keep 20 GB or more free on the page file's drive.** The test PC had 17 GB free on C:, where its system-managed page file (11.7 GB) lives; under memory pressure the page file must be able to grow.
- **Heat, not the power plan, limits a 15 W chip.** Balanced with processor maximum state 100% is fine; the power mode slider ("Best performance") raises power limits on many laptops (**Known**). Play plugged in: on battery, laptops cut CPU and GPU power further.
- **Turn off background recording** (Game Bar captures): it costs GPU encoder time and memory (**Known**). It was on on the test PC.
- **Game Mode on** (the Windows 11 default) gives the game priority over background work (**Known**).
- **An SSD makes disk speed a small part of loading.** On the test PC the 80 to 94 s load was mostly CPU work ([mod overhead](/docs/performance/mod-overhead.md)).

## Settings and what to set

| Setting | Where | Test PC | Set to (for play) | Why (**Known**) |
| --- | --- | --- | --- | --- |
| Power source | | Mains | Mains | Battery mode limits CPU and GPU power |
| Power plan / power mode | Settings > System > Power | Balanced | Balanced, power mode "Best performance" | The power mode slider raises power limits on many laptops |
| Processor maximum state | Power plan advanced settings | 100% | 100% (lower only to cut heat as a test) | Capping at 99% disables turbo: cooler but slower |
| Game Mode | Settings > Gaming > Game Mode | On (default) | On | Gives the foreground game priority |
| Game Bar captures, background recording | Settings > Gaming > Captures | On | Off | Recording costs encoder time and memory |
| Startup apps | Settings > Apps > Startup, or Task Manager | About 30 | Only what's needed at sign-in | Each one takes RAM and CPU in the background |
| Programs open while playing | | Several heavy apps | Close them | Same RAM as the game and (on integrated graphics) the video memory |
| Page file | System > Advanced system settings > Performance > Virtual memory | System-managed, 11.7 GB | System-managed, 20+ GB free on its drive | Must be able to grow under pressure |
| Graphics driver | Device Manager, or the GPU maker's tool | Recent | Latest stable from the GPU maker or the laptop maker | Fixes and game profiles |
| GPU preference for the game | Settings > System > Display > Graphics | Not set | "High performance" on laptops with two GPUs | Picks the dedicated GPU |
| Hardware-accelerated GPU scheduling | Same page | Not offered | On if offered and stable | Needs a newer GPU and driver |
| Fullscreen optimisations | `GTA5.exe` properties > Compatibility | Default | Default; try off if alt-tab or stutter misbehaves | Windows' borderless-flip path |
| Antivirus exclusions | Windows Security | None | Try excluding the game folder | Scanning reads of 90 GB of archives can cost load time |

## Integrated vs dedicated graphics

| | Integrated | Dedicated |
| --- | --- | --- |
| Video memory | Shared system RAM (a small amount reserved, more on demand) | Its own VRAM |
| Settings that hurt most | Textures (memory), resolution, MSAA | MSAA, resolution, grass, shadows |
| Heat | Shares the CPU's power budget: GPU load slows the CPU | Separate budget |
| What to do | Lowest textures, half-rate VSync, low resolution, close other programs | Normal tuning ([graphics settings](/docs/performance/graphics-settings.md)) |

On a laptop with integrated graphics the CPU and GPU share one power and heat budget, so a lighter GPU load (lower settings, a 30 FPS cap) leaves more power for the CPU's main game thread ([CPU](/docs/performance/cpu.md)).

## A pre-play checklist for a low-end laptop

1. Plugged in; power mode "Best performance"; on a hard surface or a cooling pad.
2. Quit browsers, editors, design and AI tools, chat apps; pause cloud sync.
3. At least 20 GB free on the page file's drive.
4. Game Bar captures off.
5. Start with only the mods you need for this session ([mod overhead](/docs/performance/mod-overhead.md)).

## What this means for modders

- Test your mod on a machine in its everyday state, not a clean one: players have browsers and launchers open.
- Say in your readme what you tested on (RAM, GPU, other programs closed or not).

## Open questions

| Question | Where it goes |
| --- | --- |
| How much FPS and how many hitches closing background programs saves | Test card 1 |
| Whether "Best performance" power mode raises sustained clocks on a 15 W laptop | Test card 2 |
| Whether excluding the game folder from the antivirus shortens loading | Test card 3, R18.8 |

## Test cards

1. **Background programs:** play 5 minutes at the same spot with everything open as usual, then again after quitting the background programs. Compare average FPS, worst frame, hitches and peak memory ([measuring performance](/docs/performance/measuring.md)).
2. **Power mode:** same 5 minutes with power mode "Balanced" and "Best performance"; compare, and check Event Viewer for new throttling events (Kernel-Processor-Power, ID 37).
3. **Antivirus exclusion:** add the game folder as an exclusion, compare exe start to playable over two launches each way; remove the exclusion afterwards if it doesn't help.
