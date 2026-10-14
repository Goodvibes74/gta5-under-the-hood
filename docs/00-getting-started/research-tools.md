# Research tools

How the facts in these guides were extracted, and how to repeat it on your own copy of the game or after an update. The PowerShell tools are in [`/tools`](/tools). All of them are read-only: they decrypt archives in memory with the CodeWalker.Core library (which ships with [CodeWalker](https://github.com/dexyfex/CodeWalker); point the tools at your CodeWalker folder) and never write to an archive. Their output is Rockstar's data: keep it outside any repo and never publish it.

## The tools

| Tool | What it does | Time |
| --- | --- | --- |
| `rpf-cw.ps1` | Lists any archive, including Rockstar's encrypted ones and nested archives, and extracts matching plain files (`.xml`, `.meta`, `.ugc`, `.ipl` ...) | Seconds to a minute per archive |
| `ysc-dump.ps1` | Decrypts every compiled script and writes its header numbers and string table to one text file per script, plus `_summary.tsv` | About 10 minutes for all 1,143 |
| `dlc-scan.ps1` | Inventories the DLC packs: names, vehicles, file counts ([DLC packs](/docs/entities/vehicles/dlc-packs.md)) | About 5 minutes |
| `rpf.ps1` | A dependency-free viewer for unencrypted archives (add-on packs) | Seconds |
| `script-launch-graph.ps1` | Reads a decompile clone at a pinned commit with `git grep` and lists every script launch whose name is written in the call, with its stack size ([launch graph](/scripting/script-launch-graph.md)) | Under a minute |

Examples (PowerShell, from the game folder):

```powershell
# Online stats definitions
powershell -NoProfile -ExecutionPolicy Bypass -File tools\rpf-cw.ps1 -Archive update\update.rpf -Pattern "common\data\mpstats*" -ExtractTo "$env:TEMP\gta\data"

# All 1,001 local mission files
powershell -NoProfile -ExecutionPolicy Bypass -File tools\rpf-cw.ps1 -Archive update\update2.rpf -Pattern "common\data\ugc\*" -ExtractTo "$env:TEMP\gta\ugc"

# Strings of one script
powershell -NoProfile -ExecutionPolicy Bypass -File tools\ysc-dump.ps1 -Out "$env:TEMP\gta\ysc" -Only "am_mp_property_ext"
```

## How the script reader works

CodeWalker decrypts a script entry and returns its system memory block (already decompressed). The script header (64-bit PC layout):

| Offset | Field |
| --- | --- |
| `0x00` | vtable pointer |
| `0x08` | page map pointer |
| `0x10` | code page table pointer |
| `0x18` | globals signature |
| `0x1C` | code size |
| `0x20` | parameter count |
| `0x24` | statics count |
| `0x28` | globals count (low 18 bits) and global block (high bits) |
| `0x2C` | natives count |
| `0x30`, `0x38`, `0x40` | statics, globals and natives pointers |
| `0x58` | name hash |
| `0x60` | script name pointer |
| `0x68` | string page table pointer |
| `0x70` | strings size |

Pointers are `0x50000000`-based offsets into the block. Strings are stored in pages of `0x4000` bytes as null-terminated text: text labels, animation dictionaries, IPL and interior names, audio names, script names (which give the reference graph in the [Online script catalog](/docs/online/02-script-catalog.md)), debug messages and cloud content IDs.

## Open tooling work

1. **Naming the native calls in compiled scripts.** In PC scripts the native table holds hashes for the specific build, stored rotated (each entry rotated left by `(code size + index) & 63` bits). Turning them into names needs a crossmap from the community native database for that build. (A decompile already has the names; this is for working without one.)
2. **Mapping the mission-creator (UGC) format.** The local job files are plain JSON; every key still needs documenting.

## After a game update

1. Check that ScriptHookV supports the new build (`ScriptHookV.log`); that is the usual breakage.
2. Re-run `dlc-scan.ps1` for new packs.
3. Re-run `ysc-dump.ps1` and compare `_summary.tsv` with the previous run: new script names show new content; size changes show what Rockstar changed.
4. Re-extract the UGC folder and compare the file list.
5. Once a decompile of the new build exists, re-run `script-launch-graph.ps1` against it and compare the edges and stack sizes, and compare the `globalblock` lines of the script dump with the block table in [runtime scripts](/docs/core/runtime-scripts.md).
