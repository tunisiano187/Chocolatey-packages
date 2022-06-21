$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.5/electron-v19.0.5-win32-ia32.zip'
$checksum = 'acb853147fdb6fdede9c98629c6fe6a5a4f46385cf01abf090aad5e1ed5d7f50'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.5/electron-v19.0.5-win32-x64.zip'
$checksum64 = 'f06d55adb74d417e3f1fa52c3a1f21c4b7a661941f67b34854bb2251855a8da6'
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
