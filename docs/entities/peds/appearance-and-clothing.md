# Appearance and clothing

How a ped's look is built and how the shops sell it: the 12 component slots and the prop anchors, the freemode models `mp_m_freemode_01` and `mp_f_freemode_01`, head blend, overlays and face shape, tattoos and printed decals, the shop catalogue files (`*_shop.meta`, `shop_tattoo.meta`) and the `EXTRAMETADATA` natives that read them, and the shop scripts. Roadmap topic **R6.3** in the [roadmap](/ROADMAP.md). Builds on [story systems in an Online mode](/docs/online/story-systems-in-online-mode.md) (the story shops keep running) and [native usage](/scripting/native-usage.md).

**How it was made.** `mp_m_freemode_01_mpheist4_shop.meta` and `shop_tattoo.meta` extracted from the `mpheist4` pack with `tools/rpf-cw.ps1` and their fields counted; the list of shop files in `update\update.rpf` (`dlc_patch` copies, listed with `tools/rpf-cw.ps1`, pattern `*shop*.meta`); native use from [`tools/native-usage.ps1`](/scripting/native-usage.md); the shop scripts' sizes from the build-3725 decompile. Slot and overlay index meanings are community knowledge (**Known**); counts, file fields and script use are **Verified**. First pass: the shop scripts' internals (menus, prices, locks) are for a second pass.

## 10.1 Short version

- **A ped's clothes are 12 component slots plus props.** Each slot holds a drawable (the model piece) and a texture (its colour variant): `SET_PED_COMPONENT_VARIATION(ped, slot, drawable, texture, palette)` (100,960 calls in 628 scripts). Props (hats, glasses, ears, watches, bracelets) attach to anchors: `SET_PED_PROP_INDEX` / `CLEAR_PED_PROP` (558 and 539 scripts).
- **The shop files name the slots** `PV_COMP_HEAD`, `BERD` (masks), `HAIR`, `UPPR` (arms/torso skin), `LOWR` (legs), `HAND` (bags, parachutes), `FEET`, `TEEF` (accessories like chains), `ACCS` (undershirts), `TASK` (armour), `DECL` (decals), `JBIB` (jackets and tops), and the prop anchors `ANCHOR_HEAD`, `ANCHOR_EYES`, `ANCHOR_EARS`, `ANCHOR_LEFT_WRIST`, `ANCHOR_RIGHT_WRIST` ...
- **Online characters are two models,** `mp_m_freemode_01` and `mp_f_freemode_01`, with a face made by **head blend** (`SET_PED_HEAD_BLEND_DATA`: two parent heads, two skins, mix values; 439 scripts), **overlays** (`SET_PED_HEAD_OVERLAY` and `_TINT`: facial hair, eyebrows, make-up, ageing ...), **face shape** (`SET_PED_MICRO_MORPH`, 1,326 calls), hair colour (`SET_PED_HAIR_TINT`) and eye colour (`SET_HEAD_BLEND_EYE_COLOR`). `FINALIZE_HEAD_BLEND` and `HAS_PED_HEAD_BLEND_FINISHED` close the edit.
- **Tattoos and printed T-shirt logos are the same system:** "decorations" from overlay collections (`mpHeist4_overlays` ...) added with `ADD_PED_DECORATION_FROM_HASHES` (87,505 calls in 450 scripts). The heist4 pack's `shop_tattoo.meta` lists 178 items, 138 of them torso decals (`torsoDecal`): shirt prints.
- **The shop catalogue is data, read through natives.** Each pack has `mp_m_freemode_01_<pack>_shop.meta` and `mp_f_..._shop.meta` (`ShopPedApparel`: outfits, components and props with price, text label, unique name hash, shop type, lock hash, restriction tags, forced components, variants). Scripts query them with `SETUP_SHOP_PED_APPAREL_QUERY_TU`, `GET_SHOP_PED_QUERY_COMPONENT`, `GET_SHOP_PED_COMPONENT` (259,881 calls) and `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG` (790,263 calls, the single busiest metadata native).
- **One pack in numbers (`mpheist4`, male):** 708 shop entries, 28 outfits, 680 components and props, 681 with restriction tags (1,685 tags), 616 with forced components, all in the `CLO_SHOP_LOW` shop.
- **The shops are big scripts:** `clothes_shop_mp` 369,468 lines, `clothes_shop_sp` 358,312, `hairdo_shop_mp` 207,815, `hairdo_shop_sp` 172,118, `tattoo_shop` 140,783, `wardrobe_mp` 509,421, `wardrobe_sp` 508,761, all started through `shop_controller` (450,585).
- **Load before you dress:** `SET_PED_PRELOAD_VARIATION_DATA` / `HAS_PED_PRELOAD_VARIATION_DATA_FINISHED` / `RELEASE_PED_PRELOAD_VARIATION_DATA` (324 scripts) and the prop equivalents stream clothing before it's shown, so the ped never appears half-dressed.

