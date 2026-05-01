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
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="OnQuestInit", logMessage="Quest Init Fired")
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
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
;;; Handlers
;;;

;; Encounter Started
Function HandleEncounterStarted()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")
  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")
  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGrunts)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGrunts()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterInProgressPlayerKilledGrunts", logMessage="Encounter In Progress: Player has killed enemy grunts")
  SetObjectiveCompleted(ObjectiveKillGrunts)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

Function HandleEncounterComplete()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  CompleteAllObjectives()
EndFunction

Function HandleEncounterShutdown()
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Shared_ManMadeClutter", functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction