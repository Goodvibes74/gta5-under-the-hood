# Surviving game updates

What a Rockstar update to GTA V breaks in a modded install, how to see it the same day, what to do on update day, and the rules that make a mod survive the next update. Research roadmap area **R11** (R11.1 what breaks, R11.4 update-day checklist, R11.5 rules for code; R11.2 and R11.3 started) in the [roadmap](/ROADMAP.md).

**How it was made.** From what this research has already measured: the build-3725 vs build-3889 decompiles (every script recompiled, 13 new ones), a modded `update.rpf` compared with the vanilla one, the [global map](/docs/core/global-map.md), `ScriptHookV.log`, and a scan of a set of SHVDN mods for memory access. **Verified** where it says so; the rest is **Known** community experience.

## 8.1 Short version

- **The first thing an update breaks is ScriptHookV.** It checks the game build at start-up and refuses to load on a build it doesn't know, so every `.asi`, .NET and Lua mod stops at once. The fix is always the same: wait for a ScriptHookV release that supports the new build. Nothing else can be fixed until then.
- **Archive edits go stale.** A modded copy of `update.rpf` (OpenIV's mods folder) replaces Rockstar's whole archive, so after an update the game reads the **old** archive: new content is missing and old data files override new ones. The test install already shows the effect: a modded `update.rpf` left over from an earlier mod install carries data files from an older build (handling without 8 `CAdvancedData` blocks, an `events.meta` missing 7 event types) (**Verified**).
- **Anything addressed by number moves:** memory offsets, global indices (every global after an inserted one shifts; build 3889 recompiled every script), decompiler function numbers. Mods that use them break silently or crash.
- **Names usually survive:** natives (by hash), script names, data file fields, model and animation names, text labels, IPL names. Mods built on names and natives rarely need more than a rebuild.
- **New content arrives as new DLC packs** that must be listed in `dlclist.xml`. If the mods folder has its own old `update.rpf`, its old `dlclist.xml` hides the new packs.
- **Rules that survive updates:** natives over memory, names over numbers, data in add-on packs instead of edited base archives, timeouts and logging whenever an asset is missing, and a written list of every game asset a mod depends on.

## 8.2 What breaks, and how you notice

| What | Why it breaks | How likely | How you notice the same day |
| --- | --- | --- | --- |
| **ScriptHookV** | Version gate on start-up; the native table for the new build is unknown | Every update | `ScriptHookV.log` reports an unsupported game version; no mod loads at all |
| **SHVDN and .NET mods** | Need ScriptHookV; SHVDN itself rarely needs an update | Every update (through ScriptHookV) | `ScriptHookVDotNet.log` missing or empty |
| **Modded `update.rpf` / `update2.rpf` (mods folder)** | The whole archive is replaced by an old copy | Every update that changes these archives | New DLC missing, new vehicles invisible, odd data (old handling, old weapon stats), sometimes crashes on load |
| **`dlclist.xml`** | Lives inside `update.rpf`; an old modded copy doesn't list the new pack | Every content update | New pack's vehicles, clothes and missions missing |
| **Memory offsets and patterns** | Structures move between builds; byte patterns may no longer match | Most updates | Crash, or a feature silently doing nothing; only logs written by the mod show it |
| **Global indices** | Inserting globals shifts the indices after them | Most updates | Wrong values read; nothing visible until a feature misbehaves |
| **Natives** | Rarely removed or changed; new ones appear | Rare | A native call throwing in SHVDN, or ScriptHookV refusing the call |
| **Asset names** (cutscenes, IPLs, anim dictionaries, models, scaleforms, text labels, coordinates) | Rockstar renames or removes them occasionally | Rare | Loaders time out; with logging, the missing name is in the log |
| **Add-on packs** (cars, maps) | Usually unaffected; can clash with a new Rockstar asset of the same name | Rare | Duplicates or missing models |
| **Legacy vs Enhanced** | Different executables, different tools; mods for one don't load in the other | Not an update issue, but a common mix-up | An ASI loader for the wrong edition (the test install (build 3725) has one, inactive) |

## 8.3 Update day checklist

1. **Don't play on the new build yet.** If possible, delay the update (or keep a backup of `GTA5.exe`, `update\` and the mods folder from the last working build).
2. **Check ScriptHookV.** Read `ScriptHookV.log`. If it rejects the build, wait for the ScriptHookV release that supports it; update `ScriptHookV.dll` and `dinput8.dll` from the official page.
3. **Refresh the mods folder.** Re-copy the new vanilla `update.rpf` (and `update2.rpf` if modded) into the mods folder with OpenIV, then **re-apply only your own edits** from your notes or exported files (`dlclist.xml` lines for add-on packs, any data file edits). Never keep an old modded `update.rpf` on a new build.
4. **Re-scan.** Re-run the DLC scan and the script dump ([online guide 5](/docs/00-getting-started/research-tools.md)) and compare with the previous run: new packs, new scripts, changed sizes.
5. **Check every mod's assumptions.** Memory offsets and patterns first, then globals, then asset names (8.5 shows what to look for). Update the decompile to the new build's commit before trusting any number from it.
6. **Start the game with logging on** and read every mod's log for timeouts and missing assets.
7. **Re-test every mod in game** (a written checklist helps) before calling the install fixed.

## 8.4 Rules for code that survives updates

1. **Natives over memory.** If a native can do it, use the native. Memory writes break on most updates and fail silently.
2. **Names over numbers.** Look things up by name or hash (models, scripts, natives, labels), never by global index, function number or offset.
3. **Read globals only, and only where no native exists;** document the usage pattern so the global can be found again after an update ([global map](/docs/core/global-map.md#65-how-to-use-this)).
4. **Data in add-on packs.** New vehicles, peds, weapons and data changes go in your own DLC pack; edit base archives only when there is no other way, and keep the edit as a small, re-appliable change.
5. **Every load has a timeout and a log line,** naming the asset, so a renamed or removed asset shows up in the log instead of hanging the game.
6. **Keep an asset dependency list:** every cutscene, IPL, animation dictionary, model, scaleform, text label and fixed coordinate a mod uses, in one data file. After an update, check each name against the new build (R11.2).
7. **Pattern scans, if you must touch memory,** with a clear log line when the pattern isn't found, and the feature switched off rather than crashing.

## 8.5 Finding the risky code in a mod

What to search a mod's source for, from highest to lowest risk (found by scanning a set of SHVDN mods, **Verified**):

| Look for | Example | Risk | Safer route |
| --- | --- | --- | --- |
| Fixed memory offsets on an entity address | Writing a model hash at `ped + 32 → + 24` so cutscenes accept a freemode ped | High: offsets move with most updates | A native that does the same job (here `SET_CUTSCENE_PED_COMPONENT_VARIATION_FROM_PED`, [cutscenes guide](/docs/gameplay/missions/cutscenes-and-dialogue.md#66-what-this-means-for-modders)) |
| Byte-pattern scans (`Game.FindPattern`, `Memory::Scan`) | Finding head-blend data by pattern | Medium: patterns survive some updates | Log when the pattern isn't found and switch the feature off; prefer natives (`GET_PED_HEAD_BLEND_DATA`) |
| Hard-coded global indices | `Global_2658291` read from a decompile | High: indices shift every update | Natives, or a documented usage pattern ([global map](/docs/core/global-map.md)) |
| A modded `update.rpf` in the mods folder | Data files from an older build | High: stale from day one of the next update | Re-copy vanilla, re-apply only `dlclist.xml` lines and deliberate edits |
| Natives and names only | Most script mods | Low | Keep it that way |

A quick search for `FindPattern`, `Memory`, `ReadInt`, `WriteInt`, `Marshal`, `IntPtr` and `+ 0x` in a mod's source finds nearly all memory access.

## 8.6 What this means for modders

- **Keep a last-known-good backup** of `GTA5.exe`, `update\` and the mods folder (R11.3), so an unwanted update can be rolled back.
- **Rebuild a stale `update.rpf` before the next update forces it:** start from the current vanilla archive and re-apply only the deliberate edits, so the old data files it carries are gone.
- **Replace memory writes with natives** while the mod still works; it is much harder after an update has broken it.
- **Build the update-check tool** (R11.2): compare `GTA5.exe`'s version with the last known one, re-run the DLC scan and script dump, diff against the saved baseline, and check the asset dependency list.

## 8.7 Open questions

| Question | Where it goes |
| --- | --- |
| The asset dependency list for mods (every name they use) | R11.2, as a data file plus the update-check tool |
| How to stop Steam or the Rockstar launcher from updating, and roll back | R11.3 |
| Which natives changed between 3725 and 3889 | R11.1 second pass, with the native crossmap (R0.3) |
