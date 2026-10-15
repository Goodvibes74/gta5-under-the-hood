# Text and names in content

How a model gets the name players see ("Obey 9F" rather than `ninef`): the label fields in `vehicles.meta` and `weapons.meta`, where those labels are stored, how DLC packs register theirs, how scripts turn a model into a name, and what an add-on pack needs so its content isn't shown as "NULL". Roadmap topic **R14.4** in the [roadmap](/ROADMAP.md). Builds on text labels (R8.3: the `.gxt2` format and the text slots), [DLC packs and their vehicles](/docs/entities/vehicles/dlc-packs.md) and [archives and content](/docs/core/archives-and-content.md).

**How it was made.** The update copy of `common:/data/levels/gta5/vehicles.meta`, the update copy of `common:/data/ai/weapons.meta`, and every `vehicles.meta` and `weapon*.meta` in the DLC packs were extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does). The American text (`update\update2.rpf` and every DLC pack's `americandlc.rpf`) was read with a small `.gxt2` reader. Each `gameName`, `vehicleMakeName` and `HumanNameHash` was hashed (Jenkins one-at-a-time, lower case) and looked up in the base `global.gxt2`, the DLC `global.gxt2` files and all other text blocks. Native use from the [VEHICLE](/scripting/native-usage/VEHICLE.md), [HUD](/scripting/native-usage/HUD.md), [ZONE](/scripting/native-usage/ZONE.md) and [PATH](/scripting/native-usage/PATH.md) usage pages (decompile commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; how the game falls back when a label is missing is **Known**.

## Short version

- **A model's name is a label, not text.** `vehicles.meta` gives each vehicle a `gameName` (the model's name label, `NINEF`) and a `vehicleMakeName` (the maker's label, `OBEY`); `weapons.meta` gives each weapon a `HumanNameHash` (`WT_PIST`). The text lives in `global.gxt2` (`NINEF` is "9F", `OBEY` is "Obey", `WT_PIST` is "Pistol").
- **879 vehicle models** in the base and DLC `vehicles.meta` files (38 files). 875 have a name label that exists: 294 base-game models in the base global table, 551 DLC models in their packs' global tables, and 30 that use a label from the other table. Only 4 have no text at all (`freighttrailer`, `proptrailer`, `docktrailer`, `tanker2`: trailers nobody sees named).
- **The label is usually the model name.** For 716 of 879 vehicles `gameName` equals the model name in upper case; the rest reuse another model's label (variants that share a name) or a shortened one.
- **65 makers** (`VAPID` 71 models, `DECLASSE` 64, `BRAVADO` 37, `KARIN` 32, `PEGASSI` 29 ...); 13 make labels have no text.
- **170 weapon entries** carry a `HumanNameHash`: 130 found in the text, 37 deliberately empty (`WT_INVALID` or blank: ammo-less internal weapons), 3 missing.
- **Scripts look names up by model:** `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL` (122 scripts, 1,293 calls) returns the `gameName` label; `GET_MAKE_NAME_FROM_VEHICLE_MODEL` (45 scripts) the maker; the text comes from the label like any other (`GET_FILENAME_FOR_AUDIO_CONVERSATION` returns a label's text in 450 scripts).
- **Other content names** follow the same pattern: vehicle mods (`GET_MOD_TEXT_LABEL`, 440 scripts), mod slots (`GET_MOD_SLOT_NAME`, 23), liveries (`GET_LIVERY_NAME`, 7), map zones (`GET_NAME_OF_ZONE`, 93), clothing and tattoos (shop metadata labels read through `GET_SHOP_PED_COMPONENT`, 569 scripts, and `GET_TATTOO_SHOP_DLC_ITEM_DATA`, 451).

## Where names come from

| Content | Field (file) | Lookup native | Count (build 3725) |
| --- | --- | --- | --- |
| Vehicle | `gameName` (`vehicles.meta`) | `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL` | 879 models, 875 with text |
| Vehicle maker | `vehicleMakeName` (`vehicles.meta`) | `GET_MAKE_NAME_FROM_VEHICLE_MODEL` | 65 makers |
| Vehicle mod part | `modShopLabel` per mod (`carcols.meta`, **Known**) | `GET_MOD_TEXT_LABEL` | R14.1 |
| Livery | Livery names (`carcols.meta` and the vehicle's textures, **Known**) | `GET_LIVERY_NAME` | |
| Weapon | `HumanNameHash` (`weapons.meta`) | The weapon wheel and HUD read it (**Known**) | 170 entries, 130 with text |
| Weapon component | `LocName` / `LocDesc` (weapon component files, **Known**) | | R3.1 |
| Clothing, tattoo | Labels in the shop metadata (`SHOP_PED_APPAREL_META_FILE`, 83 DLC entries; tattoo files, 28) | `GET_SHOP_PED_COMPONENT`, `GET_TATTOO_SHOP_DLC_ITEM_DATA` | R6.3 |
| Map zone | Zone label (`popzone.ipl`, **Known**) | `GET_NAME_OF_ZONE` | R4.6 |
| Street | Street name hashes in the road nodes (**Known**) | `GET_STREET_NAME_AT_COORD`, `GET_STREET_NAME_FROM_HASH_KEY` | R17.5 |
| Ped, prop | No display name | | |

### Vehicles in numbers

| Source | Models | Label in base `global.gxt2` | In a DLC `global.gxt2` | Missing | `gameName` = model name |
| --- | ---: | ---: | ---: | ---: | ---: |
| Base `vehicles.meta` (update copy) | 298 | 294 | 1 | 3 | 205 |
| 37 DLC `vehicles.meta` files | 581 | 29 | 551 | 1 | 511 |
| Total | 879 | 323 | 552 | 4 | 716 |

29 DLC vehicles use a base-game label: DLC variants of base vehicles (a new version of an old car keeps the old name). The DLC global tables together hold 49,457 labels.

## How a DLC pack registers its names

**Verified (data):** a pack that adds named content ships three pieces:

1. Its `vehicles.meta` (or weapon file) with `gameName` / `HumanNameHash` set to a label.
2. A `global.gxt2` in `x64/data/lang/americandlc.rpf` (and one per other language) with that label. 42 vanilla packs carry a DLC `global.gxt2`.
3. A `dlctext.meta` (`hasGlobalTextFile` true) listed in `content.xml` as `TEXTFILE_METAFILE` (38 packs have the file, 40 entries use the type), so the game loads the pack's text.

**Known (engine):** when a label isn't found, the HUD shows the word "NULL" for a vehicle name, and the weapon wheel shows an empty name. `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL` returns the label name ("CARNOTFOUND" when the model isn't known), never the text; scripts and mods turn it into text with a second call.

## What this means for modders

- **Name your add-on vehicle** by setting `gameName` in its `vehicles.meta` to a new label (keep it short and unique, often the model name in upper case, as Rockstar does 716 times) and adding that label to a `global.gxt2` in your pack's `americandlc.rpf`, with a `dlctext.meta` and a `TEXTFILE_METAFILE` line in `content.xml`. Without the text you get "NULL".
- **Reusing a base label** (`gameName` set to an existing name such as `BANSHEE`) gives your car a name at once, but it shows the other car's name.
- **Makers:** use an existing maker label (`VAPID`, `DECLASSE`, `PEGASSI` ...) so the name reads "Maker Model" without extra text.
- **Read a name in a script:** `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model)` gives the label; show it with a text command (`BEGIN_TEXT_COMMAND_DISPLAY_TEXT(label)`), or get the string with the label-text native your library provides (ScriptHookVDotNet's `Game.GetLocalizedString`, **Known**).
- **Don't replace Rockstar's `global.gxt2`** to name add-ons; your pack's own text file survives updates, a replaced global table doesn't.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The `NULL` fallback and the "CARNOTFOUND" return, confirmed in game | Test card 1 |
| Which 13 maker labels have no text and whether anything shows them | Second pass |
| How mod-part and livery labels are named and registered | R14.1 |
| Load order when two packs define the same label | R8.3 second pass, in-game test |

## Test cards

1. **Missing label.** Add a vehicle whose `gameName` has no text and enter it. Expected: "NULL" in the vehicle name popup.
2. **Name lookup.** For `ninef`, print `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL` and the label's text. Expected: `NINEF` and "9F".
3. **DLC text loads.** Enter a DLC car from a vanilla pack in story mode. Expected: its name shows, read from the pack's own `global.gxt2`.
