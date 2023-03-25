$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.2.0/electron-v23.2.0-win32-ia32.zip'
$checksum = '077a60044fd6a2889695c444fe8135b9b7290167dc2c4ac3251714a86f0e9e54'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.2.0/electron-v23.2.0-win32-x64.zip'
$checksum64 = '9daa5eba6473e2b8010722482095a901df2c77795887fbd30298247fa3329cfb'
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
