# Profiles for different PCs

Ready-made settings for a low-end laptop, a mid-range PC and a strong PC, with the reasons; and how to switch mod sets per use. Roadmap topic **R18.7** in the [roadmap](/ROADMAP.md). It puts [graphics settings](/docs/performance/graphics-settings.md), [memory](/docs/performance/memory-and-vram.md), [CPU](/docs/performance/cpu.md), [mod overhead](/docs/performance/mod-overhead.md) and [Windows and drivers](/docs/performance/windows-and-drivers.md) together.

**How it was made.** The three profiles combine the costs in the other performance pages (**Known** where those are Known); the low-end profile's starting point is a low-end test laptop's measured state and `settings.xml`. The mod-set part describes a mod-set switcher used on that test install. The profiles are recommendations to test, not measurements; the test card compares them.

## 7.1 Short version

- **Low-end (4-core 15 W laptop, integrated graphics, 16 GB shared):** lowest textures, everything else low, density and distance at 0, FXAA on, half-rate VSync, 1280×720 to 1280×768; few mods per session; background programs closed. Target: a steady 25 to 30 FPS with no in-play hitches over 1 s.
- **Mid-range (6 cores, a 4 to 6 GB dedicated GPU, 16 GB):** 1080p, textures High, most options Normal to High, density 0.5, distance 0.5; any mod set. Target 60 FPS.
- **Strong (8+ fast cores, 8+ GB GPU, 32 GB):** textures Very High, shadows and reflections high, grass one below Ultra, distance 1.0, extended distance 0.3 to 1.0, MSAA 2x or none plus FXAA. Target 60+ FPS.
- **Mod sets per use beat one big install** on weak PCs: switching which mods load (rename to `.disabled`) frees memory and CPU that no setting can. The test install used five sets, each with its own desktop launcher.

## 7.2 The three profiles

`settings.xml` keys from [graphics settings](/docs/performance/graphics-settings.md); "lowest" and "top" mean the ends of each key's range until the menu mapping is confirmed (its test card 1).

| Setting | Low-end laptop | Mid-range PC | Strong PC |
| --- | --- | --- | --- |
| Resolution | 1280×720 to 1280×768 | 1920×1080 | native (1440p, 4K) |
| VSync | half (2) | on (1) | on, or off with a frame limiter |
| `TextureQuality` | **lowest (0)** | middle (1) | top (2) |
| `ShaderQuality` | lowest | middle | top |
| `ShadowQuality` | lowest | middle | top |
| Soft shadows, long shadows, high-res shadows | off | soft, off, off | softest, on, on |
| `ReflectionQuality`, `ReflectionMSAA` | lowest, 0 | middle, 0 | top, 2 to 4 |
| `WaterQuality`, `ParticleQuality` | lowest | middle | top |
| `GrassQuality` | lowest | middle | one below top |
| `SSAO` | off | normal | high |
| `MSAA` | off | off | 2x (or off) |
| `FXAA_Enabled` | **on** | on | on (or TXAA with MSAA on NVIDIA) |
| `AnisotropicFiltering` | 2x | 8x | 16x |
| `Tessellation` | off | normal | high |
| `PostFX` | normal (0) | high | very high |
| `CityDensity` | 0.0 | 0.5 | 1.0 |
| Variety multipliers | 0.3 to 0.5 | 0.7 | 1.0 |
| `LodScale` | 0.0 to 0.2 | 0.5 | 1.0 |
| `MaxLodScale` | 0.0 | 0.0 | 0.3 to 1.0 |
| `HdStreamingInFlight` | off | off | on |
| Mods | one mod set per session ([7.3](#73-mod-sets)) | any | any |
| Windows | [pre-play checklist](/docs/performance/windows-and-drivers.md#a-pre-play-checklist-for-a-low-end-laptop) every time | close the browser | as you like |

**Why the low-end column looks like that:** memory is the first wall on shared graphics (textures, MSAA, variety), the CPU's main thread is the second (density, distance, mods), the GPU is third (shadows, reflections, grass), and heat underlies all of it (half-rate VSync).

### Example: moving a test laptop to the low-end profile

| Key | Before | Low-end profile | Change |
| --- | --- | --- | --- |
| `TextureQuality` | 2 | 0 | **Lower** (largest memory saving) |
| `FXAA_Enabled` | false | true | Turn on (almost free) |
| `ShaderQuality`, `ShadowQuality`, `ReflectionQuality` | 1, 1, 1 | lowest | Lower if the menu shows them above the lowest |
| `PedVarietyMultiplier`, `VehicleVarietyMultiplier` | 1.0, 1.0 | 0.3 to 0.5 | Lower (fewer models kept in memory) |
| `CityDensity`, `LodScale`, `MaxLodScale` | 0, 0, 0 | 0, 0 to 0.2, 0 | Keep |
| VSync | 2 | 2 | Keep |

Make these changes in the game's menu (not by editing the file while the game runs), then measure as in [measuring performance](/docs/performance/measuring.md).

## 7.3 Mod sets

On a weak PC the cheapest frame and the cheapest MB are the ones a mod doesn't use because it isn't loaded. The approach:

1. **Group mods by use,** not by type: what you need for a story session, an Online-style session, a zombie session.
2. **Switch by renaming,** never by deleting: a mod file renamed to `<name>.disabled` isn't loaded by the ASI loader or SHVDN; renaming it back restores it.
3. **Lighter settings per set:** a set can also swap a mod's config for a lighter one (fewer police units, no ambient backup), keeping the original beside it.
4. **One launcher per set,** so the switch happens before every start and can't be forgotten.
5. **A "normal" set** with everything on, so version control sees the real install.

An example from a test install, a PowerShell switcher plus one desktop launcher per set:

| Profile | What's off | Lighter settings |
| --- | --- | --- |
| `story` | The Online-style mod, the zombie mod | none |
| `online-lite` | Small story-only gameplay mods, the zombie mod | Police mods on lighter configs |
| `online` | As `online-lite`, plus the police mods | none |
| `zombies` | The Online-style mod, gang and ambient-event mods that spawn peds | Police mods lite |
| `all` | nothing | none (the state git expects) |

## 7.4 What this means for modders

- Ship your mod with a "light" config option for weak PCs (spawn caps, effect toggles) and say which one to use.
- Make your mod safe to disable by renaming: no work in other mods' folders, no files that break if it's missing.

## 7.5 Open questions

| Question | Where it goes |
| --- | --- |
| Measured FPS and hitches of the low-end profile vs typical settings on a low-end laptop | Test card 1 |
| Profile values that need the menu mapping | [Graphics settings](/docs/performance/graphics-settings.md) test card 1 |

## 7.6 Test cards

1. **Low-end profile:** apply the low-end column in the menu, launch with a small mod set, run the [measuring](/docs/performance/measuring.md) routine (2 minutes standing, 2 minutes driving) with a frame-time log; compare with a run before the changes. Keep the profile if the peak private memory and the hitch count go down without a lower average FPS.
