$ErrorActionPreference = 'Stop'
$packageName    = 'rdpguard'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rdpguard.com/download/rdpguard-9-7-3.exe'
$checksum       = '3f6c5c49b56e6f634999be60aef8776ab5d8055ceb52ce7cd7d876d497a91f14'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  validExitCodes= @(0)
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'RdpGuard*'
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs
