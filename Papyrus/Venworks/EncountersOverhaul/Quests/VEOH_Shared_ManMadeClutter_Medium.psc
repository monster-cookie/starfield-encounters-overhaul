ScriptName Venworks:EncountersOverhaul:Quests:VEOH_Shared_ManMadeClutter_Medium extends Venworks:Core:Base:BaseQuest
{Handler script for the Radiant Engine Quest - VEOH_Shared_ManMadeClutter_Medium}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Core:Enumerations
Import Venworks:Core:Logging

Import Venworks:EncountersOverhaul:GlobalConfig


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venworks_DebugEnabled Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group QuestSetup Collapsed
  Int Property StageEncounterStarted=0 Auto Const Mandatory
  
  Int Property StageEncounterSceneSetup=25 Auto Const Mandatory
  Int Property StageEncounterSceneSetupComplete=30 Auto Const Mandatory
  Int Property StageEncounterActorSetup=50 Auto Const Mandatory
  Int Property StageEncounterActorSetupComplete=55 Auto Const Mandatory

  Int Property StageEncounterInProgressPlayerInRange=100 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerKilledGroup01=110 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerKilledBoss=140 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerLootedBossChest=150 Auto Const Mandatory

  Int Property StageEncounterComplete=900 Auto Const Mandatory
  Int Property StageEncounterShutdown=999 Auto Const Mandatory

  Int Property ObjectiveKillGrunts=10 Auto Const Mandatory
  Int Property ObjectiveKillLeader=20 Auto Const Mandatory
  Int Property ObjectiveLootChest=30 Auto Const Mandatory
EndGroup

Group EventData Collapsed
  LocationAlias Property Alias_OE_Location Auto Const Mandatory
  ReferenceAlias Property Alias_Trigger Auto Const Mandatory

  ReferenceAlias Property Alias_Player Auto Const Mandatory
  ReferenceAlias Property Alias_Companion Auto Const Mandatory

  ReferenceAlias Property Alias_MapMarker Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Center Auto Const Mandatory
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
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="OnQuestInit", logMessage="Quest Init Fired")
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
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
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledGroup01)
    HandleEncounterInProgressPlayerKilledGroup01()
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
  If (IsStageDone(110) && IsStageDone(120) && IsStageDone(130) && IsStageDone(140) && IsStageDone(150))
    SetStage(StageEncounterComplete)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Handlers
;;;

;; Encounter Started
Function HandleEncounterStarted()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")
  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")
  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGrunts)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGroup01()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterInProgressPlayerKilledGroup01", logMessage="Encounter In Progress: Player has killed Group 01")
  SetObjectiveCompleted(ObjectiveKillGrunts)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

Function HandleEncounterComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  ;; Shouldn't really need to do this but have had objectives mess up and prevent quest reset
  CompleteAllObjectives()
EndFunction

Function HandleEncounterShutdown()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_Shared_ManMadeClutter_Medium", functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction