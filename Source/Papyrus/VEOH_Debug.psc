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

;; Call using: CGF "VEOH_Debug.SpawnSettings" 
Function SpawnSettings() Global
  GlobalVariable OE_ChanceUniqueGlobal = Game.GetFormFromFile(0x00110677, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceRareGlobal = Game.GetFormFromFile(0x00110678, "Starfield.esm") as GlobalVariable
  GlobalVariable OE_ChanceUncommonGlobal = Game.GetFormFromFile(0x00110676, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_BlockCreation_TraitKnownChance = Game.GetFormFromFile(0x002CCF3A, "Starfield.esm") as GlobalVariable
  GlobalVariable PCM_CellLoad_ManMadeChance = Game.GetFormFromFile(0x00228F4A, "Starfield.esm") as GlobalVariable

  String message = "Current PCM Spawn Settings:\n\n"
  message += "  Unique Encounters Chance (Should be 40%) = " + OE_ChanceUniqueGlobal.GetValueInt() + "%\n"
  message += "    Rare Encounters Chance (Should be 40%) = " + OE_ChanceRareGlobal.GetValueInt() + "%\n"
  message += "Uncommon Encounters Chance (Should be 65%) = " + OE_ChanceUncommonGlobal.GetValueInt() + "%\n"
  message += "        Known Trait Chance (Should be 35%) = " + PCM_BlockCreation_TraitKnownChance.GetValueInt() + "%\n"
  message += "   Man Made Clutter Chance (Should be 50%) = " + PCM_CellLoad_ManMadeChance.GetValueInt() + "%\n"

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


;; Call using: CGF "VEOH_Debug.ResetSpawnSettings" 
Function ResetSpawnSettings() Global
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
  message += "  Unique Encounters Chance (Should be 40%) = " + OE_ChanceUniqueGlobal.GetValueInt() + "%\n"
  message += "    Rare Encounters Chance (Should be 40%) = " + OE_ChanceRareGlobal.GetValueInt() + "%\n"
  message += "Uncommon Encounters Chance (Should be 65%) = " + OE_ChanceUncommonGlobal.GetValueInt() + "%\n"
  message += "        Known Trait Chance (Should be 35%) = " + PCM_BlockCreation_TraitKnownChance.GetValueInt() + "%\n"
  message += "   Man Made Clutter Chance (Should be 50%) = " + PCM_CellLoad_ManMadeChance.GetValueInt() + "%\n"

  Debug.MessageBox(message)
  Debug.Trace(message, 2)
EndFunction
