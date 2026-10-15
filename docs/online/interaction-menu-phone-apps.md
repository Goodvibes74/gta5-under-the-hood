# Interaction menu, phone and apps

How the phone and the Online interaction menu are built: the two phone scripts and the app table they launch from, the app scripts (contacts, texts, internet, job list, business apps), the Online contact services (`am_contact_requests`), the interaction menu (`am_pi_menu`), the in-game internet, and what a mod can reuse in story mode. Roadmap topic **R7.10** in the [roadmap](/ROADMAP.md). Builds on [inside freemode](/docs/online/07-freemode.md) (who starts the Online scripts), the [job lobby](/docs/online/job-lobby.md) (R7.5: the activity table these menus use to start activities) and the [script launch graph](/scripting/script-launch-graph.md).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `cellphone_controller`, `cellphone_flashhand`, `am_pi_menu` (616,806 lines), `am_contact_requests` (100,960) and `appinternet` (593,334). Script sizes from the decompile; native counts from [native usage](/scripting/native-usage.md); text labels resolved from the American `.gxt2` files (9,430 of 20,307 strings in these scripts are labels). Names, counts and the app table are **Verified**; which phone belongs to which character is **Known**.

## 21.1 Short version

- **Two scripts run the phone:** `cellphone_controller` (always on, in story and Online) owns the app table and the screen; `cellphone_flashhand` (stack 1,424) is started when the phone is up and starts the chosen app script with 2,600, 4,000 or 4,592 words of stack.
- **The app table** has a slot per app: a text label, an icon, the app's script name and its hash. Filled by `cellphone_controller` (60 calls): Contacts (`appContacts`), Texts (`appTextMessage`), Internet (`appInternet`), Snapmatic (`appCamera`), Check List (`appChecklist`), Email (`appEmail`), Settings (`appSettings`), Job List (`appMPJobListNEW`), Trackify (`appTrackify`), Quick Save, Quick Join (`AppJIPMP`), Darnell Inc. (`appHackerDen`) and spare slots.
- **38 `app*` scripts** exist; the biggest are Online business computers and sites: `appinternet` (12.1 MB of decompiled code), `appbusinesshub` (7.9 MB), `apparcadebusiness` (7.8 MB), `appmpjoblistnew` (9.7 MB).
- **Three phone skins** are scaleform movies: `cellphone_ifruit`, `cellphone_badger` and `cellphone_prologue` (plus the Facade phone, **Known**); the phone itself is placed with `SET_MOBILE_PHONE_POSITION` (697 scripts) and calls checked with `IS_MOBILE_PHONE_CALL_ONGOING` (821).
- **The interaction menu (`am_pi_menu`, 13.1 MB) is started by `freemode`** (stack 9,800). Its top items include Quick GPS, Health and Ammo, Appearance, Walk Style, Vehicle Access, Request Personal Vehicle, Snacks, Impromptu Race and the organisation and club menus (Start an Organization, SecuroServ CEO, Start a Motorcycle Club, Ghost Organization, Retire).
- **Contact services (`am_contact_requests`)** are the phone's Online requests: vehicle delivery, transport, backup helicopter, boat pick-up, bounties (Lester), business and property shortcuts. It checks money first (`NETWORK_CAN_SPEND_MONEY`, 81 calls) and uses the on-screen keyboard for names (`DISPLAY_ONSCREEN_KEYBOARD`, 40).
- **The internet** is one scaleform movie (`web_browser`) driven by `appinternet`; its `WWW_` labels name 23 sites (Maze Bank, Warstock, the Diamond Casino, Eyefind, Arena War, Dynasty 8, Docktease, BAWSAQ, Legendary Motorsport, Southern San Andreas Super Autos, Lifeinvader, Epsilon Program ...).

## 21.2 The phone

`cellphone_controller` (177 KB) loads the app table at start (one function call per slot, 60 calls) and draws the phone through scaleform. When the player opens an app, `cellphone_flashhand` (162 KB) looks the slot up and starts `Global_9470[slot].f_5` (the script name, in this build) with `START_NEW_SCRIPT` (**Verified**). Story and Online share the same mechanism; the slots differ by mode.

| Slot | Label | Script |
| ---: | --- | --- |
| 0 | Contacts | `appContacts` |
| 1 | Texts | `appTextMessage` |
| 2 | Internet | `appInternet` |
| 3 | Snapmatic | `appCamera` |
| 4 | Check List | `appChecklist` |
| 7 | Email | `appEmail` |
| 10 | Settings | `appSettings` |
| 14 | Job List | `appMPJobListNEW` |
| 16 | Sniper | `appContacts` |
| 17 | Trackify | `appTrackify` |
| 20 | Quick Save | `appSettings` |
| 21 | Quick Join | `AppJIPMP` |
| 23 | Darnell Inc. | `appHackerDen` |
| 24 to 34 | Spare | `appContacts` |

