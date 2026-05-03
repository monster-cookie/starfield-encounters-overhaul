ScriptName Venworks:Shared:Injectors:Inject_SpellToPlayer extends Quest


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
Spell Property SpellToEnable Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnQuestInit()
  LogSeverity severityTable = new LogSeverity
  LogUser(creationName="VenworksShared", moduleName="Inject_SpellToPlayer", functionName="OnQuestInit", logMessage="Spell " + SpellToEnable + " added to player.", severity=severityTable.Info)
  PlayerRef.AddSpell(SpellToEnable, false)
EndEvent
