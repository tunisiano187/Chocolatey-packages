$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.0.0/electron-v43.0.0-win32-ia32.zip'
$checksum = 'cf5d0812cc161d71b82c27036e46d528663874462168439145e7d7d084f02a60'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.0.0/electron-v43.0.0-win32-x64.zip'
$checksum64 = 'a195f798837e4c5719b462d3210c47619f6fc44ce032d06dbdcfbc88327b26e0'
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
