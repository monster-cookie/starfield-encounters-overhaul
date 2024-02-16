ScriptName VEOH_Debug

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

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
  If (Venpi_DebugEnabled == None)
    Debug.MessageBox("Failed to find Venpi_DebugEnabled global variable in VenpiCore.esm. Please contact Venpi for help.")
    Return
  Else
    If (Venpi_DebugEnabled.GetValueInt() == 0)
      Venpi_DebugEnabled.SetValueInt(1)
    Else
      Venpi_DebugEnabled.SetValueInt(0)
    EndIf
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
;; *** Human Camps - Distance Limits
;; ***

;; Call using: CGF "VEOH_Debug.HumanCampDistanceRestrictions" 
Function HumanCampDistanceRestrictions() Global
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Far = Game.GetFormFromFile(0x000016E8, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Near = Game.GetFormFromFile(0x000016F0, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Current PCM Distance Restrictions:\n\n"
  message += "Human Camps Min Distance Near (Should be 300) = " + VEOH_HumanCamps_DistanceRestriction_Near.GetValueInt() + "\n"
  message += " Human Camps Min Distance Far (Should be 900) = " + VEOH_HumanCamps_DistanceRestriction_Far.GetValueInt() + "\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetHumanCampDistanceRestrictions" 
Function ResetHumanCampDistanceRestrictions() Global
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Far = Game.GetFormFromFile(0x000016E8, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Near = Game.GetFormFromFile(0x000016F0, "VenpiCaveOverhaul.esm") as GlobalVariable

  VEOH_HumanCamps_DistanceRestriction_Near.SetValue(300)
  VEOH_HumanCamps_DistanceRestriction_Far.SetValue(900)

  Utility.Wait(0.30)

  String message = "Current PCM Distance Restrictions:\n\n"
  message += "Human Camps Min Distance Near (Should be 300) = " + VEOH_HumanCamps_DistanceRestriction_Near.GetValueInt() + "\n"
  message += " Human Camps Min Distance Far (Should be 900) = " + VEOH_HumanCamps_DistanceRestriction_Far.GetValueInt() + "\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.SetHumanCampsDistanceFar" <distance:float>
Function SetHumanCampsDistanceFar(Float distance) Global
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Far = Game.GetFormFromFile(0x000016E8, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_HumanCamps_DistanceRestriction_Far == None)
    Debug.MessageBox("Failed to find VEOH_HumanCamps_DistanceRestriction_Far global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_HumanCamps_DistanceRestriction_Far.SetValue(distance)
  EndIf
EndFunction

;; Call using: CGF "VEOH_Debug.SetHumanCampsDistanceNear" <distance:float>
Function SetHumanCampsDistanceNear(Float distance) Global
  GlobalVariable VEOH_HumanCamps_DistanceRestriction_Near = Game.GetFormFromFile(0x000016F0, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_HumanCamps_DistanceRestriction_Near == None)
    Debug.MessageBox("Failed to find VEOH_HumanCamps_DistanceRestriction_Near global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_HumanCamps_DistanceRestriction_Near.SetValue(distance)
  EndIf
EndFunction


;; ****************************************************************************************
;; *** Human Camps - Spacer Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.SpacerCampSpawnSettings" 
Function SpacerCampSpawnSettings() Global
  GlobalVariable VEOH_SpacerCamps_Spacer01_Chance = Game.GetFormFromFile(0x0000171C, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_SpacerCamps_Spacer02_Chance = Game.GetFormFromFile(0x0000171D, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "   Chance for Spacer Camp 01 - Solar Farm (Should be 15%) = " + VEOH_SpacerCamps_Spacer01_Chance.GetValueInt() + "%\n"
  message += "Chance for Spacer Camp 02 - Support Chest (Should be 25%) = " + VEOH_SpacerCamps_Spacer02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetSpacerCampSpawnSettings" 
Function ResetSpacerCampSpawnSettings() Global
  GlobalVariable VEOH_SpacerCamps_Spacer01_Chance = Game.GetFormFromFile(0x0000171C, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_SpacerCamps_Spacer01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_SpacerCamps_Spacer01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_SpacerCamps_Spacer01_Chance.SetValueInt(15)
  EndIf

  GlobalVariable VEOH_SpacerCamps_Spacer02_Chance = Game.GetFormFromFile(0x0000171D, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_SpacerCamps_Spacer02_Chance == None)
    Debug.MessageBox("Failed to find VEOH_SpacerCamps_Spacer02_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_SpacerCamps_Spacer02_Chance.SetValueInt(25)
  EndIf


  Utility.Wait(0.30)

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "   Chance for Spacer Camp 01 - Solar Farm (Should be 15%) = " + VEOH_SpacerCamps_Spacer01_Chance.GetValueInt() + "%\n"
  message += "Chance for Spacer Camp 01 - Support Chest (Should be 25%) = " + VEOH_SpacerCamps_Spacer02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceSpacer01Camp" <chance:integer>
Function SetSpawnChanceSpacer01Camp(Int chance) Global
  GlobalVariable VEOH_SpacerCamps_Spacer01_Chance = Game.GetFormFromFile(0x0000171C, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_SpacerCamps_Spacer01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_SpacerCamps_Spacer01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_SpacerCamps_Spacer01_Chance.SetValueInt(chance)
  EndIf
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceSpacer02Camp" <chance:integer>
Function SetSpawnChanceSpacer02Camp(Int chance) Global
  GlobalVariable VEOH_SpacerCamps_Spacer02_Chance = Game.GetFormFromFile(0x0000171D, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_SpacerCamps_Spacer02_Chance == None)
    Debug.MessageBox("Failed to find VEOH_SpacerCamps_Spacer02_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_SpacerCamps_Spacer02_Chance.SetValueInt(chance)
  EndIf
EndFunction


;; ****************************************************************************************
;; *** Human Camps - Friendly Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.FriendlyCampSpawnSettings" 
Function FriendlyCampSpawnSettings() Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies01_Chance = Game.GetFormFromFile(0x0000171E, "VenpiCaveOverhaul.esm") as GlobalVariable
  GlobalVariable VEOH_FriendliesCamps_Friendlies02_Chance = Game.GetFormFromFile(0x0000172B, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "Chance for Friendly Camp 01 - Babysitting Robot (Should be 30%) = " + VEOH_FriendliesCamps_Friendlies01_Chance.GetValueInt() + "%\n"
  message += "Chance for Friendly Camp 02 - Treasure Map (Should be 15%) = " + VEOH_FriendliesCamps_Friendlies02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetFriendlyCampSpawnSettings" 
Function ResetFriendlyCampSpawnSettings() Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies01_Chance = Game.GetFormFromFile(0x0000171E, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_FriendliesCamps_Friendlies01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_FriendliesCamps_Friendlies01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_FriendliesCamps_Friendlies01_Chance.SetValueInt(30)
  EndIf

  GlobalVariable VEOH_FriendliesCamps_Friendlies02_Chance = Game.GetFormFromFile(0x0000172B, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_FriendliesCamps_Friendlies02_Chance == None)
    Debug.MessageBox("Failed to find VEOH_FriendliesCamps_Friendlies02_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_FriendliesCamps_Friendlies02_Chance.SetValueInt(15)
  EndIf

  Utility.Wait(0.30)

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "Chance for Friendly Camp 01 - Babysitting Robot (Should be 30%) = " + VEOH_FriendliesCamps_Friendlies01_Chance.GetValueInt() + "%\n"
  message += "Chance for Friendly Camp 02 - Treasure Map (Should be 15%) = " + VEOH_FriendliesCamps_Friendlies02_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceFriendly01Camp" <chance:integer>
Function SetSpawnChanceFriendly01Camp(Int chance) Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies01_Chance = Game.GetFormFromFile(0x0000171E, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_FriendliesCamps_Friendlies01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_FriendliesCamps_Friendlies01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_FriendliesCamps_Friendlies01_Chance.SetValueInt(chance)
  EndIf
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceFriendly02Camp" <chance:integer>
Function SetSpawnChanceFriendly02Camp(Int chance) Global
  GlobalVariable VEOH_FriendliesCamps_Friendlies02_Chance = Game.GetFormFromFile(0x0000172B, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_FriendliesCamps_Friendlies02_Chance == None)
    Debug.MessageBox("Failed to find VEOH_FriendliesCamps_Friendlies02_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_FriendliesCamps_Friendlies02_Chance.SetValueInt(chance)
  EndIf
EndFunction


;; ****************************************************************************************
;; *** Human Camps - The First Spawn Settings
;; ***

;; Call using: CGF "VEOH_Debug.TheFirstCampSpawnSettings" 
Function TheFirstCampSpawnSettings() Global
  GlobalVariable VEOH_HumanCamps_TheFirst01_Chance = Game.GetFormFromFile(0x0000173E, "VenpiCaveOverhaul.esm") as GlobalVariable

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "Chance for The First Camp 01 - Salvage Operation (Should be 20%) = " + VEOH_HumanCamps_TheFirst01_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.ResetTheFirstCampSpawnSettings" 
Function ResetTheFirstCampSpawnSettings() Global
  GlobalVariable VEOH_HumanCamps_TheFirst01_Chance = Game.GetFormFromFile(0x0000173E, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_HumanCamps_TheFirst01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_HumanCamps_TheFirst01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_HumanCamps_TheFirst01_Chance.SetValueInt(20)
  EndIf

  Utility.Wait(0.30)

  String message = "Current Spacer Camp Spawn Settings:\n\n"
  message += "Chance for The First Camp 01 - Salvage Operation (Should be 20%) = " + VEOH_HumanCamps_TheFirst01_Chance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction

;; Call using: CGF "VEOH_Debug.SetSpawnChanceTheFirst01Camp" <chance:integer>
Function SetSpawnChanceTheFirst01Camp(Int chance) Global
  GlobalVariable VEOH_HumanCamps_TheFirst01_Chance = Game.GetFormFromFile(0x0000173E, "VenpiCaveOverhaul.esm") as GlobalVariable
  If (VEOH_HumanCamps_TheFirst01_Chance == None)
    Debug.MessageBox("Failed to find VEOH_HumanCamps_TheFirst01_Chance global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
  Else
    VEOH_HumanCamps_TheFirst01_Chance.SetValueInt(chance)
  EndIf
EndFunction
