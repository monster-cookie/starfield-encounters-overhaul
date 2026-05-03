ScriptName Venworks:EncountersOverhaul:SceneManager:SMController Extends Venworks:EncountersOverhaul:Base:BaseQuest
{ My version of the radiant engine quest controller. This needs added to all SceneManager Managed Quests.}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;

;; These properties perform a standardized range check (distance between the player and the trigger).
Group RangeCheck
  Float Property RangeCheckDistance=700.00 Auto Const Mandatory
  { When player's distance to trigger is less than this, stage RangeCheckStage will be set. }
  
  Int Property RangeCheckStage=100 Auto Const Mandatory
  { When player's distance to trigger is less than RangeCheckDistance, set this stage. }
EndGroup

;; These Are key markers we will need
Group ImportantReferences
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

;; Event received when the quest is initialized, aliases are filled, and it is about to run the startup stage
Event OnQuestInit()
  LogModuleInformational(functionName="OnQuestInit", logMessage="OnQuestInit Fired")
EndEvent

;; Event received when the quest has been started
Event OnQuestStarted()
  LogModuleInformational(functionName="OnQuestStarted", logMessage="OnQuestStarted Fired")

  ;; register for range check to center marker
  If (RangeCheckDistance > 0)
    If (Alias_Marker_Center == None)
      LogModuleCritical(functionName="OnQuestStarted", logMessage="")
      return
    EndIf
    LogModuleInformational(functionName="OnQuestStarted", logMessage="Registering range check for " + RangeCheckDistance + " units to Marker_Center=" + Alias_Marker_Center)
    ObjectReference centerMarkerRef = Alias_Marker_Center.GetRef()
    RegisterForDistanceLessThanEvent(Game.GetPlayer(), centerMarkerRef, RangeCheckDistance)
  EndIf 
EndEvent

;; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogModuleInformational(functionName="OnQuestShutdown", logMessage="OnQuestShutdown Fired")
EndEvent

; Distance event - sent when the two objects are less then the registered distance apart.
Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance, int aiEventID)
  LogModuleInformational(functionName="OnDistanceLessThan", logMessage="Player in range. " + afDistance + " setting stage to " + RangeCheckStage)
  SetStage(RangeCheckStage)
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="SceneManager:SMController", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="SceneManager:SMController", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="SceneManager:SMController", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="SceneManager:SMController", functionName=functionName, logMessage=logMessage)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
