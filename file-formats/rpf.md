# RPF archives

Rockstar's archive format (version 7 on PC). Almost all game data lives in RPFs.

| Archive | Holds |
| --- | --- |
| `common.rpf` | Base data files (`data\...`) |
| `x64a.rpf` to `x64w.rpf` | The world, models, textures, audio |
| `update\update.rpf` | Newer copies of base files, `dlc_patch` folders, `dlclist.xml` |
| `update\update2.rpf` | The compiled scripts (`.ysc`) |
| `update\x64\dlcpacks\<pack>\dlc.rpf` | Each DLC pack |

**Encryption.** Rockstar's archives encrypt their entry tables and each file. CodeWalker (and the `rpf-cw.ps1` tool) decrypts in memory with the keys from your own game files. Archives saved by OpenIV and most add-on packs are "OPEN" (unencrypted table) and can be read by the dependency-free `rpf.ps1`.

**Editing.** Never edit the originals. OpenIV's mods folder keeps edited copies that the game loads instead (through `OpenIV.asi`). Add-on content goes in its own DLC pack listed in `dlclist.xml`.

Tools: [`/tools`](/tools). The content system (which archive wins, how DLC overrides base data) is roadmap topic R1.6.
