ScriptName Venworks:EncountersOverhaul:SceneManager:SMController Extends Venworks:EncountersOverhaul:Core:Base:BaseQuest
{ My version of the radiant engine quest controller. This needs added to all SceneManager Managed Quests.}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:Core:Enumerations


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
  LogUserInformational(moduleName="SceneManager:SMController", functionName="OnQuestInit", logMessage="OnQuestInit Fired")
EndEvent

;; Event received when the quest has been started
Event OnQuestStarted()
  LogUserInformational(moduleName="SceneManager:SMController", functionName="OnQuestStarted", logMessage="OnQuestStarted Fired")

  ;; register for range check to center marker
  If (RangeCheckDistance > 0)
    ObjectReference centerMarkerRef = Alias_Marker_Center.GetRef()
    LogUserInformational(moduleName="SceneManager:SMController", functionName="OnQuestShutdown", logMessage="Start range check for " + RangeCheckDistance + " units to Marker_Center=" + centerMarkerRef)
    RegisterForDistanceLessThanEvent(Game.GetPlayer(), centerMarkerRef, RangeCheckDistance)
  EndIf 
EndEvent

;; Event received when the quest has been shut down. Note that the aliases will be empty by the time this event is received.
Event OnQuestShutdown()
  LogUserInformational(moduleName="SceneManager:SMController", functionName="OnQuestShutdown", logMessage="OnQuestShutdown Fired")
EndEvent

; Distance event - sent when the two objects are less then the registered distance apart.
Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance, int aiEventID)
  LogUserInformational(moduleName="SceneManager:SMController", functionName="OnDistanceLessThan", logMessage="Player in range. " + afDistance + " setting stage to " + RangeCheckStage)
  SetStage(RangeCheckStage)
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
