# Mod-builder's cookbook

One page per kind of mod: which game systems it touches, the natives and data files to use, the traps that break mods, and a minimal working pattern. Roadmap topic **R12.1** in the [roadmap](/ROADMAP.md). Every page is built from the research guides and links to them for the details; the patterns are steps, not finished code. New to modding? Do the [modding path](/modding/README.md) first.

**How it was made.** Each page gathers the "What this means for modders" sections and the counts of Rockstar's own native use from the guides it links. Natives and files named are **Verified** in build 1.0.3725.0; the patterns are **Known** good practice drawn from how Rockstar's scripts do the same job. Patterns haven't been run as written; each page ends with a quick test.

**Single player only.** Never run mods in GTA Online.

| Kind of mod | Page | Touches |
| --- | --- | --- |
| Spawning peds and giving them AI | [spawning and AI](spawning-and-ai.md) | Models, peds, tasks, relationships, events, budgets |
| Missions | [missions](missions.md) | Mission structure, blips, objectives, fail and pass, cleanup, saves |
| Menus | [menus](menus.md) | LemonUI, controls, frontend, text |
| Shops | [shops](shops.md) | Interiors, prompts, money stats, saving what was bought |
| Vehicles and handling | [vehicles and handling](vehicles-and-handling.md) | `handling.meta`, `vehicles.meta`, spawning, AI driving |
| Weapons | [weapons](weapons.md) | `weapons.meta`, components, damage, pickups |
| World and map | [world and map](world-and-map.md) | Props, IPLs, map files, doors, time and weather |
| UI and HUD | [UI and HUD](ui-and-hud.md) | HUD components, Scaleform, blips, text |
| Audio | [audio](audio.md) | Sounds, banks, scenes, speech, radio |

## The rules every page assumes

1. **Request, wait, use, release** models, animations, audio banks and movies ([natives as the engine API](/scripting/natives-engine-api.md)).
2. **Check before you touch:** `DOES_ENTITY_EXIST` before using a handle.
3. **Clean up everything** at the end and when the script stops: delete or release entities, stop sounds and scenes, remove blips, undo global switches.
4. **Names over numbers:** use model, label and data names, never memory addresses or global indices ([surviving updates](/docs/core/surviving-updates.md)).
5. **Keep a dependency list** of every asset name the mod uses, and check it after each update with [`update-check.ps1`](/tools/README.md).
