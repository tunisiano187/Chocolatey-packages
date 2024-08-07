$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\trjsetup.exe"

$packageArgs = @{
  packageName    = 'trojan-remover'
  softwareName   = 'Trojan Remover*'
  fileType       = 'EXE'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  file           = $url
  validExitCodes = @(0)
  }

Install-ChocolateyInstallPackage @packageArgs
