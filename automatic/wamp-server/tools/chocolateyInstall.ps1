$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url              = 'https://wampserver.aviatechno.net/files/install/wampserver3.4.0_x64.exe'
$checksumType     = 'sha256'
$checksum         = '08bc458acb5974e3f93857c234c4daf72da8a4da842b736c1424d98b475e4fcd'
$silentArgs       = '/DIR="C:\wamp" /VERYSILENT /SUPPRESSMSGBOXES'
$validExitCodes   = @(0)

$packageArgs = @{
  packageName     = $packageName
  fileType        = $installerType
  url             = $url
  silentArgs      = $silentArgs
  validExitCodes  = $validExitCodes
  softwareName    = 'wamp-server*'
  checksum        = $checksum
  checksumType    = $checksumType
}

Install-ChocolateyPackage @packageArgs
