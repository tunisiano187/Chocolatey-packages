$packageName    = 'bzflag'
$installerType  = 'exe'
$url            = 'https://download.bzflag.org/bzflag/windows/2.4.30/bzflag-2.4.30.exe'
$checksum       = 'ffaed59ed35902ed50959a0c21eab2a68144d02427c0e1cd7ee07eb47c758999'
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

