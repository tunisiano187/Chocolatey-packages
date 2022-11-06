$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url32            = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.6_x86.exe'
$url64            = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.6_x64.exe'
$checksum32Type   = 'sha256'
$checksum64Type   = 'sha256'
$checksum32       = '58e6cfbd07b1070ce94b39465dacf91e23e95b6fe29a1c73626366cc891ca3be'
$checksum64       = '93780a8118b78b9d2aa14fca998e46fb89c041f48bd1ed0284382c9ee83a693b'
$silentArgs       = '/DIR="C:\wamp" /VERYSILENT /SUPPRESSMSGBOXES'
$validExitCodes   = @(0)

$packageArgs = @{
  packageName     = $packageName
  fileType        = $installerType
  url             = $url32
  url64			      = $url64
  silentArgs      = $silentArgs
  validExitCodes  = $validExitCodes
  softwareName    = 'wamp-server*'
  checksum        = $checksum32
  checksum64      = $checksum64
  checksumType    = $checksum32Type
  checksum64Type  = $checksum64Type
}

Install-ChocolateyPackage @packageArgs
