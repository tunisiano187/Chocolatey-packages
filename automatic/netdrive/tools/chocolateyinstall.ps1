$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://downloads.bdrive.com/netdrive/builds/ee000d02a2b6463d970eb04ac5ce2964/NetDrive3-4.0.35.msi'
$checksum       = '80AF46890A91B48CB8E80BEEFAD7E8ED9A15B4D6A330F2ACF3818D38B9D4DE3E'
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
