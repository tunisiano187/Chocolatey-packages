$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.1.0/electron-v42.1.0-win32-ia32.zip'
$checksum = 'c5c4bd571905870154d27a7ba78367fdce388aaa3630d1ac73e4f418bdbe51ef'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.1.0/electron-v42.1.0-win32-x64.zip'
$checksum64 = '0b03582d0a68dce8473fcc090114dabef7eaafd52b6d8cd2c85b000358c6af31'
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
