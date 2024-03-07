ScriptName VEOH_OnTrigger_SpawnActor Extends ObjectReference

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
ActorBase Property ActorToSpawn Auto Const Mandatory
ObjectReference Property WhereToSpawnActors Auto Const Mandatory
Int Property DifficultyOfSpawnedActors=4 Auto Const Mandatory
{0=???, 1=easy, 2=normal, 3=hard, 4=VeryHard}
Bool Property PlayerActivateOnly=True Auto Const Mandatory
Bool Property DoOnce=True Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;
Bool done = False

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnTriggerEnter(ObjectReference akActionRef)
  Actor player = Game.GetPlayer()
  Location currentLocation = player.GetCurrentLocation()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OnTrigger_SpawnActor", "OnTriggerEnter", "OnTriggerEnter triggered - Player in range, spawn the referenced NPC (" + ActorToSpawn + ").", 0, Venpi_DebugEnabled.GetValueInt())

  If (!done)
    If (PlayerActivateOnly)
      If (akActionRef == player as ObjectReference)
        Actor npc = WhereToSpawnActors.PlaceActorAtMe(akActorToPlace=ActorToSpawn, aiLevelMod=DifficultyOfSpawnedActors, akEncLoc=currentLocation, abForcePersist=True, abInitiallyDisabled=False, abDeleteWhenAble=True, akOffsetValues=None, abSnapOffsetToNavmesh=True)
      EndIf
    Else
      Actor npc = WhereToSpawnActors.PlaceActorAtMe(akActorToPlace=ActorToSpawn, aiLevelMod=DifficultyOfSpawnedActors, akEncLoc=currentLocation, abForcePersist=True, abInitiallyDisabled=False, abDeleteWhenAble=True, akOffsetValues=None, abSnapOffsetToNavmesh=True)
    EndIf
    If (DoOnce)
      done = True
    EndIf
  EndIf
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
