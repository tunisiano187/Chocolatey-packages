$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.2.3/electron-v28.2.3-win32-ia32.zip'
$checksum = 'fa9c98b9ead4eeb73d751e253d181484abf8d875cf4dfae9af8b3313b7c8454c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.2.3/electron-v28.2.3-win32-x64.zip'
$checksum64 = '037ecd7935b3a0c6ade0976427cd109da3a66c01d13bc4ab08c810fb876c9974'
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
