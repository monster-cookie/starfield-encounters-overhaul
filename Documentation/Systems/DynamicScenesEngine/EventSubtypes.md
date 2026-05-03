# Dynamic Scenes Engine: Event Subtypes

The story manage script event can take 2 integer values further parsing the results.

## Story Manager Data Packet

Story Manager Data will be:

- Location: Location of this activator
- Ref1: This activator
- Ref2: Currently not used
- Int1: The Location Subtype
- Int2: The Event Subtype

## Event Subtypes

These are defined as Global Variables and need to be passed in on the DSETriggerOverlay,

### DSEEventType_Disabled

Don't Send a Subtype, this is integer value -1

### DSEEventType_Any

Not really usable how story manager works, if you want any subtype to be valid then don't put a condition looking for it. This is integer value 0.

### Man Made Clutter Packings

#### DSEEventType_Clutter_Small

This is a small man made clutter packin, really can only spawn 1 group of NPCs. This is integer value 1.

#### DSEEventType_Clutter_Medium

This is a medium man made clutter packin, really can spawn 2 groups of NPCs. This is integer value 2.

#### DSEEventType_Clutter_Large  (3) = Large Clutter

This is a large man made clutter packin, really can spawn 3 groups of NPCs safely. This is integer value 3.

### Caves

#### DSEEventType_Cave_Small

This is a small cave cell, that really can only spawn 1 group of NPCs. This is integer value 4.

#### DSEEventType_Cave_Medium

This is a medium sized cave cell, that can safely spawn 2 group of NPCs. This is integer value 5.

#### DSEEventType_Cave_Large

This is a large sized cave cell, that can safely spawn 3 group of NPCs. This is integer value 6.
