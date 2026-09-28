$ErrorActionPreference = 'Stop'

$apps = Get-AppxPackage -Name '*Proton*Pass*' -ErrorAction SilentlyContinue

if ($apps) {
  $apps | Remove-AppxPackage
} else {
  [array]$key = Get-UninstallRegistryKey -SoftwareName 'Proton Pass*'
  $packageName = $env:ChocolateyPackageName

  if ($key.Count -eq 1) {
    $key | ForEach-Object {
      $packageArgs = @{
        packageName    = $packageName
        fileType       = 'EXE'
        silentArgs     = '--uninstall -s'
        validExitCodes = @(0)
        file           = "$($_.UninstallString -replace ' --uninstall')"
      }
      Uninstall-ChocolateyPackage @packageArgs
    }
  } elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
  } else {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
  }
}
