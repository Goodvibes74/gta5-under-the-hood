# Properties in GTA Online

How GTA Online's properties are built: the 115-entry property table (apartments, houses, garages, the yacht, offices, clubhouses, office garages, the vehicle warehouse) with names, classes and prices, the ten ownership slots, how an entrance becomes an instanced interior, how buying and trading in work, and the 180-entry "simple interior" system behind the business properties. Roadmap topic **R7.6** in the [roadmap](/ROADMAP.md). Research only: this documents Rockstar's Online scripts; never run mods in GTA Online. Builds on [how Online works](/docs/online/01-how-online-works.md) (§1.8: the property script pairs and the 83 entrances), [inside freemode](/docs/online/07-freemode.md) (R7.1), [stats and tunables](/docs/online/stats-and-tunables.md) (R7.3) and [Rockstar services](/docs/online/rockstar-services.md) (R15.2: the server catalog).

**How it was made.** Read in the build 1.0.3725.0 decompile (commit `6c18d3e8b`): `am_mp_property_ext` (410,963 lines), `am_mp_property_int` (817,520), `am_mp_smpl_interior_ext` and `_int`, and `am_hold_up` for the simple-interior name list. Per-property tables were dumped from their switch functions (names, prices, classes); names were read from the American text in `update\update2.rpf` with a small `.gxt2` reader (Jenkins hash of each label). Counts and values are **Verified**; what players see is **Known**. Decompiler function and global numbers are build-specific pointers only.

## 45.1 Short version

- **115 property indices** in `am_mp_property_ext`: 85 apartments, houses and garages, the yacht (86), 4 offices (87 to 90), 12 clubhouses (91 to 102), 12 office garages (103 to 114, three per office) and the vehicle warehouse (115).
- **The 85 homes come in six classes:** 35 high-end apartments, houses and penthouses ($200,000 to $1,100,000), 13 medium apartments ($125,000 to $175,000), 10 low-end apartments ($80,000 to $121,000), and garages for 10 cars (6), 6 cars (8) and 2 cars (13, $25,000 to $35,000).
- **Prices are layered:** a default table in the script, a tunable per property that can override it, a sale multiplier tunable, and on PC the server catalog price (`NET_GAMESERVER_GET_PRICE`), which wins when its item key is valid.
- **Trading in pays half:** buying a new home in an occupied slot refunds 50% of what the old one cost (`NETWORK_EARN_FROM_PROPERTY`), then charges the new price (`NETWORK_BUY_PROPERTY`, 18 scripts).
- **Ten slots for homes:** the stats `PROPERTY_HOUSE` and `MULTI_PROPERTY_1` to `9`, plus separate slots for the office, clubhouse, three office garages and the vehicle warehouse.
- **Every property is an exterior script plus an interior script,** both network scripts for 32 players. The interior registers with an instance number, so many players can be "inside" the same building in separate copies. `am_mp_property_int` starts the office and clubhouse computers (`appSecuroServ`, `appImportExport`, `appBikerBusiness`), the internet, the shower, the jukebox, a mod shop and venue peds.
- **Business properties are "simple interiors":** 180 entries (plus "invalid") in the shared list: 22 warehouses, 11 bunkers, 10 vehicle warehouses, 9 facilities, 5 hangars, 20 biker factories, 6 arcades, 5 auto shops, 4 agencies, 5 bail offices, 5 salvage yards, 10 business hubs and 43 restricted mission interiors (banks, FIB building, the aircraft carrier ...). `am_mp_smpl_interior_ext` starts each one's own interior script (`AM_MP_BUNKER`, `AM_MP_HANGAR`, `AM_MP_NIGHTCLUB` ...).

## 45.2 The property table

Four switch functions in `am_mp_property_ext` describe each index (**Verified**): its name label, its class, a default price, and the tunable that can replace the price. Prices are the script defaults; Online normally charges the server catalog price instead (45.4).

| Class | Indices | Count | Default prices |
| --- | --- | ---: | --- |
| High-end apartment, house or penthouse | 1 to 7, 34 to 43, 61 to 65, 73 to 85 | 35 | $200,000 to $1,100,000 |
| Medium apartment | 8 to 16, 66 to 69 | 13 | $125,000 to $175,000 |
| Low-end apartment | 17 to 23, 70 to 72 | 10 | $80,000 to $121,000 |
| 10-car garage | 24, 26, 27, 54, 56, 57 | 6 | $105,000 to $150,000 |
| 6-car garage | 25, 28, 32, 33, 50, 52, 53, 55 | 8 | $62,500 to $80,000 |
| 2-car garage | 29 to 31, 44 to 49, 51, 58 to 60 | 13 | $25,000 to $35,000 |
| Yacht | 86 | 1 | $27,000,000 (placeholder; the yacht is bought through its own flow) |
| Office | 87 to 90 | 4 | $1,000,000 to $4,000,000 |
| Clubhouse | 91 to 102 | 12 | $200,000 to $495,000 |
| Office garage | 103 to 114 (3 per office) | 12 | $745,000, $855,000, $1,150,000 |
| Vehicle warehouse | 115 | 1 | $3,000,000 |

Garage capacities (2, 6 and 10 cars, 20 per office garage) are **Known**. The index and the label number are not the same past 46: index 47 is `MP_PROP_48`, index 52 is `MP_PROP_57` and so on, because some labels were dropped.

<details>
<summary>All 115 properties</summary>

