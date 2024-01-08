@echo off

@REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Tools"

@REM Clear Dist DIR
@echo "Clearing and scafolding the Dist dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"

@REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
@echo "Copying the ESM from MO2 into the Dist folder"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"

@REM Use Spriggit to extract record from ESM
@echo "Running Spriggit to extract record from ESM"
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml
