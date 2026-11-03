# Data needs: open questions that need game files, not just scripts

The open questions that **can't be answered from the decompiled scripts alone**, grouped by the file to extract. Use it as a shopping list for one CodeWalker session (`tools/rpf-cw.ps1`, see [research tools](/docs/00-getting-started/research-tools.md)): extract everything in a group into a scratch folder outside the repo, then answer the group's questions together. Status and full wording of each question: [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md). Everything else that is still open is listed in [`HANDOFF.md`](/HANDOFF.md) (executable, in-game tests, scripts only).

**Done so far:** batch D1 (2026-11-03) extracted every American text block and every vehicle data file, batch D2 every explosion and weapon file, batch D3 the water files, batch D4 the police and population files, batch D5 the personality and ped files, batch D6 the shop catalogues, batch D7 `gameconfig.xml` and the archive listings, and batch D8 the map data; the rows marked *done, D1* to *D8* below are answered or narrowed, with the result in the linked guide and in `OPEN_QUESTIONS.md`.

How to read the tables:
- **Extract** gives the path as this repo's guides already use it (`common:` = `common.rpf`, `update:` = `update\update.rpf`, DLC = `update\x64\dlcpacks\<pack>\dlc.rpf` and the `dlc_patch` folders in `update.rpf`). Where no guide has given the path yet, it says *find*: list the archives with the tool and search for the file name.
- **Scripts too?** says whether the answer also needs the decompile (commit `6c18d3e8`).
- **Rules:** quote names, numbers and short labels only; never copy the files into the repo; mark results Verified.

## Vehicles

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| GP-045 (*done, D1*) | The `CFlyingHandlingData` block of every DLC aircraft | `handling.meta` in every DLC pack and `dlc_patch` (base: `common:/data/handling.meta`) | no |
| AI-024 | The AI handling profile of every DLC vehicle | the same `handling.meta` files | no |
| PHY-011 | Bit names of the model, handling, damage and advanced flags | the same files, compared across known vehicles; then an in-game check | no |
| PHY-013 | What each `statMods` modifier changes | the same files (`CCarHandlingData` / sub-handling blocks) | no |
| PHY-014 | How `vehicles.meta` fields (`handlingId`, wheel scale, `flags`) interact with handling | `common:/data/levels/gta5/vehicles.meta` and every DLC `vehicles.meta`, with `handling.meta` | no |
| GP-046 (*done, D1*) | What the `SPMED` and `SPSMALL` handling entries belong to | every `vehicles.meta` (`handlingId` column) | no |
| ON-068 (*done, D1*) | Which models the website items 323, 324, 357, 402 are: hashes −994826917, 886151985, −1242692076, −451225720 | every `vehicles.meta` `modelName`, hashed with `joaat` | no (hashes already read from `standard_global_init`) |
| ENT-036 (*done, D1*) | Why 901 models here vs 879 in R14.4 | every `vehicles.meta` | no |
| ENT-037 (*done, D1*) | The less common vehicle flags | every `vehicles.meta` `flags` | no |
| ENT-038 | Light and siren id ranges per DLC pack | every `carcols` file (*find*: `carcols.ymt`/`carcols.meta`) | no |
| ENT-039 | Which `carcols` mod parts each kit links | the same, plus `carvariations.meta` | no |
| REN-011 | How the first-person car interior camera is chosen per vehicle | `update:/x64/data/metadata/cameras.ymt` and `vehicles.meta` (`camVehicleCustomSettingsMetadata`) | no |

## Weapons, explosions, physics

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| GP-078 (*done, D2*) | How story stats and Online rank change the ammo cap | `common:/data/ai/weapons.meta` and DLC weapon files (`AmmoMax`, `AmmoMax50`, `AmmoMax100`, `AmmoMaxMP` ...) | the cap is set by the engine; scripts only read it |
| GP-079, PHY-009 (*done, D2*) | Damage and radius per explosion type, base and the 16 DLC files | `common:/data/explosion.meta` and every DLC explosion file | no |
| PHY-008 (*done, D2*) | The unnamed boolean fields | `update:/x64/data/metadata/explosion.ymt` | no |
| PHY-010 (*done, D2*) | Every DLC projectile and its explosion | DLC weapon files (`AmmoInfo` projectile entries) | no |
| PHY-001 | The two unnamed columns (0.95, 0.0) | `materials.dat` (*find*) | no |
| PHY-004 | The ragdoll and `NATURAL_MOTION` materials | `materials.dat` and the ragdoll / NM files (*find*) | no |
| ENT-017 | Which ragdoll tuning set applies to which weapon and vehicle; three hashed set names | NM tuning files and weapon / vehicle data (*find*) | no |
| ENT-019 | What `nm_blend_out_sets.meta` sets for getting up | `nm_blend_out_sets.meta` (*find*) | no |
| ENT-020 | Where fall damage is set | ped and player data files (`playerinfo.ymt`, ped tuning) | possibly |

