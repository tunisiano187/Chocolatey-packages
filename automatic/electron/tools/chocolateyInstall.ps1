$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.0.4/electron-v27.0.4-win32-ia32.zip'
$checksum = '353435f6f3c2c7ad4213d97c1fc7a454f95ad1413002c388c754fcab5496a5d1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.0.4/electron-v27.0.4-win32-x64.zip'
$checksum64 = '5a5c9841b6522604937e46a3788f1041fc1521532876d0290e13a8f8d968ca7d'
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
