
$ErrorActionPreference = 'Stop';
$url            = 'https://clients.chime.aws/win/latest'
$checksum       = '2554c8dba221eb9d7b978bfcbef4c2c4a5d388bb9e0da07e0d908da4e768ae12'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'amazon-chime*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
