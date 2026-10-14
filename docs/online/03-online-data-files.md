# Online data files on disk

What Online reads that is actually on disk in the PC game, where it is, and what each file is good for offline. Everything here is **Verified** unless marked otherwise. Paths are inside the archives; extract with `tools/rpf-cw.ps1` (guide 5).

## 3.1 Where Online content lives

| Kind | Location | Count |
| --- | --- | --- |
| Scripts (all logic) | `update\update2.rpf\x64\levels\gta5\script\script_rel.rpf` | 1,143 |
| Local mission files (UGC) | `update\update2.rpf\common\data\ugc\` | 1,001 |
| Stats definitions | `update\update.rpf\common\data\mpstatssetup.xml` (+ `mpstatscharactermappingdata.xml`, `ui\mpstatssetupui.xml`) | 17,933 stats |
| Preset outfits, apparel and property elements | `update\update.rpf\common\data\scriptmetadata.meta` | 3,868 outfits |
| Property and activity trigger points | `update\update.rpf\common\data\levels\gta5\ambient_mp.ipl` | 90 points |
| Vehicle mod catalogue (prices, unlocks) | `update\update.rpf\common\data\shop_vehicle.meta` | |
| Clothing catalogues (prices, unlocks) | each DLC's `mp_m_freemode_01_*_shop.meta` / `mp_f_freemode_01_*_shop.meta` (DLC packs and `update.rpf\dlc_patch\*`) | 3,395 items in Mercenaries alone |
| Vehicles | each DLC's `vehicles.meta` | 581 DLC models ([DLC packs](/docs/entities/vehicles/dlc-packs.md)) |
| Interiors and map changes | DLC and patch packs (`.ymap`, interior archives), toggled with IPLs | thousands |
| Cutscenes, animations, audio | DLC packs | |

## 3.2 Local mission files (UGC)

1,001 JSON files in Rockstar's mission-creator format (the same format as cloud jobs). File names are `<name>_<variant>_<language>.ugc` or `<name>_<language>.ugc`.

| Prefix | Files | Content (examples) |
| --- | --- | --- |
| `re_` | 180 | Freemode random events: armoured truck, army convoy, Cerberus, Christmas truck, crime scene |
| `salvage_` | 94 | Salvage Yard robberies (The Chop Shop): preps and finales (arena, cargo ship, casino, Mission Row, submarine) |
| `dispatch_` | 87 | Dispatch work: bomb, CCTV, drugs, heli, informant, prisoner transport |
| `xmas25_` | 73 | December 2025 update: firefighter odd jobs, survival |
| `sum25_` | 69 | Summer 2025 (Money Fronts): car wash jobs, Higgins chases and impounds |
| `prep_` | 66 | Diamond Casino Heist preps: disruption (armour, backup, weapons), equipment (torch, charges, fingerprint cracker) |
| `fixer_` | 62 | The Contract: security contracts (assault, protect, recovery, rescue, tail) |
| `xmas22_` | 50 | Los Santos Drug Wars: phone missions (crop dusting, drug lord, supply line), sell missions |
| `sum2_` | 50 | The Criminal Enterprises: Ammu-Nation, auto shop, bar resupply, drug problem, Juggernaut |
| `hacker_` | 42 | Agents of Sabotage (*probable*): preps and finales (plane, Tiki, whistle, Zancudo) |
| `daily_` | 40 | Daily bounty, stash house |
| `tuner_` | 39 | LS Tuners robbery preps (container manifest, IAA pass, inside man, key codes) |
| `smuggler_` | 35 | Smuggling resupply and operations (carrier, facility, airstrike) |
| `gr_` | 26 | Gunrunning |
| `arms_` | 20 | Arms trafficking (Cargobob, plane, Ratel, rival) |
| `bounty_` | 18 | Bottom Dollar Bounties targets |
| `bike_` | 14 | MC time trials |
| `dj_` | 12 | Nightclub DJ missions (Dr. Dre, Keinemusik) |
| `bb_` | 5 | Aircraft carrier, captured UFO, factory raid (Business Battles, *probable*) |
| hashed IDs | 13 + 3 | The Cayo Perico Heist finale in 13 languages; "Learning the Ropes" (Gerald's tutorial) solo and normal, and "All or Nothing" |
| test | 4 | `tutorial_mission_0`, `loadeddatatest1/3` |

**Format.** Top-level keys are `meta` (locations, vehicle hashes, weapons) and `mission`. `mission` holds sections such as `gen` (general settings and the title in `nm`), `cover`, `door`, `dprop` (props), `endcon` (end conditions and positions), and lists of peds, vehicles, objects, locations and rules. Coordinates are plain `x/y/z` objects. For example, the tutorial's drop-off point is `-61.6, -1513.7, 32.4`, next to Gerald's apartment.

**Offline use.** These files describe what to spawn, where, and the objectives. Rockstar's scripts play them; an offline player would need its own interpreter. Even without one, they are a ready source of authentic coordinates, vehicles, peds and objectives for hand-written missions.

## 3.3 Stats definitions

`mpstatssetup.xml` defines every Online stat: name, type (`int`, `float`, `bool`, `packed` bools or ints, dates, strings), save category, whether it is per character, `ServerAuthoritative`, and a comment.

- 17,933 stats; 13,630 server-authoritative; 17,177 per character.
- Packed stats store 64 booleans or 8 small integers each (`MP_PSTAT_BOOL0`, `TUPSTAT_INT2`) and hold most mission and unlock flags.
- **Offline use:** a map of everything Online tracks. When we add a system (properties, businesses, unlocks), this file says what state Rockstar keeps for it, so our save can hold the same thing.

## 3.4 Clothing catalogues

Each DLC has a male and a female `*_shop.meta`. Each entry is one item or outfit:

- `uniqueNameHash` (for example `DLC_MP_SUM23_M_OUTFIT_5`), `textLabel` (the name shown in the shop, for example `CLO_SCM_O_5`), `cost` (in dollars), `lockHash` (the unlock it needs, for example `CU_SUM23_CLOTHES_G9EC`), and the component slots it uses (`PV_COMP_UPPR`, `PV_COMP_LOWR`, `PV_COMP_FEET` ...).
- **Offline use:** the data source for real clothes shops: names, prices and categories come straight from Rockstar's catalogue instead of guessing drawable numbers.

## 3.5 Preset outfits and property elements (`scriptmetadata.meta`)

- `MPOutfitsData` (male and female): 3,868 preset outfits with component drawables, textures, props and tattoos. These are the heist, job and event outfits.
- `MPApparelData`: apparel definitions.
- `BaseElements` / `BaseElementLocationsMap`: placements inside properties, starting at `-795.2, 326.8, 207.0`, the Eclipse Towers custom apartment area.
- **Offline use:** outfits for AI players (roadmap phase 43) and crew outfits for missions, without hand-picking components.

## 3.6 Property entrances (`ambient_mp.ipl`)

A list of script trigger points placed in the world. When the player comes near one, the engine starts the named script.

| Script | Points | Meaning |
| --- | --- | --- |
| `AM_MP_PROPERTY_EXT` | 83 | Apartment and garage entrances across the map, for example `-197.3, 88.1, 68.7` and `-973.4, -1429.4, 5.2` |
| `AM_MP_CARWASH_LAUNCH` | 2 | Car washes |
| `ob_mp_bed_low`, `ob_mp_bed_med`, `ob_mp_shower_low`, `ob_mp_shower_med` | 4 | Low and medium apartment bed and shower activities |
| `am_cp_snitch` | 1 | Snitch activity |

**Offline use:** the exact entrance positions for garages and apartments. Rockstar's `am_mp_property_ext` won't run offline, but a mod can watch the same points.

## 3.7 Vehicle mod catalogue (`shop_vehicle.meta`)

Entries with `lockHash`, `nameHash`, `type` (`VMT_HORN`, ...) and `cost`. These are mod shop items and their unlocks. **Offline use:** prices and unlocks for the mod shop.

## 3.8 Other files

| File | What it is |
| --- | --- |
| `networkshop.meta` | Transaction and action type hashes for the server shop; no prices |
| `tunableobjects.meta` | Physics tuning for 212 objects; not the cloud tunables |
| `communitystats.meta` | Community (server-wide) stats definitions |
| `cloudkeyframes.xml` | Cloud (sky) animation keyframes; not network related |
