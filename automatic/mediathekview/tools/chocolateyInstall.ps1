$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageName      = 'mediathekview'
$url32            = 'https://download.mediathekview.de/stabil/MediathekView-15.0.0-win.exe'
$checksum32       = '367f08e409435b98797cc20cea92249a7c12f86d0c71ddd3fc9aacec1f0fab04'
$checksumType32   = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url             = $url32
  checksum        = $checksum32
  checksumType    = $checksumType32
  softwareName    = "$packageName*"
  silentArgs      = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
