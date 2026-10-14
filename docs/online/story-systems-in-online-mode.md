# Story systems that clash with an Online mode

Which story-mode systems keep running when a mod turns story mode into an "Online" mode without a real session, how Rockstar's own transition switches them off, and how a mod can do the same cleanly: the phone, shops, ATMs, restricted areas, family scenes, friends, strangers, random events and ambient launchers. Roadmap topic **R5.7** in the [roadmap](/ROADMAP.md). Builds on [engine guide 2](/scripting/script-vm.md#26-force-cleanup) (force cleanup) and [guide 1](/docs/gameplay/missions/story-script-catalog.md) (script brains).

**How it was made.** For 30 story systems, the build-3725 decompile was searched for each script's force-cleanup registration, its `NETWORK_IS_GAME_IN_PROGRESS` checks, whether it is a network script, and who starts it. The brain registrations were read from `standard_global_init`, and the brain-set switches from `maintransition`, `main_persistent`, `standard_global_reg`, `spawn_activities` and `fm_maintain_transition_players`. **Verified** unless marked.

## 7.1 Short version

- **A real switch to Online stops story mode in two moves:** force cleanup **bit 2** (every story controller that registered for it ends), and the **brain sets**: Online disables sets 1 and 4 (story world and object brains) and enables 2 and 8 (Online ones). Story mode does the reverse (`standard_global_reg` enables set 1).
- **A mod that fakes Online inside story mode does neither**, so every story system keeps running: strangers and random events keep triggering, family scenes play at Michael's house, the story shops open story menus for a freemode character, Lester's and Franklin's TV and drinks objects still work, story friends call.
- **Shops are run by one always-on script, `shop_controller`**, which survives bit 2. It manages about 65 shops by index (23 Ammu-Nations, 8 tattoo parlours, 7 mod shops, the clothes stores and barbers) and, near each, starts that shop's script, choosing `clothes_shop_sp` or `clothes_shop_mp` and `hairdo_shop_sp` or `hairdo_shop_mp` by `NETWORK_IS_GAME_IN_PROGRESS()`. In a fake-Online mode it starts the **story** versions.
- **ATMs, vending machines, telescopes, laptops and beds are object brains:** scripts that start when the player comes near a model (`prop_atm_01` → `atm_trigger`). Some are story-only (set 1), some Online-only (set 8), some both (set 9).
- **The phone (`cellphone_controller`) and `building_controller` never stop:** they run in story and Online alike, so a custom Online phone has to coexist with Rockstar's.
- **The clean way for a mod:** disable brain set 1 (and 4), enable set 8 where its scripts don't need a network session, and stop the controllers with the same cleanup they expect, instead of killing scripts by name (which `main` and the brains undo).

## 7.2 How each system ends (force cleanup)

