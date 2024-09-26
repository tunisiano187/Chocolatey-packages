$ErrorActionPreference = 'Stop'
$packageName    = 'ost2'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://d.4team.biz/files/ost2_setup.exe'
$checksum       = 'AF6A47B25AB834435E19AAB119E60FB6B89FA9AB21FE23B7424491C473BF7B6A'
$checksumType   = 'sha256'
$ahkExe         = 'AutoHotKey'
$ahkFile        = "$toolsDir\OST2install.ahk"

Start-Process $ahkExe $ahkFile

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = '/S'
  validExitCodes = @(0,2)
  softwareName   = 'OST2*'
  }

Install-ChocolateyPackage @packageArgs
