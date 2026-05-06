# Abort on first error
$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = "Stop"

# If not loaded already pull in the shared config
if (!$Global:SharedConfigurationLoaded) {
  Write-Host -ForegroundColor Green "Importing Shared Configuration"
  . "$PSScriptRoot/sharedConfig.ps1"
}

$ourPapyrusSourcePath = "./Papyrus"
$bgsPapyrusSourcePath = "$ENV:PAPYRUS_SCRIPTS_SOURCE_PATH"
$targetCompiledScriptsPath = "$ENV:MODULE_SCRIPTS_PATH"

# Pick a git comparison base.
# Good options:
#   HEAD                -> only local uncommitted changes
#   origin/main...HEAD  -> everything changed on current branch vs main
$gitDiffBase = "HEAD"

function Test-Directory {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path
  )

  if (-not [System.IO.Directory]::Exists($Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Get-RelativePapyrusPath {
  param(
    [Parameter(Mandatory = $true)]
    [string]$FullPath,
    [Parameter(Mandatory = $true)]
    [string]$SourceRoot
  )

  $full = [System.IO.Path]::GetFullPath($FullPath)
  $root = [System.IO.Path]::GetFullPath($SourceRoot)

  if (-not $root.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
    $root = $root + [System.IO.Path]::DirectorySeparatorChar
  }

  if ($full.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase)) {
    return $full.Substring($root.Length)
  }

  throw "Path '$FullPath' is not under source root '$SourceRoot'"
}

function Get-ChangedPapyrusFilesFromGit {
  param(
    [Parameter(Mandatory = $true)]
    [string]$DiffBase,
    [Parameter(Mandatory = $true)]
    [string]$SourceRoot
  )

  $repoRoot = (git rev-parse --show-toplevel).Trim()
  if (-not $repoRoot) {
    throw "Not inside a git repository."
  }

  Push-Location $repoRoot
  try {
    $changed = @()
    $deleted = @()

    # Tracked changes relative to baseline
    $diffLines = git diff --name-status $DiffBase -- | Where-Object { $_ }
    foreach ($line in $diffLines) {
      $parts = $line -split "\s+", 2
      if ($parts.Count -lt 2) { continue }

      $status = $parts[0]
      $path = $parts[1]

      if ($path -notmatch '\.psc$') { continue }
      if ($path -notlike 'Papyrus/*' -and $path -notlike 'Papyrus\*') { continue }

      switch -Regex ($status) {
        '^D' { $deleted += $path; break }
        default { $changed += $path; break }
      }
    }

    # Include untracked .psc files too
    $untracked = git ls-files --others --exclude-standard -- | Where-Object {
      $_ -match '\.psc$' -and ($_ -like 'Papyrus/*' -or $_ -like 'Papyrus\*')
    }
    $changed += $untracked

    return [PSCustomObject]@{
      RepoRoot = $repoRoot
      Changed  = $changed | Sort-Object -Unique
      Deleted  = $deleted | Sort-Object -Unique
    }
  }
  finally {
    Pop-Location
  }
}

function Remove-CompiledOutputForDeletedSource {
  param(
    [Parameter(Mandatory = $true)]
    [string]$DeletedRepoRelativePath,
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot
  )

  $relativeInsidePapyrus = $DeletedRepoRelativePath -replace '^[Pp]apyrus[\\/]', ''
  $pexRelative = [System.IO.Path]::ChangeExtension($relativeInsidePapyrus, '.pex')
  $pexPath = Join-Path $TargetRoot $pexRelative

  if (Test-Path -LiteralPath $pexPath) {
    Write-Host -ForegroundColor Yellow "Removing compiled output for deleted source: $pexPath"
    Remove-Item -LiteralPath $pexPath -Force
  }
}

# Scaffold Compiled Pathing if needed
Test-Directory "$targetCompiledScriptsPath\$Global:ScriptingNamespaceModuleCompany"
Test-Directory "$targetCompiledScriptsPath\$Global:ScriptingNamespaceModuleCompany\$Global:ScriptingNamespaceModuleName"
Test-Directory "$targetCompiledScriptsPath\$Global:ScriptingNamespaceSharedLibraryCompany"
Test-Directory "$targetCompiledScriptsPath\$Global:ScriptingNamespaceSharedLibraryCompany\$Global:ScriptingNamespaceSharedLibraryName"

Write-Host -ForegroundColor Green "Detecting changed .psc files from git using diff base '$gitDiffBase'"
$gitChanges = Get-ChangedPapyrusFilesFromGit -DiffBase $gitDiffBase -SourceRoot $ourPapyrusSourcePath

foreach ($deletedFile in $gitChanges.Deleted) {
  Remove-CompiledOutputForDeletedSource -DeletedRepoRelativePath $deletedFile -TargetRoot $targetCompiledScriptsPath
}

if (-not $gitChanges.Changed -or $gitChanges.Changed.Count -eq 0) {
  Write-Host -ForegroundColor Yellow "No changed .psc files found. Nothing to compile."

  Write-Host -ForegroundColor Cyan "`n`n"
  Write-Host -ForegroundColor Cyan "**************************************************"
  Write-Host -ForegroundColor Cyan "**   No changed scripts detected. Build skipped **"
  Write-Host -ForegroundColor Cyan "**************************************************"
  Write-Host -ForegroundColor Cyan "`n`n"

  return
}

Write-Host -ForegroundColor Green "Compiling changed scripts:"
$gitChanges.Changed | ForEach-Object { Write-Host -ForegroundColor Gray " - $_" }

$repoRoot = $gitChanges.RepoRoot
foreach ($repoRelativeFile in $gitChanges.Changed) {
  $fullSourcePath = Join-Path $repoRoot $repoRelativeFile

  Write-Host -ForegroundColor Green "Compiling $repoRelativeFile"

  & "$ENV:TOOL_PATH_PAPYRUS_COMPILER\PapyrusCompiler.exe" "$fullSourcePath" -f -optimize -flags="$ENV:PAPYRUS_COMPILER_FLAGS\Starfield_Papyrus_Flags.flg" -output="$targetCompiledScriptsPath" -import="$ourPapyrusSourcePath;$bgsPapyrusSourcePath" -ignorecwd
}

Write-Host -ForegroundColor Cyan "`n`n"
Write-Host -ForegroundColor Cyan "**************************************************"
Write-Host -ForegroundColor Cyan "**   Incremental compile workflow complete      **"
Write-Host -ForegroundColor Cyan "**************************************************"
Write-Host -ForegroundColor Cyan "`n`n"