$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'android-messages-desktop'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = 'https://github.com/chrisknepper/android-messages-desktop/releases/download/v0.7.1/android-messages-desktop-setup-0.7.1.exe'
  softwareName  = 'Android Messages*'
  checksum      = 'F909E96B0C3027D09C3811BB112DBDB0BC3D85C6F687CAFFA60B35168704F358'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs