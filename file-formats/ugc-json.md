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

How the creators write these sections (the `prop`, `race` and `dhprop` columns, sparse arrays, the upload) is in [Rockstar Creator internals](/docs/online/creator-internals.md) (R7.11).

## 11.3 Content files

| Section | Files | Key paths | Shape (keys under it) |
| --- | ---: | ---: | --- |
| `me` | 980 | 19 | Mission entities: `ents` (model `mn`, `pos`, `rot`, `head`, `int`, `cv`, `crt`) and their blips (`blp`) |
| `pd` | 980 | 37 | Peds: `num`, `pds` (list), `grp`, `asp` |
| `pp` | 980 | 16 | Props: `num`, `prps` |
| `vh` | 980 | 18 | Vehicles: `num`, `veh`, `trlr` (trailers) |
| `sro` | 980 | 2 | A list of up to 30 short strings (`name`) that other entries point to by index; *probable* a shared string table |
| `amb`, `gt`, `pop`, `ta` | 979 | 11 to 13 | *probable* ambience, gates, population, targets |
| `ptrl` | 979 | 105 | Patrols: `num`, `pat` (routes) |
| `cst`, `inte`, `mvdr`, `anims`, `fcs`, `la`, `port`, `seccam`, `tot`, `fmnm` | 934 to 940 | 1 to 66 | Cutscenes, interiors, *probable* moving doors, animations, *probable* focus cams, *probable* look-at, portals, security cameras, *probable* totals, name |
| `tags`, `modt`, `want`, `sear`, `chpts`, `sp`, `fmbs` | 515 to 883 | 1 to 17 | Tags, *probable* mod types, wanted settings, search areas, checkpoints, spawn points, *probable* freemode bounds |

**What the scripts read** (*leftovers pass*, **Verified** in `fm_content_bounty_targets`, build 3725 decompile). One loader function opens every section by name, then its sub-lists: `me` (`blp`, `ents`), `pd` (`pds`, `grp` with `rel` relationships and `trg` triggers), `vh` (`veh`, `blp`), `pp` (`prps`), `want`, `modt`, `amb` (`veh`, read by index `idx`: ambient vehicles), `gt` (`loc`: go-to locations with `pos`, `rad`, `brd`, `blp`), `tot` (`tohud` with `brtyp`, `brtit`, `brmax`, `brord`, and `tar`: targets and how they show on the HUD), `cst` (`csts`: `vcst` and `hcst`, *probable* vehicle and heli costs), `pop` (`blkr`: population blockers with `typ`, `min`, `max`, `rad`), `inte` (`int`), `ta` (`ars`: areas with `vmn`, `vmx`, `fwd`), `sear` (`area`, `blp`: search areas), `ptrl` (`pat`, `nd`: patrol routes and nodes), `mvdr` (`mvdrs`: a model `mn` with a start `pos`/`rot` and an end `epos`/`erot`, so moving objects such as doors or lifts), `fcs` (`fcs`: `feid`, `ftyp`, `frng`, `fvec`, *probable* focus points), `sro` (`name`), `seccam` (`seccams`), `port`, `tags` (`tag`) and `fmbs`. The same key strings appear across the content scripts (mostly `fm_content_*`, plus `am_launcher`): `me`, `gt` and `ta` in 87 decompiled scripts, `sro` in 55, `amb` in 49, `tot` in 33 and `mvdr` in 17 (a count of files containing the quoted string).

The content format is built for scripts: each section gives a count first and then a list, so a controller can loop without parsing names.

### 11.3.1 Rules per team and stage (leftovers pass)

*Leftovers pass, 2026-11-04.* **Verified** in `fmmc_launcher` (the loader the controllers share) and `fm_mission_controller_2020`, build 1.0.3725.0. The C-style names below are ours; the keys are the file's.

**Teams and rules.** A classic mission has up to four teams, each with its own list of rules: the steps it has to complete, in order. `endcon` → `nrl` gives each team's rule count. The arrays that hold a rule's settings are sized for **17 rules per team** (0 to 16). Each team's settings fill one 26,968-value block of the mission global, and each rule has 67 per-rule keys, read as `<key>` plus the team number. Examples:

- timers: `tmt`, `ttime`, `timelim`;
- wanted level: `wntchng`, `wntforc`, `mxwl`, `wntdlay`;
- gang backup: `gbtp`, `gbnum`, `gbdelay`, `gbmax`, `gbaccur` and more;
- objective texts: `txt`, `1txt` to `5txt`;
- rule option bitsets: `irbs` and `irbs2` to `irbs18`;
- bounds (play areas): `bndtype`, `bndtime`, `bndtxt`;
- branching: `nxtrulb`.

**How each entity is tied to a rule.** Every enemy (`ene`), vehicle (`veh`), object (`obj`) and location (`goto`) carries two arrays per team:

- `rule<team>` says what that team must do with the entity. 0 or 99999 means nothing. Locations name it `rl<team>`.
- `pri<team>` says which of the team's rules (0 to 16) it belongs to, or -1 for none.

So one van can be "deliver" on the attackers' rule 2 and "protect" on the defenders' rule 1. The rule-type numbers have creator labels (`PMC_RULE1` for 0, `PMC_RULE2` for 1, `PMC_RULE3`/`3B` for 2, `PMC_RULE4` for 3, `PMC_RULE6` for 4, `PMC_RULE7`/`7B` for 5, then 11, 13, 16, 23, 24, 31, 32 and 36). Their English text is in the game's text files, not the scripts.

**How the controller moves through rules.** The controller keeps a current rule for each team. When it changes, the controller resets that team's per-rule timers and reads the new rule's settings. If the new rule has an `nxtrulb` value, that value is a bitset of rule numbers the team may branch to:

- **One bit set:** that rule is next.
- **Several bits set:** a random one is chosen. All players agree on the choice, because the random seed is shared: the mission's seed when a mission-wide option bit is set, or a per-team seed carried from rule to rule when a rule option bit is set.
- The controller then jumps the team forward to the chosen rule, skipping those in between, or back to an earlier one. A rule option bit can block the branch in one team state.

Without `nxtrulb` the team simply goes on to its next rule (**Known**; the host code that decides a rule is complete was not traced).

## 11.4 What this means for modders

- **The content files are the easier format to play back:** fixed short sections, a count and a list each. A mission player can start with `vh`, `pd`, `pp` and `ptrl` (vehicles, peds, props, patrols) and grow from there.
- **The 16 classic missions are the hard format:** `gen` alone has 8,472 key paths; rules, objectives and end conditions depend on team and rule numbers.
- **A mission player for an offline mod:** start with content files of one family (`re_` random events, 180 files) and read the matching `fm_content_*` script for how each section is used; leave the classic format for later.

## 11.5 Open questions

| Question | Where it goes |
| --- | --- |
| Meaning of each content section key (`me`, `sro`, `amb`, `gt`, `ta`, `tot`, `mvdr` ...), from the `fm_content_*` helper that reads them | Mostly answered in [content files](#113-content-files): the sub-keys each section holds; `sro`, `cst`, `fcs` and `modt` still have a *probable* reading |
| The `gen` keys (8,472 paths): which ones `fm_mission_controller` actually reads | Second pass |
| How the controller picks rules per team and stage | Answered in [11.3.1](#1131-rules-per-team-and-stage-leftovers-pass) (leftovers pass): up to four teams with up to 17 rules each; entities tie to a rule with `rule<team>` and `pri<team>`; `nxtrulb` branches, with a shared random pick. Left: the rule-type texts (game text files) and the host's completion test |

## 11.6 Test cards

None: everything is read from files and scripts.
