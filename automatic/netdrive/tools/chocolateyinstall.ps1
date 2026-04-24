$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.bdrive.com/netdrive/builds/aaa62e58e08248f9921837b60356411b/NetDrive3-3.19.7.msi'
$checksum       = 'A154809B37FB61BADF603705DA9B42C439D33122C55B454F5A6C2A26A9CC7890'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart REINSTALL=ALL REINSTALLMODE=vamus'
  softwareName   = ''
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
