ScriptName VEOH_Debug

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

;; Call using: CGF "VEOH_Debug.GetSpawnConditionsForCurrentLocation"
Function GetSpawnConditionsForCurrentLocation() Global
  Keyword LocTypeStarSystem = Game.GetFormFromFile(0x0000149F, "Starfield.esm") as Keyword
  Actor player = Game.GetPlayer()
  Planet currentPlanet = player.GetCurrentPlanet()

  Location currentLocation = player.GetCurrentLocation()
  Location currentLocationPlanet = currentPlanet.GetLocation()
  Location currentLocationSystem = currentLocationPlanet.GetParentLocations(LocTypeStarSystem)[0]

  ConditionForm PCM_HumanPresenceCondition = Game.GetFormFromFile(0x001C3FB6, "Starfield.esm") as ConditionForm ;; Used by all Human Camps
  GlobalVariable BEDebugGlobal = Game.GetFormFromFile(0x002A4310, "Starfield.esm") as GlobalVariable ;; Used by all camps to disable them 
  Keyword PCM_TerrormorphEncountersAllowed = Game.GetFormFromFile(0x001998F6, "Starfield.esm") as Keyword ;; Used by terrormorph camps to make sure they are allowed in the system or planet

  Keyword LocEncBountyHunters = Game.GetFormFromFile(0x00283583, "Starfield.esm") as Keyword
  Keyword LocEncCreatures = Game.GetFormFromFile(0x00283586, "Starfield.esm") as Keyword
  Keyword LocEncCrimsonFleet_Exclusive = Game.GetFormFromFile(0x00023305, "Starfield.esm") as Keyword
  Keyword LocEncEcliptic_Exclusive = Game.GetFormFromFile(0x00283581, "Starfield.esm") as Keyword
  Keyword LocEncFreestarMilitia = Game.GetFormFromFile(0x00000815, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocEncFreestarRangers = Game.GetFormFromFile(0x00000814, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocEncHouseVaruun_Exclusive = Game.GetFormFromFile(0x00283580, "Starfield.esm") as Keyword
  Keyword LocEncMarineSysDef = Game.GetFormFromFile(0x0012179B, "Starfield.esm") as Keyword
  Keyword LocEncRobots = Game.GetFormFromFile(0x000581DF, "Starfield.esm") as Keyword
  Keyword LocEncSpacers_Exclusive = Game.GetFormFromFile(0x00283585, "Starfield.esm") as Keyword
  Keyword LocEncStarborn = Game.GetFormFromFile(0x00294969, "Starfield.esm") as Keyword
  Keyword LocEncSyndicate = Game.GetFormFromFile(0x00283582, "Starfield.esm") as Keyword
  Keyword LocEncTerrormorph = Game.GetFormFromFile(0x00142D4D, "Starfield.esm") as Keyword
  Keyword LocEncTheFirst = Game.GetFormFromFile(0x0012179A, "Starfield.esm") as Keyword
  Keyword LocEncUCVanguard = Game.GetFormFromFile(0x00000802, "VenworksFactionOverhaul.esm") as Keyword

  Keyword LocSystemFactionContested = Game.GetFormFromFile(0x00000813, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocSystemFactionCrimsonFleet = Game.GetFormFromFile(0x001E79B8, "Starfield.esm") as Keyword
  Keyword LocSystemFactionEcliptic = Game.GetFormFromFile(0x00000803, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocSystemFactionFreestarCollective = Game.GetFormFromFile(0x001E79B9, "Starfield.esm") as Keyword
  Keyword LocSystemFactionHouseVaruun = Game.GetFormFromFile(0x001E79B6, "Starfield.esm") as Keyword
  Keyword LocSystemFactionStarborn = Game.GetFormFromFile(0x00000804, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocSystemFactionTheFirst = Game.GetFormFromFile(0x00000805, "VenworksFactionOverhaul.esm") as Keyword
  Keyword LocSystemFactionUnitedColonies = Game.GetFormFromFile(0x0005BD8B, "Starfield.esm") as Keyword

  Bool PCM_Allows_Humans = PCM_HumanPresenceCondition.IsTrue(Game.GetPlayer() as ObjectReference, None)
  Bool PCM_Allows_Robots = true
  Bool PCM_Allows_Terrormorphs = currentLocation.HasKeyword(PCM_TerrormorphEncountersAllowed) || currentLocationPlanet.HasKeyword(PCM_TerrormorphEncountersAllowed) || currentLocationSystem.HasKeyword(PCM_TerrormorphEncountersAllowed)
  Bool BGSDebugDisabled = BEDebugGlobal.GetValueInt() == 0

  Bool Location_Supports_BountyHunters = currentLocation.HasKeyword(LocEncBountyHunters) || currentLocationPlanet.HasKeyword(LocEncBountyHunters) || currentLocationSystem.HasKeyword(LocEncBountyHunters)
  Bool Location_Supports_Creatures = currentLocation.HasKeyword(LocEncCreatures) || currentLocationPlanet.HasKeyword(LocEncCreatures) || currentLocationSystem.HasKeyword(LocEncCreatures)
  Bool Location_Supports_CrimsonFleet = currentLocation.HasKeyword(LocEncCrimsonFleet_Exclusive) || currentLocationPlanet.HasKeyword(LocEncCrimsonFleet_Exclusive) || currentLocationSystem.HasKeyword(LocEncCrimsonFleet_Exclusive)
  Bool Location_Supports_Ecliptic = currentLocation.HasKeyword(LocEncEcliptic_Exclusive) || currentLocationPlanet.HasKeyword(LocEncEcliptic_Exclusive) || currentLocationSystem.HasKeyword(LocEncEcliptic_Exclusive)
  Bool Location_Supports_FreestarMilitia = currentLocation.HasKeyword(LocEncFreestarMilitia) || currentLocationPlanet.HasKeyword(LocEncFreestarMilitia) || currentLocationSystem.HasKeyword(LocEncFreestarMilitia)
  Bool Location_Supports_FreestarRangers = currentLocation.HasKeyword(LocEncFreestarRangers) || currentLocationPlanet.HasKeyword(LocEncFreestarRangers) || currentLocationSystem.HasKeyword(LocEncFreestarRangers)
  Bool Location_Supports_HouseVaruun = currentLocation.HasKeyword(LocEncHouseVaruun_Exclusive) || currentLocationPlanet.HasKeyword(LocEncHouseVaruun_Exclusive) || currentLocationSystem.HasKeyword(LocEncHouseVaruun_Exclusive)
  Bool Location_Supports_Robots = currentLocation.HasKeyword(LocEncRobots) || currentLocationPlanet.HasKeyword(LocEncRobots) || currentLocationSystem.HasKeyword(LocEncRobots)
  Bool Location_Supports_Spacers = currentLocation.HasKeyword(LocEncSpacers_Exclusive) || currentLocationPlanet.HasKeyword(LocEncSpacers_Exclusive) || currentLocationSystem.HasKeyword(LocEncSpacers_Exclusive)
  Bool Location_Supports_Starborn = currentLocation.HasKeyword(LocEncStarborn) || currentLocationPlanet.HasKeyword(LocEncStarborn) || currentLocationSystem.HasKeyword(LocEncStarborn)
  Bool Location_Supports_Syndicate = currentLocation.HasKeyword(LocEncSyndicate) || currentLocationPlanet.HasKeyword(LocEncSyndicate) || currentLocationSystem.HasKeyword(LocEncSyndicate)
  Bool Location_Supports_Terrormorphs = currentLocation.HasKeyword(LocEncTerrormorph) || currentLocationPlanet.HasKeyword(LocEncTerrormorph) || currentLocationSystem.HasKeyword(LocEncTerrormorph)
  Bool Location_Supports_TheFirst = currentLocation.HasKeyword(LocEncTheFirst) || currentLocationPlanet.HasKeyword(LocEncTheFirst) || currentLocationSystem.HasKeyword(LocEncTheFirst)
  Bool Location_Supports_UCMarineSysDef = currentLocation.HasKeyword(LocEncMarineSysDef) || currentLocationPlanet.HasKeyword(LocEncMarineSysDef) || currentLocationSystem.HasKeyword(LocEncMarineSysDef)
  Bool Location_Supports_UCVanguard = currentLocation.HasKeyword(LocEncUCVanguard) || currentLocationPlanet.HasKeyword(LocEncUCVanguard) || currentLocationSystem.HasKeyword(LocEncUCVanguard)

  Bool System_Ownership_Contested = currentLocationSystem.HasKeyword(LocSystemFactionContested)
  Bool System_Ownership_CrimsonFleet = currentLocationSystem.HasKeyword(LocSystemFactionCrimsonFleet)
  Bool System_Ownership_Ecliptic = currentLocationSystem.HasKeyword(LocSystemFactionEcliptic)
  Bool System_Ownership_FreestarCollective = currentLocationSystem.HasKeyword(LocSystemFactionFreestarCollective)
  Bool System_Ownership_HouseVaruun = currentLocationSystem.HasKeyword(LocSystemFactionHouseVaruun)
  Bool System_Ownership_Starborn = currentLocationSystem.HasKeyword(LocSystemFactionStarborn)
  Bool System_Ownership_TheFirst = currentLocationSystem.HasKeyword(LocSystemFactionTheFirst)
  Bool System_Ownership_UnitedColonies = currentLocationSystem.HasKeyword(LocSystemFactionUnitedColonies)

  String message = "Use Spawn Conditions (0 = No, 1 = Yes):\n"
  message += "\n\n"
  message += "                    BGS BEDebugGlobal is 0: " + BGSDebugDisabled as Int + "\n"
  message += "       System or Planet has Human presence: " + PCM_Allows_Humans as Int + "\n"
  message += "       System or Planet has Robot presence: " + PCM_Allows_Robots as Int + "\n"
  message += "System or Planet has Terrormorphs presence: " + PCM_Allows_Terrormorphs as Int + "\n"
  message += "\n\n"
  message += "  Location supports Bounty Hunters: " + Location_Supports_BountyHunters as Int + "\n"
  message += "       Location supports Creatures: " + Location_Supports_Creatures as Int + "\n"
  message += "   Location supports Crimson Fleet: " + Location_Supports_CrimsonFleet as Int + "\n"
  message += "        Location supports Ecliptic: " + Location_Supports_Ecliptic as Int + "\n"
  message += "Location supports Freestar Militia: " + Location_Supports_FreestarMilitia as Int + "\n"
  message += "Location supports Freestar Rangers: " + Location_Supports_FreestarRangers as Int + "\n"
  message += "   Location supports House Va'ruun: " + Location_Supports_HouseVaruun as Int + "\n"
  message += "          Location supports Robots: " + Location_Supports_Robots as Int + "\n"
  message += "         Location supports Spacers: " + Location_Supports_Spacers as Int + "\n"
  message += "        Location supports Starborn: " + Location_Supports_Starborn as Int + "\n"
  message += "       Location supports Syndicate: " + Location_Supports_Syndicate as Int + "\n"
  message += "    Location supports Terrormorphs: " + Location_Supports_Terrormorphs as Int + "\n"
  message += "       Location supports The First: " + Location_Supports_TheFirst as Int + "\n"
  message += "Location supports UC Marine SysDef: " + Location_Supports_UCMarineSysDef as Int + "\n"
  message += "     Location supports UC Vanguard: " + Location_Supports_UCVanguard as Int + "\n"
  message += "\n\n"
  message += "                              System is Contested: " + System_Ownership_Contested as Int + "\n"
  message += "      System has Crimson Fleet presence/ownership: " + System_Ownership_CrimsonFleet as Int + "\n"
  message += "           System has Ecliptic presence/ownership: " + System_Ownership_Ecliptic as Int + "\n"
  message += "System has Freestar Collective presence/ownership: " + System_Ownership_FreestarCollective as Int + "\n"
  message += "      System has House Va'ruun presence/ownership: " + System_Ownership_HouseVaruun as Int + "\n"
  message += "           System has Starborn presence/ownership: " + System_Ownership_Starborn as Int + "\n"
  message += "          System has The First presence/ownership: " + System_Ownership_TheFirst as Int + "\n"
  message += "    System has United Colonies presence/ownership: " + System_Ownership_UnitedColonies as Int + "\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.FeatureFlags" 
Function FeatureFlags() Global
  GlobalVariable Venpi_DebugEnabled = Game.GetFormFromFile(0x71000800, "VenpiCore.esm") as GlobalVariable

  String message = "Current Feature Flag Settings (1-On, 0=Off)\n\n"
  message += "     Debug Mode = " + Venpi_DebugEnabled.GetValueInt() + "\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ToggleDebugMode" 
Function ToggleDebugMode() Global
  GlobalVariable Venpi_DebugEnabled = Game.GetFormFromFile(0x71000800, "VenpiCore.esm") as GlobalVariable
  If (Venpi_DebugEnabled.GetValueInt() == 0)
    Venpi_DebugEnabled.SetValueInt(1)
  Else
    Venpi_DebugEnabled.SetValueInt(0)
  EndIf
EndFunction

;; Call using: CGF "VEOH_Debug.SystemSpawnSettings" 
Function SystemSpawnSettings() Global
  GlobalVariable OE_ChanceUniqueGlobal = Game.GetFormFromFile(0x00110677, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceRareGlobal = Game.GetFormFromFile(0x00110678, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceUncommonGlobal = Game.GetFormFromFile(0x00110676, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_BlockCreation_TraitKnownChance = Game.GetFormFromFile(0x002CCF3A, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_CellLoad_ManMadeChance = Game.GetFormFromFile(0x00228F4A, "Starfield.esm") as GlobalVariable

  String message = "Current PCM Spawn Settings:\n\n"
  message += "   Unique Encounters Chance (Should be 40%) = " + OE_ChanceUniqueGlobal.GetValueInt() + "%\n"
  message += "     Rare Encounters Chance (Should be 40%) = " + OE_ChanceRareGlobal.GetValueInt() + "%\n"
  message += " Uncommon Encounters Chance (Should be 65%) = " + OE_ChanceUncommonGlobal.GetValueInt() + "%\n"
  message += "         Known Trait Chance (Should be 35%) = " + PCM_BlockCreation_TraitKnownChance.GetValueInt() + "%\n"
  message += "    Man Made Clutter Chance (Should be 50%) = " + PCM_CellLoad_ManMadeChance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetSystemSpawnSettings" 
Function ResetSystemSpawnSettings() Global
  GlobalVariable OE_ChanceUniqueGlobal = Game.GetFormFromFile(0x00110677, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceRareGlobal = Game.GetFormFromFile(0x00110678, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceUncommonGlobal = Game.GetFormFromFile(0x00110676, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_BlockCreation_TraitKnownChance = Game.GetFormFromFile(0x002CCF3A, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_CellLoad_ManMadeChance = Game.GetFormFromFile(0x00228F4A, "Starfield.esm") as GlobalVariable

  OE_ChanceUniqueGlobal.SetValueInt(40)
  OE_ChanceRareGlobal.SetValueInt(40)
  OE_ChanceUncommonGlobal.SetValueInt(65)
  PCM_BlockCreation_TraitKnownChance.SetValueInt(35)
  PCM_CellLoad_ManMadeChance.SetValueInt(50)

  Utility.Wait(0.25)

  String message = "Current PCM Spawn Settings:\n\n"
  message += "   Unique Encounters Chance (Should be 40%) = " + OE_ChanceUniqueGlobal.GetValueInt() + "%\n"
  message += "     Rare Encounters Chance (Should be 40%) = " + OE_ChanceRareGlobal.GetValueInt() + "%\n"
  message += " Uncommon Encounters Chance (Should be 65%) = " + OE_ChanceUncommonGlobal.GetValueInt() + "%\n"
  message += "         Known Trait Chance (Should be 35%) = " + PCM_BlockCreation_TraitKnownChance.GetValueInt() + "%\n"
  message += "    Man Made Clutter Chance (Should be 50%) = " + PCM_CellLoad_ManMadeChance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction


;; ****************************************************************************************
;; *** Camps - Distance Limits
;; ***

;; Call using: CGF "VEOH_Debug.CampsDistanceRestrictions" 
Function CampsDistanceRestrictions() Global
  GlobalVariable VEOH_Camps_DistanceRestriction_Far = Game.GetFormFromFile(0x000016E8, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_Camps_DistanceRestriction_Near = Game.GetFormFromFile(0x000016F0, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Current PCM Distance Restrictions:\n\n"
  message += "Camps Min Distance Near (Should be 300) = " + VEOH_Camps_DistanceRestriction_Near.GetValueInt() + "\n"
  message += " Camps Min Distance Far (Should be 900) = " + VEOH_Camps_DistanceRestriction_Far.GetValueInt() + "\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetCampsDistanceRestrictions" 
Function ResetCampsDistanceRestrictions() Global
  SetCampsDistanceNear(300)
  SetCampsDistanceFar(900)
  Utility.Wait(0.10)
  CampsDistanceRestrictions()
EndFunction

;; Call using: CGF "VEOH_Debug.SetCampsDistanceFar" <distance:float>
Function SetCampsDistanceFar(Float distance) Global
  GlobalVariable VEOH_Camps_DistanceRestriction_Far = Game.GetFormFromFile(0x000016E8, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_Camps_DistanceRestriction_Far.SetValue(distance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetCampsDistanceNear" <distance:float>
Function SetCampsDistanceNear(Float distance) Global
  GlobalVariable VEOH_Camps_DistanceRestriction_Near = Game.GetFormFromFile(0x000016F0, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_Camps_DistanceRestriction_Near.SetValue(distance)
EndFunction


;; ****************************************************************************************
;; *** Human Camps - Spacer Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.HumanCampSpacerSpawnSettings" 
Function HumanCampSpacerSpawnSettings() Global
  GlobalVariable VEOH_SpacerCamps_Spacer01_Chance = Game.GetFormFromFile(0x0000171C, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_SpacerCamps_Spacer02_Chance = Game.GetFormFromFile(0x0000171D, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Human Camps - Spacer Spawn Settings:\n\n"
  message += "   Chance for Spacer Camp 01 - Solar Farm (Should be 15%) = " + VEOH_SpacerCamps_Spacer01_Chance.GetValueInt() + "%\n"
  message += "Chance for Spacer Camp 02 - Support Chest (Should be 25%) = " + VEOH_SpacerCamps_Spacer02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetHumanCampSpacerSpawnSettings" 
Function ResetHumanCampSpacerSpawnSettings() Global
  SetSpawnChanceHumanCampSpacer01(15)
  SetSpawnChanceHumanCampSpacer02(25)
  Utility.Wait(0.10)
  HumanCampSpacerSpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampSpacer01" <chance:integer>
Function SetSpawnChanceHumanCampSpacer01(Int chance) Global
  GlobalVariable VEOH_SpacerCamps_Spacer01_Chance = Game.GetFormFromFile(0x0000171C, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_SpacerCamps_Spacer01_Chance.SetValueInt(chance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampSpacer02" <chance:integer>
Function SetSpawnChanceHumanCampSpacer02(Int chance) Global
  GlobalVariable VEOH_SpacerCamps_Spacer02_Chance = Game.GetFormFromFile(0x0000171D, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_SpacerCamps_Spacer02_Chance.SetValueInt(chance)
EndFunction



;; ****************************************************************************************
;; *** Human Camps - Random Friendly Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.HumanCampRandomFriendlySpawnSettings" 
Function HumanCampRandomFriendlySpawnSettings() Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies01_Chance = Game.GetFormFromFile(0x0000171E, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_FriendliesCamps_Friendlies02_Chance = Game.GetFormFromFile(0x0000172B, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Human Camps - Random Friendly Spawn Settings:\n\n"
  message += "Chance for Friendly Camp 01 - Babysitting Robot (Should be 30%) = " + VEOH_FriendliesCamps_Friendlies01_Chance.GetValueInt() + "%\n"
  message += "Chance for Friendly Camp 02 - Treasure Map (Should be 15%) = " + VEOH_FriendliesCamps_Friendlies02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetHumanCampRandomFriendlySpawnSettings" 
Function ResetHumanCampRandomFriendlySpawnSettings() Global
  SetSpawnChanceHumanCampRandomFriendly01(30)
  SetSpawnChanceHumanCampRandomFriendly02(15)
  Utility.Wait(0.10)
  HumanCampRandomFriendlySpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampRandomFriendly01" <chance:integer>
Function SetSpawnChanceHumanCampRandomFriendly01(Int chance) Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies01_Chance = Game.GetFormFromFile(0x0000171E, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_FriendliesCamps_Friendlies01_Chance.SetValueInt(chance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampRandomFriendly02" <chance:integer>
Function SetSpawnChanceHumanCampRandomFriendly02(Int chance) Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies02_Chance = Game.GetFormFromFile(0x0000172B, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_FriendliesCamps_Friendlies02_Chance.SetValueInt(chance)
EndFunction



;; ****************************************************************************************
;; *** Human Camps - The First Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.HumanCampTheFirstSpawnSettings" 
Function HumanCampTheFirstSpawnSettings() Global
  GlobalVariable VEOH_HumanCamps_TheFirst01_Chance = Game.GetFormFromFile(0x0000173E, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_HumanCamps_TheFirst02_Chance = Game.GetFormFromFile(0x00001785, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Human Camps - The First Spawn Settings:\n\n"
  message += "Chance for The First Camp 01 - Salvage Operation (Should be 20%) = " + VEOH_HumanCamps_TheFirst01_Chance.GetValueInt() + "%\n"
  message += "Chance for The First Camp 02 - Heavy Patrol (Should be 20%) = " + VEOH_HumanCamps_TheFirst02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetHumanCampTheFirstSpawnSettings" 
Function ResetHumanCampTheFirstSpawnSettings() Global
  SetSpawnChanceHumanCampTheFirst01(20)
  SetSpawnChanceHumanCampTheFirst02(20)
  Utility.Wait(0.10)
  HumanCampTheFirstSpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampTheFirst01" <chance:integer>
Function SetSpawnChanceHumanCampTheFirst01(Int chance) Global
  GlobalVariable VEOH_HumanCamps_TheFirst01_Chance = Game.GetFormFromFile(0x0000173E, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_HumanCamps_TheFirst01_Chance.SetValueInt(chance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampTheFirst02" <chance:integer>
Function SetSpawnChanceHumanCampTheFirst02(Int chance) Global
  GlobalVariable VEOH_HumanCamps_TheFirst02_Chance = Game.GetFormFromFile(0x00001785, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_HumanCamps_TheFirst02_Chance.SetValueInt(chance)
EndFunction



;; ****************************************************************************************
;; *** Human Camps - Random Hostiles Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.HumanCampRandomHostileSpawnSettings" 
Function HumanCampRandomHostileSpawnSettings() Global
  GlobalVariable VEOH_HumanCamps_Random01_Chance = Game.GetFormFromFile(0x0000175B, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_HumanCamps_Random02_Chance = Game.GetFormFromFile(0x000017A5, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Human Camps - Random Hostiles Spawn Settings:\n\n"
  message += "Chance for Random Camp 01 - Terrormorph Skirmish (Should be 20%) = " + VEOH_HumanCamps_Random01_Chance.GetValueInt() + "%\n"
  message += "       Chance for Random Camp 02 - Research Camp (Should be 20%) = " + VEOH_HumanCamps_Random02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetHumanCampRandomHostileSpawnSettings" 
Function ResetHumanCampRandomHostileSpawnSettings() Global
  SetSpawnChanceHumanCampRandom01Hostile(20)
  SetSpawnChanceHumanCampRandom02Hostile(20)
  Utility.Wait(0.10)
  HumanCampRandomHostileSpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampRandom01Hostile" <chance:integer>
Function SetSpawnChanceHumanCampRandom01Hostile(Int chance) Global
  GlobalVariable VEOH_HumanCamps_Random01_Chance = Game.GetFormFromFile(0x0000175B, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_HumanCamps_Random01_Chance.SetValueInt(chance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceHumanCampRandom02Hostile" <chance:integer>
Function SetSpawnChanceHumanCampRandom02Hostile(Int chance) Global
  GlobalVariable VEOH_HumanCamps_Random02_Chance = Game.GetFormFromFile(0x000017A5, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_HumanCamps_Random02_Chance.SetValueInt(chance)
EndFunction



;; ****************************************************************************************
;; *** Robot Camps - Random Hostiles Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.RobotCampRandomHostileSpawnSettings" 
Function RobotCampRandomHostileSpawnSettings() Global
  GlobalVariable VEOH_RobotCamps_Random01_Chance = Game.GetFormFromFile(0x0000177A, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Robot Camps - Random Hostiles Spawn Settings:\n\n"
  message += "Chance for Random Camp 01 - Fake Mech Patrol (Should be 15%) = " + VEOH_RobotCamps_Random01_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetRobotCampRandomHostileSpawnSettings" 
Function ResetRobotCampRandomHostileSpawnSettings() Global
  SetSpawnChanceRobotCampRandom01Hostile(15)
  Utility.Wait(0.10)
  RobotCampRandomHostileSpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceRobotCampRandom01Hostile" <chance:integer>
Function SetSpawnChanceRobotCampRandom01Hostile(Int chance) Global
  GlobalVariable VEOH_RobotCamps_Random01_Chance = Game.GetFormFromFile(0x0000177A, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_RobotCamps_Random01_Chance.SetValueInt(chance)
EndFunction



;; ****************************************************************************************
;; *** Special Encounters Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.SpecialEncountersSpawnSettings" 
Function SpecialEncountersSpawnSettings() Global
  GlobalVariable VEOH_Special_Corpse01_Chance = Game.GetFormFromFile(0x000017B4, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_Special_Corpse02_Chance = Game.GetFormFromFile(0x000017CE, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Special Encounter Spawn Settings:\n\n"
  message += "Chance for Corpse Encounter 01 (Should be 20%) = " + VEOH_Special_Corpse01_Chance.GetValueInt() + "%\n"
  message += "Chance for Corpse Encounter 02 (Should be 10%) = " + VEOH_Special_Corpse02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetSpecialEncountersSpawnSettings" 
Function ResetSpecialEncountersSpawnSettings() Global
  SetSpawnChanceSpecialEncountersCorpse01(20)
  SetSpawnChanceSpecialEncountersCorpse02(20)
  Utility.Wait(0.10)
  SpecialEncountersSpawnSettings()
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceSpecialEncountersCorpse01" <chance:integer>
Function SetSpawnChanceSpecialEncountersCorpse01(Int chance) Global
  GlobalVariable VEOH_Special_Corpse01_Chance = Game.GetFormFromFile(0x000017B4, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_Special_Corpse01_Chance.SetValueInt(chance)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceSpecialEncountersCorpse02" <chance:integer>
Function SetSpawnChanceSpecialEncountersCorpse02(Int chance) Global
  GlobalVariable VEOH_Special_Corpse02_Chance = Game.GetFormFromFile(0x000017CE, "VenpiCaveOverhaul.esm") as GlobalVariable
  VEOH_Special_Corpse02_Chance.SetValueInt(chance)
EndFunction
