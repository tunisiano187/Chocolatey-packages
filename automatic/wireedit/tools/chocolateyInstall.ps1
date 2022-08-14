$ErrorActionPreference = 'Stop'
$installerType  = 'msi'
$url            = 'https://omnipacket.com/current/WireEdit-3.10.223.msi'
$silentArgs     = '/quiet'
$checksum       = '999e74c5b17a6f84b0188b977bea4b172442597a02e7534e47ebf528918dec8a'
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
