# Dynamic Scenes Engine: Scripted Encounters

This needs all of the DSE POI setup so make sure those instructions are completed. You will also need a lot more markers so this will not work for all clutter/caves.

At is core you will use a custom extended DSE Manager (usually OnTriggerEnter, but OnOpen/OnRead are common too).

You will need to override the HandlerTrigger() function and start scripting out your scene, spawning needed NPC groups, clutter, key elements like terminals/chests. Scripted encounters are more about a scene layout then having the player do stuff. For a more advanced setup you need to use DSE Story Director which utilizes the quest engine so way more power to make the player do stuff.
