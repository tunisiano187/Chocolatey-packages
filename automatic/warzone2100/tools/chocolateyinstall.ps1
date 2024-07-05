$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.0/warzone2100_win_x86_installer.exe'
$checksum32   = '9e522ffc52208448c918242da9ff52d9de4d245bb534b36380d9238fcb9ec641'
$url64        = 'https://github.com/Warzone2100/warzone2100/releases/download/4.5.0/warzone2100_win_x64_installer.exe'
$checksum64   = '2627753b2b54bb583a773e505dcdd9bcd0c0eea40bd49d07ee3df6398969fa4c'
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
