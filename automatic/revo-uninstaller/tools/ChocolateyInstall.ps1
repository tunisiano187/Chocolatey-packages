# https://download.revouninstaller.com/download/revosetup.exe
$ErrorActionPreference = 'Stop';
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'revo-uninstaller'
  fileType       = 'EXE'
  file           = "$toolsDir\revosetup.exe"
  softwareName   = 'Revo Uninstaller*'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-" 
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -Force | Out-Null
