ScriptName Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Shared_ManMadeClutter extends Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Base_ManMadeClutter
{Handler script for the Radiant Engine Quest - VEOH_Shared_ManMadeClutter}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Logging


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

Group QuestSetup
  Int Property StageEncounterInProgressPlayerKilledGrunts=110 Auto Const
  Int Property StageEncounterInProgressPlayerKilledBoss=120 Auto Const
  Int Property StageEncounterInProgressPlayerLootedBossChest=130 Auto Const

  Int Property StageEncounterComplete=900 Auto Const
  Int Property StageEncounterShutdown=999 Auto Const

  Int Property ObjectiveKillGrunts=10 Auto Const
  Int Property ObjectiveKillLeader=20 Auto Const
  Int Property ObjectiveLootChest=30 Auto Const
EndGroup

Group QuestSpecificAliases
  ReferenceAlias Property Chest_Boss Auto Const Mandatory
  ReferenceAlias Property NPC_Boss Auto Const Mandatory
  RefCollectionAlias Property NPC_Grunts Auto Const Mandatory
  ReferenceAlias Property NPC_Grunts_NPC01 Auto Const Mandatory
  ReferenceAlias Property NPC_Grunts_NPC02 Auto Const Mandatory
  ReferenceAlias Property NPC_Grunts_NPC03 Auto Const Mandatory
  ReferenceAlias Property NPC_Grunts_NPC04 Auto Const Mandatory
EndGroup

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
; Event received when the quest is initialized, aliases are filled, and it is about to run the startup stage.
Event OnQuestInit()
  LogModuleInformational(functionName="OnQuestInit", logMessage="Quest Init Fired")

  If (VerifyAliases())
    LogModuleCritical(functionName="OnQuestInit", logMessage="Some aliases are missing please look for warnings above this message.")
    self.Stop()
  Else
    LogModuleInformational(functionName="OnQuestInit", logMessage="All Aliases should be filled.")
  EndIf
EndEvent

; Event received when the quest has been started
Event OnQuestStarted()
  LogModuleInformational(functionName="OnQuestStarted", logMessage="Quest OnQuestStarted Fired")

  If (VerifyAliases())
    LogModuleCritical(functionName="OnQuestStarted", logMessage="Some aliases are missing please look for warnings above this message.")
    self.Stop()
  Else
    LogModuleInformational(functionName="OnQuestStarted", logMessage="All Aliases should be filled.")
  EndIf

  If (VEOH_DebugMode.GetValueInt() == 1)
    ;; Not entirely sure we can do that with objectives so going to try and log the in game id of the map marker
    LogModuleInformational(functionName="OnQuestStarted", logMessage="This should be the in game ref for the map marker assigned to this quest: " + Alias_MapMarker.GetReference())
  EndIf
EndEvent

; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogModuleInformational(functionName="OnQuestShutdown", logMessage="Quest Shutdown Fired")
EndEvent

; Event received when a quest stage is set (in parallel with the fragment)
Event OnStageSet(int auiStageID, int auiItemID)
  If (auiStageID == StageQuestStarted)
    HandleQuestStarted()
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

Bool Function VerifyAliases()
  LogModuleInformational(functionName="VerifyAliases", logMessage="Verifying necessary aliases are set.")
  
  ;; Verify Aliases
  If (Alias_OE_Location == None || Alias_OE_Location.GetLocation() == None)
    LogModuleCritical(functionName="VerifyAliases", logMessage="REQUIRED MISSING: Alias_OE_Location is not filled this should not be possible as it comes from the script event")
    Return False
  EndIf
  If (Alias_Trigger == None || Alias_Trigger.GetReference() == None)
    LogModuleCritical(functionName="VerifyAliases", logMessage="REQUIRED MISSING: Alias_Trigger is not filled this should not be possible as it comes from the script event")
    Return False
  EndIf
  
  If (Alias_Player == None || Alias_Player.GetReference() == None)
    LogModuleCritical(functionName="VerifyAliases", logMessage="REQUIRED MISSING: Alias_Player is not filled this should be impossible player is a core engine unique actor")
    Return False
  EndIf

  ;; Alias_Companion can be unset as the player may not have a follower

  If (Alias_MapMarker == None || Alias_MapMarker.GetReference() == None)
    LogModuleCritical(functionName="VerifyAliases", logMessage="REQUIRED MISSING: Alias_MapMarker is not filled this should not be possible as it is required in all POI and Clutter locations")
    Return False
  EndIf

  If (Alias_Marker_Center == None || Alias_Marker_Center.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="REQUIRED MISSING: Alias_Marker_Center is not filled this should not be possible as it is required in all POI and Clutter locations")
    Return False
  EndIf

  If (Alias_Marker_SceneA1 == None || Alias_Marker_SceneA1.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_SceneA1 is not filled")
    Return False
  EndIf

  If (Alias_Marker_SceneA2 == None || Alias_Marker_SceneA2.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_SceneA2 is not filled")
    Return False
  EndIf

  If (Alias_Marker_SceneA3 == None || Alias_Marker_SceneA3.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_SceneA3 is not filled")
    Return False
  EndIf

  If (Alias_Marker_Boss == None || Alias_Marker_Boss.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_Boss is not filled")
    Return False
  EndIf

  If (Alias_Marker_Chest_Boss == None || Alias_Marker_Chest_Boss.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_BossChest is not filled")
    Return False
  EndIf

  If (Alias_Marker_Chest_Large == None || Alias_Marker_Chest_Large.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_Chest_Large is not filled")
    Return False
  EndIf

  If (Alias_Marker_Chest_Small == None || Alias_Marker_Chest_Small.GetReference() == None)
    LogModuleWarning(functionName="VerifyAliases", logMessage="Alias_Marker_Chest_Small is not filled")
    Return False
  EndIf
EndFunction

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
;;; Functions - Handlers
;;;

;; Encounter Started
Function HandleQuestStarted()
  LogModuleInformational(functionName="HandleQuestStarted", logMessage="Encounter Started: Nothing really to do")
  SetStage(StageEncounterSceneSetup)
EndFunction

;; Encounter Scene Setup
Function HandleEncounterSceneSetup()
  LogModuleInformational(functionName="HandleEncounterSceneSetup", logMessage="Encounter Scene Setup: Starting")

  ;; TODO: Spawn Chest
  ObjectReference markerChestBoss = Alias_Marker_Chest_Boss.GetReference()
  ObjectReference chestBoss = Chest_Boss.GetReference()
  If (markerChestBoss != None && chestBoss != None)
    ;; We should have a chest and a marker to spawn at.
    markerChestBoss.PlaceAtMe(akFormToPlace=chestBoss)
  EndIf

  SetStage(StageEncounterSceneSetupComplete)
EndFunction

;; Encounter Scene Setup -- Complete
Function HandleEncounterSceneSetupComplete()
  LogModuleInformational(functionName="HandleEncounterSceneSetupComplete", logMessage="Encounter Scene Setup: Completed")
  SetStage(StageEncounterActorSetup)
EndFunction

;; Encounter NPC Setup
Function HandleEncounterActorSetup()
  LevelModifier levelModTable = new LevelModifier
  LogModuleInformational(functionName="HandleEncounterActorSetup", logMessage="Encounter Actor Setup: Starting")

  ;; TODO: Spawn Boss and NPCs
  ObjectReference markerBoss = Alias_Marker_Boss.GetReference()

  ObjectReference markersSceneA1 = Alias_Marker_SceneA1.GetReference()
  ObjectReference markersSceneA2 = Alias_Marker_SceneA2.GetReference()
  ObjectReference markersSceneA3 = Alias_Marker_SceneA3.GetReference()

  ObjectReference npcBoss = NPC_Boss.GetActorReference()

  If (markerBoss != None && npcBoss != None)
    ;; We should have a boss NPC and a marker so spawn them
    markerBoss.PlaceActorAtMe(akActorToPlace=(npcBoss as Actor).GetLeveledActorBase(), aiLevelMod= levelModTable.Boss)
  EndIf

  markersSceneA1.PlaceActorAtMe(akActorToPlace=(NPC_Grunts.GetRandom() as Actor).GetLeveledActorBase(), aiLevelMod=levelModTable.Boss)
  markersSceneA2.PlaceActorAtMe(akActorToPlace=(NPC_Grunts.GetRandom() as Actor).GetLeveledActorBase(), aiLevelMod=levelModTable.Boss)
  markersSceneA3.PlaceActorAtMe(akActorToPlace=(NPC_Grunts.GetRandom() as Actor).GetLeveledActorBase(), aiLevelMod=levelModTable.Boss)

  SetStage(StageEncounterActorSetupComplete)
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
  SetStage(StageEncounterShutdown)
EndFunction

Function HandleEncounterShutdown()
  LogModuleInformational(functionName="HandleEncounterShutdown", logMessage="Encounter Shutdown: FYI")
  Reset()
EndFunction

