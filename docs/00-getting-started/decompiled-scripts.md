# Reading the decompiled game scripts

Most of what GTA V does in story mode and GTA Online is written in Rockstar's own script language, compiled into `.ysc` files. Community decompilers turn those into readable C-like code with every native call named. They are the main source for understanding how a system really works. They are Rockstar's code: read them, quote names and numbers, describe the logic in your own words, and never copy the code into this repo or into a mod.

## Where to get them

The community keeps a decompile of every game update in public git history (for example the `calamity-inc/GTA-V-Decompiled-Scripts` repository on GitHub). Clone it once with its history; each commit is one game build. A decompile contains:

| Folder | What it is |
| --- | --- |
| `decompiled_scripts/*.c` | One decompiled script per file, natives named (`NETWORK::NETWORK_IS_GAME_IN_PROGRESS()`) |
| `native_tables/*.txt` | Each script's native table as raw hashes |
| `scripts/*_ysc/*.ysc.full` | The raw compiled scripts the decompile was made from |

## Match the build

Use the commit for your exact game build. The guides here are written against **build 1.0.3725.0 (Legacy)**, which is the commit titled "Update for 1.72-3725.0". You can prove a match: decrypt the scripts from your own `update\update2.rpf` (with CodeWalker or the `rpf-cw.ps1` tool in [`/tools`](/tools)) and compare their SHA-256 with the `.ysc.full` files in that commit. For build 3725 all 1,143 scripts matched byte for byte. A later build (3889) recompiled every script and added 13.

Even with an exact match:

- **Global indices (`Global_2739327`), function numbers (`func_6694`) and local numbers** are produced by the decompiler and change with every build. Use them only as pointers inside one build; don't build mods on them.
- **Logic, flow, coordinates, model names, text labels and animation names** are exactly what that build of the game runs.

## How to search it

Read one build from git history without checking it out (no extra disk space):

```bash
cd GTA-V-Decompiled-Scripts
C=<commit of your build>
git grep -l "NET_GAMESERVER_BASKET_START" $C -- decompiled_scripts | wc -l     # which scripts use a native
git grep -n -- "-197.3405" $C -- decompiled_scripts/am_mp_property_ext.c        # where a coordinate is used
git show $C:decompiled_scripts/clothes_shop_mp.c | sed -n 98980,99000p          # read part of a script
git diff <old build> <new build> -- decompiled_scripts/clothes_shop_mp.c        # what an update changed
```

The files are huge (`freemode.c` is about 31 MB and 1.47 million lines), so search rather than open them. A `git grep` over every script takes one to two minutes.

## First findings (build 3725)

All **Verified** in the build-3725 decompile.

**How much of Online depends on the network layer:**

| Native | Scripts using it | Meaning |
| --- | --- | --- |
| `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT` | 423 | Script runs as a network script |
| `NETWORK_REGISTER_HOST_BROADCAST_VARIABLES` | 360 | Keeps state in host-synced memory |
| `NETWORK_REGISTER_PLAYER_BROADCAST_VARIABLES` | 354 | Keeps per-player synced state |
| `STAT_GET_INT` | 792 | Reads stats (shared helper code is compiled into most scripts) |
| `NET_GAMESERVER_BASKET_START` | 291 | Contains the server purchase flow |
| `UGC_*` | 142 | Reads or queries mission-creator content |
| `NETWORK_ACCESS_TUNABLE_INT_HASH` | 21 | Reads tunables directly; most scripts read tunables from globals that a few scripts fill |

**`freemode` is started by `maintransition`**, with a stack of 35,250; the content creator starts `"Creator"` with 28,000. `freemode` registers as a network script for up to 32 players. See [Inside freemode](/docs/online/07-freemode.md).

**A shop purchase on PC (`clothes_shop_mp`).** On PC the script uses server transactions: it ends any open basket, calls `NET_GAMESERVER_BASKET_START`, adds the item (`NET_GAMESERVER_BASKET_ADD_ITEM`), checks out (`NET_GAMESERVER_CHECKOUT_START`) and waits for the result. Spending is reported with `MONEY::NETWORK_SPENT_*`. Without a server this flow never completes, which is why offline projects charge money in their own code.

**The property table (`am_mp_property_ext`).** One function maps each property index to its entrance: index 8 is `284.96, -159.99, 63.62`, 12 is `-197.34, 88.11, 68.74`, 14 is `-973.38, -1429.43, 6.68`, and so on. These match the `AM_MP_PROPERTY_EXT` trigger points in `ambient_mp.ipl`. The script checks `NETWORK_IS_GAME_IN_PROGRESS()` in several places and uses globals on more than 11,000 lines, which is why it can't simply run offline.

## Good scripts to read next

| Topic | Scripts |
| --- | --- |
| Shops | `clothes_shop_mp`, `hairdo_shop_mp`, `tattoo_shop`, `shop_controller` |
| The in-game internet | `appinternet` |
| The pause-menu map | `pausemenu_multiplayer`, `freemode` blip handling |
| Garages and apartments | `am_mp_property_ext`, `am_mp_property_int`, `am_mp_garage_control` |
| Personal vehicles | `freemode` (search `PERSONAL_VEHICLE`) |
| Mission-creator jobs | `fm_mission_controller` |
| Heists | `fm_content_island_heist` and the heist planning scripts |
