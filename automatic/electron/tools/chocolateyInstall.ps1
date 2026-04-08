$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.2.0/electron-v41.2.0-win32-ia32.zip'
$checksum = 'fd29259da67c8503c04d0a4a6f8e5d1bdb54f1202bab05665086b864a2c1903f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.2.0/electron-v41.2.0-win32-x64.zip'
$checksum64 = 'f6ccc690836fcc380199c6af7307e378cbdea73bd757a0d229200df7fc8e92d7'
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
