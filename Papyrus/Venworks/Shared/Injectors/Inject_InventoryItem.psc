ScriptName Venworks:Shared:Injectors:Inject_InventoryItem extends Quest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Logging


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Actor Property PlayerRef Auto Const Mandatory
Form Property ItemToInject Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  LogSeverity severityTable = new LogSeverity
  LogUser(creationName="VenworksShared", moduleName="Inject_InventoryItem", functionName="OnQuestInit", logMessage="OnQuestInit triggered.", severity=severityTable.Info)
  If PlayerRef.GetItemCount(ItemToInject) <= 0
    PlayerRef.AddItem(ItemToInject, 1, false)
    LogUser(creationName="VenworksShared", moduleName="Inject_InventoryItem", functionName="OnQuestInit", logMessage="Item added to player inventory.", severity=severityTable.Info)
  EndIf
EndEvent
