$ErrorActionPreference = 'Stop'
$packageName    = 'netdrive'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://files.bdrive.com/netdrive/builds/93a0373f1b1e4dd1afbd93bd5eb202a3/NetDrive3-3.16.589.msi'
$checksum       = 'A3C8248205966EE9B09858D350A7696270D5BF3C9A716F3928050665C3E80FE2'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart REINSTALL=ALL REINSTALLMODE=vamus'
  softwareName   = ''
  checksum       = $checksum
  checksumType   = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
