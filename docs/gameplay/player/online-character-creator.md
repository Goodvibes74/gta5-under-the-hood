# The Online character creator

How GTA Online's character creator is built: where it lives, its seven menus, how heritage, face features, appearance and stats map onto natives and index numbers, the room and props it uses, and which stats keep the result. A story-mode or offline project that wants its own freemode character (or a "plastic surgeon") can rebuild the same editor from these tables. Roadmap topic **R6.5** in the [roadmap](/ROADMAP.md). Builds on [appearance and clothing](/docs/entities/peds/appearance-and-clothing.md) (R6.3: head blend, overlays, micro morphs, the shop catalogue), [transitions and sessions](/docs/online/transitions-and-sessions.md) (R7.2) and [stats, tunables and the server's role](/docs/online/stats-and-tunables.md) (R7.3).

**How it was made.** Read in the build-3725 decompile of `maintransition` (376,686 lines): the menu builders, the feature and appearance item tables, the stat-point limits, the room position and the props. Every `FACE_*`, `CHARC_*` and `CC_*` label the script names (370 labels) was looked up in the American `global.gxt2` from `update\update2.rpf` (extracted with [`tools/rpf-cw.ps1`](/tools/README.md); label names hashed with Jenkins one-at-a-time, as [text labels](/docs/ui/text-labels.md) explains). The stats come from `common\data\mpstatssetup.xml` in `update\update.rpf`. Frontend menu names were matched by hashing the candidate names. Counts, labels, indices, limits and positions are **Verified** in build 1.0.3725.0 Legacy; what a value looks like in game is **Known** unless stated.

## Short version

- **There is no separate creator script.** The character creator is part of `maintransition`, the script that also moves the player into and out of Online. It is drawn on the frontend as `FE_MENU_VERSION_MP_CHARACTER_CREATION` and filled with scaleform `SET_DATA_SLOT` / `UPDATE_SLOT` calls.
- **Seven top menu items, in this order:** Sex (`FACE_SEX`), Heritage (`FACE_HERI`), Features (`FACE_FEAT`), Appearance (`FACE_APP`), Apparel (`FACE_APPA`), Stats (`FACE_STATS`) and Save & Continue (`FACE_SAVE`).
- **Heritage is a head blend of a Mom and a Dad** with two 0 to 100 sliders, Resemblance (`FACE_H_DOM`) and Skin Tone (`FACE_H_STON`), both starting at 50. The portraits come from the texture dictionary `CHAR_CREATOR_PORTRAITS` (`Female_<n>`, `Male_<n>`, plus `Special_Female_<n>` / `Special_Male_<n>` for heads past the normal count).
- **Features are 20 face-shape sliders on 11 items,** each item a 1D or 2D grid that drives one or two micro-morph indices (0 to 19). The table below gives the exact index for every axis.
- **Appearance is 13 head overlays plus hair and eyes:** each item names its overlay index (0 to 12), its colour palette (hair tints or make-up tints) and its starting opacity (100, 50 or 25). There are 32 eye colours, from Green to Zombie.
- **Stats share 100 points across seven skills,** each with its own floor and cap: Stamina 5 to 30, Shooting 10 to 20, Strength 5 to 40, Stealth 5 to 25, Flying 5 to 60, Driving 5 to 50, Lung Capacity 5 to 40. Save is blocked until every point is placed (`FACE_W_1`), and the stats can't be changed when an existing character is edited (`FACE_STATS_H2`).
- **Apparel offers 64 starter outfits per sex** (`FACE_O_M_*`, `FACE_O_F_*`, 8 styles of 8), plus hats and glasses, a crew T-shirt in 11 styles and a crew emblem in 4 positions.
- **The room is the police line-up** at 409.02, -1000.8, -98.859, with `prop_police_id_board` and two text props per character, and the line-up and customise animations from the `mp_character_creation@...` dictionaries.
- **The result is kept in 63 character stats, 62 of them server-authoritative:** `HEADBLEND_*` (parents, mixes, overlay values), `FEATURE_0` to `FEATURE_20`, `HAIR_TINT`, `EYEBROW_TINT` and the stat points. Offline, nothing stores them, so a mod must keep its own copy.

