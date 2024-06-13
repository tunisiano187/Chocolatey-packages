$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-sync-outlook'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/google-apps-sync/enterprise_gsync.msi'
$url64          = ''
$checksum       = 'AF63A3DE66B580962E9FBD4526E7E24A168ABAF01C71E66807DC48F6C4A5927E'
$checksum64     = ''
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64          = $url64
  softwareName   = 'Google Apps Sync*'
  checksum       = $checksum
  checksum64     = $checksum64
  checksumType   = $checksumType
  checksumType64 = $checksumType
  silentArgs     = ''
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

# UPDATE INSTRUCTIONS:
# Update checksum variable

