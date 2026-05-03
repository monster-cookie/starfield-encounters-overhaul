ScriptName Venworks:Shared:AliasHelpers:AliasEnableDisableToggleOnLoad extends ObjectReference
{Toggles between enabling and disabling this object based on a global variable}


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
Group Configuration Collapsed
  GlobalVariable Property EnablementGlobal Auto Const Mandatory
  {This global when set >0 enables the referenced object otherwise it disables it}
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; States
;;;
Auto State Waiting
  Event OnLoad()
    LogSeverity severityTable = new LogSeverity
    LogUser(creationName="VenworksShared", moduleName="EnableDisableToggleOnLoad", functionName="OnLoad", logMessage="OnLoad triggered.", severity=severityTable.Info)
    Int enablementGlobalValueInt = EnablementGlobal.GetValueInt()
    bool enableObject = enablementGlobalValueInt > 0
    
    If (enableObject)
      LogUser(creationName="VenworksShared", moduleName="EnableDisableToggleOnLoad", functionName="OnLoad", logMessage="Enabling object " + self + ".", severity=severityTable.Info)
      self.Enable()
    Else
      LogUser(creationName="VenworksShared", moduleName="EnableDisableToggleOnLoad", functionName="OnLoad", logMessage="Disabling object " + self + ".", severity=severityTable.Info)
      self.Disable()
    EndIf
  EndEvent
EndState

State DoneWaiting
	; Do Nothing
EndState