# Handoff: second pass, end of phase 4 (read this first)

Short state file for the next AI session or contributor, so the work can resume without re-reading the repo. Update or delete it when the work below is done. It contains no game data and no personal paths.

## Where things are

- **All work is on branch `main-km1sze`** (pushed). It holds phase 4 (P4.1 to P4.10) and the "second-pass leftovers" commits. `research/second-pass-phase4` stops at P4.8; don't use it. Locally: `git fetch origin main-km1sze && git checkout main-km1sze`.
- **Not done yet:**
  - The knowledge-graph refresh (`/graphify . --update`, then commit `graphify-out/`), deferred since P4.1.
  - The pull request (open it only when the contributor asks).
- **Tracker:** `OPEN_QUESTIONS.md`, 438 questions. Every status changed in this work links to its doc section.

## What the cloud sessions did (summary)

- **P4.9, controls (R6.4).** Build 3717 renumbered control IDs: 37 `INPUT_CREATOR_*` controls were inserted at 257 to 293, so every old ID from 257 to 364 is now +37. Also the shared disable helpers and the view-mode context numbers.
- **P4.10, skills, flying and weapons:**
  - how `stats_controller` grows skills, and each character's starting skills
  - the ability types
  - the AI flight mission types and the flight school's aircraft
  - the hatchet and Gusenberg unlock conditions
- **Leftovers answered:**
  - CORE-030 (natives 3725 to 3889), CORE-033 (mission types)
  - GP-084 (barber rank locks), GP-086 (hair fade map)
  - ON-042 and ON-066 (the personal-vehicle record), ON-048 (story use of online services), ON-067 (phone flags), ON-075 (boss registration is free)
  - REN-010 (same as GP-044)
- **Leftovers partly answered:** GP-082, GP-088, GP-089, GP-090, ON-072, ON-074, SCR-004, SCR-005, and the mirrored GP-012, GP-034, ON-060.

## What every remaining question needs

Everything below is still open or only partly answered (about 300 rows). The groups say what input the next session needs, so it can be gathered first and then answered in one go. Some questions appear in two groups when they need both. Story mode only; never test in GTA Online.

### 1. Data files (extract with CodeWalker / `tools/rpf-cw.ps1`, update copies win)

| Input to extract | Questions |
| --- | --- |
| Every DLC `handling.meta` (+ base) | GP-045 (flying blocks), AI-024 (AI profiles), PHY-011 (flag bits), PHY-013 (`statMods`), PHY-014 (with `vehicles.meta`) |
| Every `vehicles.meta` (base + DLC), `carcols.meta`, `carvariations.meta` | GP-046 (`SPMED`/`SPSMALL`), ON-068 (match hashes −994826917, 886151985, −1242692076, −451225720 to `modelName`), ENT-036, ENT-037, ENT-038, ENT-039 |
| `weapons.meta` family, `explosion.meta` (base + 16 DLC), `explosion.ymt` | GP-078 (`AmmoMax*` fields), GP-079 and PHY-009 (DLC explosions), PHY-010 (DLC projectiles), PHY-008 |
| `materials.dat`, physics files | PHY-001, PHY-004 |
| `water.xml`, `waterheight.dat` | PHY-005, PHY-015, PHY-016, PHY-018 |
| Map data: `.ymap`, `.ytyp`, `.ybn`, `.ynv`, `.ynd`, `.ymf`, scenario files | GP-035 (world points), ENT-034 (ambient aircraft and boat routes), PHY-002, ENT-001, ENT-002, ENT-003, ENT-028, ENT-029, ENT-030/ENT-035 (car generator flags), ENT-031, WLD-001, WLD-004, WLD-005, WLD-007, AI-027, AI-028, AI-029, REN-025 |
| `pedpersonality.ymt` (PSO), `peds.ymt`, `popcycle.dat`, `popzone`/zone files, `events.meta`, `taskdata.meta`, `scriptedguntasks.meta`, `dispatch.meta`, crime data | AI-011/AI-016, AI-014, AI-017, AI-019, AI-020, AI-033, AI-034, AI-035, AI-036, AI-009, ENT-013, ENT-021, ENT-024, ENT-025 |
| Ragdoll and NM files (`nm_blend_out_sets.meta`, tuning sets) | ENT-017, ENT-019, ENT-020 |
| `playerinfo.ymt` | GP-073 (hash the 5 unnamed entries against candidate names) |
| Shop catalogue (`shop_*` files), component `.ymt` | GP-081 (tag names to match the hashes in `shop_controller`), ON-049, ENT-015, GP-055, GP-057, ENT-010 (overlay and micro-morph lists, with the creator scripts) |
| Audio `.rel` (`sounds.dat54`, `dynamix.dat15`, `speech2.dat4.rel`), `.awc` lists | AUD-001, AUD-002, AUD-003, AUD-004, AUD-005, AUD-006, AUD-008, AUD-009, AUD-010 (+ the mission table) |
| Animation dictionaries (`.ycd`) and clip sets | REN-001, REN-002, REN-004, REN-005, REN-006 |
| Camera metadata | REN-008, REN-009 (+ hashes in the scripts), REN-011 |
| Particle and FX files (`.ypt`, `entityfx.dat`, `materialfx.dat`, `wheelfx.dat`) | REN-014, REN-015, REN-016 |
| Timecycle, `visualsettings.dat`, post-effect files | GP-027, REN-017, REN-021, REN-022, REN-024, REN-026, REN-027, WLD-017 |
| `gameconfig.xml` | SCR-014, PERF-025 |
| Archive listings (sizes, per pack, base vs update) | FF-001, FF-002, FF-003, FF-004 (+ one `re_` file), FF-005 (+ `fm_mission_controller`) |
| `settings.xml` before and after | PERF-005, PERF-006, PERF-022 |

