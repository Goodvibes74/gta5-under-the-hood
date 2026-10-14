# Tools

Small, read-only PowerShell tools used to research the game. None of them writes to a game archive, and none ships any game data: you run them on your own copy of the game, and their output (Rockstar's data) stays in a scratch folder outside this repo.

## Dependencies at a glance

Nothing here is bundled: install each dependency from its official page. No tool downloads anything itself.

| Tool | Needs | Get it |
| --- | --- | --- |
| `rpf-cw.ps1` | Windows PowerShell 5.1 or PowerShell 7; **CodeWalker** (its `CodeWalker.Core.dll`, tested with CodeWalker 30 dev46); **your GTA V Legacy game folder** (the decryption keys are read from your own game files) | CodeWalker: https://github.com/dexyfex/CodeWalker/releases |
| `ysc-dump.ps1` | Same as `rpf-cw.ps1`. Compiles a small inline C# helper with `Add-Type` (built into PowerShell, nothing to install) | Same |
| `dlc-scan.ps1` | Same as `rpf-cw.ps1` | Same |
| `rpf.ps1` | PowerShell only. Uses an inline C# helper (`Add-Type`). Works on unencrypted archives only | Nothing to install |
| `script-launch-graph.ps1` | PowerShell; **Git** on the PATH; a **clone of the community decompiled-scripts repository with its history** (pass `-Repo` and the `-Commit` of your build). Inline C# for the `joaat` hash | Git: https://git-scm.com/downloads. Decompile: search GitHub for `GTA-V-Decompiled-Scripts` |
| `native-usage.ps1` | PowerShell; **Git** on the PATH; the same **decompile clone** as `script-launch-graph.ps1`; NativeDB's **`natives.json`** saved by hand. Inline C# helper (`Add-Type`) | NativeDB data: https://github.com/alloc8or/gta5-nativedb-data |
| `ugc-keys.ps1` | PowerShell 5.1 (uses .NET's built-in JSON reader); `.ugc` files extracted first with `rpf-cw.ps1` | Nothing to install |
| `check-system.ps1` | **Windows** only (reads the registry and `System32`); PowerShell 5.1 or 7. `-Dev` also checks for the .NET SDK and Visual Studio | Nothing to install; it tells you what's missing and where to get it ([system requirements](/docs/00-getting-started/system-requirements.md)) |

None of the tools needs administrator rights, an internet connection, or the game running (closed is safest for the archive tools).

## Before you start

- **CodeWalker** (https://github.com/dexyfex/CodeWalker/releases): `rpf-cw.ps1`, `ysc-dump.ps1` and `dlc-scan.ps1` load its `CodeWalker.Core.dll`. Pass `-CodeWalker <folder>` or set the `CODEWALKER_DIR` environment variable to the folder that holds the DLL.
- Run from your **game folder** (the tools default `-Game` to the current folder), or pass `-Game <folder>`.
- **Windows PowerShell 5.1** works; so does PowerShell 7. If scripts are blocked, use `powershell -ExecutionPolicy Bypass -File ...`.

## The tools and how they were made

### `rpf-cw.ps1`: list and extract any archive

```powershell
powershell -ExecutionPolicy Bypass -File tools\rpf-cw.ps1 -Archive update\update.rpf -Pattern "common\data\handling.meta" -ExtractTo "$env:TEMP\gta"
```

**How it works.** Loads `CodeWalker.Core.dll` with .NET reflection, loads the game's decryption keys from the game folder the same way CodeWalker does (`GTA5Keys.LoadFromPath`), opens the archive as an `RpfFile`, walks every entry including nested archives, and prints the size and path of each entry whose inner path matches `-Pattern` (wildcards). With `-ExtractTo` it writes matching plain files (XML, meta, text, `.ugc`) there; compiled resources (`.ydr`, `.ytd` ...) are listed but not extracted. Nothing is ever written back. Note: sizes shown are the stored (compressed) sizes.

### `ysc-dump.ps1`: script headers and strings

```powershell
powershell -ExecutionPolicy Bypass -File tools\ysc-dump.ps1 -Out "$env:TEMP\ysc" [-Only "freemode"]
```

**How it works.** Opens `update\update2.rpf` with CodeWalker, decrypts each compiled script (`.ysc`) in memory, and reads its header by fixed offsets (code size, statics, globals count and global block, natives count, name, string pages; the table is in [research tools](/docs/00-getting-started/research-tools.md)). Strings are stored in `0x4000`-byte pages as null-terminated text; all of them are written out, one text file per script, plus `_summary.tsv` with the header numbers for every script. Used for the script catalogs, the global block map and spotting what an update changed. About 10 minutes for all 1,143 scripts.

### `dlc-scan.ps1`: inventory of the DLC packs

```powershell
powershell -ExecutionPolicy Bypass -File tools\dlc-scan.ps1 -Out "$env:TEMP\dlcscan" [-Only "mpheist*"]
```

**How it works.** Walks `update\x64\dlcpacks\*\dlc.rpf` with CodeWalker, reads each pack's `setup2.xml` (internal name and order), `content.xml` (what it adds) and `vehicles.meta` (vehicle models), and writes them plus a `dlcscan.json` summary. The [DLC packs page](/docs/entities/vehicles/dlc-packs.md) was written from its output. About 5 minutes.

### `rpf.ps1`: dependency-free viewer for open archives

```powershell
powershell -ExecutionPolicy Bypass -File tools\rpf.ps1 list update\update.rpf "*dlclist*"
```

**How it works.** A plain PowerShell reader for the RPF7 format: reads the header and the entry table, follows nested archives, and lists or extracts entries. Works only where the entry table is not encrypted (archives edited with OpenIV, add-on packs); for Rockstar's encrypted archives use `rpf-cw.ps1`. Needs nothing installed.

### `script-launch-graph.ps1`: who starts whom

```powershell
powershell -ExecutionPolicy Bypass -File tools\script-launch-graph.ps1 -Repo ..\GTA-V-Decompiled-Scripts -Commit <build commit> -Out "$env:TEMP\graph"
```

**How it works.** Runs `git grep` over a decompile clone at the given commit (no checkout needed) for every `START_NEW_SCRIPT*` call and every wrapper call that passes a script name or its hash with a stack size. Hashes are turned back into names with the game's `joaat` hash (implemented inline). Each launch becomes an edge `caller → callee (stack)`; the stack size is named from the pools in `gameconfig.xml`. Launches whose name comes from a variable or table are not resolved. Output: `launches.tsv` and `launch-graph.md`, which became the [script launch graph](/scripting/script-launch-graph.md). Under a minute.

### `native-usage.ps1`: which scripts call which natives

```powershell
powershell -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Native "CUTSCENE::START_CUTSCENE$"   # who uses a native
powershell -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Script armenian1                     # what a script uses
powershell -ExecutionPolicy Bypass -File tools\native-usage.ps1 -NativesJson <natives.json> -Out "$env:TEMP\natives"              # the reference pages
```

**How it works.** Reads every script's native table (`native_tables/<script>.txt` in the decompile repository) and every native call in the decompiled scripts with `git grep` at the given commit, through an inline C# helper that streams git's output (about 12 million lines). The tables hold NativeDB hashes, so names come from NativeDB's `natives.json` (save it by hand from https://github.com/alloc8or/gta5-nativedb-data; the tool downloads nothing). Calls are matched to hashes inside each script: `unk_0x<hash>` calls directly, then by name without namespace (the decompiler uses older namespace names), then by elimination for the few names the decompiler and NativeDB disagree on. Output: `native-usage.tsv`, `script-natives.tsv`, `aliases.tsv`, and the Markdown pages that became the [native usage index](/scripting/native-usage-index.md). About two minutes. Guide: [native usage](/scripting/native-usage.md).

### `ugc-keys.ps1`: every key in the mission files

```powershell
powershell -ExecutionPolicy Bypass -File tools\rpf-cw.ps1 -Archive update\update2.rpf -Pattern "common\data\ugc\*" -ExtractTo "$env:TEMP\ugc"
powershell -ExecutionPolicy Bypass -File tools\ugc-keys.ps1 -Dir "$env:TEMP\ugc" -Out "$env:TEMP"
```

**How it works.** Parses each `.ugc` file with .NET's JSON reader, walks every object and array (arrays collapsed to `[]` in the path), and counts how many files contain each key path. Output: `ugc-keys.tsv` (path, files). About five minutes for the 1,001 local files. Guide: [UGC mission files](/file-formats/ugc-json.md).

### `check-system.ps1`: what Windows needs

```powershell
powershell -ExecutionPolicy Bypass -File tools\check-system.ps1        # play and mods
powershell -ExecutionPolicy Bypass -File tools\check-system.ps1 -Dev   # also the modding tools
```

**How it works.** Checks, read-only, for each thing outside the game folder that the game and its mods need: the DirectX June 2010 files in `System32`, the Visual C++ runtimes, .NET Framework 4.8 (from the registry), Media Foundation, and with `-Dev` the .NET SDK and Visual Studio. The list comes from the import tables of the game and mod files ([system requirements](/docs/00-getting-started/system-requirements.md)). Prints OK or MISSING with what to install. Changes nothing.

## Ideas for new tools (good contributions)

| Tool | What it would do | Roadmap |
| --- | --- | --- |
| Global map | List which script registers each global block and what fields the big blocks hold | R0.4 |
| Update check | Compare a new build with the last one: version, DLC packs, script sizes, data files | R11.2 |
| Data-file differ | Compare two copies of a `.meta` file entry by entry (by name), the way the vehicle and weapon guides compared modded files | R0.7 |

## Adding a tool

Add a tool on a `tool/<name>` branch (see [CONTRIBUTING.md](/CONTRIBUTING.md)), keep it read-only, and document it here the same way.
