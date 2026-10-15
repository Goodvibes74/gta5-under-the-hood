# GTA V Under the Hood: how Grand Theft Auto V works underneath

An open, growing reference on how **GTA V (PC, Legacy edition)** works inside: the engine, scripts, physics, AI, the world, story mode, GTA Online, the UI and audio. Written so that anyone can mod the game with a real understanding of what they're changing, and so that the next modder doesn't have to start from zero.

Every page says where its facts come from and marks each claim **Verified** (read in the game files or a decompile of this build) or **Known** (community knowledge, not checked). Nothing here is Rockstar's code or data, and nothing here is a mod.

## Learn to code by modding GTA V

This repo is also a **study tool**. Modding a game you already enjoy is one of the most motivating ways to learn a programming language: every exercise ends with something you can see and play. You'll practise real languages on a real, large program:

| Language | What you practise | Start with |
| --- | --- | --- |
| **C#** | Classes, events, lists, async-style per-frame code, using a library API | [Languages](scripting/languages.md), then the [examples](examples/README.md) (a first mod in about 30 lines) |
| **Lua** | Scripting basics, tables, functions, quick edit-and-reload experiments | [Lua](scripting/lua.md) |
| **C++** | Pointers, memory, DLLs, performance | [Languages](scripting/languages.md#which-language-for-which-job) |
| **XML and data files** | Structured data, reading a schema, changing values safely | [Vehicle handling](docs/physics/vehicle-handling.md), [weapons](docs/gameplay/weapons/weapons.md) |
| **PowerShell and bash** | Automation, searching huge codebases, parsing files | [Tools](tools/README.md), [decompiled scripts](docs/00-getting-started/decompiled-scripts.md) |
| **Reading other people's code** | Finding your way around 1,143 scripts, one of them 1.47 million lines long | [Mission anatomy](docs/gameplay/missions/mission-anatomy.md), [inside freemode](docs/online/07-freemode.md) |

The [modding path](modding/README.md) walks you through it step by step, from installing ScriptHookV to sharing your first mod. In short: change a value in a data file → write a 30-line C# mod → add a menu → read how the game itself does the same thing → contribute what you learned to the [roadmap](ROADMAP.md). Writing up a research topic is good practice too: it teaches you to read code you didn't write and to explain it clearly.

## Start here

| If you want to... | Read |
| --- | --- |
| Make your first mod, step by step | [Modding: start here](modding/README.md) |
| Learn a programming language by modding | [Learn to code by modding](#learn-to-code-by-modding-gta-v), [languages](scripting/languages.md) |
| Get set up (game version, tools, dependencies) | [Setup](docs/00-getting-started/setup.md), [system requirements](docs/00-getting-started/system-requirements.md), [Linux](docs/00-getting-started/linux.md), [tools and resources](docs/00-getting-started/toolbox.md), [glossary](docs/00-getting-started/glossary.md) |
| Know which languages to learn | [Languages for modding](scripting/languages.md) |
| See how the game starts and runs its scripts | [Boot](docs/00-getting-started/boot.md), [runtime scripts](docs/core/runtime-scripts.md), [script VM](scripting/script-vm.md) |
| Understand a system | The folders below; every folder README lists its topics |
| Write a mod | [Modding path](modding/README.md), [scripting](scripting/README.md) and [examples](examples/README.md) |
| Look up a file format | [File formats](file-formats/README.md) |
| Help | [Roadmap](ROADMAP.md) (pick an open topic), [CONTRIBUTING.md](CONTRIBUTING.md) |
| Share a tool, site or trick that sped up your work | Add it to [tools and resources](docs/00-getting-started/toolbox.md#contributed-tools-and-resources) |

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
├── modding/                     start here to make mods: how mods load, tools, first data edit, first C#, Lua and C++ mod, debugging, sharing
├── file-formats/                one page per format (RPF, YSC, handling.meta, weapons.meta, materials.dat ...)
├── scripting/                   the script VM, natives, C# (SHVDN), Lua, menus, the script launch graph
├── examples/                    small worked C# mods
└── tools/                       read-only PowerShell research tools and how they work
```

## Status

44 of 106 research topics have a first-pass guide, plus a [step-by-step modding path](modding/README.md) for beginners, the Online guides, the DLC inventory and the scripting guides. The [roadmap](ROADMAP.md) lists every topic, what's done, and where to begin. Highlights so far:

- [Inside freemode](docs/online/07-freemode.md): GTA Online's 1.47-million-line main script, its state machines and ~180 systems.
- [Story flow](docs/gameplay/missions/story-flow.md) and [mission anatomy](docs/gameplay/missions/mission-anatomy.md): how story missions unlock and how every mission script is built.
- [Vehicle handling](docs/physics/vehicle-handling.md), [collision and materials](docs/physics/collision-and-materials.md), [weapons](docs/gameplay/weapons/weapons.md), [combat and perception](docs/ai/combat-and-perception.md).
- [Runtime scripts](docs/core/runtime-scripts.md) and the [script launch graph](scripting/script-launch-graph.md): which scripts always run and who starts whom.
- [Native usage](scripting/native-usage.md): which of the 1,013 scripts call each of 6,575 natives, 12.3 million calls, with a [per-namespace index](scripting/native-usage-index.md).

## Ground rules

- A legitimately purchased copy of GTA V is needed for any of this.
- Single player only. Never use mods in GTA Online: accounts get banned.
- Markdown only: no executables, binaries or archives, ever. Tools are linked to their official pages, never uploaded (this keeps malware out). An automatic check enforces it. Found something suspicious? See [SECURITY.md](SECURITY.md).
- No game code, no game files, no other people's mods in this repo. Details in [CONTRIBUTING.md](CONTRIBUTING.md).

## Credits and licence

Built on the work of the GTA V modding community: see [CREDITS.md](CREDITS.md). Licence: see [LICENSE](LICENSE). Grand Theft Auto and GTA V are trademarks of Take-Two Interactive and Rockstar Games; this project is not affiliated with or endorsed by them.
