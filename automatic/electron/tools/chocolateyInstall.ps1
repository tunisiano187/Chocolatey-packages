$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v21.1.0/electron-v21.1.0-win32-ia32.zip'
$checksum = 'bd0868d1b1b814ac4bae7d7084ca18db2f76f13419c337e819cc362833520b81'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v21.1.0/electron-v21.1.0-win32-x64.zip'
$checksum64 = 'fd45ac6862f8bbaee1f1caac1a10e0bbe0c59cc2e6c3052c1da5a3b38abc323b'
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
