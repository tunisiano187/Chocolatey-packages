$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url32            = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.0_x86.exe'
$url64            = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.0_x64.exe'
$checksum32Type   = 'sha256'
$checksum64Type   = 'sha256'
$checksum32       = 'b4bcab2ba7a8521746e1b00e7511182ab9256f0be5f2cfd20a384ee0b39dd340'
$checksum64       = '3e034bc6a74971a3ed38afebcefa9d8e16064aa5b41f1e1340dbb9ad85768e7c'
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
