ScriptName Venworks:Shared:Utilities:Array
{Misc utility functions for handling arrays.}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Logging


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
ObjectReference Function GetRandomObjectFromArray(ObjectReference[] arrayToParse) Global
  int randomIndex = Utility.RandomInt(0, arrayToParse.Length-1)
  return arrayToParse[randomIndex]
EndFunction