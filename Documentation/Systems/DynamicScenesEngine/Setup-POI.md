# Dynamic Scenes Engine: Setting up a POI to be useable with Dynamic Scenes Engine

## Required Components

The following activators and statics must present in the scene/packin/poi or DSE will not function. All markers need to be linked via keyword to their parent trigger.

### Scene Manager

Obsoletely necessary, a container, door, activator, book with the matching DSEManager script on it and setup. All markers must be linked to this manager for NPC and Clutter spawning to function at game time.

### Scene Group Markers

You must have 1 at least one scene group but you can currently define as many as you want. The must be linked ref'ed to the manager using the correct keyword.

#### Boss Marker(s)

You must have at least 1 boss marker

#### Minion Marker(s)

You should have at least 2 minion spawn markers

#### Chest Marker(s)

You should have at lease 1 chest marker for spawning the boss chest
