$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/fossasia/pslab-desktop/releases/download/v2.5.2/PSLab-Desktop-Setup-2.5.2.exe'
$checksum     = '8eb40300dfc5c141389fe160fa2ca6c67be3d3923085bdcc7ccfbd72629fe351'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'pslab-desktop*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
