$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32        = 'https://downloads.sourceforge.net/project/warzone2100/releases/4.1.3/warzone2100_win_x86_installer.exe'
$checksum32   = '1AC853090FF513ED568EFBC3A2337E1D75619DAF75BBC9EF5625B57EC5549F4E'
$url64        = 'https://downloads.sourceforge.net/project/warzone2100/releases/4.1.3/warzone2100_win_x64_installer.exe'
$checksum64   = '7898FCEFA2A77EA5ABE6C2FCA218505BCCB90A49151E9C727DB0821F980983B0'
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
