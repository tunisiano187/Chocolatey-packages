$ErrorActionPreference = 'Stop';

$url            = ''
$checksum       = ''
$checksumType   = ''


$packageArgs = @{
  packageName   = 'android-messages-desktop'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  softwareName  = 'Android Messages*'
  checksum      = $checksum
  checksumType  = $checksumType
  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs