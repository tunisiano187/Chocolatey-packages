$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.2/warzone2100_win_x86_installer.exe'
$checksum32   = '53fc8f60f2d47ca01830dd5450c35bfa33a35bd3844aaa777933c855f07150cc'
$url64        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.2/warzone2100_win_x64_installer.exe'
$checksum64   = '515a581f8ecfa2dc94aadd5fd6d73c0b57c5025c50f9220f3e7036e23e2f5da0'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url32
  url64bit       = $url64
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Warzone 2100*'
  checksum       = $checksum32
  checksumType   = $checksumType
  checksum64     = $checksum64
  checksumType64 = $checksumType
}

Install-ChocolateyPackage @packageArgs

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
