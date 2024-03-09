# Venworks Cave and Encounters Overhaul

## Version 2.0.5
* Added new special encounters setup for the non-faction encounters I dream up.
* Removed Random Event Quest Marauders01 as BGS change the scripts in a painful way for a limited functionality encounter.
* The First encounters will now only spawn in systems that allow The First.
* The 3 crimson fleet robots will only spawn in crimson fleet areas.
* Added two special encounters involving random corpses.
* Ok no more scripted encounters until someone writes a script cache purger or CK2. Too much of a pain making a new universe every script change. 

## Version 2.0.4
* New The First encounter related to the first encounter.
* New random hostile human encounters science research encampment. 
* Setting chance to zero actually disables stuff I love logic errors 0 is <= to Chance. 

## Version 2.0.3
* Last Starfield update redid all the caves yet again. Restoring those changes and merging in mine. 

## Version 2.0.2
* New random and robot spawn setups see help for the new commands: ```CGF "VEOH_Help.Show"```
* Added a new command to show if your current location/planet/system meets spawn conditions: ```CGF "VEOH_Debug.GetSpawnConditionsForCurrentLocation"```
* Fixed the robot babysitter camp so layout doesn't fail on odd terrains. Still haven't found a way to get it to properly trigger the kill creatures for meat quest. 

## Version 2.0.1
* New load order exposed a conflict with Core Coe, Multiversal Book Hunter so a new patch is in optional files. 

## Version 2.0.0
* Found some caves still not using the biome markers they are now
* Spacers in human hostile lists are the fallback condition
* Removed localization using xedit 4.1.5c it was causing too many problems for players. 
* Now requires Venworks Faction Overhaul. 

## Version 1.0.27
* Sorry I left the testing spawn rate in for the new treasure map encounter this has been reset to 15% to fix any active save you will need to run: CGF "VEOH_Debug.ResetFriendlyCampSpawnSettings"
* Added new First Cav camp (Yes this time I reset the spawn rate to it's default 20%)
* Added some more NPCs to man made clutter (4)

## Version 1.0.26
* New friendlies camp 2 dead pirates and a treasure map. 
* All dynamic spawned lair type camps I made the NPCs persistent in the pack-in so hopefully they will be stored in the save and stop becoming level 1 humans. 
* The human lair stuff have been converted over to use spacer or crimson fleet until I figure out a better solution for the hostile human leveled list sometime return a generic non-hostile "Human".
* Restored the All Factions Patch but its back to Cora Coe, Multiversal Book Hunter and Grind Terra Factions. If you need POI Faction Diversity support I can provide a RTFP ini file to inject it. Personally long term I think RTFP is the the better way :) 

## Version 1.0.25
* Added the first friendlies camp, a boy and a robot camping. This may or may not give a collect meat locally quest (random chance).
* When a rule branch is traversed a a leaf must return or bad things happen I think it just grabs a random leaf. This is why the branch rules and leafs generally have near identical conditions to prevent a leaf not being available. 
* Added a second spacer camp with 2 NPCs and a loot chest (Aid/Food).
* Added new distance variables and debug commands to configure/display them.
* Human branch rule chain now uses conditions forms but only the ones with _SafeToOverride can be safely changed. If this system stays stable I'll expand it to the BGS rules sets so we can start fixing them. 
* Redid all the console commands please see the new help using: CGF "VEOH_Help.Show".
* NOTE: The next version will move to RTFP so patching is no longer needed for leveled lists and story manager. Please post if you object to this it supports both ASI and SFSE. 

## Version 1.0.24
* Significantly reduced Spacer camp spawns.
* Should have the war zone tamed should only be able to get 1 camp per 900m square. Its not longer random change I'll work on adding that back after but I also think that may have been the trigger based on the lame way the PCM rule tree works and evaluates. Because the rule that triggered didn't get satisfied it went trying until it found something to shove there. None of the other rules use GetRandomPercent so not sure its save in this context. 

## Version 1.0.23
* Reuploading all factions patch, nexus is serving out an old file for some reason

## Version 1.0.22
* Change all factions patch to use GrindTerraIndustriesFactionDiversityVersion.esm as the master instead. Thanks Javapower77 for reporting.

## Version 1.0.21
* Reordered PCM general list to make creatures more common and traits less. Also put the new human camps in the middle.
* Switched spacers to a new global set to 20% chance from 40% 
* Added a check for minimum distance from LocTypOutpost but I'm not sure that actually means player outpost
* Added new debug command to set custom spawn rate for spacer camps: CGF "VEOH_Debug.SetSpacerCampSpawnRate" <chance:integer>

