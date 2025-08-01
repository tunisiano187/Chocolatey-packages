<#
.SYNOPSIS
  Updates templates variables to environment ones in ps1

.DESCRIPTION
  It updates the package ps1 files with the correct environment variables.

.PARAMETER Name
  If specified it only updates the package matching the specified name

.PARAMETER PackagesDirectory
  The relative path to where packages are located (relative to the location of this script)

.PARAMETER UseStopwatch
  Uses a stopwatch to time how long this script used to execute

.PARAMETER Quiet
  Do not write normal output to host.
  NOTE: Output from git and Write-Warning will still be available

.OUTPUTS
  The number of packages that was updates,
  if some packages is already up to date, outputs how many.

.EXAMPLE
  ps> .\Update-Variables.ps1
  Updates all ps1 files with correct environment variables
-    {{PackageName}}
+    $env:ChocolateyPackageName

.EXAMPLE
  ps> .\Updates-Variables.ps1 -Name "bitvise-ssh-server" -UseStopwatch
  ps> .\Updates-Variables.ps1 -UseStopwatch
  While also updating the ps1 files this will also output the time it took for the script to finish
  output> "Time Used: 00:00:27.4720531"

  #>

param(
  [string]$Name,
  [string]$PackagesDirectory = "../automatic",
  [switch]$UseStopwatch,
  [switch]$Quiet
)

$counts = @{
  replaced = 0
  uptodate = 0
}

$encoding = New-Object System.Text.UTF8Encoding($false)

function Update-Variable {
  param(
    [string]$PS1Path
  )

  $ps1 = Get-Content "$PS1Path" -Encoding UTF8

  $oldContent = ($ps1 | Out-String) -replace '\r\n?',"`n"

  $ps1 = $ps1 -replace "'{{PackageName}}'",'$env:ChocolateyPackageName'
  $ps1 = $ps1 -replace '{{PackageName}}','$env:ChocolateyPackageName'
  $ps1 = $ps1 -replace 'Install-ChocolateyDesktopLink','Install-ChocolateyShortcut -ShortcutFilePath "$($env:USERPROFILE)\Desktop\$($env:ChocolateyPackageName).lnk" -TargetPath'
  $ps1 = $ps1 -replace 'where ', 'Where-Object '
  $ps1 = $ps1 -replace '% ', 'ForEach-Object '
  $ps1 = $ps1 -replace 'cup ', 'choco upgrade '
  $ps1 = $ps1 -replace 'cinst ', 'choco install '
  $ps1 = $ps1 -replace 'import-module AU', 'import-module chocolatey-AU'
#  $ps1 = $ps1 -replace 'releases"', 'releases/latest"'
#  $ps1 = $ps1 -replace "releases'", "releases/latest'"
  $ps1 = $ps1 | ForEach-Object {$_.TrimEnd()}

  $output = ($ps1 | Out-String) -replace '\r\n?',"`n"
  if ($oldContent -eq $output) {
    $counts.uptodate++;
    return;
  }
  [System.IO.File]::WriteAllText("$PS1Path", $output, $encoding);

  $counts.replaced++;
}

if ($UseStopwatch) {
  $stopWatch = New-Object System.Diagnostics.Stopwatch
  $stopWatch.Start();
}

If ($Name) {
  $packages = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory/$Name" -Filter "*.ps1"

  foreach ($package in $packages) {
    Update-Variable -Name $package.FullName -Quiet $Quiet
  }
}
else {
  $packages = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory" -Filter "*.ps1" -Recurse;

  foreach ($package in $packages) {
    Update-Variable $package.FullName -Quiet $Quiet
  }
}

if ($UseStopwatch) {
  $stopWatch.Stop();
  if (!$Quiet) {
    Write-Output "Time Used: $($stopWatch.Elapsed)"
  }
}
if ($counts.replaced -eq 0 -and !$Quiet) {
  Write-Output "Congratulations, all found ps1 are correct."
} elseif (!$Quiet) {
  Write-Output "Updated $($counts.replaced) ps1";
}
if ($counts.uptodate -eq 1 -and !$Quiet) {
  Write-Output "$($counts.uptodate) ps1 was already up to date.";
} elseif ($counts.uptodate -gt 1 -and !$Quiet) {
  Write-Output "$($counts.uptodate) ps1 were already up to date.";
}
