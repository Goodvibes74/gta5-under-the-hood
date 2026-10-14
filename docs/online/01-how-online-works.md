# How GTA Online works

GTA V is one engine (RAGE) running two modes on the same map: story mode and Online. Both are driven by the same script virtual machine. Online is not a separate game; it is a different set of scripts, a network session, and a set of Rockstar services. This guide describes the layers from the bottom up.

## 1.1 The script virtual machine

- Game logic (missions, shops, menus, properties, phone, HUD) is written by Rockstar in a C-like language, compiled to bytecode (`.ysc`) and run by the engine's script VM. Each running script is a *thread*. **Known.**
- Scripts talk to the engine only through **natives**: about 6,700 engine functions (`ENTITY.SET_ENTITY_COORDS`, `NETWORK.NETWORK_IS_GAME_IN_PROGRESS`, ...). C# and C++ mods call the same natives through ScriptHookV and SHVDN. Reference: [NativeDB](https://nativedb.dotindustries.dev/gta5/natives). **Verified** (reference).
- Scripts share data through **globals** (a large shared memory block, split into numbered blocks) and keep private data in **statics**. `freemode` alone has 20,634 statics. Global indices change with almost every game update, which is why trainers that poke globals break after updates. **Verified** (counts); **Known** (behaviour).
- In this build all 1,143 scripts are in `update\update2.rpf\x64\levels\gta5\script\script_rel.rpf`, apart from 4 Pilot School scripts in `x64w.rpf`. **Verified.**

## 1.2 Boot and the story-to-Online transition

| Script | Role |
| --- | --- |
| `startup` | First script the engine runs. Registers standard globals (`standard_global_reg`) and starts the main scripts. |
| `main_persistent` | Runs in both modes for the whole session. References building, cellphone, dialogue and context controllers, the `am_mp_*` property scripts and every `fm_content_*` mission, so it is the launcher hub. |
| `main` | Story-mode main: family scenes, launchers for golf, tennis, shooting range, taxi missions, strangers and freaks. |
| `maintransition` | The transition between story mode and Online: character selection, the "GTA Online" intro, cloud and stats checks (`HUD_CLOUDFAILMSG`, `HUD_RETRYSTAT` in its strings), then starting `freemode`. 1.8 MB of bytecode, 1,533 native calls. |
| `freemode_init`, `freemode` | The Online main script. `freemode` runs for as long as the player is in an Online session and owns almost everything: the HUD, the interaction menu, blips, ambient events, properties, organisations, the economy hooks, and job launching. |
| `ingamehud`, `pausemenu_multiplayer` | Online HUD and the Online pause menu. |

**Verified:** the script names, their sizes, and the names they reference (`maintransition`, `main_persistent`, `selector`, `ingamehud` and `pausemenu_multiplayer` all reference `freemode`). **Verified in the decompiled code (guide 6):** `maintransition` starts `freemode` with `START_NEW_SCRIPT("freemode", 35250)`. **Known:** the rest of the start order.

## 1.3 The network session

- In Online, every player's game joins a peer-to-peer **session** brokered by Rockstar's matchmaking. One machine is the session host; each *network script* (like `freemode` or a mission controller) also has a script host. **Known.**
- Network scripts call `NETWORK_SET_THIS_SCRIPT_IS_NETWORK_SCRIPT`, then register **broadcast data** (`NETWORK_REGISTER_HOST_BROADCAST_VARIABLES`, `NETWORK_REGISTER_PLAYER_BROADCAST_VARIABLES`): memory that the engine keeps in sync between players. Most Online scripts keep their state there: 423 scripts register as network scripts, 360 register host broadcast data and 354 player broadcast data. **Verified** (decompiled code, guide 6).
- The `NETWORK` namespace has 882 natives in this build: sessions, players, entity ownership and migration, voice, transitions, tunables and much more. **Verified.**
- Without a session, `NETWORK_IS_GAME_IN_PROGRESS` is false, network scripts can't register broadcast data, and most Online scripts stop early or wait forever. This is the main reason Rockstar's Online scripts don't run in story mode. **Known.**

## 1.4 Stats: where the save lives

- Online progress is stored as **stats**, defined in `update.rpf\common\data\mpstatssetup.xml`: **17,933 stats**, of which **13,630 are `ServerAuthoritative="true"`** and 17,177 are per-character (`characterStat="true"`). Examples: `CHAR_XP_FM` (RP), `PROPERTY_HOUSE`, packed booleans like `MP_PSTAT_BOOL0` (64 flags each). **Verified.**
- `mpstatscharactermappingdata.xml` maps per-character stats to the two character slots (`MP0_`, `MP1_`). **Verified** (file); **Known** (purpose).
- Online stats are loaded from and saved to Rockstar's servers, not the local save folder. Story-mode stats are in `spstatssetup.xml` and save locally. **Known.**
- Offline consequence: every unlock, property, vehicle, cash value and mission flag Online keeps in stats has to be kept in the mod's own save files instead.

## 1.5 Money and transactions

