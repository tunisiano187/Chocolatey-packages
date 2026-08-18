$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v2.7.0-stable.202608172336/nteract-stable-windows-x64.exe'
$checksum     = 'd6eb760da4b01553ee597fa1da3fe00f16115bf6d1ee5cab759afb73be15187d'
$checksumType = 'sha256'

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'nteract*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S' # NSIS
  validExitCodes= @(0, 1, 2)
}

Install-ChocolateyPackage @packageArgs
