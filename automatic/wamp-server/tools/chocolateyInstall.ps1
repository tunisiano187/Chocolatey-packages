$ErrorActionPreference = 'Stop'
$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url              = 'https://wampserver.aviatechno.net/files/install/wampserver3.3.5_x64.exe'
$checksumType     = 'sha256'
$checksum         = '246b9d4f77506fd2858b38cdce192a25089c9d642caca135f6d2e2cc2682258a'
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
