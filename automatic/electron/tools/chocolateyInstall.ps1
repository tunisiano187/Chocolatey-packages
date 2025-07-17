$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.2.3/electron-v37.2.3-win32-ia32.zip'
$checksum = '16980a3a4db73d03bc74bfdb8d9b5e63bc8dd55f0db02b8007182ff9e4290700'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.2.3/electron-v37.2.3-win32-x64.zip'
$checksum64 = 'df2925e059f87316272d8a495602025561a133904f2275387710e15948ed8d8a'
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
