# UGC mission files (JSON) and who reads them

The JSON format of GTA Online's jobs and content: the 1,001 local `.ugc` files, the two families inside them (classic creator missions and the newer "content" files), their sections and key counts, and which scripts read each family. Roadmap topic **R7.4** in the [roadmap](/ROADMAP.md). Extends [Online data files](/docs/online/03-online-data-files.md) (file list and prefixes).

**How it was made.** All 1,001 files in `update\update2.rpf\common\data\ugc\` extracted with [`tools/rpf-cw.ps1`](/tools/README.md) (24 MB) and every key path counted with the read-only [`tools/ugc-keys.ps1`](/tools/README.md#ugc-keysps1-every-key-in-the-mission-files) (arrays collapsed to `[]`; about 5 minutes). Readers found by searching the build-3725 decompile (commit `6c18d3e8b`) for the section names as string arguments. Key paths and counts are **Verified**; what a short key means is **Known** where the name makes it plain and marked *probable* where it's a guess. First pass: the per-key meaning of the 8,472 `gen` keys and of the content sections is for later passes.

## 11.1 Short version

- **16,500 distinct key paths** across the 1,001 files; all parse as JSON.
- **Two families share the `.ugc` extension:**
  - **Content files (about 980):** short sections such as `me`, `pd`, `pp`, `vh`, `ptrl`, `port`, `tot`, `sro`, `amb`, `gt`, `pop`, `ta`, each a count plus a list (`vh`: `num`, `veh`, `trlr`; `pd`: `num`, `pds`, `grp`, `asp`; `pp`: `num`, `prps`; `ptrl`: `num`, `pat`). These are the freemode content jobs (random events, salvage, dispatch, seasonal jobs ...).
  - **Classic creator missions (16):** the mission-creator layout with `gen` (8,472 distinct key paths on its own), `rule` (22), `ene` (466), `obj` (169), `veh` (258), `prop` (80), `dprop` (57), `weap` (48), `zone` (39), `goto` (194), `endcon` (833), `cover`, `door`, `kill`, `cuts`, `mocap`, `invty`. These are the Cayo Perico finale (13 languages), "Learning the Ropes" and "All or Nothing" ([Online data files](/docs/online/03-online-data-files.md)).
- **The families have different readers:**
  - Content files: **85 `fm_content_*` scripts**, plus `am_launcher` and `freemode`, which all read sections such as `ptrl` through a shared helper.
  - Classic missions: the creators (`creator`, `fm_capture_creator`, `fm_deathmatch_creator`, `fm_lts_creator`, `fm_race_creator`, `fm_survival_creator`, `public_mission_creator`), the job lobby (`fmmc_launcher`), `fmmc_playlist_controller`, `net_cloud_mission_loader`, `appmpjoblistnew` and `pausemenu_multiplayer` read `rule`, `ene` and `endcon`. `gen` is also read by the controllers that play jobs (`fm_mission_controller`, `fm_mission_controller_2020`, the race, deathmatch and horde controllers).
- **Plus a few odd files:** DJ dance animation sets (`djanim*`, `dancer*anim`), an `audio` section in 5 files, 17 files with `debugOnlyVersion`.

## 11.2 Classic creator missions

| Section | Key paths | What it holds |
| --- | ---: | --- |
| `gen` | 8,472 | General settings: title (`nm`), description, type, team counts, spawn and start points, many per-team arrays |
| `rule` | 22 | Mode rules: `aim`, `apeds`, `blip`, `liv`, `pol` (police), `prule`, `ptyp`, `radio`, `score`, `tag`, `tdm`, `time`, `tod` (time of day), `traf` (traffic), `vdm`, `vehd`, `voice`, `alW`, `alWC`, `weth` (weather), `wethec` |
| `ene` | 466 | Enemies (peds): models, positions, weapons, behaviour, teams |
| `veh` | 258 | Vehicles |
| `obj` | 169 | Objectives (objects to collect or deliver) |
| `prop`, `dprop`, `dhprop` | 80, 57, 5 | Props, dynamic props, *probable* destructible props |
| `weap` | 48 | Weapon pickups |
| `zone`, `otzone` | 39, 8 | Zones (areas with rules) |
| `goto` | 194 | Go-to locations |
| `endcon` | 833 | End conditions and end positions |
| `cover`, `door`, `kill` | 7, 6, 12 | Cover points, doors, kill targets |
| `cuts`, `mocap` | 26, 12 | Cutscenes |
| `invty` | 61 | *probable* inventory (player loadouts) |
| `ddblip`, `ddtrig`, `fsp`, `interactables`, `vhrls`, `usj`, `tmD`, `dtmp*`, `ptemp` | 1 to 21 each | Smaller systems (blips, triggers, unique stunt jumps `usj` ...) |
| `meta` (top level) | 11 | Locations, vehicle hashes, weapons used (a summary for the job list) |

## 11.3 Content files

| Section | Files | Key paths | Shape (keys under it) |
| --- | ---: | ---: | --- |
| `me` | 980 | 19 | *probable* mission entities or metadata |
| `pd` | 980 | 37 | Peds: `num`, `pds` (list), `grp`, `asp` |
| `pp` | 980 | 16 | Props: `num`, `prps` |
| `vh` | 980 | 18 | Vehicles: `num`, `veh`, `trlr` (trailers) |
| `sro` | 980 | 2 | *probable* scripted objects |
| `amb`, `gt`, `pop`, `ta` | 979 | 11 to 13 | *probable* ambience, gates, population, targets |
| `ptrl` | 979 | 105 | Patrols: `num`, `pat` (routes) |
| `cst`, `inte`, `mvdr`, `anims`, `fcs`, `la`, `port`, `seccam`, `tot`, `fmnm` | 934 to 940 | 1 to 66 | Cutscenes, interiors, *probable* moving doors, animations, *probable* focus cams, *probable* look-at, portals, security cameras, *probable* totals, name |
| `tags`, `modt`, `want`, `sear`, `chpts`, `sp`, `fmbs` | 515 to 883 | 1 to 17 | Tags, *probable* mod types, wanted settings, search areas, checkpoints, spawn points, *probable* freemode bounds |

The content format is built for scripts: each section gives a count first and then a list, so a controller can loop without parsing names.

## 11.4 What this means for modders

- **The content files are the easier format to play back:** fixed short sections, a count and a list each. A mission player can start with `vh`, `pd`, `pp` and `ptrl` (vehicles, peds, props, patrols) and grow from there.
- **The 16 classic missions are the hard format:** `gen` alone has 8,472 key paths; rules, objectives and end conditions depend on team and rule numbers.
- **A mission player for an offline mod:** start with content files of one family (`re_` random events, 180 files) and read the matching `fm_content_*` script for how each section is used; leave the classic format for later.

## 11.5 Open questions

| Question | Where it goes |
| --- | --- |
| Meaning of each content section key (`me`, `sro`, `amb`, `gt`, `ta`, `tot`, `mvdr` ...), from the `fm_content_*` helper that reads them | Second pass, with one `re_` file and its script |
| The `gen` keys (8,472 paths): which ones `fm_mission_controller` actually reads | Second pass |
| How the controller picks rules per team and stage | R7.5 (job lobby) and a second pass |

## 11.6 Test cards

None: everything is read from files and scripts.
