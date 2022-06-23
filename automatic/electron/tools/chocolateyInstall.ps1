$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.6/electron-v19.0.6-win32-ia32.zip'
$checksum = '90c88983adbf61d64119880554d02f15351b66b502f69863dbc8619215ccb995'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.6/electron-v19.0.6-win32-x64.zip'
$checksum64 = 'bda7244353d29f0ce51b547298863f8f996a5b898b85480fc2b7e433d0dab9d0'
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
