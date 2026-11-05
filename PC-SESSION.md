# PC session plan: what to do at the game PC

The work left in [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md) that a cloud session can't do, gathered in one place so that one sitting at the game PC covers as much as possible. It was built on 2026-11-04 from the tracker (192 answered, 49 mostly, 57 partly, 144 open of 442), [`DATA-NEEDS.md`](/DATA-NEEDS.md) and the lists in [`HANDOFF.md`](/HANDOFF.md). Each row links to the guide (and its test cards) that holds the details; this page only says what to do and in which order. When a row is done, update its guide and its tracker row as usual, and delete it here.

**Progress.** Batch PC1 (2026-11-04, Part 1) worked 15 data rows: 8 answered and deleted here (AI-024, ENT-038, REN-011, PHY-001, PHY-004, ENT-019, AI-014, AI-009); ENT-017, ENT-039 and UI-009 stay in Part 1 with what is left; ENT-020, PHY-013, AI-033 and ENT-025 moved to Part 2, because what is left of them is in the executable. Tracker after PC1: 200 answered, 53 mostly, 59 partly, 130 open.

Batch PC2 (2026-11-04, Part 2 started): `GTA5.exe` is encrypted on disk, so its decrypted image was copied read-only from the running game (story mode) and analysed in Ghidra. GS-004 answered and deleted here; CORE-018 partly (the engine starts `startup` by name); SCR-005 notes added; REN-012 partly (the decal-definition table; the copy was taken with mods, so vanilla limits need a mod-free copy); SCR-005 mostly (the native table read at run time, 6,673 natives, and a 1-to-1 crossmap of the 6,575 script natives). GP-025 and GP-087 answered (the replay natives are empty on PC, as are 71 natives in all); SCR-007 partly (no order recoverable); ON-009, CORE-031, CORE-032 and SCR-011 blocked by handlers in the anti-tamper code. Tracker after PC2: 203 answered, 54 mostly, 59 partly, 126 open.

Three kinds of work:

1. **Data files** (one CodeWalker run, no game running): 57 rows.
2. **The executable** (read-only reverse engineering of `GTA5.exe`): 34 rows.
3. **In-game tests** (story mode): 122 rows, 11 of them also listed for the executable.

## Before you start

- **Story mode only.** Never run mods, trainers or test scripts in GTA Online; it gets accounts banned. The few Online-themed rows below are read in story mode, or are read-only checks with no Online play.
- **Back up your story save** before the in-game part. Some tests change the world state (wanted levels, crew deaths, unlocks).
- **Tools** (official pages are on [tools and resources](/docs/00-getting-started/toolbox.md)): CodeWalker for the data files, used through this repo's [`tools/`](/tools/README.md) scripts (`rpf-cw.ps1`, `dlc-scan.ps1`, `ysc-dump.ps1`); ScriptHookV for your game build and a script console or trainer for the in-game tests; a frame-time capture for the performance rows ([measuring performance](/docs/performance/measuring.md)).
- **Where results go:** extracted files, dumps and logs stay in a scratch folder outside the repo. Bring back names, numbers, counts and what you saw; a cloud session can then write them into the guides. Never commit game files.
- **Record for every test:** the ID, what you did, what you saw, the game build, and which mods were loaded.

## Part 1: one CodeWalker run (data files)

Extract everything below in one pass into a scratch folder, then pack the folder for a cloud session (or read it yourself). The groups follow [`DATA-NEEDS.md`](/DATA-NEEDS.md), which says what each row needs answered; rows marked *done* there are left out. "Status" is the row's state in that file.

#### Vehicles

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| PHY-011 | open | Bit names of the model, handling, damage and advanced flags | the same files, compared across known vehicles; then an in-game check |
| PHY-014 | open | How `vehicles.meta` fields (`handlingId`, wheel scale, `flags`) interact with handling | `common:/data/levels/gta5/vehicles.meta` and every DLC `vehicles.meta`, with `handling.meta` |
| ENT-037 | mostly | The less common vehicle flags | every `vehicles.meta` `flags` |
| ENT-039 | mostly (PC1: counts done; a per-kit table left) | Which `carcols` mod parts each kit links | the same, plus `carvariations.meta` |

#### Weapons, explosions, physics

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| GP-078 | partly | How story stats and Online rank change the ammo cap | `common:/data/ai/weapons.meta` and DLC weapon files (`AmmoMax`, `AmmoMax50`, `AmmoMax100`, `AmmoMaxMP` ...) |
| GP-079, PHY-009 | mostly | Damage and radius per explosion type, base and the 16 DLC files | `common:/data/explosion.meta` and every DLC explosion file |
| PHY-008 | mostly | The unnamed boolean fields | `update:/x64/data/metadata/explosion.ymt` |
| ENT-017 | mostly (PC1: two `CGrabHelper` set names left) | Which ragdoll tuning set applies to which weapon and vehicle; three hashed set names | NM tuning files and weapon / vehicle data (*find*) |

#### Water

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| PHY-016 | partly | The format of `waterheight.dat` | `common:/data/levels/gta5/waterheight.dat` |
| PHY-005 | open | Water collision vs water simulation | `water.xml` and the collision (`.ybn`) data |
| PHY-018 | partly | Where swimming pools are defined | `water.xml` and map data (`.ymap`) |

