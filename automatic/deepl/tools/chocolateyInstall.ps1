$ErrorActionPreference = 'Stop';
$url            = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum       = 'ec79394c4e470e64efa8a8c3b70ea14a66aef2aac109c3f6fe56a9a12b83d6a4'
$checksumtype   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumtype

  silentArgs     = '/s'
}

Install-ChocolateyPackage @packageArgs
