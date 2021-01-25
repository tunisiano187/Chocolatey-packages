$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://github.com/brave/brave-browser/releases/download/v1.21.25/BraveBrowserSilentNightlySetup32.exe'
$url64            = 'https://github.com/brave/brave-browser/releases/download/v1.21.25/BraveBrowserSilentNightlySetup.exe'
$checksum32       = '89dd62d28f541f1bac4b5dbd5c8fc9d1e3ce91ce4b47e31ff9d68891a24a9be6'
$checksum64       = '83997023b49eaf58610beb7ad09aaeb8760e638322c9c72b36b66c49e21d0e25'
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
