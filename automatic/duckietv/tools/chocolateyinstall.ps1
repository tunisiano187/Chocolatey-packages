$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202603251838/DuckieTV-202603251838-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202603251838/DuckieTV-202603251838-windows-x64.zip'
$checksum = '9c1239be05eac696eee878083c4264b10256cf2a87f11b70c88fde70efb44fb7'
$checksum64 = '5fdb9797bec565d0a8ac1794eeb29188b094f698402da8a67f2d29363a3c42e8'
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