## Where it lives

| Piece | Where | Count |
| --- | --- | --- |
| Creator logic, menus, room, save | `maintransition` (also the Online transition) | 376,686 decompiled lines |
| Frontend menu | `FE_MENU_VERSION_MP_CHARACTER_CREATION` (`ACTIVATE_FRONTEND_MENU`, 1 call) | 1 |
| Text | `FACE_*`, `FACES_*`, `CHARC_*`, `CC_*` labels in `global.gxt2` | 370 labels named by the script; 334 have text |
| Parent portraits | Texture dictionary `CHAR_CREATOR_PORTRAITS` | One texture per parent head |
| Animations | `mp_character_creation@lineup@male_a`, `_b`, `@lineup@female_a`, `_b`, `@customise@male_a`, `@customise@female_a` | 6 dictionaries, 31 uses |
| Props | `prop_police_id_board`, `prop_police_id_text`, `prop_police_id_text_02` | 3 models |
| Saved result | `common\data\mpstatssetup.xml` | 63 appearance and creator stats |

Natives in `maintransition` that build the face (counted calls): `SET_PED_HEAD_BLEND_DATA` 11, `UPDATE_PED_HEAD_BLEND_DATA` 2, `SET_PED_MICRO_MORPH` 13, `SET_PED_HEAD_OVERLAY` 18, `SET_PED_HEAD_OVERLAY_TINT` 6, `SET_HEAD_BLEND_EYE_COLOR` 3, `SET_PED_HAIR_TINT` 2, `SET_HEAD_BLEND_PALETTE_COLOR` 12, `FINALIZE_HEAD_BLEND` 13, `HAS_PED_HEAD_BLEND_FINISHED` 19, `GET_PED_HEAD_BLEND_FIRST_INDEX` 36 (types 0 and 1 twelve times each, 2 and 3 three times each), and the colour filters `IS_PED_HAIR_TINT_FOR_CREATOR` 5, `IS_PED_BLUSH_TINT_FOR_CREATOR` 2, `IS_PED_LIPSTICK_TINT_FOR_CREATOR` 2. The decompile writes some of these under their older names; the names here are NativeDB's.

## The menus

### Sex and Heritage

Sex switches between `mp_m_freemode_01` and `mp_f_freemode_01` (`FACE_MALE`, `FACE_FEMALE`). Heritage (`FACE_HERT`) has five rows: the two portraits, Mom (`FACE_MUMS`, help `CHARC_H_30` "Select your Mom."), Dad (`FACE_DADS`, `CHARC_H_31`), Resemblance (`FACE_H_DOM`, `CHARC_H_9` "Select if your features are influenced more by your Mother or Father.") and Skin Tone (`FACE_H_STON`, `FACE_HER_ST_H`).

- **Parent lists.** For each list the script asks `GET_PED_HEAD_BLEND_NUM_HEADS(type)` (type 0 for the Dad list, 1 for Mom). An index past that count is a "special" head, shown with the `Special_` portrait at index minus the count (**Verified**). Which faces the special heads are is **Known**: story-game characters added to the creator.
- **The blend.** The face is set with `SET_PED_HEAD_BLEND_DATA(ped, shape parent 1, shape parent 2, 0, skin parent 1, skin parent 2, 0, shape mix, skin mix, 0, ...)`: one call site passes the same two parents for shape and skin and leaves the third parent at 0 (**Verified**). Resemblance and Skin Tone are the two mixes (**Known**; the 0 to 100 slider becomes 0.0 to 1.0). Both sliders start at 50.

### Features: the micro-morph map

Each Features item is a grid. A 2D item moves two morph indices at once (the first label pair is one axis, the second pair the other); a 1D item moves one (**Verified**, from the item table in `maintransition`):

