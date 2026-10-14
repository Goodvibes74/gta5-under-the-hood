# DLC packs and their vehicles

Inventory of every Rockstar DLC pack in build 1.0.3725.0 (Legacy). Use it to check what content a given build actually has. Scanned with [`dlc-scan.ps1`](/tools/dlc-scan.ps1), which uses the CodeWalker.Core library, decrypts in memory and never writes to an archive.

## Summary

- **89 packs** in `update/x64/dlcpacks/`, and **all 89 are active**: each one is listed in `dlclist.xml` inside `update.rpf`.
- **10 base-game packs** (2013 to 2014) live inside the root `x64*.rpf` archives and are also active (`platform:/dlcPacks/...` entries).
- That is **48 content updates**, from Beach Bum (2013) to the December 2025 update (`mp2025_02`). In other words, everything Rockstar released for Online up to this game build.
- The 89 packs break down as:
  - 38 content packs;
  - 2 support packs (`mppatchesng`, `mpreplay`);
  - 9 Expanded & Enhanced packs (`mpg9ec` and 8 `mp*_g9ec`);
  - 40 patch packs (`patchday*`, `patch20*`, including 6 `g9ec` patch packs).
- **581 vehicle models** are defined across the DLC packs, not counting the base-game packs.

## What this means for modders

- **The game streams every DLC's content in story mode too.** Vehicles, clothing, interiors, props and cutscenes from all 48 updates are loaded by the base game, so a story-mode mod can spawn any DLC vehicle or load any DLC interior IPL without extra files.
- **Shops and missions are not.** The Online dealership websites, clothing catalogues and mission scripts only run in Online, so a mod that sells DLC vehicles or recreates DLC missions has to provide that logic itself.

## Content packs

The internal name comes from each pack's `setup2.xml` (`nameHash`). The title and date come from Rockstar's release history; entries marked *probable* were matched by their vehicle list and should be confirmed in game. The order is the `setup2.xml` load order. Vehicle and map counts are files inside the pack.

### Base game (inside `x64*.rpf`)

| Pack | Update |
| --- | --- |
| `mpBeach` | Beach Bum (2013) |
| `mpBusiness` | Business (2014) |
| `mpChristmas` | Festive 2013 |
| `mpValentines` | Valentine's Day Massacre (2014) |
| `mpBusiness2` | High Life (2014) |
| `mpHipster` | I'm Not a Hipster (2014) |
| `mpIndependence` | Independence Day Special (2014) |
| `mpPilot` | San Andreas Flight School (2014) |
| `mpLTS` | Last Team Standing (2014) |
| `spUpgrade` | Story-mode returning-player content |

### `update/x64/dlcpacks`

| Pack | Order | Update | Vehicles | Maps (`.ymap`) |
| --- | --- | --- | --- | --- |
| `mpchristmas2` | 9 | Festive Surprise 2014 | 4 | 0 |
| `mpheist` | 10 | Heists (2015) | 21 | 3565 |
| `mpluxe` | 11 | Ill-Gotten Gains Part 1 (2015) | 6 | 0 |
| `mpluxe2` | 12 | Ill-Gotten Gains Part 2 (2015) | 6 | 0 |
| `mpreplay` | 13 | Rockstar Editor support | 0 | 0 |
| `mplowrider` | 14 | Lowriders (2015) | 8 | 604 |
| `mphalloween` | 15 | Halloween Surprise (2015) | 2 | 0 |
| `mpapartment` | 16 | Executives and Other Criminals (2015) | 25 | 705 |
| `mpxmas_604490` | 17 | Festive Surprise 2015 | 1 | 0 |
| `mpjanuary2016` | 18 | January 2016 update | 2 | 0 |
| `mpvalentines2` | 19 | Be My Valentine (2016) | 1 | 0 |
| `mplowrider2` | 20 | Lowriders: Custom Classics (2016) | 7 | 0 |
| `mpexecutive` | 21 | Further Adventures in Finance and Felony (2016) | 14 | 40 |
| `mpstunt` | 22 | Cunning Stunts (2016) | 15 | 0 |
| `mpbiker` | 23 | Bikers (2016) | 21 | 155 |
| `mpimportexport` | 24 | Import/Export (2016) | 24 | 21 |
| `mpspecialraces` | 25 | Cunning Stunts: Special Vehicle Circuit (2017) | 4 | 0 |
| `mpgunrunning` | 26 | Gunrunning (2017) | 19 | 30 |
| `mpairraces` | 27 | Air races (2017, *probable*) | 0 | 0 |
| `mpsmuggler` | 28 | Smuggler's Run (2017) | 19 | 2 |
| `mpchristmas2017` | 29 | The Doomsday Heist (2017) | 30 | 53 |
| `mpassault` | 30 | Southern San Andreas Super Sport Series (2018) | 16 | 0 |
| `mpbattle` | 31 | After Hours (2018) | 14 | 68 |
| `mpchristmas2018` | 32 | Arena War (2018) | 46 | 8 |
| `mpvinewood` | 33 | The Diamond Casino & Resort (2019) | 22 | 216 |
| `mpheist3` | 34 | The Diamond Casino Heist (2019) | 20 | 17 |
| `mpsum` | 35 | Los Santos Summer Special (2020) | 15 | 4 |
| `mpheist4` | 36 | The Cayo Perico Heist (2020) | 21 | 340 |
| `mptuner` | 37 | Los Santos Tuners (2021) | 18 | 26 |
| `mpsecurity` | 38 | The Contract (2021) | 17 | 31 |
| `mpg9ec` | 39 | Expanded & Enhanced content (2022) | 5 | 0 |
| `mpsum2` | 40 | The Criminal Enterprises (2022) | 18 | 5 |
| `mpchristmas3` | 42 | Los Santos Drug Wars (2022) | 17 | 22 |
| `mp2023_01` | 44 | San Andreas Mercenaries (2023) | 17 | 6 |
| `mp2023_02` | 46 | The Chop Shop (2023) | 33 | 27 |
| `mp2024_01` | 48 | Bottom Dollar Bounties (2024) | 21 | 31 |
| `mp2024_02` | 50 | Agents of Sabotage (December 2024, *probable*) | 18 | 16 |
| `mp2025_01` | 52 | Money Fronts (2025, *probable*) | 19 | 16 |
| `mp2025_02` | 54 | December 2025 update (title to confirm) | 15 | 234 |

### Expanded & Enhanced and patch packs

- **Expanded & Enhanced companions:** `mpSum2_G9EC`, `mpchristmas3_g9ec`, `mp2023_01_g9ec`, `mp2023_02_g9ec`, `mp2024_01_g9ec`, `mp2024_02_g9ec`, `mp2025_01_G9EC`, `mp2025_02_g9ec`. Some trainers warn that these "Gen9" packs can make their spawners unstable.
- **Patch packs:**
  - `patchday1ng` to `patchday28ng` plus `patchday2bng`;
  - `patch2023_01`, `patch2023_02`, `patch2024_01`, `patch2024_02`, `patch2025_01`, `patch2025_02`;
  - `g9ec` versions: `patchdayg9ecng`, `patchday27g9ecng`, `patchday28g9ecng`, `patch2023_01_g9ec`, `patch2024_01_g9ec`, `patch2025_02_g9ec`.
- The patch packs carry fixes and replaced map files; the large ones are `patchday2ng` (2,649 maps), `patchday1ng` (1,728) and `patchday27ng` (953).

## Vehicle models per pack

Model names from each pack's `vehicles.meta` (`<modelName>`), usable with `World.CreateVehicle(new Model("name"), ...)` or Menyoo.

