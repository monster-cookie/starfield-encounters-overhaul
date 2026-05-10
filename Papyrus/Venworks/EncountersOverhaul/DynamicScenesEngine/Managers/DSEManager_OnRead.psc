ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_OnRead Extends Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base
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
Event OnRead()
  SpawnerType spawnerTypeTable = new SpawnerType
  String spawnerType=GetSpawnerType(spawnerTypeTable.OnRead)

  If (!HasProcessed)
    HasProcessed = true
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="OnRead triggered, spawning NPCs")
    HandleTrigger(spawnerTypeTable.OnRead, self)
  EndIf
EndEvent