$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.1/electron-v29.1.1-win32-ia32.zip'
$checksum = '0b2d5b1a92239767c53c92728ccff703d16b907583649935d2c26cd768964189'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.1/electron-v29.1.1-win32-x64.zip'
$checksum64 = '0b3feda0720ae45f0b908752fe417a0d0ae5945833a6e095d15483a65ba73966'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
