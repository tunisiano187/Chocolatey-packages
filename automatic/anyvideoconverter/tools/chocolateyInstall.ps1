$ErrorActionPreference = 'Stop';

$url            = 'https://www.any-video-converter.com/avc-free.exe'
$checksum       = 'f5c246b248c426ac662c4b2ffffefb2065b1cb022e983f00bbaad9b4058b4dec'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = $url
  softwareName  = 'Any Video Converter*'
  checksum      = $checksum
  checksumType  = $checksumType
  validExitCodes= @(0, 3010, 1641, -1073741819)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
