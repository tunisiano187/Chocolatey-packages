$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum       = '7ea4e4d83debb247875598eaea39379a14aa41012b114e7f412dce9388918f21'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
