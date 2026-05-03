ScriptName Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Shared_ManMadeClutter extends Venworks:EncountersOverhaul:Core:Base:BaseQuest
{Handler script for the Radiant Engine Quest - VEOH_Shared_ManMadeClutter}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:Core:Enumerations
Import Venworks:EncountersOverhaul:Core:Logging


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group QuestSetup
  Int Property StageEncounterStarted=0 Auto Const
  
  Int Property StageEncounterSceneSetup=25 Auto Const
  Int Property StageEncounterSceneSetupComplete=30 Auto Const
  Int Property StageEncounterActorSetup=50 Auto Const
  Int Property StageEncounterActorSetupComplete=55 Auto Const

  Int Property StageEncounterInProgressPlayerInRange=100 Auto Const
  Int Property StageEncounterInProgressPlayerKilledGrunts=110 Auto Const
  Int Property StageEncounterInProgressPlayerKilledBoss=120 Auto Const
  Int Property StageEncounterInProgressPlayerLootedBossChest=130 Auto Const

  Int Property StageEncounterComplete=900 Auto Const
  Int Property StageEncounterShutdown=999 Auto Const

  Int Property ObjectiveKillGrunts=10 Auto Const
  Int Property ObjectiveKillLeader=20 Auto Const
  Int Property ObjectiveLootChest=30 Auto Const
EndGroup

Group EventData
  LocationAlias Property Alias_OE_Location Auto Const Mandatory
  ReferenceAlias Property Alias_Trigger Auto Const Mandatory

  ReferenceAlias Property Alias_Player Auto Const Mandatory
  ReferenceAlias Property Alias_Companion Auto Const Mandatory

  ReferenceAlias Property Alias_MapMarker Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Center Auto Const Mandatory

  ReferenceAlias Property Alias_Marker_SceneA1 Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_SceneA2 Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_SceneA3 Auto Const Mandatory

  ReferenceAlias Property Alias_Marker_Boss Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_BossChest Auto Const Mandatory
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
; Event received when the quest is initialized, aliases are filled, and it is about to run the startup stage.
Event OnQuestInit()
  LogModuleInformational(functionName="OnQuestInit", logMessage="Quest Init Fired")
  Bool allFilled = true

  ;; Verify Aliases
  If (Alias_OE_Location == None)
    LogModuleCritical(functionName="OnQuestInit", logMessage="Alias_OE_Location is not filled this should not be possible as it comes from the script event")
    allFilled=false
  EndIf
  If (Alias_Trigger == None)
    LogModuleCritical(functionName="OnQuestInit", logMessage="Alias_Trigger is not filled this should not be possible as it comes from the script event")
    allFilled=false
  EndIf
  
  If (Alias_Player == None)
    LogModuleCritical(functionName="OnQuestInit", logMessage="Alias_Player is not filled this should be impossible player is a core engine unique actor")
    allFilled=false
  EndIf
  ;; Alias_Companion can be unset as the player may not have a follower

  If (Alias_MapMarker == None)
    LogModuleCritical(functionName="OnQuestInit", logMessage="Alias_MapMarker is not filled this should not be possible as it is required in all POI and Clutter locations")
    allFilled=false
  EndIf
  If (Alias_Marker_Center == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_Center is not filled")
    allFilled=false
  EndIf

  If (Alias_Marker_SceneA1 == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_SceneA1 is not filled")
    allFilled=false
  EndIf
  If (Alias_Marker_SceneA2 == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_SceneA2 is not filled")
    allFilled=false
  EndIf
  If (Alias_Marker_SceneA3 == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_SceneA3 is not filled")
    allFilled=false
  EndIf

  If (Alias_Marker_Boss == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_Boss is not filled")
    allFilled=false
  EndIf
  If (Alias_Marker_BossChest == None)
    LogModuleWarning(functionName="OnQuestInit", logMessage="Alias_Marker_BossChest is not filled")
    allFilled=false
  EndIf

  If (allFilled == false)
    self.Stop()
  EndIf
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogModuleInformational(functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogModuleInformational(functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
EndEvent

; Event received when a quest stage is set (in parallel with the fragment)
Event OnStageSet(int auiStageID, int auiItemID)
  If (auiStageID == StageEncounterStarted)
    HandleEncounterStarted()
  ElseIf (auiStageID == StageEncounterSceneSetup)
    HandleEncounterSceneSetup()
  ElseIf (auiStageID == StageEncounterSceneSetupComplete)
    HandleEncounterSceneSetupComplete()
  ElseIf (auiStageID == StageEncounterActorSetup)
    HandleEncounterActorSetup()
  ElseIf (auiStageID == StageEncounterActorSetupComplete)
    HandleEncounterActorSetupComplete()
  ElseIf (auiStageID == StageEncounterInProgressPlayerInRange)
    HandleEncounterInProgressPlayerInRange()
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledGrunts)
    HandleEncounterInProgressPlayerKilledGrunts()
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledBoss)
    HandleEncounterInProgressPlayerKilledBoss()
  ElseIf (auiStageID == StageEncounterInProgressPlayerLootedBossChest)
    HandleEncounterInProgressPlayerLootedBossChest()
  ElseIf (auiStageID == StageEncounterComplete)
    HandleEncounterComplete()
  ElseIf (auiStageID == StageEncounterShutdown)
    HandleEncounterShutdown()
  EndIf
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

Function CheckCompleteAndSetCorrectStage()
  If (IsStageDone(StageEncounterInProgressPlayerKilledGrunts) && IsStageDone(StageEncounterInProgressPlayerKilledBoss) && IsStageDone(StageEncounterInProgressPlayerLootedBossChest))
    SetStage(StageEncounterComplete)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Handlers
;;;

;; Encounter Started
Function HandleEncounterStarted()
  LogModuleInformational(functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogModuleInformational(functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")
  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogModuleInformational(functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogModuleInformational(functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")
  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogModuleInformational(functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogModuleInformational(functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGrunts)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGrunts()
  LogModuleInformational(functionName="HandleEncounterInProgressPlayerKilledGrunts", logMessage="Encounter In Progress: Player has killed enemy grunts")
  SetObjectiveCompleted(ObjectiveKillGrunts)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogModuleInformational(functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogModuleInformational(functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

Function HandleEncounterComplete()
  LogModuleInformational(functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  CompleteAllObjectives()
EndFunction

Function HandleEncounterShutdown()
  LogModuleInformational(functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction

