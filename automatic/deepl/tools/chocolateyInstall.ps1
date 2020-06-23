$ErrorActionPreference = 'Stop';
$url            = ''
$checksum       = ''
$checksumtype   = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs