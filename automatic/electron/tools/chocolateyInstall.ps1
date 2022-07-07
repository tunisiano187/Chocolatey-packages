$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.8/electron-v19.0.8-win32-ia32.zip'
$checksum = '9b7c3ec140b12d6f6c3d9f82bc72d211e7d9347408b3b10a6f62a809bca79d1a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.8/electron-v19.0.8-win32-x64.zip'
$checksum64 = '60b5c16461ebd25344d531c4e206f0b3c3a54a6bd5b06174d959d574320743cf'
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
