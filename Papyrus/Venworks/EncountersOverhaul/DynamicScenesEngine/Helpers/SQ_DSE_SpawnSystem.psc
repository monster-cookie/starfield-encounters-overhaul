ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_SpawnSystem Extends Venworks:EncountersOverhaul:Base:BaseQuest
{
  This is a handler script for managing the spawn of DSE NPCs both hostile and friendly
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Imports
;;;
Import Venworks:Shared:Enumerations
Import Venworks:Shared:Utilities:Array


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group FactionTypes
  Keyword Property FactionTypeRandom Auto Const Mandatory
  Keyword Property FactionTypeCrimsonFleet Auto Const Mandatory
  Keyword Property FactionTypeEcliptic Auto Const Mandatory
  Keyword Property FactionTypeHouseVaruun Auto Const Mandatory
  Keyword Property FactionTypeSiren Auto Const Mandatory
  Keyword Property FactionTypeSpacer Auto Const Mandatory
  Keyword Property FactionTypeStarborn Auto Const Mandatory
  Keyword Property FactionTypeSyndicate Auto Const Mandatory
  Keyword Property FactionTypeTerrormorph Auto Const Mandatory
  Keyword Property FactionTypeTheFirst Auto Const Mandatory
EndGroup

Group ActorTypeConditionForms
  ConditionForm Property DSE_ActorIsCreature Auto Const Mandatory
  ConditionForm Property DSE_ActorIsCritter Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHeatleech Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHuman Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndCrimsonFleet Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndEcliptic Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndHouseVaruun Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndSpacer Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndStarborn Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndSyndicate Auto Const Mandatory
  ConditionForm Property DSE_ActorIsHumanAndTheFirst Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobot Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndCrimsonFleet Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndEcliptic Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndHouseVaruun Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndSpacer Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndStarborn Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndSyndicate Auto Const Mandatory
  ConditionForm Property DSE_ActorIsRobotAndTheFirst Auto Const Mandatory
EndGroup

Group AvailableActors
  FormList Property DSE_CrimsonFleet_AvailableBosses Auto Const Mandatory
  FormList Property DSE_CrimsonFleet_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Ecliptic_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Ecliptic_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_HouseVaruun_AvailableBosses Auto Const Mandatory
  FormList Property DSE_HouseVaruun_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Siren_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Siren_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Spacer_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Spacer_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Starborn_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Starborn_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Syndicate_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Syndicate_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_Terrormorph_AvailableBosses Auto Const Mandatory
  FormList Property DSE_Terrormorph_AvailableNPCs Auto Const Mandatory

  FormList Property DSE_TheFirst_AvailableBosses Auto Const Mandatory
  FormList Property DSE_TheFirst_AvailableNPCs Auto Const Mandatory
EndGroup

Group OtherAutofill Collapsed
  ObjectReference Property PlayerRef Auto Const Mandatory
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Variables
;;;
Int RemainingWaves=0
Keyword[] KnownFactionTypes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnInit()
  KnownFactionTypes = new Keyword[0]
  KnownFactionTypes.Add(FactionTypeCrimsonFleet)
  KnownFactionTypes.Add(FactionTypeEcliptic)
  KnownFactionTypes.Add(FactionTypeHouseVaruun)
  KnownFactionTypes.Add(FactionTypeSpacer)
  KnownFactionTypes.Add(FactionTypeStarborn)
  KnownFactionTypes.Add(FactionTypeSyndicate)
  KnownFactionTypes.Add(FactionTypeTheFirst)

  ; KnownFactionTypes.Add(FactionTypeSiren)
  ; KnownFactionTypes.Add(FactionTypeTerrormorph)
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
ObjectReference[] Function SpawnGroup(Keyword spawnFaction, ObjectReference[] spawnAtMarkers, Int minNumberOfBossesToSpawn, Int maxNumberOfBossesToSpawn, Int minNumberOfMinionsToSpawn, Int maxNumberOfMinionsToSpawn, Float maxOffsetX=0.00, Float maxOffsetY=0.00)
  LevelModifier levelModifierTable = new LevelModifier

  If (maxNumberOfBossesToSpawn == 0 && maxNumberOfMinionsToSpawn == 0)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Spawner configuration is set to not spawn any NPCs or Bosses.")
    Return None
  EndIf

  ObjectReference[] spawnedActors = new ObjectReference[0]

  If (spawnFaction == FactionTypeRandom)
    Int factionIndex = Utility.RandomInt(0, KnownFactionTypes.Length)
    spawnFaction = KnownFactionTypes[factionIndex]
  EndIf

  ;; Spawn Bosses
  FormList availableBosses = GetCorrectBossList(spawnFaction)
  ObjectReference[] bosses = SpawnActorHandler(spawnAtMarkers, availableBosses, minNumberOfBossesToSpawn, maxNumberOfBossesToSpawn, levelModifierTable.Boss, maxOffsetX, maxOffsetY)
  int b = 0
  While (b < bosses.Length)
    ObjectReference boss = bosses[b]
    spawnedActors.Add(boss)
    b += 1
  EndWhile

  ;; Spawn Minions
  FormList availableMinions = GetCorrectNPCList(spawnFaction)
  ObjectReference[] minions = SpawnActorHandler(spawnAtMarkers, availableMinions, minNumberOfMinionsToSpawn, maxNumberOfMinionsToSpawn, levelModifierTable.Random, maxOffsetX, maxOffsetY)
  int m = 0
  While (m < minions.Length)
    ObjectReference minion = bosses[m]
    spawnedActors.Add(minion)
    m += 1
  EndWhile

  Return spawnedActors
EndFunction

ObjectReference[] Function SpawnActorHandler(ObjectReference[] spawnAtMarkers, FormList availableActors, int minNumberToSpawn=1, int maxNumberToSpawn=1, Int actorLevelModifier = -1, Float maxOffsetX=0.00, Float maxOffsetY=0.00)
  LevelModifier levelModifierTable = new LevelModifier

  Int numberToSpawn = Utility.RandomInt(minNumberToSpawn, maxNumberToSpawn)
  If (numberToSpawn <= 0)
    LogModuleCritical(functionName="SpawnActorHandler", logMessage="Currently set to not spawn any actors from available actors pool (" + availableActors +")")
    Return None
  ElseIf (availableActors.GetSize() <= 0)
    LogModuleCritical(functionName="SpawnActorHandler", logMessage="Currently there are no actors in the available actors pool (" + availableActors +")")
    Return None
  EndIf
  LogModuleInformational(functionName="SpawnActorHandler", logMessage="Currently planning to spawn " + numberToSpawn + " actor(s) from the available actors pool (" + availableActors +") for the pool of markers.")

  int a = 0
  ObjectReference[] spawnedActors = new ObjectReference[numberToSpawn]
  While (a < numberToSpawn)
    LogModuleInformational(functionName="SpawnActorHandler", logMessage="Spawning " + a + " of " + numberToSpawn + " actors.")

    Int randomIndexActors = Utility.RandomInt(0, availableActors.GetSize() - 1)
    ActorBase randomActorToSpawn = availableActors.GetAt(randomIndexActors) as ActorBase

    If (actorLevelModifier == levelModifierTable.Random || actorLevelModifier == levelModifierTable.Disabled)
      actorLevelModifier = Utility.RandomInt(0, 3)
    EndIf

    ObjectReference spawnAtMarker = GetRandomObjectFromArray(spawnAtMarkers)
    LogModuleInformational(functionName="SpawnActorHandler", logMessage="Currently planning to spawn actor " + randomActorToSpawn + " at spawn marker " + spawnAtMarker + " using level modifier " + actorLevelModifier + ".")
    Actor spawnedActor = SpawnLeveledActor(spawnAtMarker=spawnAtMarker, actorToSpawn=randomActorToSpawn, actorLevelMod=actorLevelModifier, mustPersist=true, maxOffsetX=maxOffsetX, maxOffsetY=maxOffsetY)
    spawnedActors[a] = spawnedActor as ObjectReference
    a += 1
  EndWhile

  Return spawnedActors
EndFunction

Actor Function SpawnLeveledActor(ObjectReference spawnAtMarker, ActorBase actorToSpawn, int actorLevelMod=2, bool mustPersist=true, Float maxOffsetX=0.00, Float maxOffsetY=0.00)
  Actor spawnedActor = None
  if (maxOffsetX == 0 && maxOffsetY == 0)
    LogModuleInformational(functionName="SpawnLeveledActor", logMessage="Spawning actor (" + actorToSpawn + ") at spawn marker (" + spawnAtMarker + ").")
    spawnedActor = spawnAtMarker.PlaceActorAtMe(actorToSpawn, actorLevelMod, spawnAtMarker.GetCurrentLocation(), mustPersist, true, true, None, true)
  Else
    Float[] offsetValues = new float[6]
    offsetValues[0] = Utility.RandomFloat(0,maxOffsetX) ;; Position X coordinate
    offsetValues[1] = Utility.RandomFloat(0,maxOffsetY) ;; Position Y coordinate
    offsetValues[2] = 0 ;; Position Z coordinate
    offsetValues[3] = 0 ;; Rotation X axis
    offsetValues[4] = 0 ;; Rotation Y axis
    offsetValues[5] = Utility.RandomFloat(0,360) ;; Rotation Z axis
    spawnedActor = spawnAtMarker.PlaceActorAtMe(actorToSpawn, actorLevelMod, spawnAtMarker.GetCurrentLocation(), mustPersist, true, true, offsetValues, true)
  EndIf
  If (spawnedActor == None)
    LogModuleError(functionName="SpawnLeveledActor", logMessage="No actor was spawned. Aborting, please check the logs")
    return None
  EndIf
  
  spawnedActor.enable() ;; Enable it again now that everything is reconfigured
  return spawnedActor
EndFunction

FormList Function GetCorrectNPCList(Keyword requestedFactionType)
  FormList listToUse = None
  If (requestedFactionType == FactionTypeCrimsonFleet)
    listToUse = DSE_CrimsonFleet_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeEcliptic)
    listToUse = DSE_Ecliptic_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeHouseVaruun)
    listToUse = DSE_HouseVaruun_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeSiren)
    listToUse = DSE_Siren_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeSpacer)
    listToUse = DSE_Spacer_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeStarborn)
    listToUse = DSE_Starborn_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeSyndicate)
    listToUse = DSE_Syndicate_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeTerrormorph)
    listToUse = DSE_Terrormorph_AvailableNPCs
  ElseIf (requestedFactionType == FactionTypeTheFirst)
    listToUse = DSE_TheFirst_AvailableNPCs
  Else
    LogModuleCritical(functionName="GetCorrectNPCList", logMessage="Currently do not handle FactionType " + requestedFactionType + ".")
  EndIf

  If (listToUse == None)
    LogModuleCritical(functionName="GetCorrectNPCList", logMessage="Failed to find matching list for FactionType " + requestedFactionType + ", falling back to Spacers.")
    listToUse = DSE_Spacer_AvailableNPCs
  EndIf

  Return listToUse