#### Map data (`.ymap`, `.ytyp`, `.ybn`, `.ynv`, `.ynd`, `.ymf`, scenarios)

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| GP-035 | D8: not found | Where the world points (script brains) are placed, and how many per brain | ymap / scenario data for world-point brains |
| ENT-029 | mostly | The scenario chaining graph format | scenario point files |
| ENT-030, ENT-035 | partly | Car generator flag bits (3,680, 3,936, 3,616, 1,632) and the unresolved population groups | every `.ymap` with car generators |
| ENT-031 | mostly | Which DLC ymaps with generators load in story mode | DLC ymaps plus the IPL state |
| ENT-002 | partly | Which map props are fragments (`.yft`) and how many break | `.ytyp` archetypes and the `.yft` list |
| ENT-003 | mostly | Every rayfire object placed in the map | ymap entity extensions |
| WLD-001 | mostly | Each IPL name and the building it controls | every `.ymap` (match names to IPLs) |
| WLD-005 | partly | How many entities the story map loads | every `.ymap`, filtered by IPL state |
| AI-027, AI-029 | partly | Road nodes, routes; node and link counts, update vs base | `.ynd` files |
| UI-009 | partly (PC1: 230 of 282 named, 52 left) | Which `int<number>` interior map belongs to which interior | interior `.ytyp` / ymaps, with the text labels |

#### Peds, population, AI behaviour

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| AI-017 | mostly | The 5 unnamed civilian bravery types and the criminality types | the same file, hashed against candidate names |
| AI-019 | partly | How `MotivationMin/Max` is used | the same file |
| AI-020 | still open | How driving ranges map onto driving tasks | the same file, with the driving guides |
| ENT-013 | mostly | 23 personality hashes and relationship groups that didn't resolve | `pedpersonality.ymt`, the peds and relationship files |
| AI-034, AI-035 | partly | The 9 crime-info entries; crime points per crime | `common:/data/ai/crimeinformation.meta` |
| ENT-024 | partly | The unnamed zone fields (`hash_7111AC8A`, three flags) | `common:/data/levels/gta5/popzone.ipl` and the zone data |
| GP-073 | partly | The 5 non-story entries in `PlayerStatInfos` | `update:/x64/data/tune/playerinfo.ymt` (hash candidate names) |

#### Character appearance and shops

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| GP-081 | partly | What each restriction tag blocks or forces | the shop catalogue (`shop_ped_apparel` files, *find*) for the 510 tag names |
| GP-055 | open | Two unlabelled morph-19 entries; the last appearance-table column | creator data and the component files |
| GP-057 | open | The components of each starter outfit | catalogue / component data |
| ENT-010 | open | Overlay list 0 to 12 and micro-morph list 0 to 19, checked | head-overlay and freemode ped data |
| GP-083 | partly | Base-wardrobe labels and prices of the non-DLC clothes | the shop text (labels), see "Text" below |

#### Audio

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| AUD-004, AUD-009 | partly | Speech archives, voices, the contexts each voice has | `speech2.dat4.rel` (*find*) and the speech `.awc` archives |
| AUD-008 | partly | Radio track data (length, DJ markers) | the radio `.awc` and `.rel` entries |
| AUD-010 | mostly | Which dialogue block belongs to which mission (331 containers) | the dialogue/speech containers |

#### Animation, cameras, effects, timecycle

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| REN-001 | mostly | The 22 memory group names and their budget unit | clip/anim metadata (hash candidate names) |
| REN-002 | mostly | Which clip sets the 4,526 hashed keys are | clip set metadata, `peds.ymt`, `weaponanimations.meta` |
| REN-005 | mostly | The 12 expression dictionaries the update replaced | `.ycd` / expression files, base vs update |
| REN-008 | partly | The 50 shake names and other camera names that didn't resolve | `update:/x64/data/metadata/cameras.ymt` |
| GP-027, REN-024, REN-026 | partly | The editor's 10 post effects; the 39 unnamed post effects; `GroupId` and `EventType` | the post-effect (animpostfx) metadata (*find*) |
| REN-017 | partly | What each changed key between base and update does | `common:/data/visualsettings.dat`, base vs update copy |
| REN-021, REN-022, REN-027 | partly | Timecycle modifier line values and `userFlags` | `common:/data/timecycle/` modifier files |
| WLD-017 | partly | The 380 timecycle variables per region and how modifiers stack on weather | `common:/data/timecycle/w_<weather>.xml` |

#### Engine config and archives

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| PERF-025 | partly | Whether raised physics pools change anything on a low-end PC | vanilla vs modded `gameconfig.xml`, then a test |
| FF-004 | mostly | Each content section key (`me`, `sro`, `amb` ...) | one Online content (`re_`) file |
| FF-005 | open | Which of the 8,472 `gen` keys `fm_mission_controller` reads | a job's UGC JSON |
| PERF-005, PERF-022 | open | The menu label for each value of every quality key | the player's settings file (outside the archives), compared with the menu |
| PERF-006 | open | What rewrites the settings file without the player asking | the settings file before and after a driver update |
| PERF-013 | partly | Which files `ON_ENTER_MP` switches: the change sets the 43 `GROUP_ON_DEMAND` packs run on entering Online | `content.xml` of every DLC pack with `GROUP_ON_DEMAND` in its `setup2.xml` (`contentChangeSets`) |

#### Text (`.gxt2` text blocks: base, update and DLC, American)

| IDs | Status | What to find | Extract |
| --- | --- | --- | --- |
| GP-047 | mostly | The 12 flight school lesson names, then which lesson uses which aircraft | `PSCHOOL` block |
| GP-082 | mostly | English titles of the 306 clothes menus | shop blocks (`CSHOP_TITLE<n>`) |
| GP-090 | mostly | English names of the 80 stock companies | the block holding `BSS_BSTR_<n>` (an update or DLC block) |
| ON-018 | mostly | The story of the `mp2025_02` update | its 13 dialogue blocks |
| ON-008 | mostly | Creator libraries with no text (library 15, 39 ...) | every DLC text block |
| UI-018 | open | A label-name index | every block, hashed against all script strings |
| GP-083 | partly | Base-wardrobe labels | clothes text blocks |

#### Found since DATA-NEEDS was written

| IDs | What to find | Extract |
| --- | --- | --- |
| FF-006 | The English names of the mission rule types (labels `PMC_RULE1` to `PMC_RUE19`, read by `public_mission_creator`) | The Online creator's text block in the American `.gxt2` files |
| SCR-002, SCR-007, GP-021, AI-023, AI-045 | The functions behind the scripts' function pointers (`Call_Loc` targets): the 54 natives seen only in pointer-reached code, the native table order, the triggerers' set-ups, the per-variation vehicle and patrol data | The compiled scripts (`.ysc` in `update\update2.rpf`) and a reader that follows their code. `ysc-dump.ps1` reads only headers and strings, so this needs a new tool under `tools/` (maintainer review) |
| ON-021, ON-035, ON-049, ON-072 | Names behind hashed tunables and the price category 426439576 | Not in the game files: needs a name source (see [stats and tunables](/docs/online/stats-and-tunables.md)) |

## Part 2: the executable (read-only)

Read-only reverse engineering of `GTA5.exe` (build 1.0.3725.0): look, never patch. Rows that also appear in Part 3 can often be settled faster by a test.

