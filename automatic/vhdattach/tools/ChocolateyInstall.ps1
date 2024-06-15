$ErrorActionPreference = 'Stop'
$packageName = 'vhdattach'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\vhdattach421.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $url
  validExitCodes = @(0,1)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'VHD Attach*'
  }

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null
