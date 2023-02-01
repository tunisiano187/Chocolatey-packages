$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.2.0/electron-v22.2.0-win32-ia32.zip'
$checksum = '0d284dbf3be8cf9a73c3d5d97b5220034a6fd2db9198cc5c9d7be0a915a00ab7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.2.0/electron-v22.2.0-win32-x64.zip'
$checksum64 = 'a02a7f60f9e8f1745b15753bb8f9c0319c2e4f503430ec282b171343760f6156'
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
