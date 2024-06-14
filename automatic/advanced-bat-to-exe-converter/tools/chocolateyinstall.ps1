$ErrorActionPreference = 'Stop'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\AB2ECInstall.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = 'advanced-bat-to-exe-converter'
  softwareName   = 'Advanced BAT to EXE Converter*'
  fileType       = 'EXE'
  silentArgs     = ''
  file           = "$toolsDir\advbattoexeconverter.exe"
  validExitCodes = @(0)
  }
  
Install-ChocolateyInstallPackage @packageArgs
