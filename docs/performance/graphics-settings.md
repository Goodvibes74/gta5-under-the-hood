# Graphics settings, one by one

Every option in GTA V's `settings.xml` and graphics menu: what it changes, what it costs (GPU, CPU, video memory), its range in the file, and a value for weak, mid and strong PCs; the settings the menu doesn't show; and `commandline.txt`. Roadmap topic **R18.2** in the [roadmap](/ROADMAP.md). Measure every change the way [measuring performance](/docs/performance/measuring.md) describes.

**How it was made.** A low-end test PC's `Documents\Rockstar Games\GTA V\settings.xml` (version 27) was read and compared with an older copy of the same file. The command-line switches and their ranges come from the community list of GTA V launch options ([gtaboom.com](https://www.gtaboom.com/pc-launch-commands-for-gta-5-8421), 2015, **Known**); what each option costs is general knowledge from performance guides and testing (**Known**). Which menu label each number in `settings.xml` stands for is **not confirmed** for every setting: the file and the menu don't always agree in the obvious way (2.6), and test card 1 settles it. Nothing in the game scripts reads these settings, so the decompile has nothing to add here.

## 2.1 Short version

- **`settings.xml` is the truth, the menu writes it.** It lives in `Documents\Rockstar Games\GTA V\`, holds 40 graphics values plus video, audio and replay ones, and is rewritten whenever the menu changes something (`configSource` says whether it came from the menu or from auto-detection; this one says `SMC_AUTO`).
- **Biggest GPU costs (Known):** MSAA, resolution, grass at Ultra, shadows (quality, soft shadows, long shadows), reflections and reflection MSAA, SSAO, post FX, tessellation.
- **Biggest CPU costs (Known):** population density and variety, distance scaling and extended distance scaling, grass, and shadows at long distance. A weak CPU is helped most by `CityDensity`, `LodScale` and `MaxLodScale`.
- **Biggest memory costs (Known):** texture quality first, then MSAA, resolution and shadow and reflection resolution. On integrated graphics this memory comes out of system RAM.
- **Check the file after any change.** On the test PC, a later rewrite of `settings.xml` set `TextureQuality` to **2** (the top of its 0 to 2 range) from **1**, while the owner believed it had been lowered to Normal. On a 16 GB shared-memory laptop that is the setting most likely to cost RAM. The menu, auto-detection or a launcher can rewrite the file.
- **The same rewrite turned FXAA off** (it was on), and set distance scaling and population density to 0, VSync to half rate (2), shadows, reflections and shaders to 1, particles and water to 0.

## 2.2 Every setting

Ranges in `settings.xml` follow the command-line switch ranges (**Known**); menu labels in menu order. "Test PC" is the value on a low-end laptop (4-core 15 W CPU, integrated graphics, 16 GB shared memory).

| Setting (menu) | `settings.xml` key | Range | What it changes | Main cost (**Known**) | Test PC | Weak / mid / strong |
| --- | --- | --- | --- | --- | --- | --- |
| Resolution | `video/ScreenWidth`, `ScreenHeight` | | Pixels drawn | GPU, VRAM | 1280×768 | 1280×720 / 1920×1080 / native |
| VSync | `video/VSync` | 0 off, 1 on, 2 half | Caps FPS to the refresh rate or half | Caps heat and power | 2 (about 30) | 2 / 1 / 1 or off with a limiter |
| Population density | `CityDensity` | 0.0 to 1.0 | How many peds and cars spawn | **CPU** | 0.0 | 0.0 to 0.2 / 0.5 / 1.0 |
| Population variety | `PedVarietyMultiplier`, `VehicleVarietyMultiplier` | 0.0 to 1.0 | How many different models stay loaded | Memory, streaming | 1.0, 1.0 | 0.3 / 0.6 / 1.0 |
| Distance scaling | `LodScale` | 0.0 to 1.0 | How far detail (LOD) reaches | **CPU**, GPU | 0.0 | 0.0 to 0.3 / 0.6 / 1.0 |
| Extended distance scaling (advanced) | `MaxLodScale` | 0.0 to 1.0 | Pushes high detail further still | **CPU** heavy | 0.0 | 0 / 0 / 0.3 to 1.0 |
| Ped and vehicle LOD bias | `PedLodBias`, `VehicleLodBias` | 0.0 to 1.0 | Detail level of peds and cars by distance | GPU, CPU | 0.0, 0.0 | 0 / 0.3 / 1 |
| High detail streaming while flying (advanced) | `HdStreamingInFlight` | on/off | Keeps streaming HD while flying | Streaming, memory | off | off / off / on |
| Texture quality | `TextureQuality` | 0 to 2 | Texture resolution | **Memory (VRAM or shared RAM)** | **2** | 0 / 1 / 2 |
| Shader quality | `ShaderQuality` | 0 to 2 | Lighting and material shader detail | GPU | 1 | 0 / 1 / 2 |
| Shadow quality | `ShadowQuality` | 0 to 3 | Shadow map resolution | GPU, VRAM | 1 | lowest / mid / top |
| Soft shadows | `Shadow_SoftShadows` | several filters | Shadow edge filtering | GPU | 0 | sharpest / softer / softest |
| Long shadows (advanced) | `Shadow_LongShadows` | on/off | Shadows at dawn and dusk | GPU | off | off / off / on |
| High resolution shadows (advanced) | `UltraShadows_Enabled` | on/off | Very high shadow resolution | GPU, VRAM | off | off / off / on |
| Shadow distance (advanced) | `Shadow_Distance` | 1.0 up | How far shadows are drawn | GPU, CPU | 1.0 | 1.0 / 1.0 / 2.0+ |
| Particle shadows | `Shadow_ParticleShadows` | on/off | Shadows from smoke and effects | GPU | off | off / off / on |
| Reflection quality | `ReflectionQuality` | 0 to 3 | Reflection resolution and range | GPU | 1 | lowest / mid / top |
| Reflection MSAA | `ReflectionMSAA` | 0, 2, 4, 8 | Anti-aliasing in reflections | GPU, VRAM | 0 | 0 / 0 / 2 to 4 |
| Reflection blur | `Reflection_MipBlur` | on/off | Blurred reflections | GPU (small) | off | off / on / on |
| Water quality | `WaterQuality` | 0 to 1 (2) | Water surface and refraction | GPU | 0 | 0 / 1 / top |
| Particle quality | `ParticleQuality` | 0 to 2 | Effect resolution and count | GPU | 0 | 0 / 1 / 2 |
| Grass quality | `GrassQuality` | 0 to 3+ | Grass density and shadows | **GPU and CPU**; Ultra is the most expensive single option | 1 | lowest / mid / one below top |
| Ambient occlusion | `SSAO` | 0 to 2 | Contact shadows | GPU | 0 | 0 / 1 / 2 |
| Anisotropic filtering | `AnisotropicFiltering` | 0 to 16x | Texture sharpness at angles | GPU (small) | 0 | 2x / 8x / 16x |
| MSAA | `MSAA` | 0, 2, 4, 8 | Edge anti-aliasing | **GPU, VRAM**, very heavy | 0 | 0 / 0 / 2 to 4 |
| FXAA | `FXAA_Enabled` | on/off | Cheap post-process anti-aliasing | GPU (very small) | **off** | on / on / on or off |
| TXAA (NVIDIA only) | `TXAA_Enabled` | on/off | Temporal AA with MSAA | GPU | off | off / off / optional |
| Tessellation | `Tessellation` | 0 to 3 | Extra geometry on trees and surfaces | GPU | 0 | 0 / 1 / 2 to 3 |
| Post FX | `PostFX` | 0 to 3 | Bloom, motion blur, depth of field quality | GPU | 0 | 0 / 1 / 2 to 3 |
| Depth of field | `DoF` | on/off | In-game depth of field | GPU | off | off / off / on |
| Motion blur strength | `MotionBlurStrength` | 0.0 to 1.0 | Blur when moving | GPU (small) | 0.0 | 0 / taste / taste |
| Volumetric fog | `Lighting_FogVolumes` | on/off | Light shafts in fog | GPU | off | off / off / on |
| Frame scaling mode (advanced) | `SamplingMode` | 0 = off | Renders below (or above) the screen resolution | GPU, VRAM | 0 | 0 or below 1 / 0 / 0 |
| DirectX version | `DX_Version` | 0, 1, 2 (10, 10.1, 11) | API | | 2 (DX11) | 2 / 2 / 2 |
| Screen-space AA flag | `Shader_SSA` | on/off | Shader-based smoothing | GPU (small) | on | on / on / on |
| Pause game on focus loss | `video/PauseOnFocusLoss` | 0/1 | | | 1 | |
| Replay buffer (Rockstar Editor) | `system/numReplayBlocks`, `numBytesPerReplayBlock`, `maxSizeOfStreamingReplay` | | Memory and disk kept for recording | Memory, disk | 30 × 9,000,000 bytes, 1,024 | Lower on weak PCs if the editor isn't used |

Settings marked "advanced" are on the menu's Advanced Graphics page.

## 2.3 Settings the menu doesn't show (or shows differently)

| Key | Note |
| --- | --- |
| `Shadow_SplitZStart`, `Shadow_SplitZEnd` (0.93, 0.89) | Where the shadow cascades split; editing them moves shadow detail (**Known**, rarely worth touching) |
| `Shadow_aircraftExpWeight` (0.99) | Shadow cascade weighting while flying |
| `Shadow_DisableScreenSizeCheck` | Draws shadows of small, far objects too (costs GPU) |
| `MSAAFragments`, `MSAAQuality` | NVIDIA and AMD extended MSAA modes |
| `configSource` | `SMC_AUTO` (auto-detected) or the menu; auto-detection can overwrite hand edits on a new GPU or driver |
| `VideoCardDescription` | The GPU the settings were made for; a different card resets them unless `-ignoreDifferentVideoCard` is used |

## 2.4 `commandline.txt`

A text file named `commandline.txt` in the game folder holds launch switches, one per line; the game reads it at start (**Known**). Useful ones (from the community list, ranges as given there):

| Switch | Use |
| --- | --- |
| `-benchmark`, `-benchmarkIterations <n>`, `-benchmarkPass <n>`, `-benchmarkFrameTimes`, `-benchmarknoaudio` | The benchmark ([measuring performance](/docs/performance/measuring.md#the-games-benchmark)) |
| `-frameLimit <n>` | Limit to a divisor of the refresh rate |
| `-ignoreDifferentVideoCard` | Keep settings after a GPU or driver change |
| `-UseAutoSettings`, `-safemode`, `-useMinimumSettings` | Reset to auto, or to the minimum (safe mode isn't saved) |
| `-windowed`, `-borderless`, `-fullscreen`, `-width`, `-height` | Window mode |
| `-disableHyperthreading` | Keep game tasks off hyperthreaded cores (**Known**, worth testing on 4-core/8-thread laptops) |
| `-textureQuality 0..2`, `-shadowQuality 0..3`, `-reflectionQuality 0..3`, `-grassQuality`, `-lodScale 0.0..1.0`, `-cityDensity 0.0..1.0` ... | Override the file for one launch |

The test PC has no `commandline.txt`.

## 2.5 Where the cost lands on a low-end laptop

A 15 W, 4-core laptop chip throttles when hot, and integrated graphics share the system RAM. So, in order of what helps:

1. **Memory first:** texture quality (back to the lowest), MSAA off, reflection MSAA off, resolution as it is. Every MB the graphics take is a MB less for the game and its mods.
2. **CPU second:** population density, distance scaling and extended distance scaling at 0, which is already the case; grass at its lowest.
3. **GPU third:** shadows, reflections, SSAO, post FX at their lowest; FXAA on is almost free and hides jaggies at 1280×768.
4. **Heat:** half-rate VSync keeps the chip cooler and steadier than running uncapped.

## 2.6 The file vs the menu

On the test PC, notes of a menu change said "Shadow quality Very High to Normal", "Shader Very High to Normal" and "Texture High to Normal", but the file says shadows 2 to 1, shaders 2 to 1 and textures 1 to **2** (the last after a later rewrite). If the menu lists levels from the lowest as 0, then shadows and shaders are now one step above the lowest, not at it, and textures are at the top. Until test card 1 is done, treat the numbers in the table above as file values, not menu labels.

## 2.7 What this means for modders

- Settings don't change what scripts can do; no game script reads them. But they change how much memory and CPU a mod has to work with: on a weak PC, population density and textures matter more to mod stability than any pool size.
- A mod pack meant for weak PCs should ship a recommended `settings.xml` section (or instructions), not edit the file silently.

## 2.8 Open questions

| Question | Where it goes |
| --- | --- |
| The exact menu label for each value of every quality key | Test card 1 |
| What rewrites `settings.xml` without the player asking (auto-detection after a driver update, a launcher) | Compare the file before and after a driver update |
| How much shared memory each texture level takes on integrated graphics | Test card 2, R18.3 |

## 2.9 Test cards

1. **Map the numbers:** in the graphics menu, set texture quality to Normal and apply, then open `settings.xml` and note `TextureQuality`. Repeat for High and Very High, and for shadows, reflections, shaders, water, particles and grass. Fill in the menu labels in 2.2. Leave textures at Normal at the end.
2. **Texture memory:** with a frame-time and memory log on ([measuring performance](/docs/performance/measuring.md)), play the same 5 minutes at texture Normal and at the current value; compare peak working set and private memory, and the hitches.
3. **FXAA:** turn FXAA back on; it should cost under 1 FPS.