| Index | Label | Name | Class | Default price ($) |
| ---: | --- | --- | --- | ---: |
| 1 | `MP_PROP_1` | Eclipse Towers, Apt 31 | High-end apartment or house | 400,000 |
| 2 | `MP_PROP_2` | Eclipse Towers, Apt 9 | High-end apartment or house | 373,000 |
| 3 | `MP_PROP_3` | Eclipse Towers, Apt 40 | High-end apartment or house | 391,000 |
| 4 | `MP_PROP_4` | Eclipse Towers, Apt 5 | High-end apartment or house | 382,000 |
| 5 | `MP_PROP_5` | 3 Alta St, Apt 10 | High-end apartment or house | 217,000 |
| 6 | `MP_PROP_6` | 3 Alta St, Apt 57 | High-end apartment or house | 223,000 |
| 7 | `MP_PROP_7` | Del Perro Heights, Apt 20 | High-end apartment or house | 205,000 |
| 8 | `MP_PROP_8` | 1162 Power St, Apt 3 | Medium apartment | 130,000 |
| 9 | `MP_PROP_9` | 0605 Spanish Ave, Apt 1 | Medium apartment | 128,000 |
| 10 | `MP_PROP_10` | 0604 Las Lagunas Blvd, Apt 4 | Medium apartment | 126,000 |
| 11 | `MP_PROP_11` | 0184 Milton Rd, Apt 13 | Medium apartment | 146,000 |
| 12 | `MP_PROP_12` | The Royale, Apt 19 | Medium apartment | 125,000 |
| 13 | `MP_PROP_13` | 0504 S Mo Milton Dr | Medium apartment | 141,000 |
| 14 | `MP_PROP_14` | 0115 Bay City Ave, Apt 45 | Medium apartment | 150,000 |
| 15 | `MP_PROP_15` | 0325 South Rockford Dr | Medium apartment | 137,000 |
| 16 | `MP_PROP_16` | Dream Tower, Apt 15 | Medium apartment | 134,000 |
| 17 | `MP_PROP_17` | 2143 Las Lagunas Blvd, Apt 9 | Low-end apartment | 115,000 |
| 18 | `MP_PROP_18` | 1561 San Vitas St, Apt 2 | Low-end apartment | 99,000 |
| 19 | `MP_PROP_19` | 0112 S Rockford Dr, Apt 13 | Low-end apartment | 80,000 |
| 20 | `MP_PROP_20` | 2057 Vespucci Blvd, Apt 1 | Low-end apartment | 87,000 |
| 21 | `MP_PROP_21` | 0069 Cougar Ave, Apt 19 | Low-end apartment | 112,000 |
| 22 | `MP_PROP_22` | 1237 Prosperity St, Apt 21 | Low-end apartment | 105,000 |
| 23 | `MP_PROP_23` | 1115 Blvd Del Perro, Apt 18 | Low-end apartment | 93,000 |
| 24 | `MP_PROP_24` | 0120 Murrieta Heights | 10-car garage | 150,000 |
| 25 | `MP_PROP_25` | Unit 14 Popular St | 6-car garage | 77,500 |
| 26 | `MP_PROP_26` | Unit 2 Popular St | 10-car garage | 142,500 |
| 27 | `MP_PROP_27` | 331 Supply St | 10-car garage | 135,000 |
| 28 | `MP_PROP_28` | Unit 1 Olympic Fwy | 6-car garage | 70,000 |
| 29 | `MP_PROP_29` | 0754 Roy Lowenstein Blvd | 2-car garage | 29,500 |
| 30 | `MP_PROP_30` | 12 Little Bighorn Ave | 2-car garage | 32,000 |
| 31 | `MP_PROP_31` | Unit 124 Popular St | 2-car garage | 25,000 |
| 32 | `MP_PROP_32` | 0552 Roy Lowenstein Blvd | 6-car garage | 80,000 |
| 33 | `MP_PROP_33` | 0432 Davis Ave | 6-car garage | 72,500 |
| 34 | `MP_PROP_34` | Del Perro Heights, Apt 7 | High-end apartment or house | 200,000 |
| 35 | `MP_PROP_35` | Weazel Plaza, Apt 101 | High-end apartment or house | 335,000 |
| 36 | `MP_PROP_36` | Weazel Plaza, Apt 70 | High-end apartment or house | 319,000 |
| 37 | `MP_PROP_37` | Weazel Plaza, Apt 26 | High-end apartment or house | 304,000 |
| 38 | `MP_PROP_38` | 4 Integrity Way, Apt 30 | High-end apartment or house | 235,000 |
| 39 | `MP_PROP_39` | 4 Integrity Way, Apt 35 | High-end apartment or house | 247,000 |
| 40 | `MP_PROP_40` | Richards Majestic, Apt 4 | High-end apartment or house | 241,000 |
| 41 | `MP_PROP_41` | Richards Majestic, Apt 51 | High-end apartment or house | 253,000 |
| 42 | `MP_PROP_42` | Tinsel Towers, Apt 45 | High-end apartment or house | 270,000 |
| 43 | `MP_PROP_43` | Tinsel Towers, Apt 29 | High-end apartment or house | 286,000 |
| 44 | `MP_PROP_44` | 142 Paleto Blvd | 2-car garage | 26,500 |
| 45 | `MP_PROP_45` | 1 Strawberry Ave | 2-car garage | 26,000 |
| 46 | `MP_PROP_46` | 1932 Grapeseed Ave | 2-car garage | 27,500 |
| 47 | `MP_PROP_48` | 1920 Senora Way | 2-car garage | 32,000 |
| 48 | `MP_PROP_49` | 2000 Great Ocean Highway | 2-car garage | 31,500 |
| 49 | `MP_PROP_50` | 197 Route 68 | 2-car garage | 29,000 |
| 50 | `MP_PROP_51` | 870 Route 68 Approach | 6-car garage | 62,500 |
| 51 | `MP_PROP_52` | 1200 Route 68 | 2-car garage | 28,000 |
| 52 | `MP_PROP_57` | 8754 Route 68 | 6-car garage | 65,000 |
| 53 | `MP_PROP_59` | 1905 Davis Ave | 6-car garage | 75,000 |
| 54 | `MP_PROP_60` | 1623 South Shambles St | 10-car garage | 105,000 |
| 55 | `MP_PROP_61` | 4531 Dry Dock St | 6-car garage | 67,500 |
| 56 | `MP_PROP_62` | 1337 Exceptionalists Way | 10-car garage | 112,500 |
| 57 | `MP_PROP_63` | Unit 76 Greenwich Parkway | 10-car garage | 120,000 |
| 58 | `MP_PROP_64` | Garage Innocence Blvd | 2-car garage | 34,000 |
| 59 | `MP_PROP_65` | 634 Blvd Del Perro | 2-car garage | 33,500 |
| 60 | `MP_PROP_66` | 0897 Mirror Park Blvd | 2-car garage | 35,000 |
| 61 | `MP_PROP_67` | Eclipse Towers, Apt 3 | High-end apartment or house | 500,000 |
| 62 | `MP_PROP_68` | Del Perro Heights, Apt 4 | High-end apartment or house | 468,000 |
| 63 | `MP_PROP_69` | Richards Majestic, Apt 2 | High-end apartment or house | 484,000 |
| 64 | `MP_PROP_70` | Tinsel Towers, Apt 42 | High-end apartment or house | 492,000 |
| 65 | `MP_PROP_71` | 4 Integrity Way, Apt 28 | High-end apartment or house | 476,000 |
| 66 | `MP_PROP_72` | 4 Hangman Ave | Medium apartment | 175,000 |
| 67 | `MP_PROP_73` | 12 Sustancia Rd | Medium apartment | 143,000 |
| 68 | `MP_PROP_74` | 4584 Procopio Dr | Medium apartment | 155,000 |
| 69 | `MP_PROP_75` | 4401 Procopio Dr | Medium apartment | 165,000 |
| 70 | `MP_PROP_76` | 0232 Paleto Blvd | Low-end apartment | 121,000 |
| 71 | `MP_PROP_77` | 140 Zancudo Ave | Low-end apartment | 120,000 |
| 72 | `MP_PROP_78` | 1893 Grapeseed Ave | Low-end apartment | 118,000 |
| 73 | `MP_PROP_83` | 3655 Wild Oats Drive | High-end apartment or house | 800,000 |
| 74 | `MP_PROP_84` | 2044 North Conker Avenue | High-end apartment or house | 762,000 |
| 75 | `MP_PROP_85` | 2868 Hillcrest Avenue | High-end apartment or house | 672,000 |
| 76 | `MP_PROP_86` | 2862 Hillcrest Avenue | High-end apartment or house | 705,000 |
| 77 | `MP_PROP_87` | 3677 Whispymound Drive | High-end apartment or house | 478,000 |
| 78 | `MP_PROP_89` | 2117 Milton Road | High-end apartment or house | 608,000 |
| 79 | `MP_PROP_90` | 2866 Hillcrest Avenue | High-end apartment or house | 525,000 |
| 80 | `MP_PROP_92` | 2874 Hillcrest Avenue | High-end apartment or house | 571,000 |
| 81 | `MP_PROP_94` | 2113 Mad Wayne Thunder Drive | High-end apartment or house | 449,000 |
| 82 | `MP_PROP_95` | 2045 North Conker Avenue | High-end apartment or house | 727,000 |
| 83 | `MP_PROP_79` | Eclipse Towers, Penthouse Suite 1 | High-end apartment or house | 985,000 |
| 84 | `MP_PROP_80` | Eclipse Towers, Penthouse Suite 2 | High-end apartment or house | 905,000 |
| 85 | `MP_PROP_81` | Eclipse Towers, Penthouse Suite 3 | High-end apartment or house | 1,100,000 |
| 86 | `PM_SPAWN_Y` | Private Yacht | Yacht | 27,000,000 |
| 87 | `MP_PROP_OFF1` | Lombank West | Office | 3,100,000 |
| 88 | `MP_PROP_OFF2` | Maze Bank West | Office | 1,000,000 |
| 89 | `MP_PROP_OFF3` | Arcadius Business Center | Office | 2,250,000 |
| 90 | `MP_PROP_OFF4` | Maze Bank Tower | Office | 4,000,000 |
| 91 | `MP_PROP_CLUBH1` | Rancho Clubhouse | Clubhouse | 420,000 |
| 92 | `MP_PROP_CLUBH2` | Del Perro Beach Clubhouse | Clubhouse | 365,000 |
| 93 | `MP_PROP_CLUBH3` | Pillbox Hill Clubhouse | Clubhouse | 455,000 |
| 94 | `MP_PROP_CLUBH4` | Great Chaparral Clubhouse | Clubhouse | 200,000 |
| 95 | `MP_PROP_CLUBH5` | Paleto Bay Clubhouse | Clubhouse | 242,000 |
| 96 | `MP_PROP_CLUBH6` | Sandy Shores Clubhouse | Clubhouse | 210,000 |
| 97 | `MP_PROP_CLUBH7` | La Mesa Clubhouse | Clubhouse | 449,000 |
| 98 | `MP_PROP_CLUBH8` | Downtown Vinewood Clubhouse | Clubhouse | 472,000 |
| 99 | `MP_PROP_CLUBH9` | Hawick Clubhouse | Clubhouse | 495,000 |
| 100 | `MP_PROP_CLUBH10` | Grapeseed Clubhouse | Clubhouse | 225,000 |
| 101 | `MP_PROP_CLUBH11` | Paleto Bay Clubhouse | Clubhouse | 250,000 |
| 102 | `MP_PROP_CLUBH12` | Vespucci Beach Clubhouse | Clubhouse | 395,000 |
| 103 | `MP_PROP_OFFG1` | Office Garage 1 | Office garage | 1,150,000 |
| 104 | `MP_PROP_OFFG2` | Office Garage 2 | Office garage | 855,000 |
| 105 | `MP_PROP_OFFG3` | Office Garage 3 | Office garage | 745,000 |
| 106 | `MP_PROP_OFFG1` | Office Garage 1 | Office garage | 1,150,000 |
| 107 | `MP_PROP_OFFG2` | Office Garage 2 | Office garage | 855,000 |
| 108 | `MP_PROP_OFFG3` | Office Garage 3 | Office garage | 745,000 |
| 109 | `MP_PROP_OFFG1` | Office Garage 1 | Office garage | 1,150,000 |
| 110 | `MP_PROP_OFFG2` | Office Garage 2 | Office garage | 855,000 |
| 111 | `MP_PROP_OFFG3` | Office Garage 3 | Office garage | 745,000 |
| 112 | `MP_PROP_OFFG1` | Office Garage 1 | Office garage | 1,150,000 |
| 113 | `MP_PROP_OFFG2` | Office Garage 2 | Office garage | 855,000 |
| 114 | `MP_PROP_OFFG3` | Office Garage 3 | Office garage | 745,000 |
| 115 | `IE_WARE_1` | Vehicle Warehouse | Vehicle warehouse | 3,000,000 |

