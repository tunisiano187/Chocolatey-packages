$ErrorActionPreference = 'Stop'
$packageName    = 'rdpguard'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://rdpguard.com/download/rdpguard-9-4-5.exe'
$checksum       = '6e2c154bbfe08df93a8e271f41754c22500de4b266e8f4032da13203d66ae451'
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
