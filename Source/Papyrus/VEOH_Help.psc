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
  message += "To toggle debug mode and logging:\n\tCGF \"VEOH_Debug.ToggleDebugMode\"\n"
  message += "     Feature Flags Status Screen:\n\tCGF \"VEOH_Debug.FeatureFlags\"\n"

  Debug.MessageBox(message)
EndFunction