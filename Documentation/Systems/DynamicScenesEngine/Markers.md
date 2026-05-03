# Dynamic Scenes Engine: Markers

## Placement Markers

### DSEMarkerCenter (DSECenterLocRef) [REQUIRED]

This marker marks the center of the POI no real use other then that. Usually I put a box/cylinder primitive to mark the boundaries of the useable space. SQ_Groups uses this as the default spawn point so needs to be on the ground and clear.

### MapMarker (MapMarkerRefType) [REQUIRED]

This the normal BGS map marker and is required for the player to be able to fast travel and find the POI. You can customize the map marker via override name on the ref alias or DefaultAliasMapMarkerScript.

### XMarkerHeading [REQUIRED]

This the normal BGS XMarker Heading marker and is required for the player move to functionality and to find the POI.

## Scene Markers

These are key area markers for use in quests scenes and spawning. As many as the location will allow should be added.

### DSESceneA1 (DSESceneA1LocRef) - DSESceneA3 (DSESceneA3LocRef)

### DSESceneB1 (DSESceneB1LocRef) - DSESceneB3 (DSESceneB3LocRef)

### DSESceneC1 (DSESceneC1LocRef) - DSESceneC3 (DSESceneC3LocRef)

## Travel Markers

These are key area markers for use in quests scenes and spawning. They are usually where NPCs will move to after spawning at the center marker or in a scene. These are mirrored from the Radiant Engine system, but I really don't see a need for them.

### DSETravelA1 (DSETravelA1LocRef) - DSETravelA3 (DSETravelA3LocRef)

### DSETravelB1 (DSETravelB1LocRef) - DSETravelB3 (DSETravelB3LocRef)

### DSETravelC1 (DSETravelC1LocRef) - DSETravelC3 (DSETravelC3LocRef)

## Important Markers

These are key markers for the quest usually tied to objects

### DSEMarkerSmallImportant (DSEMarkerSmallImportantLocRef)

This is a key quest item for the player to find that reference another location or place to go.

## Spawn Markers

### NPCs

#### Bosses/Leaders

These markers denote where the group's leader would spawn.

#### DSEMarker_Boss (DSEMarkerBossLocRef)

#### DSEMarker_Boss_Mini (DSEMarkerMiniBossLocRef)

### Containers

These markers control where containers are spawned.

#### DSEMarker_Container_Small (DSEContainerSmallLocRef)

#### DSEMarker_Container_Large (DSEContainerLargeLocRef)

#### DSEMarker_Container_Boss (DSEContainerBossLocRef)

### Clutter

These control markers for spawning random clutter objects usually packins

#### Sizing

To be noted, a basic chair and file cabinet are 1m x 1m in game.

#### Floor Clutter

- DSEMarker_Clutter_Floor_T1 (DSELocRefType_Clutter_Floor_T1)
  - Size is 1m by 1m
- DSEMarker_Clutter_Floor_T2 (DSELocRefType_Clutter_Floor_T2)
  - Size is 4m by 4m
- DSEMarker_Clutter_Floor_T3 (DSELocRefType_Clutter_Floor_T3)
  - Size is 8m by 8m
- DSEMarker_Clutter_Floor_T4 (DSELocRefType_Clutter_Floor_T4)
  - Size is 16m by 16m

#### Table/Cabinet Surface Clutter

- DSEMarker_Clutter_Surface_T1 (DSELocRefType_Clutter_Surface_T1)
  - Size is 5cm by 5cm
- DSEMarker_Clutter_Surface_T2 (DSELocRefType_Clutter_Surface_T2)
  - Size is 25cm by 25cm
- DSEMarker_Clutter_Surface_T3 (DSELocRefType_Clutter_Surface_T3)
  - Size is 50cm by 50cm
- DSEMarker_Clutter_Surface_T4 (DSELocRefType_Clutter_Surface_T4)
  - Size is 1m by 1m

#### Outdoor Clutter

- DSEMarker_Clutter_Outdoor_T1 (DSELocRefType_Clutter_Outdoor_T1)
  - Size is 1m by 1m
- DSEMarker_Clutter_Outdoor_T2 (DSELocRefType_Clutter_Outdoor_T2)
  - Size is 4m by 4m
- DSEMarker_Clutter_Outdoor_T3 (DSELocRefType_Clutter_Outdoor_T3)
  - Size is 8m by 8m
- DSEMarker_Clutter_Outdoor_T4 (DSELocRefType_Clutter_Outdoor_T4)
  - Size is 16m by 16m
- DSEMarker_Clutter_Outdoor_T5 (DSELocRefType_Clutter_Outdoor_T5)
  - Size is 32m by 32m
