# Contributing

Thanks for helping map how GTA V works. Everything here is written by contributors in their own words; the game's code and data never go into this repo.

## The three rules that never bend

1. **No Rockstar code or files.** Never paste decompiled script code, extracted game files (`.ysc`, `.ugc`, `.meta` copies, `mpstatssetup.xml` ...), or anything from the archives. Quote names, numbers, coordinates, field names and short labels, and describe logic in your own words.
2. **No other people's mods.** No mod binaries or their source, decompiled or not. Link to the author's page instead.
3. **Mark every claim.** **Verified** means you read it in the game files or a decompile of the stated build. **Known** means community knowledge you haven't checked yourself. A guide that mixes the two without saying which can't be trusted.

Also leave out personal details: your paths (`C:\Users\...`), your hardware unless it's a clearly marked test note, your saves and logs.

## How work is organised

Every piece of research has an **ID** in the [roadmap](/ROADMAP.md) (`R1.4`, `R17.6` ...). One topic, one branch, one pull request.

### Phases of a topic

| Phase | What you do | Done when |
| --- | --- | --- |
| 1. Claim | Open an issue titled `R1.4: Memory, pools and limits`, or comment on the existing one, and say you're taking it. A maintainer sets the roadmap row to **Claimed** (`@you`, branch name). Claims with no activity for 3 weeks go back to **Open** | The row says Claimed |
| 2. Research | Read the existing guides first, then the sources (decompile, data files, natives, tests). Keep notes outside the repo | You can answer the topic's "What to find out" column |
| 3. Write | Copy [`templates/entry-template.md`](/templates/entry-template.md) into the right folder, fill every section, mark Verified and Known, end with "What this means for modders" and "Open questions" | The page reads on its own |
| 4. Pull request | Push the branch and open a PR (template below). Update the roadmap row to **Done (first pass)** with a link, and the folder's README table | Checks pass, review done |
| 5. Merge | A maintainer squash-merges into `main` | The topic is on `main` |
| 6. Second pass (optional) | Anyone can pick rows from a guide's "Open questions" table as a new small branch | |

### Branch names

| Kind of work | Branch | Example |
| --- | --- | --- |
| A roadmap topic | `research/<ID>-<short-name>` | `research/R1.4-memory-pools` |
| A second pass on a topic | `research/<ID>-pass2-<what>` | `research/R2.2-pass2-flag-names` |
| A file format page | `format/<format>` | `format/ytyp` |
| A tool | `tool/<name>` | `tool/native-crossmap` |
| A worked example | `example/<name>` | `example/spawn-safely` |
| Fixes to existing pages | `fix/<what>` | `fix/broken-links-physics` |
| A new topic for the inbox | `inbox/<what>` | `inbox/train-tracks` |

Always branch from the latest `main`. Keep a branch to one topic; if you find something for another topic, put it in that topic's issue or the inbox.

### Commits and pull requests

- Commit messages start with the ID when there is one: `R1.4: add pool table from gameconfig.xml`.
- PR title: `R1.4: Memory, pools and limits (first pass)`.
- PR description checklist:
  - [ ] Follows the entry template; every claim marked **Verified** or **Known**
  - [ ] Names the game build the facts are from (default: 1.0.3725.0 Legacy)
  - [ ] No game code, extracted files, mod binaries or decompiled mod code
  - [ ] No personal paths, emails or save data
  - [ ] Links work (use repo-root links like `/docs/core/runtime-scripts.md`)
  - [ ] Roadmap row and folder README updated
- Two topics never share a PR. Small fixes can share one.

### Reviews and merging

- A maintainer (or a contributor who has had three PRs merged) reviews for the three rules first, then for clarity.
- Disagreements about a fact are settled with a source: a quote of names or numbers from the decompile, a data file field, or an in-game test anyone can repeat. Write the test in the guide.
- PRs are squash-merged into `main`; `main` is always readable.

## Writing style

- Plain English, short sentences, one idea per paragraph. Tables for anything with more than three items of the same kind.
- Native names as in [NativeDB](https://nativedb.dotindustries.dev/gta5/natives) (`ENTITY::SET_ENTITY_COORDS` or `SET_ENTITY_COORDS`).
- Decompiler names (`func_878`, `Global_102429`) only as pointers inside one build, and say which build.
- Link to other guides with repo-root paths: `[weapons](/docs/gameplay/weapons/weapons.md)`.

## Game version

The guides are written against **GTA V Legacy (the original PC edition), build 1.0.3725.0** (ScriptHookV reports `VER_1_0_3717_0`). Research on a newer build or on GTA V Enhanced is welcome: say so at the top of the page and in the PR. See [setup](/docs/00-getting-started/setup.md).

## Using an AI assistant

Fine, and how most of the existing guides were written. [`CLAUDE.md`](/CLAUDE.md) tells Claude Code (or any assistant) the rules above and the research workflow. You are still responsible for every claim: check what it writes against the sources.
