ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration Extends Venworks:EncountersOverhaul:Base:BaseQuest
{
  This is a handler script for managing the factions DSE can support both hostile and friendly
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Utilities:Array

Import Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group Configuration
  FactionDefinition[] Property FactionDefinitions Auto Const Mandatory
  {Array for faction definitions, there must be at least 1}
EndGroup

Group FactionTypes
  FormList Property DSE_KnownFactionTypes Auto Const Mandatory

  Keyword Property FactionTypeRandom Auto Const Mandatory
  Keyword Property FactionTypeCrimsonFleet Auto Const Mandatory
  Keyword Property FactionTypeEcliptic Auto Const Mandatory
  Keyword Property FactionTypeHouseVaruun Auto Const Mandatory
  Keyword Property FactionTypeSiren Auto Const Mandatory
  Keyword Property FactionTypeSpacer Auto Const Mandatory
  Keyword Property FactionTypeStarborn Auto Const Mandatory
  Keyword Property FactionTypeSyndicate Auto Const Mandatory
  Keyword Property FactionTypeTerrormorph Auto Const Mandatory
  Keyword Property FactionTypeTheFirst Auto Const Mandatory
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Accessing Faction Definitions
;;;

FactionDefinition Function GetFactionDefinition(Keyword requestedFactionType)
  FactionDefinition foundDefinition=None

  int index = 0
  While (index < FactionDefinitions.Length)
    FactionDefinition definition = FactionDefinitions[index]
    if (definition.FactionType == requestedFactionType)
      return definition
    EndIf
    index += 1
  EndWhile
  Return None
EndFunction

FormList Function GetCorrectMinionList(Keyword requestedFactionType)
  FactionDefinition definition=GetFactionDefinition(requestedFactionType=requestedFactionType)
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectMinionList", logMessage="Failed to find faction definition for " + requestedFactionType + ".")
    Return None
  EndIf

  Return definition.Minions
EndFunction

FormList Function GetCorrectBossList(Keyword requestedFactionType)
  FactionDefinition definition=GetFactionDefinition(requestedFactionType=requestedFactionType)
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectBossList", logMessage="Failed to find faction definition for " + requestedFactionType + ".")
    Return None
  EndIf

  Return definition.Bosses
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration", functionName=functionName, logMessage=logMessage)
EndFunction
