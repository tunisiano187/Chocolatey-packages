$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.1.2/electron-v39.1.2-win32-ia32.zip'
$checksum = '14abbf0cbca810ffb29ac152a4f652ee79eb361f3dc8800175e13a90e9273f7c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.1.2/electron-v39.1.2-win32-x64.zip'
$checksum64 = 'aa993df5bfcc4019f287273d1244248e448228a94867c842f10ab25d16005bf2'
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
