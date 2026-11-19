$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url              = 'https://wampserver.aviatechno.net/files/install/wampserver3.4.3_x64.exe'
$checksumType     = 'sha256'
$checksum         = 'd50058a1026da229f5f4708a92ca522cbc7e3cd1893ec7a19dedcb2f9d29a625'
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
