$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.0.1/electron-v31.0.1-win32-ia32.zip'
$checksum = '16fda6510f7210cd62957257f026f721f6de25704eca2fff22763a1275cdd1ca'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.0.1/electron-v31.0.1-win32-x64.zip'
$checksum64 = '990a46338b1ce0b74abcfe1e52f56dbd1326f1a062a7744582edc1c07985cf62'
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
