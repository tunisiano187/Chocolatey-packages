$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64          = 'https://cdn.pawns.app/download/app/latest/windows/Pawns%20Setup.exe'
$checksum64     = '861e3873e88f6753083236ee612b52d81b839eeec22b24ae8fda69fb7b90a6c0'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = 'pawns*'

  checksum64    = $Checksum64
  checksumType64= $ChecksumType64

  # MSI
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
