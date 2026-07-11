# Venworks Cave and Encounters Overhaul

## Version 3.0.3 [BETA]

- Create Archives will no longer pull in any existing archives. 

## Version 3.0.2 [BETA]

- Reimplemented the following caves:
  - OEAF001 (Random)
  - OEAF002 (Biome Predators)
  - OEAF003 (Crimson Fleet)
  - OEAF005 (Random)
  - OEAF010 (Large Random)
  - OEAF011 (Large The First)
  - OEAF014 (Large Starborn)
- DSE: Added a faction type and definition for the current planet's biome predator
- Backed out PCM patrol points they are causing an engine crash and the linkref weren't holding. Back to the drawing board.

## Version 3.0.1 [BETA]

- The engine only occasionally processes the enable/disable via papyrus so removing the debug markers. Sorry about that.
- Also all hostile factions are neutral to fliers/predators/prey. This will stop them leaving their encounter to be hunters instead of pirates.

## Version 3.0.0 [BETA]

- Completely redone in SFCK
- Using new custom Dynamic Scenes Manager (If there is interest I may break this out to its own creation for other creator can leverage it)
- This is a beta, I will try to keep change save game safe but no promises. Too much around PCM needs a new universe and don't get be started on save games caching the scripts.

## Version 2.0.12

- To avoid the file conflict that is confusing users, I have moved the Venpi Core RTFP config to that mod but this means you will need to handle its configuration for all mods in one go vs the last in the mod dependency chain. Sorry there is no way you can have you cake and eat it to. This is why I put it in both so you would only need to touch the end of the dependency chain now you will have to deal with it at each step if you need to change something at that level.
