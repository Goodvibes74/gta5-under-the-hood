# Online cosmetics and the shops that sell them

How GTA Online sells and applies every cosmetic on the freemode character: barber shops (hair, hair colour, beards, eyebrows, chest hair, contact lenses, face paint, make-up), clothes stores and the mask shop, hats, glasses and the other props, tattoo parlours, and how the result is saved and put back on. A story-mode project that wants working salons, clothes stores and tattoo parlours for a freemode character can rebuild them from these tables. Roadmap topic **R6.7** in the [roadmap](/ROADMAP.md). Builds on [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) (R6.3: component slots, head overlays, the catalogue files and their natives), [the Online character creator](/docs/gameplay/player/online-character-creator.md) (R6.5: overlay and eye-colour tables, the face stats) and [story systems in an Online mode](/docs/online/story-systems-in-online-mode.md) (R5.7: `shop_controller` keeps running).

**How it was made.** Read in the build-3725 decompile (commit `6c18d3e8b`): `hairdo_shop_mp` (207,815 lines), `clothes_shop_mp` (369,468), `tattoo_shop` (140,783), `shop_controller` (450,585) and `am_pi_menu` (616,806, for the interaction menu's accessories). Every string literal in the four shop scripts (21,778) was looked up as a text label in the American text: all 610 base blocks in `update\update2.rpf` and the 279 American blocks of the DLC packs, extracted with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and matched by Jenkins hash ([text labels](/docs/ui/text-labels.md)); 10,205 resolved. Barber prices were computed by reading each item's price expression and putting in the default of every tunable it uses, taken from `tuneables_processing` (34,910 tunables with a default). The clothing catalogue is every `mp_m_freemode_01_*_shop.meta` and `mp_f_freemode_01_*_shop.meta` in the DLC packs, with the `update\update.rpf` `dlc_patch` copy replacing the pack's own where one exists (86 files, read as XML); the tattoo catalogue the same way for `shop_tattoo.meta` (31 files). The stats come from `common\data\mpstatssetup.xml` in `update\update.rpf`. Counts, labels, prices, positions and file fields are **Verified** in build 1.0.3725.0 Legacy; what something looks like in game is **Known** unless stated. Decompiler names (`func_690`, `Global_262145`) are pointers for this build only.

## Short version

- **Four kinds of cosmetic shop, 35 places, one launcher.** `shop_controller` starts `hairdo_shop_mp` for 9 barbers, `clothes_shop_mp` for 18 clothes and mask stores and `tattoo_shop` for 8 tattoo parlours (in story mode the `_sp` versions; tattoo is one script for both). Each shop has a fixed index, name label and position (table below).
- **The barber menu has nine pages:** Hairstyles, Beards, Eyebrows, Chest, Contacts, Face Paints, and a Makeup page holding Blusher, Eye and Lipstick. Men get all but Blusher; women get no Beards and no Chest. The penthouse and mansion barbers drop Chest, Contacts and Face Paints.
- **512 barber items, every one priced.** Hairstyles 47 male and 49 female ($0 to $6,980), beards 30 ($150 to $5,000), eyebrows 35 ($500 to $1,050), chest hair 18 ($1,100 to $2,650), contact lenses 32 ($4,500 to $20,000), face paints 93 ($100 to $42,750), blusher 8, eye make-up 26, lipstick 11. A price is a base dollar figure times a tunable (default 1), or a tunable on its own.
- **What a barber item sets:** a hairstyle is a drawable in component slot 2; beards, eyebrows, chest hair and every kind of make-up and face paint are head overlays (1, 2, 10, 4, 5 and 8); contact lenses are an eye colour, not an overlay. Hairstyles come with **hair fades** on the scalp: tattoo-style decorations (`NG_M_Hair_001` ... in `multiplayer_overlays`, DLC ones in each pack's tattoo file).
- **The clothing catalogue is 36,232 items in 86 pack files** (male 790 outfits, 14,090 components, 2,566 props; female 777, 15,513, 2,496). 84% of them have `cost` 0 in the file: in Online the store script prices them itself, from 17,411 price lines keyed by the item's **text label**, each reading a tunable, then multiplied by per-update sale tunables.
- **Stores differ by layout, not by stock file.** All catalogue items say `CLO_SHOP_LOW`; the store index picks the interior (`v_clotheslo`, `v_clothesmid`, `v_clotheshi`), the clerk model and the browse spots ("Press ~a~ to browse jackets"), each a position, radius and menu.
- **Wearing rules are tags.** The catalogue carries 510 restriction tag names as plain text (`HAT`, `HELMET`, `SHRINK_HEAD`, `HOOD_UP`, `BLOCK_GLASSES` ...); the shop scripts test 466 of them by hash. `hat` and `hair_shrink` decide when hair is swapped for a version that fits under a hat or mask.
- **Tattoos: 1,194 DLC tattoos (597 per gender) in six zones** (Torso, Head, Left Arm, Right Arm, Left Leg, Right Leg), plus the script's own list of 0 to 128 per character. Removing one is free. The same files hold 1,380 T-shirt prints, 92 hair fades and 36 rank badges.
- **Saving:** ownership and "seen" flags are packed into stat arrays (`CLTHS_AVAILABLE_*`, `CLTHS_ACQUIRED_*`, `DLC_APPAREL_ACQUIRED` 319 ints, `TATTOO_FM_UNLOCKS` 54 ints, `CHAR_HAIR_UNLCK` 18), 20 outfit slots, and the current hair in `CHAR_FM_STORED_HAIRDO`. All are Online character stats; offline, a mod keeps its own copy.

## The shop table

`shop_controller` holds one entry per shop (indices 0 to 64). The script that runs it, its name label and its position come from three switch tables in the script (**Verified**); the interior name from a fourth. Cosmetic shops:

| Index | Script | Name (label) | Position | Interior |
| ---: | --- | --- | --- | --- |
| 0 | hairdo | Bob Mulét Hair & Beauty (`S_H_01`) | -822.0, -187.2, 36.6 | `v_hairdresser` |
| 1 | hairdo | Herr Kutz Barber (`S_H_02`) | 133.6, -1710.9, 28.3 | `v_barbers` |
| 2 | hairdo | Beachcombover Barbers (`S_H_03`) | -1287.1, -1116.6, 6.0 | `v_barbers` |
| 3 | hairdo | O'Sheas Barbers (`S_H_04`) | 1933.1, 3726.1, 31.8 | `v_barbers` |
| 4 | hairdo | Herr Kutz Barber (`S_H_05`) | 1208.3, -470.9, 65.2 | `v_barbers` |
| 5 | hairdo | Hair On Hawick Barbers (`S_H_06`) | -30.7, -148.5, 56.1 | `v_barbers` |
| 6 | hairdo | Herr Kutz Barber (`S_H_07`) | -280.8, 6231.8, 30.7 | `v_barbers` |
| 50 | hairdo | Penthouse Barber (`S_H_08`) | the owner's casino penthouse | spa |
| 62 | hairdo | Mansion Barber (`S_H_09`) | offset from the owner's mansion | |
| 7, 8, 10, 11, 13 | clothes | Discount Store (`S_CL_01`, `_02`, `_04`, `_05`, `_07`) | 80.7, -1391.7 · 1687.9, 4820.6 · -1094.0, 2704.2 · 1198.0, 2704.2 · -0.2, 6516.0 | `v_clotheslo` |
| 9, 12 | clothes | Binco Clothing (`S_CL_03`, `_06`) | 419.5, -807.6 · -818.6, -1077.5 | `v_clotheslo` |
| 14 to 17 | clothes | Suburban (`S_CM_01`, `_03`, `_04`, `_05`) | -1199.8, -776.7 · 618.2, 2752.6 · 126.7, -212.5 · -3169.0, 1055.3 | `v_clothesmid` |
| 18 to 20 | clothes | Ponsonbys (`S_CH_01` to `_03`) | -715.4, -155.8 · -158.2, -305.0 · -1455.0, -233.2 | `v_clotheshi` |
| 21 | clothes | Vespucci Movie Masks (`S_CA_01`) | -1336.0, -1278.6, 3.9 | (none named) |
| 51 | clothes | Casino Store (`S_CL_09`) | inside the casino | |
| 55 | clothes | Merch Shop (`S_CL_10`) | -2194.1, 1103.8, -24.2 | |
| 57 | clothes | Record A Studios (`S_CL_11`) | inside the studio | |
| 22 | tattoo | Blazing Tattoo (`S_T_01`) | 321.6, 179.4, 102.6 | `v_tattoo` |
| 23 | tattoo | Alamo Tattoo Studio (`S_T_02`) | 1861.7, 3750.1, 32.0 | `v_tattoo2` |
| 24 | tattoo | Paleto Tattoo Studio (`S_T_03`) | -290.2, 6199.1, 30.5 | `v_tattoo2` |
| 25 | tattoo | The Pit (`S_T_04`) | -1153.9, -1425.0, 4.0 | `v_tattoo` |
| 26 | tattoo | Los Santos Tattoos (`S_T_05`) | 1322.5, -1651.1, 51.2 | `v_tattoo` |
| 27 | tattoo | Ink Inc Tattoos (`S_T_06`) | -3169.4, 1074.7, 19.8 | `v_tattoo` |
| 54 | tattoo | LS Car Meet Tattoos (`S_T_07`) | -2159.9, 1075.2, -25.4 | |
| 63 | tattoo | Mansion Tattoo Parlor (`S_T_08`) | offset from the owner's mansion | |

The rest of the table is Ammu-Nation (28 to 38, 11 stores), the armouries in the MOC, Avenger, Terrorbyte, arena, arcade, Kosatka and agency and the Gun Van (46 to 49, 52, 53, 56, 58 to 61, 64), and the vehicle mod shops (39 to 45: four Los Santos Customs, Beeker's Garage, Benny's, and 45, the workshop of whichever vehicle property the player is in). Ammu-Nation shops also start `clothes_shop_mp` as a second script (they sell tops and boiler suits). The four interior barbers, clothes and tattoo shops (50, 51, 54, 55, 57, 62, 63) only exist while their property or venue does.

`shop_controller` requests and starts each shop's script while the shop is open and the player qualifies, passing the shop index (and whether it is the second script) as the argument (**Verified**); how near the player must be was not read in this pass.

## Barber shops (`hairdo_shop_mp`)

### Menus

The top page (`HAIR_NG_T0` "CATEGORIES") lists seven entries in this order; Makeup opens a second page with three. Which entries a model gets is a fixed table in the script (**Verified**):

| Page | Label | Male | Female | Penthouse and mansion |
| --- | --- | :-: | :-: | :-: |
| Hairstyles | `HAIR_NG_O1` | yes | yes | yes |
| Beards | `HAIR_NG_O2` | yes | no | yes |
| Eyebrows | `HAIR_NG_O3` | yes | yes | yes |
| Chest | `HAIR_NG_O4` | yes | no | no |
| Contacts | `HAIR_NG_O5` | yes | yes | no |
| Face Paints | `HAIR_NG_O6` | yes | yes | no |
| Makeup | `HAIR_NG_O7` | yes | yes | yes |
| Makeup > Blusher | `HAIR_NG_O8` | no | yes | yes |
| Makeup > Eye | `HAIR_NG_O9` | yes | yes | yes |
| Makeup > Lipstick | `HAIR_NG_O10` | yes | yes | yes |

An entry shows as new (a star) when an unseen item in it has unlocked, and greyed when nothing in it can be bought. Inside a page the item rows show the price; colour pages add a palette row with `FACE_COLOUR` "Color (n of n)", `FACE_COLHILI` "Highlights" (hair) and `FACE_OPAC` "Opacity" (overlays). The number of colours comes from the game, not the script: `GET_NUM_PED_HAIR_TINTS` (hair, beards, eyebrows, chest) and `GET_NUM_PED_MAKEUP_TINTS` (blusher, lipstick) (**Verified** calls; the counts themselves are **Known**: 64 each).

Messages: `HAIR_AFF_1` to `_9` ("Sorry - you cannot afford this beard / hairstyle / makeup / item"), `HAIR_CUR_*` (already owned), `HAIR_UNLOCK` ("This item will unlock when you reach Rank ~1~"), `HAIR_LOCK` (unavailable), `HAIR_SALE` (a sale is on).

### What each item is

Every item is a small record built by one of two helpers: a **hair** record (price, label, drawable, item hash) or an **overlay** record (price, label, overlay index, overlay value, opacity, unlock id, item hash). An overlay index of 7 is used as a marker for an eye colour rather than overlay 7 (**Verified**: the helper switches the record type when it sees 7).

| Page | What it sets | Index or slot | Items M / F | Price range (defaults) |
| --- | --- | --- | ---: | --- |
| Hairstyles | Component slot 2 (hair) drawable | slot 2 | 47 / 49 | $0 to $6,980 (male base styles $170 to $1,980) |
| Beards | Head overlay | 1 | 30 / 0 | $150 to $5,000 |
| Eyebrows | Head overlay | 2 | 35 / 35 | $500 to $1,050 |
| Chest | Head overlay | 10 | 18 / 0 | $1,100 to $2,650 |
| Contacts | Eye colour (`SET_HEAD_BLEND_EYE_COLOR`) | 0 to 31 | 32 / 32 | $4,500 to $20,000 |
| Face Paints | Head overlays 4 (67) and 5 (26) | 4, 5 | 93 / 93 | $100 to $42,750 |
| Blusher | Head overlay | 5 | 0 / 8 | $0 to $1,000 |
| Eye make-up | Head overlay | 4 | 26 / 26 | $100 to $2,000 |
| Lipstick | Head overlay | 8 | 11 / 11 | $0 to $1,050 |

The first 23 male and 24 female hairstyles carry the old `CC_M_HS_n` / `CC_F_HS_n` labels (the launch set and the first updates: Shorter Cut, Braided Mohawk ...); later ones take the pack's own label (`CLO_S1M_H_0_0` for Lowriders, `CLO_BIM_H_0_0` for Bikers ...) and find their drawable by the catalogue name (`dlc_mp_low_m_hair0_0`), so a DLC hairstyle stays correct when packs shift drawable numbers (**Verified**). Face paints and eye make-up share overlay 4: values 0 to 41 are make-up, 42 and up are the Halloween and later face paints (`CC_MKUP_42` "Shadow Demon", $12,950).

Prices: base styles are a fixed figure times a per-style tunable (`male_hair_close_shave_expenditure_tunable` and so on, default 1); DLC items read a tunable that holds the price itself (`dlc_male_hair_shaggy_curls_black` 570, `eyebrows_quizzical` 915, `halloween_2015_shadow_demon` 12,950), often times a per-update multiplier (`lowrider_male_and_female_hair_all_hair`, `male_and_female_hair_all_hair`). Two Diamond Casino hairstyles cost 0.

### Hair fades

Each hairstyle comes with a scalp decoration so short styles show a fade line. They live in the same decoration system as tattoos (`ADD_PED_DECORATION_FROM_HASHES`, [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md#101-short-version)) and in the same per-character tattoo list, typed `hairOverlay` (**Verified**):

- Base styles: `multiplayer_overlays` / `NG_M_Hair_001` to `_015` and `NG_F_Hair_001` to `_015`, plus `NGBea_`, `NGBus_`, `NGHip_` and `NGInd_` ones for the Beach, Business, Hipster and Independence styles (57 `hairOverlay` rows in the script's list across both genders, some `not_in_use`).
- `mpBeach_overlays` / `FM_Hair_Fuzz` (list slot 123): stubble for a shaved head, added unless the head zone already has one.
- Later packs list theirs in `shop_tattoo.meta` with `updateGroup` `hairOverlay` (92 items in all packs).

### The chair

The barber is `s_m_m_hairdress_01` (`s_f_m_fembarber` at Bob Mulét's); the player sits through `misshair_shop@barbers` or `misshair_shop@hair_dressers` (`player_enterchair`, `keeper_hair_cut_a` / `_b`, `player_exitchair`), the penthouse spa uses `anim@amb@luxury_suite@spa@barbers`. A scripted camera follows the animation's phase, and the menu lets the player move the camera and zoom (`ITEM_MOV_CAM`, `ITEM_ZOOM`). A barber who sees a weapon or is shot at cowers (`react_cowering`) and the shop closes (`SHOP_CLOSED`) (**Verified** names).

## Clothes stores and the mask shop (`clothes_shop_mp`)

### Browsing

There is no single counter menu. Each store has browse spots, each a position, a trigger radius, a help text and a menu: `CSHOP_TRY_J` "Press ~a~ to browse jeans", `_SHO` shoes, `_JK` jackets, `_SU` suits, `_HAT` hats, `_GLS` glasses, `_MASK` masks, `_OUT` outfits and more (34 `CSHOP_TRY_` labels). The counter spot (`CSHOP_BRO_OUT` "Go to the counter to browse outfits") opens outfits. The spots and the clerk change with the interior: `v_clotheslo` (Discount Store and Binco, clerk `s_f_y_shop_low`), `v_clothesmid` (Suburban, `s_f_y_shop_mid`), `v_clotheshi` (Ponsonbys, `s_f_m_shop_high`), the mask shop (`s_m_y_shop_mask`) (**Verified**). The shop's menu titles come from a 617-label table (`CSHOP_ITEM0` to `_349` and others: "Sweaters", "Fitted Caps, Backward", "Outfits: Heist Tuxedos" ...).

### Where the items come from

1. **Base items** (the launch wardrobe): for each model and slot the script knows how many drawables are base ones (a fixed table, **Verified**); their labels and prices are in script tables not read in this pass.
2. **DLC items** are read from the catalogue with `SETUP_SHOP_PED_APPAREL_QUERY_TU(character, 11, locate, props, -1, component type)` and `GET_SHOP_PED_QUERY_COMPONENT` / `_PROP` (12 query calls, 805 `GET_SHOP_PED_COMPONENT` calls). The item's `locate` number puts it on a menu.
3. **Price:** in Online the item's `textLabel` is hashed and looked up in 38 price functions (17,411 cases, each a tunable such as `Global_262145.f_16119`), then multiplied by the sale tunable of the update that added it (`CU_VAL_CLOTHES`, `CU_INDI_CLOTHES`, `CU_LOW_CLOTHES` ... with separate multipliers per slot), and doubled in one special case. Outside Online the `cost` field is used. Outfits are cheaper by what the player already owns (`CSHOP_OUTFIT_DI`).

### The catalogue in numbers

Every pack file read, `dlc_patch` copies winning (**Verified**):

| | Male | Female |
| --- | ---: | ---: |
| Outfits | 790 | 777 |
| Components | 14,090 | 15,513 |
| Props | 2,566 | 2,496 |
| Packs with a shop file | 43 | 43 |

By slot (both models): tops `JBIB` 9,686, undershirts `ACCS` 4,428, hats `ANCHOR_HEAD` 3,549, masks `BERD` 3,095, legs 2,925, shoes 2,597, arms `UPPR` 2,307, bags and parachutes `HAND` 1,806, outfits 1,567, accessories `TEEF` 1,235, decals 1,192, glasses 869, watches 317, hair 199, earrings 186, bracelets 141, armour 133.

- **Cost in the file:** 30,524 of 36,232 items say 0; the rest range up to $696,969 (a hair joke item). The script's price wins in Online.
- **Locks:** 65 distinct `lockHash` values, one per update (`CU_GUNRUN_CLOTHES` 4,005 items, `CU_ARENA_CLOTHES` 1,996, `CU_X22_CLOTHES` 1,993 ...), 6,068 items with none. The shop checks them with `IS_CONTENT_ITEM_LOCKED`.
- **Every item says `CLO_SHOP_LOW`.** The tier field isn't used to split stock between stores in this build.
- **30,940 items carry restriction tags, 10,764 force other components** (a jacket that forces its arms).

### Wearing rules: restriction tags

The tag names are plain text in the catalogue (`<tagNameHash>HAT</tagNameHash>`), so no hash guessing is needed: 510 distinct names. The busiest: `LONG_SLEEVE` 11,522, `OUTFIT_CHECKS` 11,294, `JACKET` 8,119, `BLOCK_SCARFS` 7,628, `BLOCK_CHAINS` 6,768, `UNDER_JACKET` 6,704, `HEIST_GEAR` 4,929, `HAT` 4,581, `GLOVES` 4,341. Head-related: `SHRINK_HEAD` 3,958, `HOODED_JACKET` 3,278, `FITTED_HOOD` 3,102, `HELMET` 2,336, `HOOD_UP` 1,414, `HOOD_HAT` 1,408, `BACKWARDS_HAT` 1,148, `BLOCK_GLASSES` 792, `ALT_HELMET` 764, `SKI_MASK` 336, `SHRINK_HAIR` 208, `BIG_MASK` 104, `GAS_MASK` 20 (**Verified** counts).

The shop and wardrobe scripts ask `DOES_SHOP_PED_APPAREL_HAVE_RESTRICTION_TAG` (4,222 calls in `clothes_shop_mp`, 1,776 in `hairdo_shop_mp`) and `DOES_CURRENT_PED_COMPONENT_HAVE_RESTRICTION_TAG` before showing or combining an item. Examples read in `shop_controller` (**Verified** reading): masks from drawable 26 up that are tagged `hat` or `hair_shrink` are excluded from a check other masks pass; putting on a hat takes off a worn mask tagged `hair_shrink` unless the hat is tagged `shrink_hair`; hats from drawable 26 up are tested for `shrink_head`. What each tag blocks in detail is spread over hundreds of checks (open question below).

### Saved outfits

20 slots (`CSHOP_SAVE_OUT` "EDIT SAVED OUTFITS"), each with a name, saved from what the player wears; save, delete and rename (`ITEM_SAVE`, `ITEM_DEL`, `ITEM_REN`). The interaction menu reads the same slots (`PIM_HOUTF` "Select a saved outfit to wear").

## Hats, glasses, masks and other props

Props are the five anchors of [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md#102-component-slots-and-prop-anchors): head (hats and helmets), eyes, ears, left and right wrist. Masks are not props but component slot 1 (`BERD`), sold at Vespucci Movie Masks and on the mask racks of clothes stores. Half masks are a separate page in the interaction menu.

The interaction menu's Appearance page (`PIM_TSTYL`) lets the player cycle what they own without a shop: Accessories (`PIM_TACCE`), Hats (`PIM_THELM`), Helmets (`PIM_THELM1`), Helmet Visor, Glasses, Masks, Half Masks, Earrings, Chains, Gloves, Bike Helmet, Auto Equip Bike / Aircraft Helmet, Outfit and Stunt Racing Outfit, with refusals when an outfit, the Beast or a job forbids it (`PIM_HACCEG`, `_HACCEB`, `_HACCEP`) (**Verified** labels).

## Tattoo parlours (`tattoo_shop`)

- **Six zone pages:** Torso, Head, Left Arm, Right Arm, Left Leg, Right Leg (`TAT_ZONE_0` to `_5`), plus crew emblems (`TAT_FMM_CLB` "Crew Emblem Back"; locked by crew rank, `TAT_CREW`).
- **Two sources.** The script's own list (indices 0 to 128 per character: story characters' `singleplayer_overlays` tattoos, and for freemode `multiplayer_overlays` ones such as `TAT_FM_TAT1` and award tattoos like "Trust No One" for the Car Bomber award) and the DLC list from `shop_tattoo.meta`, read with `GET_NUM_TATTOO_SHOP_DLC_ITEMS` / `GET_TATTOO_SHOP_DLC_ITEM_DATA` and numbered from 129 up.
- **The DLC files:** 2,702 rows in 31 files: 1,194 real tattoos (597 male `TATTOO_MP_FM`, 597 female `TATTOO_MP_FM_F`, in 20 packs), 1,380 T-shirt prints (`torsoDecal`), 92 hair fades, 36 rank badges. By zone the tattoos split Torso 544, Right Arm 182, Left Arm 154, Head 122, Left Leg 98, Right Leg 80. Each row has `cost`, `textLabel`, `collection`, `preset`, `zone`, `updateGroup` (the body region: `BACK_FULL`, `CHEST_LEFT`, `ARM_RIGHT_FULL_SLEEVE` ... 60 regions), `eFaction` and `lockHash`. 690 tattoos have a price in the file (the median over all 1,194 is $6,400).
- **Removal is free:** the remove branch clears the owned bit, plays `Tattooing_Oneshot_Remove` and reapplies the rest; that branch takes no money (**Verified**).
- **Putting tattoos back:** one routine walks list slots 0 to 126, then slot 123's hair fuzz, then every DLC item, and adds each owned one with `ADD_PED_DECORATION_FROM_HASHES`, skipping DLC items whose lock is still on. It is called from the barber, clothes and tattoo scripts alike; `CLEAR_PED_DECORATIONS` wipes tattoos, fades and T-shirt prints together, so all three must be put back after a clear (**Known**).
- The artist is `s_m_m_tattoo_01`, animations `misstattoo_parlour@shop_ig_4`, `_4b`, `_5_b`.

## How it is saved

From `mpstatssetup.xml` (**Verified** names; all are per-character Online stats):

| Stats | What they hold |
| --- | --- |
| `CLTHS_AVAILABLE_<slot>`, `CLTHS_ACQUIRED_<slot>`, `CLTHS_USED_<slot>` (HAIR, JBIB, LEGS, FEET, BERD 8 each; TEETH 3; SPECIAL 9; PROPS 11) | Bit fields: which base items are unlocked, bought and seen |
| `DLC_APPAREL_ACQUIRED_0` to `_318`, `DLC_APPAREL_USED_*` (319 each) | The same for DLC items, as packed bits |
| `TATTOO_FM_UNLOCKS_*`, `TATTOO_FM_CURRENT_*`, `TATTOO_FM_VIEWED_*` (54 each) | Tattoos owned, worn and seen, one bit per list slot |
| `CHAR_HAIR_UNLCK_*`, `CHAR_HAIR_VIEWED_*` (18 each), `CHAR_FM_HAIRCUT_1_UNLCK` | Barber items unlocked and seen |
| `CHAR_FM_STORED_HAIRDO`, `CHAR_FM_FORCED_HAIR_ITEM`, `CHAR_FM_FORCED_HAIR_TYPE` | The current haircut and a hair forced by an outfit |
| `CHAR_FM_CLOTHES_1_UNLCK` to `_11_UNLCK` | Clothing unlock groups |
| `SHOPFM_HAIRDO_01_BH` ... `SHOPFM_CLOTHES_L_01_SC` ... `SHOPFM_TATTOO_01_HW` ... `SHOPFM_TYPES_VISITED` | Which shops have been visited (one per shop) |
| `HEADBLEND_*`, `HAIR_TINT`, `EYEBROW_TINT` | Face, overlay values and colours ([creator](/docs/gameplay/player/online-character-creator.md#what-is-saved)) |

The shop scripts write through `STAT_SET_INT` on the stat for the current character slot and the packed-stat natives (`PACKED_STAT_GET_INT_STAT_INDEX` 33 calls in each of the barber and clothes scripts). A purchase in Online also goes through the server shop (`NETWORK_BUY_ITEM`, catalogue checks with `NET_GAMESERVER_CATALOG_ITEM_IS_VALID`), which story mode doesn't have ([stats and tunables](/docs/online/stats-and-tunables.md)).

## What this means for modders

- **Rebuild the shops, don't launch Rockstar's.** The `_mp` shop scripts read tunables, server-backed stats and the network shop; offline none of that is there. The tables above (pages per gender, overlay indices, item counts, price formulas) are enough to rebuild a barber, a clothes store and a tattoo parlour in a mod menu, at the same 35 places.
- **Barber:** hair drawable in slot 2 plus `SET_PED_HAIR_TINT(ped, colour, highlight)`; beards, eyebrows, chest hair, make-up and face paint with `SET_PED_HEAD_OVERLAY(ped, index, value, opacity)` and `SET_PED_HEAD_OVERLAY_TINT` (colour type 1 for hair-coloured overlays, 2 for make-up, **Known**); contact lenses with `SET_HEAD_BLEND_EYE_COLOR`. Add the matching hair fade with `ADD_PED_DECORATION_FROM_HASHES(ped, joaat("multiplayer_overlays"), joaat("NG_M_Hair_00n"))`, and reapply tattoos afterwards.
- **Clothes:** walk the catalogue with the query natives, take the slot, drawable and texture from `GET_SHOP_PED_COMPONENT`, and use the file's `cost` or your own price list; the Online prices are tunables a mod can copy as defaults. Respect `forcedComponents` and the restriction tags, or tops float and masks clip.
- **Keep your own save:** owned items as item hashes (`uniqueNameHash`), not drawable numbers, which move when packs are added.
- **Order matters on load:** clothes, then hair and its fade, then overlays and tints, then tattoos and T-shirt prints last, since clearing decorations removes all three kinds.
- **On a low-end PC:** preload clothing (`SET_PED_PRELOAD_VARIATION_DATA`) before showing it, and build menu lists once per page, not every frame; the catalogue has 18,000 items per gender.

## Open questions

| Question | Where it goes |
| --- | --- |
| What each restriction tag blocks or forces, as a table (hat with hood, glasses with masks ...) | Next pass, the tag checks in `shop_controller` |
| The full `locate` number to menu title map, and why a few menus appear only in some store layouts | Next pass, `clothes_shop_mp` menu builder |
| The base-wardrobe tables (labels and prices of the non-DLC clothes) | Next pass |
| Which barber items need a rank, and the ranks | Next pass, the unlock checks behind `HAIR_UNLOCK` |
| The hair and make-up colour counts on this build | In-game test, `GET_NUM_PED_HAIR_TINTS` / `GET_NUM_PED_MAKEUP_TINTS` |
| Which hair fade goes with which hairstyle (the barber adds one when a style is bought) | Next pass, the hairstyle-to-list-slot mapping in `hairdo_shop_mp` |

## Test cards

1. **Barber pages per gender (story mode, a freemode ped, single player only).** With a mod menu, read `GET_NUM_PED_HAIR_TINTS` and `GET_NUM_PED_MAKEUP_TINTS`; then set overlay 1 (beard) on `mp_f_freemode_01`: nothing should show, which is why the shop hides Beards for women.
2. **Hair fade.** On `mp_m_freemode_01` with a short hairstyle, add `multiplayer_overlays` / `NG_M_Hair_001`: a fade line should appear on the scalp; `CLEAR_PED_DECORATIONS` removes it together with any tattoo. Which fade belongs to which hairstyle is an open question.
