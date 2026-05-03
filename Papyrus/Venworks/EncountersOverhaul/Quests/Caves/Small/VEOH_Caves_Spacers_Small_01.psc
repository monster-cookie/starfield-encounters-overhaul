ScriptName Venworks:EncountersOverhaul:Quests:Caves:Small:VEOH_Caves_Spacers_Small_01 extends Venworks:EncountersOverhaul:Base:BaseQuest
{Handler script for the Radiant Engine Quest - VEOH_Caves_Spacers_Small_01}


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
  Int Property StageEncounterInProgressPlayerKilledBoss=120 Auto Const Mandatory
  Int Property StageEncounterInProgressPlayerLootedBossChest=130 Auto Const Mandatory

  Int Property StageEncounterComplete=900 Auto Const Mandatory
  Int Property StageEncounterShutdown=999 Auto Const Mandatory

  Int Property ObjectiveKillGroup01=10 Auto Const Mandatory
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
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="OnQuestInit", logMessage="Quest Init Fired")
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
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
  If (IsStageDone(110) && IsStageDone(120) && IsStageDone(130))
    SetStage(StageEncounterComplete)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Handlers
;;;

;; Encounter Started
Function HandleEncounterStarted()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")
  ;; To do implement random related clutter. Testing the new radiant ending but again I suspect it cant handle the level of detail needed so I'll have to pull in more SceneManager stuff. 
  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")
  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGroup01)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGroup01()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterInProgressPlayerKilledGroup01", logMessage="Encounter In Progress: Player has killed Group 01")
  SetObjectiveCompleted(ObjectiveKillGroup01)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

Function HandleEncounterComplete()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  ;; Shouldn't really need to do this but have had objectives mess up and prevent quest reset
  CompleteAllObjectives()
EndFunction

Function HandleEncounterShutdown()
  LogUserInformational(moduleName="Quests:VEOH_Caves_Spacers_Small_01", functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction