$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://github.com/brave/brave-browser/releases/download/v1.22.13/BraveBrowserSilentNightlySetup32.exe'
$url64            = 'https://github.com/brave/brave-browser/releases/download/v1.22.15/BraveBrowserSilentNightlySetup.exe'
$checksum32       = '2a127c4c6f4c51092a406ea926437ea6138f8c9fe24f196fff7038dfdd6b93eb'
$checksum64       = '1fd7b0b9f6f07893b3f2595a86c1467f692309f6946a6764935cc6564b6bd5d2'
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
