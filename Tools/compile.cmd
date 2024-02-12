@echo off

@REM Get Caprica from https://github.com/Orvid/Caprica currently installed is old manual compile -- v0.3.0 causes a io stream failure

@REM Notepad++/VSCODE needs current working directory to be where Caprica.exe is 
cd "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Tools"

@REM Clear Dist DIR
@echo "Clearing and scafolding the Dist dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\Strings"

@REM Clear Dist-CCMBH-Patch DIR
@echo "Clearing and scafolding the Dist-CCMBH-Patch dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"

@REM Clear Dist-Grindterra-Patch DIR
@echo "Clearing and scafolding the Dist-Grindterra-Patch dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-Grindterra-Patch\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-Grindterra-Patch"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-Grindterra-Patch"

@REM Clear Dist-BA2-Main DIR
@echo "Clearing and scafolding the Dist-BA2-Main dir"
del /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\*.*"
rmdir /s /q "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\Scripts\"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\terrain\"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\lodsettings\"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects\"
mkdir "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VEOH_SpacerMechCamp_World\objects\"

@REM Compile and deploy Scripts to Dist-BA2-Main folder
@echo "Compiling all script in Source/Papyrus to Dist-BA2-Main folder"
"D:\Program Files\PexTools\Caprica-0.3.0.exe" --game starfield --import "C:\Repositories\Public\Starfield-Script-Source;C:\Repositories\Public\Starfield Mods\starfield-venpi-core\Source\Papyrus;C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Papyrus" --output "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\Scripts" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Papyrus" -R -q && (
  @echo "Compile all scripts has successfully compiled"
  (call )
) || (
  @echo "Error:  Compile all scripts has failed to compile <======================================="
  exit /b 1
)

@REM Deploy LOD to Dist-BA2-Main folder
@echo "Deploy LOD to Dist-BA2-Main folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\LOD\VCOH_GhostCave_World.lod" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\lodsettings"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\LOD\VEOH_ActivePortalCrater_World.lod" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\lodsettings"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\LOD\VEOH_SpacerMechCamp_World.lod" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\lodsettings"

@REM Deploy Meshes to Dist-BA2-Main folder
@echo "Deploy Meshes (VCOH_GhostCave_World) to Dist-BA2-Main folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VCOH_GhostCave_World.1.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VCOH_GhostCave_World.2.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VCOH_GhostCave_World.4.-2.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VCOH_GhostCave_World.8.-2.-4.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"

@echo "Deploy Meshes (VEOH_ActivePortalCrater_World) to Dist-BA2-Main folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.1.-1.-1.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.1.-1.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.1.0.-1.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.1.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.2.-2.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.2.-2.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.2.0.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.2.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.4.-2.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_ActivePortalCrater_World.8.-2.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VCOH_GhostCave_World\objects"

@echo "Deploy Meshes (VEOH_SpacerMechCamp_World) to Dist-BA2-Main folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_SpacerMechCamp_World.1.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VEOH_SpacerMechCamp_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_SpacerMechCamp_World.2.0.0.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VEOH_SpacerMechCamp_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_SpacerMechCamp_World.4.-2.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VEOH_SpacerMechCamp_World\objects"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Meshes\VEOH_SpacerMechCamp_World.8.-2.-2.nif" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\meshes\terrain\VEOH_SpacerMechCamp_World\objects"

@REM Deploy Terrain to Dist-BA2-Main folder
@echo "Deploy Terrain to Dist-BA2-Main folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Terrain\VCOH_GhostCave_World.btd" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\terrain"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Terrain\VEOH_ActivePortalCrater_World.btd" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\terrain"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Terrain\VEOH_SpacerMechCamp_World.btd" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\terrain"

@REM Extract English Strings from xedit, so need to pull from starfield dir where xedit has to have it
@echo "Extract English Strings from xEdit and adding to Source and Dist folders"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.DLSTRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Localization"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.ILSTRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Localization"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.STRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\Localization"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.DLSTRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\Strings"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.ILSTRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\Strings"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\Strings\VenpiCaveOverhaul_En.STRINGS" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist\Strings"

@REM ESM is purely binary so need to pull from starfield dir where xedit has to have it 
@echo "Copying the ESM from xEdit and adding to Source and Dist folders"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"

copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-CCMBH-Patch"

copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-GrindTerraFactions-Patch-Experimental\VenpiCaveOverhaul-GrindTerraFactions-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM"
copy /y "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-GrindTerraFactions-Patch-Experimental\VenpiCaveOverhaul-GrindTerraFactions-Patch.esm" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-Grindterra-Patch"

@REM Use Spriggit to extract record from ESM
@echo "Running Spriggit to extract record from ESM"
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-Experimental\VenpiCaveOverhaul.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-CCMBH-Patch-Experimental\VenpiCaveOverhaul-CCMBH-Patch.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-CCMBH-Patch-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml
"D:\Program Files\Spriggit\Spriggit.CLI.exe" serialize --InputPath "D:\MO2Staging\Starfield\mods\VenpiCaveOverhaul-GrindTerraFactions-Patch-Experimental\VenpiCaveOverhaul-GrindTerraFactions-Patch.esm" --OutputPath "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Source\ESM-VenpiCaveOverhaul-GrindTerraFactions-Patch-Extracted" --GameRelease Starfield --PackageName Spriggit.Yaml

@REM Create and copy the BA2 Main Archive to Dist folder
@echo "Creating the BA2 Main Archive"
"D:\Program Files\xEdit\BSArch64.exe" pack "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main" "VenpiCaveOverhaul - Main.ba2" -sf1 -mt && (
  @echo "Main Archive successfully assembled"
  (call )
) || (
  @echo "ERROR:  Main Archive failed to assemble <======================================="
  exit /b 1
)

@REM Copying the BA2 Archives to the Dist folder
@echo "Copying the BA2 Archives to the Dist folder"
copy /y "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist-BA2-Main\VenpiCaveOverhaul - Main.ba2" "C:\Repositories\Public\Starfield Mods\starfield-cave-overhaul\Dist"
