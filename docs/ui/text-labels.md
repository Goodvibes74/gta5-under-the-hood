# Text labels

How GTA V stores every piece of on-screen text (help text, subtitles, mission objectives, blip names, menu items, vehicle names) as labels in `.gxt2` files, how they are split into a global table and per-mission blocks, how DLC packs add text, how scripts load and show it, and how a mod can show its own text. Roadmap topic **R8.3** in the [roadmap](/ROADMAP.md). Builds on [archives and content](/docs/core/archives-and-content.md) (DLC packs and `content.xml`) and [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) (subtitles of conversations). How model display names are registered is R14.4.

**How it was made.** Every file in the vanilla archives was listed with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does). The American text files were extracted from `x64b.rpf` (`data/lang/american_rel.rpf`), `update\update2.rpf` and every DLC pack (`americandlc.rpf`), and their labels counted with a small reader of the `.gxt2` layout (a `2TXG` header, a count, then hash and offset pairs and null-terminated strings). DLC `content.xml` files were read with [`tools/dlc-scan.ps1`](/tools/README.md). Native use from the [HUD](/scripting/native-usage/HUD.md) and [LOCALIZATION](/scripting/native-usage/LOCALIZATION.md) usage pages; the block names and slots scripts load and the labels they pass to the text commands counted with `git grep -o` over every decompiled script (commit `6c18d3e8b`). Build 1.0.3725.0 Legacy. Counts are **Verified**; how the text system works inside is **Known** unless stated.

## Short version

- **A label is a hash.** Each `.gxt2` file is a table of Jenkins hashes of label names (`CELL_255`, `MP_WHOUSE_BLP2`) and UTF-8 strings. The label name itself isn't stored; the game hashes the name a script passes and looks it up.
- **The base game ships 610 American text blocks with 278,749 labels** (8.5 million characters). `update\update2.rpf` carries all of them (it replaces the 602 blocks in `x64b.rpf` and adds 8). The global block `global.gxt2` alone has 69,209 labels; the rest are per mission or system (`fmmc` 10,557 for the mission creator, `animlau` 7,803, `pubc` 3,785, `credit` 2,818).
- **Blocks ending in `aud` are conversation subtitles** (`ah3baud`, `bs2baud`, `rbh2aud` ...): the text of every line a mission's characters speak (**Known**; the names follow the mission's dialogue block).
- **13 languages,** each in its own archive (`american_rel.rpf`, `french_rel.rpf`, `german_rel.rpf`, `italian_rel.rpf`, `spanish_rel.rpf`, `mexican_rel.rpf`, `portuguese_rel.rpf`, `polish_rel.rpf`, `russian_rel.rpf`, `japanese_rel.rpf`, `korean_rel.rpf`, `chinese_rel.rpf` and `chinesesimp_rel.rpf`), each holding about 1,213 text files across the base and update archives (Simplified Chinese, added later, 611).
- **DLC packs add 186,875 more labels** in 316 American files (one `global.gxt2` in each of 42 packs, plus mission blocks). 38 packs carry a `dlctext.meta` (`hasGlobalTextFile`, `hasAdditionalText`) and 40 `content.xml` entries use `TEXTFILE_METAFILE`.
- **Scripts load mission text into numbered slots:** `REQUEST_ADDITIONAL_TEXT(block, slot)` in 461 scripts, with 195 different block names; slots 0 (169 calls), 2 (134) and 3 (110) are the busy ones, out of 0 to 15 seen.
- **Most text is built by "text commands":** `BEGIN_TEXT_COMMAND_DISPLAY_HELP` (679 scripts), `ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL` (624), `BEGIN_TEXT_COMMAND_THEFEED_POST` (498), `DOES_TEXT_LABEL_EXIST` (491). The label scripts pass most often is `STRING` (705 literal uses): its text is just `~a~`, a slot the script fills with any string.

## Where it lives

| File | What it holds | Count (build 3725, American) |
| --- | --- | --- |
| `x64b.rpf` → `data/lang/<language>_rel.rpf/*.gxt2` | The original text blocks | 602 |
| `update\update2.rpf` → the same paths | The current text (replaces all 602, adds 8) | 610 blocks, 278,749 labels |
| `global.gxt2` | Text that is always loaded (HUD, menus, vehicle and weapon names, help) | 69,209 labels |
| `<block>.gxt2` | Per-mission, per-activity and per-system text, loaded on demand | 609 blocks |
| `<block>aud.gxt2` | Subtitles for a dialogue block | Most mission blocks have one |
| DLC packs → `x64/data/lang/americandlc.rpf/*.gxt2` | DLC text: a `global.gxt2` per pack plus mission blocks | 316 files, 186,875 labels |
| DLC packs → `common:/data/dlctext.meta` | Tells the game the pack has text (`hasGlobalTextFile`, `hasAdditionalText`, `isTitleUpdate`) | 38 packs |

