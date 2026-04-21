# Radiant Quests: Location Reference Types

TODO: This is heavily MCS Scene Manager, need to revert back to BGS Story Manager only

These are needed for the quest alias system to find specific items in a location/worldspace/cell. They often have a matching keyword.

NOTE: Just like Cells/WorldSpaces they cannot have underscores or dashes in their name.

## Placement Location References

### SMLocRef_Trigger [REQUIRED]

This is linked to the MCS_SMTrigger* triggers.

### SMLocRef_Marker_Center [REQUIRED]

This is a LocRef linking the center marker to the POI's location.

## Important Location References

- SMLocRef_Marker_Important_Clue
- SMLocRef_Marker_Important_Container
- SMLocRef_Marker_Important_Corpse
- SMLocRef_Marker_Important_Door
- SMLocRef_Marker_Important_Item
- SMLocRef_Marker_Important_NPC
- SMLocRef_Marker_Important_Terminal

## Spawn Location References

### NPCs

- SMLocRef_Marker_Spawn_NPCGroup01
- SMLocRef_Marker_Spawn_NPCGroup02
- SMLocRef_Marker_Spawn_NPCGroup03
- SMLocRef_Marker_Spawn_NPCGroup04
- SMLocRef_Marker_Spawn_NPCGroup05
- SMLocRef_Marker_Spawn_NPCGroup06

### Corpses

- SMLocRef_Marker_Spawn_Corpse_Random
- SMLocRef_Marker_Spawn_Corpse_Scientist
- SMLocRef_Marker_Spawn_Corpse_Security
- SMLocRef_Marker_Spawn_Corpse_Civilian

### Containers

- SMLocRef_Marker_Container_Boss
- SMLocRef_Marker_Container_Chest
- SMLocRef_Marker_Container_Clutter

### Clutter

#### Floor Clutter

- SMLocRef_Marker_Clutter_Floor_T1
- SMLocRef_Marker_Clutter_Floor_T2
- SMLocRef_Marker_Clutter_Floor_T3
- SMLocRef_Marker_Clutter_Floor_T4
- SMLocRef_Marker_Clutter_Floor_T5

#### Table/Cabinet Surface Clutter

- SMLocRef_Marker_Clutter_Surface_T1
- SMLocRef_Marker_Clutter_Surface_T2
- SMLocRef_Marker_Clutter_Surface_T3
- SMLocRef_Marker_Clutter_Surface_T4

#### Outdoor Clutter

- SMLocRef_Marker_Clutter_Outdoor_T1
- SMLocRef_Marker_Clutter_Outdoor_T2
- SMLocRef_Marker_Clutter_Outdoor_T3
- SMLocRef_Marker_Clutter_Outdoor_T4
- SMLocRef_Marker_Clutter_Outdoor_T5
