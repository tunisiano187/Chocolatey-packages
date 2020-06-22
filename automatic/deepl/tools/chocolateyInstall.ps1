$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName

  url          = 'https://www.deepl.com/windows/download/full/DeepLSetup.exe'
  checksum     = '1498BFCA4361B90D9F7F0345A5E0981B257270CC2D52761B4D3464FE22F8C6F4'
  checksumType = 'sha256'

  silentArgs   = '/s'
}

Install-ChocolateyPackage @packageArgs