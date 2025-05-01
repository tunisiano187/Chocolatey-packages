$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.0.1/electron-v36.0.1-win32-ia32.zip'
$checksum = '1266b1b54d90d2b34b2b60396ae2eb86ba8a3eefefeaaebfc3ffe3cc1377eba8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.0.1/electron-v36.0.1-win32-x64.zip'
$checksum64 = '5021046b4c9df858be64e06e88f365a0f84b95f826d557a5ab944e73bfcab674'
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