| Item | Label | Axis 1 (labels) | Morph | Axis 2 (labels) | Morph |
| --- | --- | --- | ---: | --- | ---: |
| Brow | `FACE_F_BROW` | Up / Down | 6 | In / Out | 7 |
| Eyes | `FACE_F_EYES` | Squint / Wide | 11 | | |
| Nose | `FACE_F_NOSE` | Up / Down | 0 | Narrow / Wide | 1 |
| Nose Profile | `FACE_F_NOSEP` | Crooked / Curved | 3 | Short / Long | 2 |
| Nose Tip | `FACE_F_NOSET` | Tip Up / Tip Down | 4 | Broken Left / Broken Right | 5 |
| Cheekbones | `FACE_F_CHEEK` | Up / Down | 8 | In / Out | 9 |
| Cheeks | `FACE_F_CHEEKS` | Gaunt / Puffed | 10 | | |
| Lips | `FACE_F_LIPS` | Thin / Fat | 12 | | |
| Jaw | `FACE_F_JAW` | Round / Square | 14 | Narrow / Wide | 13 |
| Chin Profile | `FACE_F_CHIN` | Up / Down | 15 | In / Out | 16 |
| Chin Shape | `FACE_F_CHINS` | Rounded / Bum | 18 | Square / Pointed | 17 |

Two more entries drive morph **19** with no label (one per body type, *probable*); the stats file names `FEATURE_20` "Next gen (Neck)", so 19 is the neck (**Known**: neck thickness). Each axis runs from -1 to 1. The labels `FACE_F_P0_0` to `FACE_F_P10_1` (Large / Small, Crooked / Curved, Broken / Up Turned, Protruding / Shallow, Fat / Thin, Wide / Squint, Square / Round, Pointed / Round) and `FACE_F_P_ST`, `_CUST`, `_OFF` (Standard, Custom, None) are presets for quick picks.

### Appearance: the overlay map

Every Appearance item is either an overlay (`SET_PED_HEAD_OVERLAY` with the index below and an opacity) or a component (hair, eyes). Columns from the item table (**Verified**):

| Item | Label | Overlay | Colour palette | Start opacity |
| --- | --- | ---: | --- | ---: |
| Hair Style | `FACE_A_HS` | (component) | Hair tints | |
| Eyebrows | `FACE_F_EYEBR` | 2 | Hair tints | 100 |
| Facial Hair | `FACE_F_BEARD` | 1 | Hair tints | 100 |
| Skin Blemishes | `FACE_F_SKINB` | 0 | None | 100 |
| Skin Aging | `FACE_F_SKINA` | 3 | None | 100 |
| Skin Complexion | `FACE_F_SKC` | 6 | None | 100 |
| Moles & Freckles | `FACE_F_MOLE` | 9 | None | 100 |
| Skin Damage | `FACE_F_SUND` | 7 | None | 100 |
| Eye Color | `FACE_APP_EYE` | (eye colour) | 32 colours | |
| Eye Makeup | `FACE_F_EYEM` | 4 | None | 50 |
| Blusher | `FACE_F_BLUSH` | 5 | Make-up tints | 25 |
| Lipstick | `FACE_F_LIPST` | 8 | Make-up tints | 50 |
| Body blemishes (no label) | | 11 and 12 | (not set in the table) | 100 |
| Chest hair (no label) | | 10 | (not set in the table) | 100 |

The number of styles per overlay is read at run time with `GET_PED_HEAD_OVERLAY_NUM(index)`, and of colours with `GET_NUM_PED_HAIR_TINTS` / `GET_NUM_PED_MAKEUP_TINTS`; the `IS_PED_*_TINT_FOR_CREATOR` natives hide the colours the creator doesn't offer. New eyebrows start on a random style: 1 to 12 for one sex, 13 to 27 for the other. Opacity (`FACE_OPAC`) and colour (`FACE_COLOUR`, "Color (~1~ of ~1~)") are the two sliders under each overlay.