The biggest blocks:

| Block | Labels | What (**Known** from the name) |
| --- | ---: | --- |
| `global` | 69,209 | Always loaded |
| `fmmc` | 10,557 | The mission creator and Online jobs |
| `animlau` | 7,803 | Animal dialogue (the peyote animals) |
| `pubc` | 3,785 | Public (Online) content |
| `ct_aud` | 3,224 | Conversation subtitles |
| `bs2baud`, `ah3baud`, `rbh2aud`, `jhaud`, `fh3aaud` | 2,500 to 3,200 each | Heist dialogue subtitles |
| `mc_play` | 3,026 | Mission controller play text |
| `credit` | 2,818 | The end credits |
| `trackid` | 2,711 | Radio track names for the track ID feature (R9.3) |

## How scripts use text

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `BEGIN_TEXT_COMMAND_DISPLAY_HELP` / `END_...` | 679 | 1,744 | Help text box (top left) |
| `BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED` | 606 | 1,747 | Is that help text up |
| `ADD_TEXT_COMPONENT_SUBSTRING_TEXT_LABEL` | 624 | 12,627 | Insert another label into a message |
| `ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME` | 474 | 16,090 | Insert any string (used for names and for raw text) |
| `ADD_TEXT_COMPONENT_INTEGER`, `_FLOAT`, `_FORMATTED_INTEGER`, `_SUBSTRING_TIME` | 498, 349, 196, 364 | | Insert numbers, money, times |
| `BEGIN_TEXT_COMMAND_THEFEED_POST` | 498 | 2,579 | Notifications (the feed) |
| `DOES_TEXT_LABEL_EXIST` | 491 | 1,750 | Check before showing (DLC text that may be missing) |
| `REQUEST_ADDITIONAL_TEXT`, `HAS_ADDITIONAL_TEXT_LOADED`, `HAS_THIS_ADDITIONAL_TEXT_LOADED`, `CLEAR_ADDITIONAL_TEXT` | 461, 245, 232, 307 | 698, 489, 365, 563 | Load a mission block into a slot, wait, free it |
| `GET_FILENAME_FOR_AUDIO_CONVERSATION` | 450 | 3,583 | Look up a label's text as a string (used with conversations) |
| `GET_MOD_TEXT_LABEL` | 440 | 725 | The name of a vehicle mod |
| `BEGIN_TEXT_COMMAND_SET_BLIP_NAME` | 315 | 945 | Name a blip |
| `BEGIN_TEXT_COMMAND_DISPLAY_TEXT` | 245 | 2,430 | Draw text on screen |
| `BEGIN_TEXT_COMMAND_PRINT` | 220 | 537 | Mission objective and subtitle line (bottom of the screen) |
| `GET_CURRENT_LANGUAGE` | 375 | 3,241 | Which language is on |
| `GET_DISPLAY_NAME_FROM_VEHICLE_MODEL` | 122 | 1,293 | A model's name label (R14.4) |

**Verified (block loading):** the 195 block names scripts request by literal, with the slot. Slot use (literal calls): 0 ×169, 2 ×134, 3 ×110, 6 ×29, 5 ×9, 9 ×7, 8 ×4, 4 ×3, 10 and 15 ×2, and 1, 7, 11, 12 and 14 once. **Known:** slot 0 is the mission's own text, slot 3 minigames and shared systems; loading a block into a slot replaces what was there. The second pass lists every slot ([the text slots](#the-text-slots-and-who-uses-them)): story subtitles use slot 6, not 2.

## The text slots and who uses them

*Second pass (2026-10-25).* Every `REQUEST_ADDITIONAL_TEXT` and `REQUEST_ADDITIONAL_TEXT_FOR_DLC` call in the decompile (commit `6c18d3e8b`) was listed with `git grep`, and its block and slot read from the arguments. 665 calls pass the slot as a number (62 more pass it in a variable). The table counts calls, the scripts that make them, and the blocks named. **Verified** counts; the "used for" column is read from which scripts use the slot and which blocks they load.

