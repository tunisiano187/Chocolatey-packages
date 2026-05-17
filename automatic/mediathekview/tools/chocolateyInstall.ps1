$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageName      = 'mediathekview'
$url32            = 'https://download.mediathekview.de/stable/14.5.0/MediathekView-14-5-0-windows.exe'
$checksum32       = 'placeholder'
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