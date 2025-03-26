$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.0/electron-v35.1.0-win32-ia32.zip'
$checksum = 'c1e9f252a4dc178f0d05782472f2f59c9083fb829104d95f4310ac1ed51c9158'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.0/electron-v35.1.0-win32-x64.zip'
$checksum64 = 'f3fa60e7e7a3d8c73feac15677f6ba39536f511d862fac0aa02e9b7b9f3db727'
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
