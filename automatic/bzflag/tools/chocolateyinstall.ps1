$packageName    = 'bzflag'
$installerType  = 'exe'
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.28/bzflag-2.4.28.exe'
$checksum       = '689f625ca50d8782ba09ebf2f88a005d2feeb70e3699b1b0f95649f41b5946eb'
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

