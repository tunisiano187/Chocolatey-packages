$ErrorActionPreference = 'Stop'

$packageName    = 'real-netstat'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://netstatagent.com/files/netagent-setup.exe'
$checksum       = 'D6AF04B6315BD5FA6E4F434F32EA228B9F6C699BB9104E9D64AEBC9EC38D39CA'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Real NetStat*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
