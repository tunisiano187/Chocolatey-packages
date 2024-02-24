$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'
$checksum       = '0037c9895723fb712b57b144cbb429f319ab5a3c1e4c44a3ffefa351486bcdaf'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
