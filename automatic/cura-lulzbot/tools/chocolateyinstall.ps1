$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Windows/Cura%20LulzBot%20Edition%204.13/4.13.15/Cura_LulzBot_Edition-4.13.15-amd64.exe'
$checksum32 = '4e41e3fe44f28756a9319142d793142e39e10f0e4e4893eed1809a1fb38c1c7a'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url32
  softwareName  = 'cura-lulzbot*'
  checksum      = $checksum32
  checksumType  = 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
