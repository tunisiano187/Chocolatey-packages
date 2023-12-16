$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://software.lulzbot.com/Windows/Cura%20LulzBot%20Edition%204.13/4.13.2/Cura_LulzBot_Edition-4.13.2-amd64.exe'
$checksum32 = '996b624f5a92adb1d3a193c5e3e1061db28215b4c5b0eca0ef900ee7dcc9888f'

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
