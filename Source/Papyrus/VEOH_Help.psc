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
  message += "               Feature Flags Status Screen:\n\tCGF \"VEOH_Debug.FeatureFlags\"\n"
  message += "                Spawn Chance Status Screen:\n\tCGF \"VEOH_Debug.SpawnSettings\"\n"
  message += "       Distance Restrictions Status Screen:\n\tCGF \"VEOH_Debug.DistanceRestrictions\"\n"
  message += "          To toggle debug mode and logging:\n\tCGF \"VEOH_Debug.ToggleDebugMode\"\n"
  message += "        Reset spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetSpawnSettings\"\n"
  message += "Reset distance restrictions to my settings:\n\tCGF \"VEOH_Debug.ResetDistanceRestrictions\"\n"
  message += " Set human camps near distance restriction:\n\tCGF \"VEOH_Debug.SetHumanCampsDistanceNear\" <distance:float>\n"
  message += "  Set human camps far distance restriction:\n\tCGF \"VEOH_Debug.SetHumanCampsDistanceFar\" <distance:float>\n"

  Debug.MessageBox(message)
EndFunction