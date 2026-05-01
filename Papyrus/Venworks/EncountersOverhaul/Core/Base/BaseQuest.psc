ScriptName Venworks:EncountersOverhaul:Core:Base:BaseQuest Extends Quest
{ 
  Shared base class for encounters overhaul that all Quest classes derive from.  
  
  This injects some shared functions, constants, etc 
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:Core:Enumerations
Import Venworks:EncountersOverhaul:Core:Logging

Import Venworks:EncountersOverhaul:GlobalConfig


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Helper (Spawning)
;;;
Function HelperSpawnObject(ObjectReference marker, FormList possibleObjects)
  Form objectToSpawn = possibleObjects.GetAt(Utility.RandomInt(0, possibleObjects.GetSize()-1))
  ObjectReference spawnedObjectRef = marker.PlaceAtMe(objectToSpawn)
  spawnedObjectRef.SetPosition(marker.GetPositionX(), marker.GetPositionY(), marker.GetPositionZ())
  spawnedObjectRef.SetAngle(0, 0, marker.GetAngleZ())
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Utility
;;;
var Function Ternary(Bool conditional, Var result1, Var result2) global
  If (conditional)
    Return result1
  EndIf

  Return result2
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging (System)
;;;
Function LogSystemInformational(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogSystem(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Info)
EndFunction

Function LogSystemWarning(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogSystem(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Warning)
EndFunction

Function LogSystemError(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogSystem(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Error)
EndFunction

Function LogSystemCritical(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogSystem(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Critical)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging (User)
;;;
Function LogUserInformational(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogUser(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Info)
EndFunction

Function LogUserWarning(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogUser(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Warning)
EndFunction

Function LogUserError(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogUser(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Error)
EndFunction

Function LogUserCritical(String moduleName, String functionName, String logMessage)
  LogSeverity severityTable = new LogSeverity;
  LogUser(creationName=GetCreationName(), moduleName=moduleName, functionName=functionName, logMessage=logMessage, severity=severityTable.Critical)
EndFunction
