$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.6/electron-v39.2.6-win32-ia32.zip'
$checksum = '88801beb0afb718e95f606cb1747f5226bb22e5bd75c37b9b252e9dc71b90e99'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.6/electron-v39.2.6-win32-x64.zip'
$checksum64 = '0ec6e6d006def667370a8b21e60112a2740baae58450f5305b3ad9200220fea2'
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
