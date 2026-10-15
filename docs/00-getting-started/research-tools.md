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
| `native-usage.ps1` | Names every script's native table from NativeDB and counts calls per native and per script; writes the [native usage index](/scripting/native-usage-index.md) and the per-namespace pages, or answers one query (`-Native`, `-Script`) | About two minutes |
| `ugc-keys.ps1` | Counts the key paths in extracted `.ugc` mission files ([UGC format](/file-formats/ugc-json.md)) | Seconds |
| `check-system.ps1` | Checks a PC for what the game and the modding tools need (`-Dev` for the build tools) | Seconds |

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

## Techniques that need no new tool

These came out of the second round of topics (R2.5, R2.6, R3.5, R3.8, R4.3, R5.8, R6.2, R6.4, R8.3, R9.3, R13.2, R13.3, R13.5, R14.4). Each was done with a few lines of PowerShell or Python around the same CodeWalker library; keep such helpers in your scratch folder, not in the repo.

| Need | How | Used for |
| --- | --- | --- |
| Read a binary `.ymt`, `.rel` or binary `.meta` | Extract it with CodeWalker.Core and call `CodeWalker.GameFiles.MetaXml.GetXml(entry, bytes, out name)`; it returns XML | `cameras.ymt`, `explosion.ymt`, `animpostfx.ymt`, `playerinfo.ymt`, `popgroups.ymt`, `game.dat151.rel` |
| Turn `hash_XXXXXXXX` back into names | Hash every string literal in the decompile (`git grep -h -o` for quoted strings) and every name in the extracted XML with Jenkins one-at-a-time on the lower-case string, and replace the matches. Resolves most script-facing names, few internal ones | Post effects, radio stations, health configs |
| Count across every archive | Walk every `.rpf` (root `x64*.rpf`, `common.rpf`, `update\update*.rpf`, every `update\x64\dlcpacks\*\dlc*.rpf`) with `RpfFile.ScanStructure` and write one line per entry: archive, size, inner path (about 385,000 lines, a few minutes) | Particle dictionaries, text files, control files |
| Count things inside map files | Load each `.ymap` with `YmapFile.Load(bytes, entry)` and read `CarGenerators`, `TimeCycleModifiers`, `AllEntities`; when one name exists in several archives, count only the winning copy (update over DLC over base) | Car generators (R4.3) |
| Read text | A `.gxt2` is `2TXG`, a count, then (hash, offset) pairs and null-terminated UTF-8 strings. The current American text is in `update\update2.rpf`, DLC text in each pack's `americandlc.rpf` | Text labels (R8.3), names (R14.4) |
| Count what scripts pass to a native | `git grep -o -E` for `NS::NAME("...` (or a number pattern) over the decompile at the pinned commit, then count per value and per script. Literal arguments only, so treat the counts as a floor | Weather names, control IDs, music events, shake names |
| Name a numbered enum the game doesn't ship | Read it from an API's assembly metadata (for example ScriptHookVDotNet's `GTA.Control` with `ReflectionOnlyLoadFrom`) without running anything; say which version and where its list ends | Control IDs (R6.4) |
| Compare base and update | Extract the same path from `common.rpf` and `update\update.rpf` (or the `x64` base archive and `update2.rpf`) and diff; the update copy wins | Every data topic |

## Research a topic in an hour

1. **Read the row and what exists (5 min).** The roadmap row's "What to find out", the folder README, and every guide that mentions the topic ID (`git grep -n "R4.3"`). Note what is already answered.
2. **Find the files (10 min).** Search the full archive listing for the system's names (`weather`, `explosion`, `control` ...). Extract the update copy and the base copy; convert binary metadata to XML and resolve hashes.
3. **Find the natives (5 min).** Open the namespace page in [native usage](/scripting/native-usage.md) (or the [namespace map](/scripting/native-namespace-map.md)) and list the natives for the system with their script and call counts.
4. **Find the scripts (15 min).** `git grep -l` the busiest natives to find who owns the system; read only the functions around the calls (`git show <commit>:decompiled_scripts/<name>.c` piped to `sed -n`). Count literal arguments for the natives that take names.
5. **Count (10 min).** Turn the files into tables: how many, the biggest, the defaults. Say how you counted.
6. **Write (15 min).** Copy the [entry template](/templates/entry-template.md): short version first, then where it lives, how it works, how scripts use it, what it means for modders, open questions, test cards. Mark every claim **Verified** or **Known**; keep decompiler names as pointers only.
7. **Finish.** Update the roadmap row, "What is done", the counts and the folder README; check links; scan the diff for code, extracted files and personal paths.

## Open tooling work

1. ~~Naming the native calls in compiled scripts.~~ Done for the decompile by `native-usage.ps1` (R0.3); naming them in raw `.ysc` files without a decompile is still open.
2. ~~Mapping the mission-creator (UGC) format.~~ First pass done in R7.4 with `ugc-keys.ps1`.
3. **A read-only lister for `.ypt` particle dictionaries** (effect names inside each), for R13.3's second pass.
4. **A hash-name dictionary built from the decompile**, kept outside the repo, so every tool resolves the same names.

## After a game update

1. Check that ScriptHookV supports the new build (`ScriptHookV.log`); that is the usual breakage.
2. Re-run `dlc-scan.ps1` for new packs.
3. Re-run `ysc-dump.ps1` and compare `_summary.tsv` with the previous run: new script names show new content; size changes show what Rockstar changed.
4. Re-extract the UGC folder and compare the file list.
5. Once a decompile of the new build exists, re-run `script-launch-graph.ps1` against it and compare the edges and stack sizes, and compare the `globalblock` lines of the script dump with the block table in [runtime scripts](/docs/core/runtime-scripts.md).
