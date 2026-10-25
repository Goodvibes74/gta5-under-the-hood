# CLAUDE.md

Instructions for Claude Code (or any AI assistant) working in this repo. Human contributors: this is also the fastest summary of how the research is done.

## What this repo is

A public reference on how **Grand Theft Auto V (PC, Legacy edition, build 1.0.3725.0)** works underneath: the engine, physics, AI, the world, story mode, GTA Online, the UI and audio, so people can mod it. It contains only contributors' own writing and their own small tools. No mods, no game files, no game code.

. **Markdown only, no executables.** Add or change only `.md` files. Never add binaries, executables, scripts outside `tools/`, archives or downloaded files; if a tool was used, link to its official release page instead. Changes to `tools/`, `examples/` and `.github/` need the maintainer and must stay plain readable source with no download-and-run code. The `file-rules` check rejects anything else.
1. **Never copy Rockstar code or data into the repo.** Decompiled scripts, extracted archive files and dumps stay outside it (a temp or scratch folder). Quote names, numbers, field names, coordinates and short labels; describe logic in your own words.
2. **Never include other people's mods** (binaries or source, decompiled or not). Link to the author's page.
3. **Mark every claim Verified or Known.** Verified = read in the game files or a decompile of the stated build. Known = community knowledge not checked.
4. **No personal data:** no user paths, emails, hardware details (except a clearly marked "on a low-end test PC" note), saves or logs.
5. **Single player only.** Never suggest running mods in GTA Online; it gets accounts banned.
6. Work on one roadmap topic per branch, named as in [CONTRIBUTING.md](/CONTRIBUTING.md) (`research/R1.4-memory-pools`). Don't commit unless the contributor asks.

## Research workflow (one topic)

1. Read the topic's row in [ROADMAP.md](/ROADMAP.md) ("What to find out") and the finished guides it builds on. Don't redo what a guide already answers.
2. Pick sources:
   - **Decompiled scripts** for logic: a clone of the community decompile repository, read at the commit for the build (`git grep <pattern> <commit> -- decompiled_scripts`, `git show <commit>:decompiled_scripts/<name>.c`). Files are huge (`freemode.c` is 1.47 million lines): search, don't open. See [decompiled scripts](/docs/00-getting-started/decompiled-scripts.md).
   - **Data files** for tuning: extract with `tools/rpf-cw.ps1` into a scratch folder (needs CodeWalker; see [research tools](/docs/00-getting-started/research-tools.md)). Compare an update's copy (`update\update.rpf`) with the base copy (`common.rpf`); the update wins.
   - **Natives**: [NativeDB](https://nativedb.dotindustries.dev/gta5/natives). Count real usage in the decompile before calling something important.
   - **In-game tests** for behaviour: write a test card the contributor can run (what to do, what they should see).
3. Count things. "Used 1,543 times in 210 scripts" beats "used a lot". Say how you counted.
4. Write the page from [`templates/entry-template.md`](/templates/entry-template.md) into the folder the roadmap row belongs to (each folder README lists its topic IDs).
5. Update the roadmap row (status and link) and the folder README table. If the work used a tool, website or technique that isn't on [tools and resources](/docs/00-getting-started/toolbox.md), add a row to its "Contributed tools and resources" table (official link only, never the tool itself).
6. Before finishing, scan the diff for decompiled code blocks, extracted file contents, personal paths and mod binaries.

## Useful facts

- The game's scripts talk to the engine only through natives; mods (C# with ScriptHookVDotNet, C++ with ScriptHookV, Lua) call the same natives.
- Decompiler names (`func_878`, `Global_102429`, `Local_3133`) change every build. Use them only as pointers, always with the build.
- Base data is in `common.rpf`, newer copies in `update\update.rpf`, DLC data in `update\x64\dlcpacks\<pack>\dlc.rpf`; `dlc_patch` folders in `update.rpf` patch older packs.
- PC build 1.0.3725.0's scripts match the decompile commit "Update for 1.72-3725.0" byte for byte.

## Repo map

| Path | What |
| --- | --- |
| `docs/` | The guides, by game system (folder READMEs list their topics) |
| `file-formats/` | One page per file format |
| `scripting/` | The script VM, natives, and how mods run code |
| `examples/` | Small worked mods |
| `tools/` | Read-only research tools (PowerShell), explained in `tools/README.md` |
| `templates/` | The entry template |
| `ROADMAP.md` | Every topic and its status |
| `OPEN_QUESTIONS.md` | Every guide's open questions with IDs, by category: the second-pass tracker. Update it when you answer or add a question |
