$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.6/electron-v22.0.0-alpha.6-win32-ia32.zip'
$checksum = '2b546a938d0b098a6bf012b44ba5fa4ed8f7c2e287df02e96313e615967c4b34'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.6/electron-v22.0.0-alpha.6-win32-x64.zip'
$checksum64 = '9b4e45d31ae7cfbdfd8b21839d9c8d4d5557c0dca32d66f43e292fbcc1e899e8'
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
