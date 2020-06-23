$ErrorActionPreference = 'Stop';
$url      = ''
$checksum = ''

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName

  url          = $url
  checksum     = $checksum
  checksumType = 'sha256'

  silentArgs   = '/s'
}

Install-ChocolateyPackage @packageArgs