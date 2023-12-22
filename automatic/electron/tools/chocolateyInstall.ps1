$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.1.0/electron-v28.1.0-win32-ia32.zip'
$checksum = 'e7c9f0c30df0f999b3b9b736ef0f194318a176840ac4de881d7cddc86cc64548'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.1.0/electron-v28.1.0-win32-x64.zip'
$checksum64 = '6ab17fa3ec537e7d9a5e6483f321a0634333c30a6fdfaec1cc8fd07953cbff89'
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
