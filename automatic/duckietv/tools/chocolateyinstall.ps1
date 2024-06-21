$ErrorActionPreference = 'Stop'

$packageName = 'duckietv'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202406211919/DuckieTV-202406211919-windows-x32.zip'
$url64 = 'https://github.com/DuckieTV/Nightlies/releases/download/nightly-202406211919/DuckieTV-202406211919-windows-x64.zip'
$checksum = 'e97c7104ee0012c0fe80ea0a967d616467ed78b877956b554033a480a9359bc5'
$checksum64 = '1b7639ecb8d4831b4ef52d674b55cd139f78a53dab2e80a2c3800f0198bd9fa4'
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
