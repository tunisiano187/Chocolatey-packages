$packageName    = 'gsuite-migration-outlook'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/outlookmigration/enterprise_outlookmigration.msi'
$checksum       = '9314162D813C3644AC546ED0265BCBC1A1B878329B1B2A7E669FA993A1AAA6B3'
$url64          = 'https://dl.google.com/dl/outlookmigration/x64/enterprise_outlookmigration.msi'
$checksum64     = '32DFEAB7715B8D0CA823E77B7BBC3DFEB59D48FD21BB06FF6109E578DB0AF515'
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

