@echo off

@REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Tools"

@REM Clear Dist DIR
@echo "Clearing and scafolding the Dist dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"

@REM Clear Dist DIR
@echo "Clearing and scafolding the Dist-CCMBH-Patch dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"

@REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
@echo "Copying the ESM from MO2 into the Dist folder"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"

@REM Use Spriggit to extract record from ESM
@echo "Running Spriggit to extract record from ESM"
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-CCMBH-Patch-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml
