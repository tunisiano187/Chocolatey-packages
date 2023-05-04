$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.2.0/electron-v24.2.0-win32-ia32.zip'
$checksum = '224a2934ff1a6164ee49d4ceda58f7bfbe220ee64d1a4356485f36b2df6a80a8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.2.0/electron-v24.2.0-win32-x64.zip'
$checksum64 = 'c5842697deb4a8fdec07f469dee10c53bb3d693d8c6b80395471f3b94c7cafd7'
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
