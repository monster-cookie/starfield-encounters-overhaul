ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base Extends Venworks:EncountersOverhaul:Base:BaseObjectReference
{DO NOT USE, this is the base class of all other managers}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Utilities:Random
Import Venworks:Shared:Utilities:Array

Import Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group SceneMangerConfiguration
  Int Property Mode=0 Auto Const Mandatory
  {The mode the spawner should run in, set to 0 normal single spawn, set to 1 for spawn in waves, set to 2 for time delayed waves.}

  Int Property Waves=1 Auto Const Mandatory
  {The number of waves to spawn, set to 0 it infinitely spawn.}

  Int Property TimerDelay=0 Auto Const Mandatory
  {The time in seconds to delay between wave spawns, set to 0 to disable.}

  ConditionForm Property GlobalChanceToSpawn=None Auto Const Mandatory
  {The condition form to test if this manager should do anything.}

  GlobalVariable Property PlayerCompleted=None Auto Const Mandatory
  {If set this GlobalVariable will be updated on spawn completion}

  SpawnGroupDefinition[] Property SpawnGroupDefinitions Auto Const Mandatory
  {Array for spawn group definitions, there must be at least 1}
EndGroup

Group AutoFillLinkedRefKeywords
  Keyword Property DSELinkedRef_Marker_Map Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Center Auto Const Mandatory

  Keyword Property DSELinkedRef_Marker_SceneA_Minions Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneA_Bosses Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneA_Chests Auto Const Mandatory

  Keyword Property DSELinkedRef_Marker_SceneB_Minions Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneB_Bosses Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneB_Chests Auto Const Mandatory

  Keyword Property DSELinkedRef_Marker_SceneC_Minions Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneC_Bosses Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneC_Chests Auto Const Mandatory
EndGroup

Group Autofill
  Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_SpawnSystem Property SQ_DSE_SpawnSystem Auto Const Mandatory
  {Handler Script for the DSE Spawner System}

  Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration Property SQ_DSE_FactionConfiguration Auto Const Mandatory
  {Handler Script for the DSE Faction System}
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Variables
;;;
Int RemainingWaves=0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
; Timer event, sent when a timer on this script expires. The ID of the expired timer is passed in as the parameter. This event is sent only once for each timer that expires.
Event OnTimer(int aiTimerID)
  HandleGroups(aiTimerID)
EndEvent

;; Trigger events will be created from the child scripts of this script


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function HandleTrigger(Int triggerType, ObjectReference triggerTarget)
  String spawnerType=GetSpawnerType(triggerType)

  If (GlobalChanceToSpawn.IsTrue())
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Encounter will spawn due to random chance or in debug mode.")
  Else
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Encounter was blocked from spawning due to random chance.")
    Return
  EndIf

  If (PlayerCompleted != None)
    PlayerCompleted.SetValueInt(1)
  EndIf

  ;; Handle NPC spawning
  If (Waves > 1 && TimerDelay == 0)
    ;; Handle spawning waves every 30 seconds
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Wave spawner processing " + Waves + " waves of NPCs every 30 seconds.")
    RemainingWaves = Waves - 1
    HandleGroups(triggerType)
    StartTimer(afInterval=30, aiTimerID=triggerType)
  ElseIf (waves > 1 && TimerDelay > 0)
    ;; Handle spawning waves every TimerDelay seconds
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Wave/Timer spawner processing " + Waves + " waves of NPCs every " + TimerDelay + " seconds.")
    RemainingWaves = Waves - 1
    HandleGroups(triggerType)
    StartTimer(afInterval=TimerDelay, aiTimerID=triggerType)
  ElseIf (waves == 0 && TimerDelay == 0)
    ;; Handle spawning infinite waves every 30 seconds
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Wave/Timer spawner processing infinite waves of NPCs every 30 seconds.")
    RemainingWaves = -1
    HandleGroups(triggerType)
    StartTimer(afInterval=30, aiTimerID=triggerType)
  ElseIf (waves == 0 && TimerDelay > 0)
    ;; Handle spawning infinite waves every TimerDelay seconds
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Wave/Timer spawner processing infinite waves of NPCs every " + TimerDelay + " seconds.")
    RemainingWaves = -1
    HandleGroups(triggerType)
    StartTimer(afInterval=TimerDelay, aiTimerID=triggerType)
  Else
    ;; Handle normal spawn processing just 1 wave of NPCs
    LogModuleInformational(functionName="HandleTrigger[" + spawnerType + "]", logMessage="Normal spawn processing just 1 wave of NPCs.")
    RemainingWaves = 0
    HandleGroups(triggerType)
  EndIf
EndFunction


Function HandleGroups(int triggerType)
  String spawnerType=GetSpawnerType(triggerType)
  int groupNumber = 0
  While (groupNumber < SpawnGroupDefinitions.Length)
    SpawnGroupDefinition groupDefinition = SpawnGroupDefinitions[groupNumber]
    FactionDefinition factionDefinition=SQ_DSE_FactionConfiguration.GetFactionDefinition(requestedFactionType=groupDefinition.GroupFaction)

    LogModuleInformational(functionName="HandleGroups[" + spawnerType + "]", logMessage="Spawning group " + groupNumber + " using SpawnGroupDefinitions in configuration.")

    ;; Handle NPCs
    ObjectReference[] bossSpawners = self.GetRefsLinkedToMe(groupDefinition.LinkRefKeywordForBossSpawnPoints)
    ObjectReference[] minionSpawners = self.GetRefsLinkedToMe(groupDefinition.LinkRefKeywordForMinionSpawnPoints)
    SQ_DSE_SpawnSystem.SpawnGroup(groupDefinition=groupDefinition, spawnBossMarkers=bossSpawners, minNumberOfBossesToSpawn=groupDefinition.BossesMinToSpawn, maxNumberOfBossesToSpawn=groupDefinition.BossesMaxToSpawn, spawnMinionMarkers=minionSpawners, minNumberOfMinionsToSpawn=groupDefinition.MinionsMinToSpawn, maxNumberOfMinionsToSpawn=groupDefinition.MinionsMaxToSpawn)
    groupNumber += 1

    ;; Handle chest spawning
    ObjectReference[] chestSpawners = self.GetRefsLinkedToMe(groupDefinition.LinkRefKeywordForChestSpawnPoints)

    ;; TODO handle boss chest spawning

  EndWhile

EndFunction

String Function GetSpawnerType(int triggerType)
  SpawnerType spawnerTypeTable = new SpawnerType
  If (triggerType == spawnerTypeTable.CellLoad)
    Return "CellLoad"
  ElseIf (triggerType == spawnerTypeTable.OnClose)
    Return "OnClose"
  ElseIf (triggerType == spawnerTypeTable.OnOpen)
    Return "OnOpen"
  ElseIf (triggerType == spawnerTypeTable.OnRead)
    Return "OnRead"
  ElseIf (triggerType == spawnerTypeTable.OnTriggerEnter)
    Return "OnTriggerEnter"
  ElseIf (triggerType == spawnerTypeTable.OnTriggerLeave)
    Return "OnTriggerLeave"
  Else
    return "UNKNOWN"
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:Managers:DSEManager_Base", functionName=functionName, logMessage=logMessage)
EndFunction
