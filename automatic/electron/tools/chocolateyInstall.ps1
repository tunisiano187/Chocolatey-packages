$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.2.1/electron-v26.2.1-win32-ia32.zip'
$checksum = 'a262b1fc0614b22f5d7fecb491a74790737588b5f8c7c724724a74730259446a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.2.1/electron-v26.2.1-win32-x64.zip'
$checksum64 = '37f52aa5382900eb59911e8090b4521f1e02572190c69fb0e2f364c7562bb163'
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
