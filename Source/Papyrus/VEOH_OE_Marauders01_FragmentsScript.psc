ScriptName VEOH_OE_Marauders01_FragmentsScript Extends Quest

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
ReferenceAlias Property Alias_AttackerA1 Auto Const mandatory
; ReferenceAlias Property Alias_AttackerA2 Auto Const mandatory
ReferenceAlias Property Alias_AttackerA3 Auto Const mandatory
ReferenceAlias Property Alias_AttackerB1 Auto Const mandatory
; ReferenceAlias Property Alias_AttackerB2 Auto Const mandatory
ReferenceAlias Property Alias_AttackerB3 Auto Const mandatory
ReferenceAlias Property Alias_Corpse Auto Const mandatory
LeveledItem Property BonusLoot Auto Const mandatory
ReferenceAlias Property Alias_Chest Auto Const mandatory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Variables
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Fragments
;;;
Function Fragment_Stage_0100_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0100_Item_00", "Stage 100 triggered - Player in range, so populating chest and corpse.", 0, Venpi_DebugEnabled.GetValueInt())
  Quest __temp = Self as Quest
  DefaultGroupSpawnQuestScript kmyQuest = __temp as DefaultGroupSpawnQuestScript
  Int Chance = Utility.RandomInt(1, 8)
  If (Chance == 4)
    Alias_Corpse.GetRef().AddItem(BonusLoot as Form, 1, False)
  ElseIf (Chance == 1)
    Alias_Chest.GetRef().AddItem(BonusLoot as Form, 1, False)
  EndIf
EndFunction

Function Fragment_Stage_0150_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0150_Item_00", "Stage 150 triggered - Player in range of corpse, so setting stage 200 to spawn group A.", 0, Venpi_DebugEnabled.GetValueInt())
  Self.SetStage(200)
EndFunction

Function Fragment_Stage_0200_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0200_Item_00", "Stage 200 triggered - Spawning Group A.", 0, Venpi_DebugEnabled.GetValueInt())
  Actor AttackerA1 = Alias_AttackerA1.GetActorRef()
  AttackerA1.Enable(False)
  AttackerA1.EvaluatePackage(False)
  ; Actor AttackerA2 = Alias_AttackerA2.GetActorRef()
  ; AttackerA2.Enable(False)
  ; AttackerA2.EvaluatePackage(False)
  Actor AttackerA3 = Alias_AttackerA3.GetActorRef()
  AttackerA3.Enable(False)
  AttackerA3.EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0250_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0250_Item_00", "Stage 250 triggered - Player in range of chest, so setting stage 300 to spawn group B.", 0, Venpi_DebugEnabled.GetValueInt())
  Self.SetStage(300)
EndFunction

Function Fragment_Stage_0300_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0300_Item_00", "Stage 300 triggered - Spawning Group B.", 0, Venpi_DebugEnabled.GetValueInt())
  Actor AttackerB1 = Alias_AttackerB1.GetActorRef()
  AttackerB1.Enable(False)
  AttackerB1.EvaluatePackage(False)
  ; Actor AttackerB2 = Alias_AttackerB2.GetActorRef()
  ; AttackerB2.Enable(False)
  ; AttackerB2.EvaluatePackage(False)
  Actor AttackerB3 = Alias_AttackerB3.GetActorRef()
  AttackerB3.Enable(False)
  AttackerB3.EvaluatePackage(False)
EndFunction

Function Fragment_Stage_0400_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0400_Item_00", "Stage 400 triggered - If stage 300 didn't happen trigger it.", 0, Venpi_DebugEnabled.GetValueInt())
  If !Self.GetStageDone(200)
    Self.SetStage(200)
  EndIf
  If !Self.GetStageDone(300)
    Self.SetStage(300)
  EndIf
EndFunction

Function Fragment_Stage_0500_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0500_Item_00", "Stage 500 triggered - If stage 300 didn't happen trigger it.", 0, Venpi_DebugEnabled.GetValueInt())
  If !Self.GetStageDone(200)
    Self.SetStage(200)
  EndIf
  If !Self.GetStageDone(300)
    Self.SetStage(300)
  EndIf
EndFunction

Function Fragment_Stage_0999_Item_00()
  VPI_Debug.DebugMessage(Venpi_ModName, "VEOH_OE_Marauders01_FragmentsScript", "Fragment_Stage_0999_Item_00", "Stage 999 triggered - Random Encounter Complete.", 0, Venpi_DebugEnabled.GetValueInt())
  Self.CompleteAllObjectives()
EndFunction
