$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://github.com/brave/brave-browser/releases/download/v1.22.28/BraveBrowserSilentNightlySetup32.exe'
$url64            = 'https://github.com/brave/brave-browser/releases/download/v1.22.30/BraveBrowserSilentNightlySetup.exe'
$checksum32       = '1b7005991edd7280318644b376af09ee4386b1fddeb5b4484643cb0d1fe6b021'
$checksum64       = '0fabd28575fbc8cae7f23d3283de909b2ccd3630f063ad0b21a7125c7089d1b9'
$checksumType32   = 'sha256'
$checksumType64   = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url             = $url32
  url64           = $url64

  softwareName    = "$packageName*"

  checksum        = $checksum32
  checksumType    = $checksumType32
  checksum64      = $checksum64
  checksumType64  = $checksumType64


  validExitCodes= @(0)
}

if ($installedVersion -and ($softwareVersion -lt $installedVersion)) {
  Write-Warning "Skipping installation because a later version than $softwareVersion is installed."
}
elseif ($installedVersion -and ($softwareVersion -eq $installedVersion)) {
  Write-Warning "Skipping installation because version $softwareVersion is already installed."
}
else {
  Install-ChocolateyPackage @packageArgs
}
