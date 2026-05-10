ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_OnCellLoad Extends Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base
{This spawns NPCs on load of the attached cell, packin, or worldspace}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

; Event received when every object in this object's parent cell is loaded (TODO: Find restrictions)
Event OnCellLoad()
  SpawnerType spawnerTypeTable = new SpawnerType
  String spawnerType=GetSpawnerType(spawnerTypeTable.CellLoad)

  LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="OnCellLoad triggered, spawning NPCs.")
  HandleTrigger(spawnerTypeTable.CellLoad, self)
EndEvent