Style names come from label families named by the script: `CC_EYEBRW_*` (35 names), `CC_BLUSH_*` (34), `CC_MKUP_*` (92), `CC_LIPSTICK_*` (11), `CC_BODY_*` (19), `CC_M_*` (23) and `CC_F_*` (24) for the two sexes' hair, plus one name each for beard, skin ageing, blemishes, complexion, sun damage and moles.

The 32 eye colours in index order (`FACE_E_C_0` to `_31`): Green, Emerald, Light Blue, Ocean Blue, Light Brown, Dark Brown, Hazel, Dark Gray, Light Gray, Pink, Yellow, Purple, Blackout, Shades of Gray, Tequila Sunrise, Atomic, Warp, ECola, Space Ranger, Ying Yang, Bullseye, Lizard, Dragon, Extra Terrestrial, Goat, Smiley, Possessed, Demon, Infected, Alien, Undead, Zombie.

### Apparel

- **Outfits:** 64 per sex, in eight groups of eight named by their label codes `BEA`, `CAS`, `ECC`, `FLS`, `PAR`, `SMA`, `SPO`, `STR` (Beach, Casual, Eccentric, Flashy, Party, Smart, Sporty, Street, *probable* from the codes). The names are labels: male outfits run from "The Dude" and "The Surfer" to "The Gangsta" and "The Hombre".
- **Hat** (`FACE_HAT`) and **Glasses** (`FACE_GLS`).
- **Crew T-shirt** (`FACE_CREWT`): 11 styles, `CHARC_CRT1` "No Crew T-Shirt" to `CHARC_CRT11` "Crew Collar Gray". **Crew emblem** (`FACE_CREWE`): No Emblem, Big, Small, Back (`CHARC_CRD1` to `4`). The emblem texture comes from the crew service (`NETWORK_CLAN_RELEASE_EMBLEM` at cleanup), so it has nothing to show offline.

### Stats

Seven rows plus a points counter (`FACE_STATPT` "Points to Assign", `FACE_STATPTA` "All Points Assigned"). The pool starts at **100** and each step moves one point (**Verified**):

| Stat | Label | Floor | Cap |
| --- | --- | ---: | ---: |
| Stamina | `FACE_STAM` | 5 | 30 |
| Shooting | `FACE_SHOOT` | 10 | 20 |
| Strength | `FACE_STR` | 5 | 40 |
| Stealth | `FACE_STEALTH` | 5 | 25 |
| Flying | `FACE_FLY` | 5 | 60 |
| Driving | `FACE_DRIV` | 5 | 50 |
| Lung Capacity | `FACE_LUNG` | 5 | 40 |

The help texts `FACE_H_STA`, `_SHO`, `_STR`, `_STE`, `_FLY`, `_DRI`, `_LCP` describe what each skill does and how it grows in play ([player skills](/docs/gameplay/player/skills-and-abilities.md)). The stats file still carries `CHAR_CREATOR_FAMILY`, `_SLEEP`, `_SPORT`, `_PARTY`, `_LEGAL`, `_ILLEGAL`, `_TV`, `_BIKE`, `_MECHANIC` next to the seven skill stats: names from the 2013 creator, which set skills from a "lifestyle" of hours per day (**Known**); the current menus never show them.

### Leaving

Save & Continue (`FACE_SAVE`, help `FACE_MM_H8` "Ready to start playing GTA Online?"). Quitting a new character warns `FACES_WARNSP` (all progress lost); leaving an edit warns either `FACES_WARN5` ("You will be unable to alter this character again without paying a fee.") or `FACES_WARN6` ("No money has been taken."). The fee and its limits are stats: `CHAR_APPEARANCE_COOLDOWN`, `CHAR_APPEARANCE_CAP_TIME`, `CHAR_APPEARANCE_CAP_INST`.

## The room

The creator stages its characters in the police line-up interior. The reference point is **409.02, -1000.8, -98.859** (**Verified**); each character's ID board (`prop_police_id_board`) is created 1 m apart along X from it, with the two text props (`prop_police_id_text`, `_02`) on it (`FACE_B_POL` "LOS SANTOS POLICE DEPT"). Two scripted cameras (`DEFAULT_SCRIPTED_CAMERA`) switch between the line-up and the close-up with `RENDER_SCRIPT_CAMS` and 3,000 ms blends. Characters play the line-up clips while being chosen and the customise clips while being edited.

## What is saved

`mpstatssetup.xml` holds 63 appearance and creator stats (35 float, 27 int, 1 bool), **62 of them `ServerAuthoritative="true"`**, per character slot:

| Stats | Holds |
| --- | --- |
| `HEADBLEND_GEOM_BLEND`, `_TEX_BLEND`, `_VAR_BLEND`, `HEADBLEND_DOM` | The shape, skin and third mixes, and parent dominance |
| `HEADBLEND_MUM_*`, `HEADBLEND_DAD_*` (hair, hair texture, beard, make-up, eyebrows) | The parents' looks the face was built from |
| `HEADBLEND_OVERLAY_*_PC`, `HEADBLEND_OVER_BLEMISH_PC`, `HEADBLENDOVERLAYCUTS_PC`, `HEADBLENDOVERLAYMOLES_PC` | Overlay values |
| `FEATURE_0` to `FEATURE_20` | The face-shape values |
| `HAIR_TINT`, `EYEBROW_TINT` | Colours |
| `CHAR_CREATOR_*` (15) | The seven skill points and the old lifestyle values |
| `MESH_HASGRANDPARENT` | A head-blend flag |

**From slider to saved value** (*second pass, 2026-10-30*, **Verified** in `maintransition` and the stat mapping file `mpstatscharactermappingdata.xml`):

- **Features.** A slider runs 0 to 100. The morph value is `min + (max - min) × slider / 100`, where `min` and `max` are the item's two ends in the item table (-1 and 1 for every axis in the table above). That float is saved unchanged: micro morph *n* goes to `MP_STAT_FEATURE_n` (character float stats 137 to 156 for morphs 0 to 19). On load, the same loop reads `FEATURE_0` to `FEATURE_19` and passes each value straight to `SET_PED_MICRO_MORPH(ped, n, value)`, with no scaling. `FEATURE_20` is not read by that loop.
- **Heritage.** After editing, the script reads the face back with `GET_PED_HEAD_BLEND_DATA` and saves its nine values:
  - the three shape parents as `MESH_HEAD0` to `MESH_HEAD2` (int stats 2097 to 2099);
  - the three skin parents as `MESH_TEX0` to `MESH_TEX2` (2100 to 2102);
  - the shape, skin and third mixes as `MESH_HEADBLEND`, `MESH_TEXBLEND` and `MESH_VARBLEND` (float stats 134 to 136).

  So the 0 to 100 Resemblance and Skin Tone sliders end up stored as the 0 to 1 mix floats the native returns.

Server-authoritative stats are written through the server and only land when it accepts them ([stats and tunables](/docs/online/stats-and-tunables.md)). Offline there is no server and no session: the stats can't be written, and the creator only runs as part of the Online transition (`maintransition` checks `NETWORK_IS_GAME_IN_PROGRESS` 100 times).

## What this means for modders

