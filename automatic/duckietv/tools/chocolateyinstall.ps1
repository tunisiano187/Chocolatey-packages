$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202405151726/DuckieTV-202405151726-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202405151726/DuckieTV-202405151726-windows-x64.zip'
$checksum = '5c0e9cd9f86ca333a321a9f96723be9fea7a33708ad52226029a401046ce89c0'
$checksum64 = 'a58c700ab7f69ce11e5109f1138e2ad517d5baab880ccfdad399ab4d3f92c63b'
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
