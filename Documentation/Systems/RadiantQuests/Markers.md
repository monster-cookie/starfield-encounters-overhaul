# Radiant Quests: Markers

## Placement Markers

### REOverlayCenter [REQUIRED]

This marker marks the center of the POI no real use other then that. Usually I put a box/cylinder primitive to mark the boundaries of the useable space.

### REOverlayExteriorMarker

### REOverlayInteriorMarker

### MapMarker [REQUIRED]

This the normal BGS map marker and is required for the player to be able to fast travel and find the POI. You can customize the map marker via override name on the ref alias or DefaultAliasMapMarkerScript.

### XMarkerHeading [REQUIRED]

This is required for the player move to functionality and to find the POI.

## Important Markers

These are key markers for the quest usually tied to objects

TODO: Evaluate BGS's use cases

## Spawn Markers

### NPCs

These markers control where the NPC (Combat and normal) are spawned with a random (5x5) offset. This requires a 5x5 clear area around the marker.

- REOverlayLeaderMarker
- MCS_SMMarker_Spawn_NPCGroup02
- MCS_SMMarker_Spawn_NPCGroup03
- MCS_SMMarker_Spawn_NPCGroup04
- MCS_SMMarker_Spawn_NPCGroup05
- MCS_SMMarker_Spawn_NPCGroup06

### Corpses

These markers control where corpses are spawned. Havok will just drop them from T pose resulting with random positioning.

- MCS_SMMarker_Spawn_Corpse_Random
- MCS_SMMarker_Spawn_Corpse_Scientist
- MCS_SMMarker_Spawn_Corpse_Security
- MCS_SMMarker_Spawn_Corpse_Civilian

### Containers

These markers control where containers are spawned.

### Items

- REOverlayMarkerDetail

#### MCS_SMMarker_Container_Clutter

This is a small clutter container like a medkit, toolbox, etc.

#### MCS_SMMarker_Container_Chest

This is a loot container like a chest, contraband case, etc.

#### MCS_SMMarker_Container_Boss

This is a boss loot container like a science, military, industrial, creature, etc.

### Clutter

These control markers for spawning random clutter objects usually packings

#### Sizing

To be noted, a basic chair and file cabinet are 1m x 1m in game.

#### Floor Clutter

- REOverlayMarkerLargeFloor

#### Table/Cabinet Surface Clutter

#### Outdoor Clutter

- REOverlayMarkerLargeGround
