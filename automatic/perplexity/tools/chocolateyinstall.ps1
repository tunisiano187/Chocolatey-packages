$ErrorActionPreference = 'Stop'

$url64          = 'https://download.todesktop.com/25020447d4kq915/Perplexity%20AI%20Setup%201.7.0-x64.exe'
$checksum64     = ''
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64bit       = $url64
  checksum64     = $checksum64
  checksumType64 = $checksumType64
  softwareName   = 'Perplexity*'
  # NSIS silent install
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
