
$ErrorActionPreference = 'Stop';
$url            = 'https://clients.chime.aws/win/latest'
$checksum       = 'e693899615b63e7c5fa5e89250ff14bc07ad2785f0997752a4f238a9761ad6e4'
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
