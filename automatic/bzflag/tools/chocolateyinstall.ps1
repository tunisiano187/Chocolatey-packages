$packageName    = 'bzflag'
$installerType  = 'exe'
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.26/bzflag-2.4.26.exe'
$checksum       = '3c84287e41c4ed697f13a2116bdd05f11098d2c4e262be0f080e0c019edbd96b'
$checksumType   = 'sha256'
$silentArgs     = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'BZFlag*'
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs

