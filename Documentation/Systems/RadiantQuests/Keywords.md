# Radiant Quests: Keywords

These help Story Manager find appropriate quests to return and the quest aliases find matching items/actors to use.

## Encounter Types [REQUIRED]

One of these is required on a SMTrigger* activator that describes the type of scene and story manager script event rules to use.

### SMEncounterTypeAssault

This is a NPC take over radiant quest that applies to PCM Block Load POI mostly but might work with PCM Cell Reset too (still testing)

### SMEncounterTypeStoryOverlay

This is a story radiant quest that applies to PCM Block Load POI mostly but might work with PCM Cell Reset too (still testing)

### SMEncounterTypeStoryShip

This is near identical to SMEncounterTypeStoryOverlay but because it needs ships landing has additional requirements on the supported POI. Namely a in POI ship landing zone.

### SMEncounterTypeStorySpace

EXPERIMENTAL: This is a story radiant quest that applies to Space cell.

## Location Type [REQUIRED]

Use as many of these as apply to the POI/Location. These are set on the Location record for the WorldSpace (POI) and help the Story Manager find matching quests to use for the location.

### SMLocationTypeCave

This is a cave POI

### SMLocationTypeCamp

This is a small open world POI usually inhabited

### SMLocationTypeDungeon

This is a open world or cave dungeon

### SMLocationTypeNatural

This is a open world POI usually not inhabited

### SMLocationTypeOutpost

This is a open world POI usually inhabited

### SMLocationTypeShipwreck

This is a open world POI featuring a crashed/damaged ship

## Story Themes [REQUIRED]

Use as many of these as apply to the POI/Location. These are set on the Location record for the WorldSpace (POI) and help the Story Manager find matching quests to use for the location.

### SMThemeBattleground

This is a battleground POI

### SMThemeCave

This is a cave POI

### SMThemeCivilian

This is a civilian themed POI

### SMThemeMilitary

This is a military themed POI

### SMThemeMilitaryMech

This is a military mech themed POI

### SMThemeIndustrial

This is a industrial themed POI

### SMThemeScience

This is a science themed POI

### SMThemeScienceDissection

This is a science dissection themed POI

### SMThemeSciencePharmaceutical

This is a science pharmaceutical themed POI
