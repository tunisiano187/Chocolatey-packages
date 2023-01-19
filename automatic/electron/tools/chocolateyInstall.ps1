$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.3/electron-v22.0.3-win32-ia32.zip'
$checksum = '3c5458d5eb1b7b8f84ffe7a5c45349739a4b1df9c2e698229afa454732ed6b54'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.3/electron-v22.0.3-win32-x64.zip'
$checksum64 = '7355fd5a648b5e36a13ec7f35315e9222a32833fd49d8478e66d3edde75debe6'
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
