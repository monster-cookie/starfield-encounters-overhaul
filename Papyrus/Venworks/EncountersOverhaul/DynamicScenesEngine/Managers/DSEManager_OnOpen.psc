ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_OnOpen Extends Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base
{This spawns NPCs on close of the attached container or door}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Variables
;;;
bool HasProcessed = false


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

; Event received when this object is closed
Event OnOpen(ObjectReference akActionRef)
  SpawnerType spawnerTypeTable = new SpawnerType
  String spawnerType=GetSpawnerType(spawnerTypeTable.OnOpen)

  If (!HasProcessed)
    HasProcessed = true
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="OnOpen triggered, spawning NPCs")
    HandleTrigger(spawnerTypeTable.OnOpen, self)
  EndIf
EndEvent