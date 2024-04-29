<#
.SYNOPSIS
  Remove -NoCheckChocoVersion in update.ps1 that aren't commited for more than 30 commits

.DESCRIPTION
  Remove -NoCheckChocoVersion in update.ps1

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
  ps> .\Remove-Nockeck.ps1
  output> "Time Used: 00:00:27.4720531"

  #>

param(
    [string]$PackagesDirectory = "../automatic",
    [switch]$UseStopwatch
)
$counts = @{}
$counts.replaced = 0

$encoding = New-Object System.Text.UTF8Encoding($false)

function Update-File {
    param(
      [string]$PS1Path
    )

    $ps1 = Get-Content "$PS1Path" -Encoding UTF8

    $oldContent = ($ps1 | Out-String) -replace '\r\n?',"`n"

    $ps1 = $ps1 -replace " -NoCheckChocoVersion", ""
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

# List update.ps1 files
# Set the path to the folder containing the update.ps1 files
$folder_path = "folder_path"

# Retrieve the list of update.ps1 files containing the string -NoCheckChocoVersion
$files = Get-ChildItem -Path $folder_path -Filter "update.ps1" -Recurse | Where-Object { $_ | Select-String -Pattern "-NoCheckChocoVersion" }

foreach ($file in $files) {
    # Get the relative path of the file for Git
    $relativePath = $file.FullName.Replace((Get-Location).Path + "\", "")

    # Get the number of commits where the file has been modified
    $commitCount = git rev-list HEAD -n 30 -- $relativePath | Measure-Object | Select-Object -ExpandProperty Count

    if ($commitCount -eq 0) {
        Write-Output "$($file.FullName) contains -NoCheckChocoVersion but has not been modified in the last 30 commits. The -NoCheckChocoVersion part will be removed."

        # Read the content of the file
        Update-File
    }
}

if ($UseStopwatch) {
    $stopWatch.Stop();
    if (!$Quiet) {
      Write-Output "Time Used: $($stopWatch.Elapsed)"
    }
}
if ($counts.replaced -eq 0 -and !$Quiet) {
  Write-Output "Congratulations, all $($counts.uptodate) ps1 are correct."
} elseif (!$Quiet) {
  Write-Output "Updated $($counts.replaced) ps1";
  if ($counts.uptodate -eq 1 -and !$Quiet) {
    Write-Output "$($counts.uptodate) ps1 was already up to date.";
  } elseif ($counts.uptodate -gt 1 -and !$Quiet) {
    Write-Output "$($counts.uptodate) ps1 were already up to date.";
  }
}
