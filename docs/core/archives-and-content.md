# Archives and the content system

How GTA V decides what to load: RPF archives, the DLC pack list, each pack's `setup2.xml` and `content.xml`, the order in which packs override each other, what OpenIV's mods folder does, and the difference between add-on and replacement mods. Roadmap topic **R1.6** in the [roadmap](/ROADMAP.md). Builds on the pack inventory in [DLC packs](/docs/entities/vehicles/dlc-packs.md) and the [RPF format page](/file-formats/rpf.md).

**How it was made.** `common\data\dlclist.xml` was extracted from the vanilla `update\update.rpf` and from a modded copy in OpenIV's mods folder, and `setup2.xml` (plus `content.xml` for two packs) from 8 vanilla DLC packs and 12 add-on packs of a test install, with the read-only [RPF tools](/tools/README.md). The setup fields were read with PowerShell's XML parser. **Verified** unless marked **Known**.

## 8.1 Short version

- **Everything ships in RPF archives:** the base game (`common.rpf`, `x64a.rpf` to `x64w.rpf`), the title update (`update\update.rpf`, `update2.rpf`) and one `dlc.rpf` per DLC pack. Archives nest (a `dlc.rpf` holds `vehicles.rpf`, interiors and map archives).
- **`dlclist.xml` decides which packs exist.** It lives in `update.rpf` (`common\data\dlclist.xml`) and lists 98 packs in vanilla build 3725 (the first four as `platform:/dlcPacks/...` inside the base archives, the rest as `dlcpacks:/...`). A pack not in the list never loads.
- **Each pack describes itself in `setup2.xml`:** its device name (`dlc_<name>:/`), its type (compat pack, level pack, paid pack), its **order**, and the change-set groups it takes part in. **`content.xml`** lists its files with a type for each (`VEHICLE_METADATA_FILE`, `HANDLING_FILE`, `RPF_FILE`; 39 types in one big pack) and which change sets enable them.
- **Order decides who wins:** packs load in their `order`, and for files that replace or overlay the same data, the higher order wins (**Known**). Vanilla packs use orders up to 55 (build 3725's newest pack, `mp2025_02_g9ec`); level packs (map patches) sit in the same range (`patch2025_02` is 41).
- **OpenIV's mods folder** (`Mods\`, via `OpenIV.asi`) makes the game read `Mods\<path>` instead of `<path>` for any archive that exists there. A modded copy replaces the **whole** archive, which is why a stale `update.rpf` hides an update's changes ([core guide 8](/docs/core/surviving-updates.md)).
- **Add-on vs replacement:** an add-on mod is a new DLC pack plus one line in `dlclist.xml`; it adds new names and survives updates. A replacement mod overwrites files inside a Rockstar archive (in the mods folder); it changes existing things and is lost or goes stale with every update.

## 8.2 The archives

| Archive | What's in it |
| --- | --- |
| `common.rpf` | Base data files (`common\data\...`): the original `handling.meta`, `weapons.meta`, `gameconfig.xml` and the rest, later overridden by the title update |
| `x64a.rpf` to `x64w.rpf` | Base platform assets: models, textures, map, audio, the first four DLC packs (`platform:/dlcPacks/mpBeach/` and so on, **Known**: they have no folder in `updateddlcpacks`) |
| `update\update.rpf` | The title update: newer copies of data files, compiled scripts (`script_rel.rpf`), `dlclist.xml`, `gameconfig.xml`, text |
| `update\update2.rpf` | A second title-update archive (later builds) |
| `update\x64\dlcpacks\<pack>\dlc.rpf` | One per DLC pack: `setup2.xml`, `content.xml`, data files, nested archives |
| `Mods\...` | OpenIV's mods folder: full copies of any of the above that a mod changed, plus add-on packs |

Rockstar's archives encrypt each file; add-on packs made with OpenIV usually don't ([RPF format](/file-formats/rpf.md)).

## 8.3 `dlclist.xml`

A plain list (`SMandatoryPacksData/Paths/Item`). Vanilla build 3725: **98 entries**, from `platform:/dlcPacks/mpBeach/` to `dlcpacks:/mp2025_02_g9ec/` (**Verified**). Paths are case-insensitive and accept both slash directions (a modded list with `dlcpacks:\<name>\` works).

**A healthy modded list** is the vanilla list, unchanged and in order, plus the add-on packs at the end. The test install's list was exactly that (98 vanilla entries plus 12 add-ons: cars, two map packs, a map remaster, a police overhaul in three packs, a zombie mod's pack) (**Verified**), even though other files in the same modded `update.rpf` came from an older build. Reading `dlclist.xml` is also the quickest way to find add-on packs nobody remembers installing: the test install had two.

## 8.4 `setup2.xml`: the pack's identity and order

| Field | Meaning |
| --- | --- |
| `deviceName` | The mount name: files are addressed as `dlc_<name>:/common/data/...` in `content.xml` |
| `datFile` | Usually `content.xml` |
| `type` | `EXTRACONTENT_COMPAT_PACK` (ordinary content), `EXTRACONTENT_LEVEL_PACK` (map and streaming patches, loaded early), `EXTRACONTENT_PAID_PACK` (`patchday1ng`, order -1) |
| `order` | Load order; later (higher) packs override earlier ones (**Known**) |
| `minorOrder` | Tie-breaker within an order |
| `contentChangeSetGroups` | Which phases the pack's change sets run in: `GROUP_EARLY_ON`, `GROUP_STARTUP`, `GROUP_MAP`, `GROUP_ON_DEMAND`, `GROUP_UPDATE_STREAMING`, `GROUP_TITLEUPDATE_STARTUP`, `GROUP_UPDATE_DLC_PATCH`, `GROUP_UPDATE_WEAPON_PATCH` ... |
| `dependencyPackHash`, `requiredVersion`, `subPackCount` | Pack dependencies and versions (empty in every pack read) |

**Orders in the test install (build 3725)** (**Verified**):

| Pack | Type | Order | Groups |
| --- | --- | --- | --- |
| `mpheist` (vanilla) | compat | 10 | startup, on demand, map |
| `mpchristmas2018` (vanilla) | compat | 32 | startup, on demand, map |
| `patch2025_02` (vanilla) | level | 41 | early on, update streaming |
| `mpchristmas3` (vanilla) | compat | 42 | startup, map |
| `mp2023_01` (vanilla) | compat | 44 | startup, map |
| `mp2025_02`, `mp2025_02_g9ec` (vanilla) | compat | 54, 55 | startup, map |
| An add-on prop and sound pack | compat | 1 | startup |
| Four add-on car packs (one with device name `dlc_xc40`, copied from another pack) | compat | 9 | startup |
| Another add-on car pack | compat | 13 | startup |
| Two forest map packs and a map remaster | level | 40, 50, 60 | early on, update streaming |
| Police overhaul, main pack | compat | 400 | startup, map |
| Police overhaul, vehicle expansion | level | 403 | ten groups, including title-update, weapon and DLC patch groups |
| Police overhaul, fixes pack | compat | 404 | startup, map |

Reading the table: the car packs use low orders because they only add new models; the police overhaul uses 400 to 404 so that its files beat every Rockstar pack; the map remaster at 60 beats Rockstar's own map patch (`patch2025_02`, 41), so where both change the same map area, the remaster's version shows. Four car packs share order 9 (harmless, they add different names). One car pack's device name is `dlc_xc40`, a name left over from the pack it was copied from, which is harmless unless a second pack uses the same device name.

## 8.5 `content.xml`: the file list

Each `dataFiles` item names a file in the pack and a `fileType` telling the engine which loader reads it; flags: `overlay` (merge over existing data instead of adding), `disabled` (off until a change set enables it), `persistent`, `locked`, `loadCompletely`, `contents` (`CONTENTS_DLC_MAP_DATA` for map archives). `contentChangeSets` then group the files (`<pack>_AUTOGEN` enables all the normal ones at start-up; map change sets enable map files).

| Pack | Files | Types |
| --- | --- | --- |
| A typical add-on car pack | 9 | `VEHICLE_LAYOUTS_FILE`, `VEHICLE_METADATA_FILE`, `CARCOLS_FILE`, `VEHICLE_VARIATION_FILE`, `TEXTFILE_METAFILE`, `HANDLING_FILE`, `VEHICLE_SHOP_DLC_FILE`, two `RPF_FILE`s (models, mod kit) |
| `mpchristmas3` (a Rockstar update) | 115 | 39 types: 58 `RPF_FILE`, 15 `DLC_ITYP_REQUEST`, weapons (`WEAPONINFO_FILE` x4, components, animations, pickups, shop info), peds and clothes, tattoos, audio (6 types), clip sets, explosions, loadouts, stats display |

An add-on car needs exactly the first set; most "my car is invisible / doesn't spawn" problems are a missing line in `dlclist.xml`, a `content.xml` path that doesn't match the archive, or a model name not in `vehicles.meta`.

## 8.6 How a file reaches the game

1. The engine mounts the base archives, then the title update (`update.rpf` overrides `common.rpf` files of the same path).
2. It reads `dlclist.xml` and mounts each listed pack's `dlc.rpf` as `dlc_<name>:/`.
3. Packs are sorted by `order`; each pack's change sets run in their group's phase (early on, then start-up, then map).
4. Each enabled `content.xml` entry is handed to its loader: data files merge or add (handling entries by name, vehicles by model name), archives are mounted for streaming.
5. With OpenIV, at every step, `X.rpf` is read from `Mods\X.rpf` if that file exists.

**Known** (to check): which file types merge (overlay) and which replace, and how two packs that both define the same vehicle or handling name resolve; this is R1.6's second pass.

## 8.7 What this means for modders

- **Prefer add-on packs to editing Rockstar's archives.** A new car, ped, weapon or data change in your own pack with one `dlclist.xml` line survives updates and can be switched off by removing the line.
- **Edit `dlclist.xml` only by appending.** The vanilla 98 entries must stay complete and in order; after a game update, compare the vanilla list with yours (the modded list should be vanilla plus your lines at the end).
- **Pick orders on purpose:** an add-on that only adds names can use a low order; one that must replace Rockstar data needs an order above Rockstar's newest pack (55 in build 3725, higher after updates).
- **Watch map packs with high orders:** a map remaster above Rockstar's map patches hides them. If a Rockstar map fix doesn't show, check the orders.
- **Keep a written list of your add-on packs** and check it against `dlclist.xml` now and then; packs installed long ago are easy to forget.

## 8.8 Open questions

| Question | Where it goes |
| --- | --- |
| Which data file types overlay (merge) and which replace; how duplicate names between packs resolve | Second pass (test with two packs defining the same handling name) |
| The exact load phases for each change-set group | Second pass, with R1.2 boot |
| What `update2.rpf` holds in build 3725 and why the mods folder has a copy | Second pass |
