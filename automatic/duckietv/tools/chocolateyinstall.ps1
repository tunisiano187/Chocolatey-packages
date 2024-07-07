$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202406291642/DuckieTV-202406291642-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202406291642/DuckieTV-202406291642-windows-x64.zip'
$checksum = 'd5d3b94103fd6f4aff096ed8d0d336618e7da10aa60e527203e8803f1be7cd5e'
$checksum64 = '31bf276616f38e6a3bce559283ddab5365525ea6bfb7f837ad4a3c6795f0f018'
$checksumType = 'sha256'
$silentArgs = '/S'
$validExitCodes = @(0)

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'ZIP'
  url            = $url
  url64Bit       = $url64
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

$fileLocation = (Get-ChildItem -Path $toolsDir -Filter "*.exe" ).FullName
$fileLocation

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  File           = $fileLocation
  silentArgs     = $silentArgs
  validExitCodes = $validExitCodes
  softwareName   = 'DuckieTV*'
}

Install-ChocolateyInstallPackage @packageArgs
