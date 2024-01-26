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

;; Call using: CGF "VEOH_Debug.FastTravelToCell" <Integer_Cell_Index>
Function FastTravelToCell(Int cellIndex) Global
  FormList VEOH_CellMarkersForTeleport = Game.GetFormFromFile(0x7D00100C, "VenpiCaveOverhaul.esm") as FormList
  If (VEOH_CellMarkersForTeleport == None)
    Debug.MessageBox("Failed to find VEOH_CellMarkersForTeleport global variable in VenpiCaveOverhaul.esm. Please contact Venpi for help.")
    Return
  Else
    Form targetForm = VEOH_CellMarkersForTeleport.GetAt(cellIndex)
    Game.FastTravel(targetForm as ObjectReference)
  EndIf
EndFunction

;; Call using: CGF "VEOH_Debug.FastTravelToCellKnownLocations"
Function FastTravelToCellKnownLocations() Global
  String message = "When combined with the Integer_Cell_Index value you can teleport to the matching cell using:\n\tCGF \"VEOH_Debug.FastTravelToDebugCell\" <Integer_Cell_Index>\n"
  message += "\n\n"
  message += "0 = Portal Mini-game Pack-in Cell\n"
  message += "1 = Spacer Mech Camp Pack-in Cell\n"
  message += "2 = Spooky Cave Interior Cell\n"
  message += "3 = Spooky Cave World Space\n"
  message += "4 = Stock Covered Crater\n"
  message += "5 = Active Portal (Crater)\n"
  message += "\n\n"
  message += "NOTE: For cell's with NPCs, they will not spawn unless linked to a PCM world space I have not found a way around this. You will have to use a temp object in the meantime for placement.\n"

  Debug.MessageBox(message)
EndFunction
