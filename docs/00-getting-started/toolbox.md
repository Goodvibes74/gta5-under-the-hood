# Tools and resources

Every tool, data source, website, assistant and trick used to research and write these guides: what each was used for, and where to get it. Versions are in [setup](setup.md).

**This page belongs to everyone.** If you used something that made your research faster or easier (a tool, a script, a website, a CodeWalker trick, a VS Code extension, an AI skill, a forum thread, a video), add it to [Contributed tools and resources](#contributed-tools-and-resources) at the bottom, in the same pull request as your research. Link to the official page; never upload the tool itself (see the [file rules](/CONTRIBUTING.md#file-rules)).

## Reading the game files

| Tool | Used for | Link |
| --- | --- | --- |
| CodeWalker (and its `CodeWalker.Core.dll`) | Decrypting Rockstar's archives in memory; the base of `rpf-cw.ps1`, `ysc-dump.ps1` and `dlc-scan.ps1` | https://github.com/dexyfex/CodeWalker |
| OpenIV | Browsing archives, the "mods" folder for safe edits, exporting files by hand | https://openiv.com |
| Our PowerShell tools | Listing and extracting archives, dumping script headers and strings, scanning DLC packs, building the script launch graph; how each was made: [`/tools/README.md`](/tools/README.md) | [`/tools`](/tools) |

## Reading the game's logic

| Tool | Used for | Link |
| --- | --- | --- |
| The community decompile of the game scripts | Reading what every script does, at the exact build (one commit per game update) | Search GitHub for `GTA-V-Decompiled-Scripts`; see [decompiled scripts](decompiled-scripts.md) |
| The original GTA V script decompiler | The tool decompiles of this kind come from (for understanding, not needed to read them) | https://github.com/njames93/GTA-V-Script-Decompiler |
| `git grep`, `git show`, `git diff` | Searching and reading a build straight from history; comparing builds | https://git-scm.com |
| `grep`, `awk`, `sed`, `perl` (Git for Windows' bash) | Counting native calls, flag values, cases in a switch; tabulating data files | https://git-scm.com/download/win |
| A call-graph labeller (an `awk` script) | Naming the unnamed functions of `freemode` by the strings each one reaches (method in [inside freemode](/docs/online/07-freemode.md)) | Described in that guide |

## Reading the engine's API

| Source | Used for | Link |
| --- | --- | --- |
| NativeDB | Native names, parameters and community notes | https://nativedb.dotindustries.dev/gta5/natives |
| alloc8or's native data | The data behind NativeDB, for offline search | https://github.com/alloc8or/gta5-nativedb-data |
| ScriptHookVDotNet source and docs | The C# API, how SHVDN runs scripts | https://github.com/scripthookvdotnet/scripthookvdotnet |
| LemonUI, NativeUI, iFruitAddon2 | Menu and phone libraries | https://github.com/LemonUIbyLemon/LemonUI, https://github.com/Guad/NativeUI, https://github.com/Bob74/iFruitAddon2 |
| ILSpy | Reading compiled .NET libraries and mods to learn APIs and techniques (never republished) | https://github.com/icsharpcode/ILSpy |

## Watching the game run

| Tool | Used for |
| --- | --- |
| `ScriptHookV.log`, `ScriptHookVDotNet.log`, `asiloader.log` | Boot timeline, which mods loaded, errors |
| A small SHVDN monitoring script | Frame times, freezes, entity counts, running Rockstar script threads and free stacks at boot ([script VM](/scripting/script-vm.md) section 2.9 describes what to log) |
| Per-mod log lines | Every guide's "Test cards" say what a test should log |

## AI assistance

Most guides were researched and written with **Claude Code** (Anthropic's coding assistant in the terminal and VS Code), driving the tools above: it ran the searches and counts, read the decompiled scripts and data files, and drafted the pages, which were then checked against the sources. Docs: https://docs.claude.com/en/docs/claude-code/overview. The repo's [`CLAUDE.md`](/CLAUDE.md) gives an assistant the rules and the workflow.

Claude Code **skills** are packaged instructions for a kind of task (https://docs.claude.com/en/docs/claude-code/skills). These were available in the setup used for this research; the guides themselves mostly needed plain search and counting:

| Skill | What it is for |
| --- | --- |
| `game-recon` | Working out how a game can be modded: engine, version, loaders, anti-cheat, the community's route |
| `reverse-engineering` | Decompiling .NET, IL2CPP, Java and native code; reverse-engineering data formats; reading memory |
| `reverse-engineer-anything` | Reverse-engineering native, managed, packaged and firmware targets with a dedicated toolset |
| `codebase-teardown` | Taking a large codebase apart systematically |
| `deep-research` | Multi-source research with citations |
| `game-research-websearch` | Searching the web and archives (dead forums, GitHub, Nexus) for prior modding work |
| `mod-any-game` | Taking a mod idea from recon to a working, recorded mod |
| `game-automation` | Launching and driving the game to test a mod automatically |
| `share-field-notes` | Writing up how a game was modded for a shared knowledge base |
| `publish-mod` | Pre-release checks (no game files or decompiled code), credits, where to upload |
| `asset-pipeline`, `fal-assets` | Turning generated or hand-made art and audio into game-ready assets |
| `showcase-video` | Recording and cutting a short video of a mod |
| `mashup-mods` | Cross-game mods and total conversions |

If you use another assistant, give it `CLAUDE.md` as its instructions; nothing in the workflow depends on Claude.

## Contributed tools and resources

Add one row per tool or resource, newest at the bottom. Keep it to things you actually used.

| Tool or resource | Version | Link (official page only) | What it helped with | Used for topic | Added by |
| --- | --- | --- | --- | --- | --- |
| *Example:* CodeWalker | 30 dev46 | https://github.com/dexyfex/CodeWalker/releases | Extracting `handling.meta` and `materials.dat` from the encrypted archives | R2.1, R2.2 | @Goodvibes74 |

**Rules for this table**

- **Links only.** The official site, the author's GitHub releases page, or the official store or documentation page. No re-uploads, mirrors, shared-drive links or attachments.
- **Say what it did for you** in a few words, so others can tell whether it fits their topic.
- **Workflows count too.** A clever `git grep` pattern, a CodeWalker export setting or a regex that saved you an hour can go here with a one-line description, or as a short section above if it needs more room.
- If a tool turns out to be unsafe or abandoned, open an issue instead of deleting its row, so the reason is recorded.
