$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://github.com/brave/brave-browser/releases/download/v1.22.9/BraveBrowserSilentNightlySetup32.exe'
$url64            = 'https://github.com/brave/brave-browser/releases/download/v1.22.10/BraveBrowserSilentNightlySetup.exe'
$checksum32       = '09d52455f19343e8e64a2fb94f550e7ceb810e50a048abac958a6da4d22a9e0c'
$checksum64       = '5c515737c08aa0dfa3ec39a545d0c03787f67d4e05811643e835fb8fcae043fa'
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
