ScriptName Venworks:EncountersOverhaul:DynamicScenesEngine:Data:Enumerations Extends Venworks:Shared:Enumerations Hidden


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

  FormList ChestsBoss=None
  {Form list of faction setup boss loot chests - looks and loot should be factored in to make sense}

  FormList ChestsLarge=None
  {Form list of faction setup large loot chests - looks and loot should be factored in to make sense}
EndStruct

Struct SpawnGroupDefinition
  Keyword GroupFaction=None
  {The faction to spawn for this group definition}

  ConditionForm BossesChanceToSpawn=None
  {The condition form to test to see if the encounter should spawn bosses}

  Int BossesMinToSpawn=1
  {Minimum number of bosses to spawn, do not use 0 it forces 0 NPCs as the random number generator stinks.}

  Int BossesMaxToSpawn=1
  {Maximum number of bosses to spawn}

  ConditionForm MinionsChanceToSpawn=None
  {The condition form to test to see if the encounter should spawn minions}
  
  Int MinionsMinToSpawn=2
  {Minimum number of NPCs to spawn, do not use 0 it forces 0 NPCs as the random number generator stinks.}

  Int MinionsMaxToSpawn=4
  {Maximum number of NPCs to spawn}

  Keyword LinkRefKeywordForBossSpawnPoints=None
  {The target, usually a marker or activator, that all spawn groups are linked to via reference keyword (See DSELinkedRef_Marker_Scene*_Minion keywords in the autofill group)}

  Keyword LinkRefKeywordForMinionSpawnPoints=None
  {The target, usually a marker or activator, that all spawn groups are linked to via reference keyword (See DSELinkedRef_Marker_Scene*_Boss keywords in the autofill group)}

  Keyword LinkRefKeywordForChestSpawnPoints=None
  {The target, usually a marker, that all chest markers are linked to via reference keyword (See DSELinkedRef_Marker_Scene*_Chest keywords in the autofill group)}
EndStruct

;; There should be DSE_SpawnerType global variables for these too
Struct SpawnerMode
  Int Normal=0
  Int Waves=1
  Int Timer=2
EndStruct

;; There should be DSE_SpawnerType global variables for these too
Struct SpawnerType
  Int CellLoad=0
  Int OnClose=1
  Int OnOpen=2
  Int OnRead=3
  Int OnTriggerEnter=4
  Int OnTriggerLeave=5
EndStruct
