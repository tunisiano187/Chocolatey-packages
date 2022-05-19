$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.2.4/electron-v18.2.4-win32-ia32.zip'
$checksum = '75d305bc6c0e93c5eed09eb31f052e28694f8a8b8d5ec77c61feaef925e650b1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.2.4/electron-v18.2.4-win32-x64.zip'
$checksum64 = 'fc10a1c5fd9332e8fbe0ed562cea7907304f4e44f1d814016a6e865d3e30e452'
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
