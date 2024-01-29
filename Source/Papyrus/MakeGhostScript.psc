ScriptName MakeGhostScript Extends Actor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="VenworksEncountersOverhaul" Auto Const Mandatory

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
Event OnLoad()
  If (Self.IsDead() == False)
    VPI_Debug.DebugMessage(Venpi_ModName, "MakeGhostScript", "OnLoad", self + "I'm loaded and not a corpse so becoming a ghost.", 0, Venpi_DebugEnabled.GetValueInt())
    BecomeGhost(self)
  EndIf
EndEvent

Event OnDeath(ObjectReference akKiller)
  VPI_Debug.DebugMessage(Venpi_ModName, "MakeGhostScript", "OnDeath", self + "I died seeing if I can resurrect.", 0, Venpi_DebugEnabled.GetValueInt())
  If (Game.GetDieRollSuccess(25, 1, 100, -1, -1))
    VPI_Debug.DebugMessage(Venpi_ModName, "MakeGhostScript", "OnDeath", self + "I won the dice roll so I get to respawn.", 0, Venpi_DebugEnabled.GetValueInt())
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
