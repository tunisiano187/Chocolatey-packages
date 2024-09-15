$ErrorActionPreference = 'Stop'
$installerType  = 'msi'
$url            = 'https://omnipacket.com/current/WireEdit-3.13.329.msi'
$silentArgs     = '/quiet'
$checksum       = 'bb65b1ec016049ca89bda96abecba6e86c180176a1df9a618c7b20abb7357b7a'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
