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
; Keyword Property VEOH_ActivePortal Auto Const Mandatory
RefCollectionAlias Property KnownPortals Auto Const Mandatory
RefCollectionAlias Property KnownRandomPOI Auto Const Mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnInit()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnInit", "OnInit triggered. Known Portals =" + KnownPortals.GetCount() + ". Known Random POI=" + KnownRandomPOI.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent

Event OnLoad()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnLoad", "OnLoad triggered. Known Portals =" + KnownPortals.GetCount() + ". Known Random POI=" + KnownRandomPOI.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent

Event OnActivate(ObjectReference akActionRef)
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnActivate", "OnActivate triggered. Known Portals =" + KnownPortals.GetCount() + ". Known Random POI=" + KnownRandomPOI.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
  ; ObjectReference[] portalNetwork = self.GetRefsLinkedToMe(VEOH_ActivePortal, None)
  ; Int randomPortalIndex = CommonArrayFunctions.GetRandomIndex(portalNetwork.Length);
  ; ObjectReference randomPortal = portalNetwork[randomPortalIndex]
  ; Actor player = Game.GetPlayer()
  ; player.MoveTo(randomPortal, 0.0, 0.0, 0.0, True, False)
EndEvent

Event OnTriggerEnter(ObjectReference akActionRef)
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "OnTriggerEnter", "OnTriggerEnter triggered. Known Portals =" + KnownPortals.GetCount() + ". Known Random POI=" + KnownRandomPOI.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; States
;;;
State Done
EndState

Auto State Waiting
  Event OnTriggerEnter(ObjectReference akActionRef)
    VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_PortalHandlerScript", "WaitingState.OnTriggerEnter", "WaitingState.OnTriggerEnter triggered. Known Portals =" + KnownPortals.GetCount() + ". Known Random POI=" + KnownRandomPOI.GetCount() + ".", 0, Venpi_DebugEnabled.GetValueInt())
    Self.GoToState("Done")
  EndEvent
EndState
