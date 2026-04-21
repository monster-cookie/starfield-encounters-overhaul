# Radiant Quests: Markers

## Placement Markers

### SMMarker_Center [REQUIRED]

This marker marks the center of the POI no real use other then that. Usually I put a box/cylinder primitive to mark the boundaries of the useable space.

### Map Marker [REQUIRED]

This the normal BGS map marker and is required for the player to be able to fast travel and find the POI. You can customize the map marker via override name on the ref alias or DefaultAliasMapMarkerScript.

### XMarkerHeading [REQUIRED]

This the normal BGS xmarker heading and is required for the player move to functionality and find the POI.

## Important Markers

These are key markers for the quest usually tied to objects

### SMMarker_Important_Clue

This is a key quest item for the player to find that reference another location or place to go.

### SMMarker_Important_Container

This is usually boss loot container like a science, military, industrial, creature, etc. But can also be any container with custom injected story/quest loot.

### SMMarker_Important_Corpse

This is usually key quest corpse for injecting story/quest items into.

### SMMarker_Important_Door

This is usually a locked door(s) that need to be opened to proceed.

### SMMarker_Important_Item

This is a key quest item for the player to find

### SMMarker_Important_NPC

This is usually key NPC for injecting story/quest items into for death, quest dialog, etc.

### SMMarker_Important_Terminal

This is a marker for a quest terminal/computer to spawn for the quest.

## Spawn Markers

### NPCs

These markers control where the NPC (Combat and normal) are spawned with a random (5x5) offset. This requires a 5x5 clear area around the marker.

- MCS_SMMarker_Spawn_NPCGroup01
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

- MCS_SMMarker_Clutter_Floor_T1
  - Size is 50cm by 50cm
  - Not sure this can actually be used except maybe a pail or floor mat ????
- MCS_SMMarker_Clutter_Floor_T2
  - Size is 1m by 1m
- MCS_SMMarker_Clutter_Floor_T3
  - Size is 4m by 4m
- MCS_SMMarker_Clutter_Floor_T4
  - Size is 8m by 8m
- MCS_SMMarker_Clutter_Floor_T5
  - Size is 16m by 16m
  - Not sure this can actually be used in most interior cells/buildings

#### Table/Cabinet Surface Clutter

- MCS_SMMarker_Clutter_Surface_T1
  - Size is 5cm by 5cm
- MCS_SMMarker_Clutter_Surface_T2
  - Size is 25cm by 25cm
- MCS_SMMarker_Clutter_Surface_T3
  - Size is 50cm by 50cm
- MCS_SMMarker_Clutter_Surface_T4
  - Size is 1m by 1m

#### Outdoor Clutter

- MCS_SMMarker_Clutter_Outdoor_T1
  - Size is 1m by 1m
- MCS_SMMarker_Clutter_Outdoor_T2
  - Size is 4m by 4m
- MCS_SMMarker_Clutter_Outdoor_T3
  - Size is 8m by 8m
- MCS_SMMarker_Clutter_Outdoor_T4
  - Size is 16m by 16m
- MCS_SMMarker_Clutter_Outdoor_T5
  - Size is 32m by 32m
