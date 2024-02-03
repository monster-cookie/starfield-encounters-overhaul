# Open World Encounters - Changes and Notes

## Spacer Mech Camp
Beta attempt at human "Lairs" to the random open world encounters system. Lairs us a pack-in system instead of world space cells. So they can be placed on any terrain and biome.

- Spawn Conditions:
  - Block Type: OverlayFieldsCrevassesSmall03 [SFBK:002A3773]
- Keywords:
  - System is human occupied
- Type: Lair
- Found In:
  - Biome
    - System - Planet
  
- Description:
  - Small camp with a UC Mech, Tent, and a tree
- Spawns:
  - Spacer Boss
  - Spacer Heavy
  - Spacer Sniper

## Portal
Portal mini game go through and get sent to a random linked portal unless it crashes then you get sent anywhere in the universe.

- Encounter Type: PCM OVerlay
- Spawn Conditions:
  - Block Type: OverlayFieldsFlatLarge03 [SFBK:0028BDEC]
- Keywords:
  - None
- Found In:
  - SYSTEM - Planet - Zone
- Description:
  - Active portal in the center of a small clearing
- Spawns:
  - Spacer Boss
  - Spacer Heavy
  - Spacer Sniper

## Spacer vs Vanguard Battle
2 groups of spacers guarding a corpse(s) and a chest

- Encounter Type: Random Encounter Engine
- Spawn Conditions:
  - BlockType: Any
- Keywords:
  - LocTypeNoHumanPresence = 0
  - LocType_ThemeScience
  - LocType_ThemeMilitary
  - LocType_ThemeShipWreck
- Found In: Any
- Description:
  - Varies but will have 2 groups of spacers guarding a corpse(s) and a chest
- Spawns:
  - Spacer Boss
  - Spacer Charge
  - Spacer Sniper
  - Spacer Assault
