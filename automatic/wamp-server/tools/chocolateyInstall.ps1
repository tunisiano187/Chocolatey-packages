$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url32            = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.5_x64.exe'
$checksum32Type   = 'sha256'
$checksum32       = '644f35f0ff3b9bfc7f7e4ec2389474875f3a3fc773bb18c9d85477b7ad05b484'
$silentArgs       = '/DIR="C:\wamp" /VERYSILENT /SUPPRESSMSGBOXES'
$validExitCodes   = @(0)

$packageArgs = @{
  packageName     = $packageName
  fileType        = $installerType
  url             = $url32
  silentArgs      = $silentArgs
  validExitCodes  = $validExitCodes
  softwareName    = 'wamp-server*'
  checksum        = $checksum32
  checksumType    = $checksum32Type
}

Install-ChocolateyPackage @packageArgs
