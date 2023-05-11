$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.3.0/electron-v24.3.0-win32-ia32.zip'
$checksum = 'c6cb4203702bd19be2e23e3ca5fce51cc92761b8a90395bab6ce637e0f2d24d4'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.3.0/electron-v24.3.0-win32-x64.zip'
$checksum64 = '5657cf17cda2276900309941ff324dfb83802beb9829d9174a91de7b9b4ad2d8'
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
