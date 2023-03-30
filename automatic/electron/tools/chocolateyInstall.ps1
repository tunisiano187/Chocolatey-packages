$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.2.1/electron-v23.2.1-win32-ia32.zip'
$checksum = '9cebe785a93ead89c3b007231d169d5d8e84d2cf808a0428b6593ed6e8dd28cf'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.2.1/electron-v23.2.1-win32-x64.zip'
$checksum64 = '2ba2cea7bbbc72ea24d60e0b772ba1b235fa5df0c2911fd328c820a70fa9d058'
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
