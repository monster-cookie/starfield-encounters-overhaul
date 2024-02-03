ScriptName VEOH_OE_1stCav01_FragmentsScript Extends Quest Const hidden

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="VenworksEncountersOverhaul" Auto Const

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Fragments
;;;
Function Fragment_Stage_0000_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_1stCav01_FragmentsScript", "Fragment_Stage_0000_Item_00", "Stage 0 triggered - Player in range, setup quest and move to stage 50.", 0, Venpi_DebugEnabled.GetValueInt())
  Self.SetStage(50)
EndFunction

Function Fragment_Stage_9999_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_1stCav01_FragmentsScript", "Fragment_Stage_9999_Item_00", "Stage 9999 triggered - Random Encounter Complete.", 0, Venpi_DebugEnabled.GetValueInt())
  Self.CompleteAllObjectives()
EndFunction