Each story script registers a force-cleanup mask with `HAS_FORCE_CLEANUP_OCCURRED(mask)`; when any of those bits is raised, it cleans up and ends. Bit 2 is the move to Online ([engine guide 2](/scripting/script-vm.md#26-force-cleanup)).

| System | Script | Lines | Mask (bits) | Ends on the move to Online? | Notes |
| --- | --- | --- | --- | --- | --- |
| Shops (manager) | `shop_controller` | 450,584 | 96 (32, 64) | **No** | Started by `main_persistent`; runs in both modes |
| Clothes (story) | `clothes_shop_sp` | 358,311 | 66 (2, 64) | Yes | Started by `shop_controller` |
| Clothes (Online) | `clothes_shop_mp` | 369,467 | none | | Network script |
| Barber (story / Online) | `hairdo_shop_sp` / `_mp` | 172,117 / 207,814 | 66 / none | Yes / | |
| Tattoo | `tattoo_shop` | 140,782 | 66 | Yes | One script for both modes; network-capable |
| Ammu-Nation | `gunclub_shop` | 190,850 | 66 | Yes | Both modes ([weapons guide](/docs/gameplay/weapons/weapons.md#49-ammu-nation-in-story-mode)) |
| Los Santos Customs | `carmod_shop` | 401,808 | 66 | Yes | Both modes; also started inside Online vehicles and properties |
| Wardrobe | `wardrobe_sp` / `wardrobe_mp` | 508,760 / 509,420 | 2 / none | Yes / | `wardrobe_mp` started by `shop_controller` |
| Phone | `cellphone_controller` | 7,784 | none | **No** | Started by `main_persistent`; runs in both modes |
| Phone in hand | `cellphone_flashhand` | 7,322 | none | | Started by `cellphone_controller` |
| Contacts app | `appcontacts` | 15,881 | none | | |
| Email | `email_controller` | 7,027 | 34 (2, 32) | Yes | |
| Calls and texts queue | `comms_controller` | 13,839 | 82 (2, 16, 64) | Yes | Story calls and texts |
| ATMs | `atm_trigger` | 4,929 | 3 (1, 2) | Yes | Object brain, both modes |
| Restricted areas | `restrictedareas` | 1,652 | 34 | Yes | Wanted level at the military base, prison, airport |
| Family scenes | `family_scene_m` (and `_f0`, `_f1`, `_t0`, `_t1`) | 123,691 | 66 | Yes | Michael's family at home |
| Friends | `friends_controller`, `friendactivity` | 42,691 / 123,181 | 34 / 35 | Yes | Story friends calling, hang-outs |
| Strangers and freaks | `randomchar_controller` | 6,387 | 34 | Yes | |
| Vehicle generators | `vehicle_gen_controller` | 37,589 | 98 (2, 32, 64) | Yes | The story characters' parked cars |
| Pickups | `pickup_controller` | 2,881 | 34 | Yes | Story pickups |
| Taxis | `taxilauncher` | 6,426 | 34 | Yes | |
| Stock market | `stock_controller` | 5,776 | 2 | Yes | |
| Save bed | `savegame_bed` | 95,458 | 2 | Yes | |
| Story blips | `blip_controller` | 2,798 | 2 | Yes | |
| Emergency calls | `emergencycalllauncher` | 1,252 | 34 | Yes | |
| Buildings | `building_controller` | 11,723 | none | **No** | Map states (destroyed or repaired buildings) in both modes |

## 7.3 Script brains and brain sets

`standard_global_init` registers the brains (**Verified** counts): 99 world-point brains (a script starts when the player comes within a radius of a place) and 47 object brains (when the player comes near a model), each with a **brain set** bit mask:

| Set | World points | Objects | What's in it |
| --- | --- | --- | --- |
| 1 | 93 | 19 | Story: random events (`re_*`), strangers and freaks launchers (`launcher_Abigail`, `launcher_Epsilon` ...), the street performers and odd people (`gpb_Mime`, `gpb_Jesse`, `gpb_Zombie` ...), `ShopRobberies`, `chop`, `UFO`, `flyUnderBridges`, `fairgroundHub`; objects like `ob_tv`, `ob_franklin_beer`, `ob_bong`, darts boards |
| 8 | 5 | 13 | Online: `AM_MP_PROPERTY_EXT`, `AM_MP_GARAGE_CONTROL`, `AM_MP_CARWASH_LAUNCH`; beds, showers and laptops in Online properties (`ob_mp_bed_high`, `laptop_trigger`) |
| 9 (1 and 8) | 1 | 15 | Both modes: `act_cinema`; ATMs (`prop_atm_01` to `_03`, `prop_fleeca_atm` → `atm_trigger`), vending machines (`ob_vend1`, `ob_vend2`), telescopes, shop tills (`ob_cashregister`) |

Sets 2 and 4 hold the ped brains (scripts attached to random peds) (**Known**).

**Who switches the sets** (**Verified**):

| Script | Calls, in order |
| --- | --- |
| `standard_global_reg` (story boot) | enable 1 |
| `maintransition` (to and from Online) | disable 2, 4, 8, enable 1 (back to story); disable 1, 4, 8, 2; disable 1, 4, enable 2, 8 (into Online) |
| `main_persistent` | disable 1, 4, enable 2, 8 when Online starts; disable 1 |
| `fm_maintain_transition_players` | disable 1, 4, enable 2, 8 |
| `spawn_activities` | enable 8, 2 |

So **Online = sets 2 and 8 on, 1 and 4 off; story = set 1 on, 2, 4 and 8 off.**

## 7.4 The shops in detail

`shop_controller` keeps a table of shops (about 65 entries) with, for each: its script name, its position, whether it is open in this mode, and flags. Each frame it checks distance and conditions and, when the player is near an open shop, requests and starts the shop's script with `START_NEW_SCRIPT_WITH_ARGS` (the shop index as argument; stack 3,750 for `carmod_shop`, 2,324 for the others) (**Verified**). Per shop index it returns one of: `gunclub_shop` (23 shops), `tattoo_shop` (8), `carmod_shop` (7), `clothes_shop_sp` or `clothes_shop_mp`, `hairdo_shop_sp` or `hairdo_shop_mp`, chosen by whether a network game is running.

Consequences:

- In story mode with a freemode character, walking into a clothes store starts `clothes_shop_sp`, which is written for Michael, Franklin and Trevor's wardrobes, not for the freemode ped's components (**Known**: the story shop menus list story outfits). The Online clothes and barber scripts are network scripts and won't run without a session.
- The tattoo, gun and mod shops are single scripts that handle both modes and check `NETWORK_IS_GAME_IN_PROGRESS` hundreds of times (257 to 638 checks each), so in a fake-Online mode they behave as story shops (story prices, story unlocks, story characters' stats).
- `shop_controller` itself never ends, so its shops reappear even after a mod kills a shop script; it simply starts it again next time the player walks in.

## 7.5 What this means for modders

- **Don't kill story scripts by name.** `main` restarts the controllers it watches, the brains restart their scripts when the player comes back in range, and `shop_controller` restarts its shops ([engine guide 1](/docs/core/runtime-scripts.md#18-what-this-means-for-modders)). Killing by name is a fight that has to be repeated every frame.
- **Switch brain sets like Rockstar does.** In a fake-Online mode: `DISABLE_SCRIPT_BRAIN_SET(1)` and `(4)` stops strangers, random events, ambient launchers and story objects at the source; enabling set 8 only helps for its non-network scripts (beds, showers and laptops are object scripts; the property and garage controllers need a session). Put the sets back when the mod returns to story mode. Needs an in-game test.
- **Shops need their own front ends.** Since story shops start for a freemode character and Online shops need a session, a mod's clothes and barber shops have to be built from scratch, at the same 14 clothes and 7 barber locations, with the data from `clothes_shop_mp`'s catalogues ([online guide 3](/docs/online/03-online-data-files.md)). Also block `shop_controller`'s story shop at those spots, or the story menu opens on top.
- **The phone is shared.** `cellphone_controller` always runs, so a custom phone must keep Rockstar's closed.
- **Restricted areas and story pickups** end only with bit 2, so in a fake-Online mode the military base still gives a wanted level and story pickups still spawn. Decide per system whether that's wanted.

## 7.6 Test cards

1. **Brain sets.** In story mode, call `DISABLE_SCRIPT_BRAIN_SET(1)`, drive past a stranger launcher or random-event spot: nothing should trigger. `ENABLE_SCRIPT_BRAIN_SET(1)` brings them back.
2. **Shop restart.** Kill `clothes_shop_sp` while standing in a clothes store, walk out and back in: `shop_controller` should start it again.

## 7.7 Open questions

| Question | Where it goes |
| --- | --- |
| The full shop table (index, position, type) from `shop_controller` | Second pass; feeds shop mods |
| What exactly `clothes_shop_sp` does with a freemode ped (refuses, shows story stock, or breaks) | In-game test |
| What sets 2 and 4 contain (ped brains) | Second pass |
| How bits 16, 32 and 64 in these masks are raised (they end some systems on other occasions) | R1.2 second pass |
