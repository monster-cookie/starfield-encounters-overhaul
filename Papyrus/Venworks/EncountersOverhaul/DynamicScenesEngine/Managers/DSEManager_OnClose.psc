ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_OnClose Extends Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base
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
Event OnClose(ObjectReference akActionRef)
  SpawnerType spawnerTypeTable = new SpawnerType
  String spawnerType=GetSpawnerType(spawnerTypeTable.OnClose)

  If (!HasProcessed)
    HasProcessed = true
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="OnClose triggered, spawning NPCs")
    HandleTrigger(spawnerTypeTable.OnClose, self)
  EndIf
EndEvent