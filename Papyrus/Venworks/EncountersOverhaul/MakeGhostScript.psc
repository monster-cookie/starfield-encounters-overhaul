ScriptName Venworks:EncountersOverhaul:MakeGhostScript Extends Actor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:GlobalConfig

Import Venworks:Core:Enumerations
Import Venworks:Core:Logging

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venworks_DebugEnabled Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
LogSeverity Property LogSeverityTable Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnLoad()
  LogSeverityTable = new LogSeverity
  If (Self.IsDead() == False)
    LogUser(creationName=GetCreationName(), moduleName="MakeGhostScript", functionName="OnLoad", logMessage=self + "I'm loaded and not a corpse so becoming a ghost.", severity=LogSeverityTable.Info)
    BecomeGhost(self)
  EndIf
EndEvent

Event OnDeath(ObjectReference akKiller)
  LogUser(creationName=GetCreationName(), moduleName="MakeGhostScript", functionName="OnDeath", logMessage=self + "I died seeing if I can resurrect.", severity=LogSeverityTable.Info)
  If (Game.GetDieRollSuccess(25, 1, 100, -1, -1))
    LogUser(creationName=GetCreationName(), moduleName="MakeGhostScript", functionName="OnDeath", logMessage=self + "I won the dice roll so I get to respawn.", severity=LogSeverityTable.Info)
    Actor newActor = self.PlaceDuplicateActorAtMe(self, False, False, True, None, None, False)
    BecomeGhost(newActor)
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function BecomeGhost(Actor target)
  target.SetAlpha(0.60, False)
  target.SetEssential(False)
  target.SetGhost(False)
  target.AllowPCDialogue(False)
  target.SetValue(Game.GetAggressionAV(), 1.0)
EndFunction
