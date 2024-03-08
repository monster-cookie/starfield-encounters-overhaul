ScriptName VEOH_Packin_Special_Corpse01 Extends ObjectReference

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
Explosion Property TransitionExplosion Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Bool DONE = False
ObjectReference spawnedXenogrubRef = None
ObjectReference spawnedSirenRef = None

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnActivate(ObjectReference akActionRef)
  Actor player = Game.GetPlayer()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "OnOpen", "OnOpen triggered - Someone or Something looted the corpse.", 0, Venpi_DebugEnabled.GetValueInt())

  If (!DONE)
    If (PlayerActivateOnly && akActionRef == player as ObjectReference)
      ;; Player Activated Spawn only
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "OnOpen", "Player looted the chest so triggering phase 1.", 0, Venpi_DebugEnabled.GetValueInt())
      StartPhase1()
    ElseIf (!PlayerActivateOnly)
      ;; Spawn not activated by player but that is allowed
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "OnOpen", "Player did not loot the corpse but someone/something else did, but PlayerActivateOnly is false so will trigger phase 1.", 0, Venpi_DebugEnabled.GetValueInt())
      StartPhase1()
    Else
      VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "OnOpen", "Player did not loot that corpse but someone/something else did, but PlayerActivateOnly is true so not doing anything.", 0, Venpi_DebugEnabled.GetValueInt())
      Return
    EndIf
    If (DoOnce)
      DONE = True
    EndIf
  EndIf
EndEvent

Event OnTimer(Int aiTimerID)
  If (aiTimerID == 2)
    StartPhase2()
  EndIf
EndEvent

Event Actor.OnDeath(Actor akSource, ObjectReference akKiller)
  If (akSource == spawnedXenogrubRef)
    ;; If still running we need to cancel the phase 2 timer
    self.CancelTimer(2)
    Self.UnregisterForRemoteEvent(spawnedXenogrubRef, "OnDeath")
  EndIf
EndEvent



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function StartPhase1() 
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "StartPhase1", "Will begin phase 1, deleting the corpse, triggering explosion, and spawning xenogrub.", 0, Venpi_DebugEnabled.GetValueInt())
  spawnedXenogrubRef = Self.GetLinkedRef(MyChild)

  ;; Trigger explosion for smoke and mirrors activities
  Self.PlaceAtMe(TransitionExplosion as Form, 1, False, False, True, None, None, True)

  ;; Move xenogrub to corpse, enable Xenogrub, and disable the the corpse
  spawnedXenogrubRef.MoveTo(Self, 0, 0, 0, False, False)
  spawnedXenogrubRef.Enable(False)
  Self.RegisterForRemoteEvent(spawnedXenogrubRef, "OnDeath")
  Self.DisableNoWait(False)
  ;;Self.SetPosition(0, 0,-1000) ;; Disable stops the timer too. 

  ;; Start timer for when to convert Xenogrub to siren
  Float waitPeriod = Utility.RandomFloat(5.0, 15.0)
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "StartPhase1", "Phase 1: Setting phase 2 to trigger in " + waitPeriod + ".", 0, Venpi_DebugEnabled.GetValueInt())
  Self.StartTimer(waitPeriod, 2)
EndFunction

Function StartPhase2() 
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "StartPhase2", "Will begin phase 2, deleting the xenogrub, triggering explosion, and spawning siren.", 0, Venpi_DebugEnabled.GetValueInt())
  If (spawnedXenogrubRef == None)
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_Packin_Special_Corpse01", "StartPhase2", "Phase 2 [ERROR]: reference to spawned Xenogrub is None but timer still triggered.", 2, Venpi_DebugEnabled.GetValueInt())
    Return
  EndIf
  spawnedSirenRef = spawnedXenogrubRef.GetLinkedRef(MyChild)

  ;; Trigger explosion for smoke and mirrors activities
  spawnedXenogrubRef.PlaceAtMe(TransitionExplosion as Form, 1, False, False, True, None, None, True)

  ;; Move Siren to Xenogrub, enable Siren, and disable Xenogrub
  spawnedSirenRef.MoveTo(spawnedXenogrubRef, 0, 0, 0, False, False)
  spawnedSirenRef.Enable(False)
  spawnedXenogrubRef.DisableNoWait(False)  
EndFunction