## Version 1.0.20
* Hostile Human Factions are now neutral to critters and prey. 
* Moved the are hostile actors near check on hostile humans leveled list to the entry level. This should help spawning more at least logically but in testing didn't seem to matter any. 
* Updated all patches for these changes too. 
* This should be the remainder of the patching needed from 1.0.14 & 1.0.15. So I can go back to adding new fun encounters (not necessarily hostile though).

## Version 1.0.19
* Using the gas vents distance restrictions settings to see if that can keep the camp spawn separated some. Camps now are spread a fair distance apart but the spacers wonder more. 
* Restored the starborn are known check lost in the revert to starfield's hostile humans stuff. Sorry @nexstephen :)  
* All Factions Patch now requires GRiNDTerra Industries - Corporate Terraformation 2.0, POI Faction Diversity and POI Faction Diversity - New Factions

## Version 1.0.18
* For compatibility and at the request of the GRiNDTerra author reverting back to Starfield Hostile Human List but adding my cheat to prevent competing factions from pawning together. 
* Added compatibility patches for GRiNDTerra Factions and Expanded the patch for Cora Coe Multiversal Book Hunter to add its faction. I can't get POI Faction Diversity and its Factions mod to play nice so can't make patches for them.
* Added new debug command to dump the spawn chance settings for open world encounters. 
* So if you change global variables and another mod overrides them to new settings the new are ignored until next NG+ ot manually set via console. So added to new commands below the first confirms your settings do or do not match my vanilla'ish settings and the second resets them to the overhaul settings.
* View current settings in Console run: CGF "VEOH_Debug.SpawnSettings"
* To reset the settings to the overhaul settings: CGF "VEOH_Debug.ResetSpawnSettings"

## Version 1.0.17
* Misspelling of Hollow as reported by LJTIGER69

## Version 1.0.16
* Added additional option to 7zip to take unknown file types. The strings/localization files should now be present.

## Version 1.0.15
* Localization Support
* Added random spacer camp which should appear anywhere a lair can. (Uses OE Uncommon Chance).
* Cell Load Request rules do not require a new game or NG+ Universe to go active. So enjoy the new camp right now. 

## Version 1.0.14
* The Storage and Solar Panel Human Clutter sites with beds/chairs now will randomly spawn a hostile human (Again only converts about half usually the larger ones)
* Fair warning 1 spawns a terrormorph for JaeDL
* Depending on the reception I may add more of these now that I figured out the secret sauce. 
* Reset some PCM variables that overhaul mods change to closer to Vanilla. This should drastically cut the number of trait nodes being spawned so the other new ones can spawn. 
* Please load Cave and Encounter overhaul late in load order mods so its override's win. 
* Increased out how far the human clutter stuff spawns so its not clustered so tightly. 
* You will need new planet/system for most of this version's changes but not a new game/universe.

## Version 1.0.13
* Finally trying to abuse the RE system as my human lair setup failed horribly. 
* Added a new Marauder RE quest where you will come upon 2 groups one protecting a chest and another guarding a a group of dead UC Vanguard Soldiers. 
* Added a 1st cav vs UC Random Encounter to go with some coming new POIs for JaeDL writing whims
* Added some missing persistance links so NPCs stay the correct thing on save instead of becoming level 1 of some race usually human
* Fixed some bugs with the NPC placements and PCM rules on for the Spacer Mech Encampment

## Version 1.0.12
* Removed MQ301 from available short circuit portal targets. This requires version 1.0.16 or newer of Venworks Core Utilities
* Only the player can trigger the portal now should be much safer the excluding things. 

## Version 1.0.11
* Compatibility with Starfield 1.9.51

## Version 1.0.10
* Refactor Mech Camp and Portal Mini Game to normal world space cells. PCM doesn't want to spawn custom lair/pack-in cells.
* Thank you SKK50 for all the help with the portal functionality and really all your mods :)
* Note: I'm still working on the Spacer Mech Camp world space version

## Version 1.0.9
* Added portal mini game to the open world encounters in natural and man made PCM rules.
* Fixed error preventing spacers mech camp from spawning
* Removed the form IDs from cave names. Renamed large caves to caverns also restored BGS's special caves names where they existed. 
* Terrormorph and heatleach caves have a special names
* NEED HELP: Please let me know where you encounter the portals or the mech encampments. 
* NOTE: PCM rule changes require a new universe to show up (NG+ or New Game)

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