## 10.2 Component slots and prop anchors

| Slot | Shop name | What it holds (**Known**) | In `mpheist4` male shop file |
| ---: | --- | --- | ---: |
| 0 | `PV_COMP_HEAD` | Head (face model) | |
| 1 | `PV_COMP_BERD` | Masks, beards on story peds | 99 |
| 2 | `PV_COMP_HAIR` | Hair style (barber) | |
| 3 | `PV_COMP_UPPR` | Arms and torso skin (matches the top) | 171 |
| 4 | `PV_COMP_LOWR` | Legs | 31 |
| 5 | `PV_COMP_HAND` | Bags and parachutes | 100 |
| 6 | `PV_COMP_FEET` | Shoes | 32 |
| 7 | `PV_COMP_TEEF` | Accessories (chains, ties, scarves) | 179 |
| 8 | `PV_COMP_ACCS` | Undershirts | 244 |
| 9 | `PV_COMP_TASK` | Body armour | 28 |
| 10 | `PV_COMP_DECL` | Decals, badges | 83 |
| 11 | `PV_COMP_JBIB` | Tops and jackets | 227 |

| Prop anchor | Index (**Known**) | In the same file |
| --- | ---: | ---: |
| `ANCHOR_HEAD` (hats, helmets) | 0 | 78 |
| `ANCHOR_EYES` (glasses) | 1 | 51 |
| `ANCHOR_EARS` | 2 | |
| `ANCHOR_LEFT_WRIST` (watches) | 6 | 13 |
| `ANCHOR_RIGHT_WRIST` (bracelets) | 7 | 13 |

## 10.3 The shop file

One `<Item>` in `pedComponents` or `pedProps` (fields counted in the heist4 male file, 708 entries):

| Field | What it is |
| --- | --- |
| `lockHash` | The unlock that makes it available (`CU_HEIST4_CLOTHES`); checked with `IS_CONTENT_ITEM_LOCKED` (630 scripts) |
| `cost` | Price in dollars |
| `textLabel` | Name shown in the shop (a GXT label, e.g. `CLO_H4M_O_SM_M1`) |
| `uniqueNameHash` | The item's identity (`DLC_MP_H4_M_OUTFIT_SM_M1`), used in saves and to look it up |
| `eShopEnum` | Which shop sells it (`CLO_SHOP_LOW`, and the other shop tiers in other packs) |
| `locate` | Menu position |
| `drawableIndex`, `localDrawableIndex`, `textureIndex`, `eCompType` / `propIndex`, `eAnchorPoint` | What it actually puts on the ped |
| `restrictionTags` | Tags that say what it can't be worn with (`tagNameHash`, 1,685 in this file); `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG` checks them |
| `forcedComponents`, `forcedProps` | What must change with it (a jacket that forces the matching arms in slot 3) |
| `variantComponents`, `variantProps` | Alternatives (open/closed jacket) |
| `isInOutfit`, `scriptSaveData` | Outfit membership, script-saved flags |

`pedOutfits` (28 here) bundle components and props under one price and name. Story-mode characters have their own catalogue for `player_zero`, `player_one`, `player_two` (`clothes_shop_sp`).

## 10.4 How scripts read the catalogue

1. `SETUP_SHOP_PED_APPAREL_QUERY_TU(character, shop, locate, ...)` sets up a query; `GET_SHOP_PED_QUERY_COMPONENT` / `_PROP` / `_OUTFIT` walk the results.
2. `INIT_SHOP_PED_COMPONENT` / `_PROP` prepare a struct; `GET_SHOP_PED_COMPONENT(nameHash, &struct)` fills it from the item's hash; `GET_HASH_NAME_FOR_COMPONENT(ped, slot, drawable, texture)` goes the other way, from what a ped wears to the item hash.
3. Forced and variant parts: `GET_SHOP_PED_APPAREL_FORCED_COMPONENT_COUNT` / `GET_FORCED_COMPONENT`, `GET_SHOP_PED_APPAREL_VARIANT_COMPONENT_COUNT` / `GET_VARIANT_COMPONENT`.
4. Restrictions: `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG(itemHash, tagHash)` and `DOES_CURRENT_PED_COMPONENT_HAVE_RESTRICTION_TAG(ped, slot, tag)`.
5. Tattoos: `GET_NUM_TATTOO_SHOP_DLC_ITEMS(character)` and `GET_TATTOO_SHOP_DLC_ITEM_DATA(character, index, &struct)` read `shop_tattoo.meta`; `ADD_PED_DECORATION_FROM_HASHES(ped, collection, preset)` applies one.

These are the natives that make `EXTRAMETADATA` the fourth-busiest namespace by calls ([native usage](/scripting/native-usage.md#93-the-namespaces-in-numbers)).

## 10.5 Where the shop files are

| Place | Files |
| --- | --- |
| Each DLC pack's `dlc.rpf` (`common\data\`) | `mp_m_freemode_01_<pack>_shop.meta`, `mp_f_freemode_01_<pack>_shop.meta`, `shop_tattoo.meta`, `pedalternatevariations.meta` (heist4: 29 KB), `overlayinfo.xml` |
| `update\update.rpf` `dlc_patch\<pack>\` | Patched copies for older packs (`mp2023_01`, `mp2023_02`, `mp2024_01`, `mp2024_02`, `mpairraces`, `mpassault`, `mpbattle`, `mpbeach` ...) |

A full per-pack list of shop files is still to make (10.7).

## 10.6 What this means for modders

- **Dress through the catalogue, not by numbers:** item hashes (`uniqueNameHash`) survive updates and DLC order; raw drawable indices for DLC clothes shift when packs are added (**Known**). `GET_SHOP_PED_COMPONENT` turns a hash into slot, drawable and texture on the current build.
- **Honour forced components and restriction tags,** or tops float over the wrong arms and masks clip through hats.
- **Preload, then apply:** `SET_PED_PRELOAD_VARIATION_DATA`, wait for `HAS_PED_PRELOAD_VARIATION_DATA_FINISHED`, apply, then `RELEASE_PED_PRELOAD_VARIATION_DATA`.
- **Faces need the full sequence:** head blend, then overlays and tints, then micro morphs, eye colour, hair and hair tint, `FINALIZE_HEAD_BLEND`, and wait for `HAS_PED_HEAD_BLEND_FINISHED` before a cutscene clones the ped ([cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md)).
- **A mod's own clothes and barber shops:** build the clothes shop on `SETUP_SHOP_PED_APPAREL_QUERY_TU` and `GET_SHOP_PED_COMPONENT` over the freemode catalogue (every pack is already installed and active), prices from `cost`, locks from `lockHash` checked against the mod's own progression instead of `IS_CONTENT_ITEM_LOCKED`; the barber from the hair slot, `SET_PED_HAIR_TINT` and the facial-hair, eyebrow and make-up overlays; tattoos and T-shirt prints from `GET_TATTOO_SHOP_DLC_ITEM_DATA`. Block the story shops at the same spots ([story systems in an Online mode](/docs/online/story-systems-in-online-mode.md)).

## 10.7 Open questions

| Question | Where it goes |
| --- | --- |
| Inside `clothes_shop_mp`: menu structure, how it applies an item, what it saves | Second pass |
| Inside `hairdo_shop_mp`: which overlays and tints it offers per gender | Second pass |
| The overlay index list (0 to 12) and micro-morph list (0 to 19), checked against the creator | Answered from the creator's tables in [the Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5); in-game check still open |
| The restriction tag names (hashes to names) | Second pass |
| How many packs carry shop files, and how many items in all (a one-process scan of all 89 packs; one CodeWalker start per pack is too slow) | Second pass, extend [`tools/dlc-scan.ps1`](/tools/README.md) |
