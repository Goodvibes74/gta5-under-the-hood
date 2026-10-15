# Ideas list: mods the research says are possible

Mods that the finished guides show can be built in story mode, each tied to the guide that explains the system, with what it would touch and a size estimate. Roadmap topic **R12.3** in the [roadmap](/ROADMAP.md). **These are proposals.** The roadmap row says ideas go onto the roadmaps only after review with the maintainer, so nothing here is a roadmap topic yet. Pick one, open an issue, and talk it through first.

**How it was made.** Each idea comes from a "What this means for modders" section of a first-pass guide and names that guide. Sizes use the roadmap's scale: **S** an evening, **M** a few sessions, **L** a week or more. Feasibility is **Known** (it follows from the documented natives and data files); none of these has been built yet.

**Single player only.** Every idea is for story mode. Never run mods in GTA Online.

## Data-file mods (no code)

| Idea | What it changes | Guide | Size |
| --- | --- | --- | --- |
| **Police overhaul pack** | Units per wanted level, search radii, hiding times, cop search helpers, which events call the police | [police and services](/docs/ai/police-and-services.md), [perception and events](/docs/ai/perception-and-events.md) | S |
| **Better AI drivers** | The four AI corner-speed curves, and `SPORTS_CAR` handling for fast cars that drive like average ones | [driving and AI driving](/docs/ai/driving.md) | S |
| **Ragdoll feel pack** | Shot, high-fall and brace tunables in `physicstasks.ymt` (heavier or lighter reactions) | [ragdoll](/docs/entities/peds/ragdoll.md) | S |
| **Living city tuning** | Idle-clip timing, look-at scores, how long peds stay shaken after gunfire | [ambient life](/docs/ai/ambient-life.md) | S |
| **Ultrawide HUD layout** | HUD component positions and radar placement in `frontend.xml` | [HUD, colours and blips](/docs/ui/hud-colours-blips.md) | S |
| **Night lights pack** | Distant lights and LOD light ranges in `visualsettings.dat` (cheap way to see the city farther at night) | [rendering and LOD](/docs/rendering/rendering-and-visual-settings.md) | S |
| **Door and gate behaviour** | `doortuning.meta`: which gates auto-open for the player, garages, barrier arms | [props and doors](/docs/entities/objects/props-and-doors.md) | S |

## Script mods

| Idea | What it does | Guide | Size |
| --- | --- | --- | --- |
| **Story-mode track builder** | A fly camera, a placement ray, a prop catalogue with stunt pieces that snap by their bones, speed pads, and a JSON save, rebuilt with the race player's prop setup | [Rockstar Creator internals](/docs/online/creator-internals.md) | L |
| **Local creator-job player** | Reads a job's `prop`, `dprop`, `dhprop` and checkpoint columns and rebuilds the map in story mode (no Online, no cloud) | [creator internals](/docs/online/creator-internals.md), [UGC files](/file-formats/ugc-json.md) | M |
| **Side-mission framework** | Distance-triggered side missions with blips, hour windows and follow-up scripts, the way strangers and freaks work | [strangers and freaks](/docs/gameplay/missions/strangers-and-freaks.md), [mission anatomy](/docs/gameplay/missions/mission-anatomy.md) | M |
| **Mod save helper** | A small library that keeps a mod's data in its own file per story save slot, never touching the story save | [saves](/docs/core/saves.md) | M |
| **Completion tracker** | An overlay of the 100% groups with their weights, from the `num_*` stats | [completion](/docs/core/completion-and-autosave.md) | S |
| **Low-end PC helper** | Lowers densities and model budgets in heavy scenes and caps combat peds, using Rockstar's own natives | [AI cost](/docs/ai/ai-cost-and-lod.md), [CPU](/docs/performance/cpu.md) | M |
| **Navmesh-aware companion** | A follower that loads navmesh around far goals, uses safe coordinates and blocking objects, and doesn't get stuck | [navigation](/docs/ai/navigation.md) | M |
| **Scaleform message kit** | Helpers to show the game's big messages, mission-passed screen and button prompts from any mod | [Scaleform movies](/docs/ui/scaleform.md), [story-mode UI](/docs/ui/story-mode-ui.md) | S |
| **Speech sandbox** | Make any ped say any ambient context in any voice, to find lines for a mod | [speech and dialogue](/docs/audio/speech-and-dialogue.md) | S |
| **Flight trainer** | Turbulence and handling presets, helicopter spawn-in-air, gear and nozzle controls | [flying](/docs/gameplay/player/flying.md) | S |
| **Dependency list generator** | Scans a mod's source for model, animation, IPL and movie names and writes the list the update-check tool reads | [surviving updates](/docs/core/surviving-updates.md), [tools](/tools/README.md) | M |

## Harder or riskier

| Idea | Why it's hard | Guide | Size |
| --- | --- | --- | --- |
| **A pause-menu page for a mod** | Needs an edited `pausemenu.xml` with a `SCRIPT` runtime; every update that changes the file breaks it | [pause menu](/docs/ui/pause-menu.md) | M |
| **A phone app in a spare slot** | The app table's address changes every build | [phone and apps](/docs/online/interaction-menu-phone-apps.md) | M |
| **New websites** | Each site is its own `www_*.gfx` movie; needs Flash editing | [Scaleform movies](/docs/ui/scaleform.md) | L |
| **New voiced dialogue** | New `.awc` containers and speech config, packed as an add-on | [speech and dialogue](/docs/audio/speech-and-dialogue.md) | L |

## How to take one

1. Open an issue titled after the idea and say which one you're taking.
2. The maintainer decides whether it becomes a roadmap topic (in R12.1's cookbook, or as a worked example in [examples](/examples/README.md)).
3. Build it on a branch, single player only, and link the guides it used.
