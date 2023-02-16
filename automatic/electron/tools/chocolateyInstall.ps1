$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.1.0/electron-v23.1.0-win32-ia32.zip'
$checksum = '18007b5783fdb79a8c0a9424d3f64990b9cfa34f54b5699327f33e50a1be8328'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.1.0/electron-v23.1.0-win32-x64.zip'
$checksum64 = '5276ee6870459f16ee8469375306a6a7c03e469f59c844e6010656bc6428f0e6'
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
