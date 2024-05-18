$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url              = 'http://wampserver.aviatechno.net/files/install/wampserver3.3.5_x64.exe'
$checksumType     = 'sha256'
$checksum         = '644f35f0ff3b9bfc7f7e4ec2389474875f3a3fc773bb18c9d85477b7ad05b484'
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