| Pack | Count | Models |
| --- | --- | --- |
| `mpchristmas2` | 4 | jester2, massacro2, ratloader2, slamvan |
| `mpheist` | 21 | barracks3, boxville4, casco, dinghy3, enduro, gburrito2, guardian, hydra, insurgent, insurgent2, kuruma, kuruma2, lectro, mule3, savage, slamvan2, tanker2, technical, trash2, valkyrie, velum2 |
| `mpluxe` | 6 | feltzer3, luxor2, osiris, swift2, virgo, windsor |
| `mpluxe2` | 6 | brawler, chino, coquette3, t20, toro, vindicator |
| `mplowrider` | 8 | buccaneer2, chino2, faction, faction2, moonbeam, moonbeam2, primo2, voodoo |
| `mphalloween` | 2 | btype2, lurcher |
| `mpapartment` | 25 | baller3, baller4, baller5, baller6, cargobob4, cog55, cog552, cognoscenti, cognoscenti2, dinghy4, limo2, mamba, nightshade, schafter3, schafter4, schafter5, schafter6, seashark3, speeder2, supervolito, supervolito2, toro2, tropic2, valkyrie2, verlierer2 |
| `mpxmas_604490` | 1 | tampa |
| `mpjanuary2016` | 2 | banshee2, sultanrs |
| `mpvalentines2` | 1 | btype3 |
| `mplowrider2` | 7 | faction3, minivan2, sabregt2, slamvan3, tornado5, virgo2, virgo3 |
| `mpexecutive` | 14 | bestiagts, brickade, fmj, nimbus, pfister811, prototipo, reaper, rumpo3, seven70, tug, volatus, windsor2, xls, xls2 |
| `mpstunt` | 15 | bf400, brioso, cliffhanger, contender, gargoyle, le7b, lynx, omnis, rallytruck, sheava, tampa2, trophytruck, trophytruck2, tropos, tyrus |
| `mpbiker` | 21 | avarus, blazer4, chimera, daemon2, defiler, esskey, faggio, faggio3, hakuchou2, manchez, nightblade, raptor, ratbike, sanctus, shotaro, tornado6, vortex, wolfsbane, youga2, zombiea, zombieb |
| `mpimportexport` | 24 | blazer5, boxville5, comet3, diablous, diablous2, dune4, dune5, elegy, fcr, fcr2, italigtb, italigtb2, nero, nero2, penetrator, phantom2, ruiner2, ruiner3, specter, specter2, technical2, tempesta, voltic2, wastelander |
| `mpspecialraces` | 4 | gp1, infernus2, ruston, turismo2 |
| `mpgunrunning` | 19 | apc, ardent, caddy3, cheetah2, dune3, halftrack, hauler2, insurgent3, nightshark, oppressor, phantom3, tampa3, technical3, torero, trailerlarge, trailers4, trailersmall2, vagner, xa21 |
| `mpsmuggler` | 19 | alphaz1, bombushka, cyclone, havok, howard, hunter, microlight, mogul, molotok, nokota, pyro, rapidgt3, retinue, rogue, seabreeze, starling, tula, vigilante, visione |
| `mpchristmas2017` | 30 | akula, autarch, avenger, avenger2, barrage, chernobog, comet4, comet5, deluxo, gt500, hermes, hustler, kamacho, khanjali, neon, pariah, raiden, revolter, riata, riot2, savestra, sc1, sentinel3, streiter, stromberg, thruster, viseris, volatol, yosemite, z190 |
| `mpassault` | 16 | caracara, cheburek, dominator3, ellie, entity2, fagaloa, flashgt, gb200, hotring, issi3, jester3, michelli, seasparrow, taipan, tezeract, tyrant |
| `mpbattle` | 14 | blimp3, freecrawler, menacer, mule4, oppressor2, patriot2, pbus2, pounder2, scramjet, speedo4, stafford, strikeforce, swinger, terbyte |
| `mpchristmas2018` | 46 | bruiser, bruiser2, bruiser3, brutus, brutus2, brutus3, cerberus, cerberus2, cerberus3, clique, deathbike, deathbike2, deathbike3, deveste, deviant, dominator4, dominator5, dominator6, impaler, impaler2, impaler3, impaler4, imperator, imperator2, imperator3, issi4, issi5, issi6, italigto, monster3, monster4, monster5, rcbandito, scarab, scarab2, scarab3, schlagen, slamvan4, slamvan5, slamvan6, toros, tulip, vamos, zr380, zr3802, zr3803 |
| `mpvinewood` | 22 | caracara2, drafter, dynasty, emerus, gauntlet3, gauntlet4, hellion, issi7, jugular, krieger, locust, nebula, neo, novak, paragon, paragon2, peyote2, rrocket, s80, thrax, zion3, zorrusso |
| `mpheist3` | 20 | asbo, everon, formula, formula2, furia, imorgon, jb7002, kanjo, komoda, minitank, outlaw, rebla, retinue2, stryder, sugoi, sultan2, vagrant, vstr, yosemite2, zhaba |
| `mpsum` | 15 | club, coquette4, dukes3, gauntlet5, glendale2, landstalker2, manana2, openwheel1, openwheel2, penumbra2, peyote3, seminole2, tigon, yosemite3, youga3 |
| `mpheist4` | 21 | alkonost, annihilator2, avisa, brioso2, dinghy5, italirsx, kosatka, longfin, manchez2, patrolboat, seasparrow2, seasparrow3, slamtruck, squaddie, toreador, verus, vetir, veto, veto2, weevil, winky |
| `mptuner` | 18 | calico, comet6, cypher, dominator7, dominator8, euros, freightcar2, futo2, growler, jester4, previon, remus, rt3000, sultan3, tailgater2, vectre, warrener2, zr350 |
| `mpsecurity` | 17 | astron, baller7, buffalo4, champion, cinquemila, comet7, deity, granger2, ignus, iwagen, jubilee, mule5, patriot3, reever, shinobi, youga4, zeno |
| `mpg9ec` | 5 | arbitergt, astron2, cyclone2, ignus2, s95 |
| `mpsum2` | 18 | brioso3, conada, corsita, draugur, greenwood, kanjosj, lm87, omnisegt, postlude, rhinehart, ruiner4, sentinel4, sm722, tenf, tenf2, torero2, vigero2, weevil2 |
| `mpchristmas3` | 17 | boor, brickade2, broadway, cargoplane2, entity3, eudora, everon2, issi8, journey2, manchez3, panthere, powersurge, r300, surfer3, tahoma, tulip2, virtue |
| `mp2023_01` | 17 | avenger3, avenger4, brigham, buffalo5, clique2, conada2, coureur, gauntlet6, inductor, inductor2, l35, monstrociti, raiju, ratel, speedo5, stingertt, streamer216 |
| `mp2023_02` | 33 | aleutian, asterope2, baller8, benson2, boattrailer2, boattrailer3, boxville6, cavalcade3, dominator9, dorado, drifteuros, driftfr36, driftfuto, driftjester, driftremus, drifttampa, driftyosemite, driftzr350, fr36, freight2, impaler5, impaler6, phantom4, polgauntlet, police5, terminus, towtruck3, towtruck4, trailers5, turismo3, tvtrailer2, vigero3, vivanite |
| `mp2024_01` | 21 | castigator, coquette5, dominator10, driftcypher, driftnebula, driftsentinel, driftvorschlag, envisage, eurosx32, niobe, paragon3, pipistrello, pizzaboy, poldominator10, poldorado, polgreenwood, policet3, polimpaler5, polimpaler6, vorschlaghammer, yosemite1500 |
| `mp2024_02` | 18 | banshee3, cargobob5, chavosv6, coquette6, driftcheburek, driftfuto2, driftjester3, duster2, firebolt, freightcar3, jester5, polcaracara, polcoquette4, polfaction2, polterminus, titan2, uranus, youga5 |
| `mp2025_01` | 19 | cheetah3, driftchavosv6, driftdominator10, driftgauntlet4, drifthardy, driftl352, everon3, flatbed2, hardy, l352, maverick2, minimus, policeb2, rapidgt4, sentinel5, stockade4, suzume, tampa4, woodlander |
| `mp2025_02` | 15 | astrale, driftdominator9, driftkeitora, driftrt3000, driftsentinel2, fmj2, gt750, itali2, keitora, luiva, polbuffalo, polbuffalo6, sentinel6, vivanite2, xtreme |

## Refreshing this file

Run with the game closed or open (read-only either way), then update the tables:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\dlc-scan.ps1 -Out "$env:TEMP\dlcscan"
```

It prints one line per pack and writes `dlcscan.json` plus each pack's `setup2.xml`, `content.xml` and `vehicles.meta` to the output folder.
