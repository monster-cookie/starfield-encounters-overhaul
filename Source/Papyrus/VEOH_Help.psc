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
  message += "Get spawn conditions for the current planet:\n\tCGF \"VEOH_Debug.GetSpawnConditionsForCurrentLocation\"\n"
  message += "          System spawn chance status screen:\n\tCGF \"VEOH_Debug.SystemSpawnSettings\"\n"
  message += "  Reset system spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetSystemSpawnSettings\"\n"
  message += "\n\n"
  message += "       Camps distance restrictions status screen:\n\tCGF \"VEOH_Debug.CampsDistanceRestrictions\"\n"
  message += "Reset Camps distance restrictions to my settings:\n\tCGF \"VEOH_Debug.ResetCampsDistanceRestrictions\"\n"
  message += "             Set Camps near distance restriction:\n\tCGF \"VEOH_Debug.SetCampsDistanceNear\" <distance:float>\n"
  message += "              Set Camps far distance restriction:\n\tCGF \"VEOH_Debug.SetCampsDistanceFar\" <distance:float>\n"
  message += "\n\n***** Human Camps *****\n\n"
  message += "                 Spacer Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampSpacerSpawnSettings\"\n"
  message += "          Reset Spacer Camp spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetHumanCampSpacerSpawnSettings\"\n"
  message += "   Set new spawn setting for Spacer Camp 01 - Solar Farm:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampSpacer01\" <chance:integer>\n"
  message += "Set new spawn setting for Spacer Camp 02 - Support Chest:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampSpacer02\" <chance:integer>\n"
  message += "\n\n"
  message += "                     The First Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampTheFirstSpawnSettings\"\n"
  message += "              Reset The First Camp spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetHumanCampTheFirstSpawnSettings\"\n"
  message += "Set new spawn setting for The First Camp 01 - Salvage Operation:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampTheFirst01\" <chance:integer>\n"
  message += "     Set new spawn setting for The First Camp 02 - Heavy Patrol:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampTheFirst02\" <chance:integer>\n"
  message += "\n\n"
  message += "                        Random Hostile Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampRandomHostileSpawnSettings\"\n"
  message += "                Reset Random Hostile Camps spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetHumanCampRandomHostileSpawnSettings\"\n"
  message += "Set new spawn setting for Random Hostile Camp 01 - Terrormorph Skirmish:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampRandom01Hostile\" <chance:integer>\n"
  message += "       Set new spawn setting for Random Hostile Camp 02 - Research Camp:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampRandom02Hostile\" <chance:integer>\n"
  message += "\n\n"
  message += "                     Friendly Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.HumanCampRandomFriendlySpawnSettings\"\n"
  message += "             Reset Friendly Camps spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetHumanCampRandomFriendlySpawnSettings\"\n"
  message += "Set new spawn setting for Friendly Camp 01 - Babysitting Robot:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampRandomFriendly01\" <chance:integer>\n"
  message += "     Set new spawn setting for Friendly Camp 02 - Treasure Map:\n\tCGF \"VEOH_Debug.SetSpawnChanceHumanCampRandomFriendly02\" <chance:integer>\n"
  message += "\n\n***** Robot Camps *****\n\n"
  message += "                    Random Hostile Camps spawn chance status screen:\n\tCGF \"VEOH_Debug.RobotCampRandomHostileSpawnSettings\"\n"
  message += "            Reset Random Hostile Camps spawn chances to my settings:\n\tCGF \"VEOH_Debug.ResetRobotCampRandomHostileSpawnSettings\"\n"
  message += "Set new spawn setting for Random Hostile Camp 01 - Patrol:\n\tCGF \"VEOH_Debug.SetSpawnChanceRobotCampRandom01Hostile\" <chance:integer>\n"

  Debug.MessageBox(message)
EndFunction