# Glossary

Words used across the guides.

| Term | Meaning |
| --- | --- |
| **ASI** | A native plug-in (`.asi`, really a DLL) loaded into the game by an ASI loader (`dinput8.dll`) |
| **ScriptHookV (SHV)** | The plug-in every script mod depends on: it lets mods call natives from the game's script thread. C++ mods use it directly |
| **ScriptHookVDotNet (SHVDN)** | A ScriptHookV plug-in that runs C# and VB mods (`scripts\*.dll`, `*.cs`). API versions v2 (legacy) and v3 |
| **Native** | One of about 6,700 engine functions that scripts and mods call (`ENTITY::SET_ENTITY_COORDS`). Identified by a 64-bit hash |
| **YSC** | A compiled game script (`.ysc`), bytecode for the game's script VM. 1,143 of them in build 3725 |
| **Decompile** | YSC turned back into readable C-like code by a community decompiler. Rockstar's code: read, never copy |
| **Script thread** | A running script. Cooperative: it runs until it calls `WAIT`, then the next one runs |
| **Stack pool** | Fixed sets of script stacks of fixed sizes (`gameconfig.xml`); a script can only start if a stack of its size is free |
| **Global / global block** | Script memory shared by all scripts, split into blocks each owned by one registration script. Indices change every build |
| **Static / local** | Memory private to one script |
| **Broadcast data** | Globals synced between players in Online: player broadcast data (per player) and server or host broadcast data |
| **Tunables** | Values Rockstar's servers send to Online scripts (prices, switches). Read by scripts from a global block |
| **Force cleanup** | A signal that asks scripts to stop, as a bit mask (bit 2 ends story mode on the way to Online) |
| **Script brain** | A rule that starts a script when the player comes near a place, object or ped |
| **Flow / strand** | The story mode program that unlocks missions: 32 strands of commands run by `flow_controller` |
| **RPF** | Rockstar's archive format. `common.rpf` holds base data, `update\update.rpf` newer copies, `x64*.rpf` the world and models |
| **DLC pack** | `update\x64\dlcpacks\<name>\dlc.rpf`, listed in `dlclist.xml`. Each update adds packs; `dlc_patch` folders patch older ones |
| **Mods folder** | OpenIV's copy of archives in `mods\`, so edits never touch the originals |
| **Meta** | XML data files (`handling.meta`, `weapons.meta`, `vehicles.meta` ...) |
| **YMT / PSO** | Binary metadata files (`pedpersonality.ymt`); CodeWalker can convert many to XML |
| **YMAP / YTYP** | Map placement files and archetype (object type) definitions |
| **IPL** | A named group of map placements that scripts turn on and off (`REQUEST_IPL`), used for interiors and map states |
| **UGC** | User-generated content: the JSON format of mission-creator jobs, also used for Rockstar's own jobs |
| **Handling** | A vehicle's physics data in `handling.meta` |
| **Decision maker** | The table that maps events (shots, explosions) to a ped's reaction |
| **Verified / Known** | Verified: read in the game files or a decompile of the stated build. Known: community knowledge not checked |
| **Legacy / Enhanced** | The two PC editions. These guides cover Legacy (`GTA5.exe`) |
