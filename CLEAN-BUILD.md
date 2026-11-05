# Questions that need a clean game (no mods loaded)

Many open questions can only be answered from the game as Rockstar ships it, because mods change the very values, checks, data and scripts these questions ask about. This page lists every open question in [`PC-SESSION.md`](/PC-SESSION.md) by how clean the game has to be, so the work can be grouped into clean sittings. Each row's details and test card are in its guide (linked from `PC-SESSION.md`). When a row is done, update its guide and its row in [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md) as usual, and delete it here.

Why it matters, with two examples from the test install:

- **Limit patches change limits.** The first decrypted copy of the executable was taken with the usual mods loaded, and its decal-definition check reads 620, a decal-limit patch's setting, not Rockstar's ([particles and decals](/docs/rendering/particles-and-decals.md#the-decal-definition-limit-in-the-executable-pc-executable-pass)). Pool, heap, weapon and packfile adjusters do the same to their limits.
- **The mods folder replaces the game's data and scripts.** On the test install, OpenIV's mods folder holds edited copies of `common.rpf`, `update.rpf`, `update2.rpf` (the compiled scripts) and `x64a.rpf`, plus add-on DLC packs (a police and AI overhaul among them). With `OpenIV.asi` loaded the game runs on those copies, so peds, police, weapons, handling, timecycle and even Rockstar's scripts can differ from vanilla.

## Two levels of clean

- **Fully clean:** no mod files at all. Take every mod loader out of the game folder for the session (move them to a folder outside it, and back afterwards): the ASI loader (usually `dinput8.dll`, sometimes another proxy DLL such as `xinput1_4.dll`), every `.asi` file, `OpenIV.asi` included (so the mods folder isn't used), `ScriptHookV.dll`, ScriptHookVDotNet, Lua loaders and trainers.
- **Clean test setup:** fully clean, plus only what the test card needs to run: `ScriptHookV.dll` and the ASI loader, and the one test script (with ScriptHookVDotNet if the script is C#). No `OpenIV.asi` (so no mods folder), no limit adjusters, no other scripts or menus.

Check before starting: no mod logs are written on start-up (the adjusters, OpenIV), no mod menu opens, and the loading screen is the stock one. **Story mode only**, as always.

## 1. Fully clean: a copy of the executable (Part 2)

Take the read-only copy of the decrypted image once the player can move, with an administrator PowerShell, as `PC-SESSION.md` Part 2 describes. Keep it outside the repo, and keep the earlier modded copy: comparing the two shows what each patch changes.

| ID | What to find out | Guide |
| --- | --- | --- |
| REN-012 | The vanilla size of the decal-definition table (512 is **Known** from the patch), and what decal-limit patches change | [Particles and decals](/docs/rendering/particles-and-decals.md#the-decal-definition-limit-in-the-executable-pc-executable-pass) |
| CORE-015 | Memory cost of each pool, bytes per slot, where the vanilla code sizes each pool | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-016 | The vanilla built-in sizes of the weapon arrays that WeaponLimitsAdjuster raises | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-027 | The streaming memory budget (how the engine splits memory between stores), and what HeapAdjuster changes in it | [Streaming](/docs/core/streaming.md) |
| GP-023 | What NoEditorRestrictions patches and the vanilla limits it lifts: compare the clean copy with the modded one | [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) |

## 2. Fully clean first, then with mods: performance (Part 3, block A)

All 26 performance rows: **PERF-001** to **PERF-011**, **PERF-013** to **PERF-015**, **PERF-017** to **PERF-028**. Measure each one clean first; the run with the usual mod set comes second. For these rows the clean run is the comparison itself:

| ID | What to find out |
| --- | --- |
| PERF-011 | The benchmark switches and results file, and a baseline with and without mods |
| PERF-015 | How much a smaller mod set saves |
| PERF-018 | Frame time per mod set at the same spot (clean is the zero point) |
| PERF-019 | Load time added by the add-on packs (`Mods\` off against on) |
| PERF-025 | Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels (vanilla `gameconfig.xml` first) |
| PERF-001, PERF-020 | The per-frame cost of one idle SHVDN script: a clean run, then the clean test setup with one empty script |

## 3. Clean test setup: limits and counts (Part 3)

Pool, heap and limit adjusters raise exactly these numbers, so a modded run measures the patch:

| ID | What to find out |
| --- | --- |
| CORE-015 | Memory cost of each raised pool (also from the executable, section 1) |
| CORE-026 | How `TextureQuality` values map to the menu and how much memory each level takes |
| CORE-029 | Pop-in at `LodScale` 0 and 0.5: hitches and memory |
| SCR-010 | The size limits of the nearby-entity arrays |
| ENT-016 | How many Euphoria ragdolls run at once before peds fall back (also PERF-023) |
| ENT-022 | How the caps, `CityDensity` and the budgets combine into the real spawn count |
| ENT-027 | How the time window and probability combine with the `#Scenario` cap |
| ENT-032 | How the schedule caps, the budget and `CityDensity` combine (vehicles) |
| PHY-007 | How far and how fast fire spreads, and the number of fires at once |
| AI-007 | How far from the player ambient peds despawn |
| AI-030 | How far around the player navmeshes stream by default |
| AI-037 | The exact follower limit and what happens to the eighth |
| AI-041 | How many enemies a big shootout has alive at once |

## 4. Clean test setup: behaviour, data and scripts (Part 3)

Everything else in Part 3 measures how the vanilla game behaves, which the mods folder's data, scripts and add-on packs can change (police, AI, weapons, handling, timecycle, text, DLC load order). Run all of them in the clean test setup:

| Area | IDs |
| --- | --- |
| AI | AI-002, AI-004, AI-005, AI-018, AI-019, AI-020, AI-021, AI-025, AI-039, AI-040, AI-042, AI-044, AI-046, AI-047, AI-049 |
| Entities | ENT-004, ENT-007, ENT-010, ENT-018, ENT-030, ENT-033, ENT-037 |
| Physics | PHY-003, PHY-006, PHY-012, PHY-017 |
| The world | WLD-003, WLD-012, WLD-013, WLD-014, WLD-016, WLD-018, WLD-019 |
| Gameplay | GP-006, GP-023, GP-038, GP-039, GP-043, GP-049, GP-050, GP-053, GP-054, GP-062, GP-064, GP-068, GP-071, GP-072, GP-074, GP-075, GP-078, GP-081, GP-085, GP-088, GP-089, GP-091 |
| Core and boot | CORE-001, CORE-032, GS-003 |
| Scripting | SCR-002, SCR-005, SCR-008, SCR-009, SCR-011, SCR-012 |
| User interface | UI-002, UI-017, UI-020 |
| GTA Online systems (read in story mode) | ON-058, ON-060, ON-073 |
| Audio | AUD-007, AUD-008, AUD-011 |
| Rendering | REN-003, REN-013, REN-017, REN-018, REN-020, REN-021, REN-023 |

The rows on how packs and labels merge (CORE-001, ENT-007, UI-017) add their own small test packs; no other add-on packs should be loaded while they run.

## 5. Data files (Part 1): no clean game needed, but the right archives

The data-file rows are read with CodeWalker, not in game, so mods don't matter as long as the files come from the game folder's own archives, never from the mods folder's copies (the repo's `tools/` scripts open archives by their path in the game folder, such as `update\update.rpf`, so point them at the game folder, not at `mods\`). Where a Part 1 row ends in an in-game check (PHY-011, "then an in-game check"), do that check in the clean test setup.

## Not these: rows that need the mods loaded

These are about the mods themselves, so they run with the mods on: PERF-016 (how much of HeapAdjuster's raised heap is used), CORE-013 and CORE-014 (PoolManager's logs and pool usage), and AI-015 (whether the modded `events.meta` drops gunfight reactions). The second, modded run of each performance row (section 2) also belongs here.
