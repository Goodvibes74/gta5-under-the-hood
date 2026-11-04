# Open questions: the second pass

Every open question from every first-pass guide, in one place. All 108 roadmap topics have a first-pass guide, and each guide ends with an "Open questions" table. This file collects those tables, plus the questions that were only written into a guide's text, so the **second pass** of the research can be planned and tracked from one list.

**How it was made.** Collected on 2026-10-25 from the `main` branch: every `.md` file under `docs/`, `scripting/`, `file-formats/` and `modding/` was scanned for headings that contain "Open questions", and every row of the table under each one was taken, 396 rows from 97 guides. The guides' text was also searched for "open question", "not decoded" and similar phrases outside those tables, which added 13 questions (marked *from the guide's text*). One row was already answered elsewhere and is listed at the end instead. Guides written later add their questions with the next free ID in their category (R6.7, 2026-10-26: GP-081 to GP-086; the R7.6 second pass: ON-065, ON-066). The roadmap ID after each guide comes from [ROADMAP.md](/ROADMAP.md). The questions are copied as the guides word them; the guide stays the place where the answer goes.

## How the second pass works

1. **Pick a question.** Use its ID (`AI-007`, `ON-031` ...) in the issue title, for example `AI-007: ped AI LOD distances`. Several questions from the same guide can go in one issue.
2. **Branch** as [CONTRIBUTING.md](/CONTRIBUTING.md) says for a second pass: `research/<roadmap ID>-pass2-<what>`, for example `research/R17.7-pass2-ai-lod-distances`.
3. **Answer it in the guide**, with the same rules as the first pass: mark the answer **Verified** or **Known**, say how you counted, quote names and numbers only, never Rockstar code. Then change the guide's own table row to say where it was answered (or delete the row).
4. **Update this file in the same pull request:** set the row's status to **Answered** with a link to the section, or **Partly answered** with what is left. Don't renumber IDs; an answered ID stays answered.
5. **New questions** found while answering go into the guide's table first, then here, with the next free ID in that category.

**Status values:** **Open**, **Partly answered** (some of it is in a guide; the cell says what is left), **Answered** (link to the answer).

## Where the work is

What the "Where it goes" column asks for, counted over all 408 open questions (a question can count more than once):

| Kind of work | Questions | Good for |
| --- | --- | --- |
| A second pass of the same topic (more reading of the scripts or data) | 203 | Anyone who has done a first pass |
| A link to another roadmap topic (answer it there, or together with it) | 147 | Pairing two guides on one branch |
| An in-game test (a test card someone runs and reports) | 83 | Contributors who can't read decompiled scripts but can play |
| Engine reverse engineering (not visible in scripts or data files) | 6 | Contributors with a disassembler |

The topics that open questions point to most often are R4.6, R5.1 and R5.2 (6 each), then R18.3 (5) and R1.2, R1.6, R2.2, R3.1, R5.3, R7.1, R7.2 and R7.7 (4 each). Answering one of those topics' second pass closes questions in several guides at once.

**Suggested batches to start with:**

- **An in-game test session:** collect the in-game-test rows of one category into a single test card and play through it in one evening.
- **One guide at a time:** the guides with the most open questions are the Online creator internals (8), time and weather, timecycles and post effects, heists, and respawn, death and arrest (7 each).
- **The links:** pick a topic from the list above and answer every question that points to it.

## Priority order (set 2026-10-25)

The second pass works through the 196 questions of these four areas (and the test and engine questions with them) in this order: **1. the user interface, 2. the core engine, 3. GTA Online** (the interaction menu, jobs, properties, businesses, heists and everything else a player does there), **4. story mode and offline play** (missions, activities, the player). The other categories (entities, physics, AI, the world, audio, rendering, performance, scripting, file formats) wait until these are done, except where a question below needs one of them.

The questions are grouped into **batches**. A batch is one branch and one pull request: its questions share a guide, a script or a data file, so reading the source once answers most of them. Work the batches top to bottom inside a phase; a batch can start before the one above it is finished.

**Kind** says what the batch needs: *scripts* (the decompile), *data* (extracted game files), *test* (an in-game test card someone has to play), *engine* (reverse engineering the executable). Questions that need only a test or the engine are listed separately at the end of each phase so a script-reading pass doesn't stall on them.

**Batch status:** **Open**, **In progress** (branch named), **Partly done** (pull request linked, with what is left), **Done** (pull request linked). Each question keeps its own status in the tables further down.

### Phase 1: the user interface

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P1.1 | [Pause and Online menus](/docs/ui/pause-menu.md) (R8.1): the full menu tree and `frontend.xml` | UI-004, UI-006 | data | Done, [#107](https://github.com/Goodvibes74/gta5-under-the-hood/pull/107) |
| P1.2 | [Text labels](/docs/ui/text-labels.md) (R8.3): text slots, the label-name index, the `update2.rpf` blocks, and the labels other guides couldn't read | UI-016, UI-018, UI-019, CORE-004, CORE-008, GP-013 | scripts, data | Done, [#108](https://github.com/Goodvibes74/gta5-under-the-hood/pull/108) |
| P1.3 | [HUD, colours and blips](/docs/ui/hud-colours-blips.md) (R8.4): blip sprite names and the `[HD]`/`[CRT]` colours | UI-001, UI-003 | data | Done, [#109](https://github.com/Goodvibes74/gta5-under-the-hood/pull/109) |
| P1.4 | [Scaleform movies](/docs/ui/scaleform.md) (R8.2): movies loaded through variables, DLC movies, each movie's methods, interior maps | UI-007, UI-008, UI-009 | scripts, data | Done, [#110](https://github.com/Goodvibes74/gta5-under-the-hood/pull/110) (61 interior maps left) |
| P1.5 | [Story-mode UI](/docs/ui/story-mode-ui.md) (R8.6): the stat list, mission stats and medals, the mission-passed screen | UI-013, UI-014, UI-015, GP-015 | scripts, data | Done, [#111](https://github.com/Goodvibes74/gta5-under-the-hood/pull/111) |
| P1.6 | [Server-backed Online screens](/docs/ui/server-backed-screens.md) (R8.5): what `pausemenu_multiplayer` fills, the signed-out guards, leaderboard IDs | UI-005, UI-010, UI-012 | scripts | Done, [#112](https://github.com/Goodvibes74/gta5-under-the-hood/pull/112) and [#120](https://github.com/Goodvibes74/gta5-under-the-hood/pull/120); new UI-020 (third pass) |
| P1.7 | Subtitles and phone-call lines (R5.6 with R8.6) | GP-008 | scripts | Done, [#113](https://github.com/Goodvibes74/gta5-under-the-hood/pull/113) |

Test only: UI-002 (draw lists and depths), UI-017 (which DLC text block wins a clash). UI-011 (transactions per business app) is answered with P3.8.

### Phase 2: the core engine

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P2.1 | [Boot](/docs/00-getting-started/boot.md) and [runtime scripts](/docs/core/runtime-scripts.md) (R1.2, R0.2): how `main`, `initial` and `startup` start, force-cleanup bits, `profiler_registration`, level index 5, the path to `prologue1` | CORE-017, CORE-018, CORE-019, GS-001, GS-002, ON-060 | scripts | Done for scripts, [#114](https://github.com/Goodvibes74/gta5-under-the-hood/pull/114) and [#120](https://github.com/Goodvibes74/gta5-under-the-hood/pull/120) (CORE-018's engine side needs the executable); new GS-004, CORE-032 (third pass) |
| P2.2 | [The global map](/docs/core/global-map.md) (R0.4): the player and server broadcast data, blocks 13 and 15, the **Known** rows | CORE-009, CORE-011, CORE-012, ON-003, ON-050 | scripts | Mostly done, [#115](https://github.com/Goodvibes74/gta5-under-the-hood/pull/115), [#120](https://github.com/Goodvibes74/gta5-under-the-hood/pull/120) and branch `research/second-pass-phase2-leftovers` (single-bit names of `.f_204`/`.f_203` and field-by-field server layouts left) |
| P2.3 | [Saves](/docs/core/saves.md) (R1.7): the full section tree, the save upgrade, spending categories | CORE-022, CORE-023, GP-004 | scripts | Done, [#121](https://github.com/Goodvibes74/gta5-under-the-hood/pull/121) |
| P2.4 | [Completion and autosave](/docs/core/completion-and-autosave.md) (R5.3): autosave triggers, completion flags, the 23 achievements, the retry snapshot, mission replays | CORE-005, CORE-006, CORE-007, CORE-025, GP-018, GP-020, GP-033 | scripts | Done, [#121](https://github.com/Goodvibes74/gta5-under-the-hood/pull/121) and branch `research/second-pass-phase2-leftovers` (four type 8/10 achievement stats unnamed) |
| P2.5 | [Archives and content](/docs/core/archives-and-content.md) (R1.6): load phases per change set, `update2.rpf` and the mods folder copy | CORE-002, CORE-003 | data | Partly done, [#121](https://github.com/Goodvibes74/gta5-under-the-hood/pull/121) (the moment each change-set group runs needs the executable) |
| P2.6 | [Script launch graph](/scripting/script-launch-graph.md) (R0.5): table-driven launches, and the scripts nobody starts by name | CORE-021, GP-009, GP-040 | scripts | Mostly done, [#121](https://github.com/Goodvibes74/gta5-under-the-hood/pull/121) and branch `research/second-pass-phase2-leftovers` (`freemode`'s launches by request left) |
| P2.7 | [Streaming](/docs/core/streaming.md) and [memory](/docs/core/memory-and-pools.md) (R1.5, R1.4): the SRLs, pool slot costs, vanilla weapon array sizes | CORE-015, CORE-016, CORE-028 | scripts, engine | Partly done, [#121](https://github.com/Goodvibes74/gta5-under-the-hood/pull/121) (CORE-028 answered; pool slot costs and the built-in weapon array sizes need the executable) |

Test only: GS-003 (does the return to story mode restart every script), CORE-001 (overlay or replace between two packs), CORE-013, CORE-014 (pool use in a heavy session), CORE-026, CORE-027, CORE-029 (streaming and memory measurements). Engine only: CORE-024 (the save file format). Later: CORE-030 (natives changed in build 3889, with R11.1).

### Phase 3: GTA Online

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P3.1 | [Interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10): the full interaction-menu tree, story phone slots, website pages, phone models | ON-026, ON-027, ON-028, ON-029 | scripts | Done, branch `research/second-pass-phase3`; new ON-067, ON-068, ON-069 |
| P3.2 | [The job lobby](/docs/online/job-lobby.md) (R7.5): launcher states, start arguments, corona settings, playlists, walk-in markers, job types | ON-030, ON-031, ON-032, ON-033, ON-034, ON-006 | scripts | Mostly done, branch `research/second-pass-phase3`; job types 4 and 31 moved to the third pass (ON-006); new ON-070, ON-071 |
| P3.3 | [Inside `freemode`](/docs/online/07-freemode.md) and [sessions](/docs/online/sessions-and-sync.md) (R7.1, R15.1): the event ids, the host's rotation, the running-state functions per system | ON-001, ON-002, ON-005, ON-051 | scripts | Partly done, branch `research/second-pass-phase3` (ON-051 answered, ON-005 mostly, ON-002 partly); ON-001 and the rest of ON-002 and ON-005 moved to the third pass |
| P3.4 | [Transitions](/docs/online/transitions-and-sessions.md) (R7.2): the offline branch, character slots, the way back to story mode, the testbed session, what opens the creator | ON-004, ON-061, ON-062, ON-063, ON-064, GP-059 | scripts | Done, branch `research/second-pass-phase3`; new ON-074 |
| P3.5 | [Stats and tunables](/docs/online/stats-and-tunables.md) (R7.3): the tunable index, save categories, the shop basket, unnamed service readers | CORE-010, ON-047, ON-054, ON-055, ON-056, GP-058 | scripts | Done, branch `research/second-pass-phase3`; new ON-072, ON-073 |
| P3.6 | [The Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5): unlabelled morphs, slider scaling, outfit groups | GP-055, GP-056, GP-057 | scripts | Partly done, branch `research/second-pass-phase3` (GP-056 answered, GP-057 partly); GP-055 and the rest of GP-057 moved to the third pass |
| P3.7 | [Properties](/docs/online/properties.md) (R7.6): yachts and vehicles as properties, garages, entrances, instances, daily fees | ON-041, ON-042, ON-043, ON-044, ON-045, ON-046 | scripts | Partly done, with ON-028, branch `research/second-pass-phase3` (ON-065 mostly, ON-042 and ON-043 partly); the rest of ON-042, ON-043 and ON-065, and ON-066, moved to the third pass |
| P3.8 | [Organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7): production numbers, capacities, offline production, boss costs, challenges, business missions, transactions | ON-035, ON-036, ON-037, ON-038, ON-039, ON-040, ON-049, UI-011 | scripts | Mostly done, branch `research/second-pass-phase3` (ON-036, ON-038, UI-011 answered, ON-035 and ON-039 mostly); ON-037, ON-040, ON-049 and the rest of ON-035 and ON-039 moved to the third pass; new ON-075, ON-077 |
| P3.9 | [Heists](/docs/online/heists.md) (R7.8): fail bands, casino targets, Cayo loot, the classic planning board, elite rewards, story arcs, crew skill | ON-019, ON-020, ON-021, ON-022, ON-023, ON-024, ON-025, GP-019 | scripts | Mostly done, branch `research/second-pass-phase3` (ON-019, ON-020, ON-022, ON-025 answered, ON-023 mostly, GP-019 partly); ON-021, ON-024 and the rest of ON-023 and GP-019 moved to the third pass; new ON-076 |
| P3.10 | [DLC storylines](/docs/online/dlc-storylines.md) (R7.9): stats per flow step, voice-only flows, arrival updates, missing flows, mp2025_02 | ON-014, ON-015, ON-016, ON-017, ON-018 | scripts, data | Mostly done, branch `research/second-pass-phase3` (ON-015, ON-016 answered, ON-018 partly); ON-014, ON-017 and the rest of ON-018 moved to the third pass |
| P3.11 | [Creator internals](/docs/online/creator-internals.md) (R7.11): prop limits, hidden libraries, the two prop writers, checkpoint fields, other creators' placement | ON-007, ON-008, ON-010, ON-011, ON-012, ON-013 | scripts | Partly done, branch `research/second-pass-phase3` (ON-007 answered); ON-008 and ON-010 to ON-013 moved to the third pass |
| P3.12 | [Story systems in an Online mode](/docs/online/story-systems-in-online-mode.md) (R5.7): the shop table, ped brain sets | ON-057, ON-059 | scripts | Done, with R6.7, branch `research/second-pass-phase3`; new CORE-031 |

Test only: GP-054 (parent head counts), ON-058 (story clothes shop with a freemode ped; single player only). Engine only: ON-009 (creator budget), ON-052 (migration). Later: ON-048 (service natives in story scripts), ON-053 (a tunables list tool; needs the maintainer, as `tools/` does).

### Phase 4: story mode and offline play

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P4.1 | [Story flow](/docs/gameplay/missions/story-flow.md) (R5.1): the remaining command types, table fields, hidden missions, fails, the flow integers, the active triggerer | GP-028, GP-029, GP-030, GP-031, GP-032, CORE-020 | scripts | Mostly done, branch `research/second-pass-phase4` (GP-028, GP-030, CORE-020 answered, GP-031 mostly, GP-029 and GP-032 partly); new CORE-033 |
| P4.2 | [Mission anatomy](/docs/gameplay/missions/mission-anatomy.md) and [replay](/docs/gameplay/missions/replay-director-and-editor.md) (R5.2, R5.8): skip flags, replay states, lead-ins, replay event types, director mode areas | GP-016, GP-017, GP-021, GP-022, GP-024, GP-025, GP-026 | scripts | Mostly done, branch `research/second-pass-phase4` (GP-016, GP-017, GP-022, GP-024, GP-026 answered, GP-021 and GP-025 partly); new GP-087 |
| P4.3 | [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md) (R5.5): medal thresholds, golf, activity unlocks, towing bonus | GP-010, GP-011, GP-012, GP-014 | scripts | Mostly done, branch `research/second-pass-phase4` (GP-010, GP-014 answered, GP-012 mostly, GP-011 partly); new GP-088 |
| P4.4 | [Strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) (R5.4): unlock conditions, world points, brain flags | GP-034, GP-035, GP-036 | scripts, data | Mostly done, branch `research/second-pass-phase4` (GP-036 answered, GP-034 mostly; GP-035 moved to the third pass); new GP-089 |
| P4.5 | [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (R5.6): the cutscene files and `dialogue_handler`'s globals | GP-005, GP-007 | scripts, data | Done, branch `research/second-pass-phase4` (GP-005 answered, GP-007 mostly) |
| P4.6 | [Character switching](/docs/gameplay/player/character-switching.md) (R6.1): saved character state, the scene table | GP-037, GP-038 | scripts | Done, branch `research/second-pass-phase4` (GP-037 answered, GP-038 mostly) |
| P4.7 | [Respawn](/docs/gameplay/player/respawn-death-and-arrest.md) and [health](/docs/gameplay/player/health-armour-death.md) (R6.2, R3.8): the building table, free respawns, hospital packs, armour items, DLC health configs | GP-060, GP-061, GP-063, GP-065, GP-066, GP-051, GP-052 | scripts, data | Done, branch `research/second-pass-phase4` (all seven answered) |
| P4.8 | [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) (R3.9): stock prices, pickup placement, shop robbery pay | GP-001, GP-002, GP-003 | scripts | Done, branch `research/second-pass-phase4` (GP-002, GP-003 answered, GP-001 mostly); new GP-090 |
| P4.9 | [Controls and camera](/docs/gameplay/player/controls-and-camera.md) (R6.4): control names, disable helpers, context numbers | GP-041, GP-042, GP-044 | scripts, data | Done, branch `main-km1sze` (all three answered; control IDs from 257 up shifted by 37 in build 3717); new GP-091 |
| P4.10 | [Skills](/docs/gameplay/player/skills-and-abilities.md), [flying](/docs/gameplay/player/flying.md) and [weapons](/docs/gameplay/weapons/weapons.md) (R3.6, R3.4, R3.1): skill gains, ability types, starting skills, DLC flying blocks, flight lessons, AI flight missions, weapon unlocks, ammo caps | GP-067, GP-069, GP-070, GP-045, GP-046, GP-047, GP-048, GP-077, GP-078 | scripts, data | Done, branch `main-km1sze` (GP-067, GP-070, GP-048, GP-077 answered, GP-069 and GP-047 partly; GP-078 moved to the third pass; GP-045 and GP-046 need the data files, not available in this session); new GP-092 |

Test only (one evening's test card for the phase): GP-006 (cutscene flag bits), GP-039 (switch flags), GP-043 (two scripts disabling controls), GP-091 (old control numbers on build 3717+), GP-049, GP-050, GP-053 (regeneration, hurt thresholds, armour split), GP-062, GP-064 (arrest weapons, respawn point choice), GP-068 (shooting, strength, stealth), GP-071, GP-072, GP-075 (breath, drowning, swim speed). Engine: GP-023 (what NoEditorRestrictions patches). Elsewhere: GP-027 (R13.2), GP-073 (swimming stat entries), GP-074 (R2.3), GP-076 (a question for the install's owner), GP-079 (R2.5), GP-080 (R3.2).

### Leftovers: the data-file batches ([DATA-NEEDS](/DATA-NEEDS.md))

Started 2026-11-03 on branch `research/second-pass-leftovers-data`. Each batch extracts one group of game files into a scratch folder outside the repo and answers the questions that need them.

| Batch | Files | Questions | Status |
| --- | --- | --- | --- |
| D1 | Every American `.gxt2` text block (base, `update.rpf`, `update2.rpf`, DLC); every `vehicles.meta`, `handling.meta`, `carcols` and `carvariations` (base, update, DLC, `dlc_patch`) | GP-090, GP-047, GP-082, ENT-005, GP-045, GP-046, ENT-036, ENT-037, ON-068 | Done: GP-045, GP-046, ENT-005, ENT-036 answered; GP-047, GP-082, GP-090, ENT-037 mostly; ON-068 narrowed (not a vehicle), then answered from the scripts (the four package items) |
| D2 | `explosion.ymt` (update), all 19 `explosion.meta` (16 packs + 3 `dlc_patch`), every `*weapon*.meta` and `*ammo*.meta` (base, update, DLC, `dlc_patch`) | GP-078, GP-079, PHY-008, PHY-009, PHY-010 | Done: GP-079, PHY-010 answered; PHY-008, PHY-009 mostly; GP-078 partly |
| D3 | `water.xml`, `water_heistisland.xml`, `waterheight.dat`, `water.dat`, `watertune*.xml` | PHY-015, PHY-016, PHY-018, PHY-005 | Done: PHY-015 answered; PHY-016, PHY-018 partly; PHY-005 waits for the collision files (map-data batch); new: Cayo Perico's own water file |
| D4 | `dispatch.meta`, `crimeinformation.meta`, `wantedtuning.ymt`, `playerinfo.ymt`, `zonebind.ymt`, `popcycle.dat`, `popzone.ipl`, `popgroups.ymt`, `pedpersonality.ymt` (extracted) | AI-034, AI-035, AI-036, ENT-021, ENT-024, GP-073 | Done: AI-036, ENT-021 answered; AI-034 mostly; AI-035, ENT-024, GP-073 partly. The personality questions (AI-011, AI-016, AI-017, AI-019, AI-020, ENT-013) are the next batch |
| D5 | `pedpersonality.ymt`, every `peds.ymt` / `peds.meta`, `relationships.dat` | AI-011, AI-016, AI-017, AI-019, AI-020, ENT-013 | Done: AI-011, AI-016 answered; AI-017, ENT-013 mostly; AI-019 partly; AI-020 needs the executable |
| D6 | The 164 freemode shop catalogue files, 22 DLC component `.ymt` files, `shop_vehicle`, `shop_weapon` and `shop_tattoo` files | GP-081, ENT-015, ON-049, GP-055, GP-057, ENT-010 | Done: ENT-015 answered, GP-081 partly. ON-049 is about the server's transaction catalogue, which no game file holds; GP-055, GP-057 and ENT-010 need the creator scripts more than these files, so they stay open |
| D7 | `gameconfig.xml` (base and update), a listing of every archive with entry sizes, one `fm_content_*` script for the content keys | SCR-014, PERF-025, FF-001, FF-002, FF-003, FF-004, FF-005 | Done: SCR-014, FF-001, FF-002, FF-003 answered (and AI-006 with SCR-014); FF-004 mostly; PERF-025 partly (a test). FF-005 needs `fm_mission_controller` read key by key, a scripts job, so it stays open |
| D8 | Every `.ymap`, `.ytyp`, `.ymf`, `.ynd`, `.ynv` and scenario region file, loaded with CodeWalker's library; the archive listing for `.ybn` | GP-035, ENT-001 to ENT-003, ENT-028 to ENT-031, ENT-034, ENT-035, WLD-001, WLD-004, WLD-005, WLD-007, AI-027 to AI-029, REN-025, PHY-002 | Done: WLD-004, WLD-007, ENT-001, ENT-028, ENT-034, AI-028, AI-029, REN-025, PHY-002 answered; WLD-001, ENT-003, ENT-029, ENT-031 mostly; WLD-005, ENT-002, ENT-030, ENT-035, AI-027 partly; GP-035 not found. UI-009 (interior map names), PHY-005 and the pools part of PHY-018 were not attempted |
| D9 | Every audio `.rel` file (253, CodeWalker's library), the `.awc` listing, the dialogue text-block names in the decompile | AUD-001 to AUD-006, AUD-008 to AUD-010 | Done: AUD-001, AUD-002, AUD-003, AUD-005, AUD-006 answered; AUD-010 mostly; AUD-004, AUD-008, AUD-009 partly (the per-voice context lists need a reader for the `speech2` byte arrays). AUD-007 stays a test |
| D10 | `entityfx.dat`, `materialfx.dat`, `wheelfx.dat`, every `.ypt` (CodeWalker), DLC `content.xml` and `setup2.xml`, `animpostfx.ymt`, the `timecycle_mods` and `w_*.xml` files, `visualsettings.dat` | REN-014 to REN-017, REN-021, REN-022, REN-024, REN-026, REN-027, GP-027, WLD-017 | Done: REN-014, REN-015, REN-016, GP-027 answered; REN-022, REN-024, REN-027 mostly; REN-017, REN-021, REN-026, WLD-017 partly. Correction: the weather files have 423 variables per region, not 380 |
| D11 | `clip_sets.ymt` and the DLC `clip_sets.xml` files, `cameras.ymt`, the archive listing (`.ycd`, `.yed` sizes), `CREATE_CAMERA` calls in the decompile | REN-001, REN-002, REN-004, REN-005, REN-006, REN-008, REN-009 | Done: REN-004, REN-006, REN-009 answered; REN-001, REN-002, REN-005 mostly; REN-008 partly |
| D12 | The American text dump (every block), every `carcols.meta`, the clothes shop scripts' string literals | ON-018, ON-008, UI-018, ENT-006, GP-083 | Done: ENT-006 answered; ON-018, ON-008 mostly; GP-083 partly. UI-018 not moved: adding file and data names and numbered siblings found no clear gain over the second pass's method |
| PC1 | At the game PC, 2026-11-04 (branch `research/pc1-data-files`, [`PC-SESSION.md`](/PC-SESSION.md) Part 1): a listing of every vanilla archive (389,555 entries) and 2,134 data files converted to XML with CodeWalker's library: `common.rpf\data`, `update.rpf\common\data`, `update.rpf\x64\data` and `x64\levels\gta5`, the `dlc_patch` folders, and every DLC `handling`, `vehicles`, `carcols`, `carvariations`, `peds`, `events`, `taskdata`, `scenarios` and weapon file | PHY-001, PHY-004, ENT-017, ENT-019, ENT-020, AI-014, AI-033, ENT-025, AI-009, REN-011, ENT-038, ENT-039, AI-024, PHY-013, UI-009 | Done: PHY-001, PHY-004, ENT-019, AI-014, AI-009, REN-011, ENT-038, AI-024 answered; ENT-017, AI-033, ENT-025, ENT-039 mostly; ENT-020 (not in any data file: the executable), PHY-013 partly; UI-009 still partly (230 of 282) |

## By category

| Category | Guides | Questions |
| --- | --- | --- |
| [Getting started](#getting-started) (`GS-`) | 1 | 4 |
| [Core engine](#core-engine) (`CORE-`) | 8 | 33 |
| [Entities](#entities) (`ENT-`) | 9 | 39 |
| [Physics](#physics) (`PHY-`) | 4 | 18 |
| [AI](#ai) (`AI-`) | 13 | 50 |
| [The world](#the-world) (`WLD-`) | 4 | 19 |
| [Gameplay](#gameplay) (`GP-`) | 17 | 92 |
| [GTA Online](#gta-online) (`ON-`) | 13 | 77 |
| [User interface](#user-interface) (`UI-`) | 6 | 20 |
| [Audio](#audio) (`AUD-`) | 3 | 11 |
| [Rendering](#rendering) (`REN-`) | 5 | 27 |
| [Performance](#performance) (`PERF-`) | 9 | 28 |
| [Scripting](#scripting) (`SCR-`) | 4 | 14 |
| [File formats](#file-formats) (`FF-`) | 2 | 6 |
| [Knowledge graph](#knowledge-graph) (`KG-`) | (the graph) | 4 |
| **Total** | | **442** |

## Getting started

### [Boot and script control: from launch to control, and between story and Online](/docs/00-getting-started/boot.md) (R1.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GS-001 | Which level index 5 is | R1.6 or R4.6 | Answered: the network testbed level; which folder it loads stays **Known** (GS-004, third pass; [boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass)) |
| GS-002 | The exact path from a new game to `prologue1` | Answered: [boot 3.4.2](/docs/00-getting-started/boot.md#342-from-a-new-game-to-prologue1-second-pass) | Answered |
| GS-003 | Whether the return to story mode restarts every script (test card 2) | R7.2 | Open |
| GS-004 | Which folder level index 5 loads: confirm that the testbed level is `common:/data/levels/stripped` (only **Known** in [boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass)) | Third pass, the executable's level list | Answered: `nettestbed`, the 5th entry of `x64a.rpf\data\levels.ymt`; not `stripped` (8th), and its folder is not shipped (PC executable pass, [boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass)) |

## Core engine

### [Archives and the content system](/docs/core/archives-and-content.md) (R1.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-001 | Which data file types overlay (merge) and which replace; how duplicate names between packs resolve | Second pass (test with two packs defining the same handling name) | Open |
| CORE-002 | The exact load phases for each change-set group | Second pass, with R1.2 boot | Partly answered: the 12 groups, which packs use which, how the title update feeds the `UPDATE` groups ([archives 8.6.1](/docs/core/archives-and-content.md#861-the-change-set-groups-second-pass)); the exact moment each runs needs the executable |
| CORE-003 | What `update2.rpf` holds in build 3725 and why the mods folder has a copy | Second pass | Answered: scripts, text, shaders, job files and the version moved there from `update.rpf`; the mods copy differs in 9 shaders ([archives 8.2.1](/docs/core/archives-and-content.md#821-what-update2rpf-holds-second-pass)) |

### [Completion, autosave and achievements](/docs/core/completion-and-autosave.md) (R5.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-004 | The text of each completion label (block not found) | Second pass, with every text block | Answered: [completion 16.3](/docs/core/completion-and-autosave.md#163-the-completion-list) (199 have text; 121 are internal names with no text) |
| CORE-005 | What each completion entry's flags and map numbers mean | Second pass, `func_699` | Answered: the 12 values of an entry, the heist-choice flag, the packed IDs and the completion position ([completion 16.3](/docs/core/completion-and-autosave.md#163-the-completion-list)) |
| CORE-006 | Every autosave trigger, from the request fields | Second pass, follow `Global_102468` | Answered: the 11 request values, the 220 scripts that ask, the 9 missions that don't, and when the controller refuses or waits ([completion 16.5.1](/docs/core/completion-and-autosave.md#1651-how-a-save-is-asked-for-and-when-it-is-refused-second-pass)) |
| CORE-007 | Which 23 achievements the controller awards, by name | Second pass, with the achievement list | Answered: the 23 IDs with their conditions (**Verified**) and names (**Known**); Online stats named from the stat mapping file except four type 8/10 stats and one packed bool ([completion 16.6](/docs/core/completion-and-autosave.md#166-achievements)) |
| CORE-008 | `SC_MSC_` labels whose text is in a text block not read in the first pass *(from the guide's text)* | Second pass | Answered: [completion 16.3](/docs/core/completion-and-autosave.md#163-the-completion-list) |

### [The global variable map](/docs/core/global-map.md) (R0.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-009 | Field layout of the player broadcast data (`Global_1845250`, `Global_2658291`) | R7.1 second pass | Mostly answered: `.f_325` named, 16 parts of `.f_260` named from `mpstatscharactermappingdata.xml`, every bit of `.f_204`/`.f_203` grouped by who writes it, and 18 single bits read from their callers, 15 with a reading (leftovers pass: the organisation move-with-fade handshake, the vehicle-slot moves, leaving a vehicle) ([global map 6.3](/docs/core/global-map.md#63-the-most-used-globals)); left: `.f_203` bits 2, 5 to 8, 30, 31 and the mod shop bits |
| CORE-010 | The tunable index list: which `Global_262145.f_<n>` is which tunable | R7.3 | Answered: 34,987 assignments give field, type, name and default; 27,691 named, 7,296 by hash only ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| CORE-011 | What the references into blocks 13 and 15 are | Second pass | Answered: dead code behind two flags no script sets ([global map 6.2](/docs/core/global-map.md#62-the-blocks-with-how-much-they-are-used)) |
| CORE-012 | Roles of the **Known** rows above, by reading one use each | Second pass | Answered: [global map 6.3](/docs/core/global-map.md#63-the-most-used-globals) (four rows **Verified**, including `Global_1892653` = `GPBD_FM_3`) |

### [Memory, pools and limits](/docs/core/memory-and-pools.md) (R1.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-013 | A PoolManager crash log from the test install names `cscenarioinfo` at size 250, the vanilla value, while the start-up log shows 885: was the modded `gameconfig.xml` not loaded on that launch, or does the crash log print the vanilla size? | Test card 1 on the next crash | Open |
| CORE-014 | Real usage of the busiest pools in a heavy session (turn on PoolManager's usage warning for one launch) | Second pass | Open |
| CORE-015 | Memory cost of each raised pool (bytes per slot) | Second pass | Open: needs the executable or a memory tool (scripts, `gameconfig.xml` and PoolManager's logs give no item size) |
| CORE-016 | The vanilla built-in sizes of the weapon arrays that WeaponLimitsAdjuster raises | Second pass | Partly answered: vanilla loads 140 weapon-info and 20 weapon-component files from its packs, a lower bound ([memory 7.9](/docs/core/memory-and-pools.md#79-open-questions)); the built-in sizes need the executable |

### [Runtime scripts: the scripts that keep the game running](/docs/core/runtime-scripts.md) (R0.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-017 | Meaning of force-cleanup bits 8, 16, 32, 64 and 128 | R1.1 | Answered (16 and 32 are raised by the engine; their cause is CORE-032, third pass): [runtime scripts 1.3](/docs/core/runtime-scripts.md#every-force-cleanup-bit-second-pass) |
| CORE-018 | What exactly the engine does to start `main`, `initial` and `startup`, and in which order | R1.2 | Partly answered: no script starts them, and the order follows from what each reads and waits for ([boot 3.3](/docs/00-getting-started/boot.md#33-inside-the-boot-scripts)); the engine starts `startup` (or `startup_install`) by name (PC executable pass); how `main` and `initial` start is still open |
| CORE-019 | What `profiler_registration` (global block 2) is and whether anything starts it | R0.4 | Answered: empty script, block 2 never used ([runtime scripts 1.5](/docs/core/runtime-scripts.md#15-global-blocks)) |
| CORE-020 | The story flags that pick the active mission triggerer | R5.1 | Answered: no flag; `main` reads the `completed` values of `trevor1`, `fbi4` and `michael1`, behind five gates; new CORE-033 ([story flow 2.7](/docs/gameplay/missions/story-flow.md#27-the-mission-triggerers)) |
| CORE-021 | Resolve table-driven launches (second pass of the graph) | R0.5 | Mostly answered: 502 non-literal launches, 220 followed back, eleven tables read, including `freemode`'s launches by request (a 20-entry table of 12 travel cinematics; requests are filed by `freemode`, `fm_content_island_heist`, `fm_race_creator`, `gb_delivery` and `spawn_activities`, leftovers pass); 240 scripts nothing starts ([launch graph](/scripting/script-launch-graph.md#launches-by-variable-and-by-table-second-pass)); `player_controller`'s other scenes left |
| CORE-032 | What the engine raises force-cleanup bits 16 and 32 for (no script raises them; [runtime scripts 1.3](/docs/core/runtime-scripts.md#every-force-cleanup-bit-second-pass)) | Third pass, in-game test logging `GET_CAUSE_OF_MOST_RECENT_FORCE_CLEANUP`, or the executable | Open |
| CORE-033 | What the values of the current mission type (`Global_44869` in build 3725) mean, and the compatibility table in `main` that lets the triggerers run for 15, 5 and 17 | Third pass, `main` and the mission scripts that set it | Answered: 0/2/3 story missions, 4 strangers and odd jobs, 5 random events, 6/7 friend activities, 9/10 activities, 12 exile city denial, 13 animal mode, 14 Director Mode, 15 none, 17 scripted moments, 18 friend calls; plus the full may-replace table ([runtime scripts](/docs/core/runtime-scripts.md#the-current-mission-type-second-pass-core-033)) |

### [Saves: what the story save holds and how scripts write it](/docs/core/saves.md) (R1.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-022 | The full tree of nested and run-time-named sections, with offsets | Second pass: walk every registration function | Answered: all 67 top-level sections and 58 loose fields with offsets, deeper levels summarised ([saves 15.4](/docs/core/saves.md#154-whats-in-the-story-save)) |
| CORE-023 | What the upgrade function does for older save versions | Second pass, `startup` `func_21` | Answered: six fixes for versions 1.0 to 1.5 ([saves 15.5.1](/docs/core/saves.md#1551-the-save-upgrade)) |
| CORE-024 | The save file's on-disk format and how names map to it | Reverse engineering, outside the scripts | Open |
| CORE-025 | What triggers an autosave, and completion | R5.3 | Answered with CORE-006 ([completion 16.5.1](/docs/core/completion-and-autosave.md#1651-how-a-save-is-asked-for-and-when-it-is-refused-second-pass)) |

### [Streaming: how assets get into memory](/docs/core/streaming.md) (R1.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-026 | How `TextureQuality` values map to the menu, and how much memory each level takes on shared graphics | R18.2, R18.3 | Open |
| CORE-027 | The streaming memory budget (how the engine splits RAM between stores), and what HeapAdjuster changes in it | R18.3 | Open |
| CORE-028 | Which SRLs exist (13 names in scripts) and what each covers | Second pass | Answered: 207 SRLs in `srllist.meta` plus 14 DLC lists, 20 started by name ([streaming 10.4.1](/docs/core/streaming.md#1041-the-srls-second-pass)) |
| CORE-029 | Measure a pop-in case: drive fast through the city at `LodScale` 0 and 0.5 with a frame-time log, compare hitches and memory | Test card below, R18.2 | Open |

### [Surviving game updates](/docs/core/surviving-updates.md) (R11.1, R11.2, R11.3, R11.4, R11.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| CORE-030 | Which natives changed between 3725 and 3889 | R11.1 second pass, with the native crossmap (R0.3) | Answered: hashes are stable; 29 natives new in 3889 are used, one 3725 native dropped; 11 new scripts ([surviving updates 8.4a](/docs/core/surviving-updates.md#84a-what-changed-in-the-natives-and-controls-second-pass)) |
| CORE-031 | Which brain set the engine gives the random-ped brains added with `ADD_SCRIPT_TO_RANDOM_PED` (no script registers into sets 2 or 4) | Third pass, the executable | Open |

## Entities

### [Props, archetypes and doors](/docs/entities/objects/props-and-doors.md) (R14.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-001 | Archetype flag bits counted across all `.ytyp` files | Second pass, with an XML export of the ytyps | Answered: bit counts over 158,104 archetypes (leftovers pass, [props](/docs/entities/objects/props-and-doors.md#3041-archetypes-fragments-and-rayfire-objects-leftovers-pass)) |
| ENT-002 | Which map props are fragments (`.yft`) and how many break | Second pass with R4.6's model counts | Partly answered: 4,426 fragment archetypes by source and folder; how many break needs the `.yft` files (leftovers pass, [props](/docs/entities/objects/props-and-doors.md#3041-archetypes-fragments-and-rayfire-objects-leftovers-pass)) |
| ENT-003 | Every rayfire object placed in the map, not only those named in scripts | Second pass, ymap entity extensions | Mostly answered: 49 rayfire objects defined, 17 placed in outdoor ymaps (5 of them in script-loaded ones); the other 32 are not in any ymap, probably interior entity lists (leftovers pass, [props](/docs/entities/objects/props-and-doors.md#3041-archetypes-fragments-and-rayfire-objects-leftovers-pass)) |

### [Text and names in content](/docs/entities/objects/text-and-names.md) (R14.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-004 | The `NULL` fallback and the "CARNOTFOUND" return, confirmed in game | Test card 1 | Open |
| ENT-005 | Which 13 maker labels have no text and whether anything shows them | Second pass | Answered: 13 makers have text only in a DLC or update global table; only `KRAKEN` (`avisa`) has none anywhere; what the game shows for it is a test (leftovers pass, [text and names](/docs/entities/objects/text-and-names.md#short-version)) |
| ENT-006 | How mod-part and livery labels are named and registered | R14.1 | Answered: `modShopLabel` per part (21,955 labels), `liveryNames` for texture liveries, text in each pack's `global.gxt2` (leftovers pass, [text and names](/docs/entities/objects/text-and-names.md#open-questions)) |
| ENT-007 | Load order when two packs define the same label | R8.3 second pass, in-game test | Open |

### [Appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) (R6.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-008 | Inside `clothes_shop_mp`: menu structure, how it applies an item, what it saves | Second pass | Answered: browse spots, catalogue queries, label-keyed prices, 20 outfit slots and the stats ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#clothes-stores-and-the-mask-shop-clothes_shop_mp)) |
| ENT-009 | Inside `hairdo_shop_mp`: which overlays and tints it offers per gender | Second pass | Answered: pages per gender, overlay index and item count per page, prices ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#barber-shops-hairdo_shop_mp)) |
| ENT-010 | The overlay index list (0 to 12) and micro-morph list (0 to 19), checked against the creator | Answered from the creator's tables in [the Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5); in-game check still open | Partly answered |
| ENT-011 | The restriction tag names (hashes to names) | Second pass | Answered: the catalogue stores them as text, 510 names with counts ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#wearing-rules-restriction-tags)) |
| ENT-012 | How many packs carry shop files, and how many items in all (a one-process scan of all 89 packs; one CodeWalker start per pack is too slow) | Second pass, extend [`tools/dlc-scan.ps1`](/tools/README.md) | Answered: 86 files from 43 packs, 36,232 items; 31 tattoo files, 2,702 rows ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#the-catalogue-in-numbers)) |

### [Peds](/docs/entities/peds/peds.md) (R14.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-013 | The 23 personality hashes and relationship groups that didn't resolve | Second pass | Mostly answered: all 24 relationship-group hashes resolved from `relationships.dat`; every personality hash matches an entry, 69 of 96 named (leftovers pass, [peds](/docs/entities/peds/peds.md)) |
| ENT-014 | What each `SET_PED_CONFIG_FLAG` number does (the ones Rockstar sets most) | Second pass: count flag numbers in the decompile | Partly answered: 190 flag numbers in 36,104 literal calls. The flags in the most scripts are 36 and 34 (528 and 527 scripts), 208, 118, 185, 342 and 122; 427 has the most calls (8,943, from shared code). Left: each flag's effect, which needs the engine enum names (leftovers pass, [peds](/docs/entities/peds/peds.md#the-config-flags-rockstar-sets-most-leftovers-pass)) |
| ENT-015 | The component `.ymt` format (slots, drawables, restrictions) | R6.3, R14.2 second pass | Answered: the `CPedVariationInfo` layout part by part (leftovers pass, [appearance 10.2.1](/docs/entities/peds/appearance-and-clothing.md#1021-the-component-ymt-file-leftovers-pass)) |

### [Ped physics and ragdoll](/docs/entities/peds/ragdoll.md) (R2.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-016 | How many Euphoria ragdolls run at once before peds fall back to `CTaskRageRagdoll` | In-game test, [physics cost](/docs/performance/physics-cost.md) test card 1 | Open |
| ENT-017 | Which tuning set is chosen for which weapon and vehicle, and the 3 hashed set names | Second pass, weapon and vehicle data | Mostly answered: weapons by `NmShotTuningSet`, vehicles per seat entry in `vehiclelayouts.meta`; `KNIFE_SLASH` and `AUTOMATICMG` named (PC data pass, [ragdoll 17.3.1](/docs/entities/peds/ragdoll.md#1731-who-picks-which-tuning-set-pc-data-pass)); left: two `CGrabHelper` set names |
| ENT-018 | Fall damage by height | R3.8 open question, in-game test | Open |
| ENT-019 | What `nm_blend_out_sets.meta` sets for getting up | Second pass | Answered: 103 get-up sets, their item types, fields and flags (PC data pass, [ragdoll 17.4.1](/docs/entities/peds/ragdoll.md#1741-getting-up-nm_blend_out_setsmeta-pc-data-pass)) |
| ENT-020 | Where fall damage is set (not in the ragdoll files) *(from the guide's text)* | R3.8 | Partly answered: in no data file; the files only set when a fall becomes a ragdoll (PC data pass, [ragdoll 17.4](/docs/entities/peds/ragdoll.md#174-falling)); left: the executable or an in-game test |

### [Population](/docs/entities/spawning/population.md) (R4.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-021 | The 5 story-mode schedule hashes that don't match a `popcycle.dat` name | Second pass | Answered: one hash (`7D143EDB`) matches no schedule; six Online-only zones use it in story mode, so they get no ambient population (our reading) (leftovers pass, [population](/docs/entities/spawning/population.md#schedules-that-dont-exist-leftovers-pass)) |
| ENT-022 | How the caps, `CityDensity` and the budgets combine into the real spawn count | Test card 1; R17.9 | Open |
| ENT-023 | What `scumminessLevel` changes in code and in scripts | Second pass: `GET_ZONE_SCUMMINESS` callers | Partly answered: one script reads it, `cellphone_flashhand`, to set the phone's signal bars (levels 0 and 1 give 5 bars, 2 and 3 give 4, 4 gives 3, 5 gives 2, with a 1-in-4 chance of one fewer). The guide's earlier "shop prices" note was wrong. Left: what it changes in the engine (leftovers pass, [population](/docs/entities/spawning/population.md)) |
| ENT-024 | The unnamed zone fields (`hash_7111AC8A`, three flags) | Second pass | Partly answered: `hash_7111AC8A` (7) and `hash_3CBB62E0` (−1) are the same in every zone; the two flags are true on the west-coast beach zones, effect untested (leftovers pass, [population](/docs/entities/spawning/population.md#schedules-that-dont-exist-leftovers-pass)) |
| ENT-025 | How birds and fish groups spawn (they fill many slots) | R17.8 | Mostly answered: ordinary weighted population groups flagged aerial, aquatic or wildlife (PC data pass, [population](/docs/entities/spawning/population.md#birds-and-fish-pc-data-pass)); left: the engine's placement rule |

### [Scenarios and ambient life](/docs/entities/spawning/scenarios.md) (R4.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-026 | The 44 scenario groups scripts toggle and what each controls | Second pass | Mostly answered: 43 groups are named in `SET_SCENARIO_GROUP_ENABLED` calls, with the scripts that switch each (`HEIST_ISLAND_PEDS` in 19 scripts, the rest in 1 to 4; mission dressing, activities, plane traffic, guards, Online areas). Most calls pass the group in a variable from shared code. Left: which points each group holds (scenario files) (leftovers pass, [scenarios](/docs/entities/spawning/scenarios.md#the-scenario-groups-scripts-switch-leftovers-pass)) |
| ENT-027 | How the time window and probability combine with the `#Scenario` cap | Test card 1; R17.8 | Open |
| ENT-028 | How many of the 111,898 points are Online-only | Second pass: the availability field | Answered: 1,088 Online-only, 50,331 story-only (mostly animals), 57,779 both (leftovers pass, [scenarios](/docs/entities/spawning/scenarios.md#availability-chains-and-aircraft-leftovers-pass)) |
| ENT-029 | The chaining graph format and how vehicles follow it | R17.6 | Mostly answered: 45,372 nodes, 40,907 edges, 4,697 chains with their fields; the 16 speed values are unnamed (leftovers pass, [scenarios](/docs/entities/spawning/scenarios.md#availability-chains-and-aircraft-leftovers-pass)) |

### [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (R4.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-030 | What the car generator flag bits mean (3,680, 3,936 ...) | Second pass: compare generators in known places | Partly answered: five default bits (3,680), bit 8 on roadside generators, bits 0 and 1 with fixed models, bits 28 to 31 with groups; exact meanings are a test (leftovers pass, [car generators](/docs/entities/spawning/vehicle-generators-and-traffic.md#flag-bits-and-dlc-generators-leftovers-pass)) |
| ENT-031 | Which DLC ymaps with generators load in story mode | R4.6 (map data), R4.5 (IPLs) | Mostly answered: 20,177 DLC generators are in always-on copies of base road sections (`hei_`, `lr_`, `bkr_`, `apa_`) (leftovers pass, [car generators](/docs/entities/spawning/vehicle-generators-and-traffic.md#flag-bits-and-dlc-generators-leftovers-pass)) |
| ENT-032 | How the schedule caps, the budget and the `CityDensity` setting combine | R4.1, test card 1 | Open |
| ENT-033 | What the ten unused train tracks are and whether they work | Test card 3 | Open |
| ENT-034 | Where ambient planes, helicopters and boats on routes come from | R4.2 (vehicle scenarios) | Answered: vehicle scenario points with plane, helicopter and boat model sets on chains, the planes in four `ng_planes` files (leftovers pass, [scenarios](/docs/entities/spawning/scenarios.md#availability-chains-and-aircraft-leftovers-pass)) |
| ENT-035 | Meaning of the bits in the vehicle generator flags field (3,680, 3,936, 3,616, 1,632), and the unresolved population group hash on 455 generators *(from the guide's text)* | Second pass | Partly answered: the bits as ENT-030; the group `F85943A6` is only in South Los Santos road sections and still unnamed (leftovers pass, [car generators](/docs/entities/spawning/vehicle-generators-and-traffic.md#flag-bits-and-dlc-generators-leftovers-pass)) |

### [Vehicles](/docs/entities/vehicles/vehicles.md) (R14.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-036 | The difference between the 901 models here and the 879 counted in R14.4 (how entries were split) | Second pass | Answered: 921 models in all 76 files; the 879 count left out the 42 models found only in `dlc_patch` copies (leftovers pass, [vehicles](/docs/entities/vehicles/vehicles.md#how-many-models-counted-three-ways-leftovers-pass)) |
| ENT-037 | The meaning of the less common flags | Second pass: compare models that set them | Mostly answered: which model uses each of the 79 rarest flags, and one unprefixed flag on `bodhi2`; the detailed effect is a test per model (leftovers pass, [vehicles](/docs/entities/vehicles/vehicles.md#how-many-models-counted-three-ways-leftovers-pass)) |
| ENT-038 | Light and siren setting id ranges used by DLC packs | Second pass | Answered: per pack, with two clashes (PC data pass, [vehicles](/docs/entities/vehicles/vehicles.md#light-siren-and-kit-ids-and-what-kits-contain-pc-data-pass)) |
| ENT-039 | Which `carcols` mod parts each kit really links (the per-type counts include repeats) | Second pass | Mostly answered: counts with and without repeats, linked and stat parts (PC data pass, [vehicles](/docs/entities/vehicles/vehicles.md#light-siren-and-kit-ids-and-what-kits-contain-pc-data-pass)); left: a per-kit table |

## Physics

### [Collision, materials and shape tests](/docs/physics/collision-and-materials.md) (R2.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-001 | The two unnamed columns (0.95 and 0.0 in every row) | R2.1 second pass | Answered: `SOFTNESS` and `NOISINESS`, the same in all 213 rows (PC data pass, [collision 5.3.1](/docs/physics/collision-and-materials.md#531-the-softness-and-noisiness-columns-and-the-ragdoll-materials-pc-data-pass)) |
| PHY-002 | How many `.ybn` files the map has and how they are grouped | R4.1 (map) | Answered: 15,124, by area, pack and name prefix (leftovers pass, [collision](/docs/physics/collision-and-materials.md#57-open-questions)) |
| PHY-003 | The exact shape test flag bits, checked in game | R2.1 second pass | Open |
| PHY-004 | The ragdoll and `NATURAL_MOTION` materials | R2.3 | Answered: ids 150 to 171, 21 body parts and `ANIMAL_DEFAULT`, with their values (PC data pass, [collision 5.3.1](/docs/physics/collision-and-materials.md#531-the-softness-and-noisiness-columns-and-the-ragdoll-materials-pc-data-pass)) |
| PHY-005 | How water collision differs from water simulation | R2.4 | Open |

### [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) (R2.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-006 | The exact falloff curve between centre and edge, and how armour takes explosion damage | Test card 1; R3.1 | Open |
| PHY-007 | How far and how fast fire spreads, and its limits (number of fires at once) | Test card 2; R18 | Open |
| PHY-008 | The meaning of the unnamed boolean fields in `explosion.ymt` (their names didn't resolve) | Second pass | Mostly answered: two of the eight are `bForceNonTimedVfx` and `bIsSmokeGrenade` (named by the DLC XML, case-sensitive `joaat`); the other six are off for every type (leftovers pass, [explosions](/docs/physics/fire-explosions-projectiles.md#the-base-explosion-types)) |
| PHY-009 | The DLC explosion types' numbers, damage and radius | Second pass: tabulate the 16 DLC files | Mostly answered: damage, radius, force and flags of all 51 DLC types (49 plus `spupgrade`'s patch-only `BLIMP2` and `RAILGUN`); the numbers follow the load order (**Known**) (leftovers pass, [explosions](/docs/physics/fire-explosions-projectiles.md#every-dlc-type-with-damage-and-radius-leftovers-pass)) |
| PHY-010 | The full list of DLC projectiles and their explosions | R3.1 second pass | Answered: 64 DLC projectiles by pack with the explosion each makes (leftovers pass, [projectiles](/docs/physics/fire-explosions-projectiles.md#projectiles)) |

### [Vehicle physics: handling, damage and upgrades](/docs/physics/vehicle-handling.md) (R2.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-011 | Bit names for the model, handling, damage and advanced flags, checked one by one in game | R2.2 second pass | Open |
| PHY-012 | How the engine turns `fInitialDriveMaxFlatVel` and the drive force into the real top speed | R2.2 second pass, in-game measurement | Open |
| PHY-013 | What exactly each `statMods` modifier changes (percent of what) | R2.2 second pass | Partly answered: every value in every kit (PC data pass, [handling 4.7](/docs/physics/vehicle-handling.md#47-speed-grip-and-upgrades)); left: what the number scales (the executable or a measurement) |
| PHY-014 | How `vehicles.meta` fields (`handlingId`, wheel scale, `flags`) interact with handling | R14.1 | Open |

### [Water and buoyancy](/docs/physics/water-and-buoyancy.md) (R2.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-015 | What the 5 water quad types mean | Second pass: compare where each type is | Answered: type 0 rectangles (342 quads, 53.6 km²), types 1 to 4 the corner triangles along diagonal shores (**Known** reading of the field); counts and heights per type (leftovers pass, [water](/docs/physics/water-and-buoyancy.md#the-five-quad-types-leftovers-pass)) |
| PHY-016 | The format of `waterheight.dat` | Second pass | Partly answered: `WMAP` header, version 100, a 183 × 249 grid of 50 m cells from (−4,050, 8,400); the 59,360-byte body is still undecoded (leftovers pass, [water](/docs/physics/water-and-buoyancy.md#the-waterheightdat-file-leftovers-pass)) |
| PHY-017 | How wave quads differ from calming quads in effect | In-game test | Open |
| PHY-018 | Where swimming pools are defined | R4.6 second pass | Partly answered: no pool is in `water.xml` (all 504 quads at the four sea, lake and reservoir heights); the map data that holds them is left for the map-data batch (leftovers pass, [water](/docs/physics/water-and-buoyancy.md#water-heights)) |

## AI

### [The AI architecture](/docs/ai/ai-architecture.md) (R17.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-001 | The full list of task classes the engine has (not only tuned ones) | Engine reverse engineering | Open |
| AI-002 | Task status values and what each means, measured | In-game test | Open |
| AI-003 | How primary and secondary task slots are numbered | Engine reverse engineering | Open |

### [AI cost and level of detail](/docs/ai/ai-cost-and-lod.md) (R17.9)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-004 | The distances where ped AI LOD changes | In-game test, or engine reverse engineering | Open |
| AI-005 | Measured frame time per combat ped on a low-end PC | R18.1 measuring, test card 1 | Open |
| AI-006 | What the second `CTask` pool (2,100) is for | Second pass with R1.4 | Answered: 2,100 is the PS4 block's `CTask` value; PC uses 8,192 (leftovers pass, [memory and pools](/docs/core/memory-and-pools.md#72-where-the-limits-come-from)) |

### [Ambient life](/docs/ai/ambient-life.md) (R17.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-007 | How far from the player ambient peds despawn | R17.9, in-game test | Open |
| AI-008 | How peds pick partners for chats | Second pass | Partly answered: no script picks partners; `TASK_CHAT_TO_PED` has only 10 calls in 5 scripts, each pairing two script-chosen peds both ways (flag 16 in 8). Ambient pairing is the engine's (`CTaskChat`, hang-outs within 2 m). Left: the engine rule (leftovers pass, [ambient life 36.3](/docs/ai/ambient-life.md#363-what-scripts-do)) |
| AI-009 | The animal models by kind and where each spawns | Second pass with R4.2's scenario types | Answered: 32 base models and the DLC variants with their AI, and the 47 scenario types and population groups that spawn them (PC data pass, [ambient life 36.3.1](/docs/ai/ambient-life.md#3631-the-animals-and-where-they-spawn-pc-data-pass)) |

### [Combat and AI (first pass)](/docs/ai/combat-and-perception.md) (R3.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-010 | Names of the common combat attributes (50, 17, 53, 52, 46) and config flags (427, 36, 398, 34), checked in game | R3.2 second pass | Open |
| AI-011 | Decode `pedpersonality.ymt` (binary PSO): personalities, bravery, driving ability | R17.3 | Answered: decoded in [decisions and personalities](/docs/ai/decisions-and-personalities.md) (R17.3); the leftovers pass named all 18 bravery types and 69 of 96 personalities |
| AI-012 | Cover: how cover points are found and scored, `TASK_SEEK_COVER_*` | R17 | Open |
| AI-013 | How aim assist and lock-on work for the player | R3.2 second pass | Open |
| AI-014 | The full meaning of `taskdata.meta` and `scriptedguntasks.meta` | R17.1 | Answered: the 10 task data sets and their flags, the default tasks, the 11 scripted gun tasks and the 4 missions that use them (PC data pass, [combat 5.8.1](/docs/ai/combat-and-perception.md#581-task-data-sets-and-scripted-gun-tasks-pc-data-pass)) |
| AI-015 | Whether the modded `events.meta` really drops gunfight reactions, in game | Test card | Open |
| AI-016 | Decode `pedpersonality.ymt` (binary PSO; not decoded in the first pass) *(from the guide's text)* | R17.3 | Answered with AI-011 ([decisions and personalities](/docs/ai/decisions-and-personalities.md)) |

### [Decisions and personalities](/docs/ai/decisions-and-personalities.md) (R17.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-017 | The names of the 5 unnamed civilian bravery types and the criminality types | Second pass with more name sources | Mostly answered: the five are `Bold`, `Bold_Female`, `Timid`, `Timid_Female` and `Average_Female` (with `Default_Female`); criminality `Law_Abiding` named, two hashes left (leftovers pass, [decisions](/docs/ai/decisions-and-personalities.md#names-of-the-hashed-types-leftovers-pass)) |
| AI-018 | What `IsWeird` changes for Trevor | In-game test; second pass | Open |
| AI-019 | How motivation (`MotivationMin/Max`) is used | Second pass | Partly answered: max 10 for 79 personalities, 0 for the 17 gang, army, SWAT and security ones; engine use is a test (leftovers pass, [decisions](/docs/ai/decisions-and-personalities.md#names-of-the-hashed-types-leftovers-pass)) |
| AI-020 | How the driving ranges map onto the driving tasks (R3.3, R17.6) | R3.3 | Open: scripts override the values with `SET_DRIVER_ABILITY` / `_AGGRESSIVENESS` / `_RACING_MODIFIER` (105 to 118 scripts), but how the personality range becomes the task behaviour is the executable or a test (leftovers pass) |

### [Driving AI: missions, chases, aircraft and boats](/docs/ai/driving-ai.md) (R17.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-021 | The name of each temp action number, checked in game | In-game test, one action at a time | Open |
| AI-022 | How the flee mission picks a route | R17.5 second pass | Open |
| AI-023 | Mission numbers passed in variables (about a quarter of the calls) | Second pass, follow the variables | Partly answered: of 1,131 variable mission calls, only about ten resolve statically (to 10, 11, 12, 0, 6). Most come from a shared vehicle-task helper in about 95 `fm_content_*` scripts that gets the mission from a function-pointer call into the job's content data (`StackVal` in the decompile), so they are chosen at run time. Left: a YSC reader or runtime log ([driving AI](/docs/ai/driving-ai.md)) |

### [Driving and AI driving](/docs/ai/driving.md) (R3.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-024 | AI profiles of every DLC vehicle (all `handling.meta` files) | Second pass, with the DLC scan | Answered: 566 DLC handling entries, 477 `AVERAGE`, 60 `SPORTS_CAR`, 25 `TRUCK`, 4 `CRAP`, with names (PC data pass, [driving 18.2](/docs/ai/driving.md#182-the-ai-handling-profiles)) |
| AI-025 | How `SET_DRIVER_ABILITY` and `_AGGRESSIVENESS` change the curve or braking | In-game test | Open |
| AI-026 | What `TASK_VEHICLE_TEMP_ACTION`'s action numbers mean, with Rockstar's counts | Second pass | Answered: the 15 literal action numbers Rockstar uses, with counts, matched to NativeDB's community meanings (**Known**: 24 and 1 brake, 4 and 5 turn while braking, 30 burnout, 6 hard brake, 9 gentle acceleration ...). The in-game check stays AI-021 (leftovers pass, [driving AI](/docs/ai/driving-ai.md)) |
| AI-027 | Road nodes and how routes are planned | R17.5 (navigation) | Partly answered: node, link and junction counts; route planning is engine code (leftovers pass, [navigation](/docs/ai/navigation.md#3441-navmesh-and-road-node-counts-leftovers-pass)) |

### [Navigation and pathfinding](/docs/ai/navigation.md) (R17.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-028 | Polygon, link and cover-point counts per tile | Second pass, a `.ynv` reader | Answered: polygons, vertices, portals and cover points, base and DLC (leftovers pass, [navigation](/docs/ai/navigation.md#3441-navmesh-and-road-node-counts-leftovers-pass)) |
| AI-029 | Node and link counts in the `.ynd` files, and what the update changed | Second pass | Answered: 79,788 nodes and 166,544 links; the update adds 15 files and changes 23 (leftovers pass, [navigation](/docs/ai/navigation.md#3441-navmesh-and-road-node-counts-leftovers-pass)) |
| AI-030 | How far around the player navmeshes stream by default | In-game test with `GET_NUM_NAVMESHES_EXISTING_IN_AREA` | Open |

### [Perception and events](/docs/ai/perception-and-events.md) (R17.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-031 | The three other unnamed shocking events | Second pass, more name guesses | Open |
| AI-032 | Which `SET_PED_CONFIG_FLAG` numbers scripts set most, and what they do | Second pass, R17.10 | Partly answered: the same count as ENT-014, 190 flags with the top 20 by scripts (36, 34, 208, 118, 185 ...). Left: what each does ([peds](/docs/entities/peds/peds.md#the-config-flags-rockstar-sets-most-leftovers-pass)) |
| AI-033 | How decision makers map each event to a response | R17.3 second pass | Mostly answered: the three lists in `events.meta`, the chances, distances, flags and parents (PC data pass, [perception and events 33.4.1](/docs/ai/perception-and-events.md#3341-from-event-to-response-decision-makers-pc-data-pass)); left: the exact selection rule (the executable) |

### [Police and service AI](/docs/ai/police-and-services.md) (R17.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-034 | The names and values of the 9 crime-info entries | R3.7 | Mostly answered: the 9 keys are `CRIME_NONE`, `KILL_COP`, `KILL_PED`, `STEAL_CAR`, `STEAL_VEHICLE`, `HASSLE`, `SHOOT_COP`, `RECKLESS_DRIVING` and `VEHICLE_EXPLOSION`, with their values; three field names are still unknown (leftovers pass, [police](/docs/ai/police-and-services.md#353-search-and-spawning-dispatchtuningymt)) |
| AI-035 | How crime points are added per crime | R3.7 | Partly answered: no data file holds points per crime (crime info has witness rules, dispatch only the points per star), so it is the engine (leftovers pass) |
| AI-036 | The full vehicle sets with model names | Second pass, `dispatch.meta` | Answered: all 15 sets with models, peds and the army-base and countryside variants (leftovers pass, [police](/docs/ai/police-and-services.md#352-dispatchmeta)) |

### [Relationships and groups](/docs/ai/relationships-and-groups.md) (R17.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-037 | The exact follower limit and what happens to the eighth | Test card 2 | Open |
| AI-038 | Which mission groups persist between missions (global groups registered at boot) | Second pass: `standard_global_init` | Answered: no script registers groups at boot. The only story groups that last across missions are `main_persistent`'s `RELGROUPHASH_FAMILY_M`, `_F` and `_T`, used by 70 scripts. Triggerer lead-in groups and mission groups end with their scripts (leftovers pass, [relationships](/docs/ai/relationships-and-groups.md#which-groups-outlive-a-mission-leftovers-pass)) |
| AI-039 | How dislike (4) differs from hate (5) in behaviour | In-game test | Open |
| AI-040 | How the wanted level overrides the `COP`–`PLAYER` relationship | R3.7 | Partly answered: no script sets `COP` toward `PLAYER`, so the engine's wanted system does it; scripts use the wanted natives. `lamar1` and `franklin1` set `PLAYER` to hate `COP` (followers fight police), and 15 Online scripts copy the player group's value to their own groups. Left: the engine side (the executable, a test) (leftovers pass, [relationships and groups](/docs/ai/relationships-and-groups.md#police-and-the-players-group-leftovers-pass)) |

### [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md) (R17.10)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-041 | Where story missions keep enemy spawn tables (positions, triggers) and how many enemies a big shootout has alive at once | Next pass: `rural_bank_heist`, `finale_heist2b` | Partly answered: no spawn tables; enemy positions are literals in each stage's code (63 of 73 `CREATE_PED` calls in `rural_bank_heist`, 13 of 25 in `jewelry_heist`), handles in fixed local arrays. Left: how many are alive at once (an in-game count) (leftovers pass, [script AI patterns 44.8](/docs/ai/script-ai-patterns.md#448-waves-and-difficulty-in-online-content)) |
| AI-042 | What hackers' and drivers' stats do in each heist | Next pass: the heist scripts | Mostly answered: hacker and driver stats are read only on the planning board. The finales branch on a skill tier (0 to 2) kept in the save, recomputed from the average stat percentage when a finale passes (above 66.6 is tier 2, above 33.3 tier 1, never lowered). Per finale: jewel hacker time limit 55/65/90 s, case value multiplier 0.8/0.9/1.0, crashes and deaths for low tiers, 9% take cuts and a minigame delay in `finale_heist2a`, a $100.8 million loss in `finale_heist2b`. Left: two branches to confirm in game (leftovers pass, [script AI patterns 44.7](/docs/ai/script-ai-patterns.md#447-heist-crews)) |
| AI-043 | When the crew stat raise is called (every survived heist, or only some) | Next pass | Answered: once near the end of each of the six crew finales (the docks heist scripts contain none), for every member chosen for that heist who is neither dead in the save nor lost in the heist. Each of their 3 or 4 stats rises by a quarter of its cap, clamped at the cap; skipped in one state (our reading: a replay) (leftovers pass, [script AI patterns 44.7](/docs/ai/script-ai-patterns.md#447-heist-crews)) |
| AI-044 | The `TASK_COMBAT_PED` flag values (16, 67108864, 201326592) | In-game test | Open |
| AI-045 | How `fm_content_*` scripts set up patrols from content data | R7.7, R7.9 | Mostly answered: 92 scripts share one builder. One route per ped from a `data.Patrol` block (`MAX_NUM_PATROLS`) of nodes (position, look-at, wait), 1 to 14 nodes per script (1 in 55 scripts), named `miss_<mission>_<instance>_<index>`, linked in a loop with no node scenarios, then `TASK_PATROL` with alert state 0 and chat on by default; a callback can switch to a script-walked back-and-forth route. Left: each variation's values, set through function pointers (leftovers pass, [script AI patterns 44.3](/docs/ai/script-ai-patterns.md#443-guards-and-patrols)) |
| AI-046 | Buddy behaviour in vehicles (driver choice, drive-bys) | With [R17.6](/docs/ai/driving-ai.md) | Mostly answered: no script logic picks a driver; missions seat buddies with literal seats (957 of 1,278 literal `TASK_ENTER_VEHICLE` seats are the driver's), group members choose their own seat with a preference set by `SET_PED_GROUP_MEMBER_PASSENGER_INDEX`, friends get vehicle and drive-by combat attributes and no scripted drive-by, and scripted drive-bys are 166 `TASK_DRIVE_BY` calls in 43 mission scripts. Left: the passenger index values and the engine's seat choice (a test) (leftovers pass, [script AI patterns 44.6](/docs/ai/script-ai-patterns.md#446-buddies-escorts-and-set-routes)) |

### [Wanted level and police](/docs/ai/wanted-level-and-police.md) (R3.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-047 | Crime points added per crime (set in the engine) | In-game test: commit one crime with a multiplier of 1 and read the result | Open |
| AI-048 | Names for the crime numbers 13, 36, 37 and 28 | Second pass with NativeDB's crime list | Mostly answered (Known, NativeDB's community list): 13 assault with a deadly weapon, 28 shots fired, 36 given only as a radio code. Left: 37 has no name there ([wanted level](/docs/ai/wanted-level-and-police.md)) |
| AI-049 | How the difficulty value changes police behaviour, measured | In-game test | Open |
| AI-050 | Confirm the crime numbers passed literally to `REPORT_CRIME` (37, 36, 13) and `SUPPRESS_CRIME_THIS_FRAME` (28 and others); the names come from NativeDB's crime list *(from the guide's text)* | Second pass | Answered (leftovers pass, **Verified**): `REPORT_CRIME` uses 37 (20 calls), 36 (12) and 13 (2) in 7 scripts, with one call passing a variable. `SUPPRESS_CRIME_THIS_FRAME` uses 29 numbers in 11 scripts, with 28 the most (4). Names as in AI-048 ([wanted level](/docs/ai/wanted-level-and-police.md)) |

## The world

### [Interiors and IPLs](/docs/world/interiors-and-ipls.md) (R4.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-001 | A list of IPL names with the interior or building each one controls | Second pass: match IPL names to the ymaps they load | Mostly answered: all 410 literal IPL names are script-loaded ymaps, 134 with an interior; by prefix family; a place-by-place list is third pass (leftovers pass, [interiors and IPLs](/docs/world/interiors-and-ipls.md)) |
| WLD-002 | What `building_controller` swaps, building by building | Second pass | Answered: one function describes 198 buildings. 180 have IPL state names (up to three states; `REMOVE_ALL_STATES` clears all of them), three are FIB building model swaps, and the rest work through areas or interiors. The full table is in the guide (leftovers pass, [interiors and IPLs](/docs/world/interiors-and-ipls.md#what-building_controller-swaps-leftovers-pass)) |
| WLD-003 | Which Online interiors work offline with IPLs alone | Test card 2; second pass | Open |

### [Map data](/docs/world/map-data.md) (R4.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-004 | The exact meaning of the ymap `flags` values 1, 2, 3 | Second pass: compare with the IPL names scripts request | Answered: bit 1 script-loaded (all 410 requested IPL ymaps have it), bit 2 LOD (leftovers pass, [map data](/docs/world/map-data.md#flags-story-mode-entities-and-manifests-leftovers-pass)) |
| WLD-005 | How many entities the story-mode map loads (only ymaps active outside Online) | Second pass: filter by IPL state | Partly answered: about 715,000 entities once script-loaded maps and replaced DLC copies are left out; which pack change sets apply in story mode is open (leftovers pass, [map data](/docs/world/map-data.md#flags-story-mode-entities-and-manifests-leftovers-pass)) |
| WLD-006 | How `re_lossantosintl` and `re_yetarian` enforce their areas | Second pass | Answered: neither enforces an area. `re_lossantosintl` creates and flies `jet` airliners in and out of the airport (`TASK_PLANE_MISSION`) while the player is on foot or in a car and not wanted. `re_yetarian` is random event 30 at Simeon's dealership (goons, a sniper step, three cars) (leftovers pass, [map data](/docs/world/map-data.md#restricted-areas)) |
| WLD-007 | How the LOD manifests (`.ymf`) tie ymaps together | R4.5, second pass | Answered: ytyp dependencies, HD texture bindings, 938 named IPL groups (47 by hour, 44 by weather) and interiors (leftovers pass, [map data](/docs/world/map-data.md#flags-story-mode-entities-and-manifests-leftovers-pass)) |

### [Random events](/docs/world/random-events.md) (R4.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-008 | The event index of each script, and the full character and time rules per event | Second pass: the index each script passes to the check | Answered: 34 indices (0 `re_accident` to 33 `re_monkey`), from literals or a shared name table in 35 event scripts, with the character rules: 18 Trevor only; 19, 28 and 30 not Trevor; 20 not Franklin; 13 and 22 depend on the variant. The time-of-day windows are inside each script (leftovers pass, [random events](/docs/world/random-events.md#each-events-index-cooldown-character-and-unlock-leftovers-pass)) |
| WLD-009 | How long each event's cooldown is | Second pass: read where each script writes its next allowed time | Answered: a shared table in game hours added to the in-game clock when the event ends. Most events 30; ATM robbery 200, deal gone wrong 120, domestic, getaway driver, drunk driver, security van and Yetarian 60, muggings, snatched and stag do 40, hitch lift 35, bus tours 0; events 31 to 33 have none (leftovers pass, [random events](/docs/world/random-events.md#each-events-index-cooldown-character-and-unlock-leftovers-pass)) |
| WLD-010 | How `re_armybase`, `re_prison`, `re_lossantosintl` and `re_yetarian` are started | Second pass: [launch graph](/scripting/script-launch-graph.md) | Answered: `controller_ambientarea` starts `re_armybase` within 1,000 m of Fort Zancudo and `re_prison` within 300 m of the prison (stack 1,424). `re_yetarian` is a world-point brain registered in `standard_global_init` (150 m), whose point isn't in `ambient.ipl`. No script registers or starts `re_lossantosintl` (leftovers pass, [map data](/docs/world/map-data.md#restricted-areas)) |
| WLD-011 | When each event is unlocked (story progress) | R5.1 second pass | Partly answered: the unlock bits are set by `code_controller` actions 24 (13 events), 27 (17 events), 28 (event 32), 29 (event 13) and 30 or 88 (event 30), by `lesterhandler` (event 7) and by `photographymonkey` (event 33). Left: which story moment schedules each action (leftovers pass, [random events](/docs/world/random-events.md#each-events-index-cooldown-character-and-unlock-leftovers-pass)) |
| WLD-012 | The world brain activation range and how the engine picks between nearby points | Test card 2 | Open |

### [Time, weather and wind](/docs/world/time-and-weather.md) (R2.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-013 | How long one `TimeMult` unit lasts, and whether the cycle position is tied to the game clock or to real time (story vs Online) | Test card 1; second pass | Open |
| WLD-014 | Whether wind changes the flight of aircraft, the drift of boats, or bullets | Test card 3; R2.2, R2.4 | Open |
| WLD-015 | What the global flag that skips the post-death weather reroll is, and which scripts set it | Second pass: read the writers of that global in `respawn_controller`'s callers | Answered: `Global_4525837` in build 1.0.3725.0. Only `replay_controller` sets it, when a mission replay is set up while the player isn't playing (dead or arrested), and `respawn_controller` clears it after each respawn. So only a death that leads into a replay keeps the weather (leftovers pass, [time and weather](/docs/world/time-and-weather.md)) |
| WLD-016 | How `SET_OVERRIDE_WEATHER` and the persistent lock interact when both are set | In-game test | Open |
| WLD-017 | What the 380 timecycle variables per region do, and how timecycle modifiers stack on the weather | R13.2 | Partly answered: there are 423 variables per region (not 380), grouped by name; stacking is engine code (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| WLD-018 | The base length of one weather `TimeMult` unit (not in the file) *(from the guide's text)* | In-game test | Open |
| WLD-019 | Whether wind pushes aircraft or boats *(from the guide's text)* | In-game test | Open |

## Gameplay

### [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) (R3.9)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-001 | How `stock_controller` moves prices and which story events move which company | Second pass | Mostly answered: LCN random walk with caps, BAWSAQ from community stats, the story stock events; counters mapped to companies by code (GP-090); only the company names (text) are left ([economy](/docs/gameplay/economy/economy-and-pickups.md#the-stock-market-second-pass)) |
| GP-002 | Where `pickup_controller` places each pickup and when they respawn | Second pass: its coordinate tables | Answered: 253 pickups in seven groups, 10-minute regeneration, removed during mission types 13 and 14 ([economy](/docs/gameplay/economy/economy-and-pickups.md#the-pickups-pickup_controller-places-second-pass)) |
| GP-003 | How shop robberies pay out (the till amounts) | Second pass: `shoprobberies` | Answered: bag $220 to $786 (dropped bag $50 to $219); own till grabs $10 to $50 each ([economy](/docs/gameplay/economy/economy-and-pickups.md#what-a-shop-robbery-pays-second-pass)) |
| GP-090 | Which company each of the 126 `sm_` stock counters feeds, and the English names of the 80 companies (`BSS_BSTR_` labels, not in the base text files) | Third pass | Mostly answered: 95 counters map to company codes, and all 80 company names are in `global.gxt2` (`BSS_BSTR_<2n>` name, `<2n+1>` ticker; leftovers pass); how the 31 counters without a code are used is still open ([economy](/docs/gameplay/economy/economy-and-pickups.md#the-stock-market-second-pass)) |
| GP-004 | The full list of `SPx_MONEY_SPENT_*` categories | R1.7 | Answered: 10 categories plus the total, and a second shop family `SPx_SP_MONEY_SPENT_*` ([economy](/docs/gameplay/economy/economy-and-pickups.md#where-story-money-is-booked-second-pass)) |

### [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (R5.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-005 | How many cutscene files ship (`.cut` in the `x64` archives and DLC packs) and how they are organised | R0.7 atlas, R13.4 animation | Answered: 807 `.cut` files (465 base in 82 `cuts_*.rpf`, 342 in 26 DLC packs), 729 scenes once parts are merged, 8,994 clip dictionaries ([cutscenes 6.3.1](/docs/gameplay/missions/cutscenes-and-dialogue.md#631-the-cutscene-files-second-pass)) |
| GP-006 | Exact meanings of the `START_CUTSCENE` and `REGISTER_ENTITY_FOR_CUTSCENE` flag bits | Second pass, in-game tests | Open |
| GP-007 | The layout of `dialogue_handler`'s request globals (speakers, root, block, flags) | R0.4 global map | Answered: every request field, the priority rule and all states (0 idle, 1 build, 2 wait for the phone, 3 wait for a preloaded call, 4 playing, 5 hung up, 6 ended) ([cutscenes and dialogue 6.5](/docs/gameplay/missions/cutscenes-and-dialogue.md#subtitles-and-phone-calls-second-pass)) |
| GP-008 | How subtitles are hidden or shown (frontend setting) and how phone calls differ from face-to-face lines | Second pass | Answered: [cutscenes and dialogue 6.5](/docs/gameplay/missions/cutscenes-and-dialogue.md#subtitles-and-phone-calls-second-pass) |

### [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md) (R5.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-009 | Who starts `minigame_stats_tracker` and `minigame_ending_stinger` (not started by name in this build) | Next pass: search by hash | Answered: neither is named anywhere, by string or hash ([minigames 42.5](/docs/gameplay/missions/minigames-and-activities.md#425-scoring)) |
| GP-010 | The flight-school, range and triathlon medal thresholds | Next pass: read each script's goal tables | Answered: flight school 90/80/70 per lesson with the 12 lessons' goals, the range's points goals per challenge, triathlon has no medals (top three for completion) ([minigames 42.5.1](/docs/gameplay/missions/minigames-and-activities.md#4251-medals-and-goals-second-pass)) |
| GP-011 | Golf: course data, AI foursome behaviour, how the score is kept | Next pass | Answered: nine holes, par 36, strokes against par, the save fields; leftovers pass: the club distance table, the automatic shot setup by lie and distance, how the computer players aim (5.5-degree steps around a blocked line), the lie multipliers and the wind ([minigames 42.5.1](/docs/gameplay/missions/minigames-and-activities.md#4251-medals-and-goals-second-pass)); the ambient golfers: 07:00 to 17:59, one group of four with two carts (two groups on the putting holes), moving to a hole the player isn't on, stopping on a wanted level, aiming, shooting or damage |
| GP-012 | How the flow unlocks each activity (blips appear after story missions) | Next pass, with [story flow](/docs/gameplay/missions/story-flow.md) | Mostly answered: every activity's unlock source is in GP-088 except code entries 6, 12 and 18 ([minigames 42.2.1](/docs/gameplay/missions/minigames-and-activities.md#4221-how-an-activity-is-unlocked-second-pass)) |
| GP-013 | The sea-race labels (`SNCA`, `SSC`, `SCAA`, `SCAB`) and street-race labels in English | Text files ([R8.3](/ROADMAP.md)) | Answered: [minigames 42.2](/docs/gameplay/missions/minigames-and-activities.md#422-the-activity-list) |
| GP-014 | The towing quick-bonus check (what the 12 s timer measures) | Next pass | Answered: 12 s from entering the job's target area to the end; pay and bonus only after 5 completed jobs ([minigames 42.4](/docs/gameplay/missions/minigames-and-activities.md#424-fees-and-pay)) |
| GP-088 | Which scripts arm the `code_controller` entries that unlock base jumps, golf, hunting, off-road, flight school, the races, stunts, towing and trafficking, since no strand does | Third pass | Mostly answered: `Extreme1` (base jumps), `Hunting2`, `Hao1` (street races), flow phone calls (off-road after `trevor1`, flight school after `trevor3`, golf and tennis after `family3`/`armenian3`), `player_controller` (stunt planes), `traffickingteleport`; entries 6, 12 (sea races) and 18 (towing) still unexplained ([minigames](/docs/gameplay/missions/minigames-and-activities.md#4221-how-an-activity-is-unlocked-second-pass)) |
| GP-015 | What starts `minigame_stats_tracker`'s medal result screen (`mission_complete` Scaleform, `SET_MEDAL`); no script starts it by name *(from the guide's text)* | Second pass | Answered: nothing starts it in this build ([minigames 42.5](/docs/gameplay/missions/minigames-and-activities.md#425-scoring)) |

### [Anatomy of a story mission](/docs/gameplay/missions/mission-anatomy.md) (R5.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-016 | Where `armenian1`, `jewelry_heist` and `trevor1` set the skip flag (`Global_96580`), since they don't do it in their own code | Next pass of R5.2 or R5.8 | Answered: `flow_controller` opens the fail screen for every mission the flow runs and sets the flag there (two fails without progress, bit 16 clear) ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |
| GP-017 | The exact meaning of `replay_controller` states 1 to 6 and 11 to 13 | R5.8 | Answered: states 0 to 13 named, with the replay types that pick the menu ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |
| GP-018 | How the snapshot in `Global_108447` is restored on retry, and what it leaves out | R5.3 | Answered: clock, weather, cash, weapons, outfits, tattoos, special ability, texts and the player ped are restored; other stats and the world aren't ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |
| GP-019 | How crew skill changes the heist take and the fail labels in `Local_3373` | Third pass (was: R7.8 (heists)) | Mostly answered: fail labels fixed; in the Jewel Store Job the gunman's tier scales each case (×1/0.9/0.8), the hacker's sets the alarm window (90/65/55 s), a lost bag costs a third (floor $2,741,082); the other heists' effects not read ([mission anatomy](/docs/gameplay/missions/mission-anatomy.md)) |
| GP-020 | How `mission_repeat_controller` replays a mission without moving the flow (from guide 2) | R5.3 | Answered: the flow-started flag is cleared and the game is saved and reloaded around the replay ([mission anatomy 3.9](/docs/gameplay/missions/mission-anatomy.md#39-passing)) |
| GP-021 | What the mission triggerers build before a mission starts (lead-in scenes, from guide 2) | R5.2 second pass | Partly answered: what each triggerer creates and its lead-in labels; no triggerer plays a cutscene; leftovers pass: label prefixes matched to missions (our reading), and the set-ups are called only through `Call_Loc` on a per-mission table (59 of 65 lead-in labels sit in functions with no named caller). The exact scene-to-mission map needs a YSC reader for the table's addresses; the handover is still open ([mission anatomy 3.3.1](/docs/gameplay/missions/mission-anatomy.md#331-before-the-script-starts-the-lead-in-second-pass)) |
| GP-022 | Where `armenian1`, `jewelry_heist` and `trevor1` unlock their skip (they honour `Global_96581` but don't set `Global_96580` themselves) *(from the guide's text)* | Second pass | Answered with GP-016 ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |

### [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) (R5.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-023 | What exactly NoEditorRestrictions patches, and the vanilla limits it lifts (free camera distance, restricted areas) | Second pass with the executable; test card 3 | Open |
| GP-024 | The meaning of `replay_controller` states 1 to 6 and 11 to 13 | Second pass (also open in mission anatomy) | Answered with GP-017 ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |
| GP-025 | The `REPLAY_START_EVENT` and `REPLAY_RECORD_BACK_FOR_TIME` type numbers | Second pass | Partly answered: who passes each value (4 and 3 story missions, 1 and 0 side missions, 2 six scripts); the engine meaning is new GP-087 ([replay guide](/docs/gameplay/missions/replay-director-and-editor.md#the-clip-recorder)) |
| GP-026 | Where director mode's restricted places (the prison and others) are defined | Second pass: the area checks in `director_mode` | Answered: a 200 m circle around the prison is the only restricted area; the other spots only move the start point ([replay guide](/docs/gameplay/missions/replay-director-and-editor.md#director-mode-director_mode)) |
| GP-027 | The 10 post effects `startup` registers for the editor | R13.2 second pass | Answered: `No_Filter` and `phone_cam1` to `_7`, `_9`, `_12` (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| GP-087 | What the engine does with the type number of `REPLAY_RECORD_BACK_FOR_TIME` and `REPLAY_START_EVENT` (values 0 to 4) | Third pass, the executable | Open |

### [The story mission flow: how missions unlock](/docs/gameplay/missions/story-flow.md) (R5.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-028 | The remaining 40-odd command types (blips, contacts, texts, unlocks, savehouses, character state) | Next pass of R5.1 | Answered: all 69 used types named from their handlers, with use counts; 18 more hashes have no builder in build 3725 ([story flow 2.4.1](/docs/gameplay/missions/story-flow.md#241-every-command-type-second-pass)) |
| GP-029 | The meaning of mission-table field 12 above bit 4, and of the option flags in field 15 | Next pass of R5.1 | Mostly answered: field 12 answered; every field 15 bit tabulated with its missions and readers, effects read for 1, 3, 4, 5, 7, 13, 14, 16, 20, 21, 24, 25, 26, 27, 29, 30; bits 2, 6, 8 to 12, 17 to 19, 22, 23, 28 are only tested inside `flow_controller`, `mission_repeat_controller` or the triggerers ([story flow 2.2.1](/docs/gameplay/missions/story-flow.md#221-the-mission-table-flags-second-pass)) |
| GP-030 | How `agency_heist2` and Blitz prep 3 are reached | R5.2 | Answered: `agency_heist2` by a one-off mission builder in the Bureau Raid strand; strand 11 is never run, `FBI4_Prep3Amb` starts prep 3 and nothing waits for it ([story flow 2.5](/docs/gameplay/missions/story-flow.md#25-the-32-strands)) |
| GP-031 | The pass and fail labels of each mission command: what happens on a fail | R5.2 (the mission side is in [guide 3](/docs/gameplay/missions/mission-anatomy.md#37-failing)) | Answered: a fail jumps to the fail label only with field 15 bit 1; the third target of `finaleA`/`finaleB` is never read (endings use flags 134 to 136) ([story flow 2.4.2](/docs/gameplay/missions/story-flow.md#242-what-a-fail-does-to-the-flow)) |
| GP-032 | What the flow integers (`f_99.f_58`) hold; index 120 is read 1,434 times | R5.1, R5.3 | Answered: every flag ID's flow setters, script setters, `code_controller` entry and reference count in one table, with readings (characters playable 115 to 117, the endings 134 to 137, heist planning flags ...) ([story flow 2.6.1](/docs/gameplay/missions/story-flow.md#261-the-flag-ids-second-pass)) |
| GP-033 | How `mission_repeat_controller` replays a mission without moving the flow | R5.2 | Answered with GP-020 ([mission anatomy 3.9](/docs/gameplay/missions/mission-anatomy.md#39-passing)) |

### [Strangers, freaks and side content](/docs/gameplay/missions/strangers-and-freaks.md) (R5.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-034 | The unlock condition of each entry (flow flags, character) from the remaining table fields | Second pass | Mostly answered: the conditions and every gating flag's setter (GP-089); `MrsPhilips2` and `Rampage3` releases open ([strangers 20.3.1](/docs/gameplay/missions/strangers-and-freaks.md#2031-what-makes-an-entry-available-second-pass)) |
| GP-035 | Where the world points are placed and how many there are per brain | Map data, R4.6 second pass | Open, moved to the third pass: the placements are in the map data, not the scripts. The leftovers pass checked ymap extensions, archetype effects, scenario types and chaining nodes: none holds the brain names |
| GP-036 | What the object-brain percentage and flags mean | Second pass, in-game test | Answered: the last argument is the brain-set mask (1 story, 8 Online, 9 both); percentage always 100, the fourth argument always -1 ([strangers 20.2](/docs/gameplay/missions/strangers-and-freaks.md#202-script-brains)) |
| GP-089 | Which scripts set the flag IDs that gate stranger entries (74, 84 to 110, 133) and release `MrsPhilips2`, `Rampage3` and `TheLastOne` | Third pass | Mostly answered: every flag's setter (pass → code entry → message → code entry chains, collectibles, the Epsilon site, 100% for 133); `TheLastOne` released at 100% by `completionpercentage_controller`; `MrsPhilips2`, `Rampage3` and code entry 95 open ([strangers](/docs/gameplay/missions/strangers-and-freaks.md#2031-what-makes-an-entry-available-second-pass)) |

### [Character switching](/docs/gameplay/player/character-switching.md) (R6.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-037 | What each character's saved state holds (position, outfit, weapons, vehicle, money) and where in the story save | Second pass, with R1.7 saves and the [global map](/docs/core/global-map.md) | Answered: `PP_INFO_STRUCT` with its named arrays per character; cash is in the `SP0` to `SP2_TOTAL_CASH` stats ([switching 9.4.1](/docs/gameplay/player/character-switching.md#941-what-is-saved-for-each-character-second-pass)) |
| GP-038 | The 42-entry scene table's conditions (time, place, mission state) | Second pass | Mostly answered: six-hour blocks, flag-switched weighted lists, a forced scene, the pull toward a waiting mission; leftovers pass: Trevor's pickers (three hour blocks, two parts switched off by flow flags 58 and 59, their forced scenes, weights and remainders); the draw (150 m mission pull, weighted pick) and the 15 tests of the scene check (one-time scenes, last scene and its family, the last five, missions on offer, flow bits, the city box, weather, 400 m from the player); left: the meaning of tests 4, 5, 8, 9 and 13 ([switching 9.4.2](/docs/gameplay/player/character-switching.md#942-which-arrival-scene-is-picked-second-pass)) |
| GP-039 | The meaning of switch flag bits 1, 2, 4, 8 | NativeDB notes plus a test card | Open |
| GP-040 | Who starts the `family_scene_*` scripts | R0.5 second pass (launch graph) | Answered: `main`, within 100 m of five house points ([launch graph](/scripting/script-launch-graph.md#launches-by-variable-and-by-table-second-pass)) |

### [Controls and camera](/docs/gameplay/player/controls-and-camera.md) (R6.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-041 | The names of controls 365 to 401 | Second pass: the game's own control list (`controls.xml`, settings menu text) | Answered: since build 3717 the 37 creator controls sit at 257 to 293 and the old 257 to 364 moved to 294 to 401, so 365 to 401 are the old 328 to 364 (`VEH_HYDRAULICS_*`, `VEH_MELEE_*`, `VEH_ROCKET_BOOST`, `VEH_TRANSFORM` ...) ([controls](/docs/gameplay/player/controls-and-camera.md#the-numbering-changed-in-build-3717-second-pass)) |
| GP-042 | Which shared helpers produce the near-identical disable counts, and what each blocks | Second pass | Answered: three Online combat, weapon-select and pause helpers (247 scripts), two vehicle-control helpers (321 scripts), a story lead-in freeze (85) ([controls](/docs/gameplay/player/controls-and-camera.md#the-shared-disable-helpers-second-pass)) |
| GP-043 | How `SET_INPUT_EXCLUSIVE` and `DISABLE_CONTROL_ACTION` interact when two scripts disagree | In-game test | Open |
| GP-044 | The context and mode numbers, read from the scripts' own constants | Second pass | Answered: contexts 0 on foot, 1 car, 2 bike, 3 boat, 4 plane, 5 sub, 6 heli, 7 turret; mode 4 first person, 3 and 4 treated alike by the help-text helper ([controls](/docs/gameplay/player/controls-and-camera.md#the-view-mode-first-and-third-person)) |
| GP-091 | Whether the `PAD` natives on build 3717+ still treat an old control number (257 to 364) as the old control, so old mods keep working | In-game test (controls test card 4) | Open |

### [Flying](/docs/gameplay/player/flying.md) (R3.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-045 | Flying blocks of all DLC aircraft | Second pass with every DLC `handling.meta` | Answered: 63 flying blocks, 41 from 12 DLC packs, with their ranges and the top thrust values (leftovers pass, [flying 19.2.1](/docs/gameplay/player/flying.md#1921-the-dlc-aircraft-leftovers-pass)) |
| GP-046 | What `SPMED` and `SPSMALL` are | Second pass, `vehicles.meta` | Answered: no `vehicles.meta` uses them; left-over flying entries with a weapon block (leftovers pass, [flying 19.2](/docs/gameplay/player/flying.md#192-the-flying-handling-block)) |
| GP-047 | The 12 lessons by name, their aircraft and targets | Second pass, `pilot_school` | Mostly answered: the 12 lesson names (`MGFS_0` to `11`, leftovers pass), the two Maverick set-ups are Skydiving and Drop Zone and the two Frogger set-ups the helicopter lessons; which two fixed-wing lessons use the Cuban 800 is still open ([flying 19.5](/docs/gameplay/player/flying.md#195-the-flight-school)) |
| GP-048 | The mission type numbers used with `TASK_HELI_MISSION` and `TASK_PLANE_MISSION`, with counts | Second pass | Answered: helicopters mostly go to (4), stop (5), flee (8), land (19); planes go to (4) and crash (21, all Online) ([flying](/docs/gameplay/player/flying.md#193-what-scripts-do-with-aircraft)) |

### [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (R3.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-049 | The player's regeneration rate, delay and cap in numbers | Test card 2 | Open |
| GP-050 | What exactly changes below the fatigued and hurt thresholds | In-game test | Open |
| GP-051 | The 5 armour item percentages, read from the shop's data | Second pass: `gunclub_shop` item table | Answered: 20, 40, 60, 80 and 100% (`WT_BA_0` to `4`) ([health](/docs/gameplay/player/health-armour-death.md#armour)) |
| GP-052 | Which personalities each DLC pack adds and their health configs | Second pass with [`tools/dlc-scan.ps1`](/tools/README.md) | Answered: none; the 23 DLC personality files only add holster and movement data for 57 weapons, and no pack has its own `pedhealth.meta` ([health](/docs/gameplay/player/health-armour-death.md#where-it-lives)) |
| GP-053 | How armour splits damage between armour and health for each damage type | R3.1 second pass, in-game test | Open |

### [The Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-054 | How many normal and special parent heads each list has, and which characters the special ones are | In-game test: `GET_PED_HEAD_BLEND_NUM_HEADS` and `GET_PED_HEAD_BLEND_FIRST_INDEX` per type | Open |
| GP-055 | The two unlabelled morph-19 entries and the last column of the appearance table (which sex or body type each row is for) | Third pass (was: Next pass, the item-table caller) | Open |
| GP-056 | How the slider values (0 to 100, -1 to 1) are scaled into the saved `FEATURE_n` and `HEADBLEND_*` floats, and which `FEATURE_n` is which morph | Next pass, the save function and the stat enum mapping | Answered: `FEATURE_n` is micro morph n, saved as min + (max - min) x slider / 100; heritage saved from `GET_PED_HEAD_BLEND_DATA` ([character creator](/docs/gameplay/player/online-character-creator.md#what-is-saved)) |
| GP-057 | The outfit group names (`BEA`, `CAS` ...) and the components of each starter outfit | Third pass (was: Next pass, the outfit tables) | Partly answered: no group labels exist in the text, only per-outfit labels; components left ([character creator](/docs/gameplay/player/online-character-creator.md#open-questions)) |
| GP-058 | The appearance fee and cooldown values | R7.3 tunables, `freemode` | Answered: `character_appearance_charge` $100,000, cooldown 48 minutes, cap 30 in 24 hours ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| GP-059 | Which transition state opens the creator, and what menu `-1392473901` is (used 3 times, probably the character select) | R7.2 (transitions) | Answered: `-1392473901` is `FE_MENU_VERSION_TEXT_SELECTION`, the "LOBBY LIST" screen ([pause menu 23.5](/docs/ui/pause-menu.md#235-the-full-tree-menu-versions-tabs-and-panes)); the creator opens through state 32 when the transition's destination is 2 ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |

### [Online cosmetics and the shops that sell them](/docs/gameplay/player/online-cosmetic-shops.md) (R6.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-081 | What each restriction tag blocks or forces, as a table (hat with hood, glasses with masks ...) | Next pass, the tag checks in `shop_controller` | Partly answered: scripts test 387 tags, 383 in the catalogue; 118 catalogue tags are never tested and 4 tested tags exist in no item; a full per-check table is third pass (leftovers pass, [cosmetic shops](/docs/gameplay/player/online-cosmetic-shops.md#wearing-rules-restriction-tags)) |
| GP-082 | The full `locate` number to menu title map, and why a few menus appear only in some store layouts | Next pass, `clothes_shop_mp` menu builder | Mostly answered: all 322 `CSHOP_TITLE` labels have English text in `CLO_MNU` (leftovers pass); why some menus appear only in some store layouts is still open ([cosmetic shops](/docs/gameplay/player/online-cosmetic-shops.md)) |
| GP-083 | The base-wardrobe tables (labels and prices of the non-DLC clothes) | Next pass | Mostly answered: the base labels' patterns and text; the prices of the 3,541 table entries (77 functions, the same in `clothes_shop_sp` and `clothes_shop_mp`), and how Online scales them with tunables (leftovers pass, [cosmetic shops](/docs/gameplay/player/online-cosmetic-shops.md#hats-glasses-masks-and-other-props)); left: the pack-coded sets (`CLO_GRF_U_` ...) priced elsewhere |
| GP-084 | Which barber items need a rank, and the ranks | Next pass, the unlock checks behind `HAIR_UNLOCK` | Answered: two rank tables in `hairdo_shop_mp`, hairstyles from rank 6 to 25, overlays 0 to 26 ([cosmetics](/docs/gameplay/player/online-cosmetic-shops.md#menus)) |
| GP-085 | The hair and make-up colour counts on this build | In-game test, `GET_NUM_PED_HAIR_TINTS` / `GET_NUM_PED_MAKEUP_TINTS` | Open |
| GP-086 | Which hair fade goes with which hairstyle (the barber adds one when a style is bought) | Next pass, the hairstyle-to-list-slot mapping in `hairdo_shop_mp` | Answered: hair items map to slots 93 to 114 and 123; newer DLC hair names its fade as forced component type 10 ([cosmetics](/docs/gameplay/player/online-cosmetic-shops.md#hair-fades)) |

### [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md) (R6.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-060 | What the "building" table tied to each restart point drives | Second pass | Answered: the static map-blip table; hospitals own blips 14 to 18 (sprite 61), police stations 7 to 13 (sprite 60) ([respawn](/docs/gameplay/player/respawn-death-and-arrest.md#the-restart-points)) |
| GP-061 | Which respawn states (global values 7 and 9) and money categories (3 and 4) skip the charges | Second pass: trace the writers of those globals | Answered: 7 and 9 are `replay_controller` states (a retry relaunching); 3 and 4 are the contact-sheet account values of anyone but the three main characters ([respawn](/docs/gameplay/player/respawn-death-and-arrest.md#what-it-costs)) |
| GP-062 | Exactly which weapons survive an arrest | Test card 2 | Open |
| GP-063 | Which of the 10 hospital damage packs is chosen when | Second pass: read the selector in `respawn_controller` | Answered: one pack at random, each 1 in 10 ([respawn](/docs/gameplay/player/respawn-death-and-arrest.md#what-every-respawn-resets)) |
| GP-064 | Whether the engine picks the nearest enabled point or uses other rules (wanted level, water, the exile) | Test card 3 | Open |
| GP-065 | What the "building" table that `standard_global_init` fills next to each hospital and police station drives (blips, doors, state) *(from the guide's text)* | Second pass | Answered with GP-060 ([respawn](/docs/gameplay/player/respawn-death-and-arrest.md#the-restart-points)) |
| GP-066 | The two respawn states (7 and 9) that skip the death charge, and money categories 3 and 4 that skip both charges *(from the guide's text)* | Second pass | Answered with GP-061 ([respawn](/docs/gameplay/player/respawn-death-and-arrest.md#what-it-costs)) |

### [Player skills and abilities](/docs/gameplay/player/skills-and-abilities.md) (R3.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-067 | How much each activity raises each skill (the `stats_controller` rules) | Second pass: read `stats_controller` | Answered: each skill is recomputed from career stats (for example running distance ÷ 175, unarmed hits ÷ 20, seconds underwater ÷ 30) plus a starting value and bonus points, and never lowered ([skills](/docs/gameplay/player/skills-and-abilities.md#how-skills-grow-second-pass)) |
| GP-068 | What shooting, strength and stealth change, in numbers | In-game tests | Open |
| GP-069 | Which ability type each entry 3 to 16 is | Second pass with the ability type list | Partly answered: entries 0 to 7 follow the eight `SAT_*` types (3 `SNAPSHOT`, 4 `INSULT`, 5 `ENRAGED`, 6 `GHOST`, 7 `SPRINT_SPEED_BOOST`); 8 to 16 have no type, new GP-092 ([skills](/docs/gameplay/player/skills-and-abilities.md#the-special-abilities)) |
| GP-092 | What selects special ability entries 8 to 16, which have no `SAT_*` type | Third pass, the engine | Open |
| GP-070 | The starting skill values of each character in a new game | Second pass: `initial` / `flow_controller` | Answered: a table in `stats_controller` (Michael shooting 79 and stealth 81, Franklin wheelie 71, Trevor flying 82 and strength 79 ...); 100 in Director Mode ([skills](/docs/gameplay/player/skills-and-abilities.md#starting-skills)) |

### [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md) (R3.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-071 | The exact curve from the lung capacity stat to seconds of breath (`DiveRampPow` may be part of it) | Test card 1; R3.6 | Open |
| GP-072 | How fast drowning drains health | Test card 2 | Open |
| GP-073 | What the 5 non-story entries in `PlayerStatInfos` are (their names didn't resolve) | Second pass | Partly answered: the three story entries are `PLAYER_0` to `PLAYER_2`; the five others are identical, start with full plane control, and their names didn't hash from any candidate tried (leftovers pass, [swimming](/docs/gameplay/player/swimming-and-diving.md)) |
| GP-074 | How the fall heights combine with ragdoll and fall damage | R2.3 | Open |
| GP-075 | Swim speed from the stamina and lung stats | R3.6 | Open |

### [Weapons](/docs/gameplay/weapons/weapons.md) (R3.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-076 | Which mod installed the weapon overhaul (and the other 93 replaced files) | Ask the user; R10.1 | Open |
| GP-077 | The hatchet's extra condition, and whether the Gusenberg really waits for `finale_credits` | R3.1 second pass | Answered: the hatchet needs `trevor1` and the returning-player check (`NETWORK_HAS_ROS_PRIVILEGE_PLAYED_LAST_GEN` or profile setting 866 bit 0); the Gusenberg needs only `finale_credits` ([weapons](/docs/gameplay/weapons/weapons.md#49-ammu-nation-in-story-mode)) |
| GP-078 | How story stats and Online rank change `AmmoMax` | Third pass, the engine and the `AmmoMax*` fields of `weapons.meta` (scripts only read the cap with `GET_MAX_AMMO`, 185 scripts) | Partly answered: the six cap fields and their values (250 / 1,000 / 9,999 for ten pools, one value for the other 112); what picks the step in story mode needs the executable or a test (leftovers pass, [weapons 4.4.1](/docs/gameplay/weapons/weapons.md#441-the-six-ammo-caps-leftovers-pass)) |
| GP-079 | Explosion damage and radius per explosive (`explosion.meta`) | R2.5: [fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) | Answered: the 36 base and 51 DLC types with damage and radius (leftovers pass, [explosions](/docs/physics/fire-explosions-projectiles.md#every-dlc-type-with-damage-and-radius-leftovers-pass)) |
| GP-080 | How aim assist and lock-on work for the player versus AI | R3.2 | Open |

## GTA Online

### [Inside `freemode` (first pass)](/docs/online/07-freemode.md) (R7.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-001 | What each of the 183 running-state functions does in detail (this pass labels them from strings only) | Third pass (was: R7.1 second pass, per system) | Open |
| ON-002 | Names of the 60 network event ids and the main script event hashes | Third pass (was: R7.2, R15) | Partly answered: network events described by behaviour ([R7.1 7.6.1](/docs/online/07-freemode.md#761-the-60-network-event-types-second-pass)); no names exist in the scripts for the event types or the 381 script-event hashes |
| ON-003 | The fields of the player and server broadcast data | R0.4 global map | Answered at block level: every player and server broadcast block named and sized, busiest server fields typed ([global map 6.3.1](/docs/core/global-map.md#631-every-broadcast-block-by-its-registered-name-third-pass)) |
| ON-004 | What `freemode_clearGlobals` resets and when | R7.2 | Answered: 31 steps that reset Online global blocks to defaults, started once by `freemode` at start ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-005 | How the host's rotation through participants works | Third pass (was: R7.1 second pass) | Answered: the host's running state advances two counters every frame. `Global_1574689` steps through all 32 slots; `Global_1574684` jumps to the next active participant that isn't on team 8. Seven host functions use the first and six the second (leftovers pass, [7.3](/docs/online/07-freemode.md#73-the-main-loop)) |

### [Rockstar Creator internals: how tracks and maps are built from props](/docs/online/creator-internals.md) (R7.11)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-006 | What job types 4 and 31 are, and what the even and odd race subtypes of a pair mean | Third pass (was: Next pass, with the [job lobby](/ROADMAP.md) (R7.5)) | Mostly answered: odd race subtypes are one-lap (point-to-point) races; types 4 and 31 are handled with missions and Survival but stay unnamed. Leftovers pass: six creators set type 4 in one shared step when the job's `goto.atrig` is non-zero, and no script writes 31, so it only comes from loaded job data ([R7.11 12.3](/docs/online/creator-internals.md#123-from-the-menu-to-a-creator)); left: the names |
| ON-007 | The prop limit in `public_mission_creator`, which uses its own messages (`PMCE_F_P`, `PMCE_F_D`) | Second pass | Answered: 200 props and 20 dynamic props, with the other eleven limits ([R7.11 12.11.1](/docs/online/creator-internals.md#12111-the-mission-creators-limits-second-pass)) |
| ON-008 | The second dynamic list (library 15), library 39 and the other libraries with no text: hidden, Rockstar-only, or text in a pack not read | Third pass (was: Second pass, with every DLC text block) | Mostly answered: 8 of 49 library labels have no text in any block, so not a missed pack; probably hidden or Rockstar-only (leftovers pass, [creator](/docs/online/creator-internals.md#1213-open-questions)) |
| ON-009 | What `GET_USED_CREATOR_BUDGET` measures inside the engine | Reverse engineering, R1.5 (streaming) | Open |
| ON-010 | Which jobs are saved by the full prop writer and which by the sparse one (`func_189`) | Third pass (was: Second pass, compare with the 16 local classic missions ([R7.4](/file-formats/ugc-json.md))) | Answered: `func_189` tests whether `public_mission_creator` is running. Jobs saved then get short writers for 14 sections (props: 14 keys instead of about 120) and lose 7 sections; the other creators save the full form ([creator internals 12.10](/docs/online/creator-internals.md#1210-saving-and-publishing)) |
| ON-011 | Meaning of `chs`, `chs2`, `chpp` and the `cpbs1` to `cpbs3` bits | Third pass (was: Second pass, read the race controller's checkpoint code) | Partly answered: `chs`/`chs2` are size scales (drawn size and pass radius), `chpp`/`chpps` are pitch angles, all checkpoint keys mapped to struct fields, the bits come in primary and secondary pairs, and about a dozen bits' effects are known (submarine and hover mode, forced direction, faded blip, host-only, nitrous). Left: the other bits' names ([creator internals 12.10](/docs/online/creator-internals.md#1210-saving-and-publishing)) |
| ON-012 | How the deathmatch and mission controllers create dynamic props (the race is in 12.11) | Third pass (was: Next pass) | Answered: both controllers create them once, in their entity-creation step, behind `CAN_REGISTER_MISSION_ENTITIES`. They skip model 0, `prop_container_ld_pu` and linked props, check per-prop rule and team fields, and create each prop networked (`OBJ_TO_NET`) through a shared helper. The mission controller can swap the model and caps creation at 6 (or 2) per frame while a lobby flag is set (leftovers pass, [creator internals 12.11.2](/docs/online/creator-internals.md#12112-dynamic-props-in-the-deathmatch-and-mission-controllers-leftovers-pass)) |
| ON-013 | The other creators' own placement (spawn points, enemy waves, capture objects) | Third pass (was: Second pass per creator) | Partly answered: all six creators share one save writer with 41 sections. The survival `surv` section holds a wave count and, per wave, kills, difficulty, three squads, heavy units, four land vehicles, three air units and weapon lists. `ene` has 399 key names and `obj` 248, including the capture and pickup options. Left: which menu sets which key, and each creator's limits ([creator internals 12.10](/docs/online/creator-internals.md#1210-saving-and-publishing)) |

### [DLC storylines in GTA Online](/docs/online/dlc-storylines.md) (R7.9)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-014 | Which stats each flow keys on, step by step | Third pass (was: Next pass, per flow function in `freemode`) | Partly answered: where 18 flows keep their progress (character stat bit words such as 14804 and 12444, a shared word 7880, packed bools such as 30516 to 30518 and 54708 to 54710), and `EXEC_FLW` step by step (bits 14, 15 and 23 of stat 14804). Left: the other flows step by step ([DLC storylines 48.3.1](/docs/online/dlc-storylines.md#4831-where-each-flow-keeps-its-progress-leftovers-pass)) |
| ON-015 | The text of the voice-only flows (`XM4V_FLW`, `S25R_FLW`, `SR2CH_FLW` ...) | Dialogue files, R9.2 second pass | Answered: 40 phone calls whose subtitles are in six DLC dialogue blocks (`XM4VAU`, `SR2CHAU`, `SR2RNAU`, `X24OAU`, `S25MAU`, `S25RAU`), summarised per call family ([R7.9 48.2.1](/docs/online/dlc-storylines.md#4821-the-phone-call-flows-second-pass)) |
| ON-016 | Which update each `fm_content_*` script arrived in (compare decompile commits by build) | Next pass, `git log` of the decompile | Answered: all 97 `fm_content_*` scripts dated by the decompile commit that added them ([R7.9 48.6.1](/docs/online/dlc-storylines.md#4861-when-each-fm_content_-script-arrived-second-pass)) |
| ON-017 | The flows for After Hours, Doomsday and the 2015 heists (no flow label family found) | Third pass (was: Next pass) | Partly answered: After Hours is 143 `BATFM_*` calls in block `BATFMAU` plus texts keyed on stat 7229. Doomsday is 64 `XMFM_*` calls in `XMFMAUD`, with a facility-buy call fired at one map spot, plus `GOPS_*`/`GO_*_R` help. The 2015 heists are Lester and `HEIST_*` help. Left: the call subtitles in the packs' dialogue blocks (data) ([DLC storylines 48.2.2](/docs/online/dlc-storylines.md#4822-after-hours-doomsday-and-the-2015-heists-leftovers-pass)) |
| ON-018 | The mp2025_02 update's name and story | Third pass (was: Next pass, its pack text) | Mostly answered: KnoWay Out, six missions summarised (Negative Press and two titles tied); missions 2, 5 and 6 not tied to their titles (leftovers pass, [DLC storylines](/docs/online/dlc-storylines.md#4862-the-mp2025_02-story-leftovers-pass)) |

### [Heists in GTA Online](/docs/online/heists.md) (R7.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-019 | The units of the failure time bands (minutes of play, *probable*) | Next pass, the mission controller | Answered: minutes; the mission controller compares each band times 60,000 with the mission's elapsed network time plus 10 seconds ([R7.8 47.3](/docs/online/heists.md#473-classic-heists)) |
| ON-020 | The casino target index order (gold or artwork at index 1) | Next pass: the target name function | Answered: 0 cash, 1 gold, 2 artwork, 3 diamonds ([R7.8 47.6.1](/docs/online/heists.md#4761-casino-targets-and-elite-challenges-second-pass)) |
| ON-021 | Cayo secondary loot values (cash, weed, coke, gold, paintings) and bag capacity | Third pass (was: Next pass: hashed tunables near the primary values) | Mostly answered: `heist_island_planning` rolls each type's value between two hashed tunables (cash 78,750 to 83,250, weed 130,500 to 135,000, cocaine 198,000 to 202,500, gold 328,333 to 333,333, paintings 157,500 to 180,000; the type mapping is our reading). It rounds up to 100, scales by a factor of 1.2 to 1, places 1 or 2 paintings over 7 spots, and saves everything to stats 9495 to 9508. Left: bag capacity ([heists 47.6.2](/docs/online/heists.md#4762-cayo-perico-secondary-loot-values-leftovers-pass)) |
| ON-022 | How the classic apartment board is drawn and which script owns it | Next pass, `freemode` | Answered: owned by `fmmc_launcher`, movies `heist_mp`, `heistmap_mp`, `heist_pre` drawn with `DRAW_SCALEFORM_MOVIE_3D_SOLID` ([R7.8 47.6.1](/docs/online/heists.md#4761-casino-targets-and-elite-challenges-second-pass)) |
| ON-023 | Elite challenge rewards for each heist | Third pass (was: Next pass) | Mostly answered: Doomsday, Casino and Cayo elite values from the tunables; classic heists' values come from the job files (ON-076) |
| ON-024 | The heist story arcs and their contacts | Third pass (was: [R7.9](/ROADMAP.md)) | Partly answered: each heist's story dialogue is mapped to its script and dialogue blocks: the casino `HS3LEAU`/`HS3PRAU` (80 roots), Cayo `HS4PAAU`/`HS4PSAU`/`H4SCPAU` (over 600), Doomsday `XMFMAUD` in `freemode`, and the classic heists through Lester in `freemode`. Left: the lines themselves (dialogue text, data) ([heists 47.6.3](/docs/online/heists.md#4763-where-each-heists-story-talks-leftovers-pass)) |
| ON-025 | Which script draws the apartment heist planning board for the classic heists *(from the guide's text)* | Second pass | Answered: `fmmc_launcher` ([R7.8 47.6.1](/docs/online/heists.md#4761-casino-targets-and-elite-challenges-second-pass)) |
| ON-076 | The classic heists' elite rewards and targets as set in the mission controller (the tunables only override them) | Third pass, `fm_mission_controller` | Answered as far as scripts go: the controller uses Doomsday/Casino tunables, then the classic override, else the job's own content data; the values need the finales' job files ([heists](/docs/online/heists.md)) |

### [Interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-026 | The story-mode slot list (which apps each character has) | Second pass, `cellphone_controller` by character | Answered: one story list for all three characters, and the Online list ([R7.10 21.2.1](/docs/online/interaction-menu-phone-apps.md#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass)) |
| ON-027 | The full interaction-menu tree and its conditions | Second pass, `am_pi_menu` | Answered: the top page with each item's conditions and all 144 pages by area ([R7.10 21.3.1](/docs/online/interaction-menu-phone-apps.md#2131-the-menu-tree-second-pass)); per-page conditions stay in each page's function |
| ON-028 | Every website page and what each sells | Second pass, `appinternet` | Answered: the eight selling sites with their numbers and stock counts, and the 683-item model list ([R7.10 21.5](/docs/online/interaction-menu-phone-apps.md#215-the-internet)) |
| ON-029 | The Facade phone's movie and the character-to-phone mapping | Second pass | Answered: `cellphone_facade` is Trevor's; the four-entry phone table ([R7.10 21.2.1](/docs/online/interaction-menu-phone-apps.md#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass)) |
| ON-067 | Who sets the story phone's Sniper-app flag, and what the two Online flags are that switch the phone to the Badger skin and empty slot 24 | Third pass, `cellphone_controller` callers | Answered: the Badger flags are set by the mission controllers when the player is in Franklin's (`p_franklin_02`) or Lamar's (`ig_lamardavis_02`) model; the Sniper flag (`Is_Sniper_App_Available`) is written by no script ([phone](/docs/online/interaction-menu-phone-apps.md)) |
| ON-068 | What website items 323, 324, 357 and 402 are (hashes set at start that match no model name) | Third pass, the preview code in `appinternet` | Answered: not models. They are placeholder hashes (`Global_77303` to `77306`, set in `standard_global_init`) for four package items that `appinternet` names `BIG_TRUCK`, `BALLISTIC`, `BIG_PLANE` and `HACKER_TRUCK`: the Mobile Operations Center, Ballistic Equipment, Avenger and Terrorbyte, matching the catalogue keys `VE_BIG_TRUCK_t0_v0` and so on (leftovers pass, [phone and apps](/docs/online/interaction-menu-phone-apps.md)) |
| ON-069 | Each interaction-menu page's own show and grey conditions (the top page is mapped) | Third pass, `am_pi_menu` page by page | Partly answered: the two greying layers (drawn grey, and usable when highlighted), counts for all 143 page builders (804 rows: 385 conditional, 605 with run-time greying), and the Preferences, body armour and vehicle pages read in full; the other pages' checks are left ([21.3.2](/docs/online/interaction-menu-phone-apps.md#2132-how-a-page-decides-what-shows-and-what-is-greyed-third-pass)) |

### [The job lobby (`fmmc_launcher`)](/docs/online/job-lobby.md) (R7.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-030 | The exact role of states 7 and 10, and which idle exits go to 4, 8 and 9 | Next pass, follow `func_13037`'s conditions | Answered: state 7 starts the impromptu deathmatch, state 10 is the next playlist job; every idle exit with the flag and script that raises it ([R7.5 13.3](/docs/online/job-lobby.md#133-the-11-top-level-states)) |
| ON-031 | The meaning of each of the 21 start-argument values | Next pass, read a controller's entry function | Answered: the launcher sets only the network instance (`.f_16`) and one job value (`.f_2`) ([R7.5 13.5](/docs/online/job-lobby.md#135-from-job-type-to-running-controller)) |
| ON-032 | How the corona's settings are stored and sent to the controller | Next pass, with `Global_2685150` | Answered: host's choices in `GPBD_FM_2`, copied to the lobby state's `.f_669`; races also use `GlobalServerBD_Races` ([R7.5 13.5](/docs/online/job-lobby.md#135-from-job-type-to-running-controller)) |
| ON-033 | How playlists and series step from job to job (`FMMC_PlayList_Controller`) | Next pass | Answered: each playlist job is a new session; the playlist hands the next content id to the launcher ([R7.5 13.7.1](/docs/online/job-lobby.md#1371-playlists-and-walk-in-markers-second-pass)) |
| ON-034 | How a walk-in job marker in freemode hands over to the launcher | R7.1 second pass (`freemode`) | Answered: the walk-in conditions and the launcher flag `freemode` raises ([R7.5 13.7.1](/docs/online/job-lobby.md#1371-playlists-and-walk-in-markers-second-pass)) |
| ON-070 | What the job value in start argument `.f_2` is, and what lobby flag bit 1 and `.f_880` are raised for | Third pass, the `freemode` and `maintransition` writers | Partly answered: `.f_880` is raised only by one `freemode` routine, in a branch that checks another active player's index (our reading: joining that player's quick job). Leftovers pass: `.f_2` is the value in its corona's request (`Global_4526171[i].f_15.f_2`, written only by `freemode`, `fmmc_launcher` and `am_npc_invites`), copied by `fmmc_launcher` through `Global_4526143.f_18` and the player's broadcast data into the start block ([job lobby](/docs/online/job-lobby.md)). Lobby bit 1 is raised right after `NETWORK_JOIN_TRANSITION` succeeds on another player (one shared routine in `freemode`, `maintransition` and the launcher; four more call sites in `main_persistent`), and sends idle to state 8 ([job lobby](/docs/online/job-lobby.md)); left: `.f_880`'s exact meaning and `main_persistent`'s four branches |
| ON-071 | What the playlist's `.f_877` position is and how the launcher uses it | Third pass, `fmmc_launcher` state 10 | Answered: a 3D position from the next job's data, passed with its content id to the launcher's job loader ([job lobby 13.7.1](/docs/online/job-lobby.md#1371-playlists-and-walk-in-markers-second-pass)) |

### [Organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-035 | The nightclub's production and popularity numbers (their tunable names are hashed) | Third pass (was: Next pass: match hashes to names from the scripts) | Mostly answered: the safe's pay bands by popularity, its $250,000 cap and 48-minute timer, the popularity change tunables, and each goods type's value, capacity and units one Yohan source job adds ([R7.7 46.5.3](/docs/online/organisations-and-businesses.md#4653-the-nightclubs-safe-and-warehouse-second-pass)); production timing is ON-077 |
| ON-036 | Special cargo warehouse capacities (16, 42 and 111 crates are **Known**) and where the scripts keep them | Next pass | Answered: fixed in the scripts; 22 warehouses in three sizes, 16, 42 and 111 crates ([R7.7 46.5.1](/docs/online/organisations-and-businesses.md#4651-warehouse-sizes-boss-costs-and-the-apps-transactions-second-pass)) |
| ON-037 | How production is stored in stats and advanced while offline or in another session | Third pass (was: Next pass, with the stats file) | Partly answered: the production timer is network time in script memory, and only the time left to the next unit carries over (broadcast data per business slot, `.f_9`), so offline time isn't counted (our reading). A second biker "delay" timer uses cloud time and is backdated by (units − 1) × delay. Left: where the broadcast fields are loaded from and saved to in the stats ([R7.7 46.5.4](/docs/online/organisations-and-businesses.md#4654-how-production-time-is-kept-leftovers-pass)) |
| ON-038 | What `gb_bosscost` and `gb_bosssetupcost` charge | Next pass, `freemode` | Answered: defaults $200,000 and $5,000, but no script reads them in this build ([R7.7 46.5.1](/docs/online/organisations-and-businesses.md#4651-warehouse-sizes-boss-costs-and-the-apps-transactions-second-pass)); new ON-075 |
| ON-039 | The MC challenge and VIP challenge rules (cash, RP, time) | Third pass (was: Next pass, per script) | Answered: the 8 VIP and 3 MC challenges with their scripts, time limits, cash, RP and rules. Leftovers pass: a reward routine shared by 69 scripts picks one cash and RP factor pair. The VIP challenges pay full cash, with RP × 0.5 for anyone but the boss; other work pays 0.7 to a player in a rival organisation, 0.3 to a solo player and 1 to the running organisation ([R7.7 46.5.2](/docs/online/organisations-and-businesses.md#4652-vip-and-mc-challenges-second-pass)) |
| ON-040 | Business battles and the `fm_content_*` business missions | Third pass (was: R7.9 and a later pass) | Partly answered: Business Battles is four scripts. The event has 34 variations, with locations (police stations, Fort Zancudo, the Union Depository, drop sites ...) and enemy groups (The Lost, professionals, armoured guards, mercenaries), four cargo types and an event-cargo chance (`bb_business_battle_event_cargo_weighting` 0.5), and it delivers to the player's nightclub. Left: the payouts and the other `fm_content_*` business missions ([R7.7 46.5.5](/docs/online/organisations-and-businesses.md#4655-business-battles-leftovers-pass)) |
| ON-075 | Where registering as a boss is charged now (`gb_bosscost` and `gb_bosssetupcost` are read by no script) | Third pass, the boss registration code in `freemode` and `am_pi_menu` | Answered: it isn't; the menu only checks that the player could spend `gb_become_boss_threshold` (default 0) ([organisations](/docs/online/organisations-and-businesses.md)) |
| ON-077 | How long a nightclub production step takes, and how technicians are assigned to goods types (the goods tunables are hashed; [R7.7 46.5.3](/docs/online/organisations-and-businesses.md#4653-the-nightclubs-safe-and-warehouse-second-pass)) | Third pass, the business hub code in `freemode` | Answered: one unit takes 140, 80, 240, 120, 40, 30 and 60 minutes for goods types 0 to 6, halved by one upgrade (factor tunable 0.5). Five technician slots are stored as assignment bits in the player's broadcast data. The remaining time of each type is saved in stats 15626 to 15632 and counts down only while three player checks pass (leftovers pass, [R7.7 46.5.3](/docs/online/organisations-and-businesses.md#4653-the-nightclubs-safe-and-warehouse-second-pass)) |

### [Properties in GTA Online](/docs/online/properties.md) (R7.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-041 | How the yacht, Kosatka and other vehicles-as-properties are bought and placed | Next pass, `freemode` yacht code | Answered: websites, stats, the 36 yacht spots ([45.6a](/docs/online/properties.md#yachts-and-other-vehicles-as-properties)) |
| ON-042 | Where garage capacities and vehicle slots are stored, and how a personal vehicle is saved per slot | Third pass (was: Next pass, with the vehicle stats) | Answered: sizes per slot, the 607 `MPSV_*` records, and the full setup struct (ON-066) ([45.6a](/docs/online/properties.md#garage-sizes-and-personal-vehicle-records)) |
| ON-043 | The simple-interior entrance positions and which script places the doors | Third pass (was: Next pass, `am_mp_smpl_interior_ext` tables) | Partly answered: the per-type function table, all 180 simple-interior ids named, and the entrances of the mansions and salvage yards ([45.6a](/docs/online/properties.md#simple-interior-entrances)); the other types' positions are left |
| ON-044 | Instance numbering of `am_mp_property_int` (owner id, building, or both) | Next pass | Answered: per owner, rows 0 to 31, 32 without an owner ([45.6a](/docs/online/properties.md#interior-instances)) |
| ON-045 | Daily property fees (utility bills) and how they are charged | Next pass, `freemode` | Answered: every 48 minutes, fees per property ([45.6a](/docs/online/properties.md#daily-property-fees-utility-bills)) |
| ON-046 | The business side of each simple interior | [R7.7](/ROADMAP.md) | Answered in [organisations and businesses](/docs/online/organisations-and-businesses.md#464-the-business-loop) |
| ON-065 | Which business or vehicle the garage indices 116 to 137 and ownership slots 12 to 35 are | Third pass (was: Next pass, the slot-to-stat functions in `freemode`) | Mostly answered: slots 12 to 35 all named. Slots 33 to 35 are the three mansions, tied through the simple-interior map, so the data file is not needed. Slot 30 is never owned. Indices 115 to 129, 132, 133 and 135 to 137 are tied to their slots by the literal values the purchase code writes (leftovers pass). Left: 130, 131 and 134, which no slot is given ([45.6a](/docs/online/properties.md#garage-sizes-and-personal-vehicle-records)) |
| ON-066 | Where a personal vehicle's colours, wheels and mods are saved | Third pass (was: Next pass, the vehicle save code in `freemode` and `carmod_shop`) | Answered: the personal-vehicle struct (plate, colours, 50 mod slots, tyre smoke, tint, livery, wheels, neons, flags) ([properties 45.6a](/docs/online/properties.md#garage-sizes-and-personal-vehicle-records)) |

### [Rockstar services](/docs/online/rockstar-services.md) (R15.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-047 | The unnamed (`unk_`) tunable readers and which service natives they are | Second pass, NativeDB hashes | Answered: `_NETWORK_GET_TUNABLES_REGISTRATION_INT`, `_FLOAT` and `_BOOL` ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| ON-048 | Which story-mode scripts call any service native, and why | Second pass, per script | Answered: mostly shared guards; real use is minigame leaderboards with crew tags, presence and the returning-player checks ([services 32.1.1](/docs/online/rockstar-services.md#3211-which-story-scripts-touch-a-service-second-pass)) |
| ON-049 | The catalogue item keys and categories | Third pass (was: R7.7) | Mostly answered: keys are hashed strings shaped `<name>_t<type>_v<version>` (157 written out in full, such as `VE_KOSATKA_t0_v0`) or `<PREFIX>_INDEX_<n>_v<version>` (four groups built in 247 scripts). The price calls use ten category hashes, eight of them named (`CATEGORY_VEHICLE_MOD` 333 calls, `CATEGORY_WEAPON_AMMO`, `_WEAPON`, `_WEAPON_MOD`, `_VEHICLE`, `_CLOTH`, `_PROPERTY_INTERIOR`, `_TATTOO`). 1999830656 hashes to `CATEGORY_WAREHOUSE_INTERIOR` (leftovers pass; an odd fit for its two bail-office and salvage-yard calls). Left: the name of 426439576 (1,037 calls; 15.5 million two-word candidates tried) ([Rockstar services 32.2.1](/docs/online/rockstar-services.md#3221-catalogue-keys-and-categories-leftovers-pass)) |

### [Sessions and sync](/docs/online/sessions-and-sync.md) (R15.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-050 | The layout of the big broadcast blocks | Second pass, per controller | Answered at block level: the 37 broadcast blocks with their registered names, sizes and users ([global map 6.3.1](/docs/core/global-map.md#631-every-broadcast-block-by-its-registered-name-third-pass)); field-by-field layouts stay per controller |
| ON-051 | Event type numbers and what each does | Second pass, `freemode`'s event handler | Answered: all 60 network event types with their data size and what `freemode` does; 174 carries script events, 186 is entity damage ([R7.1 7.6.1](/docs/online/07-freemode.md#761-the-60-network-event-types-second-pass)) |
| ON-052 | How migration chooses a new owner and host | Engine reverse engineering | Open |

### [Stats, tunables and the server's role](/docs/online/stats-and-tunables.md) (R7.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-053 | A tool that writes the tunable name, type and default list for one build (read-only, from the decompile), to diff builds and to feed a mod's defaults | Tool idea; R11.2 update check | Open |
| ON-054 | What `SaveCategory` 0 and 1 mean exactly | Second pass | Answered: 1 is the original per-character set (2,522), 0 everything since (15,411) ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| ON-055 | The basket flow step by step in one shop script | R7.6 or a second pass | Answered: the six steps in `clothes_shop_mp` ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| ON-056 | Which tunables a given offline system needs | Per mod, with the defaults list | Answered by method: per mod, read from the tunable index ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| ON-072 | The names behind the 7,296 tunables registered by hash only | Third pass: needs a name list; hash every candidate name | Partly answered: 311 recovered by hashing candidate names (numbered playlist, vehicle-website and `enable_vehicle_*` series); the rest need a name list ([stats and tunables](/docs/online/stats-and-tunables.md)) |
| ON-073 | Whether the two `SaveCategory` groups are saved as separate cloud files | Third pass: in-game or cloud check (read-only) | Open |

### [Story systems that clash with an Online mode](/docs/online/story-systems-in-online-mode.md) (R5.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-057 | The full shop table (index, position, type) from `shop_controller` | Second pass; feeds shop mods | Answered: all 65 entries by script, the cosmetic shops with name, position and interior ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#the-shop-table)) |
| ON-058 | What exactly `clothes_shop_sp` does with a freemode ped (refuses, shows story stock, or breaks) | In-game test | Open |
| ON-059 | What sets 2 and 4 contain (ped brains) | Second pass | Answered: no script registers into sets 2 or 4; the three `pb_prostitute` ped brains take no set ([R5.7 7.3](/docs/online/story-systems-in-online-mode.md#73-script-brains-and-brain-sets)); new CORE-031 |
| ON-060 | How bits 16, 32 and 64 in these masks are raised (they end some systems on other occasions) | R1.2 second pass | Mostly answered: 64 (with 8) by `main`, `mission_repeat_controller`, `benchmark`; 16 and 32 only by the engine, the same question as CORE-032 (executable or in-game logging) |

### [Transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-061 | What enables the offline-mode branch before `START_FM_LAUNCH_SCRIPT` (the function returning true), and whether it can be reached on PC | Second pass | Answered: unreachable; its flag is only ever cleared ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-062 | What the four character "slots" in the retry states are (two characters plus?) and how `HUD_SLOTONE` / `HUD_SLOTTWO` relate | R7.3 stats | Answered: cloud save slots 0 (account), 1 and 2 (the two characters); "Slot 1" and "Slot 2" label the character saves ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-063 | The order of states on the way back to story mode, step by step | Second pass | Answered: 63 then 64, step by step ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-064 | What the testbed session is used for in release builds | Second pass | Answered: only level 5 (development) enters it; unused in release ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-074 | Which scripts outside `maintransition` ask for the return to story mode, and what retry state 13 waits for | Third pass, the callers of the state request | Answered: only `ingamehud` (connection-problem warnings) and `selector` ask for the return; state 13 retries cloud save slot 3 and then sets `mpply_last_mp_char` to 2 ([transitions](/docs/online/transitions-and-sessions.md)) |

## User interface

### [HUD, colours and blips](/docs/ui/hud-colours-blips.md) (R8.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-001 | A picture or name for each of the 191 sprites used | Second pass with the blip icon list | Answered (names; pictures still open): [HUD 24.4](/docs/ui/hud-colours-blips.md#244-blips) |
| UI-002 | What the `listId` draw lists and depths do | Partly answered: list 1 is the top-right stack ordered by `listPriority`, `depth` is draw order ([pause menu 23.6](/docs/ui/pause-menu.md#236-frontendxml-where-the-hud-and-menus-sit)); confirm the stacking with test card 2 there | Partly answered |
| UI-003 | The three colours that differ between `[HD]` and `[CRT]` | Second pass | Answered: [HUD 24.3](/docs/ui/hud-colours-blips.md#243-colours) |

### [Pause and Online menus](/docs/ui/pause-menu.md) (R8.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-004 | The full tree: which header holds which tabs in story mode and Online | Second pass, walk `pausemenu.xml` | Answered: [pause menu 23.5](/docs/ui/pause-menu.md#235-the-full-tree-menu-versions-tabs-and-panes) |
| UI-005 | What `pausemenu_multiplayer` fills on each Online page | R8.5 | Answered (the ONLINE tab list; each sub-page in detail is left): [server-backed screens 25.5](/docs/ui/server-backed-screens.md#255-the-online-tab-entry-by-entry) |
| UI-006 | What `frontend.xml` sets (sizes and positions of HUD and menus) | R8.4 | Answered: [pause menu 23.6](/docs/ui/pause-menu.md#236-frontendxml-where-the-hud-and-menus-sit) |

### [Scaleform movies](/docs/ui/scaleform.md) (R8.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-007 | Movies loaded through variables (not counted), and DLC pack movies | Second pass, DLC scan | Answered: [Scaleform 22.5](/docs/ui/scaleform.md#225-every-movie-its-methods-and-who-names-it) |
| UI-008 | Each movie's full method list | Second pass, read the `.gfx` action scripts | Answered (rebuilt from the `.gfx` files; summary and examples, not the full list): [Scaleform 22.5](/docs/ui/scaleform.md#225-every-movie-its-methods-and-who-names-it) |
| UI-009 | Which interior map `int<number>` belongs to which interior | Second pass with R4.5 | Partly answered: 230 of 282 named, 9 of them from game files in the PC data pass ([Scaleform 22.5](/docs/ui/scaleform.md#225-every-movie-its-methods-and-who-names-it)); 52 left |

### [Server-backed Online screens](/docs/ui/server-backed-screens.md) (R8.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-010 | Which screens still work, partly, when signed out (an offline test is Online-adjacent; read-only analysis only) | Second pass from the guards | Answered from the guards (what the engine returns signed out is UI-020, third pass): [server-backed screens 25.6](/docs/ui/server-backed-screens.md#256-signed-out-what-the-guards-do-second-pass) |
| UI-011 | The full list of transaction calls per business app | R7.7 | Answered: per-app counts of `NET_GAMESERVER_*` natives and the spend and earn natives ([R7.7 46.5.1](/docs/online/organisations-and-businesses.md#4651-warehouse-sizes-boss-costs-and-the-apps-transactions-second-pass)) |
| UI-012 | Leaderboard IDs read by each screen | Second pass | Answered: 39 board IDs in a library shared by 30 scripts ([server-backed screens 25.7](/docs/ui/server-backed-screens.md#257-leaderboard-ids-per-screen-second-pass)) |
| UI-020 | What the stat and Social Club inbox natives return when signed out, which decides what `mp_awards`, `mp_unlocks` and `appmpemail` show ([server-backed screens 25.6](/docs/ui/server-backed-screens.md#256-signed-out-what-the-guards-do-second-pass), only **Known**) | Third pass, the executable (read-only, no Online test) | Open |

### [Story-mode UI](/docs/ui/story-mode-ui.md) (R8.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-013 | The full stat list per category, with display types | Second pass, `spstatssetupui.xml` | Answered: [story-mode UI, the full stat list](/docs/ui/story-mode-ui.md#the-full-stat-list) |
| UI-014 | How a mission chooses its stats and the medal thresholds | Second pass, `mission_stat_watcher` and each mission | Answered: [story-mode UI, stats and medal](/docs/ui/story-mode-ui.md#how-a-mission-picks-its-stats-and-its-medal) (which stats each mission lists is left) |
| UI-015 | The parameters of `SHOW_MISSION_PASSED_MESSAGE` | Second pass | Answered (order and values; what 3, 6 and 7 change on screen is left): [story-mode UI](/docs/ui/story-mode-ui.md#how-a-mission-picks-its-stats-and-its-medal) |

### [Text labels](/docs/ui/text-labels.md) (R8.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-016 | The full slot list and which systems own which slot | Second pass: read the slot constants in `standard_global_init` and the mission scripts | Answered: [text labels, the text slots](/docs/ui/text-labels.md#the-text-slots-and-who-uses-them) |
| UI-017 | How DLC global blocks are merged and which wins on a clash | In-game test; R1.6 | Open |
| UI-018 | A label-name index (most names are only known by hash) | Second pass: hash every string literal in the decompile and match | Partly answered: 29.5% of all labels named, 74% of `global` ([text labels, naming the labels](/docs/ui/text-labels.md#naming-the-labels)); subtitle, credit and track-ID labels left |
| UI-019 | What the 8 blocks `update2.rpf` adds are for | Second pass | Answered: [text labels, the eight blocks](/docs/ui/text-labels.md#the-eight-blocks-update2rpf-adds) |

## Audio

### [How audio is organised](/docs/audio/how-audio-is-organised.md) (R9.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AUD-001 | The number of sounds and sound sets in `sounds.dat54` | Second pass with a `.rel` reader | Answered: 135,128 sounds and 1,658 sound sets (11,187 set entries), by file and kind (leftovers pass, [audio](/docs/audio/how-audio-is-organised.md#2731-what-the-config-files-hold-leftovers-pass)) |
| AUD-002 | What each audio scene changes | Second pass, `dynamix.dat15` | Answered: 2,244 scenes, 2,231 patches, 6,922 category changes (volume, filters, pitch); most category names still hashes (leftovers pass, [audio](/docs/audio/how-audio-is-organised.md#2731-what-the-config-files-hold-leftovers-pass)) |
| AUD-003 | `.awc` counts per archive | Second pass, list every archive | Answered: 7,706 `.awc`, per archive and per pack (leftovers pass, [audio](/docs/audio/how-audio-is-organised.md#2731-what-the-config-files-hold-leftovers-pass)) |
| AUD-004 | Speech archives and voices | R9.2 | Partly answered: 794 ped voice groups, 89,096 `speech2` entries, 875 voice names (leftovers pass, [speech](/docs/audio/speech-and-dialogue.md#2851-voices-and-blocks-leftovers-pass)) |

### [Music and radio](/docs/audio/music-and-radio.md) (R9.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AUD-005 | The 10 base and many DLC station objects whose names didn't resolve | Second pass with more name sources | Answered: every station object has a `RadioName`; 46 hidden stations, the player and club stations, 23 `REPL_*` editor stations (leftovers pass, [music and radio](/docs/audio/music-and-radio.md#stations-music-events-and-track-markers-leftovers-pass)) |
| AUD-006 | How a music event maps to moods and tracks, step by step | R9.1, second pass | Answered: an event is one action object (start track, set mood, stop ...); moods are lists of stem mixes over 8 stems (leftovers pass, [music and radio](/docs/audio/music-and-radio.md#stations-music-events-and-track-markers-leftovers-pass)) |
| AUD-007 | Which DLC stations are available in story mode in build 3725 | Test card 1 | Open |
| AUD-008 | The format of a radio track's data (length, markers for the DJ) | R9.1 | Partly answered: markers are time plus a flag bit; flag meanings are a test, length is in the `.awc` (leftovers pass, [music and radio](/docs/audio/music-and-radio.md#stations-music-events-and-track-markers-leftovers-pass)) |

### [Speech and dialogue](/docs/audio/speech-and-dialogue.md) (R9.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AUD-009 | The list of contexts each voice has, from `speech2.dat4.rel` | Second pass with a `.rel` reader | Partly answered: the byte arrays that hold each voice's contexts are not decoded by CodeWalker; needs a format reader (leftovers pass, [speech](/docs/audio/speech-and-dialogue.md#2851-voices-and-blocks-leftovers-pass)) |
| AUD-010 | Which block name maps to which mission, for all 331 containers | Second pass, with R5.1's mission table | Mostly answered: 194 of 331 containers tied to scripts through their `<name>AUD` text block; 137 are codes built at run time (leftovers pass, [speech](/docs/audio/speech-and-dialogue.md#2851-voices-and-blocks-leftovers-pass)) |
| AUD-011 | The speech parameter names and what each does | Second pass, in-game test | Open |

## Rendering

### [Animation](/docs/rendering/animation.md) (R13.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-001 | The names behind the 22 memory groups and their budget unit | Next pass: hash the candidate names | Mostly answered: 19 of 22 groups named (`MG_*`), budgets and the `combat` memory situation; the unit is probably KB (leftovers pass, [animation](/docs/rendering/animation.md#4381-names-archives-and-sizes-leftovers-pass)) |
| REN-002 | Which clip sets the hashed entries are (resolving the 4,526 keys from script, `peds.ymt` and `weaponanimations.meta` strings) | Next pass | Mostly answered: 3,065 of 4,526 clip sets named, by family (leftovers pass, [animation](/docs/rendering/animation.md#4381-names-archives-and-sizes-leftovers-pass)) |
| REN-003 | Exactly what each `TASK_PLAY_ANIM` flag bit does (262144 and 16777216 in particular) | In-game test | Open |
| REN-004 | The clip archive layout in DLC packs and how many dictionaries each pack adds | With [R0.7](/file-formats/data-file-atlas.md) | Answered: 67 packs, 13,502 dictionaries, in-game and per-cutscene archives (leftovers pass, [animation](/docs/rendering/animation.md#4381-names-archives-and-sizes-leftovers-pass)) |
| REN-005 | The 12 expression dictionaries the update replaced and why | Next pass | Mostly answered: 5 replace a base file, 7 are new; why is not in the files (leftovers pass, [animation](/docs/rendering/animation.md#4381-names-archives-and-sizes-leftovers-pass)) |
| REN-006 | Animation memory cost per dictionary | R18.3 (memory) | Answered: median 40 KB in game, 152 KB in cutscenes, all system memory; the biggest are nightclub DJ sets (leftovers pass, [animation](/docs/rendering/animation.md#4381-names-archives-and-sizes-leftovers-pass)) |

### [Cameras](/docs/rendering/cameras.md) (R13.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-007 | The director priorities and exactly when the cinematic director takes over | Second pass | Open |
| REN-008 | The 50 shake names and other camera names that didn't resolve | Second pass with more name sources | Partly answered: three spline cameras named; 28 shakes named by the sources tried, the rest need another source (leftovers pass, [cameras](/docs/rendering/cameras.md#camera-names-leftovers-pass)) |
| REN-009 | Which `CREATE_CAMERA` hashes scripts use (the hashed form of `CREATE_CAM`) | Second pass: resolve the hashes in the decompile | Answered: six camera hashes, all named (leftovers pass, [cameras](/docs/rendering/cameras.md#camera-names-leftovers-pass)) |
| REN-010 | The view mode contexts and modes as numbers | R6.4 | Answered by GP-044 (P4.9): contexts 0 to 7 and mode 4 first person ([controls and camera](/docs/gameplay/player/controls-and-camera.md#the-view-mode-first-and-third-person)) |
| REN-011 | How the first-person car interior camera is chosen per vehicle (`camVehicleCustomSettingsMetadata`) | R14.1 | Answered: `povCameraName` and offsets per model, and per-seat cameras for 130 models through the gameplay director's list (PC data pass, [cameras](/docs/rendering/cameras.md#the-first-person-car-camera-per-vehicle-and-per-seat-pc-data-pass)) |

### [Particles and decals](/docs/rendering/particles-and-decals.md) (R13.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-012 | The exact decal limit in build 3725 and what limit patches change | Second pass with the executable; R18 | Open |
| REN-013 | How the particle quality setting picks between `ptfx`, `ptfx_hi` and `ptfx_lo` | Test card 2; R18.2 | Open |
| REN-014 | The format of `entityfx.dat`, `materialfx.dat` and `wheelfx.dat` row by row | Second pass | Answered: sections and columns of all three files (leftovers pass, [particles](/docs/rendering/particles-and-decals.md#effect-files-dictionaries-and-mounting-leftovers-pass)) |
| REN-015 | Which DLC dictionaries are mounted in story mode | R1.6 second pass | Answered: all 33 DLC particle archives are switched on in `GROUP_STARTUP` change sets (leftovers pass, [particles](/docs/rendering/particles-and-decals.md#effect-files-dictionaries-and-mounting-leftovers-pass)) |
| REN-016 | Which effect names each dictionary holds (an index) | Second pass: a read-only lister for `.ypt` | Answered: 364 dictionaries, 2,907 effects, counts and name families (leftovers pass, [particles](/docs/rendering/particles-and-decals.md#effect-files-dictionaries-and-mounting-leftovers-pass)) |

### [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md) (R13.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-017 | What each changed key between base and update copies does | Second pass, diff and in-game test | Partly answered: 11 changed, 136 added, 6 removed keys listed; the in-game effect is a test (leftovers pass, [visual settings](/docs/rendering/rendering-and-visual-settings.md#296-open-questions)) |
| REN-018 | How "extended distance scaling" maps to the LOD scale value | In-game test with `GET_LODSCALE` | Open |
| REN-019 | What popular lighting and graphics overhauls change in these files | A comparison, with each author's release page linked | Open |
| REN-020 | Per-pass cost measured on a low-end PC | R18.1 measuring, with a frame capture tool | Open |

### [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md) (R13.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-021 | What the two numbers on each modifier line mean (value and strength? value at two ends of a range?) | Second pass: test with a modifier that sets one variable | Partly answered: the second number is 0 to 1 on 97% of lines, probably a weight; test card still needed (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| REN-022 | What `userFlags` 1, 2, 4, 8 and 16 do | Second pass: compare the modifiers in each group | Mostly answered: 1 water, 2 interiors, 4 and 16 tunnels, 8 `NO_streetAmbient`; a bit field (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| REN-023 | The game hours of the 13 keyframes | Second pass: test card 2 | Open |
| REN-024 | What the 39 unnamed post effects are, and whether anything plays them | Second pass: hash lists from other sources | Mostly answered: 215 of 252 named; the 37 left identified by their layers, none played by literal name (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| REN-025 | How many timecycle boxes and interior room modifiers the map has | R4.6 (map data) | Answered: 6,263 timecycle boxes in 527 ymaps; 1,269 of 1,658 interior rooms name a modifier, plus 939 interior boxes (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#open-questions)) |
| REN-026 | `GroupId` and `EventType` on post effects | Second pass | Partly answered: group 1 on the three Heist4 camera flashes, group 64 and two event hashes on eight transition and view effects; event names unresolved (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |
| REN-027 | Meaning of the timecycle modifier `userFlags` values (0, 2, 1, 16, 4, 8) *(from the guide's text)* | Second pass | Mostly answered with REN-022 (leftovers pass, [timecycle](/docs/rendering/timecycle-and-post-effects.md#modifier-values-flags-and-post-effect-names-leftovers-pass)) |

## Performance

### [CPU: population, AI, physics and scripts](/docs/performance/cpu.md) (R18.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-001 | What one idle SHVDN script costs per frame on a low-end PC (and so what 51 cost) | Test card 1, R18.5 | Open |
| PERF-002 | Whether `-disableHyperthreading` helps on a 4-core, 8-thread laptop | Test card 2 | Open |
| PERF-003 | AI cost per ped type (ambient, combat, driving) | R17.9 | Open |
| PERF-004 | How much of the frame the 52 Rockstar threads take | Needs a profiler (Windows Performance Recorder); second pass | Open |

### [Graphics settings, one by one](/docs/performance/graphics-settings.md) (R18.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-005 | The exact menu label for each value of every quality key | Test card 1 | Open |
| PERF-006 | What rewrites `settings.xml` without the player asking (auto-detection after a driver update, a launcher) | Compare the file before and after a driver update | Open |
| PERF-007 | How much shared memory each texture level takes on integrated graphics | Test card 2, R18.3 | Open |

### [Load times and stutter](/docs/performance/load-times.md) (R18.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-008 | How much each add-on pack adds to the engine loading screen | Test card 1 | Open |
| PERF-009 | Whether the 3-to-10-minute FPS drop is throttling (and how much a cooling pad recovers) | Test card 2 | Open |
| PERF-010 | Whether an antivirus exclusion shortens the loading screen | [Windows and drivers](/docs/performance/windows-and-drivers.md) test card 3 | Open |

### [Measuring performance](/docs/performance/measuring.md) (R18.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-011 | Confirm the benchmark switches and results file, and record a baseline with and without mods | Test card below, R18.5 | Open |
| PERF-012 | What happens in each of the 8 states of the benchmark loop, and how long each pass lasts | Second pass of this topic | Answered: set-up (mission-repeat save), scene set-up, spline camera, scene with time-lapse, `lazer` flight, drive set-up, police chase, results. Scenes are 15 s splines recorded from 5% to 88% (passes 1 to 4, about 12.5 s each). Pass 5 is scene 5 plus a 52 s flight, a 10 s set-up and a chase of up to 75 s (about 2.5 min); one iteration is about 3.5 min plus loading (leftovers pass, [measuring performance](/docs/performance/measuring.md#the-games-benchmark)) |
| PERF-013 | Why `ON_ENTER_MP` blocks for about 9 s: which map data it swaps | R1.5 streaming, R18.8 load times | Partly answered: a `DLC` native, called once per story-to-Online switch by `maintransition` and the two creators behind a faded screen, followed by a wait on `ARE_ANY_CCS_PENDING`; it applies the DLC packs' content change sets (our reading: the 43 `GROUP_ON_DEMAND` packs). Left: which files, **needs local game files** (`content.xml`, in DATA-NEEDS), and the time per step (a profiler) (leftovers pass, [measuring performance](/docs/performance/measuring.md#what-on_enter_mp-does-leftovers-pass)) |

### [Streaming, memory and video memory](/docs/performance/memory-and-vram.md) (R18.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-014 | How much each texture level costs on integrated graphics (working set and private) | [Graphics settings](/docs/performance/graphics-settings.md) test card 2 | Open |
| PERF-015 | How much a smaller mod set saves, measured the same way | Test card 1, R18.5 | Open |
| PERF-016 | How much of the 1,950 MB heap is used (HeapAdjuster only logs the size) | Needs a memory tool; second pass | Open |
| PERF-017 | Whether the game's in-menu video memory bar counts shared memory on integrated graphics | Test card 2 | Open |

### [Mod overhead: what each kind of mod costs](/docs/performance/mod-overhead.md) (R18.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-018 | Frame time per mod set at the same spot | Test card 1 | Open |
| PERF-019 | Load time added by the add-on packs (with `Mods\` off vs on) | Test card 2 | Open |
| PERF-020 | The per-frame cost of one idle SHVDN script | Test card 1 ([CPU](/docs/performance/cpu.md) open question) | Open |

### [Profiles for different PCs](/docs/performance/pc-profiles.md) (R18.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-021 | Measured FPS and hitches of the low-end profile vs typical settings on a low-end laptop | Test card 1 | Open |
| PERF-022 | Profile values that need the menu mapping | [Graphics settings](/docs/performance/graphics-settings.md) test card 1 | Open |

### [Physics cost: what the simulation spends, and how scripts keep it down](/docs/performance/physics-cost.md) (R2.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-023 | How many Euphoria ragdolls the engine runs at once before falling back, and what one costs on a low-end PC | Test card 1 | Open |
| PERF-024 | Cost of a vehicle crash, an explosion, a fire, on a low-end PC | Test cards 2 and 3 | Open |
| PERF-025 | Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels | R18.3, compare with the vanilla file | Partly answered: no other block changes the physics pools on PC; whether raising them matters is a test (test card 5 in [physics cost](/docs/performance/physics-cost.md#119-test-cards)) |

### [Windows and drivers](/docs/performance/windows-and-drivers.md) (R18.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PERF-026 | How much FPS and how many hitches closing background programs saves | Test card 1 | Open |
| PERF-027 | Whether "Best performance" power mode raises sustained clocks on a 15 W laptop | Test card 2 | Open |
| PERF-028 | Whether excluding the game folder from the antivirus shortens loading | Test card 3, R18.8 | Open |

## Scripting

### [Native namespace map](/scripting/native-namespace-map.md) (R0.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| SCR-001 | Split `MISC` into sub-families with their own owners (weather, cheats, area checks, game state) | Second pass | Answered: all 334 natives in 16 sub-families, each with an owner guide; bits and maths (24 natives, 1.07 million calls) and strings and hashes (12, 196,481) carry 92% of the calls (leftovers pass, [native namespace map](/scripting/native-namespace-map.md#misc-split-into-sub-families-leftovers-pass)) |
| SCR-002 | Which natives are reached only through shared helper code and never called in practice | R0.3 second pass: reachability from each script's entry point | Partly answered: Rockstar's compiler drops uncalled functions; in the 803 scripts with no indirect calls 359,076 of 359,210 functions are reachable and only 16 native-and-script pairs are dead. 54 natives appear only in code of the 342 `Call_Loc` scripts that no direct call reaches. Left: those 54, which **needs local game files** (a YSC reader for the pointer targets) **or the game** (a call logger) (leftovers pass, [native namespace map](/scripting/native-namespace-map.md#what-the-compiler-keeps-leftovers-pass)) |
| SCR-003 | Which namespaces' unused natives still work in story mode (useful to mods but not to Rockstar) | Per-topic second passes | Open |

### [Native usage: which scripts call which natives](/scripting/native-usage.md) (R0.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| SCR-004 | What `0x8F5D1AD832AEB06C` and `0x0F7082C60FB479EF` do (not in NativeDB) | [Inbox](/ROADMAP.md#inbox); read their call sites in `freemode` and `public_mission_creator` | Partly answered: `0x0F7082C60FB479EF` returns a float per model before the creator budget routine (our reading: budget cost), dropped in 3889; `0x8F5D1AD832AEB06C` left for the executable ([native usage](/scripting/native-usage.md)) |
| SCR-005 | Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` style check from a mod, or ScriptHookV's native table) | In-game test with a small C++ check | Partly answered: no 3725 script calls any of the 29; they are exactly the natives 3889's scripts add. Existence in the 3725 executable still needs the in-game check |
| SCR-006 | A story-only vs Online-only split of every native (which natives story mode never needs) | R0.8 namespace coverage map, using the script groups from R0.1 and the Online catalog | Answered: scripts sorted into story only (430), both modes (58: network-flagged catalog scripts and the shared framework) and Online (544); of 6,471 named natives, 1,845 appear only in Online scripts (story never needs them), 634 only in story-only scripts, 227 in story and both-mode scripts only, 3,765 in both (leftovers pass, [native usage](/scripting/native-usage.md#story-mode-and-online-which-natives-each-needs-leftovers-pass)) |
| SCR-007 | What the table order is (not first use; maybe first use in compiled code order) | Second pass, compare with a YSC dump | Open |

### [Natives as the engine API: kinds, contracts and costs](/scripting/natives-engine-api.md) (R1.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| SCR-008 | Measured cost of the heavy natives (synchronous shape test, `GET_CLOSEST_*`, load scenes) on a low-end PC | R18 performance topics, an in-game timing test | Open |
| SCR-009 | Which natives crash on a stale handle and which fail quietly | In-game tests, one family at a time | Open |
| SCR-010 | The size limits of the nearby-entity arrays | In-game test | Open |

### [The script VM: how GTA V runs its scripts, and how mods run beside them](/scripting/script-vm.md) (R1.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| SCR-011 | Meaning of force-cleanup bits 4, 16 and 32 (engine-raised) | R1.2 and R5.8 (replay), with an in-game test | Open |
| SCR-012 | What thread priority values change | R1.4 or R18.4 | Mostly answered (Known, NativeDB): values 0 highest, 1 normal, 2 lowest, 100 manual update. Only `freemode` (highest) and `fm_maintain_transition_players` (lowest) set one (**Verified**). Left: the engine's ordering within a priority ([script VM](/scripting/script-vm.md)) |
| SCR-013 | The event queue indexes and the script event layout | R15.1 | Answered: queues 0 (engine and AI events, 116 scripts), 1 (network and script events, 249 scripts) and 2 (errors, `error_listener` only). Script events are sent on queue 1 as arrays of 4-byte values: field 0 is the event id hash, field 1 the sender, then the payload; sizes run from 1 to 56 values (leftovers pass, [script VM](/scripting/script-vm.md)) |
| SCR-014 | Which of the duplicated pool entries in `gameconfig.xml` applies to the PC build | R1.4 | Answered: the base block's value; the update copy has no duplicate inside a block and no pools in its `x64` block; the duplicates are PS4, Xbox One, beta and non-final overrides (leftovers pass, [memory and pools](/docs/core/memory-and-pools.md#72-where-the-limits-come-from)) |

## File formats

### [Archive and data file atlas](/file-formats/data-file-atlas.md) (R0.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| FF-001 | Reliable sizes per type (audio sizes read as zero) | Second pass, read sizes from the resource headers | Answered: stored (uncompressed) entries have a compressed size of 0; sizes per type, 118.6 GB in all (leftovers pass, [atlas](/file-formats/data-file-atlas.md#sizes-per-type-leftovers-pass)) |
| FF-002 | A per-pack breakdown for all 89 DLC packs | Second pass, with [DLC packs](/docs/entities/vehicles/dlc-packs.md) | Answered: files, size and main types for all 89 packs; the 15 `g9ec` packs are near-empty on Legacy (leftovers pass, [atlas](/file-formats/data-file-atlas.md#the-89-dlc-packs-leftovers-pass)) |
| FF-003 | How the update's copies override the base ones, type by type | R1.6 second pass | Answered: 14,893 same-path replacements, 7,441 `dlc_patch` files, 1,672 same-name moves, 5,377 new, by type (leftovers pass, [atlas](/file-formats/data-file-atlas.md#how-the-update-overrides-the-base-leftovers-pass)) |

### [UGC mission files (JSON) and who reads them](/file-formats/ugc-json.md) (R7.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| FF-004 | Meaning of each content section key (`me`, `sro`, `amb`, `gt`, `ta`, `tot`, `mvdr` ...), from the `fm_content_*` helper that reads them | Second pass, with one `re_` file and its script | Mostly answered: the sub-keys of every section from `fm_content_bounty_targets`; `sro`, `cst`, `fcs`, `modt` still a *probable* reading (leftovers pass, [UGC JSON](/file-formats/ugc-json.md#113-content-files)) |
| FF-005 | The `gen` keys (8,472 paths): which ones `fm_mission_controller` actually reads | Second pass | Open |
| FF-006 | How the controller picks rules per team and stage | R7.5 (job lobby) and a second pass | Mostly answered: up to four teams, each with up to 17 rules (`endcon.nrl`, 67 per-rule keys); every enemy, vehicle, object and location has `rule<team>` (what to do) and `pri<team>` (which rule) per team; a rule's `nxtrulb` bitset branches to one of several next rules with a shared random seed, jumping forward or back. Left: the rule-type texts (**local game text files**) and the host's rule-complete test (leftovers pass, [UGC JSON 11.3.1](/file-formats/ugc-json.md#1131-rules-per-team-and-stage-leftovers-pass)) |

## Knowledge graph

Questions raised by the [graph report](/graphify-out/GRAPH_REPORT.md) after the 2026-11-03 refresh (2,408 nodes, 5,240 edges, 137 communities). They are about the docs themselves, not the game: where facts aren't tied together, and where the same fact lives in two places.

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| KG-001 | Tie in the 722 weakly connected nodes (one link or none; 4 fully isolated). The docs with the most: `docs/core/global-map.md` (27), `docs/ui/server-backed-screens.md` (19), `docs/00-getting-started/boot.md` (13), `docs/online/properties.md` (11), `docs/gameplay/economy/economy-and-pickups.md` (11), `docs/core/runtime-scripts.md` (9), `docs/00-getting-started/glossary.md` (9), `scripting/native-usage/WEAPON.md` (9). Typical cases are data files named once (`material_override_pairs.dat`, `procedural.meta`, the shape-test flags) with no link to the system that uses them | Each guide's next pass: add the missing cross-links, then re-run `/graphify . --update` and compare the count | Mostly answered: the graph of 2026-11-04 had 1,061 weakly connected nodes, mostly extraction artefacts rather than gaps in the docs. A capped pass fixed the real gaps: 8 data files named on a page that never linked the page explaining them (`combatbehaviour.meta`, `relationships.dat`, `americandlc.rpf`, `weaponarchetypes.meta`, `ambient_mp.ipl`, `carcols.meta`, `vehicleaihandlinginfo.meta`, `dlctext.meta`), and the 5 isolated nodes (2 dropped with KG-004, 3 re-extracted). Left: the remaining weak nodes, case by case, if a later graph shows real gaps (KG housekeeping pass, branch `docs/kg-housekeeping`) |
| KG-002 | Pick one owner page for each of the 72 facts that two docs describe separately (the graph links them as `semantically_similar_to` across files), and link to it from the other, so numbers can't drift. Examples: `flow_controller` (launch graph and runtime scripts), the 270-entry activity table (launch graph and job lobby; their counts agree, 266 scripts), the script brains (launch graph and strangers and freaks) | A docs pass over the 72 pairs listed by the graph | Answered: the refreshed graph listed 92 cross-page pairs among the guides; 53 were already linked one way, and of the 39 unlinked pairs, 20 describe the same fact twice. 16 new links in 14 guides tie them to the page that owns the fact (some links cover two or three pairs) (for example the force-cleanup bits in the glossary to [runtime scripts](/docs/core/runtime-scripts.md#every-force-cleanup-bit-second-pass), patrol routes in navigation to [script AI patterns 44.3](/docs/ai/script-ai-patterns.md#443-guards-and-patrols)). The rest are extraction similarities between different facts (KG housekeeping pass) |
| KG-003 | Should the loosest clusters be split or given clearer sections? Cohesion scores: "Repo Overview and Guides" 0.04, "Story Flow and Strangers" 0.05, "Performance and Measuring" 0.05, "Vehicle and World Physics" 0.05 (1.0 = every node linked to every other). Low cohesion here mostly comes from index pages that link to everything | Maintainer decision: split the hub pages, or accept them as indexes | Answered (maintainer decision, 2026-11-04): accept the loosest clusters as indexes. Their low cohesion (0.04 to 0.05: the handoff, runtime scripts, native namespace map, global map and mod map) comes from hub pages that link to everything; no page is split |
| KG-004 | Should non-doc files be left out of the graph? `.github/workflows/file-rules.yml` alone adds 14 weakly connected nodes, and the example mods add 19 external C# types with no source file (`Vector3`, `KeyEventArgs` ...) | Maintainer decision; if yes, add the paths to graphify's exclude list | Answered (maintainer decision, 2026-11-04): leave non-doc files out. `graphify-out/.graphify_build.json` excludes `.github/`, `*.cs`, `*.ps1`, `*.yml` and `*.yaml`, and their nodes (and the example mods' external C# types) were pruned from the graph. `examples/README.md` and `tools/README.md` stay in |

## Already answered

Rows that were still in a guide's table but are answered elsewhere. Remove them from the guide in the second pass.

- What the numbers in the story mission table mean (Boot and script control: from launch to control, and between story and Online): Answered in [core guide 2](/docs/gameplay/missions/story-flow.md#22-the-mission-table)

