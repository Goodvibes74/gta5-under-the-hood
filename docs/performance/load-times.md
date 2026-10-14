# Load times and stutter

What happens while GTA V loads, why the first minutes stutter, what the shader and streaming caches do, and what shortens loading and early stutter. Roadmap topic **R18.8** in the [roadmap](/ROADMAP.md). Builds on [boot](/docs/00-getting-started/boot.md) (the boot timeline), [streaming](/docs/core/streaming.md), [measuring](/docs/performance/measuring.md) and [mod overhead](/docs/performance/mod-overhead.md).

**How it was made.** Three launch timelines of a heavily modded low-end test laptop (from the ScriptHookV, SHVDN and ASI loader logs and a monitoring script's log; see [boot](/docs/00-getting-started/boot.md)), and FPS and hitches per time window computed from two 10-minute sessions (samples every 5 s). Shader caching and the effect of disks are **Known**; the times are **Verified**.

## 8.1 Short version

- **Exe start to playable: 80 to 107 s on the test laptop** across three measured launches with different mod sets; earlier launches ranged from 57 to 140 s ([boot](/docs/00-getting-started/boot.md)).
- **About two thirds is the engine's loading screen** (archives, map, save; 68 to 77 s), the rest is mods starting (SHVDN loads its scripts in 6 to 14 s) and the last fade-in.
- **The first three minutes have nearly all the hitches.** In the two 10-minute sessions, 9 of 10 hitches over 250 ms happened in the first 180 s (3 + 1 and 2 + 3); after that, 0 and 1.
- **But the frame rate falls later, not earlier:** 17 to 19 FPS in the first minute, 21 FPS from 1 to 3 minutes, then 16 to 18 FPS from 3 to 10 minutes. In both sessions the later window includes fast drives across the city (120 to 170 km/h), so heavier streaming and heat throttling ([CPU](/docs/performance/cpu.md)) are both possible causes; test card 2 separates them.
- **What causes early stutter (Known):** the streamer filling memory around the player for the first time; shaders compiled the first time an effect is drawn (the driver caches them on disk afterwards); scripts and mods doing their first-run setup; for an Online-style mod, the one-off map switch (`ON_ENTER_MP`, 8.6 s behind a loading screen).
- **What helps:** fewer mods and add-on packs (shorter mount and SHVDN steps), an SSD (already here), keeping the driver's shader cache (don't clear it), preloading a mod's assets behind the loading screen, starting a session where you last saved (the map around the save loads with the save), and letting the first minute settle before judging performance.

## 8.2 What a load is made of

| Phase | Time on the test laptop | What happens | Shortened by |
| --- | ---: | --- | --- |
| Exe start to ScriptHookV | 8 s | The executable, Social Club and launcher layer, the ASI loader loading 14 plugins | Fewer ASI plugins (small) |
| Engine loading screen | 60 to 69 s more | Archives mounted (every add-on pack mounts several), map and data files read, story save loaded ([boot](/docs/00-getting-started/boot.md)) | Fewer add-on packs and replaced archives; an SSD (**Known**) |
| Script hooks start | 1 to 2 s | ScriptHookV launches the ASI scripts' `main()`; SHVDN starts | |
| SHVDN loads scripts | 6 s (61 scripts) to 14 s | Assemblies loaded, every script constructed; slow constructors show as "slow start" | Fewer .NET mods; light constructors |
| Fade-in to playable | 7 to 9 s | The game's last streaming around the player, then the fade | Nothing to tune |
| An Online-style mod's map switch | 8.6 s | `ON_ENTER_MP` and about 150 IPL changes behind a loading screen ([streaming](/docs/core/streaming.md)) | Only by not switching |

## 8.3 The first minutes

FPS (average of the 5-second samples) and hitches over 250 ms, by time after the scripts started:

| Session | 0 to 60 s | 60 to 180 s | 180 to 600 s |
| --- | --- | --- | --- |
| Session 1 | 18.6 FPS, 3 hitches | 21.0 FPS, 1 hitch | 17.9 FPS, 0 hitches |
| Session 2 | 17.1 FPS, 2 hitches | 21.3 FPS, 3 hitches | 16.0 FPS, 1 hitch |

The hitches come early: the end of loading (4 to 5 s frames before playable), the Online switch (6.9 and 8.6 s behind loading screens), a streamed animation (1.4 s). The FPS comes down late. Both sessions followed the same path (airport, then a fast drive to the city at 120 to 170 km/h, a stop in Vinewood, another drive, and Strawberry), so the later window mixes heavier streaming with whatever heat throttling did ([CPU](/docs/performance/cpu.md), 32 throttling events in 14 days). Test card 2, standing still for 15 minutes, separates the two.

## 8.4 Shader cache (Known)

On DirectX 11 the game's shaders are compiled by the graphics driver the first time they're used and stored in the driver's shader cache on disk (`%LocalAppData%\Intel\ShaderCache` for Intel, `NVIDIA\DXCache` for NVIDIA, `D3DSCache` for Windows). The first visit to a new area or effect after a driver update or a cache clean can hitch while shaders compile; later visits read the cache. So: don't clear the shader cache as a "fix", and expect a slower first session after a driver update.

## 8.5 What this means for modders

- **Keep constructors light:** SHVDN constructs every script during the load; a slow constructor adds to everyone's load time (visible in `ScriptHookVDotNet.log` times). Do heavy setup on first use.
- **Preload behind the loading screen:** assets your mod needs at the start (models, animation dictionaries) are cheapest to request while the screen is still black.
- **Don't judge performance in the first minute:** measure after the first three minutes, or report the early window separately ([measuring](/docs/performance/measuring.md)).

## 8.6 Open questions

| Question | Where it goes |
| --- | --- |
| How much each add-on pack adds to the engine loading screen | Test card 1 |
| Whether the 3-to-10-minute FPS drop is throttling (and how much a cooling pad recovers) | Test card 2 |
| Whether an antivirus exclusion shortens the loading screen | [Windows and drivers](/docs/performance/windows-and-drivers.md) test card 3 |

## 8.7 Test cards

1. **Add-on packs:** note exe start to playable for two launches; temporarily remove two big add-on packs' lines from `dlclist.xml` in the mods-folder `update.rpf` (back the archive up first), launch twice more, compare, and restore.
2. **Throttling vs time:** play 15 minutes standing in one spot with a frame-time log; note the FPS by window and any Kernel-Processor-Power ID 37 events in Event Viewer; repeat with a cooling pad.
