ScriptName Venworks:Shared:Injectors:Inject_LeveledListItem extends Quest


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
LeveledItem Property InjectIntoLeveledItemList Auto Const Mandatory
Form Property ToInjectLeveledItemEntryItem Auto Const Mandatory
Int Property ToInjectLeveledItemEntryLevel Auto Const Mandatory
Int Property ToInjectLeveledItemEntryCount Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  LogSeverity severityTable = new LogSeverity
  LogUser(creationName="VenworksShared", moduleName="Inject_LeveledListItem", functionName="OnQuestInit", logMessage="Injecting " + ToInjectLeveledItemEntryCount + " " + ToInjectLeveledItemEntryItem + " items at level " + ToInjectLeveledItemEntryLevel + " into " + InjectIntoLeveledItemList +  ".", severity=severityTable.Info)
  InjectIntoLeveledItemList.AddForm(ToInjectLeveledItemEntryItem, ToInjectLeveledItemEntryLevel, ToInjectLeveledItemEntryCount)
EndEvent
