$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Windows/Cura%20LulzBot%20Edition%204.13/4.13.5/Cura_LulzBot_Edition-4.13.5-amd64.exe'
$checksum32 = '90c34ce07a38e351a7de63a6f1bb6d356aee7912a7b124a5256a8e8e3a120333'

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
