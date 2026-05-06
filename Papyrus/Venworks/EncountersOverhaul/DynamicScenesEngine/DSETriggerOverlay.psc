ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:DSETriggerOverlay Extends Venworks:EncountersOverhaul:Base:BaseObjectReference
{ 
  This is attached to the DSETriggerOverlay* activators and is used to trigger a call to Story Manger when the engine or player is ready.

  Story Manager Data will be:
    Location: Location of this activator
    Ref1: This activator
    Ref2: Currently not used
    Int1: The Location Subtype
    Int2: The Event Subtype
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants
;;;
Int Property CONST_DSETriggerMode_StoryManager = 0 AutoReadOnly
Int Property CONST_DSETriggerMode_DirectLaunch = 1 AutoReadOnly

Int Property CONST_DSETriggerType_OnCellLoad = 0 AutoReadOnly
Int Property CONST_DSETriggerType_OnTriggerEnter = 1 AutoReadOnly


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group StoryMangerConfiguration
  Int Property TriggerMode=1 Auto Const Mandatory
  {
    How to trigger quests:
      - 0 for StoryManager SendStoryEventAndWait
      - 1 for Direct launch of quests
  }

  Int Property TriggerType=1 Auto Const Mandatory
  {
    Which event to trigger the call to the manager on:
      - 0 for on cell load
      - 1 for when player enters the trigger zone. (This is the default)
  }

  FormList Property AvailableQuests Auto Const Mandatory
  {
    These are the quests the trigger will randomly choose one of try and launch
  }

  Int Property ChanceToSpawnQuest=40 Auto Const
  {
    The chance to spawn a quest in percentage form, the default is 40%
  }

  Keyword Property StoryEventKeyword Auto Const Mandatory
	{The Keyword you want to call SendStoryEvent for.}

  GlobalVariable Property LocationType Auto Const Mandatory
	{
    An integer associated with trigger location, potentially will be used for location type (urban, rural, coastal, road, etc). 
    
    Sent as the StoryMangerEvent.aiValue1. 
    
    See Global Variables Below for correct values

    SMLocationType_Disabled   (-1) = Don't Send a Subtype
    SMLocationType_Any        (0)  = Any Subtype

    SMLocationType_StorageGeneral (1)  = Storage Themed Man Made Clutter
    SMLocationType_StorageFluid   (2)  = Storage Themed Man Made Clutter
    SMLocationType_Solar          (3)  = Solar Power Themed Man Made Clutter
    SMLocationType_Industrial     (4)  = Industrial Themed Man Made Clutter

    Currently Not Really Used
  }

	GlobalVariable Property EventSubType Auto Const Mandatory
	{
    This controls which specific event you want to start. 
    
    Sent as the StoryMangerEvent.aiValue2. 
    
    See Global Variables below for the correct values 

    SMEventType_Disabled (-1) = Don't Send a Subtype
    SMEventType_Any      (0)  = Any Subtype

    For Man Made Clutter Packins:
    SMEventType_Clutter_Small  (1) = Small Clutter
    SMEventType_Clutter_Medium (2) = Medium Clutter
    SMEventType_Clutter_Large  (3) = Large Clutter

    For Caves
    SMEventType_Cave_Small  (4) = Small Cave
    SMEventType_Cave_Medium (5) = Medium Cave
    SMEventType_Cave_Large  (6) = Large Cave
  }
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
; Event received when every object in this object's parent cell is loaded (TODO: Find restrictions)
Event OnLoad()
  If (TriggerType == CONST_DSETriggerType_OnCellLoad)
    LogModuleInformational(functionName="OnLoad", logMessage="OnLoad triggered, calling StartEncounter()")
    StartEncounter()
  EndIf
EndEvent

; Event received when this trigger volume is entered
Event OnTriggerEnter(ObjectReference akActionRef)
  If (TriggerType != CONST_DSETriggerType_OnTriggerEnter)
    Return
  EndIf

  If (akActionRef == Game.GetPlayer() as ObjectReference)
    LogModuleInformational(functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered, and it was the player that triggered so calling StoryManager.")
    StartEncounter()
  Else
    LogModuleInformational(functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered, but not by the player so aborting. Was triggered by " + akActionRef)
  EndIf
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
Function StartEncounter()
  Location akLoc = GetCurrentLocation()
  ObjectReference akRef1 = self
  ObjectReference akRef2 = None
  Int iEventNum = EventSubType.GetValueInt()
  Int iLocationType = LocationType.GetValueInt()

  Quest[] startedQuests = new Quest[0]
  if (TriggerMode == CONST_DSETriggerMode_StoryManager)
    ;; Use Story Manager
    LogModuleInformational(functionName="StartEncounter", logMessage="Calling SendStoryEvent() keyword: " + StoryEventKeyword + ", akLoc: " + akLoc + ", akRef1: " + akRef1 + ", akRef2: " + akRef2 + ", aiValue1: " + iLocationType + ", aiValue2: " + iEventNum)
	  startedQuests = StoryEventKeyword.SendStoryEventAndWait(akLoc=akLoc, akRef1=akRef1, akRef2=akRef2, aiValue1=iLocationType, aiValue2=iEventNum)
  ElseIf (TriggerMode == CONST_DSETriggerMode_DirectLaunch)
    ;; Direct launch the quest
    If (AvailableQuests == None || AvailableQuests.GetSize() == 0)
      LogModuleCritical(functionName="StartEncounter", logMessage="AvailableQuests array is empty.")
      return
    EndIf

    int randomIndex = Utility.RandomInt(0, AvailableQuests.GetSize()-1)
    LogModuleInformational(functionName="StartEncounter", logMessage="There are " + AvailableQuests.GetSize() + " to choose from grabbing quest at index " + randomIndex + ".")
    Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Shared_ManMadeClutter questToStart = AvailableQuests.GetAt(randomIndex) as Venworks:EncountersOverhaul:Quests:Clutter:VEOH_Shared_ManMadeClutter
    If (questToStart == None)
      LogModuleCritical(functionName="StartEncounter", logMessage="Failed to find a quest to start")
      return
    EndIf

    ;; Need to use linked refs to get the linked map marker and center marker linked to this trigger.
    ObjectReference akMapMarker = self.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Map)[0] ;; Can only be one
    ObjectReference akMarkerCenter = self.GetRefsLinkedToMe(apLinkKeyword=DSELinkedRef_Marker_Center)[0] ;; Can only be one

    LogModuleInformational(functionName="StartEncounter", logMessage="Directly Calling the quest: " + questToStart + ", akTrigger: " + akRef1 + ", akLocation: " + akLoc + ", aiLocationSubtype: " + iLocationType + ", aiEventSubType: " + iEventNum + ", akMapMarker: " + akMapMarker + ", akMarkerCenter: " + akMarkerCenter)

    questToStart.BeginWithData(akTrigger=akRef1, akLocation=akLoc, aiLocationSubtype=iLocationType, aiEventSubType=iEventNum, akMapMarker=akMapMarker, akMarkerCenter=akMarkerCenter)
    startedQuests.Add(questToStart)
  Else
    LogModuleCritical(functionName="StartEncounter", logMessage="Unknown trigger mode received (" + TriggerType +")")
    return
  EndIf
	
  If (startedQuests.Length == 0 && TriggerMode == CONST_DSETriggerMode_StoryManager)
	  LogModuleWarning(functionName="StartEncounter", logMessage="Called SendStoryEvent() and did not start any quests.")
  ElseIf (startedQuests.Length >= 1 && TriggerMode == CONST_DSETriggerMode_StoryManager)
	  LogModuleInformational(functionName="StartEncounter", logMessage="Called SendStoryEvent() and started " + startedQuests.Length +" quests.")
  ElseIf (startedQuests.Length == 0 && TriggerMode == CONST_DSETriggerMode_DirectLaunch)
	  LogModuleWarning(functionName="StartEncounter", logMessage="Tried directly calling a quest and it did not start.")
  ElseIf (startedQuests.Length >= 1 && TriggerMode == CONST_DSETriggerMode_DirectLaunch)
	  LogModuleInformational(functionName="StartEncounter", logMessage="Tried directly calling a quest and it started.")
  Else
	  LogModuleCritical(functionName="StartEncounter", logMessage="Something weird happened. This message shouldn't be reachable.")
  EndIf    
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="DynamicScenesEngine:DSETriggerOverlay", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="DynamicScenesEngine:DSETriggerOverlay", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="DynamicScenesEngine:DSETriggerOverlay", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="DynamicScenesEngine:DSETriggerOverlay", functionName=functionName, logMessage=logMessage)
EndFunction
