# Venpi's Cave Overhaul

## Version 1.0.8
* Accidental link to Scale the World The Sequel happened. This has been removed. 

## Version 1.0.7
* Removed the random creature spawner no matter how I try it, it breaks the CCT buildup of the creature so you get the skin but no stats or abilities. 
* Better compatibility with Scale The World (https://www.nexusmods.com/starfield/mods/7425)
* Added special ghost cave encounter
* Starborn will now only spawn if normal quest locks are cleared or in a NG+ universe
* Found yet another "cave" PCM node generator making 5 total. Someone needs to tell BGS duplication in programming is very bad. No wonder som of the PCM cell requests have 10 copies. 
* Also added the cache sites to the Natural Block list too as they spawn so many relative and are always the same
* Everything is stable now but more encounters will be added over time between myself and JaeDL so removing the beta tags

## Version 1.0.6 (BETA)
* Implemented a "safe" random creature spawner. Currently only has about a quarter of the predator factions and as a fail-safe a 50% chance for a terrormorph. It uses the is safe to spawn logic for creatures.
* The new predator spawner is used in "Windswept Cave (OEZW007)" and "Cave (OEAF002)"
* Added a new open world encounter a spacer mech camp. It can happen on any human occupied system's planets/moons. 

## Version 1.0.5 (BETA)
* Implemented a "safe" random human spawner will only spawn ally factions
* The new human spawner is used in "Cave (OEBB034)" and "Cave (OEAF005)"
* Added a cave with a multi-way battle or a Terraform Royal Queen and subjects see "Tiered Cave (OEZW008)"

## Version 1.0.4 (BETA)
* Cached content is fun, so really really everything is named this time... 
* Also found a new cave, if you find Cave (OEBB034) please let me know where and what it is. 

## Version 1.0.3 (BETA)
* So for some silly reason locations control the cave entrance names not the cell/worldspace

## Version 1.0.2 (BETA)
* Renamed the world space name's for the caves to include their editor ID for bug reporting.
* Known issue: The probable reason for the empty caves is BGS didn't want to sort out the atmosphere issues. The RE engine handles it because of it's spawn conditions, AKA it only selects "safe" worlds. This is the cause of the dead standing creatures, the cave spawned on a world with no atmosphere. 

## Version 1.0.1 (BETA)
* Added new terrormorph elder controller fun cave (1 controller, 3 humans, 2 robots, and 3 predators) for a fun multi-way battle until the elder takes over everyone. 
* Added 3 more creature caves
* For the remaining caves, I think I might have found the real bug. Testing the fix of adding CCT_Enviro_Underground [KYWD:001122A6] to the cave's location record. This is on random caves you have to zone into but the open world caves you just enter only have this fix. I could use feedback it it is working. 

## Version 1.0.0 (BETA)
* Initial Release
* The open world caves will now spawn enemies without having to be in a random encounter quest
