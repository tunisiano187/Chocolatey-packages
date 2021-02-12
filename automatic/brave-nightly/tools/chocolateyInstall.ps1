$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://github.com/brave/brave-browser/releases/download/v1.22.19/BraveBrowserSilentNightlySetup32.exe'
$url64            = 'https://github.com/brave/brave-browser/releases/download/v1.22.21/BraveBrowserSilentNightlySetup.exe'
$checksum32       = '5d27e119cc3447cf383f9b0eca4ee9cfc66fc0b133ffb7fb2b269993eabec858'
$checksum64       = 'b0f56266cdd977db5a89b7288d8e116856c5f3f7b3eaa55e448907611116f5a9'
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
