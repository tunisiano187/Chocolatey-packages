$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.5/electron-v29.1.5-win32-ia32.zip'
$checksum = '949d96658f2371a0e46940eab673c330b4322fa02d8c4dbcbb71b5656c1a96f1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.5/electron-v29.1.5-win32-x64.zip'
$checksum64 = '7dc1822b40677955db5a2b6b89820787541971576a23a65ec6065f4e74f4c857'
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
