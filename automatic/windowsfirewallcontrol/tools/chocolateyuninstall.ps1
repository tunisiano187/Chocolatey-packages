$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Malwarebytes Windows Firewall Control*'
  fileType      = 'exe'
  silentArgs    = ''
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $packageArgs['file'] = "$($_.UninstallString)"
    [array]$str = $packageArgs['file'] -Split " -"
    $packageArgs['file'] = $str[0]

    Start-Process $packageArgs['file'] -ArgumentList '-uninstall' -Verb 'runas'
    Start-Process autohotkey -Wait -ArgumentList '.\uninstall-windows-firewall-control.ahk' -WorkingDirectory $toolsDir
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
