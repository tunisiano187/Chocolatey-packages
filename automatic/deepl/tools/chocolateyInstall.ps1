$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum       = 'bd7d7725df388b84455479d88dc284b7b466be1ba3247765805debda3d903328'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
