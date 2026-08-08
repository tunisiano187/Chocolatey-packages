$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  softwareName = 'Perplexity*'
  fileType     = 'exe'
  silentArgs   = '/S'
  validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $packageArgs['file'] = "$($_.UninstallString)" -Replace '"', ''
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  $key | ForEach-Object { Write-Warning "Found key: $($_.DisplayName)" }
  Write-Warning "To prevent accidental removal, manually uninstall $($packageArgs['packageName'])."
}
