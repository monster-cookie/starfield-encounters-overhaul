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
  message += "        System spawn chance status screen:\n\tCGF \"VEOH_Debug.SystemSpawnSettings\"\n"
  message += "Reset system spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetSystemSpawnSettings\"\n"
  message += "\n\n"
  message += "                 Spacer Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.SpacerCampSpawnSettings\"\n"
  message += "          Reset spacer camp spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetSpacerCampSpawnSettings\"\n"
  message += "   Set new spawn setting for Spacer Camp 01 - Solar Farm:\n\tCGF \"VEOH_Debug.SetSpawnChanceSpacer01Camp\" <chance:integer>\n"
  message += "Set new spawn setting for Spacer Camp 02 - Support Chest:\n\tCGF \"VEOH_Debug.SetSpawnChanceSpacer02Camp\" <chance:integer>\n"
  message += "\n\n"
  message += "                     Friendly Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.FriendlyCampSpawnSettings\"\n"
  message += "             Reset Friendly Camps spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetFriendlyCampSpawnSettings\"\n"
  message += "Set new spawn setting for Friendly Camp 01 - Babysitting Robot:\n\tCGF \"VEOH_Debug.SetSpawnChanceFriendly01Camp\" <chance:integer>\n"
  message += "\n\n"
  message += "       Human Camps distance restrictions status screen:\n\tCGF \"VEOH_Debug.HumanCampDistanceRestrictions\"\n"
  message += "Reset Human Camps distance restrictions to my settings:\n\tCGF \"VEOH_Debug.ResetHumanCampDistanceRestrictions\"\n"
  message += "             Set Human Camps near distance restriction:\n\tCGF \"VEOH_Debug.SetHumanCampsDistanceNear\" <distance:float>\n"
  message += "              Set Human Camps far distance restriction:\n\tCGF \"VEOH_Debug.SetHumanCampsDistanceFar\" <distance:float>\n"

  Debug.MessageBox(message)
EndFunction