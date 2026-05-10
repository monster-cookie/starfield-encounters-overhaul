ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_OnTriggerEnter Extends Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base
{This spawns NPCs on close of the attached container or door}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations


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
Event OnTriggerEnter(ObjectReference akActionRef)
  SpawnerType spawnerTypeTable = new SpawnerType
  String spawnerType=GetSpawnerType(spawnerTypeTable.OnTriggerEnter)

  If (!HasProcessed)
    HasProcessed = true
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="OnTriggerEnter triggered, spawning NPCs")
    HandleTrigger(spawnerTypeTable.OnTriggerEnter, self)
  EndIf
EndEvent