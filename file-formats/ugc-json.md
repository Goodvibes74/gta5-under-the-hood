# UGC mission files (JSON)

The mission-creator format. GTA Online's own jobs use it too: 1,001 local files ship in `update\update2.rpf\common\data\ugc\`.

Top-level keys are `meta` (locations, vehicle hashes, weapons) and `mission`, which holds sections such as `gen` (general settings and the title in `nm`), `cover`, `door`, `dprop` (props), `endcon` (end conditions) and more. What is known so far: [Online data files](/docs/online/03-online-data-files.md). Documenting every key is roadmap topic R7.4: a good first contribution.