| Slot | Calls | Scripts | Used for | Blocks loaded (examples) |
| ---: | ---: | ---: | --- | --- |
| 0 | 176 | 155 | A story mission's or odd job's own text | 128 blocks: `ARM1`, `FAM1`, `H4HEIST`, `BBONDS`, `DOCKH1` ... |
| 1 | 3 | 3 | The phone's email and contacts apps | `email` |
| 2 | 134 | 98 | An Online job controller's text, and a story activity's text | `FMMC` (Online jobs, creators, seating scripts), `BJUMP`, `TAXI`, `TOW`, `BUSTOUR`, `DTRFAIR`, `DTRFKGR` |
| 3 | 110 | 87 | Minigames and other shared activities, story and Online | 23 blocks: `DARTS`, `TENNIS`, `SP_GOLF`, `YOGA`, `S_RANGE`, `PSCHOOL`, `HACK`, the assassination blocks, the arcade games (`GGSM`, `IAP`, `SCGW`, `DCTL`) |
| 4 | 4 | 1 | The in-game internet (`appinternet`) | `LFI_M`, `LFI_F`, `LFI_T` (the Lifeinvader pages) |
| 5 | 14 | 12 | Heist boards, ambient prep scripts, friend activities, the public creator | `GETAWY`, `CHOPPER`, `FRIENDS`, `PUBC` |
| 6 | 43 | 36 | Dialogue subtitles of a story mission (`dialogue_handler` and the missions) | 24 `*AUD` / `*AU` blocks: `FAM1AUD`, `fbi1aud`, `JHS1AUD` ... |
| 7 | 3 | 2 | Barry's post-mission scene (`postrc_barry1and2`) and `dialogue_handler` | `BARY1` |
| 8 | 4 | 4 | Awards and the mission-replay stats screen (`mp_awards`, `pausemenu_sp_repeat`, `freemode`, `initial`) | `MPAWD`, `MISHSTA` |
| 9 | 148 | 135 | Online property, interior and ambient scripts (`am_mp_*`, `act_cinema` ...) | `MC_PLAY`, `FMMC` |
| 10 | 2 | 2 | Apartment arm wrestling and darts | `ARM_MP`, `DARTS` |
| 11 | 1 | 1 | DLC text in `fm_mission_controller` | `OBHFAU` |
| 12 | 1 | 1 | DLC text in `pilot_school_mp` | `DSCHOOL` |
| 14 | 11 | 7 | DLC dialogue subtitles in the Online job controllers and `dialogue_handler` | `EXPOWAU` |
| 15 | 4 | 2 | DLC phone-call subtitles (`appcontacts`, `dialogue_handler`) | `LOWCAAU`, `X25MAAU` |
| 20 | 7 | 5 | DLC text named in a variable, in the Online job controllers | none by literal |

Slots 13 and 16 to 19 are never passed as a literal. All 29 `_FOR_DLC` calls (14 scripts) use slots 11, 12, 14, 15 and 20, so the high slots are kept for DLC text and the low ones for the base game (**Verified** for this build). These counts are higher than the first pass's (above) because that count kept only calls whose block name it recognised. It also corrects one first-pass reading: slot 2 is not story dialogue; story subtitles go in slot 6.

**For a mod:** a story mission is running when slots 0 and 6 are taken, and a minigame when 3 is; slots 13 and 16 to 19 are never used by Rockstar's scripts, so they are the safest for a mod's own block (**Verified** from the scripts; that the engine has no other use for them is **Known**).

## The eight blocks `update2.rpf` adds

*Second pass.* The 602 American blocks in `x64b.rpf` were listed with [`tools/rpf-cw.ps1`](/tools/README.md) and compared with the 610 in `update\update2.rpf`. The eight extra blocks, with the scripts that load them by name (**Verified**):

| Block | Labels | Loaded by | What it is |
| --- | ---: | --- | --- |
| `pubc` | 3,785 | `public_mission_creator` | The public mission creator's menus and help |
| `dir_mnu` | 653 | `director_mode` | Director mode's menus (character, place and mood names) |
| `iap` | 58 | `scroll_arcade_cabinet`, `apparcadebusiness`, `appinternet` | The "Invade and Persuade" arcade game |
| `ggsm` | 47 | `ggsm_arcade` | The "Go Go Space Monkey" arcade game |
| `scgw` | 47 | `grid_arcade_cabinet` | The "Street Crimes: Gang Wars" arcade game |
| `dctl` | 14 | `dont_cross_the_line` and 20 seating scripts | "Don't Cross the Line", the game played from seats in Online properties |
| `dance` | 12 | `si_dancing_activity`, the nightclub, casino and island scripts | Dancing prompts (button names) |
| `lowdau` | 0 | none | Empty (named like a Lowrider dialogue block, with no lines) |

