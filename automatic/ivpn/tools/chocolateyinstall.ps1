
$ErrorActionPreference = 'Stop';
$url          = 'https://www.ivpn.net/releases/win/IVPN-Client-v2.7.7.exe'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ivpn*'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs