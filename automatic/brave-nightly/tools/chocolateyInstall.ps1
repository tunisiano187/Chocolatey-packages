$ErrorActionPreference = 'Stop';
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName      = $env:ChocolateyPackageName
$url32            = 'https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.9/ultracopier-windows-x86-2.2.4.9-setup.exe'
$url64            = 'https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.9/ultracopier-windows-x86_64-2.2.4.9-setup.exe'
$checksum32       = 'be8882f326f8f633323ee7ec7d6a7833aa2049d2dcb54937b9ca6f0fe045604a'
$checksum64       = 'ba4018e7f251c80d7ddd6a413b3e7f4cfc813d2c5624741780b94cb7db5d771f'
$checksumType32   = ''
$checksumType64   = ''

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