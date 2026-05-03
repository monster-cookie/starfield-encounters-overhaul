ScriptName Venworks:EncountersOverhaul:SceneManager:SMTriggerOverlay Extends Venworks:EncountersOverhaul:Core:Base:BaseObjectReference
{ 
  This is attached to the SMTriggerOverlay* activators and is used to trigger a call to Story Manger when the engine or player is ready.

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
Import Venworks:EncountersOverhaul:Core:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants
;;;
Int Property CONST_SMTriggerType_OnCellLoad = 0 AutoReadOnly
Int Property CONST_SMTriggerType_OnTriggerEnter = 1 AutoReadOnly


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group StoryMangerConfiguration
  Int Property TriggerType=0 Auto Const Mandatory
  {Which event to trigger the call to Story Manager on, use 0 for cell load which is the default or 1 for player enters the trigger zone. }

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
; Event received when every object in this object's parent cell is loaded (TODO: Find restrictions)
Event OnLoad()
  If (TriggerType != CONST_SMTriggerType_OnCellLoad)
    Return
  EndIf

  LogUserInformational(moduleName="SceneManager:SMOverlayTrigger", functionName="OnLoad", logMessage="OnLoad triggered, calling StoryManager.")
  StartEncounter()
EndEvent

; Event received when this trigger volume is entered
Event OnTriggerEnter(ObjectReference akActionRef)
  If (TriggerType != CONST_SMTriggerType_OnTriggerEnter)
    Return
  EndIf

  If (akActionRef != Game.GetPlayer() as ObjectReference)
    LogUserInformational(moduleName="SceneManager:SMOverlayTrigger", functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered, but not by the player so aborting.")
  EndIf

  LogUserInformational(moduleName="SceneManager:SMOverlayTrigger", functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered, calling StoryManager.")
  StartEncounter()
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

	LogUserInformational(moduleName="SceneManager:SMOverlayTrigger", functionName="StartEncounter", logMessage="Calling SendStoryEvent() keyword: " + StoryEventKeyword + ", akLoc: " + akLoc + ", akRef1: " + akRef1 + ", akRef2: " + akRef2 + ", aiValue1: " + iLocationType + ", aiValue2: " + iEventNum)
	Quest[] startedQuests = StoryEventKeyword.SendStoryEventAndWait(akLoc=akLoc, akRef1=akRef1, akRef2=akRef2, aiValue1=iLocationType, aiValue2=iEventNum)
	if (startedQuests.Length == 0 )
	  LogUserWarning(moduleName="SceneManager:SMOverlayTrigger", functionName="StartEncounter", logMessage="Called SendStoryEvent() and started no radiant quests.")
  Else
	  LogUserInformational(moduleName="SceneManager:SMOverlayTrigger", functionName="StartEncounter", logMessage="Called SendStoryEvent() and started " + startedQuests.Length +" quests.")
  EndIf    
EndFunction
