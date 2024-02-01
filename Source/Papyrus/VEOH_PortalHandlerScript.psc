ScriptName VEOH_PortalHandlerScript Extends ObjectReference

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Global Variables
;;;
GlobalVariable Property Venpi_DebugEnabled Auto Const Mandatory
String Property Venpi_ModName="VenworksEncountersOverhaul" Auto Const Mandatory

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
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "OnTriggerEnter triggered. Known portals = " + PortalsFound.GetCount() + ". Known map makers = " + MapMarkersFound.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
  Actor player = Game.GetPlayer() 

  If (akActionRef != player as ObjectReference)
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "OnTriggerEnter triggered by something other then the player so aborting.", 0, Venpi_DebugEnabled.GetValueInt())
    Return
  EndIf

  ;; Freeze the player
  InputEnableLayer playerInputManager = InputEnableLayer.Create()
  playerInputManager.DisablePlayerControls(abMovement=True, abFighting=True, abCamSwitch=True, abLooking=True, abSneaking=True, abMenu=True, abActivate=True, abJournalTabs=True, abVATS=True, abFavorites=True, abRunning=True) 

  ;; TODO: Handle random change portal brakes and sends to you random location or unity.

  ;; No point is trying portal match unless we have a few found 
  If (PortalsFound.GetCount() >= 5)
    ObjectReference portalRef = VPI_TravelUtilities.GetSomeWhatSafeMarker(PortalsFound)
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "A random portal was found " + portalRef + "(" + portalRef.GetBaseObject() +").", 0, Venpi_DebugEnabled.GetValueInt())
    VPI_TravelUtilities.SomeWhatSafeFastTravel(portalRef)
    Return
  EndIf

  ;; If no portal was found fall back on using a random map marker
  If (MapMarkersFound.GetCount() >= 1)
    ObjectReference markerRef = VPI_TravelUtilities.GetSomeWhatSafeMarker(MapMarkersFound)
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "A random POI was found " + markerRef + "(" + markerRef.GetBaseObject() +").", 0, Venpi_DebugEnabled.GetValueInt())
    VPI_TravelUtilities.SomeWhatSafeFastTravel(markerRef)
    Return
  EndIf

  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "No random portal or map marker was found. No idea what to do.", 0, Venpi_DebugEnabled.GetValueInt())
  ;; TODO: Cause random explosion or something

  ;; Unfreeze the player
  playerInputManager.Reset()
  playerInputManager.Delete()
EndEvent
