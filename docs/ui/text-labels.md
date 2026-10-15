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

**Verified (block loading):** the 195 block names scripts request by literal, with the slot. Slot use (literal calls): 0 ×169, 2 ×134, 3 ×110, 6 ×29, 5 ×9, 9 ×7, 8 ×4, 4 ×3, 10 and 15 ×2, and 1, 7, 11, 12 and 14 once. **Known:** slot 0 is the mission's own text, slot 2 the mission's dialogue subtitles, slot 3 minigames and shared systems; loading a block into a slot replaces what was there.

## What this means for modders

- **Show any text without a label:** use the `STRING` label and insert your text: `BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")`, `ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("My text")`, `END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)`. Rockstar does the same 705 times. ScriptHookVDotNet's `Screen.ShowHelpText` and `Notification.Show` wrap this (**Known**).
- **Use Rockstar's labels** for translated text: the label name works in every language. Check `DOES_TEXT_LABEL_EXIST` first; mission blocks must be loaded with `REQUEST_ADDITIONAL_TEXT` into a free slot (avoid 0, 2 and 3 while a mission runs) and freed with `CLEAR_ADDITIONAL_TEXT`.
- **Add your own labels** through a DLC pack of your own: a `dlctext.meta` with `hasGlobalTextFile` true, a `TEXTFILE_METAFILE` entry in `content.xml`, and a `global.gxt2` inside `x64/data/lang/americandlc.rpf` (and the other languages you support). Build the `.gxt2` with a text editor tool for GTA V text (OpenIV or CodeWalker can edit them, **Known**). This is how add-on vehicles get their display names (R14.4).
- **Don't edit Rockstar's `global.gxt2`** to add text: every update replaces `update2.rpf`, and a replaced global block breaks other languages and DLC text.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The full slot list and which systems own which slot | Second pass: read the slot constants in `standard_global_init` and the mission scripts |
| How DLC global blocks are merged and which wins on a clash | In-game test; R1.6 |
| A label-name index (most names are only known by hash) | Second pass: hash every string literal in the decompile and match |
| What the 8 blocks `update2.rpf` adds are for | Second pass |

## Test cards

1. **STRING trick.** Show help text "Hello" with the `STRING` label as above. Expected: the help box shows "Hello" in any language.
2. **Mission block.** `REQUEST_ADDITIONAL_TEXT("ARM1", 6)`, wait for `HAS_THIS_ADDITIONAL_TEXT_LOADED("ARM1", 6)`, then show a label from it. Expected: its text appears; after `CLEAR_ADDITIONAL_TEXT(6, false)` it no longer exists.
3. **Language.** Switch the game language and show the same label. Expected: the translated text, with no change in the script.