## Water

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| PHY-015 (*done, D3*) | What the five water quad types mean | `common:/data/levels/gta5/water.xml` | no |
| PHY-016 (*done, D3*) | The format of `waterheight.dat` | `common:/data/levels/gta5/waterheight.dat` | no |
| PHY-005 | Water collision vs water simulation | `water.xml` and the collision (`.ybn`) data | no |
| PHY-018 (*done, D3*) | Where swimming pools are defined | `water.xml` and map data (`.ymap`) | no |

## Map data (`.ymap`, `.ytyp`, `.ybn`, `.ynv`, `.ynd`, `.ymf`, scenarios)

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| GP-035 (*D8: not found*) | Where the world points (script brains) are placed, and how many per brain | ymap / scenario data for world-point brains | brain names from the scripts (done) |
| ENT-034 (*done, D8*) | Where ambient aircraft and boats on routes come from | vehicle scenarios, `common:/data/ai/scenarios.meta` and the scenario point files | no |
| ENT-028 (*done, D8*) | How many of the 111,898 scenario points are Online-only | scenario point files (availability field) | no |
| ENT-029 (*done, D8*) | The scenario chaining graph format | scenario point files | no |
| ENT-030, ENT-035 (*done, D8*) | Car generator flag bits (3,680, 3,936, 3,616, 1,632) and the unresolved population groups | every `.ymap` with car generators | no |
| ENT-031 (*done, D8*) | Which DLC ymaps with generators load in story mode | DLC ymaps plus the IPL state | the IPL requests in the scripts |
| PHY-002 (*done, D8*) | How many `.ybn` files and how they're grouped | archive listing of `.ybn` | no |
| ENT-001 (*done, D8*) | Archetype flag bits across all `.ytyp` | every `.ytyp` exported to XML | no |
| ENT-002 (*done, D8*) | Which map props are fragments (`.yft`) and how many break | `.ytyp` archetypes and the `.yft` list | no |
| ENT-003 (*done, D8*) | Every rayfire object placed in the map | ymap entity extensions | no |
| WLD-001 (*done, D8*) | Each IPL name and the building it controls | every `.ymap` (match names to IPLs) | the IPL names from the scripts |
| WLD-004 (*done, D8*) | Ymap `flags` values 1, 2, 3 | every `.ymap` | the IPL requests |
| WLD-005 (*done, D8*) | How many entities the story map loads | every `.ymap`, filtered by IPL state | yes |
| WLD-007 (*done, D8*) | How `.ymf` LOD manifests tie ymaps together | the `.ymf` files (*find*) | no |
| AI-027, AI-029 (*done, D8*) | Road nodes, routes; node and link counts, update vs base | `.ynd` files | no |
| AI-028 (*done, D8*) | Polygons, links and cover points per navmesh tile | `.ynv` files | no |
| REN-025 (*done, D8*) | Timecycle boxes and interior room modifiers in the map | ymap timecycle modifiers and interior (`.ytyp` MLO) rooms | no |
| UI-009 | Which `int<number>` interior map belongs to which interior | interior `.ytyp` / ymaps, with the text labels | yes (the map names) |

