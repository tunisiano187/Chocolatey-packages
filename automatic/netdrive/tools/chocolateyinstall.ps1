$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.bdrive.com/netdrive/builds/baecdb2fdd814c0489935d4e062fd775/NetDrive3-3.19.14.msi'
$checksum       = '69E6005F09D1CAE24A04266003F9D2A63E21214603CC7343633E43EA3F8157AC'
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
