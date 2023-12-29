$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/0install/DeepLSetup.exe'
$checksum       = 'cac980c207b8653c98a3fb671b2bf1ff59e49e8b36bb74a757935129a6f870c8'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
