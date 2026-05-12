# Dynamic Scenes Engine:  Story Director

Story Director is a bridge between DSE spawners and the Radiant Quest Engine. This means it shares the same restrictions as the radiant quest engine, the main/whopper being it can only deal with PCM World Spaces not instances (dungeons), clutter, and caves.

The core of Story Director is the DSEController and DSEOverlayTrigger which use story manager events and quests to reconfigure the cell to match the needs of the quest.

PLEASE NOTE: Story Director should not be confused with the DSE Scripted Encounters which are a locally trigger papyrus scripted affair which cannot access any of the power of a quest.
