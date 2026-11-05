# Questions that need a clean game (no mods loaded)

Some open questions can only be answered from the game as Rockstar ships it: limit patches and script hooks change the very values, checks and timings these questions ask about. This page lists them, so that one sitting with the mods switched off covers all of them. It is a companion to [`PC-SESSION.md`](/PC-SESSION.md), which has the full plan, and each row links to its guide. When a row is done, update its guide and its row in [`OPEN_QUESTIONS.md`](/OPEN_QUESTIONS.md) as usual, and delete it here.

Why it matters, with an example: the first decrypted copy of the executable was taken with the usual mods loaded, and the decal-definition check in it reads 620, which is a decal-limit patch's setting, not Rockstar's ([particles and decals](/docs/rendering/particles-and-decals.md#the-decal-definition-limit-in-the-executable-pc-executable-pass)).

## Setting up a clean start

- **Story mode only.** Never use GTA Online for any of this.
- **Take every mod loader out of the game folder** for the session (move them to a folder outside it, then move them back): the ASI loader (usually `dinput8.dll`, sometimes another proxy DLL such as `xinput1_4.dll`), every `.asi` file (OpenIV's `OpenIV.asi` included, so the `mods` folder is not used either), `ScriptHookV.dll`, ScriptHookVDotNet and any trainer or Lua loader.
- **Check it's clean:** no mod logs are written on start-up (ScriptHookV, the limit adjusters), no mod menu opens, and the loading screen is the stock one.
- **For the executable rows,** take the read-only copy of the decrypted image once the player can move, with an administrator PowerShell, as `PC-SESSION.md` Part 2 describes. Keep the copy outside the repo; keep the earlier modded copy too, because comparing the two shows what each patch changes.

## 1. From a clean copy of the executable (Part 2)

| ID | What to find out | Guide |
| --- | --- | --- |
| REN-012 | The vanilla size of the decal-definition table (512 is **Known** from the patch), and what decal-limit patches change | [Particles and decals](/docs/rendering/particles-and-decals.md#the-decal-definition-limit-in-the-executable-pc-executable-pass) |
| CORE-015 | Memory cost of each pool, bytes per slot, read where the vanilla code sizes each pool | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-016 | The vanilla built-in sizes of the weapon arrays that WeaponLimitsAdjuster raises | [Memory, pools and limits](/docs/core/memory-and-pools.md) |
| CORE-027 | The streaming memory budget (how the engine splits memory between stores), and what HeapAdjuster changes in it | [Streaming](/docs/core/streaming.md) |
| GP-023 | What NoEditorRestrictions patches and the vanilla limits it lifts: compare the clean copy with the modded one | [Replay, director mode and the Rockstar Editor](/docs/gameplay/missions/replay-director-and-editor.md) |

## 2. In-game tests: clean run first, then with mods (Part 3, block A)

`PC-SESSION.md` asks for the whole performance block (PERF-001 to PERF-028) on a clean install first and then again with the usual mod set. These rows are the clean-versus-modded comparisons themselves, so their clean run is the baseline:

| ID | What to find out | Guide |
| --- | --- | --- |
| PERF-011 | The benchmark switches and results file, and a baseline with and without mods | [Measuring performance](/docs/performance/measuring.md#test-cards) |
| PERF-015 | How much a smaller mod set saves, measured the same way | [Streaming, memory and video memory](/docs/performance/memory-and-vram.md#38-test-cards) |
| PERF-018 | Frame time per mod set at the same spot (clean is the zero point) | [Mod overhead](/docs/performance/mod-overhead.md#57-test-cards) |
| PERF-019 | Load time added by the add-on packs (`Mods\` off against on) | [Mod overhead](/docs/performance/mod-overhead.md#57-test-cards) |
| PERF-025 | Whether raised physics pools in a modded `gameconfig.xml` change anything at a low-end PC's spawn levels (vanilla `gameconfig.xml` first) | [Physics cost](/docs/performance/physics-cost.md#119-test-cards) |
| PERF-001, PERF-020 | The per-frame cost of one idle SHVDN script: a clean run, then the same run with only ScriptHookV, SHVDN and one empty script | [CPU](/docs/performance/cpu.md#48-test-cards), [Mod overhead](/docs/performance/mod-overhead.md#57-test-cards) |

## Not these: rows that need the mods loaded

So that nobody runs them clean by mistake: PERF-016 (how much of HeapAdjuster's raised heap is used), CORE-013 and CORE-014 (PoolManager's logs and pool usage), and AI-015 (whether the modded `events.meta` drops gunfight reactions) are about the mods themselves.
