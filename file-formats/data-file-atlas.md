# Archive and data file atlas

Every archive in a build 1.0.3725.0 Legacy install and every kind of file inside them: how many of each, where they sit (base archives, the update archives, the 89 DLC packs, the audio archives), what each kind is, which engine system reads it, and which guide covers it. Roadmap topic **R0.7** in the [roadmap](/ROADMAP.md). Builds on [RPF archives](/file-formats/rpf.md) and [archives and the content system](/docs/core/archives-and-content.md) (R1.6).

**How it was made.** A read-only PowerShell script (the same approach as [`tools/update-check.ps1`](/tools/README.md)) opened every `.rpf` in the game folder, `update\`, `x64\` and `update\x64\dlcpacks\` with CodeWalker's library, walked all nested archives, and counted every file entry by extension and by where its top archive lives. It ran in 21 seconds. Counts are **Verified**. What each file type is and which system reads it are **Known** (CodeWalker's formats and the finished guides); sizes from the archive headers are reliable for most types but not for audio containers, so sizes are left out.

## 41.1 Short version

- **5,290 archives** (top-level and nested) hold **389,555 files** of **57 kinds**.
- **Where they are:** base archives (`common.rpf`, `x64a.rpf` to `x64w.rpf`) 157,769 files; the update archives (`update.rpf`, `update2.rpf`) 29,636; the **89 DLC packs** 197,369 (more than half); the audio archives in `x64\audio` 4,781.
- **Models and textures dominate:** 88,558 texture dictionaries (`.ytd`), 85,456 drawables (`.ydr`), 59,342 fragments (`.yft`), 22,939 drawable dictionaries (`.ydd`), 24,692 animation dictionaries (`.ycd`), 15,124 collision files (`.ybn`).
- **The world:** 19,366 placement files (`.ymap`), 2,744 archetype files (`.ytyp`), 1,778 map manifests (`.ymf`), 10,038 navmesh tiles (`.ynv`), 1,027 road node files (`.ynd`).
- **Data and scripts:** 4,693 binary metadata files (`.ymt`), 1,925 XML metadata (`.meta`), 904 `.xml`, 243 `.dat`, 1,147 compiled scripts (`.ysc`, 1,143 in the update), 1,466 job files (`.ugc`), 19,373 text blocks (`.gxt2`, all languages).
- **Media:** 7,706 audio containers (`.awc`), 1,152 Scaleform movies (`.gfx`), 1,228 particle dictionaries (`.ypt`), 807 cutscenes (`.cut`), 411 Bink videos (`.bik`), 1,446 compiled shaders (`.fxc`).
- **Recordings:** 7,511 vehicle recordings (`.yvr`) and 1,600 waypoint recordings (`.ywr`), the recorded routes behind chases and set pieces.

## 41.2 Every file type

Counts by where the file's top archive is (**Verified**). "Base" = root archives; "Update" = `update.rpf` and `update2.rpf`; "DLC" = all 89 packs; "Audio" = `x64\audio`.

| Type | What it is | Total | Base | Update | DLC | Audio | Read by | Guide |
| --- | --- | ---: | ---: | ---: | ---: | ---: | --- | --- |
| `.ytd` | Texture dictionary | 88,558 | 33,063 | 4,516 | 50,979 | 0 | Rendering | [R13.1](/docs/rendering/rendering-and-visual-settings.md) |
| `.ydr` | Drawable (a single model) | 85,456 | 57,272 | 1,613 | 26,571 | 0 | Rendering, streaming | [R4.6](/docs/world/map-data.md) |
| `.yft` | Fragment (a model that breaks or moves: vehicles, breakable props) | 59,342 | 6,147 | 89 | 53,106 | 0 | Physics, rendering | [R14.3](/docs/entities/objects/props-and-doors.md) |
| `.ycd` | Clip dictionary (animations) | 24,692 | 11,102 | 88 | 13,502 | 0 | Animation | R13.4 |
| `.ydd` | Drawable dictionary (ped parts, grouped models) | 22,939 | 11,551 | 112 | 11,276 | 0 | Peds, rendering | [R6.3](/docs/entities/peds/appearance-and-clothing.md) |
| `.gxt2` | Text block | 19,373 | 7,357 | 8,053 | 3,963 | 0 | UI | [R8.3](/docs/ui/text-labels.md) |
| `.ymap` | Map placements | 19,366 | 4,601 | 2,975 | 11,790 | 0 | World | [R4.6](/docs/world/map-data.md) |
| `.ybn` | Static collision bounds | 15,124 | 8,709 | 1,052 | 5,363 | 0 | Physics | [R2.1](/docs/physics/collision-and-materials.md) |
| `.ynv` | Navmesh tile | 10,038 | 4,420 | 0 | 5,618 | 0 | AI navigation | [R17.5](/docs/ai/navigation.md) |
| `.awc` | Audio wave container | 7,706 | 24 | 10 | 3,380 | 4,292 | Audio | [R9.1](/docs/audio/how-audio-is-organised.md) |
| `.yvr` | Vehicle recording (recorded routes) | 7,511 | 3,718 | 3,779 | 14 | 0 | AI driving | [R3.3](/docs/ai/driving.md) |
| `.rpf` | Nested archive | 5,114 | 1,455 | 253 | 3,406 | 0 | Content system | [R1.6](/docs/core/archives-and-content.md) |
| `.ymt` | Metadata (binary resource): peds, personalities, scenarios, tunables | 4,693 | 1,233 | 734 | 2,255 | 471 | Many | [R17.3](/docs/ai/decisions-and-personalities.md) |
| `.ytyp` | Archetype definitions | 2,744 | 911 | 39 | 1,794 | 0 | World, props | [R14.3](/docs/entities/objects/props-and-doors.md) |
| `.meta` | Metadata (XML): vehicles, weapons, handling, dispatch, content | 1,925 | 519 | 453 | 953 | 0 | Many | [R2.2](/docs/physics/vehicle-handling.md) |
| `.ymf` | Map manifest (LOD and interior links) | 1,778 | 833 | 63 | 882 | 0 | World | [R4.6](/docs/world/map-data.md) |
| `.ywr` | Waypoint recording (ped routes) | 1,600 | 749 | 851 | 0 | 0 | AI | [R17.5](/docs/ai/navigation.md) |
| `.ugc` | Mission or content file (JSON) | 1,466 | 465 | 1,001 | 0 | 0 | Online jobs | [R7.4](/file-formats/ugc-json.md) |
| `.fxc` | Compiled shader | 1,446 | 321 | 1,125 | 0 | 0 | Rendering | [R13.1](/docs/rendering/rendering-and-visual-settings.md) |
| `.ypt` | Particle effects dictionary | 1,228 | 169 | 491 | 568 | 0 | Effects | [R13.3](/docs/rendering/particles-and-decals.md) |
| `.gfx` | Scaleform movie | 1,152 | 510 | 614 | 28 | 0 | UI | [R8.2](/docs/ui/scaleform.md) |
| `.ysc` | Compiled script | 1,147 | 4 | 1,143 | 0 | 0 | Scripts | [YSC format](/file-formats/ysc.md) |
| `.ynd` | Road path nodes | 1,027 | 753 | 274 | 0 | 0 | AI driving | [R17.5](/docs/ai/navigation.md) |
| `.xml` | Data (XML): content.xml, setup2.xml, UI layouts | 904 | 384 | 152 | 368 | 0 | Many | [R1.6](/docs/core/archives-and-content.md) |
| `.cut` | Cutscene definition | 807 | 465 | 0 | 342 | 0 | Cutscenes | [R5.6](/docs/gameplay/missions/cutscenes-and-dialogue.md) |
| `.sps` | Shader preset | 417 | 391 | 26 | 0 | 0 | Rendering | R13.1 |
| `.bik` | Bink video | 411 | 52 | 1 | 358 | 0 | Video |  |
| `.rel` | Audio configuration (`.dat*.rel`) | 254 | 40 | 13 | 184 | 17 | Audio | [R9.1](/docs/audio/how-audio-is-organised.md) |
| `.dat` | Data (text or binary): timecycles, hud colours, materials | 243 | 54 | 47 | 142 | 0 | Many | [R8.4](/docs/ui/hud-colours-blips.md) |
| `.yed` | Expression dictionary (facial expressions) | 242 | 165 | 12 | 65 | 0 | Animation | R13.4 |
| `.nametable` | Audio name table | 224 | 40 | 0 | 184 | 0 | Audio | [R9.1](/docs/audio/how-audio-is-organised.md) |
| `.mrf` | Move network (animation state graph) | 162 | 99 | 35 | 28 | 0 | Animation | R13.4 |
| `.txt` | Text lists | 65 | 24 | 14 | 26 | 1 | Various |  |
| `.yld` | Cloth data | 61 | 53 | 0 | 8 | 0 | Physics |  |
| `.ypdb` | Pose matcher database | 56 | 28 | 0 | 28 | 0 | Animation | R13.4 |
| `.dat54, .dat151, .dat10, .dat15, .dat4, .dat150, .dat149` | Audio data before packing into `.rel` | 224 | 40 | 0 | 184 | 0 | Audio | [R9.1](/docs/audio/how-audio-is-organised.md) |
| `.ipl` | Old-style placement list | 19 | 15 | 4 | 0 | 0 | World | [R4.5](/docs/world/interiors-and-ipls.md) |

Rare types (under 10 files each): `.dds` and `.bmp`, `.jpg`, `.png` images (8, 3, 1, 1), `.patch` (5), `.list` (5), `.yfd` frame filters (4), `.ybd` bound dictionaries (4), `.srl` streaming request lists (3), `.pso` (2), `.ide` (2), `.ypl` (1), `.json` (1), and one file with no extension.

## 41.3 Where the work is

- **DLC packs hold most of the game by count:** 53,106 of the 59,342 fragments (vehicles and breakable props) and 50,979 of the texture dictionaries are in DLC packs, because every pack ships its vehicles and clothing as models and textures ([DLC packs](/docs/entities/vehicles/dlc-packs.md)).
- **The update archives carry the logic:** nearly all scripts (1,143 `.ysc`), most text (8,053 `.gxt2`), the job files (1,001 `.ugc`), most shaders (1,125 `.fxc`) and the newest data files. That's why an update mostly replaces `update.rpf` and `update2.rpf` ([surviving updates](/docs/core/surviving-updates.md)).
- **Navmeshes and road nodes:** 4,420 navmesh tiles in the base, 5,618 in DLC packs; road nodes only in the base (753) and update (274) ([navigation](/docs/ai/navigation.md)).

## 41.4 What this means for modders

- **To find a file,** look up its type here, then its guide; the guide says which archive and folder.
- **Add-on content** ships the same kinds of files in its own DLC pack: models (`.ydr`, `.yft`, `.ydd`), textures (`.ytd`), placements (`.ymap`, `.ytyp`), data (`.meta`), registered in `content.xml` ([R1.6](/docs/core/archives-and-content.md)).
- **Topics without a guide yet:** animation files (`.ycd`, `.yed`, `.mrf`, `.ypdb`) are R13.4.

## 41.5 Open questions

| Question | Where it goes |
| --- | --- |
| Reliable sizes per type (audio sizes read as zero) | Second pass, read sizes from the resource headers |
| A per-pack breakdown for all 89 DLC packs | Second pass, with [DLC packs](/docs/entities/vehicles/dlc-packs.md) |
| How the update's copies override the base ones, type by type | R1.6 second pass |

## 41.6 Test cards

None: this is an inventory of files.
