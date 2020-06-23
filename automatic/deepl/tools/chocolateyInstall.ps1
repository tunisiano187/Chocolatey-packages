$ErrorActionPreference = 'Stop';
$url      = 'https://appdownload.deepl.com/windows/full/DeepLSetup.exe'
$checksum = '1498bfca4361b90d9f7f0345a5e0981b257270cc2d52761b4d3464fe22f8c6f4'

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName

  url          = $url
  checksum     = $checksum
  checksumType = 'sha256'

  silentArgs   = '/s'
}

Install-ChocolateyPackage @packageArgs
