# Handoff: current status and what to do next (read this first)

State file for the next AI session or contributor, written so an agent with no history of this work can start here. It holds no game data and no personal paths. Update it as the work moves, and delete it when the work is done.

## The project in three lines

A public, Markdown-only reference on how GTA V (PC, Legacy, build 1.0.3725.0) works underneath, for modders. [`CLAUDE.md`](/CLAUDE.md) has the rules and [`ROADMAP.md`](/ROADMAP.md) the topics. The current work is the **second pass**: answering the numbered questions in [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md).

## Status

- **Everything is on `main`, nothing is in flight.** The last merges are #127 (second-pass phases 1 to 4), #128 (data batches D1 to D6), #129 (D7 to D12) and #130 (this file).
- **Tracker:** 442 question rows: 192 answered, 49 mostly, 57 partly, 144 open (after the leftovers pass on branch `research/pass2-leftovers`, PR #132). A row's last column is its status and links to the guide section with the answer. The table "Leftovers: the data-file batches" in `OPEN_QUESTIONS.md` says what each batch read and settled.
- **The data batches are finished, but not every row in [`DATA-NEEDS.md`](/DATA-NEEDS.md) was worked.** Each group had a batch, and each row a batch touched carries its result (*done*, *mostly*, *partly* or *still open*). The 25 rows with no tag were never attempted; they are listed below.
- **The knowledge graph is current as of PR #132** (2026-11-04). The 80 docs changed in #127, #128, #129 and #132 were re-extracted, giving 4,716 nodes, 10,010 edges and 193 communities. Refresh it again after the next phase.

## What needs game files and what doesn't

Decide first what your environment can do. **The game install, CodeWalker and the in-game tests are only on the maintainer's own PC.** A cloud session has the repo and can clone the public decompile, and nothing else. Extracted files and the helper scripts from earlier sessions were kept outside the repo and are not available.

| Work | Needs | Cloud? |
| --- | --- | --- |
| Refresh the knowledge graph | The repo | **Yes, do this first** |
| Docs housekeeping (KG-001 to KG-004) | The repo and the graph | Yes |
| Scripts-only questions | A clone of the decompile | **Yes, this is the main body of work** |
| Data rows not attempted | Game files, CodeWalker on Windows | No |
| The executable | `GTA5.exe`, read-only | No |
| In-game tests | The game in story mode | No |

## Next steps, in order

1. **Refresh the graph after each phase:** in a cloud session graphify isn't installed: run `pip install graphifyy`, then `graphify install --platform claude`, and the `/graphify` skill becomes available; then run `/graphify . --update`. Docs are extracted by subagents, about 140k tokens per 120 KB of Markdown. If the export refuses because saved nodes are missing, check that all the missing nodes come from the re-extracted files, then export with `force=True`. Watch for node IDs that collide with a page's ID (a concept on `native-usage.md` named after a namespace page). Before committing, check that `grep -r "/home/\|C:\\\\Users" graphify-out` is empty; set `graphify-out/.graphify_root` back to `.` first, because graphify writes its absolute scan path there. On a CRLF checkout graphify sees every file as changed; normalise the hashes rather than converting the tree to LF.
2. **Links are checked:** every relative link and heading anchor in the repo resolves (the 105 anchor links #129 added included). One stale anchor in `scripting/script-vm.md` was fixed. Re-run a link check after each phase.
3. **Work through the scripts-only table below,** one branch per phase, batches pushed as you go. Rebuild what you need of the working method below.
4. **When the maintainer is at the PC:** the data rows, the executable and the in-game test cards.

## Rules of this workflow that aren't in `CLAUDE.md`

The maintainer set these in earlier sessions. Keep them, and ask if one gets in the way.

- **Branches:** one branch per phase, in its own worktree or clone, because other sessions may share the main folder. Commit and push per batch, with one PR for the phase. The maintainer decides when to merge. After a merge, delete the branch locally and on origin, and remove its worktree.
- **The graph:** refresh it once per phase, not per batch or PR, because it costs a lot of tokens. Don't add it to data branches.
- **New gaps:** a gap found while researching becomes a numbered row in `OPEN_QUESTIONS.md`, a row in the guide's open questions and an updated total, all in the same edit.
- **Answering a question:** update the guide's open-question row, the `OPEN_QUESTIONS.md` row (with a link to the section) and, if it applies, the `DATA-NEEDS.md` tag. Call a question answered only if it really is: use *mostly* or *partly* otherwise, and keep the two files in step. A review on #129 caught rows marked done too early.
- **Check your numbers** against the raw output before committing. Earlier batches caught wrong counts and over-claims this way. Write "our reading" for anything inferred, and before writing "no native does X", check NativeDB.
- **Line endings:** files are LF in git. If your checkout is CRLF, keep each file's existing endings when editing.

## Data rows not attempted, and gaps the batches left

**Never attempted** (`DATA-NEEDS.md` names the file for each): AI-024, PHY-011, PHY-013, PHY-014, ENT-038, ENT-039, REN-011, PHY-001, PHY-004, ENT-017, ENT-019, ENT-020, PHY-005, UI-009, AI-014, AI-033, AI-009, ENT-025, GP-055, GP-057, ENT-010, FF-005, PERF-005, PERF-022, PERF-006, UI-018. Of these, FF-005, GP-055, GP-057 and ENT-010 lean mostly on the scripts, so they may be possible from the decompile alone. UI-009, GP-057, ENT-010 and UI-018 have partial answers from the earlier passes. D12 tried UI-018 again and didn't clearly improve it.

**Partial results, and what would finish them:**

| ID | What is missing |
| --- | --- |
| GP-035 | World-point placements: not in ymap extensions, archetype effects, scenario types or chaining nodes, so the source is still unknown |
| AUD-004, AUD-009 | The byte arrays in `speech2.dat4.rel` that hold each voice's contexts; CodeWalker doesn't decode them, so they need a format reader |
| WLD-005 | About 715,000 story-map entities is an estimate; it depends on which pack change sets apply in story mode |
| ENT-030, ENT-035 | The exact meaning of each car generator flag bit (a test), and the group hash `F85943A6` |
| ENT-002, ENT-003 | How many fragments break (needs the `.yft` files); rayfire objects inside interiors (the MLO entity lists in `.ytyp`) |
| PHY-016, PHY-018 | The body of `waterheight.dat`; where swimming pools are defined |
| REN-008 | Shake names: needs another name source |

## What each remaining question needs

Story mode only; never test in GTA Online. Some lists below were written before the data batches, so check a question's row in `OPEN_QUESTIONS.md` before starting it.

### The executable (read-only reverse engineering)

GS-004, GP-025 and GP-087 (replay type numbers), GP-069 and GP-092 (ability entries 8 to 16), GP-080 (aim assist; also a test), CORE-002, CORE-016, CORE-018, CORE-024, CORE-027, CORE-031, CORE-032 (= ON-060, SCR-011), AI-001, AI-003, ON-009, ON-052, GP-023, GP-087, GP-092, UI-020, REN-007, REN-012, SCR-004 (`0x8F5D1AD832AEB06C`), SCR-007 (a YSC dump), PERF-016, GP-021 (the mission triggerers' per-mission function tables, read with a YSC reader).

### In-game tests (story mode; most have a test card in their guide)

- **Gameplay:** GP-006, GP-039, GP-043, GP-049, GP-050, GP-053, GP-054, GP-062, GP-064, GP-068, GP-071, GP-072, GP-074, GP-075, GP-085, and GP-091 (controls test card 4: do old control numbers still work on 3717+?).
- **GP-088 and GP-089 remainders:** watch `Global_114904.f_8620[6]`, `[12]` and `[18]`, and the "released" bit of entries 36 (`MrsPhilips2`) and 54 (`Rampage3`).
- **Core and physics:** GS-003, CORE-001 (two packs), CORE-013, CORE-014, CORE-015, CORE-026, CORE-029, PHY-003, PHY-006, PHY-007, PHY-012, PHY-017.
- **Entities, AI and world:** ENT-004, ENT-007, ENT-016, ENT-018, ENT-022, ENT-027, ENT-032, ENT-033, AI-002, AI-004, AI-005, AI-007, AI-015, AI-018, AI-021, AI-025, AI-030, AI-037, AI-039, AI-044, AI-047, AI-049, WLD-003, WLD-012, WLD-013, WLD-014, WLD-016, WLD-018, WLD-019.
- **Audio, rendering, UI and scripting:** AUD-007, AUD-011, REN-003, REN-013, REN-018, REN-020, REN-023, UI-017, SCR-005, SCR-008, SCR-009, SCR-010, SCR-012, ON-058, ON-073 (read-only cloud check).
- **Performance (all measured on the test PC):** PERF-001, PERF-002, PERF-003, PERF-004 (needs a profiler such as Windows Performance Recorder), PERF-005 to PERF-011, PERF-014, PERF-015, PERF-017 to PERF-024, PERF-025 (physics cost, test card 5), PERF-026 to PERF-028.

### Scripts only (the decompile at commit `6c18d3e8`; no other input)

**Phase 1 to 4 leftovers still open**. Each has a starting point:

| ID | Where to start |
| --- | --- |
| GP-021 | Leftovers pass (branch `research/pass2-leftovers`): the set-ups are called only through `Call_Loc` on a per-mission table, so the decompile can't map them. Needs a YSC reader for the table's function addresses (moved to the executable list). The label prefixes are matched by name |
| GP-038 | Trevor's pickers are done (leftovers pass). Left: the per-scene validity check (`func_670` / `func_636` at this build in `player_controller_b`) |
| GP-011 | Answered (leftovers pass): `golf` and the two ambient foursome scripts |
| GP-083 | Done for the 77 base table functions (leftovers pass). Left: where the pack-coded sets (`CLO_GRF_U_`, `CLO_IEF_U_`, `CLO_BIF_U_`) get their prices |
| CORE-009 | 18 bits read (leftovers pass). Left: `.f_203` bits 2, 5 to 8, 30 and 31 (one 127-line `freemode` function about tutorial sessions) and the mod shop bits (`carmod_shop`) |
| CORE-021 | `freemode`'s request launches are done (leftovers pass). Left: `player_controller`'s other scenes. The "296" and "240" are not in conflict: the launch graph gives 296 before its third pass and 240 after |
| UI-002 | Not a scripts question: what's left is in-game test card 2 in the pause menu guide |
| ON-006 | Leftovers pass: type 4 is set by six creators from `goto.atrig`, and nothing writes 31. Left: the names (a text or engine source) |
| ON-069 | Partly done: greying layers, per-page counts, Preferences, armour and vehicle pages (21.3.2). Left: the other pages' checks, helper by helper |
| ON-070 | Leftovers pass: `.f_2` is traced to the corona request; lobby bit 1 is "joined another player's transition". Left: `.f_880`'s exact meaning, `main_persistent`'s four setter branches |
| ON-065 | Leftovers pass: all slots and indices tied (slot 30 never owned, 33 to 35 the mansions). Left: indices 130, 131 and 134, which no slot is given |
| ON-049 | Leftovers pass: key shapes, 157 literal keys, eight of ten price categories named. Left: the names of category hashes 426439576 and 1999830656 |
| ON-001 | `freemode`'s 183 running-state functions (ON-005, the host rotation, was answered in the leftovers pass) |
| ON-011 to ON-014, ON-017 | Race checkpoint fields (ON-011 partly done in the leftovers pass: scales, pitch, key map, a dozen bits; left: the other bits' names), the other creators' placement (ON-013 partly done: shared 41-section writer, survival wave keys; left: menus and limits), the flow stats (ON-014 partly done: storage for 18 flows, EXEC_FLW step by step), the After Hours / Doomsday / 2015 flows (ON-017 partly done: call blocks BATFMAU and XMFMAUD, help families; left: subtitles, data) |
| ON-024, ON-040 | Heist story arcs and contacts (ON-024 partly done: scripts and dialogue blocks per heist; left: the lines, data); business battles (ON-040 partly done: scripts, 34 variations, cargo types; left: payouts) and the other `fm_content_*` business missions |
| ON-035, ON-021 | Nightclub popularity cases are hashed tunables: needs a name list (see ON-072 method). ON-077 answered in the leftovers pass (production times, technician bits). ON-021 mostly done in the leftovers pass (Cayo loot ranges from their use in `heist_island_planning`); left: bag capacity |
| ON-037, ON-043 | Production while offline (stats) (ON-037 partly done: network-time timer, cloud-time delay timer; left: stat load and save), simple-interior entrances per type (ON-039, how the challenge percentages combine, was answered in the leftovers pass) |

**Other categories (leftovers pass, 2026-11-04):**
- **Done or partly done from the decompile:** AI-008, AI-040, AI-041, AI-042, AI-045, AI-046; SCR-001, SCR-002, SCR-006; PERF-012, PERF-013 (see each row in `OPEN_QUESTIONS.md`).
- **Also done later in the session:** FF-006 (rules per team, `nxtrulb` branching), GP-011 (the ambient golfers), GP-038 (the draw and the 15 scene tests; five tests' meaning left), ON-049 (1999830656 is `CATEGORY_WAREHOUSE_INTERIOR`).
- **Still scripts-only, but low yield from the decompile alone:** ENT-014 and AI-032 (flag names), AI-031 (hash guesses), CORE-021's `player_controller` scenes, CORE-009's last bits.
- **Online rows tried and stopped:**
  - ON-021 (bag capacity): not next to the loot tunables; the tunable names are hashed.
  - ON-049 (category 426439576): 15.5 million candidate names tried.
  - ON-065 (indices 130, 131, 134): nothing ever assigns them, which is likely the answer.
  - ON-070 (`main_persistent`'s four setter branches): they hang on unnamed transition flags (`Global_2685150.f_787.f_5`, `.f_7`, `.f_10`).
  - ON-001, ON-011 to ON-014, ON-017, ON-024 and ON-040 need long per-function reading and give names only by inference.
- **Need local game files or the game:** SCR-002's last 54 natives (a YSC reader or a call logger), SCR-003 (in-game tests of unused natives; SCR-006's 1,845 Online-only natives are the candidates), PERF-013's file list (`content.xml` of the 43 `GROUP_ON_DEMAND` packs, in DATA-NEEDS), AI-041's live enemy count, AI-010, AI-012, AI-013, AI-022 (engine or tests).

### Docs housekeeping from the knowledge graph

Done in the KG housekeeping pass (branch `docs/kg-housekeeping`). KG-002, KG-003 and KG-004 are answered and KG-001 is mostly answered; see their rows in `OPEN_QUESTIONS.md`. The graph now covers Markdown only, with the excludes in `graphify-out/.graphify_build.json`.

### Ask the contributor or the community

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

**For the data batches (Windows, CodeWalker's library from PowerShell):**

- Load each file type with its class: `YmapFile` (`CarGenerators`, `TimeCycleModifiers`, `AllEntities`), `YtypFile` (`AllArchetypes`, `CompositeEntityTypes`), `YmfFile`, `YndFile` (counts in `NodeDictionary`), `YnvFile`, `YptFile` (`AllEffects`), `RelFile` (`RelDatas`). For scenario regions use `YmtFile.CScenarioPointRegion`; `ScenarioRegion` came back empty.
- PowerShell traps: variable names ignore case (`$K` and `$k` are the same), `H` is an alias for `Get-History`, and `powershell -File` drops array arguments (pass one comma-separated string).
- One listing of every archive entry with its sizes answers many questions. For a binary entry a file size of 0 means stored uncompressed, and the real size is the uncompressed one; for a resource use system plus graphics size. Check the sum against the archives on disk.
- Dump all American `.gxt2` text once (hash, file, text) and look labels up by `joaat`. Build a big name list for hashes from all decompile string literals, every file name in the archives and every name in the extracted data.
- One copy per file name wins: update over DLC over base. Watch for DLC packs shipping renamed copies of base map sections (`hei_`, `apa_`, `lr_`, `bkr_`): plain entity sums count them twice.
- In edit scripts, beware Python string escapes: a backslash before `a` once became a control character in a guide. Scan for control characters before committing.
