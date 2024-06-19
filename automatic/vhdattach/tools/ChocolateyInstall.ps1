$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$File        = Join-path $toolsDir "vhdattach.exe"

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = $File
  validExitCodes = @(0,1)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'VHD Attach*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
Remove-Item $toolsDir\*.ignore -force | Out-Null
