ScriptName Venworks:EncountersOverhaul:PortalHandlerScript Extends Venworks:Core:Base:BaseObjectReference

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Core:Utilities:Travel

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venworks_DebugEnabled Auto Const Mandatory
String Property Venworks_ModName="VenworksEncountersOverhaul" Auto Const Mandatory

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
  LogUserInformational(creationName=Venworks_ModName, moduleName="Venworks:EncountersOverhaul:PortalHandlerScript", functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered. Known portals = " + PortalsFound.GetCount() + ". Known map makers = " + MapMarkersFound.GetCount() + ".")
  Actor player = Game.GetPlayer() 

  If (akActionRef != player as ObjectReference)
    LogUserInformational(creationName=Venworks_ModName, moduleName="Venworks:EncountersOverhaul:PortalHandlerScript", functionName="OnTriggerEnter", logMessage="OnTriggerEnter triggered by something other then the player so aborting.")
    Return
  EndIf

  ;; Freeze the player
  InputEnableLayer playerInputManager = InputEnableLayer.Create()
  playerInputManager.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=True, abLooking=True, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=True, abVATS=True, abFavorites=True, abRunning=True) 

  ;; TODO: Handle random change portal brakes and sends to you random location or unity.

  ;; No point in trying portal match unless we have a few found 
  If (PortalsFound.GetCount() >= 5)
    ObjectReference portalRef = GetSomeWhatSafeMarker(PortalsFound)
    LogUserInformational(creationName=Venworks_ModName, moduleName="Venworks:EncountersOverhaul:PortalHandlerScript", functionName="OnTriggerEnter", logMessage="A random portal was found " + portalRef + "(" + portalRef.GetBaseObject() +").")
    SomeWhatSafeFastTravel(portalRef)
    Return
  EndIf

  ;; If no portal was found fall back on using a random map marker
  If (MapMarkersFound.GetCount() >= 1)
    ObjectReference markerRef = GetSomeWhatSafeMarker(MapMarkersFound)
    LogUserInformational(creationName=Venworks_ModName, moduleName="Venworks:EncountersOverhaul:PortalHandlerScript", functionName="OnTriggerEnter", logMessage="A random POI was found " + markerRef + "(" + markerRef.GetBaseObject() +").")
    SomeWhatSafeFastTravel(markerRef)
    Return
  EndIf

  LogUserInformational(creationName=Venworks_ModName, moduleName="Venworks:EncountersOverhaul:PortalHandlerScript", functionName="OnTriggerEnter", logMessage="No random portal or map marker was found. No idea what to do.")
  ;; TODO: Cause random explosion or something

  ;; Unfreeze the player
  playerInputManager.Reset()
  playerInputManager.Delete()
EndEvent
