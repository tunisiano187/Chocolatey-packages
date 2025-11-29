$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum       = '7ef489ca4fc9aa00f627d6712b6d63576624546cc05d007fd053415e33aa2f43'
$checksumType   = 'sha256'
$url64          = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum64     = '7ef489ca4fc9aa00f627d6712b6d63576624546cc05d007fd053415e33aa2f43'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Gwyddion'
}

Install-ChocolateyPackage @packageArgs

#Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace EXE files
