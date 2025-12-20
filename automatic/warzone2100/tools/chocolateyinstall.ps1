$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.2/warzone2100_win_x86_installer.exe'
$checksum     = '53fc8f60f2d47ca01830dd5450c35bfa33a35bd3844aaa777933c855f07150cc'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Warzone 2100*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null
