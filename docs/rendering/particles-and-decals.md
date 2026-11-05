# Particles and decals

Where GTA V's particle effects live and how they are loaded, what data ties them to weapons, wheels, materials, explosions and scripts, how decals (blood, bullet holes, tyre marks, footprints) are defined, the limits on both, and how scripts start, colour and clean them up. Roadmap topic **R13.3** in the [roadmap](/ROADMAP.md). Builds on [streaming](/docs/core/streaming.md) (`REQUEST_NAMED_PTFX_ASSET` and friends), [memory, pools and limits](/docs/core/memory-and-pools.md) and [archives and content](/docs/core/archives-and-content.md). Explosion and fire effects are in R2.5; screen effects (`ANIMPOSTFX_*`) in R13.2.

**How it was made.** Every file in the vanilla archives (the root `.rpf` files, `update\update.rpf` and all DLC packs, 384,774 entries) was listed with CodeWalker's library (as [`tools/rpf-cw.ps1`](/tools/README.md) does) and the particle dictionaries (`.ypt`) counted by name. The update copies of the effect data files in `common:/data/effects/` (`decals.dat`, `scriptfx.dat`, `entityfx.dat`, `materialfx.dat`, `weaponfx.dat`, `wheelfx.dat`, `bloodfx.dat`, `explosionfx.dat`, `liquidfx.dat`) and `common:/data/gameconfig.xml` were read; DLC `content.xml` files were read with [`tools/dlc-scan.ps1`](/tools/README.md). Native use from the [GRAPHICS](/scripting/native-usage/GRAPHICS.md) and [STREAMING](/scripting/native-usage/STREAMING.md) usage pages; asset names scripts request counted with one `git grep -o` over every decompiled script (commit `6c18d3e8b`, literal names only). Build 1.0.3725.0 Legacy. Counts and values are **Verified**; what the engine does with them is **Known** unless stated.

## Short version

- **364 particle dictionaries** (`.ypt`), each in up to three quality copies: `ptfx.rpf`, `ptfx_hi.rpf` and `ptfx_lo.rpf` (422, 403 and 403 files across all archives). 169 come from the base game, 192 only from DLC packs, 3 only from the update. By name: `scr_` (script effects) 195, `cut_` (cutscenes) 81, `des_` (destruction) 27, `veh_` 24, `weap_` 24, plus `core` (the always-loaded common effects).
- **Data files tie effects to events:** `entityfx.dat` (517 rows, effects on objects and vehicles), `wheelfx.dat` (283, tyres per surface), `weaponfx.dat` (251, muzzle and impact effects), `materialfx.dat` (218, impacts per material), `bloodfx.dat` (179), `explosionfx.dat` (32 explosion visuals, R2.5) and `scriptfx.dat` (140 rows mapping 140 scripts to 77 script effect dictionaries).
- **Decals are a table:** `decals.dat` defines 259 decal rows with 211 IDs over 26 textures: bullet holes (`fxdecal_bullet_bangs` 37 rows, shotgun 12), splatters (blood, mud, paint, water; 31), footprints (25), tyre marks (18 + 12 + slick 12), glass (14 + 4), petrol trails (12), pools (blood, water, oil).
- **Limits:** `gameconfig.xml` gives the `PtFxAssetStore` pool 400 slots and `PtFxSortedEntity` 384, and each script is expected to hold at most 61 particle effects and 20 particle assets at once (`ConfigScriptResourceExpectedMaximums`: `PTFX` 61, `PTFX_ASSET` 20). The number of decals alive at once is fixed in the executable (**Known**); community "decal limit" patches raise it.
- **Scripts load an asset, then start effects:** `REQUEST_NAMED_PTFX_ASSET` (276 scripts, 995 calls) then `USE_PARTICLE_FX_ASSET` (267 scripts) before each `START_PARTICLE_FX_*`. Looped effects are the common kind: `START_PARTICLE_FX_LOOPED_ON_ENTITY` (312 scripts), stopped with `STOP_PARTICLE_FX_LOOPED` (344).
- **Scripts name 101 different dictionaries;** the most shared are Online ones (`scr_ch_finale` in 15 scripts, `scr_xm_submarine` 13, `scr_xs_props` and `scr_xs_pits` 12, `scr_ba_club` 12), and `core_snow` (8).

