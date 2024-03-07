ScriptName VEOH_OnTrigger_EnableObject Extends ObjectReference

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
ObjectReference[] Property ObjectsToEnable Auto Const Mandatory
Bool Property PlayerActivateOnly=True Auto Const Mandatory
Bool Property DoOnce=True Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Bool DONE = False

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnTriggerEnter(ObjectReference akActionRef)
  Actor player = Game.GetPlayer() ; #DEBUG_LINE_NO:29
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OnTrigger_EnableObject", "OnTriggerEnter", "OnTriggerEnter triggered - Player in range, enable the " + ObjectsToEnable.Length + "referenced objects.", 0, Venpi_DebugEnabled.GetValueInt()) ; #DEBUG_LINE_NO:30

  If (!DONE) ; #DEBUG_LINE_NO:32
    If (PlayerActivateOnly && akActionRef == player as ObjectReference) ; #DEBUG_LINE_NO:33
      EnableObjects() ; #DEBUG_LINE_NO:34
    ElseIf (!PlayerActivateOnly) ; #DEBUG_LINE_NO:35
      EnableObjects() ; #DEBUG_LINE_NO:36
    EndIf
    If (DoOnce) ; #DEBUG_LINE_NO:38
      DONE = True ; #DEBUG_LINE_NO:39
    EndIf
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function EnableObjects()
  Int I=0 ; #DEBUG_LINE_NO:49
  While (I < ObjectsToEnable.Length) ; #DEBUG_LINE_NO:50
    ObjectReference ref = ObjectsToEnable[I] ; #DEBUG_LINE_NO:51
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OnTrigger_EnableObject", "EnableObjects", "Enabling array object #" + i + " (" + ref + ").", 0, Venpi_DebugEnabled.GetValueInt()) ; #DEBUG_LINE_NO:52
    If (ref != None) ; #DEBUG_LINE_NO:53
      ref.Enable(False) ; #DEBUG_LINE_NO:54
    EndIf
    I += 1 ; #DEBUG_LINE_NO:56
  EndWhile
EndFunction