## Peds, population, AI behaviour

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| AI-011, AI-016 (*done, D5*) | Decode personalities, bravery, driving ability | `update:/x64/data/metadata/pedpersonality.ymt` (PSO to XML) | no |
| AI-017 (*done, D5*) | The 5 unnamed civilian bravery types and the criminality types | the same file, hashed against candidate names | no |
| AI-019 (*done, D5*) | How `MotivationMin/Max` is used | the same file | in-game |
| AI-020 (*done, D5*) | How driving ranges map onto driving tasks | the same file, with the driving guides | no |
| ENT-013 (*done, D5*) | 23 personality hashes and relationship groups that didn't resolve | `pedpersonality.ymt`, the peds and relationship files | hash the script strings |
| AI-014 | The full meaning of `taskdata.meta` and `scriptedguntasks.meta` | both files (*find*) | no |
| AI-033 | How decision makers map each event to a response | `common:/data/events.meta` and the decision-maker files | no |
| AI-034, AI-035 (*done, D4*) | The 9 crime-info entries; crime points per crime | `common:/data/ai/crimeinformation.meta` | in-game test for points |
| AI-036 (*done, D4*) | The police vehicle sets with model names | `common:/data/dispatch.meta` | no |
| AI-009 | Animal models by kind and where each spawns | scenario types and the peds file | no |
| ENT-021 (*done, D4*) | The 5 story schedule hashes that don't match a `popcycle.dat` name | `common:/data/levels/gta5/popcycle.dat` | the hashes come from the scripts |
| ENT-024 (*done, D4*) | The unnamed zone fields (`hash_7111AC8A`, three flags) | `common:/data/levels/gta5/popzone.ipl` and the zone data | no |
| ENT-025 | How bird and fish groups spawn | `popcycle.dat`, population groups | no |
| GP-073 (*done, D4*) | The 5 non-story entries in `PlayerStatInfos` | `update:/x64/data/tune/playerinfo.ymt` (hash candidate names) | no |

