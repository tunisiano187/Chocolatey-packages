$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.1.5/electron-v10.1.5-win32-ia32.zip'
$checksum = 'cc59171f4236f4d8f9cb5e445cea04c52b2201c42a8e5e5089e41f91826b15b8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.1.5/electron-v10.1.5-win32-x64.zip'
$checksum64 = 'e5f0bf09aea0d1def6839dc08e7a56bac5679bb1001ab3cb3088922391dba53c'
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
