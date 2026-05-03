ScriptName Venworks:Shared:Inventory Extends ScriptObject hidden


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
Int Function GetItemType(Form baseObject)
  InventoryItemTypes inventoryItemTypes = new InventoryItemTypes

  If (baseObject is Weapon)
    Return inventoryItemTypes.ItemTypeWeapon
  ElseIf baseObject is Armor
    Return inventoryItemTypes.ItemTypeArmor
  ElseIf baseObject is Ammo
    Return inventoryItemTypes.ItemTypeAmmo
  ElseIf baseObject is Book
    Return inventoryItemTypes.ItemTypeBook
  ElseIf baseObject is MiscObject
    Return inventoryItemTypes.ItemTypeMisc
  ElseIf baseObject is Potion
    Return inventoryItemTypes.ItemTypeInjestible
  Else
    LogSeverity severityTable = new LogSeverity
    LogUser(creationName="VenworksShared", moduleName="Inventory", functionName="GetItemType", logMessage="Unknown base object type found for base object " + baseObject + ".", severity=severityTable.Error)
    Return inventoryItemTypes.ItemTypeUnknown
  EndIf
EndFunction