EndFunction

FormList Function GetCorrectBossList(Keyword requestedFactionType)
  FormList listToUse = None
  If (requestedFactionType == FactionTypeCrimsonFleet)
    listToUse = DSE_CrimsonFleet_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeEcliptic)
    listToUse = DSE_Ecliptic_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeHouseVaruun)
    listToUse = DSE_HouseVaruun_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeSiren)
    listToUse = DSE_Siren_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeSpacer)
    listToUse = DSE_Spacer_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeStarborn)
    listToUse = DSE_Starborn_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeSyndicate)
    listToUse = DSE_Syndicate_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeTerrormorph)
    listToUse = DSE_Terrormorph_AvailableBosses
  ElseIf (requestedFactionType == FactionTypeTheFirst)
    listToUse = DSE_TheFirst_AvailableBosses
  Else
    LogModuleCritical(functionName="GetCorrectBossList", logMessage="Currently do not handle FactionType " + requestedFactionType + ".")
  EndIf

  If (listToUse == None)
    LogModuleCritical(functionName="GetCorrectBossList", logMessage="Failed to find matching list for FactionType " + requestedFactionType + ", falling back to Spacers.")
    listToUse = DSE_Spacer_AvailableBosses
  EndIf

  Return listToUse
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions - Logging Helpers
;;;

Function LogModuleInformational(String functionName, String logMessage)
  LogUserInformational(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:SQ_DSE_SpawnSystem", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleWarning(String functionName, String logMessage)
  LogUserWarning(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:SQ_DSE_SpawnSystem", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleError(String functionName, String logMessage)
  LogUserError(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:SQ_DSE_SpawnSystem", functionName=functionName, logMessage=logMessage)
EndFunction

Function LogModuleCritical(String functionName, String logMessage)
  LogUserCritical(moduleName="Venworks:EncountersOverhaul:DynamicScenesEngine:SQ_DSE_SpawnSystem", functionName=functionName, logMessage=logMessage)
EndFunction
