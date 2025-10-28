$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.0.0/electron-v39.0.0-win32-ia32.zip'
$checksum = '0c4c61320dff115cb3609ae2d110b48c6b959836a8626ac8ed6fe2094417071a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.0.0/electron-v39.0.0-win32-x64.zip'
$checksum64 = 'bdcf82b95100a4b770dded1587d8d9dafddf782079127a8dbdc1891faef324a5'
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
