# Interaction menu, phone and apps

How the phone and the Online interaction menu are built: the two phone scripts and the app table they launch from, the app scripts (contacts, texts, internet, job list, business apps), the Online contact services (`am_contact_requests`), the interaction menu (`am_pi_menu`), the in-game internet, and what a mod can reuse in story mode. Roadmap topic **R7.10** in the [roadmap](/ROADMAP.md). Builds on [inside freemode](/docs/online/07-freemode.md) (who starts the Online scripts), the [job lobby](/docs/online/job-lobby.md) (R7.5: the activity table these menus use to start activities) and the [script launch graph](/scripting/script-launch-graph.md).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `cellphone_controller`, `cellphone_flashhand`, `am_pi_menu` (616,806 lines), `am_contact_requests` (100,960) and `appinternet` (593,334). Script sizes from the decompile; native counts from [native usage](/scripting/native-usage.md); text labels resolved from the American `.gxt2` files (9,430 of 20,307 strings in these scripts are labels). Names, counts, the app table and which phone belongs to which character are **Verified**.

## 21.1 Short version

- **Two scripts run the phone:** `cellphone_controller` (always on, in story and Online) owns the app table and the screen; `cellphone_flashhand` (stack 1,424) is started when the phone is up and starts the chosen app script with 2,600, 4,000 or 4,592 words of stack.
- **The app table** has a slot per app: a text label, an icon, the app's script name and its hash. Filled by `cellphone_controller` (60 calls): Contacts (`appContacts`), Texts (`appTextMessage`), Internet (`appInternet`), Snapmatic (`appCamera`), Check List (`appChecklist`), Email (`appEmail`), Settings (`appSettings`), Job List (`appMPJobListNEW`), Trackify (`appTrackify`), Quick Save, Quick Join (`AppJIPMP`), Darnell Inc. (`appHackerDen`) and spare slots.
- **38 `app*` scripts** exist; the biggest are Online business computers and sites: `appinternet` (12.1 MB of decompiled code), `appbusinesshub` (7.9 MB), `apparcadebusiness` (7.8 MB), `appmpjoblistnew` (9.7 MB).
- **Three phone skins** are scaleform movies: `cellphone_ifruit` (Michael), `cellphone_badger` (Franklin), `cellphone_facade` (Trevor) and `cellphone_prologue` (**Verified**, [21.2.1](#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass)); the phone itself is placed with `SET_MOBILE_PHONE_POSITION` (697 scripts) and calls checked with `IS_MOBILE_PHONE_CALL_ONGOING` (821).
- **The interaction menu (`am_pi_menu`, 13.1 MB) is started by `freemode`** (stack 9,800). Its top items include Quick GPS, Health and Ammo, Appearance, Walk Style, Vehicle Access, Request Personal Vehicle, Snacks, Impromptu Race and the organisation and club menus (Start an Organization, SecuroServ CEO, Start a Motorcycle Club, Ghost Organization, Retire).
- **Contact services (`am_contact_requests`)** are the phone's Online requests: vehicle delivery, transport, backup helicopter, boat pick-up, bounties (Lester), business and property shortcuts. It checks money first (`NETWORK_CAN_SPEND_MONEY`, 81 calls) and uses the on-screen keyboard for names (`DISPLAY_ONSCREEN_KEYBOARD`, 40).
- **The internet** is the `web_browser` movie, driven by `appinternet`, which loads one movie per website (86 `www_*.gfx` files, [Scaleform movies](/docs/ui/scaleform.md)); the script's own `WWW_` labels name 23 sites (Maze Bank, Warstock, the Diamond Casino, Eyefind, Arena War, Dynasty 8, Docktease, BAWSAQ, Legendary Motorsport, Southern San Andreas Super Autos, Lifeinvader, Epsilon Program ...).

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

### 21.2.1 The slots by mode and the phone each character carries (second pass)

*Second pass, 2026-10-30.* **Verified** in `cellphone_controller` and `standard_global_reg`. Story mode does not give each character a different app list: one function fills the same table for Michael, Franklin and Trevor. Each entry stores a label, a home-screen position (-99 = not on the home screen), the script, its hash, an icon number and two flags.

| Home position | Story mode | Online |
| ---: | --- | --- |
| 0 | Email (`appEmail`) | Email (`appMPEmail`) |
| 1 | Texts | Texts |
| 2 | Check List (`appChecklist`) | Contacts |
| 3 | Quick Save (`appSettings`) | Quick Join (`AppJIPMP`) |
| 4 | Contacts | Job List (`appMPJobListNEW`) |
| 5 | Settings | Darnell Inc. (`appHackerDen`) once the player has the Hacker Den, otherwise Settings |
| 6 | Snapmatic | Snapmatic |
| 7 | Internet | Internet |
| 8 | Trackify, only while a mission turns it on (`michael2`, `docks_heistb`, `ambient_diving` and `ambient_sonar` set the flag and clear it again) | Trackify while a job turns it on; otherwise slot 24 holds a job app: VLSI Unlock (`AppVLSI`), Sightseer, Extraction (`AppExtraction`), SecuroServ Hack (`AppSecuroHack`) or, by default, SecuroServ (`appMPBossAgency`) |

- **Story only:** Sniper (slot 16, `appContacts`) appears while one flag is set, and Contacts uses a second icon while any of the 161 contacts is flagged for the current character. BAWSAQ (slot 9), More Apps (slots 11 and 26) and six spare slots are filled but kept off the home screen.
- **Online only:** two `appMPCopBackup` entries (Player List and one more) and Map (slot 15) are filled off the home screen; slots 24 to 34 are spare.

**The phone each character carries.** `standard_global_reg` fills a four-entry phone table, indexed by the current character (worked out from the player model):

| Entry | Character | Movie | Ringtone |
| ---: | --- | --- | --- |
| 0 | Michael | `cellphone_iFruit` | `PHONE_GENERIC_RING_01` |
| 1 | Franklin | `cellphone_badger` | `PHONE_GENERIC_RING_02` |
| 2 | Trevor | `cellphone_facade` | `PHONE_GENERIC_RING_03` |
| 3 | any other model | `cellphone_ifruit` | `PHONE_GENERIC_RING_01` |

So the Facade phone is Trevor's, and its movie is `cellphone_facade`. Each entry also stores three theme numbers (1, 2 and 3 for the iFruit, Badger and Facade). `cellphone_flashhand` loads the entry's movie in story mode, `cellphone_prologue` during the prologue, and in Online `cellphone_ifruit`, or `cellphone_badger` while either of two Online flags is set (the same flags that empty slot 24).

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

### 21.3.1 The menu tree (second pass)

*Second pass, 2026-10-30.* **Verified** in `am_pi_menu`, with labels from the American text. One function builds the top page (title "INTERACTION MENU"). It adds items in this order, each with its own condition. Greyed means the item is shown but can't be picked.

| Item | Shown when | Greyed when |
| --- | --- | --- |
| Short Trip Options | The player is in a Short Trip | |
| Support Crew | A crew-support check passes | |
| The organisation entry: Motorcycle Club President, SecuroServ CEO or VIP, the club's own name, or SecuroServ Associate or Bodyguard | The player is in an organisation or club, in that order of checks | In an activity session (unless that session allows it) and in a few blocking states |
| Apartment Style or Office Decor | The player is inside their own apartment or office | Office Decor, during an office transition |
| Invite to Yacht, Clubhouse, Office, Office Garage or Apartment | The player is inside one of their properties that allows guests (one item, named after the property type) | |
| Two vehicle entries named at run time | The player is in one of their large vehicles (Avenger, Terrorbyte, Kosatka and others) | When that vehicle's own check says so |
| Invite to Cayo Perico Beach Party | The beach-party check passes | |
| Spectate Crew | The player can spectate crew members during a job | |
| Quick GPS | Always | When waypoints can't be set, or in some activity sessions |
| Register as a Boss | The player is not already in an organisation | In an activity session and in a few blocking states |
| Manage Vehicles | Always | In a few blocking states |
| Service Vehicles | Always | In a few blocking states |
| Health and Ammo, Appearance | Always | |
| Challenges | Always | When a tunable switches challenges off |
| All Collectibles, Preferences | Always | |
| Impromptu Race | Always | When the race check fails |
| Enable or Disable Passive Mode | Always | When passive mode can't change. A tunable can put a price on it, which is then shown in place of "Enable Passive Mode" |

Below the top page the script has **144 page titles** (plus 17 named at run time) and **1,203 item calls**. The pages by area:

| Area | Pages |
| --- | --- |
| SecuroServ | CEO, VIP, Associate, Bodyguard; CEO and VIP abilities; VIP work (Headhunter, Sightseer, Hostile Takeover, Asset Recovery, Executive Search, Piracy Prevention, Executive Deathmatch, Airfreight, Haulage, Cashing Out, Salvage, Most Wanted, Market Manipulation, Courier Service, Due Diligence, Point to Point, Auto Buyout); challenges; management; style; associate and bodyguard vehicles; Register as a Boss |
| Motorcycle club | Find Prospects, Management, Club Work, Club Challenges (Deathmatch, Joust, Stand Your Ground, Caged In), MC Style, Members; the Enforcer, VP, Sgt-at-Arms and Road Captain abilities |
| Vehicles | Manage Vehicles, Vehicle Remote Functions, Remote Control Vehicles, Service Vehicles, Vehicle Preferences; Avenger, Terrorbyte, Mobile Operations Center, Kosatka (with access, empty and return options), Galaxy Super Yacht, Bail Office Transporter, Acid Lab (product names, return options), Ballistic Equipment Services |
| Properties | Apartment Style, Office Decor, the six invite pages; Nightclub, Nightclub Garage and Nightclub Management; Facility Management; Arcade and Arcade Management; Auto Shop and Auto Shop Management; Penthouse Management and Place Decorations; Mansion (management, staff, audio, customization); Eclipse Blvd Garage; Arena Workshop (workshop level, garage levels B1 and B2); LS Car Meet (vehicle options, takeover options, Prize Ride Challenge); The Diamond Casino & Resort |
| Player | Health and Ammo (Body Armor, Snacks, Parachute), Appearance (Accessories), Discount Vouchers, Highlight Player on Radar, Player Groups, Spectate Crew, Last Job |
| Challenges and collectibles | Challenges, Daily Challenges, Weekly Challenge, All Collectibles, Daily Collectibles; eight vehicle work pages (Plowed, Fully Loaded, Amphibious Assault, Transporter, Fortified, Velocity, Ramped Up, Stockpiling) |
| Preferences | Preferences, Map Blip Options (hide activities, contact missions, properties, rival gameplay, series, events, jobs, stores, odd jobs), Phone Contact Favorites, Radio Station Favorites |

The conditions for each page sit in the function that builds it. They follow the same pattern as the top page: an ownership or membership check decides whether a page shows, and a session or state check decides whether it is greyed.

## 21.4 Contact services

`am_contact_requests` (1.8 MB of decompiled code) serves the phone's Online contacts (**Verified**, its text): "Request a vehicle to be delivered nearby", "Request Transportation", backup helicopter and boat pick-ups (with refusals such as "The boat won't pick up a Wanted crook"), Lester's bounties ("Set Bounty", "CURRENT BOUNTY"), Agent 14 and the business shortcuts (bunker research, acid lab), and property access (Arcade, Auto Shop, Arena Workshop garage levels, Bail Office). Every paid request checks `NETWORK_CAN_SPEND_MONEY` first.

## 21.5 The internet

`appinternet` runs the `web_browser` movie (with `font_lib_web`), and each site is its own movie in `scaleform_web.rpf` (86 `www_*.gfx` files, [Scaleform movies](/docs/ui/scaleform.md)). The `WWW_` labels in the script name 23 sites (**Verified**, counted by prefix): Maze Bank (23 labels), Warstock (12), The Diamond Casino & Resort (8), Eyefind (8), Arena War (5), The Children of the Mountain, Prix Luxury Real Estate, Epsilon Program, Dynasty 8 Real Estate, Dynasty 8 Executive Realty, Docktease, BAWSAQ (4 each), The Reality Mill, LCN (3 each), Southern San Andreas Super Autos, P and M Cycles, Lifeinvader, Legendary Motorsport, I Will Survive It All, Elitas Travel, Benny's Original Motorworks (2 each), My Divine Within and the bank (1 each). Buying through a site in Online goes through the server's transactions ([stats and tunables](/docs/online/stats-and-tunables.md)).

*Second pass, 2026-10-26.* Eight sites sell vehicles, and the script numbers them (**Verified**, from the purchase-message table and the per-site stock table in `appinternet`):

| Site number | Site | Stock slots | Notes |
| ---: | --- | ---: | --- |
| 10 | Legendary Motorsport | 209 | |
| 11 | Elitas Travel | 33 | aircraft |
| 12 | Warstock Cache & Carry | 161 | separate purchase messages for the Mobile Operations Center (item 323), Avenger (357), Terrorbyte (402) and Kosatka (518) |
| 13 | Docktease | 23 | boats; the yacht (item 245) has its own message |
| 15 | P and M Cycles | 9 | bicycles |
| 16 | Southern San Andreas Super Autos | 269 | |
| 26 | Benny's Original Motorworks | 32 | |
| 29 | Arena War | 23 | |

Each slot holds an item number from one shared vehicle item list; the list is below. What the notes column says each site sells is **Known**. The real-estate sites sell properties: Dynasty 8 Real Estate the 85 homes and garages, Dynasty 8 Executive Realty offices, warehouses and the other executive properties ([properties](/docs/online/properties.md)); The Diamond Casino & Resort sells membership, the penthouse suites and renovations. Maze Bank, BAWSAQ and LCN are the bank and the two stock markets; Lifeinvader, Eyefind and the cult sites only show pages.

*Second pass, 2026-10-30.* **The item list** (**Verified**): one function in `appinternet` turns an item number into a model hash. It has **683 items (0 to 687)**; items 8, 9, 23, 26 and 28 are unused. Most entries name the model directly. The 52 newest items (633 to 687) are bare hashes, matched here against the model names in the 2023 to 2025 DLC packs' `vehicles.meta`. Items 323, 324, 357 and 402 return hashes set at start that match no model name in the game text or the decompile.

| Items | Models |
| --- | --- |
| 0–24 | 0 `ztype`, 1 `stinger`, 2 `jb700`, 3 `cheetah`, 4 `entityxf`, 5 `adder`, 6 `monroe`, 7 `cogcabrio`, 10 `shamal`, 11 `stunt`, 12 `cuban800`, 13 `duster`, 14 `luxor`, 15 `frogger`, 16 `maverick`, 17 `rhino`, 18 `titan`, 19 `cargobob`, 20 `buzzard`, 21 `crusader`, 22 `barracks`, 24 `marquis` |
| 25–49 | 25 `jetmax`, 27 `squalo`, 29 `tropic`, 30 `seashark`, 31 `submersible`, 32 `suntrap`, 33 `bmx`, 34 `scorcher`, 35 `tribike`, 36 `tribike2`, 37 `tribike3`, 38 `cruiser`, 39 `schwarzer`, 40 `zion`, 41 `gauntlet`, 42 `vigero`, 43 `issi2`, 44 `infernus`, 45 `surano`, 46 `vacca`, 47 `ninef`, 48 `comet2`, 49 `banshee` |
| 50–74 | 50 `feltzer2`, 51 `bfinjection`, 52 `sandking`, 53 `fugitive`, 54 `dilettante`, 55 `superd`, 56 `exemplar`, 57 `baller2`, 58 `cavalcade`, 59 `rocoto`, 60 `felon`, 61 `oracle2`, 62 `bati`, 63 `akuma`, 64 `ruffian`, 65 `vader`, 66 `blazer`, 67 `pcj`, 68 `sanchez`, 69 `faggio2`, 70 `bullet`, 71 `carbonizzare`, 72 `coquette`, 73 `ninef2`, 74 `rapidgt` |
| 75–99 | 75 `rapidgt2`, 76 `stingergt`, 77 `voltic`, 78 `annihilator`, 79 `mammatus`, 80 `velum`, 81 `dump`, 82 `airbus`, 83 `bus`, 84 `coach`, 85 `journey`, 86 `mule`, 87 `rentalbus`, 88 `stretch`, 89 `bison`, 90 `double`, 91 `felon2`, 92 `hexer`, 93 `zion2`, 94 `bati2`, 95 `elegy2`, 96 `khamelion`, 97 `hotknife`, 98 `carbonrs`, 99 `bifta` |
| 100–124 | 100 `kalahari`, 101 `paradise`, 102 `speeder`, 103 `bodhi2`, 104 `dune`, 105 `rebel`, 106 `sadler`, 107 `sanchez2`, 108 `sandking2`, 109 `btype`, 110 `alpha`, 111 `jester`, 112 `turismor`, 113 `vestra`, 114 `massacro`, 115 `zentorno`, 116 `huntley`, 117 `coquette`, 118 `banshee`, 119 `stinger`, 120 `voltic`, 121 `thrust`, 122 `dominator`, 123 `f620`, 124 `fusilade` |
| 125–149 | 125 `penumbra`, 126 `sentinel`, 127 `sentinel2`, 128 `asea`, 129 `asterope`, 130 `bobcatxl`, 131 `cavalcade2`, 132 `granger`, 133 `ingot`, 134 `intruder`, 135 `minivan`, 136 `premier`, 137 `radi`, 138 `rancherxl`, 139 `ratloader`, 140 `stanier`, 141 `stratum`, 142 `washington`, 143 `blade`, 144 `warrener`, 145 `glendale`, 146 `rhapsody`, 147 `panto`, 148 `dubsta3`, 149 `pigalle` |
| 150–174 | 150 `picador`, 151 `regina`, 152 `surfer`, 153 `youga`, 154 `blazer3`, 155 `rebel2`, 156 `primo`, 157 `buffalo`, 158 `buffalo2`, 159 `tailgater`, 160 `monster`, 161 `sovereign`, 162 `miljet`, 163 `besra`, 164 `swift`, 165 `coquette2`, 166 `coquette2`, 167 `innovation`, 168 `hakuchou`, 169 `furoregt`, 170 `kalahari`, 171 `boxville4`, 172 `casco`, 173 `dinghy3`, 174 `enduro` |
| 175–199 | 175 `gburrito2`, 176 `guardian`, 177 `hydra`, 178 `insurgent`, 179 `insurgent2`, 180 `kuruma`, 181 `kuruma2`, 182 `lectro`, 183 `mule3`, 184 `pbus`, 185 `savage`, 186 `technical`, 187 `valkyrie`, 188 `velum2`, 189 `gresley`, 190 `jackal`, 191 `landstalker`, 192 `mesa3`, 193 `nemesis`, 194 `oracle`, 195 `rumpo`, 196 `schafter2`, 197 `seminole`, 198 `surge`, 199 `dodo` |
| 200–224 | 200 `marshall`, 201 `submersible2`, 202 `blista2`, 203 `stalion`, 204 `dukes`, 205 `dukes2`, 206 `stalion2`, 207 `dominator2`, 208 `gauntlet2`, 209 `buffalo3`, 210 `slamvan`, 211 `ratloader2`, 212 `jester2`, 213 `massacro2`, 214 `feltzer3`, 215 `luxor2`, 216 `osiris`, 217 `swift2`, 218 `virgo`, 219 `windsor`, 220 `brawler`, 221 `chino`, 222 `coquette3`, 223 `t20`, 224 `toro` |
| 225–249 | 225 `vindicator`, 226 `buccaneer`, 227 `faction`, 228 `moonbeam`, 229 `primo`, 230 `voodoo2`, 231 `btype2`, 232 `lurcher`, 233 `baller3`, 234 `baller4`, 235 `cog55`, 236 `cognoscenti`, 237 `limo2`, 238 `mamba`, 239 `nightshade`, 240 `schafter3`, 241 `schafter4`, 242 `verlierer2`, 243 `supervolito`, 244 `supervolito2`, 245 `apa_mp_apa_yacht` (set at start), 246 `tampa`, 247 `sultan`, 248 `btype3`, 249 `sabregt` |
| 250–274 | 250 `tornado`, 251 `virgo3`, 252 `faction`, 253 `volatus`, 254 `cargobob2`, 255 `rumpo3`, 256 `brickade`, 257 `nimbus`, 258 `tug`, 259 `windsor2`, 260 `prototipo`, 261 `fmj`, 262 `bestiagts`, 263 `xls`, 264 `seven70`, 265 `pfister811`, 266 `reaper`, 267 `le7b`, 268 `omnis`, 269 `tropos`, 270 `brioso`, 271 `trophytruck`, 272 `trophytruck2`, 273 `contender`, 274 `cliffhanger` |
| 275–299 | 275 `bf400`, 276 `rallytruck`, 277 `tampa2`, 278 `gargoyle`, 279 `tyrus`, 280 `lynx`, 281 `sheava`, 282 `bagger`, 283 `esskey`, 284 `nightblade`, 285 `defiler`, 286 `avarus`, 287 `zombiea`, 288 `zombieb`, 289 `chimera`, 290 `daemon2`, 291 `ratbike`, 292 `shotaro`, 293 `raptor`, 294 `hakuchou2`, 295 `vortex`, 296 `blazer4`, 297 `sanctus`, 298 `manchez`, 299 `tornado6` |
| 300–324 | 300 `youga2`, 301 `wolfsbane`, 302 `faggio3`, 303 `faggio`, 304 `dune5`, 305 `phantom2`, 306 `technical2`, 307 `blazer5`, 308 `boxville5`, 309 `wastelander`, 310 `ruiner2`, 311 `voltic2`, 312 `penetrator`, 313 `tempesta`, 314 `italigtb`, 315 `nero`, 316 `diablous`, 317 `fcr`, 318 `specter`, 319 `gp1`, 320 `infernus2`, 321 `ruston`, 322 `turismo2`, 323 (a hash set at start), 324 (a hash set at start) |
| 325–349 | 325 `cheetah2`, 326 `torero`, 327 `vagner`, 328 `xa21`, 329 `apc`, 330 `dune3`, 331 `halftrack`, 332 `oppressor`, 333 `tampa3`, 334 `trailersmall2`, 335 `ardent`, 336 `nightshark`, 337 `lazer`, 338 `microlight`, 339 `mogul`, 340 `rogue`, 341 `starling`, 342 `seabreeze`, 343 `tula`, 344 `pyro`, 345 `molotok`, 346 `nokota`, 347 `bombushka`, 348 `hunter`, 349 `havok` |
| 350–374 | 350 `howard`, 351 `alphaz1`, 352 `cyclone`, 353 `visione`, 354 `retinue`, 355 `rapidgt3`, 356 `vigilante`, 357 (a hash set at start), 358 `deluxo`, 359 `stromberg`, 360 `riot2`, 361 `chernobog`, 362 `khanjali`, 363 `akula`, 364 `thruster`, 365 `barrage`, 366 `volatol`, 367 `comet4`, 368 `neon`, 369 `streiter`, 370 `sentinel3`, 371 `yosemite`, 372 `sc1`, 373 `autarch`, 374 `gt500` |
| 375–399 | 375 `hustler`, 376 `revolter`, 377 `pariah`, 378 `raiden`, 379 `savestra`, 380 `riata`, 381 `hermes`, 382 `comet5`, 383 `z190`, 384 `viseris`, 385 `kamacho`, 386 `gb200`, 387 `fagaloa`, 388 `ellie`, 389 `issi3`, 390 `michelli`, 391 `flashgt`, 392 `hotring`, 393 `tezeract`, 394 `tyrant`, 395 `dominator3`, 396 `taipan`, 397 `entity2`, 398 `jester3`, 399 `cheburek` |
| 400–424 | 400 `caracara`, 401 `seasparrow`, 402 (a hash set at start), 403 `mule4`, 404 `pounder2`, 405 `swinger`, 406 `menacer`, 407 `scramjet`, 408 `strikeforce`, 409 `oppressor2`, 410 `patriot2`, 411 `stafford`, 412 `freecrawler`, 413 `blimp3`, 414 `pbus2`, 415 `futo`, 416 `ruiner`, 417 `romero`, 418 `prairie`, 419 `baller`, 420 `serrano`, 421 `bjxl`, 422 `habanero`, 423 `fq2`, 424 `patriot` |
| 425–449 | 425 `cerberus`, 426 `cerberus2`, 427 `cerberus3`, 428 `brutus`, 429 `brutus2`, 430 `brutus3`, 431 `scarab`, 432 `scarab2`, 433 `scarab3`, 434 `imperator`, 435 `imperator2`, 436 `imperator3`, 437 `zr380`, 438 `zr3802`, 439 `zr3803`, 440 `impaler`, 441 `vamos`, 442 `tulip`, 443 `deveste`, 444 `schlagen`, 445 `toros`, 446 `deviant`, 447 `clique`, 448 `italigto`, 449 `rcbandito` |
| 450–474 | 450 `taxi`, 451 `bulldozer`, 452 `speedo2`, 453 `trash2`, 454 `barracks2`, 455 `mixer`, 456 `dune2`, 457 `tractor`, 458 `blista3`, 459 `thrax`, 460 `drafter`, 461 `locust`, 462 `novak`, 463 `zorrusso`, 464 `gauntlet3`, 465 `issi7`, 466 `zion3`, 467 `nebula`, 468 `hellion`, 469 `dynasty`, 470 `rrocket`, 471 `peyote2`, 472 `gauntlet4`, 473 `caracara2`, 474 `jugular` |
| 475–499 | 475 `s80`, 476 `krieger`, 477 `emerus`, 478 `neo`, 479 `paragon`, 480 `firetruk`, 481 `burrito2`, 482 `boxville`, 483 `stockade`, 484 `lguard`, 485 `blazer2`, 486 `zhaba`, 487 `minitank`, 488 `jb7002`, 489 `stryder`, 490 `vstr`, 491 `formula`, 492 `imorgon`, 493 `formula2`, 494 `furia`, 495 `rebla`, 496 `vagrant`, 497 `retinue2`, 498 `yosemite2`, 499 `komoda` |
| 500–524 | 500 `sultan2`, 501 `sugoi`, 502 `everon`, 503 `asbo`, 504 `kanjo`, 505 `outlaw`, 506 `club`, 507 `dukes3`, 508 `yosemite3`, 509 `penumbra2`, 510 `landstalker2`, 511 `seminole2`, 512 `tigon`, 513 `openwheel1`, 514 `openwheel2`, 515 `coquette4`, 516 `manana`, 517 `peyote`, 518 `kosatka`, 519 `italirsx`, 520 `slamtruck`, 521 `brioso2`, 522 `weevil`, 523 `alkonost`, 524 `annihilator2` |
| 525–549 | 525 `dinghy5`, 526 `manchez2`, 527 `patrolboat`, 528 `squaddie`, 529 `toreador`, 530 `verus`, 531 `vetir`, 532 `winky`, 533 `longfin`, 534 `veto`, 535 `veto2`, 536 `calico`, 537 `comet6`, 538 `cypher`, 539 `dominator7`, 540 `jester4`, 541 `remus`, 542 `vectre`, 543 `zr350`, 544 `warrener2`, 545 `rt3000`, 546 `futo2`, 547 `sultan3`, 548 `tailgater2`, 549 `dominator8` |
| 550–574 | 550 `euros`, 551 `growler`, 552 `previon`, 553 `supervolito2`, 554 `comet7`, 555 `shinobi`, 556 `reever`, 557 `baller7`, 558 `cinquemila`, 559 `jubilee`, 560 `astron`, 561 `deity`, 562 `zeno`, 563 `champion`, 564 `ignus`, 565 `buffalo4`, 566 `granger2`, 567 `iwagen`, 568 `patriot3`, 569 `tenf`, 570 `sm722`, 571 `torero2`, 572 `corsita`, 573 `lm87`, 574 `omnisegt` |
| 575–599 | 575 `rhinehart`, 576 `postlude`, 577 `kanjosj`, 578 `vigero2`, 579 `ruiner4`, 580 `draugur`, 581 `greenwood`, 582 `conada`, 583 `brickade2`, 584 `manchez3`, 585 `panthere`, 586 `tahoma`, 587 `tulip2`, 588 `everon2`, 589 `journey2`, 590 `surfer3`, 591 `virtue`, 592 `r300`, 593 `issi8`, 594 `entity3`, 595 `powersurge`, 596 `boor`, 597 `broadway`, 598 `eudora`, 599 `mesa` |
| 600–624 | 600 `l35`, 601 `ratel`, 602 `monstrociti`, 603 `brigham`, 604 `clique2`, 605 `inductor`, 606 `inductor2`, 607 `streamer216`, 608 `conada2`, 609 `raiju`, 610 `gauntlet6`, 611 `stingertt`, 612 `buffalo5`, 613 `coureur`, 614 `polgauntlet`, 615 `police4`, 616 `police5`, 617 `riot`, 618 `dorado`, 619 `impaler5`, 620 `impaler6`, 621 `asterope2`, 622 `dominator9`, 623 `fr36`, 624 `baller8` |
| 625–649 | 625 `aleutian`, 626 `turismo3`, 627 `cavalcade3`, 628 `vigero3`, 629 `terminus`, 630 `vivanite`, 631 `boxville6`, 632 `benson2`, 633 `poldominator10`, 634 `poldorado`, 635 `polgreenwood`, 636 `polimpaler5`, 637 `polimpaler6`, 638 `vorschlaghammer`, 639 `castigator`, 640 `yosemite1500`, 641 `dominator10`, 642 `pizzaboy`, 643 `pipistrello`, 644 `coquette5`, 645 `eurosx32`, 646 `niobe`, 647 `envisage`, 648 `paragon3`, 649 `taco` |
| 650–674 | 650 `polcaracara`, 651 `polterminus`, 652 `polcoquette4`, 653 `polfaction2`, 654 `predator`, 655 `cargobob5`, 656 `titan2`, 657 `duster2`, 658 `coquette6`, 659 `banshee3`, 660 `jester5`, 661 `chavosv6`, 662 `uranus`, 663 `firebolt`, 664 `policeb2`, 665 `stockade4`, 666 `rapidgt4`, 667 `suzume`, 668 `sentinel5`, 669 `everon3`, 670 `cheetah3`, 671 `minimus`, 672 `hardy`, 673 `l352`, 674 `woodlander` |
| 675–687 | 675 `tampa4`, 676 `driftl352`, 677 `volatus`, 678 `polbuffalo`, 679 `polbuffalo6`, 680 `itali2`, 681 `astrale`, 682 `gt750`, 683 `luiva`, 684 `xtreme`, 685 `fmj2`, 686 `keitora`, 687 `sentinel6` |

## 21.6 What this means for modders

- **Story-mode phone apps can be replaced by script:** the phone starts whatever script name is in a slot. A mod that writes its own script name into a spare slot's entry would start its own app, but the table's address changes every build; most phone mods instead draw their own menu when the phone is out.
- **Use the menu frameworks for mod menus** ([menus and UI](/scripting/menus-and-ui.md)) rather than `am_pi_menu`, which depends on Online.
- **Each website is its own `.gfx` movie,** so a new or changed page means a new or edited `www_*.gfx` ([Scaleform movies](/docs/ui/scaleform.md)).
- **Online requests spend server money.** Don't call `am_contact_requests` paths or the money natives; Online only.

## 21.7 Open questions

| Question | Where it goes |
| --- | --- |
| The story-mode slot list (which apps each character has) | Answered in [21.2.1](#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass): one list for all three characters |
| The full interaction-menu tree and its conditions | Answered in [21.3.1](#2131-the-menu-tree-second-pass): the top page with its conditions, and every page by area; per-page conditions stay in each page's function |
| Every website page and what each sells | Answered in [21.5](#215-the-internet): the eight selling sites, their stock counts and the 683-item model list |
| The Facade phone's movie and the character-to-phone mapping | Answered in [21.2.1](#2121-the-slots-by-mode-and-the-phone-each-character-carries-second-pass): `cellphone_facade`, Trevor's |
| Who sets the story phone's Sniper-app flag, and what the two Online flags are that switch the phone to the Badger skin and empty slot 24 | Third pass, `cellphone_controller` callers |
| What website items 323, 324, 357 and 402 are (hashes set at start that match no model name) | Third pass, the preview code in `appinternet` |
| Each interaction-menu page's own show and grey conditions (the top page is mapped) | Third pass, `am_pi_menu` page by page |

## 21.8 Test cards

1. **Phone apps (story mode).** Open the phone as Michael and list the apps shown. Expected: Contacts, Texts, Internet, Snapmatic, Email, Settings and others from the table above.
