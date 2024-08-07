$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$silentArgs     = '/S'

$packageArgs = @{
  packageName    = 'pelles-c'
  softwareName   = 'Pelles C for Windows'
  fileType       = 'EXE'
  silentArgs     =  $silentArgs
  file           = "$toolsDir\setup.exe"
  validExitCodes = @(0, 3010, 1641)
  }

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.exe -Force | Out-Null
Remove-Item $toolsDir\*.ignore -Force | Out-Null