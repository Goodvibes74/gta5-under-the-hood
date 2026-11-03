# Archive and data file atlas

Every archive in a build 1.0.3725.0 Legacy install and every kind of file inside them: how many of each, where they sit (base archives, the update archives, the 89 DLC packs, the audio archives), what each kind is, which engine system reads it, and which guide covers it. Roadmap topic **R0.7** in the [roadmap](/ROADMAP.md). Builds on [RPF archives](/file-formats/rpf.md) and [archives and the content system](/docs/core/archives-and-content.md) (R1.6).

**How it was made.** A read-only PowerShell script (the same approach as [`tools/update-check.ps1`](/tools/README.md)) opened every `.rpf` in the game folder, `update\`, `x64\` and `update\x64\dlcpacks\` with CodeWalker's library, walked all nested archives, and counted every file entry by extension and by where its top archive lives. It ran in 21 seconds. Counts are **Verified**. What each file type is and which system reads it are **Known** (CodeWalker's formats and the finished guides); sizes from the archive headers are reliable for most types but not for audio containers, so sizes are left out. The leftovers pass added them ([sizes](#sizes-per-type-leftovers-pass)).

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

### Sizes per type (leftovers pass)

**Verified**, from a second listing of every archive with the same library that also read each entry's sizes (389,555 files; the 5,114 nested archives are left out of the sums so nothing is counted twice). The entries add up to **118.6 GB**, against 118.7 GB for the 176 archive files on disk (the rest is archive headers), and the `x64\audio` archives match to the megabyte (16.66 GB), so the sizes are complete.

**Why audio read as zero.** An archive entry is one of two kinds. A *resource* (models, textures, maps, scripts, `.ymt` resources) carries its unpacked size in two header numbers (system and graphics memory) and is always compressed in the archive. A *binary* entry (audio, video, XML, text) carries a compressed size and an unpacked size, and the compressed size is **0 when the file is stored without compression**. All 7,706 `.awc` and all 411 `.bik` files are stored that way, so their real size is the unpacked one. The first listing read only the compressed size.

| Type | Files | Size in the archives | Unpacked | Average in the archive |
| --- | ---: | ---: | ---: | ---: |
| `.awc` audio | 7,706 | 42.1 GB | 42.1 GB (stored, not compressed) | 5.6 MB |
| `.ytd` textures | 88,558 | 34.7 GB | 82.0 GB | 411 KB |
| `.ydr` drawables | 85,456 | 14.5 GB | 35.9 GB | 178 KB |
| `.yft` fragments | 59,342 | 12.7 GB | 68.3 GB | 225 KB |
| `.ydd` drawable dictionaries | 22,939 | 4.1 GB | 10.3 GB | 187 KB |
| `.bik` video | 411 | 3.3 GB | 3.3 GB (stored) | 8.3 MB |
| `.ybn` collision | 15,124 | 2.4 GB | 3.5 GB | 169 KB |
| `.ycd` animation | 24,692 | 2.4 GB | 3.3 GB | 102 KB |
| `.ynv` navmesh | 10,038 | 869 MB | 1.7 GB | 89 KB |
| `.ymap` placements | 19,366 | 599 MB | 1.2 GB | 32 KB |
| `.ysc` scripts | 1,147 | 368 MB | 949 MB | 328 KB |
| `.gxt2` text | 19,373 | 154 MB | 337 MB | 8 KB |
| `.ypt` particles | 1,228 | 96 MB | 524 MB | 80 KB |
| `.fxc` shaders | 1,446 | 37 MB | 389 MB | 26 KB |
| Everything else | 27,615 | 182 MB | 953 MB | |

So audio is the biggest single type on disk (about 36% of the 118.6 GB), and textures are the biggest once unpacked (82 of 255 GB). By location: base archives 36.7 GB, update archives 2.3 GB, DLC packs 63.0 GB, `x64\audio` 16.7 GB.

### The 89 DLC packs (leftovers pass)

**Verified**, the same listing, one row per pack in `update\x64\dlcpacks` (file counts without nested archives; sizes as stored). What each pack added in game is in [DLC packs](/docs/entities/vehicles/dlc-packs.md).

| Pack | Files | Size (MB) | Most files by type |
| --- | ---: | ---: | --- |
| `mpheist4` | 11,383 | 7,888 | .ydr 2815, .ytd 2312, .ybn 1872 |
| `mpbattle` | 3,983 | 4,742 | .ytd 1486, .ydr 751, .yft 555 |
| `mptuner` | 7,485 | 3,365 | .yft 3995, .ytd 1184, .ydr 792 |
| `mpsecurity` | 6,492 | 3,134 | .ytd 1499, .ydr 1394, .yft 1360 |
| `mpchristmas2018` | 6,826 | 3,095 | .yft 2668, .ytd 2440, .ydr 951 |
| `mpheist` | 12,826 | 2,907 | .ymap 3565, .ytd 2053, .ybn 2006 |
| `mpchristmas2017` | 6,701 | 2,293 | .ytd 2194, .ydr 1555, .yft 1458 |
| `mpheist3` | 6,512 | 2,266 | .ytd 1650, .ydr 1512, .yft 1443 |
| `patchday3ng` | 2,511 | 2,148 | .ytd 658, .yft 318, .ydd 310 |
| `mp2025_02` | 4,152 | 1,816 | .ydr 1074, .yft 856, .ycd 612 |
| `mpgunrunning` | 7,187 | 1,791 | .ytd 4588, .ydr 843, .yft 707 |
| `mpchristmas3` | 5,832 | 1,737 | .ytd 2307, .yft 1285, .ydr 598 |
| `mpbiker` | 5,012 | 1,709 | .ytd 1956, .ydr 1056, .yft 957 |
| `mp2025_01` | 3,547 | 1,709 | .yft 1691, .ynv 511, .ytd 334 |
| `mpvinewood` | 7,470 | 1,614 | .ytd 2209, .ycd 1603, .yft 1314 |
| `mp2023_02` | 5,273 | 1,529 | .yft 1701, .ytd 1216, .ydr 619 |
| `mpsum2` | 5,311 | 1,186 | .yft 2702, .ytd 1375, .ynv 410 |
| `mp2024_02` | 3,553 | 1,128 | .yft 1052, .ytd 799, .ynv 499 |
| `mp2024_01` | 4,208 | 1,123 | .yft 1485, .ytd 927, .ydr 548 |
| `patchday21ng` | 1,402 | 1,065 | .yft 1146, .ytd 170, .ycd 29 |
| `mplowrider` | 3,343 | 1,037 | .yft 959, .ymap 604, .ytd 448 |
| `mpsum` | 4,033 | 934 | .yft 1603, .ytd 1389, .ydr 552 |
| `mpsmuggler` | 3,082 | 928 | .ytd 1999, .yft 422, .ydr 168 |
| `mpimportexport` | 3,605 | 872 | .ytd 1430, .yft 1098, .ydr 432 |
| `mp2023_01` | 3,781 | 771 | .ytd 1336, .yft 929, .ynv 412 |
| `patchday2ng` | 5,282 | 766 | .ymap 2649, .ycd 964, .ytyp 489 |
| `mpexecutive` | 2,680 | 764 | .ydr 1258, .ytd 823, .ydd 126 |
| `patchday19ng` | 1,643 | 730 | .yft 1134, .ytd 250, .bik 182 |
| `patchday22ng` | 3,214 | 661 | .ytd 1297, .ycd 782, .ydr 628 |
| `mpapartment` | 3,940 | 606 | .ydr 1395, .ymap 705, .ytd 704 |
| `patch2025_01` | 2,119 | 551 | .yft 1994, .ytd 84, .ydd 26 |
| `patchday26ng` | 2,689 | 504 | .yft 2270, .ydd 176, .ytd 176 |
| `patchday1ng` | 4,882 | 444 | .ymap 1728, .ycd 973, .ytd 805 |
| `patchday20ng` | 277 | 436 | .bik 95, .yft 88, .ydd 40 |
| `mppatchesng` | 2,502 | 417 | .ytd 1123, .ydd 852, .ycd 263 |
| `mpreplay` | 175 | 410 | .awc 147, .ydd 6, .ytd 6 |
| `patchday24ng` | 1,436 | 366 | .ycd 820, .yft 533, .ydd 38 |
| `patchday8ng` | 807 | 348 | .ytd 355, .ydr 312, .ydd 52 |
| `patch2024_01` | 1,897 | 336 | .yft 1808, .ydd 42, .ytd 38 |
| `mpstunt` | 1,683 | 331 | .ytd 1020, .ydr 262, .yft 185 |
| `mplowrider2` | 1,298 | 318 | .yft 552, .ytd 319, .ydr 229 |
| `patchday27ng` | 2,574 | 314 | .ymap 953, .yft 916, .ytyp 166 |
| `patch2025_02` | 2,173 | 314 | .yft 2147, .ytd 17, .ydd 4 |
| `mpassault` | 985 | 300 | .yft 736, .ytd 112, .awc 38 |
| `patchday4ng` | 1,441 | 298 | .ytd 822, .ydd 250, .ydr 177 |
| `patch2024_02` | 1,092 | 228 | .yft 1039, .ytd 25, .ydd 16 |
| `mpluxe` | 1,033 | 215 | .ytd 623, .ydd 137, .ydr 92 |
| `patchday28ng` | 770 | 168 | .yft 655, .ytd 60, .ydd 28 |
| `patchday9ng` | 1,060 | 153 | .yft 784, .ytd 114, .ycd 97 |
| `patchday12ng` | 560 | 148 | .ydr 324, .ytd 77, .ydd 65 |
| `mpjanuary2016` | 1,378 | 142 | .ytd 897, .yft 322, .ydd 92 |
| `patchday13ng` | 599 | 138 | .yft 334, .ydd 91, .ydr 66 |
| `patch2023_01` | 531 | 135 | .yft 222, .ydd 219, .ymt 48 |
| `mpluxe2` | 625 | 100 | .ytd 343, .ydd 121, .yft 65 |
| `mphalloween` | 370 | 100 | .ytd 127, .awc 109, .ycd 30 |
| `patchday25ng` | 224 | 90 | .yft 145, .ydd 47, .ymt 13 |
| `patchday10ng` | 368 | 90 | .yft 180, .ytd 56, .ydr 44 |
| `patchday14ng` | 855 | 88 | .yft 378, .ydr 169, .ytd 130 |
| `patchday23ng` | 490 | 86 | .yft 395, .ydd 54, .ytd 29 |
| `mpairraces` | 612 | 78 | .ytd 376, .ydr 118, .ydd 30 |
| `mpspecialraces` | 421 | 75 | .yft 202, .ydr 103, .ytd 32 |
| `mpchristmas2` | 446 | 61 | .ytd 250, .yft 64, .ydd 50 |
| `patchday17ng` | 104 | 57 | .yft 41, .ycd 18, .ydd 15 |
| `patchday15ng` | 365 | 45 | .ytd 221, .ydd 62, .yft 42 |
| `mpxmas_604490` | 303 | 44 | .ytd 180, .ydd 42, .yft 29 |
| `patchday7ng` | 74 | 42 | .ytd 23, .ydd 19, .ydr 8 |
| `patchday2bng` | 51 | 38 | .ycd 23, .awc 11, .ytd 6 |
| `patchday6ng` | 54 | 30 | .ydd 13, .ymt 12, .yft 10 |
| `mpvalentines2` | 259 | 24 | .ytd 163, .yft 30, .ydd 23 |
| `mp2024_01_g9ec` | 50 | 22 | .yft 19, .ydr 15, .xml 3 |
| `patchdayg9ecng` | 68 | 16 | .yft 57, .ytd 6, .xml 3 |
| `patch2023_02` | 81 | 12 | .ydd 50, .ymt 20, .ytd 6 |
| `patchday16ng` | 93 | 11 | .yft 36, .ydd 16, .ycd 12 |
| `patchday11ng` | 62 | 9 | .ycd 27, .ydd 13, .ytd 11 |
| `patchday5ng` | 26 | 7 | .yft 6, .ycd 6, .ytd 5 |
| `patchday18ng` | 15 | 4 | .ycd 8, .xml 2, .yft 2 |
| `mpg9ec` | 764 | 1 | .yft 456, .ytd 191, .ydd 32 |
| `mp2023_01_g9ec` | 90 | 1 | .yft 53, .ydr 10, .ybn 7 |
| `mp2023_02_g9ec` | 111 | <1 | .ydr 54, .yft 33, .ymap 5 |
| `mpsum2_g9ec` | 208 | <1 | .ytd 87, .ydd 65, .yft 29 |
| `patchday27g9ecng` | 167 | <1 | .yft 163, .xml 2, .ytd 2 |
| `patch2025_02_g9ec` | 80 | <1 | .yft 78, .xml 2 |
| `mpchristmas3_g9ec` | 106 | <1 | .yft 57, .ytd 45, .xml 2 |
| `mp2025_02_g9ec` | 66 | <1 | .ydr 36, .yft 25, .xml 2 |
| `mp2025_01_g9ec` | 37 | <1 | .yft 35, .xml 2 |
| `mp2024_02_g9ec` | 43 | <1 | .yft 22, .meta 8, .ydr 7 |
| `patch2024_01_g9ec` | 26 | <1 | .yft 24, .xml 2 |
| `patch2023_01_g9ec` | 13 | <1 | .ydd 9, .xml 2, .ymt 2 |
| `patchday28g9ecng` | 6 | <1 | .xml 2, .yft 2, .ymf 1 |

- **The heists are the heavy packs:** `mpheist4` (Cayo Perico, 7.7 GB) and `mpbattle` (nightclubs, 4.6 GB) lead by size, `mpheist` (the 2015 heists) by file count (12,826, led by 3,565 map placements).
- **Patch packs are mostly vehicles:** `patch2025_01`, `patch2024_01`, `patch2025_02`, `patchday26ng` are 84 to 99% `.yft` fragments (vehicle fixes); `patchday2ng` and `patchday1ng` patch the map (`.ymap`, `.ytyp`).
- **The 15 Expanded & Enhanced (`g9ec`) packs are almost empty on Legacy:** 1,835 files in 42 MB together (half of it one interior in `mp2024_01_g9ec`), with fragments averaging 10 KB against 225 KB for all fragments. Our reading: they are mostly placeholders so the pack list matches the newer edition, and the real models live in the matching non-`g9ec` pack.
- **Ten early packs sit inside the base archives**, not in `update\x64\dlcpacks`: `mpbusiness`, `mphipster`, `mplts`, `mppilot`, `mpbusiness2`, `mpvalentines`, `mpbeach`, `mpindependence`, `spupgrade` and `mpchristmas` (7,512 files). `mppilot` holds the only 4 base `.ysc` files, the old pilot school scripts.

### How the update overrides the base (leftovers pass)

**Verified**, every file in `update.rpf` and `update2.rpf` matched against the base archives by its path inside the archive (`common.rpf` paths under `common\`, `x64*.rpf` paths under `x64\`):

| How an update file relates to the base | Files | Types |
| --- | ---: | --- |
| Same path as a base file (a straight replacement) | 14,893 | `.gxt2` 7,224, `.yvr` 3,690, `.ytd` 1,860, `.ywr` 749, `.fxc` 321, `.gfx` 266, `.ynd` 259, `.ymap` 200 (LOD lights), `.ymt` 131, `.meta` 76 |
| In a `dlc_patch\<pack>` folder (patches a DLC pack, not the base) | 7,441 | `.ymap` 2,773, `.ydr` 1,613, `.ybn` 1,052, `.ytd` 897, `.meta` 349; for 56 packs, `mpheist` alone 3,693 |
| Same file name, another path | 1,672 | `.fxc` 642 (shaders moved), `.gxt2` 617, `.ypt` 320 |
| New, no base copy | 5,377 | `.ysc` 1,142, `.ytd` 1,722, `.ugc` 1,001, `.ymt` 602, `.gfx` 322 |

So by type: **text, vehicle and waypoint recordings, road nodes, shaders and data files replace their base copy by path**; **map files, models and collision in the update are almost all `dlc_patch` files** for DLC packs, never replacements of base map files (except the 200 LOD-light `.ymap`s); and **every script is new**, because the base has no story or Online scripts at all, only the 4 old pilot-school ones. `update2.rpf` and `update.rpf` share just 1 file (a `.ymt`), so the two update archives never override each other. *Known:* a streamed asset (model, texture, collision) is found by name, so a same-name file in a later archive or pack wins even at another path ([archives and content](/docs/core/archives-and-content.md)).

## 41.4 What this means for modders

- **To find a file,** look up its type here, then its guide; the guide says which archive and folder.
- **Add-on content** ships the same kinds of files in its own DLC pack: models (`.ydr`, `.yft`, `.ydd`), textures (`.ytd`), placements (`.ymap`, `.ytyp`), data (`.meta`), registered in `content.xml` ([R1.6](/docs/core/archives-and-content.md)).
- **Topics without a guide yet:** animation files (`.ycd`, `.yed`, `.mrf`, `.ypdb`) are R13.4.

## 41.5 Open questions

| Question | Where it goes |
| --- | --- |
| Reliable sizes per type (audio sizes read as zero) | Answered in [sizes per type](#sizes-per-type-leftovers-pass): stored files have a compressed size of 0 |
| A per-pack breakdown for all 89 DLC packs | Answered in [the 89 DLC packs](#the-89-dlc-packs-leftovers-pass) |
| How the update's copies override the base ones, type by type | Answered in [how the update overrides the base](#how-the-update-overrides-the-base-leftovers-pass) |

## 41.6 Test cards

None: this is an inventory of files.
