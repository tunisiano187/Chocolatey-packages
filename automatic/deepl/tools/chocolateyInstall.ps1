$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'
$checksum       = 'ccdde4fda138a52c9e1e3d9c230acbe413e4dc121bdbbd1dd43b1eb36b966219'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