</details>

## 45.3 Slots: what a character can own

The stat behind each ownership slot (**Verified**, the slot-to-stat function in `am_mp_property_ext`):

| Slot | Stat | Holds |
| ---: | --- | --- |
| 0 | `PROPERTY_HOUSE` | First home |
| 1 to 4 | `MULTI_PROPERTY_1` to `4` | Extra homes |
| 5 | `PROP_OFFICE` | Office |
| 6 | `PROP_CLUBHOUSE` | Clubhouse |
| 7 | `MULTI_PROPERTY_5` | Extra home |
| 8 to 10 | `PROP_OFFICE_GAR1` to `3` | Office garages |
| 11 | `PROP_IE_WAREHOUSE` | Vehicle warehouse |
| 23, 24, 27, 28 | `MULTI_PROPERTY_6` to `9` | Extra homes |

So a character holds up to ten homes (house plus nine), one office with three garages, one clubhouse and one vehicle warehouse; the business properties are tracked by their own stats ([R7.7](/ROADMAP.md)).

## 45.4 Buying, prices and trading in

1. **Where:** the Dynasty 8 and Maze Bank Foreclosures websites on the in-game internet (`appinternet`, 593,334 lines), and the property's own entrance menu.
2. **The price** (**Verified**, `am_mp_property_ext`): on PC the script asks the server catalog (`NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID`, then `NET_GAMESERVER_GET_PRICE`); otherwise it uses the per-property tunable (a block of 115 tunables), whose default is the table in 45.2. A global sale multiplier tunable is applied on top.
3. **Trading in:** if the chosen slot already holds a home, the refund is half its stored purchase price, rounded (**Verified**: `× 0.5`). The refund is paid with `NETWORK_EARN_FROM_PROPERTY` (4 scripts), labelled with the old property's name hash.
4. **Paying:** `NETWORK_BUY_PROPERTY(price, property name hash, ...)` (18 scripts). The basket and server transaction around it is the PC shop flow in [Rockstar services](/docs/online/rockstar-services.md).
5. **Business properties** are bought in their own apps with their own spend natives (`NETWORK_SPENT_BUY_BUNKER`, `_BUY_BASE` in `appinternet`), and upgrades with `NETWORK_SPENT_UPGRADE_*` (12 natives, 1 to 24 scripts each).

