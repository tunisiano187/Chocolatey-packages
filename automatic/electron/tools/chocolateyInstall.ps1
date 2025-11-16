$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.1/electron-v39.2.1-win32-ia32.zip'
$checksum = 'ad7cb3308f5fb46c7382390de4e7830638bff9d8b072dc351cb4548f4a219332'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.1/electron-v39.2.1-win32-x64.zip'
$checksum64 = '71b6dfe3a1e68e95f2de5bcf83db6328d519b96e2f3fa4112ed0930b80dda9d1'
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
