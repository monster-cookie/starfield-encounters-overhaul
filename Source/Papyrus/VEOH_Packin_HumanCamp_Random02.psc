ScriptName VEOH_Packin_HumanCamp_Random02 Extends ObjectReference

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
Bool Property PlayerActivateOnly=True Auto Const Mandatory
Bool Property DoOnce=True Auto Const Mandatory
Keyword Property MyParent Auto Const Mandatory
Keyword Property MyChild Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Bool DONE = False

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnOpen(ObjectReference akActionRef)
  Actor player = Game.GetPlayer()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "OnOpen", "OnOpen triggered - Someone or Something opened the chest, spawning the NPCs linked to the chest.", 0, Venpi_DebugEnabled.GetValueInt())

  If (!DONE)
    If (PlayerActivateOnly && akActionRef == player as ObjectReference)
      ;; Player Activated Spawn only
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "OnOpen", "Player opened the chest so spawning actors.", 0, Venpi_DebugEnabled.GetValueInt())
      SpawnActors()
    ElseIf (!PlayerActivateOnly)
      ;; Spawn not activated by player but that is allowed
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "OnOpen", "Player did not open chest but someone/something else did, but PlayerActivateOnly is false so that is ok and will spawn actors.", 0, Venpi_DebugEnabled.GetValueInt())
      SpawnActors()
    Else
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "OnOpen", "Player did not open chest but someone/something else did, but PlayerActivateOnly is true so not spawning actors.", 0, Venpi_DebugEnabled.GetValueInt())
      Return
    EndIf
    If (DoOnce)
      DONE = True
    EndIf
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function SpawnActors() 
  Actor[] actorsToEnable = self.GetActorsLinkedToMe(MyParent, None)
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "SpawnActors", "Will begin spawning the " + actorsToEnable.Length + " defined actors.", 0, Venpi_DebugEnabled.GetValueInt())

  Int I=0
  While (I < actorsToEnable.Length)
    Actor actorToEnable = actorsToEnable[i]
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_HumanCamp_Random02", "SpawnActors", "Record " + I + ":Attempting to activate actor " + actorToEnable + ".", 0, Venpi_DebugEnabled.GetValueInt())
    actorToEnable.EvaluatePackage(False)
    actorToEnable.Enable(False)
    Utility.Wait(0.001)
    I += 1
  EndWhile
EndFunction