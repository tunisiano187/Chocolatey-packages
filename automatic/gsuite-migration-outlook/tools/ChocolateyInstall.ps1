$packageName    = 'gsuite-migration-outlook'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/outlookmigration/enterprise_outlookmigration.msi'
$checksum       = 'BA711B01AE6763EFE9527928607B68BD35B9E623D57A6CE71E5C28380772AF87'
$url64          = 'https://dl.google.com/dl/outlookmigration/x64/enterprise_outlookmigration.msi'
$checksum64     = '445915E25EA46F7FB14FF64116FBFD754F08BCFB945902A81C04BD6BD7C0DC9B'
$checksumType   = 'sha256'
$silentArgs     = '/silent /installsource silent /install'
$validExitCodes = @(0)

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  url64         = $url64
  softwareName  = 'Google Apps Migration for Microsoft Outlook*'
  checksum      = $checksum
  checksum64    = $checksum64
  checksumType  = $checksumType
  silentArgs    = $silentArgs
  validExitCodes= $validExitCodes
}

Install-ChocolateyPackage @packageArgs

