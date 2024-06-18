$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-sync-outlook'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/google-apps-sync/enterprise_gsync.msi'
$url64          = 'https://dl.google.com/dl/google-apps-sync/x64/enterprise_gsync.msi'
$checksum       = '195F1E9C54A8F65137CFBDC69A27B33FD72DD2C61F8704873288F363621BC791'
$checksum64     = 'C826E05BA0D226B5BF6FE0348B63010C7FAB739B0BB1C1CD77DFDC0EE395F303'
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

