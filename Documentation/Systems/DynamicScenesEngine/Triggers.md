# Dynamic Scenes Engine: Triggers

Like the BGS Radiant Engine, Dynamic Scenes Engine uses a variety of triggers and markers in a POI to redesign the POI to match the story elements needed for a quest/story.

## Story Manager Data Packet

Story Manager Data will be:

- Location: Location of this activator
- Ref1: This activator
- Ref2: Currently not used
- Int1: The Location Subtype
- Int2: The Event Subtype

## Trigger Variants [REQUIRED]

One of these is required in all Scene Manager managed POI and should be in the middle of the POI like SMMarker_Center.

### DSETriggerStoryPOI

This controls contacting the story manager to request a radiant quest (using the DSEEncounterTypeStoryPOI event keyword) for the POI.

### DSETriggerStoryClutter

This controls contacting the story manager to request a radiant quest (using the DSEEncounterTypeStoryClutter event keyword) for the POI.

### DSETriggerStoryCaves

This controls contacting the story manager to request a radiant quest (using the DSEEncounterTypeStoryCaves event keyword) for the POI.

### DSETriggerStoryShip

This controls contacting the story manager to request a radiant quest (using the DSEEncounterTypeStoryShip event keyword) for the POI.

### DSETriggerStorySpace

This controls contacting the story manager to request a radiant quest (using the DSEEncounterTypeStorySpace event keyword) for the POI.
