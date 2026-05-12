$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202605121341/DuckieTV-202605121341-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202605121341/DuckieTV-202605121341-windows-x64.zip'
$checksum = '69d3e3baae13a70e28c0389ded846e62ccda445d1f795febad2fccc9b303d978'
$checksum64 = '65dd883b78515699924ced7834e2b06c4b105fae0e57fe9407037530ec28e5fb'
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
