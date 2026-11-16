$packageName    = 'bzflag'
$installerType  = 'exe'
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.32/bzflag-2.4.32.exe'
$checksum       = '8beeb3971b7c80c805c431f28af95679ac6496fd73b60f77cb6c04b1af69d54c'
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

