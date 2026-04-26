ScriptName Venworks:EncountersOverhaul:Quests:VEOH_HumanTraffickers_01 extends Venworks:Core:Base:BaseQuest
{Handler script for the Radiant Engine Quest - VEOH_HumanTraffickers_01}


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

GlobalVariable Property LockLevel_Novice Auto Const Mandatory
GlobalVariable Property LockLevel_Advanced Auto Const Mandatory
GlobalVariable Property LockLevel_Expert Auto Const Mandatory
GlobalVariable Property LockLevel_Master Auto Const Mandatory


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
  Int Property StageEncounterInProgressPlayerReleasesCaptives=160 Auto Const Mandatory
  Int Property StageEncounterInProgressCaptivesAreKilled=165 Auto Const Mandatory

  Int Property StageEncounterComplete=900 Auto Const Mandatory
  Int Property StageEncounterFailed=910 Auto Const Mandatory
  Int Property StageEncounterShutdown=999 Auto Const Mandatory

  Int Property ObjectiveKillGrunts=10 Auto Const Mandatory
  Int Property ObjectiveKillLeader=20 Auto Const Mandatory
  Int Property ObjectiveLootChest=30 Auto Const Mandatory
  Int Property ObjectiveReleaseTheCaptives=40 Auto Const Mandatory
EndGroup

Group EventData Collapsed
  LocationAlias Property Alias_OE_Location Auto Const Mandatory
  ReferenceAlias Property Alias_Trigger Auto Const Mandatory

  ReferenceAlias Property Alias_Player Auto Const Mandatory
  ReferenceAlias Property Alias_Companion Auto Const Mandatory

  ReferenceAlias Property Alias_MapMarker Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Center Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Boss Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_BossChest Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Corpse Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Captive Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Cage Auto Const Mandatory

  RefCollectionAlias Property Alias_Captives Auto Const Mandatory
  ReferenceAlias Property Alias_Cage Auto Const Mandatory
  ReferenceAlias Property Alias_Cage_Door Auto Const Mandatory
EndGroup

Group ActorValues Collapsed
  ActorValue Property Aggression Auto Const Mandatory
  ActorValue Property Health Auto Const Mandatory
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
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="OnQuestInit", logMessage="Quest Init Fired")
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
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
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledGroup02)
    HandleEncounterInProgressPlayerKilledGroup02()
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledGroup03)
    HandleEncounterInProgressPlayerKilledGroup03()
  ElseIf (auiStageID == StageEncounterInProgressPlayerKilledBoss)
    HandleEncounterInProgressPlayerKilledBoss()
  ElseIf (auiStageID == StageEncounterInProgressPlayerLootedBossChest)
    HandleEncounterInProgressPlayerLootedBossChest()
  ElseIf (auiStageID == StageEncounterInProgressPlayerReleasesCaptives)
    HandleEncounterInProgressPlayerReleasesCaptives()
  ElseIf (auiStageID == StageEncounterInProgressCaptivesAreKilled)
    HandleEncounterInProgressCaptivesAreKilled()
  ElseIf (auiStageID == StageEncounterComplete)
    HandleEncounterComplete()
  ElseIf (auiStageID == StageEncounterFailed)
    HandleEncounterFailed()
  ElseIf (auiStageID == StageEncounterShutdown)
    HandleEncounterShutdown()
  EndIf
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;

Function CheckGruntsAndCompleteObjective()
  If (IsStageDone(StageEncounterInProgressPlayerKilledGroup01) && IsStageDone(StageEncounterInProgressPlayerKilledGroup02) && IsStageDone(StageEncounterInProgressPlayerKilledGroup03))
    SetObjectiveCompleted(ObjectiveKillGrunts)
  EndIf
EndFunction

Function CheckCompleteAndSetCorrectStage()
  If (IsStageDone(StageEncounterInProgressPlayerKilledGroup01) && IsStageDone(StageEncounterInProgressPlayerKilledGroup02) && IsStageDone(StageEncounterInProgressPlayerKilledGroup03) && IsStageDone(StageEncounterInProgressPlayerKilledBoss) && IsStageDone(StageEncounterInProgressPlayerLootedBossChest) && IsStageDone(StageEncounterInProgressPlayerReleasesCaptives))
    SetStage(StageEncounterComplete)
  EndIf
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Handlers
;;;

;; Encounter Started
Function HandleEncounterStarted()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(25)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")

  ;; Setup the cage door
  ObjectReference cageDoorRef = Alias_Cage_Door.GetRef()
  int playerLevel = Game.GetPlayer().GetLevel()
  int range = playerLevel / 2
  int noviceLockLevel = LockLevel_Novice.GetValue() as Int
  int advancedLockLevel = LockLevel_Advanced.GetValue() as Int
  int expertLockLevel = LockLevel_Expert.GetValue() as Int
  int masterLockLevel = LockLevel_Master.GetValue() as Int

  playerLevel = Math.Clamp(PlayerLevel as Float, 0.0, 100.0) as Int
  range = Utility.RandomInt(Range, PlayerLevel)

  cageDoorRef.SetOpen(False) ; Always close the cage since creatures can't open doors

  If range < noviceLockLevel
    ;; Have to do this to prevent quest hard stop if they cannot unlock novice locks
    cageDoorRef.Lock(False)
    cageDoorRef.UnLock(True)
  Else 
    cageDoorRef.Lock()

    If range < advancedLockLevel
        cageDoorRef.SetLockLevel(noviceLockLevel)
    ElseIf range < expertLockLevel
        cageDoorRef.SetLockLevel(advancedLockLevel)
    ElseIf Range < masterLockLevel
        cageDoorRef.SetLockLevel(expertLockLevel)
    Else
        cageDoorRef.SetLockLevel(masterLockLevel)
    EndIf 
  EndIf 

  SetStage(30)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(50)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")

  ;; Set the captives to the correct mode
  int captiveIndex = 0
  While (captiveIndex < Alias_Captives.GetCount())
    ObjectReference captiveRef = Alias_Captives.GetAt(captiveIndex)
    Actor captive = Alias_Captives.GetActorAt(captiveIndex)

    captiveRef.IgnoreFriendlyHits(true)
    captive.SetRestrained(true)
    captiveRef.SetValue(Aggression, 0)
    captiveRef.SetValue(Health, 1)

    captiveIndex += 1
  EndWhile
  
  SetStage(55)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterActorSetupComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterActorSetupComplete", logMessage="Encounter Actor Setup: Completed")
  ;; Don't trigger any stages we need to wait for the player in range script to set the stage appropriately
EndFunction

;; Encounter In Progress -- Player In Range
Function HandleEncounterInProgressPlayerInRange()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerInRange", logMessage="Encounter In Progress: Player Is In Range, Displaying Objectives")
  SetObjectiveDisplayed(ObjectiveKillGrunts)
  SetObjectiveDisplayed(ObjectiveKillLeader)
  SetObjectiveDisplayed(ObjectiveLootChest)
EndFunction

;; Encounter In Progress -- Player Killed Group 01
Function HandleEncounterInProgressPlayerKilledGroup01()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerKilledGroup01", logMessage="Encounter In Progress: Player has killed Group 01")
  CheckGruntsAndCompleteObjective()
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Group 02
Function HandleEncounterInProgressPlayerKilledGroup02()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerKilledGroup02", logMessage="Encounter In Progress: Player has killed Group 02")
  CheckGruntsAndCompleteObjective()
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Group 03
Function HandleEncounterInProgressPlayerKilledGroup03()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerKilledGroup03", logMessage="Encounter In Progress: Player has killed Group 03")
  CheckGruntsAndCompleteObjective()
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Killed Boss
Function HandleEncounterInProgressPlayerKilledBoss()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerKilledBoss", logMessage="Encounter In Progress: Player has killed the boss")
  SetObjectiveCompleted(ObjectiveKillLeader)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Player Looted Boss Chest
Function HandleEncounterInProgressPlayerLootedBossChest()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerLootedBossChest", logMessage="Encounter In Progress: Player has looted the boss' chest")
  SetObjectiveCompleted(ObjectiveLootChest)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter In Progress -- Release The Captives
Function HandleEncounterInProgressPlayerReleasesCaptives()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressPlayerReleasesCaptives", logMessage="Encounter In Progress: Player has released the captives")
  SetObjectiveCompleted(ObjectiveReleaseTheCaptives)
  CheckCompleteAndSetCorrectStage()
EndFunction

;; Encounter Failed -- The Captives Died
Function HandleEncounterInProgressCaptivesAreKilled()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterInProgressCaptivesAreKilled", logMessage="Encounter Failed: Player allowed the captives to die")
  SetObjectiveFailed(ObjectiveReleaseTheCaptives)
  SetStage(StageEncounterFailed)
EndFunction

Function HandleEncounterComplete()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterComplete", logMessage="Encounter Complete: FYI")
  ;; Shouldn't really need to do this but have had objectives mess up and prevent quest reset
  CompleteAllObjectives()
EndFunction

Function HandleEncounterFailed()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterFailed", logMessage="Encounter Failed: FYI")
EndFunction

Function HandleEncounterShutdown()
  LogUserInformational(creationName=GetCreationName(), moduleName="Quests:VEOH_HumanTraffickers_01", functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
EndFunction