$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum       = 'fd5f4e3c9ffd4823642a4049a476e7a1394c1178b37be45323a3cc5891c74eac'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
