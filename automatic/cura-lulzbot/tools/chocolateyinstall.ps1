$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Windows/Cura%20LulzBot%20Edition%204.13/4.13.16/Cura_LulzBot_Edition-4.13.16-amd64.exe'
$checksum32 = '485de3bdc50ced0bf15c41888f26a8c0ebb775a73e32e0827026ea9ab9428017'

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
