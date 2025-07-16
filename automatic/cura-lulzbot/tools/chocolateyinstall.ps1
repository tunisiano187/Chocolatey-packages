$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Cura_LulzBot_Edition/Windows/4.13.17/Cura_LulzBot_Edition-4.13.17-amd64.exe'
$checksum32 = '008b5cdbe4378250dcc1e3341fdab942e844bae1e0b6a0c24c86d0b007c5bcac'

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
