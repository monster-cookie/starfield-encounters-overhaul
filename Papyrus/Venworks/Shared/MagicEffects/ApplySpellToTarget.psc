ScriptName Venworks:Shared:MagicEffects:ApplySpellToTarget extends ActiveMagicEffect  


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
Spell Property AbilityToApply Auto Const Mandatory


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, Float afMagnitude, Float afDuration)
  LogSeverity severityTable = new LogSeverity
  Actor target = akTarget.GetSelfAsActor()
	target.AddSpell(AbilityToApply, false)
  LogUser(creationName="VenworksShared", moduleName="ApplySpellToTarget", functionName="OnEffectStart", logMessage="Added ability with form ID " + AbilityToApply + " to target with form ID " + target + ".", severity=severityTable.Info)
EndEvent