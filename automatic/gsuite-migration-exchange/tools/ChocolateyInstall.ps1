$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-migration-exchange'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/exchangemigration/GSuiteMigration.msi' 
$checksum       = '495B0B7D4574B17F28D6A2086D783289B549B3449B63C20BE9590A6AF5A0617E'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'G Suite Migration For Microsoft*'
  checksum       = $checksum
  checksumType   = $checksumType 
}

Install-ChocolateyPackage @packageArgs  