## Where it lives

| File or archive | What it holds | Count (build 3725) |
| --- | --- | --- |
| `x64/data/effects/ptfx.rpf`, `ptfx_hi.rpf`, `ptfx_lo.rpf` (base, `update.rpf`'s `x64/patch/...` and `dlc_patch/...`, DLC packs) | Particle dictionaries (`.ypt`): emitters, textures, models for a family of effects | 364 names, 1,228 files |
| `common:/data/effects/scriptfx.dat` | Which effect dictionary each script uses by default | 140 rows, 77 dictionaries; 23 DLC packs add their own (`SCRIPTFX_FILE`) |
| `common:/data/effects/entityfx.dat` | Effects attached to object and vehicle events (breaking, burning, collisions) | 517 rows |
| `common:/data/effects/materialfx.dat` | Impact and scrape effects per material pair | 218 rows |
| `common:/data/effects/weaponfx.dat` | Muzzle flashes, shells, impacts per weapon effect group | 251 rows |
| `common:/data/effects/wheelfx.dat` | Tyre smoke, dust, mud and water per surface | 283 rows |
| `common:/data/effects/bloodfx.dat` | Blood effects and the decals they leave | 179 rows |
| `common:/data/effects/explosionfx.dat` | Explosion visuals and the fires they leave | 32 rows (R2.5) |
| `common:/data/effects/decals.dat` | Decal definitions | 259 rows, 211 IDs, 26 textures |
| `update:/x64/data/effects/vfxpedinfo.ymt`, `vfxvehicleinfo.ymt`, `vfxinteriorinfo.ymt` | Per-ped, per-vehicle and per-interior effect settings (footprints, exhaust, interior dust) | Binary metadata |
| `common:/data/gameconfig.xml` | Pools and per-script maximums | `PtFxAssetStore` 400, `PtFxSortedEntity` 384, `MaxAttrsParticle` 2,500, `PTFX` 61 and `PTFX_ASSET` 20 per script |

### Particle dictionaries

**Verified (counts):** 364 distinct `.ypt` names. Most exist three times, one per particle quality setting (**Known**: `ptfx_lo` for low, `ptfx` for normal, `ptfx_hi` for high and very high), so the same effect name works at every setting. By prefix:

| Prefix | Dictionaries | What |
| --- | ---: | --- |
| `scr_` | 195 | Script effects for missions, activities and Online content (`scr_ch_finale`, `scr_agencyheist`, `scr_rcbarry1` ...) |
| `cut_` | 81 | Cutscene effects |
| `des_` | 27 | Destruction scenes (rayfire objects: `des_train_crash` ...) |
| `veh_`, `weap_`, `wpn_` | 24, 24, 4 | Vehicle effects (exhaust, mods, mounted weapons) and weapon effects |
| `proj_` | 4 | Projectiles (flares, rockets) |
| `core` | 1 | Always loaded: fire, smoke, water, blood, sparks, glass |

Scripts reach their effects in two ways: `REQUEST_PTFX_ASSET()` (144 scripts) loads the dictionary that `scriptfx.dat` assigns to the calling script (for example `agency_heist3a` gets `scr_agencyheist`, `barry1` gets `scr_rcbarry1`), and `REQUEST_NAMED_PTFX_ASSET(name)` (276 scripts) loads any dictionary by name (**Known**).

### Decals

**Verified (data):** `decals.dat` groups its rows by use:

| Group | Textures | Rows |
| --- | --- | ---: |
| Bullet holes | `fxdecal_bullet_bangs`, `fxdecal_bul_shotgun`, `fxdecal_bullet_ap`, `fxdecal_bangs`, `fxdecal_concrete_impact`, `fxdecal_concrete_bang` | 57 |
| Splatters (blood, directional blood, mist, mud, paint, water, hydrant, scripted blood) | `fxdecal_splatter_mist` | 31 |
| Footprints (human shoe and barefoot per surface, animals) | `fxdecal_footprints` | 25 |
| Tyre tracks and skids | `fxdecal_tyre_01`, `_02`, `fxdecal_tyre_slick_01`, `_02`, `fxdecal_track_alt_01`, `_02` | 44 |
| Glass | `fxdecal_glass`, `fxdecal_glass_resistant` | 18 |
| Petrol trails | `fxdecal_petrol_trail` | 12 |
| Pools (blood, water, oil, on solid and porous ground) | `fxdecal_blood_pool` 1 to 3, `pool_solid`, `pool_porous_solid`, `pool_porous_water`, `pool_water` | 16 |
| Scrapes | `fxdecal_scrapes` | 4 |
| Rows with no texture (variants that reuse the row above) | `-` | 52 |

Each row sets the texture atlas cell (row and column ranges), size, fade time, specular and parallax values, whether the decal can be washed off by rain or water, whether it can appear underwater, and whether it rotates to face the camera. The footprint rows are referenced from `vfxpedinfo` (the file's own comment says so).

**Known (engine):** decals are kept in a fixed-size list; when it is full, the oldest are removed, which is why bullet holes and blood vanish during long fights. Rain washes "washable" decals over time.

## How scripts use them

| Native | Scripts | Calls | Use |
| --- | ---: | ---: | --- |
| `REQUEST_NAMED_PTFX_ASSET`, `REMOVE_NAMED_PTFX_ASSET` | 276, 258 | 995, 527 | Load and free a dictionary by name |
| `REQUEST_PTFX_ASSET`, `HAS_PTFX_ASSET_LOADED`, `REMOVE_PTFX_ASSET` | 144, 144, 104 | 314, 304, 149 | The script's own dictionary from `scriptfx.dat` |
| `USE_PARTICLE_FX_ASSET` | 267 | 1,425 | Choose the dictionary for the next `START_*` call |
| `STOP_PARTICLE_FX_LOOPED`, `DOES_PARTICLE_FX_LOOPED_EXIST` | 344, 341 | 1,280, 2,272 | Looped effect housekeeping |
| `REMOVE_PARTICLE_FX_IN_RANGE` | 330 | 1,954 | Clear effects around a point (mission cleanup) |
| `START_PARTICLE_FX_LOOPED_ON_ENTITY`, `..._ON_ENTITY_BONE`, `..._AT_COORD`, `..._ON_PED_BONE` | 312, 42, 84, 14 | 674, 117, 238, 18 | Smoke, fire, sparks that keep going |
| `START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE`, `..._ON_ENTITY`, `..._AT_COORD`, `..._ON_PED_BONE` | 247, 65, 64, 29 | 268, 141, 202, 78 | One-shot bursts |
| `SET_PARTICLE_FX_LOOPED_EVOLUTION`, `_COLOUR`, `_ALPHA`, `_OFFSETS` | 270, 55, 29, 32 | 662, 117, 53, 48 | Change a running effect (strength, colour) |
| `SET_PARTICLE_FX_CAM_INSIDE_VEHICLE` | 291 | 307 | Hide effects that would clip the in-car camera |
| `SET_PARTICLE_FX_OVERRIDE` / `RESET_PARTICLE_FX_OVERRIDE` | 12 / 15 | 80 / 99 | Swap a built-in effect for another (Online) |
| `START_NETWORKED_PARTICLE_FX_*` | 13 to 34 | | Online versions, seen by everyone |
| `SET_DISABLE_DECAL_RENDERING_THIS_FRAME` | 248 | 255 | Hide decals (shared helper code) |
| `ADD_DECAL`, `REMOVE_DECAL`, `IS_DECAL_ALIVE` | 39, 28, 14 | 220, 304, 202 | Script decals (blood pools, paint, Online spray tags) |
| `REMOVE_DECALS_IN_RANGE`, `REMOVE_DECALS_FROM_VEHICLE`, `REMOVE_DECALS_FROM_OBJECT` | 89, 22, 12 | 219, 42, 28 | Clean up |
| `PATCH_DECAL_DIFFUSE_MAP` / `UNPATCH_DECAL_DIFFUSE_MAP` | 11 / 9 | 47 / 24 | Swap a decal's texture (custom spray tags) |
| `GET_IS_PETROL_DECAL_IN_RANGE` | 28 | 30 | Is there a petrol trail here |

## Effect files, dictionaries and mounting (leftovers pass)

**Verified**, build 1.0.3725.0 Legacy: the effect `.dat` files read from `common.rpf` and the update (`materialfx.dat` has no update copy), every `.ypt` loaded with CodeWalker's library (1,228 files, 364 distinct names once the update's copies win), and every DLC pack's `content.xml` and `setup2.xml`.

**The three `.dat` files explain their own columns** in comment headers. Each is a version number, then named sections, each a table between `<NAME>_START` and `<NAME>_END`:

| File (version) | Sections and rows (update copy) | Columns |
| --- | --- | --- |
| `entityfx.dat` (8.00) | `ENTITYFX_AMBIENT_PTFX` 226, `FRAGMENTFX_BREAK_PTFX` 18, `ENTITYFX_COLLISION_PTFX` 9, `FRAGMENTFX_DESTROY_PTFX` 65, `ENTITYFX_SHOT_PTFX` 27, `ENTITYFX_ANIM_PTFX` 24, `ENTITYFX_RAYFIRE_PTFX` 143, `ENTITYFX_INWATER_PTFX` 3, and four decal sections, all empty | Every row: a tag, the particle dictionary and the effect name. Ambient rows add creation thresholds (ignore rotation, always, sun, rain, wind), a temperature and time-of-day window, evolutions for rain, wind and temperature, a night probability and a triggered-effect time range. Collision rows add a collision point and an impulse range; destroy rows a no-trigger explosion range; in-water rows a speed range |
| `materialfx.dat` | `MTLFX_TABLE` (a grid of material against material, 69 rows, each cell an index into the info lists), `MTLFX_BANG_INFO` 84 rows, `MTLFX_SCRAPE_INFO` 63 rows | Info rows: an id, a speed range, an impulse range, a skip-under-water switch, the effect, a decal id, a tint, the texture width and length range, an overlay limit and a duplicate-reject radius. Statics get tiling scrape textures, moving objects and vehicles single ones (the file's own note) |
| `wheelfx.dat` (14.00) | `VEHFX_INFO`, `_BURST`, `_WET`, `_BURST_WET`: 69 rows each, one per surface | The surface's group, slip and pressure thresholds, three skid-mark decals and a tint, friction effects (threshold and three effects), displacement effects (three plus a LOD one), burnout effects with friction and temperature evolutions, and a light (on, colour range, intensity, range, falloff) |

So a wheel on a surface picks one of the four wheel tables (normal, burst tyre, wet, burst and wet) by its state and its surface's row; an impact looks up the two materials in the grid and plays the bang or scrape row the cell points at.

**Dictionaries and effects.** The 364 dictionaries hold **2,907 effects (2,541 different names)**. `core` alone has 964 (impacts, blood, fire, wheels, water, ambient effects); the next largest are `scr_hr_lny_races` (46), the cutscene dictionaries (`cut_xm3` 30, `cut_prologue` 28, `cut_finale1` 27) and `scr_sum2_hal` (30). By name: `scr_` (script effects) 809, `ent_` 492, `cs_` 251 (cutscenes), `veh_` 141, `exp_` 118, `cut_` 111, `muz_` 83 (muzzle flashes), `wheel_` 69, `water_` 66, `eject_` 53 (shell casings), `bul_` 49. 26 DLC packs ship 138 dictionaries with 745 effects (`mpchristmas2017` 103, `mp2024_02` 95). The name lists themselves come from any `.ypt` with CodeWalker; they are not copied here.

**Mounting.** All 33 DLC packs that ship particles (a `ptfx.rpf`) switch it on in their `*_AUTOGEN` change set, and every one of those change sets is in the pack's `GROUP_STARTUP` group. None is in `GROUP_ON_DEMAND`. So DLC particle dictionaries are mounted at start-up, before story mode or Online is chosen, and a story-mode script can request them (*our reading*, from the group names in [change-set groups](/docs/core/archives-and-content.md#861-the-change-set-groups-second-pass); the moment each group runs is **Known**, not checked).

### The decal-definition limit in the executable (PC executable pass)

**Verified** in a read-only copy of the decrypted executable, analysed in Ghidra ([boot 3.4.1](/docs/00-getting-started/boot.md#341-the-level-indexes-second-pass) says how it was taken). One engine function reads `decals.dat` (the `decal` file, between `DECAL_DEF_START` and `DECAL_DEF_END`, skipping `#` comment lines) into a fixed array of 80-byte decal definitions, and simply stops adding rows once a counter reaches the array's size. So the "decal limit" that patches raise is this definition table, not the number of decals on screen.

The copy was taken with mods loaded, including a decal-limit patch, and in it the check reads 620 and the array sits outside the game's own memory: that is the patch's setting (`DecalDefs = 620`) and its moved array, not Rockstar's. The patch's own config gives 512 as the minimum it accepts, which is the vanilla size (**Known**, from the patch). Vanilla `decals.dat` has 259 rows, so an add-on pack with more than about 250 extra decal definitions needs such a patch. The vanilla number itself needs a copy taken with no mods loaded.

## What this means for modders

- **Play an effect:** `REQUEST_NAMED_PTFX_ASSET("core")`, wait for `HAS_NAMED_PTFX_ASSET_LOADED`, then `USE_PARTICLE_FX_ASSET("core")` right before `START_PARTICLE_FX_NON_LOOPED_AT_COORD(effectName, ...)` or a looped call, with an effect name from that dictionary. Keep the handle of a looped effect and `STOP_PARTICLE_FX_LOOPED` it; `REMOVE_NAMED_PTFX_ASSET` when done.
- **Find effect names** inside the `.ypt` files with CodeWalker; the dictionary names are in the table above. Use the base-game or update dictionaries in story mode; Online-only DLC dictionaries may not be mounted in every situation (**Known**).
- **Stay under the limits:** a script should hold at most 20 dictionaries and 61 effects at once (the expected maximums), and the whole game 400 loaded dictionaries. Effects cost GPU time, the high-quality copies most.
- **New effects** need a new `.ypt` in your own DLC pack, registered in `content.xml` (`PTFXASSETINFO_FILE`, used by 11 vanilla packs, **Known**); editing `.ypt` files needs a particle tool.
- **Decals:** `ADD_DECAL(type, x, y, z, ...)` with an ID from `decals.dat` (for example a blood pool), and `REMOVE_DECAL` when done. Raising the decal limit needs an executable patch, not a data edit; link to such patches rather than shipping them, and expect them to break on game updates.
- **Single player only.**

## Open questions

| Question | Where it goes |
| --- | --- |
| The exact decal limit in build 3725 and what limit patches change | Partly answered in [the decal-definition limit](#the-decal-definition-limit-in-the-executable-pc-executable-pass): the limit is the size of the definition table (80-byte entries) that patches move and enlarge; vanilla 512 is **Known** from the patch, to confirm with a mod-free copy of the executable |
| How the particle quality setting picks between `ptfx`, `ptfx_hi` and `ptfx_lo` | Test card 2; R18.2 |
| The format of `entityfx.dat`, `materialfx.dat` and `wheelfx.dat` row by row | Answered in [effect files, dictionaries and mounting](#effect-files-dictionaries-and-mounting-leftovers-pass) |
| Which DLC dictionaries are mounted in story mode | Answered in [effect files, dictionaries and mounting](#effect-files-dictionaries-and-mounting-leftovers-pass): all of them, at start-up (`GROUP_STARTUP`) |
| Which effect names each dictionary holds (an index) | Answered in [effect files, dictionaries and mounting](#effect-files-dictionaries-and-mounting-leftovers-pass): counts per dictionary and by name family; the names themselves are read with CodeWalker |

## Test cards

1. **Script effect.** Load `core`, start a smoke effect from it (look the name up in `core.ypt` with CodeWalker) looped on the player, stop it after 10 s. Expected: smoke for 10 s, then it fades.
2. **Quality copies.** Set particle quality to Low, then Very High, and fire a minigun into a wall. Expected: fewer, simpler sparks and smoke on Low.
3. **Decal limit.** Shoot a wall with a full magazine several times and count bullet holes. Expected: the oldest disappear after a fixed number.
