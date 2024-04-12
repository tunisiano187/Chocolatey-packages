$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'
$checksum       = 'f9beee004216465521a3072a1523059d741e69414050394ea554d327c3db2a73'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
