# Story-mode UI

The story mode's own screens and what draws them: the character wheel, the mission-passed screen and its stats and medal, the 206-stat Stats page in eight categories, the 100% checklist, the pause-menu pages story mode uses, and the phone. Roadmap topic **R8.6** in the [roadmap](/ROADMAP.md). Most pieces have their own guide; this page ties them together and adds the stats screen and the pass screen. Builds on [character switching](/docs/gameplay/player/character-switching.md) (R6.1), [completion, autosave and achievements](/docs/core/completion-and-autosave.md) (R5.3), [pause and Online menus](/docs/ui/pause-menu.md) (R8.1), [Scaleform movies](/docs/ui/scaleform.md) (R8.2) and [interaction menu, phone and apps](/docs/online/interaction-menu-phone-apps.md) (R7.10).

**How it was made.** `update\update.rpf\common\data\ui\spstatssetupui.xml` of build 1.0.3725.0 extracted with [`tools/rpf-cw.ps1`](/tools/README.md) and parsed with `awk` (comments removed); `selector` and `mission_stat_watcher` read in the decompile (commit `6c18d3e8b`) for their Scaleform movies and method names; text labels resolved from the American `.gxt2` files. Counts and names are **Verified**; what a screen looks like is **Known**.

## 26.1 Short version

- **The character wheel** is `selector` with three Scaleform movies: `PLAYER_SWITCH`, `PLAYER_SWITCH_PROLOGUE` and `PLAYER_SWITCH_STATS_PANEL`. It sets slots, the selected character, hints, damage and the stats panel (`SET_SWITCH_SLOT`, `SET_PLAYER_SELECTED`, `SET_SWITCH_HINTED_ALL`, `SET_PLAYER_DAMAGE`, `SET_STATS_LABELS` ...). The switch itself is in [R6.1](/docs/gameplay/player/character-switching.md).
- **The mission-passed screen** is `mission_stat_watcher` drawing `MP_BIG_MESSAGE_FREEMODE` (the same movie Online uses for big messages) with `SHOW_MISSION_PASSED_MESSAGE`, rows added with `SET_DATA_SLOT`, and roll-up and transition methods. Text: "Mission Passed" (`MISHPA`), "Heist Passed" (`HISHPA`), 210 mission stat labels (`MISHSTA_*`), "Medal", "Completion", and markers for skipped, retried-from-checkpoint, cheated and taxi-skipped runs.
- **The Stats page** is laid out by `spstatssetupui.xml`: **206 stats in 8 categories**: Skills (8), General (32), Crimes (23), Vehicles (46), Cash (45), Combat (9), Weapons (38) and 100% Checklist (5). 178 are always visible and 28 appear only after they first change.
- **Stats are typed for display:** `int` (95), `cash` (30), `time` (17), `bool` (15), `distance` (14), `fraction` (13), `bar` (8, the skill bars), `checklist` (5), `short_distance` (5), and one each of `percent`, `speed`, `namehash`, `carhash`. Some swap numbers for text with `ReplaceLabel` ranges (29 of them).
- **The 100% checklist** shows the completion groups ([R5.3](/docs/core/completion-and-autosave.md)) as `checklist` stats such as `NUM_MISC_COMPLETED`.
- **Story pause-menu pages** (map, brief, stats, settings, game, gallery, replays) are in [R8.1](/docs/ui/pause-menu.md); the phone and its apps in [R7.10](/docs/online/interaction-menu-phone-apps.md).

## 26.2 The Stats page

`spstatssetupui.xml` (**Verified**) lists stats by category; each line gives the stat name (matching the stat definitions), a display type, a visibility rule, an optional text label and whether it's per character. The file's own header documents the format (types `float`, `int`, `time`, `distance`, `date`; visibility `ALWAYS_VISIBLE`, `NEVER_VISIBLE`, `AFTER_INCREMENT`, `SPECIAL_EDITION`, `CONDITIONAL`; `ReplaceLabel` to show a word instead of a number; `fraction` and `checklist` types).

| Category (label) | Stats | Examples |
| --- | ---: | --- |
| Skills (`SP_STATS1`) | 8 | `SPECIAL_ABILITY_UNLOCKED`, `STAMINA`, `SHOOTING_ABILITY`, `STRENGTH`, `STEALTH_ABILITY`, `FLYING_ABILITY`, `WHEELIE_ABILITY`, `LUNG_CAPACITY` |
| General (`SP_STATS2`) | 32 | `TOTAL_PLAYING_TIME`, `FIRST_PERSON_CAM_TIME`, `MISSIONS_PASSED`, `LAST_MISSION_NAME`, `NUM_HIDDEN_PACKAGES_0` to `_7`, `MANUAL_SAVED`, `TIMES_CHEATED`, `DEATHS`, `DIED_IN_EXPLOSION` / `_FALL` / `_FIRE` / `_ROAD` / `_DROWNING`, `TIME_SWIMMING` |
| Crimes (`SP_STATS3`) | 23 | |
| Vehicles (`SP_STATS4`) | 46 | |
| Cash (`SP_STATS5`) | 45 | |
| Combat (`SP_STATS6`) | 9 | |
| Weapons (`SP_STATS7`) | 38 | |
| 100% Checklist (`SP_STATS8`) | 5 | The completion groups |

The skills show as bars (the `bar` type, 8 stats); their meaning is in [skills and abilities](/docs/gameplay/player/skills-and-abilities.md).

## 26.3 The mission-passed screen

`mission_stat_watcher` (8,904 lines) watches the running mission's stats and, at the end, draws the pass screen (**Verified** method calls): `SHOW_MISSION_PASSED_MESSAGE` on `MP_BIG_MESSAGE_FREEMODE`, `SET_DATA_SLOT` per row (5 calls), `ROLL_DOWN_BACKGROUND` / `ROLL_UP_BACKGROUND`, `TRANSITION_UP`, `TRANSITION_OUT`, plus `instructional_buttons` for "Continue" and the rating prompts. The rows use 210 `MISHSTA_*` labels (one per tracked mission stat, the same set across the decompile), and the footer uses `MTPHPER` ("Completion") with notes for skipped (`MTPHPERSKI`), checkpoint (`MTPHPERRET`), cheats (`MTPHPERCHE`), taxi (`MTPHPERTAX`) and missed (`MTPHPERNOREC`).

## 26.4 What this means for modders

- **Add a line to the Stats page** only by editing `spstatssetupui.xml` and using a stat that already exists; a mod can't define new stats ([saves](/docs/core/saves.md)).
- **Reuse the pass screen look** in a mod with `MP_BIG_MESSAGE_FREEMODE` and `SHOW_MISSION_PASSED_MESSAGE` ([Scaleform movies](/docs/ui/scaleform.md)); it works in story mode.
- **Hide the character wheel during a mod's scene** the way missions block switching ([R6.1](/docs/gameplay/player/character-switching.md)).

## 26.5 Open questions

| Question | Where it goes |
| --- | --- |
| The full stat list per category, with display types | Second pass, `spstatssetupui.xml` |
| How a mission chooses its stats and the medal thresholds | Second pass, `mission_stat_watcher` and each mission |
| The parameters of `SHOW_MISSION_PASSED_MESSAGE` | Second pass |

## 26.6 Test cards (story mode)

1. **Stats page.** Open Pause → Stats. Expected: eight categories, Skills first with eight bars.
2. **After increment.** Check that a stat marked `AFTER_INCREMENT` (for example a rare death cause) is missing on a new save and appears after it happens once.
