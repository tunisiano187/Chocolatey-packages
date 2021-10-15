$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v15.2.0/electron-v15.2.0-win32-ia32.zip'
$checksum = '9ecfe2b9124dc72eef7bbdfaa9e5af119e9a7d946d25915974a62e44bac347aa'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v15.2.0/electron-v15.2.0-win32-x64.zip'
$checksum64 = '43d1a0d9d9419110bbb6801cfd3f1c1c79fcfbfed3c3ad074e1fdf35cc4f874c'
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
