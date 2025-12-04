$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.5/electron-v39.2.5-win32-ia32.zip'
$checksum = 'd64a1d8a76f0106a48712e297e76b43c4d7f52afa945f68855bc8d88e95411eb'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.5/electron-v39.2.5-win32-x64.zip'
$checksum64 = 'b3d9d4fde60587046ebbfd8c7163a9d3d0c4836ff5370a7c1c93e1e1126a6ac6'
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
