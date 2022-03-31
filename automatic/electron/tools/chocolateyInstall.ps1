$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.0.1/electron-v18.0.1-win32-ia32.zip'
$checksum = 'b1344e34f7d02f6ca2e84d11c447419a210d5b288e45a068d1a5d8dd562b1aeb'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.0.1/electron-v18.0.1-win32-x64.zip'
$checksum64 = '7a47cf32330f41cc94066137d2b5f12a0fea88aaf8be1ad5ed3202d564aa35eb'
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
