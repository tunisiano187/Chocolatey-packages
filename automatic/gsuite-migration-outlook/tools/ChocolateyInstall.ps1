$packageName    = 'gsuite-migration-outlook'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/tag/s/appguid%3D%7B7DF3B6EE-9890-4307-BDE5-E1F3FCB09771%7D%26iid%3D%7BA1C292A4-DEB8-B74C-43D1-F825CFDD69AB%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DG%2520Suite%2520Migration%2520for%2520Microsoft%2520Outlook%25C2%25AE%26needsadmin%3Dtrue/outlookmigration/OutlookMigrationSetup.exe'
$checksum       = '9DC5584530E774374AE2B24207745AB6235B2157602272EA8D2EB0B3C0B14327'
$url64          = ''
$checksum64     = ''
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

