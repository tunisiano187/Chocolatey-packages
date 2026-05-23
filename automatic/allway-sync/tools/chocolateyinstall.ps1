$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://allwaysync.com/content/download/allwaysync-22-0-1.exe'
$checksum     = 'd405b2310c27ccfe578de7d587c59f21bcc76d0c7eed09792d7fcd67c544bf9e'
$checksumType = 'sha256'
$url64        = 'https://allwaysync.com/content/download/allwaysync-x64-22-0-1.exe'
$checksum64   = '7e29f26cdddf8dd0f2b8c7da6ff2da0c1312388abd28763713f29c285e017370'

$packageArgs = @{
  packageName    = 'allway-sync'
  fileType       = 'exe'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName   = 'Allway Sync*'
  }

Install-ChocolateyPackage @packageArgs
