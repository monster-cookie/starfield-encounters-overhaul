ScriptName Venworks:EncountersOverhaul:Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01 extends Venworks:EncountersOverhaul:Core:Base:BaseQuest
{Handler script for the Radiant Engine Quest - VEOH_Clutter_Ecliptic_Small_01}


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
Group QuestSetup Collapsed
  Int Property StageEncounterStarted=0 Auto Const Mandatory
  
  Int Property StageEncounterSceneSetup=25 Auto Const Mandatory
  Int Property StageEncounterSceneSetupComplete=30 Auto Const Mandatory
  Int Property StageEncounterActorSetup=50 Auto Const Mandatory
  Int Property StageEncounterActorSetupComplete=55 Auto Const Mandatory

  Int Property StageEncounterInProgressPlayerInRange=100 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerKilledGroup01=110 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerKilledGroup02=120 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerKilledGroup03=130 Auto Const Mandatory
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
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="OnQuestInit", logMessage="Quest Init Fired")
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
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
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")
  ;; To do implement random related clutter. Testing the new radiant ending but again I suspect it cant handle the level of detail needed so I'll have to pull in more SceneManager stuff. 
  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")
  
  ;; Testing Viability of SQ_Groups, if that fails will use the SceneManager Spawning Scripts. Which would normally have occurred here. 
  ; ObjectReference[] spawnedActorsGroup01 = SQ_MCS_SpawnSystem.SpawnGroup(FactionType_SpawnGroup01, Alias_Marker_Spawn_NPCGroup01.GetRef(), 0, 0, 2, 2, 3, 3)
  ; Alias_SpawnGroup01.AddArray(spawnedActorsGroup01)
  ; ObjectReference[] spawnedActorsGroup02 = SQ_MCS_SpawnSystem.SpawnGroup(FactionType_SpawnGroup02, Alias_Marker_Spawn_NPCGroup02.GetRef(), 1, 1, 1, 1, 3, 3)
  ; Alias_SpawnGroup02.AddArray(spawnedActorsGroup02)
  ; ObjectReference[] spawnedActorsGroup03 = SQ_MCS_SpawnSystem.SpawnGroup(FactionType_SpawnGroup03, Alias_Marker_Spawn_NPCGroup03.GetRef(), 1, 1, 1, 1, 3, 3)
  ; Alias_SpawnGroup02.AddArray(spawnedActorsGroup03)

  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGrunts)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGroup01()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterInProgressPlayerKilledGroup01", logMessage="Encounter In Progress: Player has killed Group 01")
  SetObjectiveCompleted(ObjectiveKillGrunts)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

Function HandleEncounterComplete()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  ;; Shouldn't really need to do this but have had objectives mess up and prevent quest reset
  CompleteAllObjectives()
EndFunction

Function HandleEncounterShutdown()
  LogUserInformational(moduleName="Quests:Clutter:Small:VEOH_Clutter_Ecliptic_Small_01", functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction