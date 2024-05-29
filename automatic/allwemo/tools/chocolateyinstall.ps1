$ErrorActionPreference = 'Stop'
$packageName    = 'allwemo'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  file           = "$toolsDir\AllWemoSetup.msi"
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'AllWemo*'
  }
  
Install-ChocolateyInstallPackage @packageArgs

Remove-Item "$toolsDir\*.msi" -EA SilentlyContinue | Out-Null
