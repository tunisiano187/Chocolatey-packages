$ErrorActionPreference = 'Stop'
$packageName    = 'winflector'
$softwareName   = 'Winflector*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winflector.com/store/free-version/index/id/528'
$checksum       = 'E51CECBEBA0984FA8F5CD7C4BE1B0D603669C3AD93D19D851414B109280D6097'
$checksumType   = 'sha256'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)
$ahkExe         = 'AutoHotKey'
$ahkFile        = Join-Path $toolsDir "WinflectorInstall.ahk"

$packageArgs = @{
  packageName   = $packageName
  url           = $url
  FileFullPath  = "$toolsDir\winflector.exe"
  checksum      = $checksum
  checksumType  = $checksumType
}

Get-ChocolateyWebFile @packageArgs

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  file          = "$toolsDir\winflector.exe"
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
}

Install-ChocolateyInstallPackage @packageArgs
