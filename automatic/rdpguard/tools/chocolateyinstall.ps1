$ErrorActionPreference = 'Stop'
$packageName    = 'rdpguard'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rdpguard.com/download/rdpguard-9-7-1.exe'
$checksum       = 'b8a619ac524f4883d499f2a31724524cbd548938babb2c066cb2d7bfb24fe371'
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