## Character appearance and shops

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| GP-081 (*done, D6*) | What each restriction tag blocks or forces | the shop catalogue (`shop_ped_apparel` files, *find*) for the 510 tag names | yes: match them to the hashes `shop_controller` tests |
| ON-049 (*D6: not in the files; the server catalogue*) | Catalogue item keys and categories | the same catalogue | no |
| ENT-015 (*done, D6*) | The component `.ymt` format (slots, drawables, restrictions) | the ped component `.ymt` files (`mp_m_freemode_01` ...) | no |
| GP-055 | Two unlabelled morph-19 entries; the last appearance-table column | creator data and the component files | yes (the creator's item tables) |
| GP-057 | The components of each starter outfit | catalogue / component data | yes (the outfit tables in the creator) |
| ENT-010 | Overlay list 0 to 12 and micro-morph list 0 to 19, checked | head-overlay and freemode ped data | partly done from the creator scripts |
| GP-083 | Base-wardrobe labels and prices of the non-DLC clothes | the shop text (labels), see "Text" below | yes (the price tables in `clothes_shop_mp`) |

## Audio

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| AUD-001 | Number of sounds and sound sets | `sounds.dat54.rel` (*find*, under `update:/x64/audio/config/`) | no |
| AUD-002 | What each audio scene changes | `dynamix.dat15.rel` (*find*, same folder) | no |
| AUD-003 | `.awc` counts per archive | archive listing of every `.awc` | no |
| AUD-004, AUD-009 | Speech archives, voices, the contexts each voice has | `speech2.dat4.rel` (*find*) and the speech `.awc` archives | no |
| AUD-005 | The radio station objects whose names didn't resolve | `update:/x64/audio/config/game.dat151.rel` and DLC `*_game.dat151.rel` | hash candidate names |
| AUD-006 | Music event → mood → track, step by step | the music `.rel` files (*find*) | the music events triggered by scripts |
| AUD-008 | Radio track data (length, DJ markers) | the radio `.awc` and `.rel` entries | no |
| AUD-010 | Which dialogue block belongs to which mission (331 containers) | the dialogue/speech containers | yes (the mission table) |

## Animation, cameras, effects, timecycle

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| REN-001 | The 22 memory group names and their budget unit | clip/anim metadata (hash candidate names) | no |
| REN-002 | Which clip sets the 4,526 hashed keys are | clip set metadata, `peds.ymt`, `weaponanimations.meta` | the script strings |
| REN-004 | Clip archive layout in DLC packs, dictionaries per pack | `.ycd` listings per DLC pack | no |
| REN-005 | The 12 expression dictionaries the update replaced | `.ycd` / expression files, base vs update | no |
| REN-006 | Animation memory cost per dictionary | `.ycd` sizes (resource headers) | no |
| REN-008 | The 50 shake names and other camera names that didn't resolve | `update:/x64/data/metadata/cameras.ymt` | hash candidate names |
| REN-009 | Which `CREATE_CAMERA` hashes scripts use | `cameras.ymt` names | yes (the hashes in the decompile) |
| REN-014 | `entityfx.dat`, `materialfx.dat`, `wheelfx.dat` row by row | `common:/data/effects/entityfx.dat` and the two others | no |
| REN-015 | Which DLC particle dictionaries are mounted in story mode | DLC `.ypt` lists and the DLC setup files | no |
| REN-016 | Effect names per particle dictionary | every `.ypt` | no |
| GP-027, REN-024, REN-026 | The editor's 10 post effects; the 39 unnamed post effects; `GroupId` and `EventType` | the post-effect (animpostfx) metadata (*find*) | `startup` registers the 10 |
| REN-017 | What each changed key between base and update does | `common:/data/visualsettings.dat`, base vs update copy | in-game check |
| REN-021, REN-022, REN-027 | Timecycle modifier line values and `userFlags` | `common:/data/timecycle/` modifier files | in-game check |
| WLD-017 | The 380 timecycle variables per region and how modifiers stack on weather | `common:/data/timecycle/w_<weather>.xml` | no |

## Engine config and archives

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| SCR-014 (*done, D7*) | Which duplicated pool entry in `gameconfig.xml` applies to PC | `common:/data/gameconfig.xml` (base vs update) | no |
| PERF-025 (*done, D7*) | Whether raised physics pools change anything on a low-end PC | vanilla vs modded `gameconfig.xml`, then a test | no |
| FF-001 (*done, D7*) | Reliable sizes per type (audio sizes read as zero) | resource headers of every file | no |
| FF-002 (*done, D7*) | A per-pack breakdown of all 89 DLC packs | every DLC `dlc.rpf` listing | no |
| FF-003 (*done, D7*) | How update copies override base ones, type by type | `common.rpf` vs `update.rpf` listings | no |
| FF-004 (*done, D7*) | Each content section key (`me`, `sro`, `amb` ...) | one Online content (`re_`) file | yes (the `fm_content_*` helper) |
| FF-005 | Which of the 8,472 `gen` keys `fm_mission_controller` reads | a job's UGC JSON | yes |
| PERF-005, PERF-022 | The menu label for each value of every quality key | the player's settings file (outside the archives), compared with the menu | in-game |
| PERF-006 | What rewrites the settings file without the player asking | the settings file before and after a driver update | no |

## Text (`.gxt2` text blocks: base, update and DLC, American)

| ID | What to find | Extract | Scripts too? |
| --- | --- | --- | --- |
| GP-047 (*done, D1*) | The 12 flight school lesson names, then which lesson uses which aircraft | `PSCHOOL` block | yes (the 6 Mallard, 2 Cuban 800, 2 Maverick, 2 Frogger set-ups in `pilot_school`) |
| GP-082 (*done, D1*) | English titles of the 306 clothes menus | shop blocks (`CSHOP_TITLE<n>`) | no (map already read) |
| GP-090 (*done, D1*) | English names of the 80 stock companies | the block holding `BSS_BSTR_<n>` (an update or DLC block) | no (counter map already read) |
| ON-018 | The story of the `mp2025_02` update | its 13 dialogue blocks | no |
| ON-008 | Creator libraries with no text (library 15, 39 ...) | every DLC text block | no |
| UI-018 | A label-name index | every block, hashed against all script strings | yes |
| ENT-005 (*done, D1*) | The 13 vehicle maker labels with no text | vehicle text blocks | no |
| ENT-006 | How mod-part and livery labels are named and registered | vehicle and `carcols` text | no |
| GP-083 | Base-wardrobe labels | clothes text blocks | yes (see above) |

## Questions that need assets (models, textures)

None of the open questions needs model or texture *contents*. Some need only lists or counts of them: ENT-002 (`.yft` list), PHY-002 (`.ybn` count), REN-004 to REN-006 (`.ycd` listings and sizes), AUD-003 (`.awc` counts), FF-001 (resource sizes). An archive listing is enough for those; no asset is opened or copied.
