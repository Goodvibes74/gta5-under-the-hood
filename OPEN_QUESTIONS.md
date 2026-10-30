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
| P1.6 | [Server-backed Online screens](/docs/ui/server-backed-screens.md) (R8.5): what `pausemenu_multiplayer` fills, the signed-out guards, leaderboard IDs | UI-005, UI-010, UI-012 | scripts | Done, [#112](https://github.com/Goodvibes74/gta5-under-the-hood/pull/112) and [#120](https://github.com/Goodvibes74/gta5-under-the-hood/pull/120) |
| P1.7 | Subtitles and phone-call lines (R5.6 with R8.6) | GP-008 | scripts | Done, [#113](https://github.com/Goodvibes74/gta5-under-the-hood/pull/113) |

Test only: UI-002 (draw lists and depths), UI-017 (which DLC text block wins a clash). UI-011 (transactions per business app) is answered with P3.8.

### Phase 2: the core engine

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P2.1 | [Boot](/docs/00-getting-started/boot.md) and [runtime scripts](/docs/core/runtime-scripts.md) (R1.2, R0.2): how `main`, `initial` and `startup` start, force-cleanup bits, `profiler_registration`, level index 5, the path to `prologue1` | CORE-017, CORE-018, CORE-019, GS-001, GS-002, ON-060 | scripts | Done for scripts, [#114](https://github.com/Goodvibes74/gta5-under-the-hood/pull/114) and [#120](https://github.com/Goodvibes74/gta5-under-the-hood/pull/120) (CORE-018's engine side needs the executable) |
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
| P3.2 | [The job lobby](/docs/online/job-lobby.md) (R7.5): launcher states, start arguments, corona settings, playlists, walk-in markers, job types | ON-030, ON-031, ON-032, ON-033, ON-034, ON-006 | scripts | Mostly done, branch `research/second-pass-phase3` (job types 4 and 31 unnamed); new ON-070, ON-071 |
| P3.3 | [Inside `freemode`](/docs/online/07-freemode.md) and [sessions](/docs/online/sessions-and-sync.md) (R7.1, R15.1): the event ids, the host's rotation, the running-state functions per system | ON-001, ON-002, ON-005, ON-051 | scripts | Partly done, branch `research/second-pass-phase3` (ON-051 answered, ON-005 mostly, ON-002 partly; ON-001 left) |
| P3.4 | [Transitions](/docs/online/transitions-and-sessions.md) (R7.2): the offline branch, character slots, the way back to story mode, the testbed session, what opens the creator | ON-004, ON-061, ON-062, ON-063, ON-064, GP-059 | scripts | Done, branch `research/second-pass-phase3`; new ON-074 |
| P3.5 | [Stats and tunables](/docs/online/stats-and-tunables.md) (R7.3): the tunable index, save categories, the shop basket, unnamed service readers | CORE-010, ON-047, ON-054, ON-055, ON-056, GP-058 | scripts | Done, branch `research/second-pass-phase3`; new ON-072, ON-073 |
| P3.6 | [The Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5): unlabelled morphs, slider scaling, outfit groups | GP-055, GP-056, GP-057 | scripts | Partly done, branch `research/second-pass-phase3` (GP-056 answered, GP-057 partly; GP-055 left) |
| P3.7 | [Properties](/docs/online/properties.md) (R7.6): yachts and vehicles as properties, garages, entrances, instances, daily fees | ON-041, ON-042, ON-043, ON-044, ON-045, ON-046 | scripts | Partly done, with ON-028 (ON-042 and ON-043 partly left, ON-065 mostly, ON-066 open), branch `research/second-pass-phase3` |
| P3.8 | [Organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7): production numbers, capacities, offline production, boss costs, challenges, business missions, transactions | ON-035, ON-036, ON-037, ON-038, ON-039, ON-040, ON-049, UI-011 | scripts | Open |
| P3.9 | [Heists](/docs/online/heists.md) (R7.8): fail bands, casino targets, Cayo loot, the classic planning board, elite rewards, story arcs, crew skill | ON-019, ON-020, ON-021, ON-022, ON-023, ON-024, ON-025, GP-019 | scripts | Open |
| P3.10 | [DLC storylines](/docs/online/dlc-storylines.md) (R7.9): stats per flow step, voice-only flows, arrival updates, missing flows, mp2025_02 | ON-014, ON-015, ON-016, ON-017, ON-018 | scripts, data | Open |
| P3.11 | [Creator internals](/docs/online/creator-internals.md) (R7.11): prop limits, hidden libraries, the two prop writers, checkpoint fields, other creators' placement | ON-007, ON-008, ON-010, ON-011, ON-012, ON-013 | scripts | Open |
| P3.12 | [Story systems in an Online mode](/docs/online/story-systems-in-online-mode.md) (R5.7): the shop table, ped brain sets | ON-057, ON-059 | scripts | Partly done, with R6.7 (ON-059 left) |

Test only: GP-054 (parent head counts), ON-058 (story clothes shop with a freemode ped; single player only). Engine only: ON-009 (creator budget), ON-052 (migration). Later: ON-048 (service natives in story scripts), ON-053 (a tunables list tool; needs the maintainer, as `tools/` does).

### Phase 4: story mode and offline play

| Batch | Topic | Questions | Kind | Status |
| --- | --- | --- | --- | --- |
| P4.1 | [Story flow](/docs/gameplay/missions/story-flow.md) (R5.1): the remaining command types, table fields, hidden missions, fails, the flow integers, the active triggerer | GP-028, GP-029, GP-030, GP-031, GP-032, CORE-020 | scripts | Open |
| P4.2 | [Mission anatomy](/docs/gameplay/missions/mission-anatomy.md) and [replay](/docs/gameplay/missions/replay-director-and-editor.md) (R5.2, R5.8): skip flags, replay states, lead-ins, replay event types, director mode areas | GP-016, GP-017, GP-021, GP-022, GP-024, GP-025, GP-026 | scripts | Open |
| P4.3 | [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md) (R5.5): medal thresholds, golf, activity unlocks, towing bonus | GP-010, GP-011, GP-012, GP-014 | scripts | Open |
| P4.4 | [Strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) (R5.4): unlock conditions, world points, brain flags | GP-034, GP-035, GP-036 | scripts, data | Open |
| P4.5 | [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (R5.6): the cutscene files and `dialogue_handler`'s globals | GP-005, GP-007 | scripts, data | Open |
| P4.6 | [Character switching](/docs/gameplay/player/character-switching.md) (R6.1): saved character state, the scene table | GP-037, GP-038 | scripts | Open |
| P4.7 | [Respawn](/docs/gameplay/player/respawn-death-and-arrest.md) and [health](/docs/gameplay/player/health-armour-death.md) (R6.2, R3.8): the building table, free respawns, hospital packs, armour items, DLC health configs | GP-060, GP-061, GP-063, GP-065, GP-066, GP-051, GP-052 | scripts, data | Open |
| P4.8 | [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) (R3.9): stock prices, pickup placement, shop robbery pay | GP-001, GP-002, GP-003 | scripts | Open |
| P4.9 | [Controls and camera](/docs/gameplay/player/controls-and-camera.md) (R6.4): control names, disable helpers, context numbers | GP-041, GP-042, GP-044 | scripts, data | Open |
| P4.10 | [Skills](/docs/gameplay/player/skills-and-abilities.md), [flying](/docs/gameplay/player/flying.md) and [weapons](/docs/gameplay/weapons/weapons.md) (R3.6, R3.4, R3.1): skill gains, ability types, starting skills, DLC flying blocks, flight lessons, AI flight missions, weapon unlocks, ammo caps | GP-067, GP-069, GP-070, GP-045, GP-046, GP-047, GP-048, GP-077, GP-078 | scripts, data | Open |

Test only (one evening's test card for the phase): GP-006 (cutscene flag bits), GP-039 (switch flags), GP-043 (two scripts disabling controls), GP-049, GP-050, GP-053 (regeneration, hurt thresholds, armour split), GP-062, GP-064 (arrest weapons, respawn point choice), GP-068 (shooting, strength, stealth), GP-071, GP-072, GP-075 (breath, drowning, swim speed). Engine: GP-023 (what NoEditorRestrictions patches). Elsewhere: GP-027 (R13.2), GP-073 (swimming stat entries), GP-074 (R2.3), GP-076 (a question for the install's owner), GP-079 (R2.5), GP-080 (R3.2).

## By category

| Category | Guides | Questions |
| --- | --- | --- |
| [Getting started](#getting-started) (`GS-`) | 1 | 3 |
| [Core engine](#core-engine) (`CORE-`) | 8 | 30 |
| [Entities](#entities) (`ENT-`) | 9 | 39 |
| [Physics](#physics) (`PHY-`) | 4 | 18 |
| [AI](#ai) (`AI-`) | 13 | 50 |
| [The world](#the-world) (`WLD-`) | 4 | 19 |
| [Gameplay](#gameplay) (`GP-`) | 17 | 86 |
| [GTA Online](#gta-online) (`ON-`) | 13 | 74 |
| [User interface](#user-interface) (`UI-`) | 6 | 19 |
| [Audio](#audio) (`AUD-`) | 3 | 11 |
| [Rendering](#rendering) (`REN-`) | 5 | 27 |
| [Performance](#performance) (`PERF-`) | 9 | 28 |
| [Scripting](#scripting) (`SCR-`) | 4 | 14 |
| [File formats](#file-formats) (`FF-`) | 2 | 6 |
| **Total** | | **424** |

## Getting started

### [Boot and script control: from launch to control, and between story and Online](/docs/00-getting-started/boot.md) (R1.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GS-001 | Which level index 5 is | R1.6 or R4.6 | Answered: the network testbed level; which folder it loads stays **Known** ([boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass)) |
| GS-002 | The exact path from a new game to `prologue1` | Answered: [boot 3.4.2](/docs/00-getting-started/boot.md#342-from-a-new-game-to-prologue1-second-pass) | Answered |
| GS-003 | Whether the return to story mode restarts every script (test card 2) | R7.2 | Open |

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
| CORE-009 | Field layout of the player broadcast data (`Global_1845250`, `Global_2658291`) | R7.1 second pass | Mostly answered: `.f_325` named, 16 parts of `.f_260` named from `mpstatscharactermappingdata.xml`, every bit of `.f_204`/`.f_203` grouped by who writes it ([global map 6.3](/docs/core/global-map.md#63-the-most-used-globals)); single-bit names left |
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
| CORE-017 | Meaning of force-cleanup bits 8, 16, 32, 64 and 128 | R1.1 | Answered (16 and 32 are raised by the engine, cause open): [runtime scripts 1.3](/docs/core/runtime-scripts.md#every-force-cleanup-bit-second-pass) |
| CORE-018 | What exactly the engine does to start `main`, `initial` and `startup`, and in which order | R1.2 | Partly answered: no script starts them, and the order follows from what each reads and waits for ([boot 3.3](/docs/00-getting-started/boot.md#33-inside-the-boot-scripts)); the engine call needs the executable |
| CORE-019 | What `profiler_registration` (global block 2) is and whether anything starts it | R0.4 | Answered: empty script, block 2 never used ([runtime scripts 1.5](/docs/core/runtime-scripts.md#15-global-blocks)) |
| CORE-020 | The story flags that pick the active mission triggerer | R5.1 | Open |
| CORE-021 | Resolve table-driven launches (second pass of the graph) | R0.5 | Mostly answered: 502 non-literal launches, 220 followed back, ten tables read; 240 scripts nothing starts ([launch graph](/scripting/script-launch-graph.md#launches-by-variable-and-by-table-second-pass)); `freemode`'s launches by request left |

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
| CORE-030 | Which natives changed between 3725 and 3889 | R11.1 second pass, with the native crossmap (R0.3) | Open |

## Entities

### [Props, archetypes and doors](/docs/entities/objects/props-and-doors.md) (R14.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-001 | Archetype flag bits counted across all `.ytyp` files | Second pass, with an XML export of the ytyps | Open |
| ENT-002 | Which map props are fragments (`.yft`) and how many break | Second pass with R4.6's model counts | Open |
| ENT-003 | Every rayfire object placed in the map, not only those named in scripts | Second pass, ymap entity extensions | Open |

### [Text and names in content](/docs/entities/objects/text-and-names.md) (R14.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-004 | The `NULL` fallback and the "CARNOTFOUND" return, confirmed in game | Test card 1 | Open |
| ENT-005 | Which 13 maker labels have no text and whether anything shows them | Second pass | Open |
| ENT-006 | How mod-part and livery labels are named and registered | R14.1 | Open |
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
| ENT-013 | The 23 personality hashes and relationship groups that didn't resolve | Second pass | Open |
| ENT-014 | What each `SET_PED_CONFIG_FLAG` number does (the ones Rockstar sets most) | Second pass: count flag numbers in the decompile | Open |
| ENT-015 | The component `.ymt` format (slots, drawables, restrictions) | R6.3, R14.2 second pass | Open |

### [Ped physics and ragdoll](/docs/entities/peds/ragdoll.md) (R2.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-016 | How many Euphoria ragdolls run at once before peds fall back to `CTaskRageRagdoll` | In-game test, [physics cost](/docs/performance/physics-cost.md) test card 1 | Open |
| ENT-017 | Which tuning set is chosen for which weapon and vehicle, and the 3 hashed set names | Second pass, weapon and vehicle data | Open |
| ENT-018 | Fall damage by height | R3.8 open question, in-game test | Open |
| ENT-019 | What `nm_blend_out_sets.meta` sets for getting up | Second pass | Open |
| ENT-020 | Where fall damage is set (not in the ragdoll files) *(from the guide's text)* | R3.8 | Open |

### [Population](/docs/entities/spawning/population.md) (R4.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-021 | The 5 story-mode schedule hashes that don't match a `popcycle.dat` name | Second pass | Open |
| ENT-022 | How the caps, `CityDensity` and the budgets combine into the real spawn count | Test card 1; R17.9 | Open |
| ENT-023 | What `scumminessLevel` changes in code and in scripts | Second pass: `GET_ZONE_SCUMMINESS` callers | Open |
| ENT-024 | The unnamed zone fields (`hash_7111AC8A`, three flags) | Second pass | Open |
| ENT-025 | How birds and fish groups spawn (they fill many slots) | R17.8 | Open |

### [Scenarios and ambient life](/docs/entities/spawning/scenarios.md) (R4.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-026 | The 44 scenario groups scripts toggle and what each controls | Second pass | Open |
| ENT-027 | How the time window and probability combine with the `#Scenario` cap | Test card 1; R17.8 | Open |
| ENT-028 | How many of the 111,898 points are Online-only | Second pass: the availability field | Open |
| ENT-029 | The chaining graph format and how vehicles follow it | R17.6 | Open |

### [Vehicle generators and traffic](/docs/entities/spawning/vehicle-generators-and-traffic.md) (R4.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-030 | What the car generator flag bits mean (3,680, 3,936 ...) | Second pass: compare generators in known places | Open |
| ENT-031 | Which DLC ymaps with generators load in story mode | R4.6 (map data), R4.5 (IPLs) | Open |
| ENT-032 | How the schedule caps, the budget and the `CityDensity` setting combine | R4.1, test card 1 | Open |
| ENT-033 | What the ten unused train tracks are and whether they work | Test card 3 | Open |
| ENT-034 | Where ambient planes, helicopters and boats on routes come from | R4.2 (vehicle scenarios) | Open |
| ENT-035 | Meaning of the bits in the vehicle generator flags field (3,680, 3,936, 3,616, 1,632), and the unresolved population group hash on 455 generators *(from the guide's text)* | Second pass | Open |

### [Vehicles](/docs/entities/vehicles/vehicles.md) (R14.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ENT-036 | The difference between the 901 models here and the 879 counted in R14.4 (how entries were split) | Second pass | Open |
| ENT-037 | The meaning of the less common flags | Second pass: compare models that set them | Open |
| ENT-038 | Light and siren setting id ranges used by DLC packs | Second pass | Open |
| ENT-039 | Which `carcols` mod parts each kit really links (the per-type counts include repeats) | Second pass | Open |

## Physics

### [Collision, materials and shape tests](/docs/physics/collision-and-materials.md) (R2.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-001 | The two unnamed columns (0.95 and 0.0 in every row) | R2.1 second pass | Open |
| PHY-002 | How many `.ybn` files the map has and how they are grouped | R4.1 (map) | Open |
| PHY-003 | The exact shape test flag bits, checked in game | R2.1 second pass | Open |
| PHY-004 | The ragdoll and `NATURAL_MOTION` materials | R2.3 | Open |
| PHY-005 | How water collision differs from water simulation | R2.4 | Open |

### [Fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) (R2.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-006 | The exact falloff curve between centre and edge, and how armour takes explosion damage | Test card 1; R3.1 | Open |
| PHY-007 | How far and how fast fire spreads, and its limits (number of fires at once) | Test card 2; R18 | Open |
| PHY-008 | The meaning of the unnamed boolean fields in `explosion.ymt` (their names didn't resolve) | Second pass | Open |
| PHY-009 | The DLC explosion types' numbers, damage and radius | Second pass: tabulate the 16 DLC files | Open |
| PHY-010 | The full list of DLC projectiles and their explosions | R3.1 second pass | Open |

### [Vehicle physics: handling, damage and upgrades](/docs/physics/vehicle-handling.md) (R2.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-011 | Bit names for the model, handling, damage and advanced flags, checked one by one in game | R2.2 second pass | Open |
| PHY-012 | How the engine turns `fInitialDriveMaxFlatVel` and the drive force into the real top speed | R2.2 second pass, in-game measurement | Open |
| PHY-013 | What exactly each `statMods` modifier changes (percent of what) | R2.2 second pass | Open |
| PHY-014 | How `vehicles.meta` fields (`handlingId`, wheel scale, `flags`) interact with handling | R14.1 | Open |

### [Water and buoyancy](/docs/physics/water-and-buoyancy.md) (R2.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| PHY-015 | What the 5 water quad types mean | Second pass: compare where each type is | Open |
| PHY-016 | The format of `waterheight.dat` | Second pass | Open |
| PHY-017 | How wave quads differ from calming quads in effect | In-game test | Open |
| PHY-018 | Where swimming pools are defined | R4.6 second pass | Open |

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
| AI-006 | What the second `CTask` pool (2,100) is for | Second pass with R1.4 | Open |

### [Ambient life](/docs/ai/ambient-life.md) (R17.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-007 | How far from the player ambient peds despawn | R17.9, in-game test | Open |
| AI-008 | How peds pick partners for chats | Second pass | Open |
| AI-009 | The animal models by kind and where each spawns | Second pass with R4.2's scenario types | Open |

### [Combat and AI (first pass)](/docs/ai/combat-and-perception.md) (R3.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-010 | Names of the common combat attributes (50, 17, 53, 52, 46) and config flags (427, 36, 398, 34), checked in game | R3.2 second pass | Open |
| AI-011 | Decode `pedpersonality.ymt` (binary PSO): personalities, bravery, driving ability | R17.3 | Open |
| AI-012 | Cover: how cover points are found and scored, `TASK_SEEK_COVER_*` | R17 | Open |
| AI-013 | How aim assist and lock-on work for the player | R3.2 second pass | Open |
| AI-014 | The full meaning of `taskdata.meta` and `scriptedguntasks.meta` | R17.1 | Open |
| AI-015 | Whether the modded `events.meta` really drops gunfight reactions, in game | Test card | Open |
| AI-016 | Decode `pedpersonality.ymt` (binary PSO; not decoded in the first pass) *(from the guide's text)* | R17.3 | Open |

### [Decisions and personalities](/docs/ai/decisions-and-personalities.md) (R17.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-017 | The names of the 5 unnamed civilian bravery types and the criminality types | Second pass with more name sources | Open |
| AI-018 | What `IsWeird` changes for Trevor | In-game test; second pass | Open |
| AI-019 | How motivation (`MotivationMin/Max`) is used | Second pass | Open |
| AI-020 | How the driving ranges map onto the driving tasks (R3.3, R17.6) | R3.3 | Open |

### [Driving AI: missions, chases, aircraft and boats](/docs/ai/driving-ai.md) (R17.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-021 | The name of each temp action number, checked in game | In-game test, one action at a time | Open |
| AI-022 | How the flee mission picks a route | R17.5 second pass | Open |
| AI-023 | Mission numbers passed in variables (about a quarter of the calls) | Second pass, follow the variables | Open |

### [Driving and AI driving](/docs/ai/driving.md) (R3.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-024 | AI profiles of every DLC vehicle (all `handling.meta` files) | Second pass, with the DLC scan | Open |
| AI-025 | How `SET_DRIVER_ABILITY` and `_AGGRESSIVENESS` change the curve or braking | In-game test | Open |
| AI-026 | What `TASK_VEHICLE_TEMP_ACTION`'s action numbers mean, with Rockstar's counts | Second pass | Open |
| AI-027 | Road nodes and how routes are planned | R17.5 (navigation) | Open |

### [Navigation and pathfinding](/docs/ai/navigation.md) (R17.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-028 | Polygon, link and cover-point counts per tile | Second pass, a `.ynv` reader | Open |
| AI-029 | Node and link counts in the `.ynd` files, and what the update changed | Second pass | Open |
| AI-030 | How far around the player navmeshes stream by default | In-game test with `GET_NUM_NAVMESHES_EXISTING_IN_AREA` | Open |

### [Perception and events](/docs/ai/perception-and-events.md) (R17.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-031 | The three other unnamed shocking events | Second pass, more name guesses | Open |
| AI-032 | Which `SET_PED_CONFIG_FLAG` numbers scripts set most, and what they do | Second pass, R17.10 | Open |
| AI-033 | How decision makers map each event to a response | R17.3 second pass | Open |

### [Police and service AI](/docs/ai/police-and-services.md) (R17.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-034 | The names and values of the 9 crime-info entries | R3.7 | Open |
| AI-035 | How crime points are added per crime | R3.7 | Open |
| AI-036 | The full vehicle sets with model names | Second pass, `dispatch.meta` | Open |

### [Relationships and groups](/docs/ai/relationships-and-groups.md) (R17.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-037 | The exact follower limit and what happens to the eighth | Test card 2 | Open |
| AI-038 | Which mission groups persist between missions (global groups registered at boot) | Second pass: `standard_global_init` | Open |
| AI-039 | How dislike (4) differs from hate (5) in behaviour | In-game test | Open |
| AI-040 | How the wanted level overrides the `COP`–`PLAYER` relationship | R3.7 | Open |

### [How Rockstar's scripts drive AI](/docs/ai/script-ai-patterns.md) (R17.10)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-041 | Where story missions keep enemy spawn tables (positions, triggers) and how many enemies a big shootout has alive at once | Next pass: `rural_bank_heist`, `finale_heist2b` | Open |
| AI-042 | What hackers' and drivers' stats do in each heist | Next pass: the heist scripts | Open |
| AI-043 | When the crew stat raise is called (every survived heist, or only some) | Next pass | Open |
| AI-044 | The `TASK_COMBAT_PED` flag values (16, 67108864, 201326592) | In-game test | Open |
| AI-045 | How `fm_content_*` scripts set up patrols from content data | R7.7, R7.9 | Open |
| AI-046 | Buddy behaviour in vehicles (driver choice, drive-bys) | With [R17.6](/docs/ai/driving-ai.md) | Open |

### [Wanted level and police](/docs/ai/wanted-level-and-police.md) (R3.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AI-047 | Crime points added per crime (set in the engine) | In-game test: commit one crime with a multiplier of 1 and read the result | Open |
| AI-048 | Names for the crime numbers 13, 36, 37 and 28 | Second pass with NativeDB's crime list | Open |
| AI-049 | How the difficulty value changes police behaviour, measured | In-game test | Open |
| AI-050 | Confirm the crime numbers passed literally to `REPORT_CRIME` (37, 36, 13) and `SUPPRESS_CRIME_THIS_FRAME` (28 and others); the names come from NativeDB's crime list *(from the guide's text)* | Second pass | Open |

## The world

### [Interiors and IPLs](/docs/world/interiors-and-ipls.md) (R4.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-001 | A list of IPL names with the interior or building each one controls | Second pass: match IPL names to the ymaps they load | Open |
| WLD-002 | What `building_controller` swaps, building by building | Second pass | Open |
| WLD-003 | Which Online interiors work offline with IPLs alone | Test card 2; second pass | Open |

### [Map data](/docs/world/map-data.md) (R4.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-004 | The exact meaning of the ymap `flags` values 1, 2, 3 | Second pass: compare with the IPL names scripts request | Open |
| WLD-005 | How many entities the story-mode map loads (only ymaps active outside Online) | Second pass: filter by IPL state | Open |
| WLD-006 | How `re_lossantosintl` and `re_yetarian` enforce their areas | Second pass | Open |
| WLD-007 | How the LOD manifests (`.ymf`) tie ymaps together | R4.5, second pass | Open |

### [Random events](/docs/world/random-events.md) (R4.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-008 | The event index of each script, and the full character and time rules per event | Second pass: the index each script passes to the check | Open |
| WLD-009 | How long each event's cooldown is | Second pass: read where each script writes its next allowed time | Open |
| WLD-010 | How `re_armybase`, `re_prison`, `re_lossantosintl` and `re_yetarian` are started | Second pass: [launch graph](/scripting/script-launch-graph.md) | Open |
| WLD-011 | When each event is unlocked (story progress) | R5.1 second pass | Open |
| WLD-012 | The world brain activation range and how the engine picks between nearby points | Test card 2 | Open |

### [Time, weather and wind](/docs/world/time-and-weather.md) (R2.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| WLD-013 | How long one `TimeMult` unit lasts, and whether the cycle position is tied to the game clock or to real time (story vs Online) | Test card 1; second pass | Open |
| WLD-014 | Whether wind changes the flight of aircraft, the drift of boats, or bullets | Test card 3; R2.2, R2.4 | Open |
| WLD-015 | What the global flag that skips the post-death weather reroll is, and which scripts set it | Second pass: read the writers of that global in `respawn_controller`'s callers | Open |
| WLD-016 | How `SET_OVERRIDE_WEATHER` and the persistent lock interact when both are set | In-game test | Open |
| WLD-017 | What the 380 timecycle variables per region do, and how timecycle modifiers stack on the weather | R13.2 | Open |
| WLD-018 | The base length of one weather `TimeMult` unit (not in the file) *(from the guide's text)* | In-game test | Open |
| WLD-019 | Whether wind pushes aircraft or boats *(from the guide's text)* | In-game test | Open |

## Gameplay

### [Economy and pickups](/docs/gameplay/economy/economy-and-pickups.md) (R3.9)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-001 | How `stock_controller` moves prices and which story events move which company | Second pass | Open |
| GP-002 | Where `pickup_controller` places each pickup and when they respawn | Second pass: its coordinate tables | Open |
| GP-003 | How shop robberies pay out (the till amounts) | Second pass: `shoprobberies` | Open |
| GP-004 | The full list of `SPx_MONEY_SPENT_*` categories | R1.7 | Answered: 10 categories plus the total, and a second shop family `SPx_SP_MONEY_SPENT_*` ([economy](/docs/gameplay/economy/economy-and-pickups.md#where-story-money-is-booked-second-pass)) |

### [Cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (R5.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-005 | How many cutscene files ship (`.cut` in the `x64` archives and DLC packs) and how they are organised | R0.7 atlas, R13.4 animation | Open |
| GP-006 | Exact meanings of the `START_CUTSCENE` and `REGISTER_ENTITY_FOR_CUTSCENE` flag bits | Second pass, in-game tests | Open |
| GP-007 | The layout of `dialogue_handler`'s request globals (speakers, root, block, flags) | R0.4 global map | Partly answered: flags, block, root and priority ([cutscenes and dialogue 6.5](/docs/gameplay/missions/cutscenes-and-dialogue.md#subtitles-and-phone-calls-second-pass)); the rest of the conversation block is R0.4 |
| GP-008 | How subtitles are hidden or shown (frontend setting) and how phone calls differ from face-to-face lines | Second pass | Answered: [cutscenes and dialogue 6.5](/docs/gameplay/missions/cutscenes-and-dialogue.md#subtitles-and-phone-calls-second-pass) |

### [Minigames and activities](/docs/gameplay/missions/minigames-and-activities.md) (R5.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-009 | Who starts `minigame_stats_tracker` and `minigame_ending_stinger` (not started by name in this build) | Next pass: search by hash | Answered: neither is named anywhere, by string or hash ([minigames 42.5](/docs/gameplay/missions/minigames-and-activities.md#425-scoring)) |
| GP-010 | The flight-school, range and triathlon medal thresholds | Next pass: read each script's goal tables | Open |
| GP-011 | Golf: course data, AI foursome behaviour, how the score is kept | Next pass | Open |
| GP-012 | How the flow unlocks each activity (blips appear after story missions) | Next pass, with [story flow](/docs/gameplay/missions/story-flow.md) | Open |
| GP-013 | The sea-race labels (`SNCA`, `SSC`, `SCAA`, `SCAB`) and street-race labels in English | Text files ([R8.3](/ROADMAP.md)) | Answered: [minigames 42.2](/docs/gameplay/missions/minigames-and-activities.md#422-the-activity-list) |
| GP-014 | The towing quick-bonus check (what the 12 s timer measures) | Next pass | Open |
| GP-015 | What starts `minigame_stats_tracker`'s medal result screen (`mission_complete` Scaleform, `SET_MEDAL`); no script starts it by name *(from the guide's text)* | Second pass | Answered: nothing starts it in this build ([minigames 42.5](/docs/gameplay/missions/minigames-and-activities.md#425-scoring)) |

### [Anatomy of a story mission](/docs/gameplay/missions/mission-anatomy.md) (R5.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-016 | Where `armenian1`, `jewelry_heist` and `trevor1` set the skip flag (`Global_96580`), since they don't do it in their own code | Next pass of R5.2 or R5.8 | Open |
| GP-017 | The exact meaning of `replay_controller` states 1 to 6 and 11 to 13 | R5.8 | Open |
| GP-018 | How the snapshot in `Global_108447` is restored on retry, and what it leaves out | R5.3 | Answered: clock, weather, cash, weapons, outfits, tattoos, special ability, texts and the player ped are restored; other stats and the world aren't ([mission anatomy 3.6](/docs/gameplay/missions/mission-anatomy.md#36-checkpoints-retry-and-skip)) |
| GP-019 | How crew skill changes the heist take and the fail labels in `Local_3373` | R7.8 (heists) | Open |
| GP-020 | How `mission_repeat_controller` replays a mission without moving the flow (from guide 2) | R5.3 | Answered: the flow-started flag is cleared and the game is saved and reloaded around the replay ([mission anatomy 3.9](/docs/gameplay/missions/mission-anatomy.md#39-passing)) |
| GP-021 | What the mission triggerers build before a mission starts (lead-in scenes, from guide 2) | R5.2 second pass | Open |
| GP-022 | Where `armenian1`, `jewelry_heist` and `trevor1` unlock their skip (they honour `Global_96581` but don't set `Global_96580` themselves) *(from the guide's text)* | Second pass | Open |

### [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) (R5.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-023 | What exactly NoEditorRestrictions patches, and the vanilla limits it lifts (free camera distance, restricted areas) | Second pass with the executable; test card 3 | Open |
| GP-024 | The meaning of `replay_controller` states 1 to 6 and 11 to 13 | Second pass (also open in mission anatomy) | Open |
| GP-025 | The `REPLAY_START_EVENT` and `REPLAY_RECORD_BACK_FOR_TIME` type numbers | Second pass | Open |
| GP-026 | Where director mode's restricted places (the prison and others) are defined | Second pass: the area checks in `director_mode` | Open |
| GP-027 | The 10 post effects `startup` registers for the editor | R13.2 second pass | Open |

### [The story mission flow: how missions unlock](/docs/gameplay/missions/story-flow.md) (R5.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-028 | The remaining 40-odd command types (blips, contacts, texts, unlocks, savehouses, character state) | Next pass of R5.1 | Open |
| GP-029 | The meaning of mission-table field 12 above bit 4, and of the option flags in field 15 | Next pass of R5.1 | Open |
| GP-030 | How `agency_heist2` and Blitz prep 3 are reached | R5.2 | Open |
| GP-031 | The pass and fail labels of each mission command: what happens on a fail | R5.2 (the mission side is in [guide 3](/docs/gameplay/missions/mission-anatomy.md#37-failing); the flow side is still open) | Partly answered |
| GP-032 | What the flow integers (`f_99.f_58`) hold; index 120 is read 1,434 times | R5.1, R5.3 | Open |
| GP-033 | How `mission_repeat_controller` replays a mission without moving the flow | R5.2 | Answered with GP-020 ([mission anatomy 3.9](/docs/gameplay/missions/mission-anatomy.md#39-passing)) |

### [Strangers, freaks and side content](/docs/gameplay/missions/strangers-and-freaks.md) (R5.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-034 | The unlock condition of each entry (flow flags, character) from the remaining table fields | Second pass | Open |
| GP-035 | Where the world points are placed and how many there are per brain | Map data, R4.6 second pass | Open |
| GP-036 | What the object-brain percentage and flags mean | Second pass, in-game test | Open |

### [Character switching](/docs/gameplay/player/character-switching.md) (R6.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-037 | What each character's saved state holds (position, outfit, weapons, vehicle, money) and where in the story save | Second pass, with R1.7 saves and the [global map](/docs/core/global-map.md) | Open |
| GP-038 | The 42-entry scene table's conditions (time, place, mission state) | Second pass | Open |
| GP-039 | The meaning of switch flag bits 1, 2, 4, 8 | NativeDB notes plus a test card | Open |
| GP-040 | Who starts the `family_scene_*` scripts | R0.5 second pass (launch graph) | Answered: `main`, within 100 m of five house points ([launch graph](/scripting/script-launch-graph.md#launches-by-variable-and-by-table-second-pass)) |

### [Controls and camera](/docs/gameplay/player/controls-and-camera.md) (R6.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-041 | The names of controls 365 to 401 | Second pass: the game's own control list (`controls.xml`, settings menu text) | Open |
| GP-042 | Which shared helpers produce the near-identical disable counts, and what each blocks | Second pass | Open |
| GP-043 | How `SET_INPUT_EXCLUSIVE` and `DISABLE_CONTROL_ACTION` interact when two scripts disagree | In-game test | Open |
| GP-044 | The context and mode numbers, read from the scripts' own constants | Second pass | Open |

### [Flying](/docs/gameplay/player/flying.md) (R3.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-045 | Flying blocks of all DLC aircraft | Second pass with every DLC `handling.meta` | Open |
| GP-046 | What `SPMED` and `SPSMALL` are | Second pass, `vehicles.meta` | Open |
| GP-047 | The 12 lessons by name, their aircraft and targets | Second pass, `pilot_school` | Open |
| GP-048 | The mission type numbers used with `TASK_HELI_MISSION` and `TASK_PLANE_MISSION`, with counts | Second pass | Open |

### [Health, armour, death and arrest](/docs/gameplay/player/health-armour-death.md) (R3.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-049 | The player's regeneration rate, delay and cap in numbers | Test card 2 | Open |
| GP-050 | What exactly changes below the fatigued and hurt thresholds | In-game test | Open |
| GP-051 | The 5 armour item percentages, read from the shop's data | Second pass: `gunclub_shop` item table | Open |
| GP-052 | Which personalities each DLC pack adds and their health configs | Second pass with [`tools/dlc-scan.ps1`](/tools/README.md) | Open |
| GP-053 | How armour splits damage between armour and health for each damage type | R3.1 second pass, in-game test | Open |

### [The Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-054 | How many normal and special parent heads each list has, and which characters the special ones are | In-game test: `GET_PED_HEAD_BLEND_NUM_HEADS` and `GET_PED_HEAD_BLEND_FIRST_INDEX` per type | Open |
| GP-055 | The two unlabelled morph-19 entries and the last column of the appearance table (which sex or body type each row is for) | Next pass, the item-table caller | Open |
| GP-056 | How the slider values (0 to 100, -1 to 1) are scaled into the saved `FEATURE_n` and `HEADBLEND_*` floats, and which `FEATURE_n` is which morph | Next pass, the save function and the stat enum mapping | Answered: `FEATURE_n` is micro morph n, saved as min + (max - min) x slider / 100; heritage saved from `GET_PED_HEAD_BLEND_DATA` ([character creator](/docs/gameplay/player/online-character-creator.md#what-is-saved)) |
| GP-057 | The outfit group names (`BEA`, `CAS` ...) and the components of each starter outfit | Next pass, the outfit tables | Partly answered: no group labels exist in the text, only per-outfit labels; components left ([character creator](/docs/gameplay/player/online-character-creator.md#open-questions)) |
| GP-058 | The appearance fee and cooldown values | R7.3 tunables, `freemode` | Answered: `character_appearance_charge` $100,000, cooldown 48 minutes, cap 30 in 24 hours ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| GP-059 | Which transition state opens the creator, and what menu `-1392473901` is (used 3 times, probably the character select) | R7.2 (transitions) | Answered: `-1392473901` is `FE_MENU_VERSION_TEXT_SELECTION`, the "LOBBY LIST" screen ([pause menu 23.5](/docs/ui/pause-menu.md#235-the-full-tree-menu-versions-tabs-and-panes)); the creator opens through state 32 when the transition's destination is 2 ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |

### [Online cosmetics and the shops that sell them](/docs/gameplay/player/online-cosmetic-shops.md) (R6.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-081 | What each restriction tag blocks or forces, as a table (hat with hood, glasses with masks ...) | Next pass, the tag checks in `shop_controller` | Open |
| GP-082 | The full `locate` number to menu title map, and why a few menus appear only in some store layouts | Next pass, `clothes_shop_mp` menu builder | Open |
| GP-083 | The base-wardrobe tables (labels and prices of the non-DLC clothes) | Next pass | Open |
| GP-084 | Which barber items need a rank, and the ranks | Next pass, the unlock checks behind `HAIR_UNLOCK` | Open |
| GP-085 | The hair and make-up colour counts on this build | In-game test, `GET_NUM_PED_HAIR_TINTS` / `GET_NUM_PED_MAKEUP_TINTS` | Open |
| GP-086 | Which hair fade goes with which hairstyle (the barber adds one when a style is bought) | Next pass, the hairstyle-to-list-slot mapping in `hairdo_shop_mp` | Open |

### [Respawn, death and arrest](/docs/gameplay/player/respawn-death-and-arrest.md) (R6.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-060 | What the "building" table tied to each restart point drives | Second pass | Open |
| GP-061 | Which respawn states (global values 7 and 9) and money categories (3 and 4) skip the charges | Second pass: trace the writers of those globals | Open |
| GP-062 | Exactly which weapons survive an arrest | Test card 2 | Open |
| GP-063 | Which of the 10 hospital damage packs is chosen when | Second pass: read the selector in `respawn_controller` | Open |
| GP-064 | Whether the engine picks the nearest enabled point or uses other rules (wanted level, water, the exile) | Test card 3 | Open |
| GP-065 | What the "building" table that `standard_global_init` fills next to each hospital and police station drives (blips, doors, state) *(from the guide's text)* | Second pass | Open |
| GP-066 | The two respawn states (7 and 9) that skip the death charge, and money categories 3 and 4 that skip both charges *(from the guide's text)* | Second pass | Open |

### [Player skills and abilities](/docs/gameplay/player/skills-and-abilities.md) (R3.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-067 | How much each activity raises each skill (the `stats_controller` rules) | Second pass: read `stats_controller` | Open |
| GP-068 | What shooting, strength and stealth change, in numbers | In-game tests | Open |
| GP-069 | Which ability type each entry 3 to 16 is | Second pass with the ability type list | Open |
| GP-070 | The starting skill values of each character in a new game | Second pass: `initial` / `flow_controller` | Open |

### [Swimming and diving](/docs/gameplay/player/swimming-and-diving.md) (R3.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-071 | The exact curve from the lung capacity stat to seconds of breath (`DiveRampPow` may be part of it) | Test card 1; R3.6 | Open |
| GP-072 | How fast drowning drains health | Test card 2 | Open |
| GP-073 | What the 5 non-story entries in `PlayerStatInfos` are (their names didn't resolve) | Second pass | Open |
| GP-074 | How the fall heights combine with ragdoll and fall damage | R2.3 | Open |
| GP-075 | Swim speed from the stamina and lung stats | R3.6 | Open |

### [Weapons](/docs/gameplay/weapons/weapons.md) (R3.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| GP-076 | Which mod installed the weapon overhaul (and the other 93 replaced files) | Ask the user; R10.1 | Open |
| GP-077 | The hatchet's extra condition, and whether the Gusenberg really waits for `finale_credits` | R3.1 second pass | Open |
| GP-078 | How story stats and Online rank change `AmmoMax` | R3.6 | Open |
| GP-079 | Explosion damage and radius per explosive (`explosion.meta`) | R2.5: [fire, explosions and projectiles](/docs/physics/fire-explosions-projectiles.md) | Open |
| GP-080 | How aim assist and lock-on work for the player versus AI | R3.2 | Open |

## GTA Online

### [Inside `freemode` (first pass)](/docs/online/07-freemode.md) (R7.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-001 | What each of the 183 running-state functions does in detail (this pass labels them from strings only) | R7.1 second pass, per system | Open |
| ON-002 | Names of the 60 network event ids and the main script event hashes | R7.2, R15 | Partly answered: network events described by behaviour ([R7.1 7.6.1](/docs/online/07-freemode.md#761-the-60-network-event-types-second-pass)); no names exist in the scripts for the event types or the 381 script-event hashes |
| ON-003 | The fields of the player and server broadcast data | R0.4 global map | Answered at block level: every player and server broadcast block named and sized, busiest server fields typed ([global map 6.3.1](/docs/core/global-map.md#631-every-broadcast-block-by-its-registered-name-third-pass)) |
| ON-004 | What `freemode_clearGlobals` resets and when | R7.2 | Answered: 31 steps that reset Online global blocks to defaults, started once by `freemode` at start ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-005 | How the host's rotation through participants works | R7.1 second pass | Mostly answered: 47 per-system counters, each visiting one of the 32 player slots per frame and wrapping to 0; the host-state counter itself not pinned ([R7.1 open questions](/docs/online/07-freemode.md)) |

### [Rockstar Creator internals: how tracks and maps are built from props](/docs/online/creator-internals.md) (R7.11)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-006 | What job types 4 and 31 are, and what the even and odd race subtypes of a pair mean | Next pass, with the [job lobby](/ROADMAP.md) (R7.5) | Mostly answered: odd race subtypes are one-lap (point-to-point) races; types 4 and 31 are handled with missions and Survival but stay unnamed ([R7.11 12.3](/docs/online/creator-internals.md#123-from-the-menu-to-a-creator)) |
| ON-007 | The prop limit in `public_mission_creator`, which uses its own messages (`PMCE_F_P`, `PMCE_F_D`) | Second pass | Open |
| ON-008 | The second dynamic list (library 15), library 39 and the other libraries with no text: hidden, Rockstar-only, or text in a pack not read | Second pass, with every DLC text block | Open |
| ON-009 | What `GET_USED_CREATOR_BUDGET` measures inside the engine | Reverse engineering, R1.5 (streaming) | Open |
| ON-010 | Which jobs are saved by the full prop writer and which by the sparse one (`func_189`) | Second pass, compare with the 16 local classic missions ([R7.4](/file-formats/ugc-json.md)) | Open |
| ON-011 | Meaning of `chs`, `chs2`, `chpp` and the `cpbs1` to `cpbs3` bits | Second pass, read the race controller's checkpoint code | Open |
| ON-012 | How the deathmatch and mission controllers create dynamic props (the race is in 12.11) | Next pass | Open |
| ON-013 | The other creators' own placement (spawn points, enemy waves, capture objects) | Second pass per creator | Open |

### [DLC storylines in GTA Online](/docs/online/dlc-storylines.md) (R7.9)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-014 | Which stats each flow keys on, step by step | Next pass, per flow function in `freemode` | Open |
| ON-015 | The text of the voice-only flows (`XM4V_FLW`, `S25R_FLW`, `SR2CH_FLW` ...) | Dialogue files, R9.2 second pass | Open |
| ON-016 | Which update each `fm_content_*` script arrived in (compare decompile commits by build) | Next pass, `git log` of the decompile | Open |
| ON-017 | The flows for After Hours, Doomsday and the 2015 heists (no flow label family found) | Next pass | Open |
| ON-018 | The mp2025_02 update's name and story | Next pass, its pack text | Open |

### [Heists in GTA Online](/docs/online/heists.md) (R7.8)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-019 | The units of the failure time bands (minutes of play, *probable*) | Next pass, the mission controller | Open |
| ON-020 | The casino target index order (gold or artwork at index 1) | Next pass: the target name function | Open |
| ON-021 | Cayo secondary loot values (cash, weed, coke, gold, paintings) and bag capacity | Next pass: hashed tunables near the primary values | Open |
| ON-022 | How the classic apartment board is drawn and which script owns it | Next pass, `freemode` | Open |
| ON-023 | Elite challenge rewards for each heist | Next pass | Open |
| ON-024 | The heist story arcs and their contacts | [R7.9](/ROADMAP.md) | Open |
| ON-025 | Which script draws the apartment heist planning board for the classic heists *(from the guide's text)* | Second pass | Open |

### [Interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-026 | The story-mode slot list (which apps each character has) | Second pass, `cellphone_controller` by character | Answered: one story list for all three characters, and the Online list ([R7.10 21.2.1](/docs/online/interaction-menu-phone-apps.md#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass)) |
| ON-027 | The full interaction-menu tree and its conditions | Second pass, `am_pi_menu` | Answered: the top page with each item's conditions and all 144 pages by area ([R7.10 21.3.1](/docs/online/interaction-menu-phone-apps.md#2131-the-menu-tree-second-pass)); per-page conditions stay in each page's function |
| ON-028 | Every website page and what each sells | Second pass, `appinternet` | Answered: the eight selling sites with their numbers and stock counts, and the 683-item model list ([R7.10 21.5](/docs/online/interaction-menu-phone-apps.md#215-the-internet)) |
| ON-029 | The Facade phone's movie and the character-to-phone mapping | Second pass | Answered: `cellphone_facade` is Trevor's; the four-entry phone table ([R7.10 21.2.1](/docs/online/interaction-menu-phone-apps.md#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass)) |
| ON-067 | Who sets the story phone's Sniper-app flag, and what the two Online flags are that switch the phone to the Badger skin and empty slot 24 | Third pass, `cellphone_controller` callers | Open |
| ON-068 | What website items 323, 324, 357 and 402 are (hashes set at start that match no model name) | Third pass, the preview code in `appinternet` | Open |
| ON-069 | Each interaction-menu page's own show and grey conditions (the top page is mapped) | Third pass, `am_pi_menu` page by page | Open |

### [The job lobby (`fmmc_launcher`)](/docs/online/job-lobby.md) (R7.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-030 | The exact role of states 7 and 10, and which idle exits go to 4, 8 and 9 | Next pass, follow `func_13037`'s conditions | Answered: state 7 starts the impromptu deathmatch, state 10 is the next playlist job; every idle exit with the flag and script that raises it ([R7.5 13.3](/docs/online/job-lobby.md#133-the-11-top-level-states)) |
| ON-031 | The meaning of each of the 21 start-argument values | Next pass, read a controller's entry function | Answered: the launcher sets only the network instance (`.f_16`) and one job value (`.f_2`) ([R7.5 13.5](/docs/online/job-lobby.md#135-from-job-type-to-running-controller)) |
| ON-032 | How the corona's settings are stored and sent to the controller | Next pass, with `Global_2685150` | Answered: host's choices in `GPBD_FM_2`, copied to the lobby state's `.f_669`; races also use `GlobalServerBD_Races` ([R7.5 13.5](/docs/online/job-lobby.md#135-from-job-type-to-running-controller)) |
| ON-033 | How playlists and series step from job to job (`FMMC_PlayList_Controller`) | Next pass | Answered: each playlist job is a new session; the playlist hands the next content id to the launcher ([R7.5 13.7.1](/docs/online/job-lobby.md#1371-playlists-and-walk-in-markers-second-pass)) |
| ON-034 | How a walk-in job marker in freemode hands over to the launcher | R7.1 second pass (`freemode`) | Answered: the walk-in conditions and the launcher flag `freemode` raises ([R7.5 13.7.1](/docs/online/job-lobby.md#1371-playlists-and-walk-in-markers-second-pass)) |
| ON-070 | What the job value in start argument `.f_2` is, and what lobby flag bit 1 and `.f_880` are raised for | Third pass, the `freemode` and `maintransition` writers | Open |
| ON-071 | What the playlist's `.f_877` position is and how the launcher uses it | Third pass, `fmmc_launcher` state 10 | Open |

### [Organisations and businesses](/docs/online/organisations-and-businesses.md) (R7.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-035 | The nightclub's production and popularity numbers (their tunable names are hashed) | Next pass: match hashes to names from the scripts | Open |
| ON-036 | Special cargo warehouse capacities (16, 42 and 111 crates are **Known**) and where the scripts keep them | Next pass | Open |
| ON-037 | How production is stored in stats and advanced while offline or in another session | Next pass, with the stats file | Open |
| ON-038 | What `gb_bosscost` and `gb_bosssetupcost` charge | Next pass, `freemode` | Open |
| ON-039 | The MC challenge and VIP challenge rules (cash, RP, time) | Next pass, per script | Open |
| ON-040 | Business battles and the `fm_content_*` business missions | R7.9 and a later pass | Open |

### [Properties in GTA Online](/docs/online/properties.md) (R7.6)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-041 | How the yacht, Kosatka and other vehicles-as-properties are bought and placed | Next pass, `freemode` yacht code | Answered: websites, stats, the 36 yacht spots ([45.6a](/docs/online/properties.md#yachts-and-other-vehicles-as-properties)) |
| ON-042 | Where garage capacities and vehicle slots are stored, and how a personal vehicle is saved per slot | Next pass, with the vehicle stats | Partly answered: spaces per slot and the 607 `MPSV_*` records ([45.6a](/docs/online/properties.md#garage-sizes-and-personal-vehicle-records)); where colours and mods are kept is ON-066 |
| ON-043 | The simple-interior entrance positions and which script places the doors | Next pass, `am_mp_smpl_interior_ext` tables | Partly answered: the per-type function table, all 180 simple-interior ids named, and the entrances of the mansions and salvage yards ([45.6a](/docs/online/properties.md#simple-interior-entrances)); the other types' positions are left |
| ON-044 | Instance numbering of `am_mp_property_int` (owner id, building, or both) | Next pass | Answered: per owner, rows 0 to 31, 32 without an owner ([45.6a](/docs/online/properties.md#interior-instances)) |
| ON-045 | Daily property fees (utility bills) and how they are charged | Next pass, `freemode` | Answered: every 48 minutes, fees per property ([45.6a](/docs/online/properties.md#daily-property-fees-utility-bills)) |
| ON-046 | The business side of each simple interior | [R7.7](/ROADMAP.md) | Answered in [organisations and businesses](/docs/online/organisations-and-businesses.md#464-the-business-loop) |
| ON-065 | Which business or vehicle the garage indices 116 to 137 and ownership slots 12 to 35 are | Next pass, the slot-to-stat functions in `freemode` | Mostly answered: ownership slots 12 to 32 named from `freemode`'s slot-to-stat function (hangar, facility, nightclub, the garage floors, auto shop, Agency, Eclipse Blvd, bail office, hacker den); slots 30, 33 to 35 and indices 116 to 137 left ([45.6a](/docs/online/properties.md#garage-sizes-and-personal-vehicle-records)) |
| ON-066 | Where a personal vehicle's colours, wheels and mods are saved | Next pass, the vehicle save code in `freemode` and `carmod_shop` | Open |

### [Rockstar services](/docs/online/rockstar-services.md) (R15.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-047 | The unnamed (`unk_`) tunable readers and which service natives they are | Second pass, NativeDB hashes | Answered: `_NETWORK_GET_TUNABLES_REGISTRATION_INT`, `_FLOAT` and `_BOOL` ([R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass)) |
| ON-048 | Which story-mode scripts call any service native, and why | Second pass, per script | Open |
| ON-049 | The catalogue item keys and categories | R7.7 | Open |

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
| ON-072 | The names behind the 7,296 tunables registered by hash only | Third pass: needs a name list; hash every candidate name | Open |
| ON-073 | Whether the two `SaveCategory` groups are saved as separate cloud files | Third pass: in-game or cloud check (read-only) | Open |

### [Story systems that clash with an Online mode](/docs/online/story-systems-in-online-mode.md) (R5.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-057 | The full shop table (index, position, type) from `shop_controller` | Second pass; feeds shop mods | Answered: all 65 entries by script, the cosmetic shops with name, position and interior ([R6.7](/docs/gameplay/player/online-cosmetic-shops.md#the-shop-table)) |
| ON-058 | What exactly `clothes_shop_sp` does with a freemode ped (refuses, shows story stock, or breaks) | In-game test | Open |
| ON-059 | What sets 2 and 4 contain (ped brains) | Second pass | Open |
| ON-060 | How bits 16, 32 and 64 in these masks are raised (they end some systems on other occasions) | R1.2 second pass | Partly answered: 64 with 8 by `main`, `mission_repeat_controller`, `benchmark`; 16 and 32 only by the engine ([runtime scripts 1.3](/docs/core/runtime-scripts.md#every-force-cleanup-bit-second-pass)) |

### [Transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| ON-061 | What enables the offline-mode branch before `START_FM_LAUNCH_SCRIPT` (the function returning true), and whether it can be reached on PC | Second pass | Answered: unreachable; its flag is only ever cleared ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-062 | What the four character "slots" in the retry states are (two characters plus?) and how `HUD_SLOTONE` / `HUD_SLOTTWO` relate | R7.3 stats | Answered: cloud save slots 0 (account), 1 and 2 (the two characters); "Slot 1" and "Slot 2" label the character saves ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-063 | The order of states on the way back to story mode, step by step | Second pass | Answered: 63 then 64, step by step ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-064 | What the testbed session is used for in release builds | Second pass | Answered: only level 5 (development) enters it; unused in release ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |
| ON-074 | Which scripts outside `maintransition` ask for the return to story mode, and what retry state 13 waits for | Third pass, the callers of the state request | Open |

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
| UI-009 | Which interior map `int<number>` belongs to which interior | Second pass with R4.5 | Partly answered: 221 of 282 named ([Scaleform 22.5](/docs/ui/scaleform.md#225-every-movie-its-methods-and-who-names-it)); 61 left |

### [Server-backed Online screens](/docs/ui/server-backed-screens.md) (R8.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| UI-010 | Which screens still work, partly, when signed out (an offline test is Online-adjacent; read-only analysis only) | Second pass from the guards | Answered from the guards: [server-backed screens 25.6](/docs/ui/server-backed-screens.md#256-signed-out-what-the-guards-do-second-pass) |
| UI-011 | The full list of transaction calls per business app | R7.7 | Open |
| UI-012 | Leaderboard IDs read by each screen | Second pass | Answered: 39 board IDs in a library shared by 30 scripts ([server-backed screens 25.7](/docs/ui/server-backed-screens.md#257-leaderboard-ids-per-screen-second-pass)) |

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
| AUD-001 | The number of sounds and sound sets in `sounds.dat54` | Second pass with a `.rel` reader | Open |
| AUD-002 | What each audio scene changes | Second pass, `dynamix.dat15` | Open |
| AUD-003 | `.awc` counts per archive | Second pass, list every archive | Open |
| AUD-004 | Speech archives and voices | R9.2 | Open |

### [Music and radio](/docs/audio/music-and-radio.md) (R9.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AUD-005 | The 10 base and many DLC station objects whose names didn't resolve | Second pass with more name sources | Open |
| AUD-006 | How a music event maps to moods and tracks, step by step | R9.1, second pass | Open |
| AUD-007 | Which DLC stations are available in story mode in build 3725 | Test card 1 | Open |
| AUD-008 | The format of a radio track's data (length, markers for the DJ) | R9.1 | Open |

### [Speech and dialogue](/docs/audio/speech-and-dialogue.md) (R9.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| AUD-009 | The list of contexts each voice has, from `speech2.dat4.rel` | Second pass with a `.rel` reader | Open |
| AUD-010 | Which block name maps to which mission, for all 331 containers | Second pass, with R5.1's mission table | Open |
| AUD-011 | The speech parameter names and what each does | Second pass, in-game test | Open |

## Rendering

### [Animation](/docs/rendering/animation.md) (R13.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-001 | The names behind the 22 memory groups and their budget unit | Next pass: hash the candidate names | Open |
| REN-002 | Which clip sets the hashed entries are (resolving the 4,526 keys from script, `peds.ymt` and `weaponanimations.meta` strings) | Next pass | Open |
| REN-003 | Exactly what each `TASK_PLAY_ANIM` flag bit does (262144 and 16777216 in particular) | In-game test | Open |
| REN-004 | The clip archive layout in DLC packs and how many dictionaries each pack adds | With [R0.7](/file-formats/data-file-atlas.md) | Open |
| REN-005 | The 12 expression dictionaries the update replaced and why | Next pass | Open |
| REN-006 | Animation memory cost per dictionary | R18.3 (memory) | Open |

### [Cameras](/docs/rendering/cameras.md) (R13.5)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-007 | The director priorities and exactly when the cinematic director takes over | Second pass | Open |
| REN-008 | The 50 shake names and other camera names that didn't resolve | Second pass with more name sources | Open |
| REN-009 | Which `CREATE_CAMERA` hashes scripts use (the hashed form of `CREATE_CAM`) | Second pass: resolve the hashes in the decompile | Open |
| REN-010 | The view mode contexts and modes as numbers | R6.4 | Open |
| REN-011 | How the first-person car interior camera is chosen per vehicle (`camVehicleCustomSettingsMetadata`) | R14.1 | Open |

### [Particles and decals](/docs/rendering/particles-and-decals.md) (R13.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-012 | The exact decal limit in build 3725 and what limit patches change | Second pass with the executable; R18 | Open |
| REN-013 | How the particle quality setting picks between `ptfx`, `ptfx_hi` and `ptfx_lo` | Test card 2; R18.2 | Open |
| REN-014 | The format of `entityfx.dat`, `materialfx.dat` and `wheelfx.dat` row by row | Second pass | Open |
| REN-015 | Which DLC dictionaries are mounted in story mode | R1.6 second pass | Open |
| REN-016 | Which effect names each dictionary holds (an index) | Second pass: a read-only lister for `.ypt` | Open |

### [Rendering, visual settings and LOD](/docs/rendering/rendering-and-visual-settings.md) (R13.1)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-017 | What each changed key between base and update copies does | Second pass, diff and in-game test | Open |
| REN-018 | How "extended distance scaling" maps to the LOD scale value | In-game test with `GET_LODSCALE` | Open |
| REN-019 | What popular lighting and graphics overhauls change in these files | A comparison, with each author's release page linked | Open |
| REN-020 | Per-pass cost measured on a low-end PC | R18.1 measuring, with a frame capture tool | Open |

### [Timecycle and post effects](/docs/rendering/timecycle-and-post-effects.md) (R13.2)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| REN-021 | What the two numbers on each modifier line mean (value and strength? value at two ends of a range?) | Second pass: test with a modifier that sets one variable | Open |
| REN-022 | What `userFlags` 1, 2, 4, 8 and 16 do | Second pass: compare the modifiers in each group | Open |
| REN-023 | The game hours of the 13 keyframes | Second pass: test card 2 | Open |
| REN-024 | What the 39 unnamed post effects are, and whether anything plays them | Second pass: hash lists from other sources | Open |
| REN-025 | How many timecycle boxes and interior room modifiers the map has | R4.6 (map data) | Open |
| REN-026 | `GroupId` and `EventType` on post effects | Second pass | Open |
| REN-027 | Meaning of the timecycle modifier `userFlags` values (0, 2, 1, 16, 4, 8) *(from the guide's text)* | Second pass | Open |

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
| PERF-012 | What happens in each of the 8 states of the benchmark loop, and how long each pass lasts | Second pass of this topic | Open |
| PERF-013 | Why `ON_ENTER_MP` blocks for about 9 s: which map data it swaps | R1.5 streaming, R18.8 load times | Open |

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
| PERF-025 | Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels | R18.3, compare with the vanilla file | Open |

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
| SCR-001 | Split `MISC` into sub-families with their own owners (weather, cheats, area checks, game state) | Second pass | Open |
| SCR-002 | Which natives are reached only through shared helper code and never called in practice | R0.3 second pass: reachability from each script's entry point | Open |
| SCR-003 | Which namespaces' unused natives still work in story mode (useful to mods but not to Rockstar) | Per-topic second passes | Open |

### [Native usage: which scripts call which natives](/scripting/native-usage.md) (R0.3)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| SCR-004 | What `0x8F5D1AD832AEB06C` and `0x0F7082C60FB479EF` do (not in NativeDB) | [Inbox](/ROADMAP.md#inbox); read their call sites in `freemode` and `public_mission_creator` | Open |
| SCR-005 | Whether the 29 "build 3889" natives exist in 3725 (`IS_NATIVE...` style check from a mod, or ScriptHookV's native table) | In-game test with a small C++ check | Open |
| SCR-006 | A story-only vs Online-only split of every native (which natives story mode never needs) | R0.8 namespace coverage map, using the script groups from R0.1 and the Online catalog | Open |
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
| SCR-012 | What thread priority values change | R1.4 or R18.4 | Open |
| SCR-013 | The event queue indexes and the script event layout | R15.1 | Open |
| SCR-014 | Which of the duplicated pool entries in `gameconfig.xml` applies to the PC build | R1.4 | Open |

## File formats

### [Archive and data file atlas](/file-formats/data-file-atlas.md) (R0.7)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| FF-001 | Reliable sizes per type (audio sizes read as zero) | Second pass, read sizes from the resource headers | Open |
| FF-002 | A per-pack breakdown for all 89 DLC packs | Second pass, with [DLC packs](/docs/entities/vehicles/dlc-packs.md) | Open |
| FF-003 | How the update's copies override the base ones, type by type | R1.6 second pass | Open |

### [UGC mission files (JSON) and who reads them](/file-formats/ugc-json.md) (R7.4)

| ID | Question | Where it goes | Status |
| --- | --- | --- | --- |
| FF-004 | Meaning of each content section key (`me`, `sro`, `amb`, `gt`, `ta`, `tot`, `mvdr` ...), from the `fm_content_*` helper that reads them | Second pass, with one `re_` file and its script | Open |
| FF-005 | The `gen` keys (8,472 paths): which ones `fm_mission_controller` actually reads | Second pass | Open |
| FF-006 | How the controller picks rules per team and stage | R7.5 (job lobby) and a second pass | Open |

## Already answered

Rows that were still in a guide's table but are answered elsewhere. Remove them from the guide in the second pass.

- What the numbers in the story mission table mean (Boot and script control: from launch to control, and between story and Online): Answered in [core guide 2](/docs/gameplay/missions/story-flow.md#22-the-mission-table)

