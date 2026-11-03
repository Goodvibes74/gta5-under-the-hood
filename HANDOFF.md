# Handoff: second pass, end of phase 4 (read this first)

Short state file for the next AI session or contributor, so the work can resume without re-reading the whole repo. Update or delete it when the work below is done. It contains no game data and no personal paths.

## Where things are

- **All work is on branch `main-km1sze`** (pushed). It holds the phase 4 commits P4.1 to P4.8 (first made on `research/second-pass-phase4`, which stops at P4.8), then P4.9, P4.10 and the "second-pass leftovers" commits. Locally: `git fetch origin main-km1sze && git checkout main-km1sze`.
- **Not done yet:** the pull request for phase 4 + leftovers (open it only when asked), and the knowledge-graph refresh (`/graphify . --update`, then commit `graphify-out/`), which the earlier batches deferred to the end of phase 4. Run the graph refresh in the same branch before the PR, or right after merging, as the maintainer prefers.
- `OPEN_QUESTIONS.md` is the tracker: 438 questions; every status changed in this work links to the doc section.

## What the last session did

1. **P4.9 controls (R6.4):** found that **build 3717 renumbered control IDs**. 37 `INPUT_CREATOR_*` controls were inserted at 257 to 293, so every old control from 257 to 364 is now +37 (`ATTACK2` 294). Wrote this up in `docs/gameplay/player/controls-and-camera.md` with the shared disable helpers and the view-mode contexts, and added a warning on the keycodes page.
2. **P4.10 skills, flying, weapons:** how `stats_controller` grows skills, the starting skills, the ability types, AI flight mission types, the flight school aircraft, the hatchet and Gusenberg unlocks.
3. **Leftovers:** the questions the second pass itself created (phases 1 to 4), answered where the decompile allowed:

| ID | Status | Where |
| --- | --- | --- |
| CORE-033 | Answered (mission-type values and may-replace table) | `docs/core/runtime-scripts.md` |
| GP-084, GP-086 | Answered (barber rank locks, hair fade map) | `docs/gameplay/player/online-cosmetic-shops.md` |
| GP-088 | Mostly: entries 6, 12, 18 unexplained | `docs/gameplay/missions/minigames-and-activities.md` |
| GP-089 | Mostly: `MrsPhilips2`, `Rampage3` releases and code entry 95 open | `docs/gameplay/missions/strangers-and-freaks.md` |
| GP-090 | Partly: counters mapped by company code; names need text | `docs/gameplay/economy/economy-and-pickups.md` |
| GP-082 | Partly: 305 menus map to 306 `CSHOP_TITLE` labels; text and layout rules open | cosmetics doc |
| ON-067, ON-075 | Answered | `docs/online/interaction-menu-phone-apps.md`, `docs/online/organisations-and-businesses.md` |
| ON-072 | Partly: 311 hashed tunable names recovered | `docs/online/stats-and-tunables.md` |
| ON-074 | Partly: retry state 13 open | `docs/online/transitions-and-sessions.md` |

## What is left, and what each needs

**Needs game data or text files (do these on the PC with CodeWalker, `tools/rpf-cw.ps1`):**

- GP-045: the `CFlyingHandlingData` blocks of every DLC `handling.meta`.
- GP-046: what `SPMED` and `SPSMALL` are (`vehicles.meta`).
- GP-047: the flight school lesson names (`PSCHOOL` text block) and which lesson uses which aircraft.
- GP-081: the restriction tag names (catalogue) matched to the hashes `shop_controller` tests.
- GP-082: the English text of the `CSHOP_TITLE` labels.
- GP-083: the base-wardrobe labels and prices in `clothes_shop_mp`.
- GP-090: the company names (`BSS_BSTR_` labels, probably in an update or DLC text block).
- GP-078 (ammo caps): the `AmmoMax*` fields of `weapons.meta`, plus the engine.

**Online, readable from the decompile but not reached:**

- ON-066: where a personal vehicle's colours, wheels and mods are saved (`freemode` and `carmod_shop` save code).
- ON-068: website items 323, 324, 357 and 402 (`appinternet` preview code).
- ON-069: each interaction-menu page's show and grey rules (`am_pi_menu`).
- ON-070, ON-071: lobby and playlist fields (`freemode`, `maintransition`, `fmmc_launcher` state 10).
- ON-076: the classic heists' elite rewards (`fm_mission_controller`).
- ON-077: nightclub production timing (business hub code in `freemode`).
- ON-074's retry state 13.

**Needs the executable or an in-game test (story mode only, never Online):**

- CORE-031, CORE-032: random-ped brain sets; force-cleanup bits 16 and 32.
- GP-085: hair and make-up tint counts.
- GP-087: replay type numbers.
- GP-091: whether old control numbers still work on 3717+. Test card 4 in the controls doc.
- GP-092: ability entries 8 to 16.
- GS-004: level index 5.
- ON-073: cloud save files, read-only check.
- UI-020: signed-out returns.
- GP-088 remainder: watch `Global_114904.f_8620[6/12/18]` in-game.

## Working method that saved tokens (reuse it)

- **Decompile:** the community repository at commit `6c18d3e8` ("Update for 1.72-3725.0"). The fastest local setup is a normal clone and `git show 6c18d3e8:decompiled_scripts/<name>.c` or `git grep`. The cloud session instead downloaded the 1,145 `.c` files of that commit (3.3 GB) in parallel; a partial clone with a checkout was much slower.
- **Small Python helpers** (kept outside the repo, per the rules) did all the tracing:
  - Split a call's arguments by bracket depth.
  - Trace a native's or setter's argument back through wrapper functions to its literal, up to 3 levels.
  - Group identical runs of calls (this is how the disable helpers were found).
  - Hash candidate names with `joaat` (checked: `weapon_pistol` = 453432689).
- **Count vector arguments from the end:** the decompiler writes a vector either as one `Vector(...)` or as three values.
- **Flow (`initial`):** data pools are shared between command types. Identify a command by the hash its builder writes, not by the pool. Strand builder functions start with `iVar0 = <strand id>`.
- **Unlock chains:** passing a stranger mission arms a `code_controller` entry (field 22 of its table row). That entry often sends a text or email carrying the next entry, and that next entry sets a flag ID.
- **Mark claims:** Verified (read in the decompile or files) or Known (community, for example the engine enum dump of build 3889 used for the control and ability-type names).

## Next steps, in order

1. Pull `main-km1sze`; read `OPEN_QUESTIONS.md` rows marked Open or Partly.
2. Do the data-file items above with CodeWalker, then the remaining Online decompile items.
3. Refresh the graph (`/graphify . --update`), check `grep -r "/home/\|C:\\\\Users" graphify-out` is empty, commit.
4. Open the PR when the contributor asks; then delete or update this file.
