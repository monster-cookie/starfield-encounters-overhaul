ScriptName Venworks:EncountersOverhaul:PortalHandlerScript Extends Venworks:EncountersOverhaul:Base:BaseObjectReference

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Utilities:Travel

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
RefCollectionAlias Property MapMarkersFound Auto Const Mandatory
RefCollectionAlias Property PortalsFound Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnTriggerEnter(ObjectReference akActionRef)
  LogModuleInformational(functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered. Known portals = " + PortalsFound.GetCount() + ". Known map makers = " + MapMarkersFound.GetCount() + ".")
  Actor player = Game.GetPlayer() 

  If (akActionRef != player as ObjectReference)
    LogModuleInformational(functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered by something other then the player so aborting.")
    Return
  EndIf

  ;; Freeze the player
  InputEnableLayer playerInputManager = InputEnableLayer.Create()
  playerInputManager.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=True, abLooking=True, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=True, abVATS=True, abFavorites=True, abRunning=True) 

  ;; TODO: Handle random change portal brakes and sends to you random location or unity.

  ;; No point in trying portal match unless we have a few found 
  If (PortalsFound.GetCount() >= 5)
    ObjectReference portalRef = GetSomeWhatSafeMarker(PortalsFound)
    LogModuleInformational(functionName="OnTriggerEnter", logMessage="A random portal was found " + portalRef + "(" + portalRef.GetBaseObject() +").")
    SomeWhatSafeFastTravel(portalRef)
    Return
  EndIf

  ;; If no portal was found fall back on using a random map marker
  If (MapMarkersFound.GetCount() >= 1)
    ObjectReference markerRef = GetSomeWhatSafeMarker(MapMarkersFound)
    LogModuleInformational(functionName="OnTriggerEnter", logMessage="A random POI was found " + markerRef + "(" + markerRef.GetBaseObject() +").")
    SomeWhatSafeFastTravel(markerRef)
    Return
  EndIf

  LogModuleInformational(functionName="OnTriggerEnter", logMessage="No random portal or map marker was found. No idea what to do.")
  ;; TODO: Cause random explosion or something

  ;; Unfreeze the player
  playerInputManager.Reset()
  playerInputManager.Delete()
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="PortalHandlerScript", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="PortalHandlerScript", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="PortalHandlerScript", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="PortalHandlerScript", functionName=functionName, logMessage=logMessage)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
