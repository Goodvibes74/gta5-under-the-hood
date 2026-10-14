# GTA V Under the Hood: how Grand Theft Auto V works underneath

An open, growing reference on how **GTA V (PC, Legacy edition, build 1.0.3725.0)** works inside: the engine, scripts, physics, AI, the world, story mode, GTA Online, the UI and audio. Written so that anyone can mod the game with a real understanding of what they're changing, and so that the next modder doesn't have to start from zero.

Every page says where its facts come from and marks each claim **Verified** (read in the game files or a decompile of this build) or **Known** (community knowledge, not checked). Nothing here is Rockstar's code or data, and nothing here is a mod.

## Start here

| If you want to... | Read |
| --- | --- |
| Get set up (game version, tools, dependencies) | [Setup](docs/00-getting-started/setup.md), [system requirements](docs/00-getting-started/system-requirements.md), [Linux](docs/00-getting-started/linux.md), [toolbox](docs/00-getting-started/toolbox.md), [glossary](docs/00-getting-started/glossary.md) |
| Know which languages to learn | [Languages for modding](scripting/languages.md) |
| See how the game starts and runs its scripts | [Boot](docs/00-getting-started/boot.md), [runtime scripts](docs/core/runtime-scripts.md), [script VM](scripting/script-vm.md) |
| Understand a system | The folders below; every folder README lists its topics |
| Write a mod | [Scripting](scripting/README.md) and [examples](examples/README.md) |
| Look up a file format | [File formats](file-formats/README.md) |
| Help | [Roadmap](ROADMAP.md) (pick an open topic), [CONTRIBUTING.md](CONTRIBUTING.md) |

## What's inside

```text
gta5-under-the-hood/
├── README.md, ROADMAP.md, CONTRIBUTING.md, CLAUDE.md, CREDITS.md
├── templates/entry-template.md   every page follows it
├── docs/
│   ├── 00-getting-started/      setup, toolbox, glossary, boot, research tools, reading decompiled scripts
│   ├── core/                    game loop, runtime scripts, pools, streaming, archives, saves
│   ├── world/                   map, zones, interiors, time, weather
│   ├── entities/                peds, vehicles (DLC inventory), objects, spawning
│   ├── physics/                 collision and materials, vehicle handling, ragdoll, buoyancy
│   ├── ai/                      perception, relationships, combat, driving, police
│   ├── gameplay/                missions (story flow, mission anatomy, script catalog), weapons, player, economy
│   ├── rendering/               models, textures, LOD, lighting, effects
│   ├── audio/                   radio, SFX, dialogue
│   ├── ui/                      HUD, menus, radar and map
│   ├── performance/             limits, pool sizes, freezes and crashes
│   └── online/                  how GTA Online is built: sessions, freemode, stats, jobs
├── file-formats/                one page per format (RPF, YSC, handling.meta, weapons.meta, materials.dat ...)
├── scripting/                   the script VM, natives, C# (SHVDN), Lua, menus, the script launch graph
├── examples/                    small worked C# mods
└── tools/                       read-only PowerShell research tools and how they work
```

## Status

13 of 105 research topics have a first-pass guide, plus the Online guides, the DLC inventory and the scripting guides. The [roadmap](ROADMAP.md) lists every topic, what's done, and where to begin. Highlights so far:

- [Inside freemode](docs/online/07-freemode.md): GTA Online's 1.47-million-line main script, its state machines and ~180 systems.
- [Story flow](docs/gameplay/missions/story-flow.md) and [mission anatomy](docs/gameplay/missions/mission-anatomy.md): how story missions unlock and how every mission script is built.
- [Vehicle handling](docs/physics/vehicle-handling.md), [collision and materials](docs/physics/collision-and-materials.md), [weapons](docs/gameplay/weapons/weapons.md), [combat and perception](docs/ai/combat-and-perception.md).
- [Runtime scripts](docs/core/runtime-scripts.md) and the [script launch graph](scripting/script-launch-graph.md): which scripts always run and who starts whom.

## Ground rules

- A legitimately purchased copy of GTA V is needed for any of this.
- Single player only. Never use mods in GTA Online: accounts get banned.
- No game code, no game files, no other people's mods in this repo. Details in [CONTRIBUTING.md](CONTRIBUTING.md).

## Credits and licence

Built on the work of the GTA V modding community: see [CREDITS.md](CREDITS.md). Licence: see [LICENSE](LICENSE). Grand Theft Auto and GTA V are trademarks of Take-Two Interactive and Rockstar Games; this project is not affiliated with or endorsed by them.
