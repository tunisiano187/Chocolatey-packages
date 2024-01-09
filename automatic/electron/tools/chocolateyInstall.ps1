$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.1.2/electron-v28.1.2-win32-ia32.zip'
$checksum = '411e4f63d1aa1fe05d2c2a307e7e1fceaa0fdb0c3635c08884ffa7a90ac3f2f0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.1.2/electron-v28.1.2-win32-x64.zip'
$checksum64 = '75b6a2a64d00662dd6ecc12119772614218a17ffcec9c400a1e1bd57acf5e43e'
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
