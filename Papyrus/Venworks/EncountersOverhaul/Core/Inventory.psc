ScriptName Venworks:EncountersOverhaul:Core:Inventory Extends Venworks:EncountersOverhaul:Core:Base:BaseScriptObject hidden


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:EncountersOverhaul:Core:Enumerations
Import Venworks:EncountersOverhaul:Core:Logging


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
    LogUserInformational(moduleName="Inventory", functionName="GetItemType", logMessage="Unknown base object type found for base object " + baseObject + ".")
    Return inventoryItemTypes.ItemTypeUnknown
  EndIf
EndFunction
