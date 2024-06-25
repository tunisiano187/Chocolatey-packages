$ErrorActionPreference = 'Stop'
$packageName    = 'rdpguard'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rdpguard.com/download/rdpguard-9-7-5.exe'
$checksum       = 'e4fbb2742c774c8574e08daad8eacbd0aed82be3a88bd4cf0af6c67e86044b21'
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