So the update added text for features that came after the first release (director mode, the creator, the arcade, dancing) as new blocks next to the original 602, rather than putting it in DLC packs.

## Naming the labels

*Second pass.* A `.gxt2` file stores only the hash of each label name, so a label-name index has to be rebuilt by guessing names and hashing them. The guesses were taken from the scripts: every string literal of 2 to 63 letters, digits and underscores in every decompiled script (216,452 distinct literals, collected with `git grep -o` over the commit), hashed with `joaat` and matched against every American label in the base game, the 36 DLC packs that carry American text, and the update's patch block (426,221 distinct hashes). Two more passes catch names that scripts build at run time: a literal followed by a number (`"CELL_"` and 5), and a literal followed by `_` and a number (a conversation root and its line, `ARM1_INTRO_3`). In those two passes a series is kept only when at least two of its numbers match, which keeps chance matches between unrelated hashes out. **Verified** counts.

| Where the labels are | Labels | Named | Share |
| --- | ---: | ---: | ---: |
| `global` (base) | 69,209 | 51,303 | 74% |
| `fmmc` | 10,557 | 8,627 | 82% |
| `pubc` | 3,785 | 3,504 | 93% |
| All blocks except subtitles | 151,035 | 81,950 | 54% |
| Subtitle blocks (`*aud`, `*au`) | 276,235 | 43,866 | 16% |
| **Everything** | **426,221** | **125,644** | **29.5%** |

73,076 names came straight from literals, 8,819 from a literal and a number, and 43,749 from a conversation root and a line number. The low share for subtitles is expected: most conversation roots reach the dialogue system from tables, not as literals, and blocks such as `credit` (the end credits) and `trackid` (radio track names) are never named in scripts at all; the engine looks them up or builds them from data. Names from the data files (vehicle, weapon and shop item names in the `.meta` files) were not added in this pass and would raise the share further.

The index itself is not in this repository (it's derived from Rockstar's files). Anyone with the decompile and their own game files can rebuild it in a few minutes with the method above; the hash is the same `joaat` that [`tools/script-launch-graph.ps1`](/tools/README.md) implements.

## What this means for modders

- **Show any text without a label:** use the `STRING` label and insert your text: `BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")`, `ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("My text")`, `END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)`. Rockstar does the same 705 times. ScriptHookVDotNet's `Screen.ShowHelpText` and `Notification.Show` wrap this (**Known**).
- **Use Rockstar's labels** for translated text: the label name works in every language. Check `DOES_TEXT_LABEL_EXIST` first; mission blocks must be loaded with `REQUEST_ADDITIONAL_TEXT` into a free slot (avoid 0, 3 and 6 while a story mission runs; 13 and 16 to 19 are never used by Rockstar's scripts) and freed with `CLEAR_ADDITIONAL_TEXT`.
- **Add your own labels** through a DLC pack of your own: a `dlctext.meta` with `hasGlobalTextFile` true, a `TEXTFILE_METAFILE` entry in `content.xml`, and a `global.gxt2` inside `x64/data/lang/americandlc.rpf` (and the other languages you support). Build the `.gxt2` with a text editor tool for GTA V text (OpenIV or CodeWalker can edit them, **Known**). This is how add-on vehicles get their display names (R14.4).
- **Don't edit Rockstar's `global.gxt2`** to add text: every update replaces `update2.rpf`, and a replaced global block breaks other languages and DLC text.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| How DLC global blocks are merged and which wins on a clash | In-game test; R1.6 |
| Names for the subtitle, credit and track-ID labels (16% of subtitle labels named) | Next pass: conversation roots from the dialogue tables, names from the `.meta` files |
| What the engine does with slots 13 and 16 to 19, which no script uses | Engine reverse engineering, or a test that loads a block into each |

Answered in the second pass: the slot list ([the text slots](#the-text-slots-and-who-uses-them)), a label-name index ([naming the labels](#naming-the-labels), 29.5% of all labels named) and the eight extra blocks ([the eight blocks](#the-eight-blocks-update2rpf-adds)).

## Test cards

1. **STRING trick.** Show help text "Hello" with the `STRING` label as above. Expected: the help box shows "Hello" in any language.
2. **Mission block.** `REQUEST_ADDITIONAL_TEXT("ARM1", 6)`, wait for `HAS_THIS_ADDITIONAL_TEXT_LOADED("ARM1", 6)`, then show a label from it. Expected: its text appears; after `CLEAR_ADDITIONAL_TEXT(6, false)` it no longer exists.
3. **Language.** Switch the game language and show the same label. Expected: the translated text, with no change in the script.
