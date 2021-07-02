$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.5/electron-v13.1.5-win32-ia32.zip'
$checksum = 'b1836924b5de90b6db5fdd6d8524d3f09dd4aecddbcee04d0395c058a840efd8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.5/electron-v13.1.5-win32-x64.zip'
$checksum64 = '91563f4c4f8ddf782cbb1317df799e393d22034f0c848317692e5dec83d5be62'
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
