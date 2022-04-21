$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.1.0/electron-v18.1.0-win32-ia32.zip'
$checksum = 'cfe01c2f3ae051b07dfcac0b4347ac0ed04154b78c0fe4902476053346f2dfe4'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.1.0/electron-v18.1.0-win32-x64.zip'
$checksum64 = '1d780ecd2676088c267ca1952722e92b32337c18d378879f236d07c86e167ece'
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
