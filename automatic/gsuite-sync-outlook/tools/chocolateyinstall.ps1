$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-sync-outlook'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/google-apps-sync/enterprise_gsync.msi'
$checksum       = 'AF63A3DE66B580962E9FBD4526E7E24A168ABAF01C71E66807DC48F6C4A5927E'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI' 
  url            = $url
  softwareName   = 'Google Apps Sync*' 
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = ''
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum variable

