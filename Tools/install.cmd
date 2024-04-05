@echo off

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-encounters-overhaul\Tools"

del /s /q "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher\*.*"
rmdir /s /q "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
mkdir "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"

@echo "Deploying Main Archive to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-encounters-overhaul\Dist\VenworksEncountersOverhaul - Main.ba2" "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental"

@echo "Deploying RTFP to MO2 Mod DIR"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-encounters-overhaul\Dist\SFSE\Plugins\RealTimeFormPatcher\VenworksCoreConfig.txt" "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-encounters-overhaul\Dist\SFSE\Plugins\RealTimeFormPatcher\VenworksEncountersOverhaulConfig.txt" "D:\MO2Staging\Starfield_Release\mods\VenworksEncountersOverhaul-Experimental\SFSE\Plugins\RealTimeFormPatcher"
