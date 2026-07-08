$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.1.0/electron-v43.1.0-win32-ia32.zip'
$checksum = '5ac3d4a9e0ea2326cdc2c3a5a9c2b43e952b49b85b923246b9446441d5ec3aef'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.1.0/electron-v43.1.0-win32-x64.zip'
$checksum64 = 'a07dc1e3d5e589593d37e3b19d1b373e02bb58270e2eb0d6633eee0198ad09f0'
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
