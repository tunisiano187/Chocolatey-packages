
$ErrorActionPreference = 'Stop';
$url            = 'https://clients.chime.aws/win/latest'
$checksum       = '88b4a1835c1928e0679ab015a7bb5f8e98168a97ac2a582528406e235ce4216b'
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
