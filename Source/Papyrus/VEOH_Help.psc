ScriptName VEOH_Help

;;
;; MAJOR NOTE: ALL FUNCTIONS MUST BE GLOBAL WITHOUT CREATION KIT
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

;; Call using: CGF "VEOH_Help.Show" 
Function Show() Global
  String message = "Cora is a completely stand alone companion based on the variant universe version of here combined with the hunter/emissary.\n" 
  message += "\n\nHow to use\n\n"
  message += "     Feature Flags status screen:\n\tCGF \"VEOH_Debug.FeatureFlags\"\n"
  message += "To toggle debug mode and logging:\n\tCGF \"VEOH_Debug.ToggleDebugMode\"\n"
  message += "\n\n"
  message += "    Get spawn conditions for the current planet:\n\tCGF \"VEOH_Debug.GetSpawnConditionsForCurrentLocation\"\n"
  message += "              System spawn chance status screen:\n\tCGF \"VEOH_Debug.SystemSpawnSettings\"\n"
  message += "\n\n"
  message += "      Camps distance restrictions status screen:\n\tCGF \"VEOH_Debug.CampsDistanceRestrictions\"\n"
  message += "\n\n***** Human Camps *****\n\n"
  message += "        Spacer Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampSpacerSpawnSettings\"\n"
  message += "     The First Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampTheFirstSpawnSettings\"\n"
  message += "Random Hostile Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampRandomHostileSpawnSettings\"\n"
  message += "      Friendly Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampRandomFriendlySpawnSettings\"\n"
  message += "\n\n***** Robot Camps *****\n\n"
  message += "Random Hostile Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.RobotCampRandomHostileSpawnSettings\"\n"
  message += "\n\n***** Special Encounters *****\n\n"
  message += "  Special Encounters spawn chance status screen:\n\tCGF \"VEOH_Debug.SpecialEncountersSpawnSettings\"\n"

  Debug.MessageBox(message)
EndFunction