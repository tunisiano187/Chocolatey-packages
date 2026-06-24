$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Cura_LulzBot_Edition/Windows/5.10.1/Cura_LulzBot_Edition-5.10.1-win64-X64.exe'
$checksum32 = '20bf9b86be2bc4f427b2ca0b640459618fa7f4cffb0c17c306b9bf5f441e95c6'

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
