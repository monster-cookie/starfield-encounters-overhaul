# Dynamic Scenes Engine: Location Subtypes

The story manage script event can take 2 integer values further parsing the results.

## Story Manager Data Packet

Story Manager Data will be:

- Location: Location of this activator
- Ref1: This activator
- Ref2: Currently not used
- Int1: The Location Subtype
- Int2: The Event Subtype

## Location Subtype

These are defined as Global Variables and need to be passed in on the DSETriggerOverlay,

### DSELocationType_Disabled

Don't Send a Subtype, this is integer value -1

### DSELocationType_Any

Not really usable how story manager works, if you want any subtype to be valid then don't put a condition looking for it. This is integer value 0.

### DSELocationType_StorageGeneral

Storage Themed Man Made Clutter, this is integer value 1.

### DSELocationType_StorageFluid

Storage Themed Man Made Clutter, this is integer value 2.

### DSELocationType_Solar

Solar Power Themed Man Made Clutter, this is integer value 3.

### DSELocationType_Industrial

Industrial Themed Man Made Clutter, this is integer value 4.
