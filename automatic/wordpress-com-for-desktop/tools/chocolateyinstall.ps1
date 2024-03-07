$ErrorActionPreference = 'Stop';

$url32          = ''
$checksum32     = ''
$checksumType32 = ''

$packageArgs = @{
  packageName    = 'wordpress-com-for-desktop'
  installerType  = 'exe'
  url            = $url32
  checksum       = $checksum32
  checksumType   = $checksumType32
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'WordPress.com Desktop*'
}
Install-ChocolateyPackage @packageArgs