## 45.5 From the door to the interior

**Entrances** (**Verified**). The 83 `AM_MP_PROPERTY_EXT` world points in `ambient_mp.ipl` start `am_mp_property_ext` through a world-point brain (range 120 m, brain set 8, Online only) ([R5.4](/docs/gameplay/missions/strangers-and-freaks.md)); `freemode` re-enables those brains when a session starts ([R7.1](/docs/online/07-freemode.md)).

**The exterior script** registers as a network script for 32 players with no instance (−1), shows the entrance menu (enter, enter with nearby friends and crew `PROP_HEI_E_2`, with organisation members `PROP_HEI_E_3`, buy) and blocks entry with a reason when it must:

| Label | Text |
| --- | --- |
| `CUST_APT_WH` | You cannot access Apartment while Wanted and in sight of the Cops. |
| `CUST_APT_MISO` | You can't access an Apartment while you have a mission objective. |
| `PROP_APT_HEI_WOH` | You cannot access Apartment until your team members lose their wanted level. |
| `CUST_GAR_FULL` | Garage Full |
| `PROP_BLOCK_1` | Unable to enter garage. Please enter property on foot. |
| `PROP_BLOCK_2` | Unable to enter garage. Please take this vehicle to mod shop to apply a tracker. |
| `PROP_BLOCK_TRAIL` | Unable to enter garage. Please detach trailer. |
| `MP_PROP_IVD_VEH` | This vehicle cannot be stored in your Garage. |

The same checks exist for garages, offices and clubhouses (`CUST_GAR_*`, `CUST_OFF_*`, `CUST_CLU_*`).

**The interior script** (`am_mp_property_int`) registers as a network script for 32 players **with an instance number** taken from its launch data, so each owner's apartment is a separate script session even when several players use the same building (**Verified** call; *probable* that the instance follows the owner). It runs the interior and starts (**Verified**):

| Started script | Stack | For |
| --- | ---: | --- |
| `appSecuroServ`, `appImportExport`, `appBikerBusiness` | 4,592 | Office and clubhouse computers ([R7.7](/ROADMAP.md)) |
| `appInternet` | 4,592 | The laptop or PC |
| `carmod_shop` | 3,750 | The office garage mod shop |
| `stripclub_drinking` | 2,050 | Clubhouse bar |
| `AM_MP_PEDS` | 15,900 | Staff and visitors ([R17.10](/docs/ai/script-ai-patterns.md)) |
| `ob_mp_shower_med`, `ob_jukebox` | 1,424 | The shower and the clubhouse jukebox |
| Seating and activity scripts | varies | Started from a table of 74-field activity entries |

## 45.6 Simple interiors: the business properties

The business properties use a shared "simple interior" system instead of the apartment code (**Verified**). Every Online script that needs it compiles in the same list of 181 names (`SIMPLE_INTERIOR_*`, index 0 to 180, the last `INVALID`):

| Kind | Count | Kind | Count |
| --- | ---: | --- | ---: |
| Special cargo warehouses | 22 | Arcades | 6 |
| Bunkers | 11 | Auto shops | 5 |
| Vehicle warehouses (`IE_WAREHOUSE`) | 10 | Bail offices | 5 |
| Facilities (`DEFUNCT_BASE`) | 9 | Salvage yards | 5 |
| Hangars | 5 | Agencies (`FIXER_HQ`) | 4 |
| Biker factories (weed, cash, meth, documents, cocaine) | 20 | Mansions | 3 |
| Nightclubs (`HUB_*`) | 10 | Small businesses (weed shop, heli tours, car wash) | 3 |
| Restricted mission interiors (banks, FIB building, carrier, chicken factory ...) | 43 | One each: casino, penthouse, valet garage, casino nightclub, car meet, arena garage, Kosatka, MOC, Avenger, Terrorbyte, creator trailer and aircraft, music studio, Eclipse multistorey garage, hacker den, juggalo hideout, acid lab, field hangar, Solomon's office | 19 |

`am_mp_smpl_interior_ext` (a network script registered with an instance number) handles the door, the entry checks and the walk-in, then starts `AM_MP_SMPL_INTERIOR_INT` (stack 2,512), which in turn starts the type's own script with stack 14,100: `AM_MP_BUNKER`, `AM_MP_HANGAR`, `AM_MP_NIGHTCLUB`, `AM_MP_ARCADE`, `AM_MP_AUTO_SHOP`, `AM_MP_FIXER_HQ`, `AM_MP_WAREHOUSE`, `AM_MP_IE_WAREHOUSE`, `AM_MP_BIKER_WAREHOUSE`, `AM_MP_BUSINESS_HUB`, `AM_MP_CASINO`, `AM_MP_SUBMARINE` and the others named in the [script catalog](/docs/online/02-script-catalog.md). Each type also names its enter, interior and exit audio scenes (`DLC_GR_Bunker_Enter`, `_Interior`, `_Exit` for the bunker).

The "restricted interiors" are the reason missions can send players into the banks, the FIB building or the carrier: they are entered through the same system as a business, but only while a mission allows it (*probable*, from the names and the shared code).

## 45.6a Garages, bills, yachts and instances (second pass)

*Second pass, 2026-10-26.* Read in the same decompile: `freemode` (the garage-size and utility-bill functions), `am_mp_property_int` (the instance), `am_mp_yacht` (the yacht spots), `am_mp_smpl_interior_ext` (entrances), `appinternet` (purchase pages), and `common\data\mpstatssetup.xml` from `update\update.rpf`. Tunable names and defaults come from `tuneables_processing`. Counts and values are **Verified** unless marked.

### Garage sizes and personal-vehicle records

One function in `freemode` gives the number of vehicle spaces, either for a property index or for one of the 36 ownership slots (**Verified**):

| Ownership slot | Owned through | Spaces |
| --- | --- | ---: |
| 0 to 4, 7, 23, 24, 27, 28 | the ten homes (`PROPERTY_HOUSE`, `MULTI_PROPERTY_1` to `9`) | 13 reserved; the home's class decides how many are used: 2, 6 or 10 (3, 8 or 13 when the function's third argument is set) |
| 5 | office (`PROP_OFFICE`) | 0 |
| 6 | clubhouse (`PROP_CLUBHOUSE`) | 10 |
| 8, 9, 10 | office garages (`PROP_OFFICE_GAR1` to `3`) | 20 each |
| 11 | vehicle warehouse (`PROP_IE_WAREHOUSE`) | 8 (*probable*: the eight special vehicles, matching an eight-entry list in `appinternet`: `ruiner2`, `blazer5`, `phantom2`, `voltic2`, `dune4`/`dune5`, `wastelander`, `boxville5`, `technical2`) |
| 12 | hangar (`PROP_HANGAR`) | 35 |
| 13 | facility (`PROP_DEFUNCBASE`) | 7 |
| 14 | nightclub (`PROP_NIGHTCLUB`) | 1 |
| 15, 16, 17 | nightclub garage floors (`PROP_MEGAWARE_GAR1` to `3`) | 10 each |
| 18, 19, 20 | Arena workshop garage floors (`PROP_ARENAWARS_GAR1` to `3`) | 10 each |
| 21 | Diamond Casino penthouse garage (`PROP_CASINO_GAR1`) | 10 |
| 22 | arcade garage (`PROP_ARCADE_GAR1`) | 10 |
| 25 | auto shop (`PROP_AUTO_SHOP`) | 10 |
| 26 | Agency garage (`PROP_SECURITY_OFFICE_GAR`) | 20 |
| 29 | Eclipse Blvd garage (`MULTSTOREY_GAR_OWNED`) | 50 |
| 31 | bail office (`PROP_BAIL_OFFICE`) | 2 |
| 32 | hacker den (`PROP_HACKER_DEN`) | 10 |
| 30, 33, 34, 35 | not in the slot-to-stat function; 33 to 35 have 20 spaces each | |

Property indices past 115 (not in the table of 45.2) get sizes by index: 116 = 35, 117 = 7, 118 = 1, 119 to 127 = 10 (122 = 9), 128 = 20, 129 = 50, 132 = 2, 133 = 10, 135 to 137 = 20. *Second pass (2026-10-30, **Verified**):* `freemode`'s slot-to-stat function names ownership slots 12 to 32 (the table above). The property indices 116 to 137 don't follow the slot numbers in a fixed offset, so which index is which property is still open (45.8).

Every personal vehicle is one **record** in a per-character array of **607**, kept in stats flagged `IsVehicle` (4,412 of them): `MPSV_MODEL_n`, `MPSV_FLAGS_n` (mod flags), `MPSV_VEHICLE_BS_n` (control flags), `MPSV_LP0_n` (the plate, a 64-bit stat), `MPSV_PRICE_PAID_n`, `MPSV_PREMIUM_PAID_n` (insurance paid by whoever destroyed it), `MPSV_IMPOUND_TIME_n`, and for 133 of them `MPSV_OBTAINED_TIME_n`, plus `MPSV_VEHICLE_TIMESTAMP` and named one-offs (`MPSV_MODEL_BIKER_CLT`, `_TUNER_VEH`, `_SALVAGE_VEH`). A `freemode` function maps record numbers to stat numbers in blocks (records 0 to 9, 13 to 22, 26 to 35 ... with three unused numbers after each block of ten up to record 362, then straight runs), so a home's 13 reserved records hold up to 10 real cars. Colours, wheels and mods aren't among these stat names; where the full vehicle setup is kept is an open question.

### Daily property fees (utility bills)

`freemode` charges everything at once, every **2,880,000 ms (48 real minutes, one in-game day)**, when no job or other block is active (**Verified**). It adds up (tunable names and defaults):

| What | Fee per day |
| --- | ---: |
| Each owned low-end home (class 4) | $25 (`low_aprt_util`) |
| Each owned medium home (class 5) | $50 (`mid_aprt_util`) |
| Each owned high-end home (class 6) | $75 (`high_aprt_util`) |
| Garages | none |
| Yacht | $500 (`yacht_utilities_cost`; off with `yacht_disable_utilities`) |
| Hangar | $250 utility + $0 staff (`smug_hangar_utility_fees`, `smug_hangar_staff_fees`) |
| Casino penthouse | $300 plus $25 per owned upgrade, up to eight (`vc_penthouse_utility_base`, `_expansion`) |
| A property flagged in the player's broadcast data (unnamed tunables) | $100 + $100, plus $100 more for each of three upgrades |
| Another flagged property | $150 |
| Each of three properties tracked in one bit field (probably the three mansions) | $600 base, +$10, +$10, +$500 and +$25 for each of four upgrades |

The total is shown with `MP_PROP_UTIL` ("You paid your combined Property charges totaling $~1~ for the day.") and paid through the transaction service (`service_spend_utility_bills`) or `NETWORK_SPEND_APARTMENT_UTILITIES`. If the player can't pay, a flag is set and the bill is tried again at the next session start (**Verified**). The Kosatka has its own fee service (`service_spend_submarine_utility_fee`).

### Yachts and other vehicles as properties

- **Bought on websites:** the yacht on Docktease (`WWW_DOCKTEASE_COM_S_YACHT_D_PURCHASE_SUCCESS`), the Mobile Operations Center, Avenger, Terrorbyte and Kosatka on Warstock Cache & Carry (`..._TRUCK_D_PURCHASE_OK`, `_AVENGER_D_BUY_D_OK`, `_HACKERTRUCK_D_SOLD`, `_SUB_D_PURCHASE_OK`). The model choice is a stat per vehicle (`INV_YACHT_MODEL_0`, `INV_TRUCK_MODEL_0`, `INV_HACKERTRUCK_MODEL_0`, `IH_SUB_OWNED`), the options are packed stats (`PACKED_MP_INT_KOSATKA_COLOUR`, `_FLAG`, `_SONAR`, `_GUIDED_MISSILES`, `_SEASPARROW2`, `_AVISA`, `_WEAPON_WORKSHOP`; `PACKED_MP_INT_HACKERTRUCK_INTERIOR_TINT`, `_DRONE_STATION` ...). Kosatka default price $2,200,000 (`ih_sub_base_kosatka`).
- **The yacht is placed at one of 36 fixed spots** around the coast, all at sea level (z 9.70): a table of 42 positions and headings in `am_mp_yacht`, where entries 0 to 35 are the player spots and 36 to 41 (z 9.71) are extra ones added later (*probable*: mission and event yachts). The yacht is built from props at that spot (`apa_mp_apa_yacht`, three hull options with rail and colour variants, `apa_mp_apa_yacht_option1` to `3`), not loaded as an IPL. Its property index is 86, and its interior uses instance slot 36 (below).
- The MOC, Avenger and Terrorbyte are stored in the bunker, facility (or hangar) and nightclub and called from the interaction menu (`PIM_HRTV1` "Your Mobile Operations Center is already stored in your Bunker", `PIM_AVEN1`); their interiors are simple interiors (45.6).

### Interior instances

`am_mp_property_int` registers as a 32-player network script with an **instance number from a 32-entry table** of active properties kept by the session: it looks for the row whose owner gamer handle and property match the one being entered (property 86, the yacht, is matched as 36), and uses that row number, 0 to 31. A player entering without an owner to match gets instance 32. So the instance is **per owner** (one per player's property in the session), not per building: two owners in the same Eclipse Towers building are in different instances (**Verified**).

### Simple-interior entrances

`am_mp_smpl_interior_ext` doesn't hold one coordinate list. Each interior type registers a table of about 40 functions; one of them returns the entrance data for an interior and entrance number (position, size, heading), which the script uses to draw the entry marker (`DRAW_MARKER` type 1, 0.75 m, in the interior's HUD colour) and the blip (`ADD_BLIP_FOR_COORD`). The three mansions' entrances are in the shared code: -2563.4, 1915.8, 167.8 · -1689.3, 481.8, 128.8 · 533.5, 770.8, 201.9 (interiors 177 to 179). The other types' lists sit behind those function pointers (open question).

**The 180 simple interiors by number** (*second pass, 2026-10-30*, **Verified**). One function in `am_mp_smpl_interior_ext` names every id. The numbers inside the names can skip, so a range like 70–80 holds 11 bunkers named up to `BUNKER_12`. The `SIMPLE_INTERIOR_` prefix is dropped here.

<details>
<summary>All 180 ids</summary>

| Ids | Names |
| --- | --- |
| 0–21 | `WAREHOUSE_1` to `WAREHOUSE_22` |
| 22 | `FACTORY_METH_1` |
| 23 | `FACTORY_WEED_1` |
| 24 | `FACTORY_CRACK_1` |
| 25 | `FACTORY_MONEY_1` |
| 26 | `FACTORY_DOCUMENTS_1` |
| 27 | `FACTORY_METH_2` |
| 28 | `FACTORY_WEED_2` |
| 29 | `FACTORY_CRACK_2` |
| 30 | `FACTORY_MONEY_2` |
| 31 | `FACTORY_DOCUMENTS_2` |
| 32 | `FACTORY_METH_3` |
| 33 | `FACTORY_WEED_3` |
| 34 | `FACTORY_CRACK_3` |
| 35 | `FACTORY_MONEY_3` |
| 36 | `FACTORY_DOCUMENTS_3` |
| 37 | `FACTORY_METH_4` |
| 38 | `FACTORY_WEED_4` |
| 39 | `FACTORY_CRACK_4` |
| 40 | `FACTORY_MONEY_4` |
| 41 | `FACTORY_DOCUMENTS_4` |
| 42 | `RESTRICTED_INTERIOR_POLICE_STATION` |
| 43 | `RESTRICTED_INTERIOR_MC_CLUBHOUSE` |
| 44 | `RESTRICTED_INTERIOR_BANK_ROCKFORD` |
| 45 | `RESTRICTED_INTERIOR_BANK_PILLBOX` |
| 46 | `RESTRICTED_INTERIOR_BANK_ALTA` |
| 47 | `RESTRICTED_INTERIOR_BANK_BURTON` |
| 48 | `RESTRICTED_INTERIOR_BANK_PALETO` |
| 49 | `RESTRICTED_INTERIOR_BANK_GRAND_SENORA` |
| 50 | `RESTRICTED_INTERIOR_BANK_CHUMASH` |
| 51 | `RESTRICTED_INTERIOR_ROCKCLUB` |
| 52 | `RESTRICTED_INTERIOR_CHICKEN_FACTORY` |
| 53–55 | `RESTRICTED_INTERIOR_CHICKEN_FACTORY_PART_2` to `RESTRICTED_INTERIOR_CHICKEN_FACTORY_PART_4` |
| 56 | `RESTRICTED_INTERIOR_FARMHOUSE` |
| 57 | `RESTRICTED_INTERIOR_HEIST_YACHT` |
| 58 | `RESTRICTED_INTERIOR_RECYCLING_PLANT` |
| 59 | `RESTRICTED_INTERIOR_BIOLAB` |
| 60–69 | `IE_WAREHOUSE_1` to `IE_WAREHOUSE_10` |
| 70–80 | `BUNKER_1` to `BUNKER_12` |
| 81 | `ARMORY_TRUCK_1` |
| 82 | `CREATOR_TRAILER_1` |
| 83–87 | `HANGAR_1` to `HANGAR_5` |
| 88 | `ARMORY_AIRCRAFT_1` |
| 89–97 | `DEFUNCT_BASE_1` to `DEFUNCT_BASE_10` |
| 98 | `RESTRICTED_INTERIOR_MEDIUM_GARAGE` |
| 99 | `RESTRICTED_INTERIOR_LOWEND_STUDIO` |
| 100 | `RESTRICTED_INTERIOR_MIDEND_APARTMENT` |
| 101 | `CREATOR_AIRCRAFT_1` |
| 102 | `HUB_LA_MESA` |
| 103 | `HUB_MISSION_ROW` |
| 104 | `HUB_STRAWBERRY_WAREHOUSE` |
| 105 | `HUB_WEST_VINEWOOD` |
| 106 | `HUB_CYPRESS_FLATS` |
| 107 | `HUB_LSIA_WAREHOUSE` |
| 108 | `HUB_ELYSIAN_ISLAND` |
| 109 | `HUB_DOWNTOWN_VINEWOOD` |
| 110 | `HUB_DEL_PERRO_BUILDING` |
| 111 | `HUB_VESPUCCI_CANALS` |
| 112–113 | `RESTRICTED_INTERIOR_SHERIFF` to `RESTRICTED_INTERIOR_SHERIFF2` |
| 114 | `RESTRICTED_INTERIOR_UNION_DEPOSITORY_CARPARK` |
| 115 | `RESTRICTED_INTERIOR_SIMEON_SHOWROOM` |
| 116 | `RESTRICTED_INTERIOR_ABATTOIR` |
| 117 | `HACKER_TRUCK` |
| 118 | `RESTRICTED_INTERIOR_JEWEL_STORE` |
| 119 | `RESTRICTED_INTERIOR_LIFE_INVADER` |
| 120 | `RESTRICTED_INTERIOR_DJ_YACHT` |
| 121 | `RESTRICTED_INTERIOR_MELANOMA_GARAGE` |
| 122 | `ARENA_GARAGE_1` |
| 123 | `CASINO` |
| 124 | `CASINO_APT` |
| 125 | `CASINO_VAL_GARAGE` |
| 126 | `RESTRICTED_INTERIOR_HAYES_AUTOS` |
| 127 | `RESTRICTED_INTERIOR_METH_LAB` |
| 128 | `ARCADE_PALETO_BAY` |
| 129 | `ARCADE_GRAPESEED` |
| 130 | `ARCADE_DAVIS` |
| 131 | `ARCADE_WEST_VINEWOOD` |
| 132 | `ARCADE_ROCKFORD_HILLS` |
| 133 | `ARCADE_LA_MESA` |
| 134 | `RESTRICTED_INTERIOR_FIB_BUILDING` |
| 135 | `RESTRICTED_INTERIOR_BIOLAB_AND_TUNNEL` |
| 136 | `RESTRICTED_INTERIOR_FOUNDRY` |
| 137 | `RESTRICTED_INTERIOR_MAX_RENDA` |
| 138 | `RESTRICTED_INTERIOR_AIRCRAFT_CARRIER` |
| 139–143 | `RESTRICTED_INTERIOR_AIRCRAFT_CARRIER_PART_2` to `RESTRICTED_INTERIOR_AIRCRAFT_CARRIER_PART_6` |
| 144 | `RESTRICTED_INTERIOR_OMEGA` |
| 145 | `SOLOMONS_OFFICE` |
| 146 | `CASINO_NIGHTCLUB` |
| 147 | `SUBMARINE` |
| 148 | `MUSIC_STUDIO` |
| 149 | `AUTO_SHOP_LA_MESA` |
| 150 | `AUTO_SHOP_STRAWBERRY` |
| 151 | `AUTO_SHOP_BURTON` |
| 152 | `AUTO_SHOP_RANCHO` |
| 153 | `AUTO_SHOP_MISSION_ROW` |
| 154 | `CAR_MEET` |
| 155 | `FIXER_HQ_HAWICK` |
| 156 | `FIXER_HQ_ROCKFORD` |
| 157 | `FIXER_HQ_SEOUL` |
| 158 | `FIXER_HQ_VESPUCCI` |
| 159 | `ACID_LAB` |
| 160 | `JUGGALO_HIDEOUT` |
| 161 | `MULTISTOREY_GARAGE` |
| 162 | `SALVAGE_YARD_PALETO_BAY` |
| 163 | `SALVAGE_YARD_SANDY_SHORES` |
| 164 | `SALVAGE_YARD_LA_PUERTA` |
| 165 | `SALVAGE_YARD_STRAWBERRY` |
| 166 | `SALVAGE_YARD_MURIETTA_HEIGHTS` |
| 167 | `BAIL_OFFICE_MISSION_ROW` |
| 168 | `BAIL_OFFICE_WEST_VINEWOOD` |
| 169 | `BAIL_OFFICE_DEL_PERRO` |
| 170 | `BAIL_OFFICE_DAVIS` |
| 171 | `BAIL_OFFICE_PALETO_BAY` |
| 172 | `HACKER_DEN` |
| 173 | `FIELD_HANGAR` |
| 174 | `SMALL_BUSINESS_CAR_WASH` |
| 175 | `SMALL_BUSINESS_WEED_SHOP` |
| 176 | `SMALL_BUSINESS_HELI_TOURS` |
| 177 | `MANSION_TONGVA_HILLS` |
| 178 | `MANSION_WEST_VINEWOOD` |
| 179 | `MANSION_EAST_VINEWOOD` |

</details>

Of the per-type entrance functions, six share the mansions' shape (position, second position, size): the mansions (177 to 179), the salvage yards (162 to 166), and four more that take an entrance number. The rest use other shapes and are still open (45.8).

### The business side

What each business interior produces, sells and costs is in [organisations and businesses](/docs/online/organisations-and-businesses.md#464-the-business-loop) (R7.7).

## 45.7 What this means for modders

These are Online systems: read them, never mod them in Online. For a story-mode or offline project:

- **The property table is a ready data set:** 85 homes with names, classes and prices; entrances are the 83 `AM_MP_PROPERTY_EXT` points in `ambient_mp.ipl` ([Online data files](/docs/online/03-online-data-files.md)). A story-mode housing mod can reuse the names, the classes and the 50% trade-in rule in its own save.
- **The interiors are map data and IPLs,** separate from the scripts; loading them in story mode is a streaming job ([R1.5](/docs/core/streaming.md)), not a reason to run `am_mp_property_int`, which needs `freemode`, network instances and the server.
- **Prices on PC come from the server,** so the script table is only a default; an offline project must pick its own prices.
- **Copy the entry checks:** wanted and in sight of police, on a mission, team wanted, vehicle not storable, trailer attached. They make a mod's doors feel like Rockstar's.

## 45.8 Open questions

| Question | Where it goes |
| --- | --- |
| How the yacht, Kosatka and other vehicles-as-properties are bought and placed | Answered in [45.6a](#yachts-and-other-vehicles-as-properties) (second pass) |
| Where garage capacities and vehicle slots are stored, and how a personal vehicle is saved per slot | Partly answered in [45.6a](#garage-sizes-and-personal-vehicle-records): sizes per slot and the 607 `MPSV_*` records; where colours and mods are kept is still open |
| The simple-interior entrance positions and which script places the doors | Partly answered in [45.6a](#simple-interior-entrances): the mechanism, all 180 interior ids, and the entrances of the mansions and salvage yards; the other types' positions sit behind per-type function pointers |
| Instance numbering of `am_mp_property_int` (owner id, building, or both) | Answered in [45.6a](#interior-instances): per owner, rows 0 to 31, 32 without an owner |
| Daily property fees (utility bills) and how they are charged | Answered in [45.6a](#daily-property-fees-utility-bills) |
| The business side of each simple interior | Answered in [organisations and businesses](/docs/online/organisations-and-businesses.md#464-the-business-loop) (R7.7) |
| Which business or vehicle the garage indices 116 to 137 and ownership slots 12 to 35 are | Mostly answered (second pass): slots 12 to 32 named in [the garage table](#garage-sizes-and-personal-vehicle-records); slots 30 and 33 to 35 and the indices 116 to 137 left |
| Where a personal vehicle's colours, wheels and mods are saved | Next pass, the vehicle save code in `freemode` and `carmod_shop` |
