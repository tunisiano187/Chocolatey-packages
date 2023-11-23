$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url32            = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.2_x64.exe'
$url64            = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.2_x64.exe'
$checksum32Type   = 'sha256'
$checksum64Type   = 'sha256'
$checksum32       = 'a8729be99f198dfd2493b3b433cab42d24e2e1a3235ae6af22546379cfc1c11a'
$checksum64       = 'a8729be99f198dfd2493b3b433cab42d24e2e1a3235ae6af22546379cfc1c11a'
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
