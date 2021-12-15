
$ErrorActionPreference = 'Stop';
$url            = 'https://clients.chime.aws/win/latest'
$checksum       = 'eeb0929b24c44c96aa25630480916224795288c737db63ebff0f29620391a825'
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
