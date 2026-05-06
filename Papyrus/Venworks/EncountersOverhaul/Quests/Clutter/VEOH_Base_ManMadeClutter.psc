ScriptName Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Base_ManMadeClutter extends Venworks:EncountersOverhaul:Base:BaseQuest
{
  Base script that all man made clutter quest script will drive from. Mostly it sets handler functions for getting data from the trigger to the quest.

  DESIGN NOTE: 

  Story manager and reference aliases look at the world cell not the child cell. So 
  when pairing PCM man made clutter with the Story Manager you can trigger the quest 
  but the reference aliases encompass the whole zone.  So you get NPC spawning in the 
  wrong places and objectives all over the map. 

  To mitigate this I'm making my own version of a script event papyrus side. The in cell 
  trigger (DSETriggerOverlay) will function normally but in made made clutter mode instead 
  calling StoryEventKeyword.SendStoryEventAndWait it will call the TriggerWithData function
  on this base class. That function will handle sending in the Trigger and Location. 
}


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
Group Helpers
  GlobalVariable Property VEOH_DebugMode Auto Const Mandatory
EndGroup

Group BaseEventData
  LocationAlias Property Alias_OE_Location Auto
  ReferenceAlias Property Alias_Trigger Auto
  Int Property LocationSubtype Auto
  Int Property EventSubtype Auto

  ReferenceAlias Property Alias_Player Auto Const Mandatory
  ReferenceAlias Property Alias_Companion Auto Const Mandatory
EndGroup

Group BaseAliases
  ReferenceAlias Property Alias_MapMarker Auto
  ReferenceAlias Property Alias_Marker_Center Auto

  ReferenceAlias Property Alias_Marker_Boss Auto Const Mandatory
  
  ReferenceAlias Property Alias_Marker_Chest_Boss Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Chest_Large Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_Chest_Small Auto Const Mandatory

  ReferenceAlias Property Alias_Marker_SceneA1 Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_SceneA2 Auto Const Mandatory
  ReferenceAlias Property Alias_Marker_SceneA3 Auto Const Mandatory

  ReferenceAlias Property Alias_Marker_SceneB1 Auto
  ReferenceAlias Property Alias_Marker_SceneB2 Auto
  ReferenceAlias Property Alias_Marker_SceneB3 Auto

  ReferenceAlias Property Alias_Marker_SceneC1 Auto
  ReferenceAlias Property Alias_Marker_SceneC2 Auto
  ReferenceAlias Property Alias_Marker_SceneC3 Auto
EndGroup

Group QuestSetup
  Int Property StageQuestStarted=0 Auto Const
  
  Int Property StageEncounterSceneSetup=25 Auto Const
  Int Property StageEncounterSceneSetupComplete=30 Auto Const
  Int Property StageEncounterActorSetup=50 Auto Const
  Int Property StageEncounterActorSetupComplete=55 Auto Const

  Int Property StageEncounterInProgressPlayerInRange=100 Auto Const
EndGroup

Group AutoFillLinkedRefKeywords
  Keyword Property DSELinkedRef_Marker_Map Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Center Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneA Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneB Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_SceneC Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Boss Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Chest_Boss Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Chest_Large Auto Const Mandatory
  Keyword Property DSELinkedRef_Marker_Chest_Small Auto Const Mandatory
EndGroup

Bool Property Initialized=False Auto Hidden



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function BeginWithData(ObjectReference akTrigger, Location akLocation, Int aiLocationSubtype, Int aiEventSubType, ObjectReference akMapMarker, ObjectReference akMarkerCenter)
  LogModuleInformational(functionName="BeginWithData", logMessage=self + " quest directly started received akTrigger=" + akTrigger + ", akLocation=" + akLocation + ", aiLocationSubtype=" + aiLocationSubtype + ", aiEventSubType=" + aiEventSubType + ", akMapMarker=" + akMapMarker + ", akMarkerCenter=" + akMarkerCenter)

  ;; The quest must be enabled and running to be able to set up aliases
  if !IsRunning()
    LogModuleInformational(functionName="BeginWithData", logMessage=self + " was not running so starting.")
    Start()
  endif

  ;; Store/Update Required Event Triggers
  Alias_OE_Location.ForceLocationTo(akLocation)
  Alias_Trigger.ForceRefTo(akTrigger)
  LocationSubtype = aiLocationSubtype
  EventSubtype = aiEventSubType

  Alias_MapMarker.ForceRefTo(akMapMarker)
  Alias_Marker_Center.ForceRefTo(akMarkerCenter)

  ;; Required Marker_Boss
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Boss) <= 0)
    LogModuleCritical(functionName="BeginWithData", logMessage="Required link ref for DSELinkedRef_Marker_Boss was not found.")
    Reset()
    Return
  EndIf
  ObjectReference akBossMarker = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Boss)[0] ;; Can only be one
  If (akBossMarker != None)
    Alias_Marker_Boss.ForceRefTo(akBossMarker)
  EndIf

  ;; Required Marker_Chest_Boss
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Boss) <= 0)
    LogModuleCritical(functionName="BeginWithData", logMessage="Required link ref for DSELinkedRef_Marker_Chest_Boss was not found.")
    Reset()
    Return
  EndIf
  ObjectReference akChestBossMarker = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Boss)[0] ;; Can be many but only need one
  If (akChestBossMarker != None)
    Alias_Marker_Chest_Boss.ForceRefTo(akChestBossMarker)
  EndIf
  
  ;; Optional Marker_Chest_Large
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Large) >= 0)
    ObjectReference akChestLargeMarker = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Large)[0] ;; Can be many but only need one
    If (akChestLargeMarker != None)
      Alias_Marker_Chest_Large.ForceRefTo(akChestLargeMarker)
    EndIf
  EndIf
  
  ;; Optional Marker_Chest_Small
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Small) >= 0)
    ObjectReference akChestSmallMarker = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Chest_Small)[0] ;; Can be many but only need one
    If (akChestSmallMarker != None)
      Alias_Marker_Chest_Small.ForceRefTo(akChestSmallMarker)
    EndIf
  EndIf

  ;; Required Marker_SceneA
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneA) <= 0)
    LogModuleCritical(functionName="BeginWithData", logMessage="Required link ref for DSELinkedRef_Marker_SceneA was not found.")
    Reset()
    Return
  EndIf
  ObjectReference[] akSceneAMarkers = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneA)
  If (akSceneAMarkers.Length >= 3)
    Alias_Marker_SceneA1.ForceRefTo(akSceneAMarkers[0])
    Alias_Marker_SceneA2.ForceRefTo(akSceneAMarkers[1])
    Alias_Marker_SceneA3.ForceRefTo(akSceneAMarkers[2])
  ElseIf (akSceneAMarkers.Length == 2)
    Alias_Marker_SceneA1.ForceRefTo(akSceneAMarkers[0])
    Alias_Marker_SceneA2.ForceRefTo(akSceneAMarkers[1])
    Alias_Marker_SceneA3.ForceRefTo(akMarkerCenter)
  ElseIf (akSceneAMarkers.Length == 1)
    Alias_Marker_SceneA1.ForceRefTo(akSceneAMarkers[0])
    Alias_Marker_SceneA2.ForceRefTo(akMarkerCenter)
    Alias_Marker_SceneA3.ForceRefTo(akMapMarker) 
  EndIf

  ;; Required Marker_SceneB
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneB) >= 0)
    ObjectReference[] akSceneBMarkers = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneB)
    If (akSceneBMarkers.Length >= 3)
      Alias_Marker_SceneB1.ForceRefTo(akSceneBMarkers[0])
      Alias_Marker_SceneB2.ForceRefTo(akSceneBMarkers[1])
      Alias_Marker_SceneB3.ForceRefTo(akSceneBMarkers[2])
    ElseIf (akSceneBMarkers.Length == 2)
      Alias_Marker_SceneB1.ForceRefTo(akSceneBMarkers[0])
      Alias_Marker_SceneB2.ForceRefTo(akSceneBMarkers[1])
      Alias_Marker_SceneB3.ForceRefTo(akMarkerCenter)
    ElseIf (akSceneBMarkers.Length == 1)
      Alias_Marker_SceneB1.ForceRefTo(akSceneBMarkers[0])
      Alias_Marker_SceneB2.ForceRefTo(akMarkerCenter)
      Alias_Marker_SceneB3.ForceRefTo(akMapMarker) 
    EndIf
  EndIf

  ;; Required Marker_SceneB
  If (akTrigger.CountRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneC) >= 0)
    ObjectReference[] akSceneCMarkers = akTrigger.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_SceneC)
    If (akSceneCMarkers.Length >= 3)
      Alias_Marker_SceneC1.ForceRefTo(akSceneCMarkers[0])
      Alias_Marker_SceneC2.ForceRefTo(akSceneCMarkers[1])
      Alias_Marker_SceneC3.ForceRefTo(akSceneCMarkers[2])
    ElseIf (akSceneCMarkers.Length == 2)
      Alias_Marker_SceneC1.ForceRefTo(akSceneCMarkers[0])
      Alias_Marker_SceneC2.ForceRefTo(akSceneCMarkers[1])
      Alias_Marker_SceneC3.ForceRefTo(akMarkerCenter)
    ElseIf (akSceneCMarkers.Length == 1)
      Alias_Marker_SceneC1.ForceRefTo(akSceneCMarkers[0])
      Alias_Marker_SceneC2.ForceRefTo(akMarkerCenter)
      Alias_Marker_SceneC3.ForceRefTo(akMapMarker) 
    EndIf
  EndIf

  LogModuleInformational(functionName="BeginWithData", logMessage=self + " calling InitializeFromCaller().")
  InitializeFromCaller()
EndFunction

Function InitializeFromCaller()
  if (Initialized == True)
    LogModuleInformational(functionName="InitializeFromCaller", logMessage=self + " already initialized so aborting.")
    return
  endif

  LogModuleInformational(functionName="InitializeFromCaller", logMessage=self + " setting initialized and jumping to stage StageQuestStarted(" + StageQuestStarted + ").")
  Initialized = true
  SetStage(StageQuestStarted)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="Quests:Clutter:VEOH_Base_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="Quests:Clutter:VEOH_Base_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="Quests:Clutter:VEOH_Base_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="Quests:Clutter:VEOH_Base_ManMadeClutter", functionName=functionName, logMessage=logMessage)
EndFunction