### 2. Text files (`.gxt2` blocks, base + update + DLC, American)

| Input | Questions |
| --- | --- |
| `PSCHOOL` block | GP-047 (lesson names; then tie lessons to the 6 Mallard, 2 Cuban 800, 2 Maverick and 2 Frogger set-ups) |
| Shop blocks (`CSHOP_TITLE<n>`) | GP-082 |
| `BSS_BSTR_<n>` (an update or DLC block) | GP-090 company names |
| `mp2025_02` dialogue blocks | ON-018 |
| DLC text for creator libraries | ON-008 |
| Every block, hashed against string candidates | UI-018 (label index), ENT-005, ENT-006, UI-009 (interior names, with the map data) |

### 3. The executable (read-only reverse engineering)

GS-004, GP-025 and GP-087 (replay type numbers), GP-069 and GP-092 (ability entries 8 to 16), GP-080 (aim assist; also a test), CORE-002, CORE-016, CORE-018, CORE-024, CORE-027, CORE-031, CORE-032 (= ON-060, SCR-011), AI-001, AI-003, AI-006, ON-009, ON-052, GP-023, GP-087, GP-092, UI-020, REN-007, REN-012, SCR-004 (`0x8F5D1AD832AEB06C`), SCR-007 (a YSC dump), PERF-016.

### 4. In-game tests (story mode; most have a test card in their guide)

- **Gameplay:** GP-006, GP-039, GP-043, GP-049, GP-050, GP-053, GP-054, GP-062, GP-064, GP-068, GP-071, GP-072, GP-074, GP-075, GP-085, and GP-091 (controls test card 4: do old control numbers still work on 3717+?).
- **GP-088 and GP-089 remainders:** watch `Global_114904.f_8620[6]`, `[12]` and `[18]`, and the "released" bit of entries 36 (`MrsPhilips2`) and 54 (`Rampage3`).
- **Core and physics:** GS-003, CORE-001 (two packs), CORE-013, CORE-014, CORE-015, CORE-026, CORE-029, PHY-003, PHY-006, PHY-007, PHY-012, PHY-017.
- **Entities, AI and world:** ENT-004, ENT-007, ENT-016, ENT-018, ENT-022, ENT-027, ENT-032, ENT-033, AI-002, AI-004, AI-005, AI-007, AI-015, AI-018, AI-021, AI-025, AI-030, AI-037, AI-039, AI-044, AI-047, AI-049, WLD-003, WLD-012, WLD-013, WLD-014, WLD-016, WLD-018, WLD-019.
- **Audio, rendering, UI and scripting:** AUD-007, AUD-011, REN-003, REN-013, REN-018, REN-020, REN-023, UI-017, SCR-005, SCR-008, SCR-009, SCR-010, SCR-012, ON-058, ON-073 (read-only cloud check).
- **Performance (all measured on the test PC):** PERF-001, PERF-002, PERF-003, PERF-004 (needs a profiler such as Windows Performance Recorder), PERF-005 to PERF-011, PERF-014, PERF-015, PERF-017 to PERF-024, PERF-026 to PERF-028.

### 5. Scripts only (the decompile at commit `6c18d3e8`; no other input)

These can be done at any time. Most are long reads; pointers are in each row of `OPEN_QUESTIONS.md`.

- **Core:** CORE-009 (single-bit names), CORE-021 (`freemode` launches by request).
- **Story:** GP-001 (rest), GP-007 (handler states 2, 3, 5), GP-011 (golf AI), GP-019 (crew skill and the take), GP-021, GP-029, GP-031 (`finaleA`/`B` third target), GP-032 (the other flag IDs), GP-038 (per-scene checks).
- **Online:** ON-001, ON-005, ON-006 (job types 4 and 31), ON-010, ON-011, ON-012, ON-013, ON-014, ON-017, ON-023/ON-076 (classic heist elite), ON-024, ON-037, ON-039, ON-040, ON-043, ON-065, ON-069 (`am_pi_menu` pages), ON-070, ON-071, ON-074 (retry state 13). ON-002 has no names in the scripts at all, so it needs the executable or community names.
- **World:** WLD-002, WLD-006, WLD-008, WLD-009, WLD-010, WLD-011, WLD-015.
- **Entities and AI:**
  - ENT-014, AI-010, AI-032 (config flag numbers; names from NativeDB or community)
  - ENT-023, ENT-026, AI-008, AI-012, AI-013, AI-022, AI-023, AI-026, AI-031 (hash guesses), AI-038, AI-040, AI-041, AI-042, AI-043, AI-045, AI-046, AI-048, AI-050
- **Shops:** GP-083 (base-wardrobe tables in `clothes_shop_mp`; the labels' English text needs group 2).
- **Online creator rules:** FF-006 (how `fm_mission_controller` picks rules per team and stage).
- **Performance, scripting and UI:** PERF-012, PERF-013, SCR-001, SCR-002, SCR-003, SCR-006, SCR-013, UI-002.
- **Hashed tunable names** (ON-021, ON-035, ON-077, ON-072): a real name list is needed first. 311 names were recovered by hashing candidates; see the method below.

### 6. Ask the contributor or the community

GP-076 (which mod replaced the weapon files), REN-019 (each overhaul's own release notes), ON-053 (a tool idea; needs the maintainer, since tools live in `tools/`).

## Working method that saved tokens (reuse it)

- **Decompile:** use the community repository at commit `6c18d3e8` ("Update for 1.72-3725.0"):
  - Locally, clone it normally and use `git show 6c18d3e8:decompiled_scripts/<name>.c` and `git grep`.
  - Its `native_tables/` folder lists the native hashes per script and build; that's how CORE-030 was answered.
- **Small Python helpers**, kept outside the repo, did all the tracing:
  - Split call arguments by bracket depth.
  - Trace an argument back through wrapper functions to its literal (up to 3 levels).
  - Group identical runs of calls (this found the disable helpers).
  - Hash candidate names with `joaat`; check it with `weapon_pistol` = 453432689.
- **Vectors:** count vector arguments from the end. The decompiler writes a vector either as one `Vector(...)` or as three values.
- **Flow (`initial`):** data pools are shared between command types. Identify a command by the hash its builder writes, not by the pool. Each strand builder starts with `iVar0 = <strand id>`.
- **Unlock chains:** passing a stranger mission arms a `code_controller` entry (field 22 of its table row). That entry often sends a text or email that carries the next entry, which sets a flag ID.
- **Mark every claim:** Verified (read in the decompile or the files) or Known (community; for example the engine enum dump of build 3889, used for control and ability-type names).

## Next steps, in order

1. Pull `main-km1sze`.
2. Extract the inputs of groups 1 and 2 into a scratch folder in one CodeWalker session. Then answer those questions batch by batch, one doc per batch.
3. Run the group 4 test cards in one or two evenings and write the results into each guide.
4. Work through group 5 when there is time.
5. Refresh the graph (`/graphify . --update`), check that `grep -r "/home/\|C:\\\\Users" graphify-out` is empty, and commit.
6. Open the PR when the contributor asks, then update or delete this file.