**The code is encrypted on disk** (entropy 8.0 in every megabyte of both code sections), so Ghidra on `GTA5.exe` itself sees nothing. Analyse a read-only copy of the decrypted image instead, read from the running game in story mode (an administrator PowerShell is needed, because the game runs elevated). The main code section is readable in that copy; the second, anti-tamper code section stays scrambled. Keep the copy outside the repo. **Take it with no mods loaded** for the limit rows (REN-012, CORE-015, CORE-016, PERF-016): limit patches change the very checks and arrays those rows ask about (the first copy, taken with mods, shows the decal patch's 620 instead of vanilla). For the native rows, the copy also needs the native hash table's heap nodes, not only the module image.

| ID | What to find out | Status | Guide |
| --- | --- | --- | --- |
| AI-001 | The full list of task classes the engine has (not only tuned ones) | open | [The AI architecture](/docs/ai/ai-architecture.md) |
| AI-003 | How primary and secondary task slots are numbered | open | [The AI architecture](/docs/ai/ai-architecture.md) |
| AI-004 | The distances where ped AI LOD changes | open | [AI cost and level of detail](/docs/ai/ai-cost-and-lod.md) |
| AI-020 | How the driving ranges map onto the driving tasks (R3.3, R17.6) | open | [Decisions and personalities](/docs/ai/decisions-and-personalities.md) |
| AI-033 | The rule a decision maker uses to pick one decision for an event (first valid one in order, or weighted?) | mostly (PC1: the data side) | [Perception and events](/docs/ai/perception-and-events.md#3341-from-event-to-response-decision-makers-pc-data-pass) |
| AI-040 | How the wanted level overrides the `COP`–`PLAYER` relationship | partly | [Relationships and groups](/docs/ai/relationships-and-groups.md) |
| CORE-002 | The exact load phases for each change-set group | partly | [Archives and the content system](/docs/core/archives-and-content.md) |
| CORE-015 | Memory cost of each raised pool (bytes per slot) | open | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-016 | The vanilla built-in sizes of the weapon arrays that WeaponLimitsAdjuster raises | partly | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-018 | What exactly the engine does to start `main`, `initial` and `startup`, and in which order | partly (PC2: `startup` by name; `main`, `initial` open) | [Runtime scripts: the scripts that keep the game running](/docs/core/runtime-scripts.md) |
| CORE-024 | The save file's on-disk format and how names map to it | open | [Saves: what the story save holds and how scripts write it](/docs/core/saves.md) |
| CORE-027 | The streaming memory budget (how the engine splits RAM between stores), and what HeapAdjuster changes in it | open | [Streaming: how assets get into memory](/docs/core/streaming.md) |
| CORE-031 | Which brain set the engine gives the random-ped brains added with `ADD_SCRIPT_TO_RANDOM_PED` (no script registers into sets 2 or 4) | open (PC2: its natives' handlers sit in the anti-tamper code) | [Surviving game updates](/docs/core/surviving-updates.md) |
| CORE-032 | What the engine raises force-cleanup bits 16 and 32 for (no script raises them; [runtime scripts … | open (PC2: its natives' handlers sit in the anti-tamper code) | [Runtime scripts: the scripts that keep the game running](/docs/core/runtime-scripts.md) |
| ENT-020 | Where and how fall damage is computed (no data file sets it) | partly (PC1: data ruled out) | [Ped physics and ragdoll](/docs/entities/peds/ragdoll.md#174-falling) |
| ENT-025 | How the engine places the aerial, aquatic and wildlife population groups | mostly (PC1: the data side) | [Population](/docs/entities/spawning/population.md#birds-and-fish-pc-data-pass) |
| GP-021 | What the mission triggerers build before a mission starts (lead-in scenes, from guide 2) | partly | [Anatomy of a story mission](/docs/gameplay/missions/mission-anatomy.md) |
| GP-023 | What exactly NoEditorRestrictions patches, and the vanilla limits it lifts (free camera distance, restricted areas) | open | [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) |
| GP-069 | Which ability type each entry 3 to 16 is | partly | [Player skills and abilities](/docs/gameplay/player/skills-and-abilities.md) |
| GP-078 | How story stats and Online rank change `AmmoMax` | partly | [Weapons](/docs/gameplay/weapons/weapons.md) |
| GP-080 | How aim assist and lock-on work for the player versus AI | open | [Weapons](/docs/gameplay/weapons/weapons.md) |
| GP-092 | What selects special ability entries 8 to 16, which have no `SAT_*` type | open | [Player skills and abilities](/docs/gameplay/player/skills-and-abilities.md) |
| ON-009 | What `GET_USED_CREATOR_BUDGET` measures inside the engine | open (PC2: its natives' handlers sit in the anti-tamper code) | [Rockstar Creator internals: how tracks and maps are built from props](/docs/online/creator-internals.md) |
| ON-052 | How migration chooses a new owner and host | open | [Sessions and sync](/docs/online/sessions-and-sync.md) |
| ON-060 | How bits 16, 32 and 64 in these masks are raised (they end some systems on other occasions) | mostly | [Story systems that clash with an Online mode](/docs/online/story-systems-in-online-mode.md) |
| PERF-016 | How much of the 1,950 MB heap is used (HeapAdjuster only logs the size) | open | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md) |
| PHY-013 | What each `statMods` modifier value scales (percent of drive force, brake force, shift speed; suspension units) | partly (PC1: every value read) | [Vehicle handling](/docs/physics/vehicle-handling.md#47-speed-grip-and-upgrades) |
| REN-007 | The director priorities and exactly when the cinematic director takes over | open | [Cameras](/docs/rendering/cameras.md) |
| REN-012 | The exact decal limit in build 3725 and what limit patches change | partly (PC2: the definition table; vanilla size needs a mod-free copy) | [Particles and decals](/docs/rendering/particles-and-decals.md) |
| SCR-004 | What `0x8F5D1AD832AEB06C` and `0x0F7082C60FB479EF` do (not in NativeDB) | partly | [Native usage: which scripts call which natives](/scripting/native-usage.md) |
| SCR-005 | Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` style check from a mod, or ScriptHookV's native table) | mostly (PC2: native table read at run time; a one-native in-game check would settle it) | [Native usage: which scripts call which natives](/scripting/native-usage.md) |
| SCR-007 | What the table order is (not first use; maybe first use in compiled code order) | partly (PC2: every testable order ruled out) | [Native usage: which scripts call which natives](/scripting/native-usage.md) |
| SCR-011 | Meaning of force-cleanup bits 4, 16 and 32 (engine-raised) | open (PC2: its natives' handlers sit in the anti-tamper code) | [The script VM: how GTA V runs its scripts, and how mods run beside them](/scripting/script-vm.md) |
| UI-020 | What the stat and Social Club inbox natives return when signed out, which decides what `mp_awards`, `mp_unlocks` and `appmpemail` show … | open | [Server-backed Online screens](/docs/ui/server-backed-screens.md) |

## Part 3: in-game test session (story mode)

Suggested order: **A** first, on a clean install and then with your usual mod set, because the later blocks load extra scripts. Within a block, follow the guide's test card; rows in guides without a test-card section link to the guide itself.

### A. Performance (measured on the test PC; run first, on a clean install, then again with your mod set)

26 questions.

| ID | What to find out | Status | Guide and test card | Also needs |
| --- | --- | --- | --- | --- |
| PERF-001 | What one idle SHVDN script costs per frame on a low-end PC (and so what 51 cost) | open | [CPU: population, AI, physics and scripts](/docs/performance/cpu.md#48-test-cards) |  |
| PERF-002 | Whether `-disableHyperthreading` helps on a 4-core, 8-thread laptop | open | [CPU: population, AI, physics and scripts](/docs/performance/cpu.md#48-test-cards) |  |
| PERF-003 | AI cost per ped type (ambient, combat, driving) | open | [CPU: population, AI, physics and scripts](/docs/performance/cpu.md#48-test-cards) |  |
| PERF-004 | How much of the frame the 52 Rockstar threads take | open | [CPU: population, AI, physics and scripts](/docs/performance/cpu.md#48-test-cards) |  |
| PERF-005 | The exact menu label for each value of every quality key | open | [Graphics settings, one by one](/docs/performance/graphics-settings.md#29-test-cards) |  |
| PERF-006 | What rewrites `settings.xml` without the player asking (auto-detection after a driver update, a launcher) | open | [Graphics settings, one by one](/docs/performance/graphics-settings.md#29-test-cards) |  |
| PERF-007 | How much shared memory each texture level takes on integrated graphics | open | [Graphics settings, one by one](/docs/performance/graphics-settings.md#29-test-cards) |  |
| PERF-008 | How much each add-on pack adds to the engine loading screen | open | [Load times and stutter](/docs/performance/load-times.md#87-test-cards) |  |
| PERF-009 | Whether the 3-to-10-minute FPS drop is throttling (and how much a cooling pad recovers) | open | [Load times and stutter](/docs/performance/load-times.md#87-test-cards) |  |
| PERF-010 | Whether an antivirus exclusion shortens the loading screen | open | [Load times and stutter](/docs/performance/load-times.md#87-test-cards) |  |
| PERF-011 | Confirm the benchmark switches and results file, and record a baseline with and without mods | open | [Measuring performance](/docs/performance/measuring.md#test-cards) |  |
| PERF-013 | Why `ON_ENTER_MP` blocks for about 9 s: which map data it swaps | partly | [Measuring performance](/docs/performance/measuring.md#test-cards) |  |
| PERF-014 | How much each texture level costs on integrated graphics (working set and private) | open | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md#38-test-cards) |  |
| PERF-015 | How much a smaller mod set saves, measured the same way | open | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md#38-test-cards) |  |
| PERF-017 | Whether the game's in-menu video memory bar counts shared memory on integrated graphics | open | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md#38-test-cards) |  |
| PERF-018 | Frame time per mod set at the same spot | open | [Mod overhead: what each kind of mod costs](/docs/performance/mod-overhead.md#57-test-cards) |  |
| PERF-019 | Load time added by the add-on packs (with `Mods\` off vs on) | open | [Mod overhead: what each kind of mod costs](/docs/performance/mod-overhead.md#57-test-cards) |  |
| PERF-020 | The per-frame cost of one idle SHVDN script | open | [Mod overhead: what each kind of mod costs](/docs/performance/mod-overhead.md#57-test-cards) |  |
| PERF-021 | Measured FPS and hitches of the low-end profile vs typical settings on a low-end laptop | open | [Profiles for different PCs](/docs/performance/pc-profiles.md#76-test-cards) |  |
| PERF-022 | Profile values that need the menu mapping | open | [Profiles for different PCs](/docs/performance/pc-profiles.md#76-test-cards) |  |
| PERF-023 | How many Euphoria ragdolls the engine runs at once before falling back, and what one costs on a low-end PC | open | [Physics cost: what the simulation spends, and how scripts keep it down](/docs/performance/physics-cost.md#119-test-cards) |  |
| PERF-024 | Cost of a vehicle crash, an explosion, a fire, on a low-end PC | open | [Physics cost: what the simulation spends, and how scripts keep it down](/docs/performance/physics-cost.md#119-test-cards) |  |
| PERF-025 | Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels | partly | [Physics cost: what the simulation spends, and how scripts keep it down](/docs/performance/physics-cost.md#119-test-cards) |  |
| PERF-026 | How much FPS and how many hitches closing background programs saves | open | [Windows and drivers](/docs/performance/windows-and-drivers.md#test-cards) |  |
| PERF-027 | Whether "Best performance" power mode raises sustained clocks on a 15 W laptop | open | [Windows and drivers](/docs/performance/windows-and-drivers.md#test-cards) |  |
| PERF-028 | Whether excluding the game folder from the antivirus shortens loading | open | [Windows and drivers](/docs/performance/windows-and-drivers.md#test-cards) |  |

### B. Boot, scripts and natives (needs ScriptHookV and a console or native logger)

21 questions.

| ID | What to find out | Status | Guide and test card | Also needs |
| --- | --- | --- | --- | --- |
| CORE-001 | Which data file types overlay (merge) and which replace; how duplicate names between packs resolve | open | [Archives and the content system](/docs/core/archives-and-content.md) |  |
| CORE-013 | A PoolManager crash log from the test install names `cscenarioinfo` at size 250, the vanilla value, while the start-up log shows 885: was the modded … | open | [Memory, pools and limits](/docs/core/memory-and-pools.md#78-test-cards) |  |
| CORE-014 | Real usage of the busiest pools in a heavy session (turn on PoolManager's usage warning for one launch) | open | [Memory, pools and limits](/docs/core/memory-and-pools.md#78-test-cards) |  |
| CORE-015 | Memory cost of each raised pool (bytes per slot) | open | [Memory, pools and limits](/docs/core/memory-and-pools.md#78-test-cards) | the executable |
| CORE-026 | How `TextureQuality` values map to the menu, and how much memory each level takes on shared graphics | open | [Streaming: how assets get into memory](/docs/core/streaming.md#109-test-cards) |  |
| CORE-029 | Measure a pop-in case: drive fast through the city at `LodScale` 0 and 0.5 with a frame-time log, compare hitches and memory | open | [Streaming: how assets get into memory](/docs/core/streaming.md#109-test-cards) |  |
| CORE-032 | What the engine raises force-cleanup bits 16 and 32 for (no script raises them; [runtime scripts … | open (PC2: its natives' handlers sit in the anti-tamper code) | [Runtime scripts: the scripts that keep the game running](/docs/core/runtime-scripts.md) | the executable |
| GS-003 | Whether the return to story mode restarts every script (test card 2) | open | [Boot and script control: from launch to control, and between story and Online](/docs/00-getting-started/boot.md#38-test-cards) |  |
| ON-058 | What exactly `clothes_shop_sp` does with a freemode ped (refuses, shows story stock, or breaks) | open | [Story systems that clash with an Online mode](/docs/online/story-systems-in-online-mode.md#76-test-cards) |  |
| ON-060 | How bits 16, 32 and 64 in these masks are raised (they end some systems on other occasions) | mostly | [Story systems that clash with an Online mode](/docs/online/story-systems-in-online-mode.md#76-test-cards) | the executable |
| ON-073 | Whether the two `SaveCategory` groups are saved as separate cloud files | open | [Stats, tunables and the server's role](/docs/online/stats-and-tunables.md#108-test-cards) |  |
| SCR-002 | Which natives are reached only through shared helper code and never called in practice | partly | [Native namespace map](/scripting/native-namespace-map.md) |  |
| SCR-005 | Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` style check from a mod, or ScriptHookV's native table) | mostly (PC2: native table read at run time; a one-native in-game check would settle it) | [Native usage: which scripts call which natives](/scripting/native-usage.md#910-test-cards) | the executable |
| SCR-008 | Measured cost of the heavy natives (synchronous shape test, `GET_CLOSEST_*`, load scenes) on a low-end PC | open | [Natives as the engine API: kinds, contracts and costs](/scripting/natives-engine-api.md#148-test-cards-story-mode-a-script-mod) |  |
| SCR-009 | Which natives crash on a stale handle and which fail quietly | open | [Natives as the engine API: kinds, contracts and costs](/scripting/natives-engine-api.md#148-test-cards-story-mode-a-script-mod) |  |
| SCR-010 | The size limits of the nearby-entity arrays | open | [Natives as the engine API: kinds, contracts and costs](/scripting/natives-engine-api.md#148-test-cards-story-mode-a-script-mod) |  |
| SCR-011 | Meaning of force-cleanup bits 4, 16 and 32 (engine-raised) | open (PC2: its natives' handlers sit in the anti-tamper code) | [The script VM: how GTA V runs its scripts, and how mods run beside them](/scripting/script-vm.md#29-test-card-which-rockstar-scripts-really-run) | the executable |
| SCR-012 | What thread priority values change | mostly | [The script VM: how GTA V runs its scripts, and how mods run beside them](/scripting/script-vm.md#29-test-card-which-rockstar-scripts-really-run) |  |
| UI-002 | What the `listId` draw lists and depths do | partly | [HUD, colours and blips](/docs/ui/hud-colours-blips.md#248-test-cards-story-mode-a-script-mod) |  |
| UI-017 | How DLC global blocks are merged and which wins on a clash | open | [Text labels](/docs/ui/text-labels.md#test-cards) |  |
| UI-020 | What the stat and Social Club inbox natives return when signed out, which decides what `mp_awards`, `mp_unlocks` and `appmpemail` show … | open | [Server-backed Online screens](/docs/ui/server-backed-screens.md#2510-test-cards) | the executable |

### C. World, AI and entities

43 questions.

| ID | What to find out | Status | Guide and test card | Also needs |
| --- | --- | --- | --- | --- |
| AI-002 | Task status values and what each means, measured | open | [The AI architecture](/docs/ai/ai-architecture.md#408-test-cards-story-mode-a-script-mod) |  |
| AI-004 | The distances where ped AI LOD changes | open | [AI cost and level of detail](/docs/ai/ai-cost-and-lod.md#378-test-cards-story-mode-a-script-mod) | the executable |
| AI-005 | Measured frame time per combat ped on a low-end PC | open | [AI cost and level of detail](/docs/ai/ai-cost-and-lod.md#378-test-cards-story-mode-a-script-mod) |  |
| AI-007 | How far from the player ambient peds despawn | open | [Ambient life](/docs/ai/ambient-life.md#366-test-cards-story-mode) |  |
| AI-015 | Whether the modded `events.meta` really drops gunfight reactions, in game | open | [Combat and AI (first pass)](/docs/ai/combat-and-perception.md) |  |
| AI-018 | What `IsWeird` changes for Trevor | open | [Decisions and personalities](/docs/ai/decisions-and-personalities.md#test-cards) |  |
| AI-019 | How motivation (`MotivationMin/Max`) is used | partly | [Decisions and personalities](/docs/ai/decisions-and-personalities.md#test-cards) |  |
| AI-020 | How the driving ranges map onto the driving tasks (R3.3, R17.6) | open | [Decisions and personalities](/docs/ai/decisions-and-personalities.md#test-cards) | the executable |
| AI-021 | The name of each temp action number, checked in game | open | [Driving AI: missions, chases, aircraft and boats](/docs/ai/driving-ai.md#398-test-cards-story-mode-a-script-mod) |  |
| AI-025 | How `SET_DRIVER_ABILITY` and `_AGGRESSIVENESS` change the curve or braking | open | [Driving and AI driving](/docs/ai/driving.md#188-test-cards-story-mode-a-script-mod) |  |
| AI-030 | How far around the player navmeshes stream by default | open | [Navigation and pathfinding](/docs/ai/navigation.md#347-test-cards-story-mode-a-script-mod) |  |
| AI-037 | The exact follower limit and what happens to the eighth | open | [Relationships and groups](/docs/ai/relationships-and-groups.md#test-cards) |  |
| AI-039 | How dislike (4) differs from hate (5) in behaviour | open | [Relationships and groups](/docs/ai/relationships-and-groups.md#test-cards) |  |
| AI-040 | How the wanted level overrides the `COP`–`PLAYER` relationship | partly | [Relationships and groups](/docs/ai/relationships-and-groups.md#test-cards) | the executable |
| AI-041 | Where story missions keep enemy spawn tables (positions, triggers) and how many enemies a big shootout has alive at once | partly | [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md#4412-test-cards) |  |
| AI-042 | What hackers' and drivers' stats do in each heist | mostly | [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md#4412-test-cards) |  |
| AI-044 | The `TASK_COMBAT_PED` flag values (16, 67108864, 201326592) | open | [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md#4412-test-cards) |  |
| AI-046 | Buddy behaviour in vehicles (driver choice, drive-bys) | mostly | [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md#4412-test-cards) |  |
| AI-047 | Crime points added per crime (set in the engine) | open | [Wanted level and police](/docs/ai/wanted-level-and-police.md#388-test-cards-story-mode) |  |
| AI-049 | How the difficulty value changes police behaviour, measured | open | [Wanted level and police](/docs/ai/wanted-level-and-police.md#388-test-cards-story-mode) |  |
| ENT-004 | The `NULL` fallback and the "CARNOTFOUND" return, confirmed in game | open | [Text and names in content](/docs/entities/objects/text-and-names.md#test-cards) |  |
| ENT-007 | Load order when two packs define the same label | open | [Text and names in content](/docs/entities/objects/text-and-names.md#test-cards) |  |
| ENT-010 | The overlay index list (0 to 12) and micro-morph list (0 to 19), checked against the creator | partly | [Appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) |  |
| ENT-016 | How many Euphoria ragdolls run at once before peds fall back to `CTaskRageRagdoll` | open | [Ped physics and ragdoll](/docs/entities/peds/ragdoll.md#178-test-cards-story-mode-a-script-mod) |  |
| ENT-018 | Fall damage by height | open | [Ped physics and ragdoll](/docs/entities/peds/ragdoll.md#178-test-cards-story-mode-a-script-mod) |  |
| ENT-022 | How the caps, `CityDensity` and the budgets combine into the real spawn count | open | [Population](/docs/entities/spawning/population.md#test-cards) |  |
| ENT-027 | How the time window and probability combine with the `#Scenario` cap | open | [Scenarios and ambient life](/docs/entities/spawning/scenarios.md#test-cards) |  |
| ENT-030 | What the car generator flag bits mean (3,680, 3,936 ...) | partly | [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md#test-cards) |  |
| ENT-032 | How the schedule caps, the budget and the `CityDensity` setting combine | open | [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md#test-cards) |  |
| ENT-033 | What the ten unused train tracks are and whether they work | open | [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md#test-cards) |  |
| ENT-037 | The meaning of the less common flags | mostly | [Vehicles](/docs/entities/vehicles/vehicles.md#test-cards) |  |
| PHY-003 | The exact shape test flag bits, checked in game | open | [Collision, materials and shape tests](/docs/physics/collision-and-materials.md) |  |
| PHY-006 | The exact falloff curve between centre and edge, and how armour takes explosion damage | open | [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md#test-cards) |  |
| PHY-007 | How far and how fast fire spreads, and its limits (number of fires at once) | open | [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md#test-cards) |  |
| PHY-012 | How the engine turns `fInitialDriveMaxFlatVel` and the drive force into the real top speed | open | [Vehicle physics: handling, damage and upgrades](/docs/physics/vehicle-handling.md) |  |
| PHY-017 | How wave quads differ from calming quads in effect | open | [Water and buoyancy](/docs/physics/water-and-buoyancy.md#test-cards) |  |
| WLD-003 | Which Online interiors work offline with IPLs alone | open | [Interiors and IPLs](/docs/world/interiors-and-ipls.md#test-cards) |  |
| WLD-012 | The world brain activation range and how the engine picks between nearby points | open | [Random events](/docs/world/random-events.md#test-cards) |  |
| WLD-013 | How long one `TimeMult` unit lasts, and whether the cycle position is tied to the game clock or to real time (story vs Online) | open | [Time, weather and wind](/docs/world/time-and-weather.md#test-cards) |  |
| WLD-014 | Whether wind changes the flight of aircraft, the drift of boats, or bullets | open | [Time, weather and wind](/docs/world/time-and-weather.md#test-cards) |  |
| WLD-016 | How `SET_OVERRIDE_WEATHER` and the persistent lock interact when both are set | open | [Time, weather and wind](/docs/world/time-and-weather.md#test-cards) |  |
| WLD-018 | The base length of one weather `TimeMult` unit (not in the file) *(from the guide's text)* | open | [Time, weather and wind](/docs/world/time-and-weather.md#test-cards) |  |
| WLD-019 | Whether wind pushes aircraft or boats *(from the guide's text)* | open | [Time, weather and wind](/docs/world/time-and-weather.md#test-cards) |  |

### D. Gameplay

22 questions.

| ID | What to find out | Status | Guide and test card | Also needs |
| --- | --- | --- | --- | --- |
| GP-006 | Exact meanings of the `START_CUTSCENE` and `REGISTER_ENTITY_FOR_CUTSCENE` flag bits | open | [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) |  |
| GP-023 | What exactly NoEditorRestrictions patches, and the vanilla limits it lifts (free camera distance, restricted areas) | open | [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md#test-cards) | the executable |
| GP-038 | The 42-entry scene table's conditions (time, place, mission state) | mostly | [Character switching](/docs/gameplay/player/character-switching.md#97-test-cards) |  |
| GP-039 | The meaning of switch flag bits 1, 2, 4, 8 | open | [Character switching](/docs/gameplay/player/character-switching.md#97-test-cards) |  |
| GP-043 | How `SET_INPUT_EXCLUSIVE` and `DISABLE_CONTROL_ACTION` interact when two scripts disagree | open | [Controls and camera](/docs/gameplay/player/controls-and-camera.md#test-cards) |  |
| GP-049 | The player's regeneration rate, delay and cap in numbers | open | [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md#test-cards) |  |
| GP-050 | What exactly changes below the fatigued and hurt thresholds | open | [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md#test-cards) |  |
| GP-053 | How armour splits damage between armour and health for each damage type | open | [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md#test-cards) |  |
| GP-054 | How many normal and special parent heads each list has, and which characters the special ones are | open | [The Online character creator](/docs/gameplay/player/online-character-creator.md#test-cards) |  |
| GP-062 | Exactly which weapons survive an arrest | open | [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md#test-cards) |  |
| GP-064 | Whether the engine picks the nearest enabled point or uses other rules (wanted level, water, the exile) | open | [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md#test-cards) |  |
| GP-068 | What shooting, strength and stealth change, in numbers | open | [Player skills and abilities](/docs/gameplay/player/skills-and-abilities.md#test-cards) |  |
| GP-071 | The exact curve from the lung capacity stat to seconds of breath (`DiveRampPow` may be part of it) | open | [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md#test-cards) |  |
| GP-072 | How fast drowning drains health | open | [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md#test-cards) |  |
| GP-074 | How the fall heights combine with ragdoll and fall damage | open | [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md#test-cards) |  |
| GP-075 | Swim speed from the stamina and lung stats | open | [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md#test-cards) |  |
| GP-078 | How story stats and Online rank change `AmmoMax` | partly | [Weapons](/docs/gameplay/weapons/weapons.md) | the executable |
| GP-081 | What each restriction tag blocks or forces, as a table (hat with hood, glasses with masks ...) | partly | [Online cosmetics and the shops that sell them](/docs/gameplay/player/online-cosmetic-shops.md#test-cards) |  |
| GP-085 | The hair and make-up colour counts on this build | open | [Online cosmetics and the shops that sell them](/docs/gameplay/player/online-cosmetic-shops.md#test-cards) |  |
| GP-088 | Which scripts arm the `code_controller` entries that unlock base jumps, golf, hunting, off-road, flight school, the races, stunts, towing and … | mostly | [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md#429-test-cards) |  |
| GP-089 | Which scripts set the flag IDs that gate stranger entries (74, 84 to 110, 133) and release `MrsPhilips2`, `Rampage3` and `TheLastOne` | mostly | [Strangers, freaks and side content](/docs/gameplay/missions/strangers-and-freaks.md#207-test-cards) |  |
| GP-091 | Whether the `PAD` natives on build 3717+ still treat an old control number (257 to 364) as the old control, so old mods keep working | open | [Controls and camera](/docs/gameplay/player/controls-and-camera.md#test-cards) |  |

### E. Rendering and audio

10 questions.

| ID | What to find out | Status | Guide and test card | Also needs |
| --- | --- | --- | --- | --- |
| AUD-007 | Which DLC stations are available in story mode in build 3725 | open | [Music and radio](/docs/audio/music-and-radio.md#test-cards) |  |
| AUD-008 | The format of a radio track's data (length, markers for the DJ) | partly | [Music and radio](/docs/audio/music-and-radio.md#test-cards) |  |
| AUD-011 | The speech parameter names and what each does | open | [Speech and dialogue](/docs/audio/speech-and-dialogue.md#287-test-cards-story-mode-a-script-mod) |  |
| REN-003 | Exactly what each `TASK_PLAY_ANIM` flag bit does (262144 and 16777216 in particular) | open | [Animation](/docs/rendering/animation.md#4311-test-cards) |  |
| REN-013 | How the particle quality setting picks between `ptfx`, `ptfx_hi` and `ptfx_lo` | open | [Particles and decals](/docs/rendering/particles-and-decals.md#test-cards) |  |
| REN-017 | What each changed key between base and update copies does | partly | [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md#297-test-cards-story-mode) |  |
| REN-018 | How "extended distance scaling" maps to the LOD scale value | open | [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md#297-test-cards-story-mode) |  |
| REN-020 | Per-pass cost measured on a low-end PC | open | [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md#297-test-cards-story-mode) |  |
| REN-021 | What the two numbers on each modifier line mean (value and strength? value at two ends of a range?) | partly | [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md#test-cards) |  |
| REN-023 | The game hours of the 13 keyframes | open | [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md#test-cards) |  |

## After the session

Paste the results (ID, what you did, what you saw) into a new cloud session together with this page. That session updates each guide and its row in [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md) and [`DATA-NEEDS.md`](/DATA-NEEDS.md), deletes the finished rows here, and refreshes the knowledge graph.