- **Rebuild, don't launch.** The creator is a slice of `maintransition` that needs a network game and server stats; it can't be opened in story mode. Its tables above are enough to build the same editor in a menu framework ([menus and UI](/scripting/menus-and-ui.md)): seven pages, the same sliders, the same limits.
- **Use the exact indices.** Features map to micro morphs 0 to 19 as in the features table; Appearance to overlays 0 to 12 as in the overlay table. Read the option counts at run time (`GET_PED_HEAD_OVERLAY_NUM`, `GET_NUM_PED_HAIR_TINTS`, `GET_NUM_PED_MAKEUP_TINTS`, `GET_PED_HEAD_BLEND_NUM_HEADS`) rather than hard-coding them; DLC can add styles.
- **Show Rockstar's own text.** Every label in this page is in `global.gxt2` and works in every language (`DOES_TEXT_LABEL_EXIST`, then display it); the portraits are in `CHAR_CREATOR_PORTRAITS` (`REQUEST_STREAMED_TEXTURE_DICT`). A mod's creator can look like the real one without shipping text or images.
- **Finish the face before anything clones the ped:** `FINALIZE_HEAD_BLEND`, wait for `HAS_PED_HEAD_BLEND_FINISHED`, as the creator does 19 times. Cutscenes and headshots copy the face from the ped ([cutscenes](/docs/gameplay/missions/cutscenes-and-dialogue.md)).
- **Keep the result in the mod's own save,** named after the stats above (`HEADBLEND_DOM`, `FEATURE_n` ...) so it reads like the real data. Don't write Online stats from story mode.
- **Copy the rules that make it feel right:** 100 skill points with the floors and caps above, no stat changes on re-edit, a fee and cooldown for changing appearance later (a plastic-surgeon feature), starting opacities of 100, 50 and 25.
- **The room is a known interior.** Loading the line-up at 409.02, -1000.8, -98.859 needs the interior streamed first ([streaming](/docs/core/streaming.md), [interiors and IPLs](/docs/world/interiors-and-ipls.md)).
- **Single player only.** Never run mods in GTA Online.

## Open questions

| Question | Where it goes |
| --- | --- |
| How many normal and special parent heads each list has, and which characters the special ones are | In-game test: `GET_PED_HEAD_BLEND_NUM_HEADS` and `GET_PED_HEAD_BLEND_FIRST_INDEX` per type |
| The two unlabelled morph-19 entries and the last column of the appearance table (which sex or body type each row is for) | Next pass, the item-table caller |
| How the slider values (0 to 100, -1 to 1) are scaled into the saved `FEATURE_n` and `HEADBLEND_*` floats, and which `FEATURE_n` is which morph | Answered in [What is saved](#what-is-saved) (second pass): `FEATURE_n` is morph *n*, saved as the raw morph value |
| The outfit group names (`BEA`, `CAS` ...) and the components of each starter outfit | Partly answered (second pass): the text has no label for a group, only for each outfit (`FACE_O_M_BEA0` "The Dude", `FACE_O_F_BEA0` "The Siesta"), so the group names stay *probable* from the codes; the components are left |
| The appearance fee and cooldown values | Answered in [R7.3 10.5.1](/docs/online/stats-and-tunables.md#1051-the-tunable-index-save-categories-and-the-basket-second-pass): $100,000, 48 minutes, at most 30 in 24 hours |
| Which transition state opens the creator, and what menu `-1392473901` is (used 3 times, probably the character select) | Answered: the "LOBBY LIST" screen, and state 32 when the transition's destination is 2 ([R7.2 9.4.1](/docs/online/transitions-and-sessions.md#941-the-offline-branch-the-slots-the-way-back-and-the-testbed-second-pass)) |

## Test cards

1. **Feature indices.** In story mode as a freemode ped (with a trainer), call `SET_PED_MICRO_MORPH(ped, 11, -1.0)` and then `1.0`: the eyes should go to the two ends of the "Eyes" item (Squint and Wide). Index 0 should move the nose up and down, index 12 make the lips thin or fat.
2. **Overlay indices.** `SET_PED_HEAD_OVERLAY(ped, 5, 0, 0.25)` then `SET_PED_HEAD_OVERLAY_TINT(ped, 5, 2, 1, 1)`: a faint blush, as the creator starts it.
3. **Labels.** Display `FACE_TITLE`, `FACE_HERI` and `FACE_E_C_31`: "Character Creator", "Heritage", "Zombie".