Other `app*` scripts are started from properties and vehicles rather than from the phone: the business computers (`appbikerbusiness`, `appbunkerbusiness`, `appimportexport`, `appsmuggler`, `appbusinesshub`, `apparcadebusiness`, `appfixersecurity`, `appbailoffice`, `apphackerden`), `appsecuroserv` (the CEO office), `appavengeroperations`, `apphackertruck`, `appcovertops`.

## 21.3 The interaction menu

`am_pi_menu` builds a scaleform menu (`MP_MENU_GLARE`, `instructional_buttons`; `SC_LEADERBOARD` and `STARTER_PACK_BROWSER` for two sub-screens). Its labels (**Verified**, `PIM_*` and `PI_BIK_*` families) cover:

| Area | Examples |
| --- | --- |
| Top level | Quick GPS, Health and Ammo, Appearance, Walk Style, Vehicle Access, Request Personal Vehicle, Snacks, Impromptu Race |
| Organisations | Start an Organization, SecuroServ CEO, Ghost Organization, Retire, Style; Start a Motorcycle Club |
| Inventory | Body Armor, Ammo, Ammo Type, Fill Jerry Can, Parachute, Smoke Trails, Reserve |
| Appearance | Accessories, Hats, Glasses, Earrings, Gloves, Masks, Bags, Chains, Helmets and visors, Auto Equip Armor, Auto Equip Bike and Aircraft Helmet |
| Activities and events | All Activities, All Events, Challenges, Checkpoints, Penned In, Criminal Damage, Hunt the Beast, Kill List, King of the Castle, Hot Property, Business Battles |
| Contact missions | All Contact Missions, Madrazo Dispatch Services, Simeon's Repo Work, Gerald's Last Play, Operation Paper Trail |
| Vehicles and properties | Vehicle Doors, Empty Personal Vehicle, the Avenger, Terrorbyte and Arcade menus |

Activities chosen here are started through the same activity table as the job lobby ([R7.5](/docs/online/job-lobby.md)).

## 21.4 Contact services

`am_contact_requests` (1.8 MB of decompiled code) serves the phone's Online contacts (**Verified**, its text): "Request a vehicle to be delivered nearby", "Request Transportation", backup helicopter and boat pick-ups (with refusals such as "The boat won't pick up a Wanted crook"), Lester's bounties ("Set Bounty", "CURRENT BOUNTY"), Agent 14 and the business shortcuts (bunker research, acid lab), and property access (Arcade, Auto Shop, Arena Workshop garage levels, Bail Office). Every paid request checks `NETWORK_CAN_SPEND_MONEY` first.

## 21.5 The internet

`appinternet` draws every site in one scaleform movie, `web_browser` (with `font_lib_web`). The `WWW_` labels in the script name 23 sites (**Verified**, counted by prefix): Maze Bank (23 labels), Warstock (12), The Diamond Casino & Resort (8), Eyefind (8), Arena War (5), The Children of the Mountain, Prix Luxury Real Estate, Epsilon Program, Dynasty 8 Real Estate, Dynasty 8 Executive Realty, Docktease, BAWSAQ (4 each), The Reality Mill, LCN (3 each), Southern San Andreas Super Autos, P and M Cycles, Lifeinvader, Legendary Motorsport, I Will Survive It All, Elitas Travel, Benny's Original Motorworks (2 each), My Divine Within and the bank (1 each). Buying through a site in Online goes through the server's transactions ([stats and tunables](/docs/online/stats-and-tunables.md)).

## 21.6 What this means for modders

- **Story-mode phone apps can be replaced by script:** the phone starts whatever script name is in a slot. A mod that writes its own script name into a spare slot's entry would start its own app, but the table's address changes every build; most phone mods instead draw their own menu when the phone is out.
- **Use the menu frameworks for mod menus** ([menus and UI](/scripting/menus-and-ui.md)) rather than `am_pi_menu`, which depends on Online.
- **The websites are one scaleform movie,** so new pages need a modified `web_browser` movie (R8.2).
- **Online requests spend server money.** Don't call `am_contact_requests` paths or the money natives; Online only.

## 21.7 Open questions

| Question | Where it goes |
| --- | --- |
| The story-mode slot list (which apps each character has) | Second pass, `cellphone_controller` by character |
| The full interaction-menu tree and its conditions | Second pass, `am_pi_menu` |
| Every website page and what each sells | Second pass, `appinternet` |
| The Facade phone's movie and the character-to-phone mapping | Second pass |

## 21.8 Test cards

1. **Phone apps (story mode).** Open the phone as Michael and list the apps shown. Expected: Contacts, Texts, Internet, Snapmatic, Email, Settings and others from the table above.
