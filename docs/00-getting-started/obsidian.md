# Reading the repo in Obsidian

The repo is plain Markdown, so it also works as an [Obsidian](https://obsidian.md) vault: graph view, backlinks, quick switcher and full-text search over every guide. This page says how to open it and what to watch for. GitHub stays the main place the docs are written for; nothing here changes how pages are written.

## Open the repo as a vault

1. Clone the repo (or use your existing checkout).
2. In Obsidian, choose **Open folder as vault** and pick the repo folder itself, not a subfolder. Every guide under `docs/`, `file-formats/`, `scripting/` and `modding/` is then in the vault, together with `README.md`, `ROADMAP.md`, `OPEN_QUESTIONS.md`, `HANDOFF.md` and `DATA-NEEDS.md`.
3. Obsidian creates a `.obsidian/` folder for its settings. It is listed in `.gitignore`: keep it on your machine and never commit it (the `file-rules` check only allows Markdown).

## Recommended settings

| Setting | Where | Value | Why |
| --- | --- | --- | --- |
| Use `[[Wikilinks]]` | Files and links | Off | The docs use normal Markdown links so they work on GitHub |
| New link format | Files and links | Absolute path in vault | Closest to the repo's style; add the leading `/` by hand (see below) |
| Automatically update internal links | Files and links | Off | A rename in Obsidian rewrites links without the leading `/`, which breaks them on GitHub. Rename files with git instead |
| Excluded files | Files and links | `graphify-out/cache/`, `templates/`, `tools/`, `examples/`, `.github/` | Keeps machine files, the template's placeholder links and non-guide folders out of search and the graph |
| Daily notes | Core plugins | Off | Stops dated notes appearing in the repo root |
| Template folder location | Core plugins, Templates | `templates` | Insert the [entry template](/templates/entry-template.md) into a new page |
| Graph colour groups | Graph view, Groups | `path:docs/`, `path:file-formats/`, `path:scripting/`, `path:modding/` | One colour per part of the repo |
| Bookmarks | Bookmarks pane | `README.md`, `ROADMAP.md`, `OPEN_QUESTIONS.md`, `HANDOFF.md`, `DATA-NEEDS.md` | The repo's entry points |

There are no separate index or "map of content" notes: the [README](/README.md) and each folder's `README.md` already list every page in that folder, and the [roadmap](/ROADMAP.md) links every topic.

## How the links behave

| Link in the docs | Count (all `.md` files) | In Obsidian |
| --- | --- | --- |
| Root-relative, `[boot](/docs/00-getting-started/boot.md)` | about 2,590 | Opens the note: a leading `/` is read as the vault root |
| Plain relative, `[setup](setup.md)`, `[index](../native-usage-index.md)` | about 350 | Opens the note |
| With a GitHub-style anchor, `boot.md#341-the-level-indexes-second-pass` | about 530 to other pages, 270 on the same page | Opens the note, but may not jump to the section: Obsidian matches anchors against the heading text, not GitHub's lower-case, hyphenated slug. Use the Outline pane to find the section |
| To a folder or a non-Markdown file (`/tools`, `/examples/01_HelloWorld.cs`) | about 30 | Not opened inside Obsidian (excluded or unsupported file type); follow it on GitHub |

Counted with `grep` over every tracked `.md` file on `main` at the time of writing.

When you add a link while editing in Obsidian, write it the repo's way: a Markdown link with a leading `/` from the repo root, and a GitHub-style anchor if you link to a section. Obsidian's own link picker writes `docs/...` without the slash and `#Heading%20text` anchors, which do not work on GitHub.

## The knowledge graph

`graphify-out/GRAPH_REPORT.md` opens like any note and lists the communities and hub nodes of the [knowledge graph](/CLAUDE.md#knowledge-graph-read-this-before-opening-docs). The rest of `graphify-out/` (`graph.json`, `graph.html`, the cache) is not Markdown: open `graph.html` in a browser. Obsidian's own graph view is separate: it is built from the links between notes, not from graphify.
