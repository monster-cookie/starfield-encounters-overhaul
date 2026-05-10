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

Import Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group FactionTypes
  FormList Property DSE_KnownFactionTypes Auto Const Mandatory

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

Group Autofill
  Venworks:EncountersOverhaul:DynamicScenesEngine:Helpers:SQ_DSE_FactionConfiguration Property SQ_DSE_FactionConfiguration Auto Const Mandatory
  {Handler Script for the DSE Faction System}
EndGroup


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Variables
;;;
Int RemainingWaves=0
Actor Player=None
ObjectReference PlayerRef=None

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Events
;;;
Event OnInit()
  Player = Game.GetPlayer()
  PlayerRef = Game.GetPlayer() as ObjectReference
EndEvent


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions
;;;
ObjectReference[] Function SpawnGroup(SpawnGroupDefinition groupDefinition, ObjectReference[] spawnBossMarkers, Int minNumberOfBossesToSpawn, Int maxNumberOfBossesToSpawn, ObjectReference[] spawnMinionMarkers, Int minNumberOfMinionsToSpawn, Int maxNumberOfMinionsToSpawn, Float maxOffsetX=0.00, Float maxOffsetY=0.00)
  LevelModifier levelModifierTable = new LevelModifier

  If (groupDefinition.GroupFaction == FactionTypeRandom)
    Int factionIndex = Utility.RandomInt(0, DSE_KnownFactionTypes.GetSize()-1)
    groupDefinition.GroupFaction = DSE_KnownFactionTypes.GetAt(factionIndex) as Keyword
  EndIf

  If (maxNumberOfBossesToSpawn == 0 && maxNumberOfMinionsToSpawn == 0)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Spawner configuration is set to not spawn any NPCs or Bosses.")
    Return None
  EndIf

  If (SQ_DSE_FactionConfiguration.GetCorrectBossList(requestedFactionType=groupDefinition.GroupFaction).GetSize() <= 0 || SQ_DSE_FactionConfiguration.GetCorrectMinionList(requestedFactionType=groupDefinition.GroupFaction).GetSize() <= 0)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Either Bosses or Minions is not properly setup in the Faction Definition so falling back to Spacers.")
    groupDefinition.GroupFaction = FactionTypeSpacer
  EndIf

  FactionDefinition factionDefinition=SQ_DSE_FactionConfiguration.GetFactionDefinition(requestedFactionType=groupDefinition.GroupFaction)

  ;; Handle Group's random chance to spawn

  ObjectReference[] spawnedActors = new ObjectReference[0]

  ;; Spawn Bosses
  FormList availableBosses = SQ_DSE_FactionConfiguration.GetCorrectBossList(requestedFactionType=groupDefinition.GroupFaction)
  if (availableBosses == None)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Failed to find bosses for " + groupDefinition.GroupFaction + " so aborting and not spawning anything.")
    Return None
  EndIf

  ObjectReference[] bosses = SpawnActorHandler(spawnBossMarkers, availableBosses, minNumberOfBossesToSpawn, maxNumberOfBossesToSpawn, levelModifierTable.Boss, maxOffsetX, maxOffsetY)
  int b = 0
  While (b < bosses.Length)
    If (groupDefinition.BossesChanceToSpawn.IsTrue())
      ObjectReference boss = bosses[b]
      spawnedActors.Add(boss)
      LogModuleInformational(functionName="", logMessage="Spawned boss " + b+1 + " as " + boss + ".")
    Else 
      LogModuleInformational(functionName="", logMessage="Prevented from spawning boss " + b+1 + " due to random chance.")
    EndIf
    b += 1
  EndWhile

  ;; Spawn Minions
  FormList availableMinions = SQ_DSE_FactionConfiguration.GetCorrectMinionList(requestedFactionType=groupDefinition.GroupFaction)
  If (availableMinions == None)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Failed to find minions for " + groupDefinition.GroupFaction + " so aborting and not spawning anything.")
    Return None
  EndIf

  ObjectReference[] minions = SpawnActorHandler(spawnMinionMarkers, availableMinions, minNumberOfMinionsToSpawn, maxNumberOfMinionsToSpawn, levelModifierTable.Random, maxOffsetX, maxOffsetY)
  int m = 0
  While (m < minions.Length)
    If (groupDefinition.MinionsChanceToSpawn.IsTrue())
      ObjectReference minion = bosses[m]
      spawnedActors.Add(minion)
      LogModuleInformational(functionName="", logMessage="Spawned minion " + m+1 + " as " + minion + ".")
    Else 
      LogModuleInformational(functionName="", logMessage="Prevented from spawning minion " + m+1 + " due to random chance.")
    EndIf
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
