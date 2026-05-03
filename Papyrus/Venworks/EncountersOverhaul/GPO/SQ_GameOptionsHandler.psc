ScriptName Venworks:EncountersOverhaul:GPO:SQ_GameOptionsHandler extends PEO:SQ_PEO_QuestScript
{ Shared script for configuring the game options }


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Logging

Import Venworks:EncountersOverhaul:GlobalConfig


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Debug/Trace Handlers
;;;
bool Function Trace(ScriptObject CallingObject, string asTextToPrint, int aiSeverity = 0, string MainLogName = "PEO",  string SubLogName = "SQ_PEO", bool bShowNormalTrace = false, bool bShowWarning = false, bool bPrefixTraceWithLogNames = true) DebugOnly
  MainLogName = GetCreationName()
  SubLogName = "EncountersOverhaul:GPO:SQ_GameOptionsHandler"
  LogUser(creationName=MainLogName, moduleName=SubLogName, functionName=CallingObject, logMessage=asTextToPrint, severity=aiSeverity)
  return debug.TraceLog(CallingObject, asTextToPrint, MainLogName, SubLogName,  aiSeverity, bShowNormalTrace, bShowWarning, bPrefixTraceWithLogNames)
endFunction

bool Function Warning(ScriptObject CallingObject, string asTextToPrint, int aiSeverity = 2, string MainLogName = "PEO",  string SubLogName = "SQ_PEO", bool bShowNormalTrace = false, bool bShowWarning = true, bool bPrefixTraceWithLogNames = true) BetaOnly
  MainLogName = GetCreationName()
  SubLogName = "EncountersOverhaul:GPO:SQ_GameOptionsHandler"
  LogUser(creationName=MainLogName, moduleName=SubLogName, functionName=CallingObject, logMessage=asTextToPrint, severity=aiSeverity)
  return debug.TraceLog(CallingObject, asTextToPrint, MainLogName, SubLogName,  aiSeverity, bShowNormalTrace, bShowWarning, bPrefixTraceWithLogNames)
EndFunction