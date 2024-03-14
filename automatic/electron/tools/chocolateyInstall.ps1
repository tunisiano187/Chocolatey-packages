$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.4/electron-v29.1.4-win32-ia32.zip'
$checksum = '2bcb37d06339459780ae9670d469cbb1bc7cd3a5b7dfe84a7638c1ec9abac987'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.4/electron-v29.1.4-win32-x64.zip'
$checksum64 = '4ab106a5b7bb4830ee7205aee40c48b5716d63d45a4138034f54eb059415008d'
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
