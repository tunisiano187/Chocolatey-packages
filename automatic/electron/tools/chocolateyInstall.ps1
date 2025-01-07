$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v33.3.1/electron-v33.3.1-win32-ia32.zip'
$checksum = 'c252746d34cfa7f7ca7724241a5deffc0f2ceaffbd610d9fff0119440c3ad173'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v33.3.1/electron-v33.3.1-win32-x64.zip'
$checksum64 = 'be72dd21104ec30105597684f535e7f97ce903f1f208b0b97d650bd3e0d961c9'
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
