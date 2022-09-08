$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.1.2/electron-v20.1.2-win32-ia32.zip'
$checksum = 'dd66678c2fc587093ca2f752bd0b03d242f51908da5bf1df9ce77366e9d899f7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.1.2/electron-v20.1.2-win32-x64.zip'
$checksum64 = '64e3e790c058548efc3507e224e9b081551db4d16d49976f94adb188dabaa4cf'
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
