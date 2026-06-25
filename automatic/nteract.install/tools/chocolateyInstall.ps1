$ErrorActionPreference = 'Stop';

$packageName  = $env:ChocolateyPackageName
$url          = 'https://github.com/nteract/nteract/releases/download/v2.6.0-stable.202606251403/nteract-stable-windows-x64.exe'
$checksum     = '325f7823a088c55dd06d023123f25ec9b72ee9fc5f2135f8703c7926414c6799'
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
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
