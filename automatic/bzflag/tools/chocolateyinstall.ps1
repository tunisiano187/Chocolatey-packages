$packageName    = 'bzflag'
$installerType  = 'exe'
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.28/bzflag-2.4.28.exe'
$checksum       = '6ad8956bb02f319a31b27f7a1c65753a42da8ebb42a2c5b853df4784efc9b5bb'
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

