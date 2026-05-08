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
;;; Structs
;;;
Struct FactionDefinition
  Keyword FactionType=None
  {The FactionType for this faction definition}

  ConditionForm DSE_ActorIsTest=None
  {The condition form to use to test if an actor is part of this faction}

  FormList Any=None
  {Form list of actors that spawn actors of any type, this is normally populated by form list injection from the other form lists below}

  FormList Bosses=None
  {Form list of faction actors that are bosses (or officers usually)}

  FormList Minions=None
  {Form list of faction actors that are minions (Assault, Charger, Heavy, Sniper, Support, etc)}

  FormList Robots=None
  {Form list of faction actors that are robots}
EndStruct

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Properties
;;;
Group Configuration
  FactionDefinition[] Property FactionDefinitions Auto Const Mandatory
  {Array for faction definitions, there must be at least 1}
EndGroup

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Private Variables
;;;
Int RemainingWaves=0
Keyword[] KnownFactionTypes
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
  if (availableBosses == None)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Failed to find bosses for " + spawnFaction + " or the fall back of spacers, so aborting and not spawning anything.")
    Return None
  EndIf

  ObjectReference[] bosses = SpawnActorHandler(spawnAtMarkers, availableBosses, minNumberOfBossesToSpawn, maxNumberOfBossesToSpawn, levelModifierTable.Boss, maxOffsetX, maxOffsetY)
  int b = 0
  While (b < bosses.Length)
    ObjectReference boss = bosses[b]
    spawnedActors.Add(boss)
    b += 1
  EndWhile

  ;; Spawn Minions
  FormList availableMinions = GetCorrectMinionList(spawnFaction)
  if (availableMinions == None)
    LogModuleCritical(functionName="SpawnGroup", logMessage="Failed to find minions for " + spawnFaction + " or the fall back of spacers, so aborting and not spawning anything.")
    Return None
  EndIf

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

FactionDefinition Function GetFactionDefinition(Keyword requestedFactionType)
  FactionDefinition foundDefinition=None

  int index = 0
  While (index < FactionDefinitions.Length)
    FactionDefinition definition = FactionDefinitions[index]
    if (definition.FactionType == requestedFactionType)
      return definition
    EndIf
    index += 1
  EndWhile
  Return None
EndFunction

FormList Function GetCorrectMinionList(Keyword requestedFactionType)
  FactionDefinition definition=GetFactionDefinition(requestedFactionType)
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectMinionList", logMessage="Failed to find matching list for FactionType " + requestedFactionType + ", falling back to Spacers.")
    definition=GetFactionDefinition(FactionTypeSpacer)
  EndIf
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectMinionList", logMessage="Failed to find matching list for spacers, Aborting.")
    Return None
  EndIf

  Return definition.Minions
EndFunction

FormList Function GetCorrectBossList(Keyword requestedFactionType)
  FactionDefinition definition=GetFactionDefinition(requestedFactionType)
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectMinionList", logMessage="Failed to find matching list for FactionType " + requestedFactionType + ", falling back to Spacers.")
    definition=GetFactionDefinition(FactionTypeSpacer)
  EndIf
  If (definition == None)
    LogModuleCritical(functionName="GetCorrectMinionList", logMessage="Failed to find matching list for spacers, Aborting.")
    Return None
  EndIf

  Return definition.Bosses
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