- In Online, money changes are not just stat writes. Purchases and payouts go through the **game server**: the script opens a basket (`NET_GAMESERVER_BASKET_START`), adds catalogue items (`NET_GAMESERVER_BASKET_ADD_ITEM`), checks out (`NET_GAMESERVER_CHECKOUT_START`) and waits for the server. The `NETSHOPPING` namespace has 41 such natives, and `MONEY` has 359 more (`NETWORK_SPENT_*`, `NETWORK_EARN_*`). On PC this path is taken whenever `NET_GAMESERVER_USE_SERVER_TRANSACTIONS()` is true, and 291 scripts contain it. **Verified** (natives, and the flow in `clothes_shop_mp`, guide 6).
- Prices come from the server catalogue (`NET_GAMESERVER_GET_PRICE`) and from tunables, though the clothing and vehicle-mod catalogues on disk also carry prices (guide 3). **Verified** (natives, files).
- `networkshop.meta` only lists transaction and action type hashes; there is no local price list for vehicles. **Verified.**

## 1.6 Tunables

- **Tunables** are values Rockstar changes from the server without a game update: prices, payouts, event switches, seasonal content, unlock dates. Scripts read them with `NETWORK_ACCESS_TUNABLE_INT/FLOAT/BOOL(_HASH)` after `NETWORK_REQUEST_CLOUD_TUNABLES`. **Verified** (natives).
- `tunableobjects.meta` on disk is unrelated (physics tuning for 212 objects). **Verified.**
- Offline consequence: every value a script would read from tunables needs a local default. In mods that means constants or ini settings.

## 1.7 Cloud content (UGC)

- Jobs (contact missions, races, deathmatches, many heist missions, adversary modes) are **user-generated-content files** made with Rockstar's own creator, stored on Rockstar's cloud and downloaded by a 22-character content ID when a job launches. `net_cloud_mission_loader` reads their header fields (`mission`, `gen`, `type`, `subtype`, `rank`, `min`, `num`, `start`, ...). **Verified** (strings).
- **575 distinct content IDs** are hard-coded across the scripts (323 in `freemode`, 321 in `fm_mission_controller`, 236 in `fmmc_launcher`, 85 in the job-list app). They point at cloud files that are not in the install. **Verified.**
- **1,001 UGC files do ship locally** in `update2.rpf\common\data\ugc\`. They are JSON in the same format and cover the content Rockstar wanted to work without a download: random events, salvage, dispatch work, business preps and the tutorial (guide 3). **Verified.**
- The players of this content are `fm_mission_controller` (6.1 MB of bytecode, classic jobs and heists) and `fm_mission_controller_2020` (6.3 MB, newer heists such as Cayo Perico), launched through `fmmc_launcher` (the job lobby or "corona"). **Verified** (scripts); **Known** (roles).

## 1.8 Properties, businesses and organisations

- Every Online property is a pair of scripts: an **exterior** script that handles the entrance and buying (`am_mp_property_ext`, `am_mp_smpl_interior_ext`) and an **interior** script that runs inside (`am_mp_property_int` for apartments and garages, plus dedicated ones such as `am_mp_bunker`, `am_mp_nightclub`, `am_mp_hangar`, `am_mp_auto_shop`, `am_mp_mansion`). 70 `am_mp_*` scripts in total. **Verified.**
- Entrances are placed in the world as script triggers in `update.rpf\common\data\levels\gta5\ambient_mp.ipl`: **83 `AM_MP_PROPERTY_EXT` points**, 2 car washes, and the low and medium apartment beds and showers. **Verified.**
- Businesses (VIP/CEO, MC, Gunrunning, Smuggling, Nightclub and later) run their missions as `gb_*` scripts (70, the older organisation work) and `fm_content_*` scripts (97, the modern freemode missions such as acid lab, auto shop, bounties, salvage yard). **Verified.**
- Interiors themselves are map data in the DLC packs and patch packs (`.ymap` and interior archives). A story-mode mod can request the Online IPLs (about 100 are needed for the Online interiors) at start-up.

## 1.9 Freemode world systems

- **Ambient events** (`am_*`, 71 scripts): crate drops, hold-ups, armoured trucks, King of the Castle, Hunt the Beast, gang attacks, taxis, joyriders, contact requests.
- **Phone and computers** (`app*`, 38 scripts): `appinternet` (2.9 MB, the in-game internet), `appmpjoblistnew` (job list), `appmpemail`, `appsecuroserv` (CEO computer), `appbikerbusiness`, `appsmuggler`, `appfixersecurity`, `appbusinesshub` and more.
- **Shops** (28 scripts): `clothes_shop_mp`, `hairdo_shop_mp`, `tattoo_shop`, `carmod_shop` and its property versions (`personal_carmod_shop`, `vinewood_premium_garage_carmod`), `gunclub_shop`, all coordinated by `shop_controller`.
- **Interaction menu**: `am_pi_menu` (3.2 MB, 1,383 native calls).

**Verified** (names and sizes); **Known** (what they do beyond their names).

## 1.10 What depends on Rockstar's servers

| System | Server dependency | Offline replacement |
| --- | --- | --- |
| Session and players | Matchmaking, peer-to-peer session | None needed for single player; AI players are simulated (roadmap section 5) |
| Stats (progress) | Loaded and saved on the server | The mod's own save files |
| Money | Server transactions | Local cash and bank values |
| Prices and switches | Tunables from the cloud | Constants or ini settings |
| Jobs | Downloaded by content ID | The mod's own missions, plus the 1,001 local UGC files |
| Clothing, outfits, vehicles, interiors | None: all on disk | Reused directly |
| Cutscenes, animations, audio | None: all on disk | Reused directly |
