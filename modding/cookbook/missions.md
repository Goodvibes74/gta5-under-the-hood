# Cookbook: missions

A mission with stages, objectives, fail conditions and a pass screen. Part of the [mod-builder's cookbook](README.md).

## Systems it touches

| System | Guide |
| --- | --- |
| How Rockstar structures a mission | [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) |
| How side missions appear | [strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) |
| Dialogue and cutscenes | [cutscenes and dialogue](/docs/gameplay/missions/cutscenes-and-dialogue.md) |
| Wanted level during the mission | [wanted level and police](/docs/ai/wanted-level-and-police.md) |
| Pass screen | [story-mode UI](/docs/ui/story-mode-ui.md), [Scaleform movies](/docs/ui/scaleform.md) |
| Saving progress | [saves](/docs/core/saves.md) |
| Quieting the world | [ambient life](/docs/ai/ambient-life.md), [strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md) (brain sets) |

## Natives and files

- Trigger: distance to a point each frame (the way script brains work), or a blip the player drives to (`ADD_BLIP_FOR_COORD`, `SET_BLIP_ROUTE`).
- World control: `SET_MAX_WANTED_LEVEL`, `CLEAR_AREA`, `SET_PED_DENSITY_MULTIPLIER_THIS_FRAME`, `DISABLE_SCRIPT_BRAIN_SET`.
- Objectives text: `BEGIN_TEXT_COMMAND_PRINT` (subtitle) with your own or literal text ([text labels](/docs/ui/text-labels.md)).
- Pass and fail: `MP_BIG_MESSAGE_FREEMODE` with `SHOW_MISSION_PASSED_MESSAGE` or `SHOW_SHARD_WASTED_MP_MESSAGE`.
- Saving: the mod's own file ([saves](/docs/core/saves.md), 15.7).

## Traps

- **No cleanup on death or arrest:** check death every frame and run the same cleanup as on pass.
- **Changing saved globals** makes the change permanent at the next autosave.
- **Side content wanders in:** disable brain sets and ambient densities during the mission, re-enable after.
- **Hard-coded coordinates** are fine; hard-coded global indices aren't.

## Minimal pattern

1. **Idle:** a blip at the start point; when the player is within a few metres, start.
2. **Setup:** fade out, load models, create the mission's peds and vehicles, cap the wanted level, fade in.
3. **Stages:** one number for the current stage; each stage gives objectives and tasks once, then polls its condition (reach a place, kill targets, escape).
4. **Fail checks every frame:** player dead, important ped dead, target escaped.
5. **Pass:** show the pass message, give rewards, save the mod's progress.
6. **Cleanup (always):** remove blips, release or delete entities, restore the wanted cap and densities, re-enable brain sets.

**Quick test:** start, die on purpose, and check that blips, peds and caps are gone and the next start works.
