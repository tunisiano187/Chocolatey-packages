$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.0.1/electron-v41.0.1-win32-ia32.zip'
$checksum = '295bad5d1ee75bc7ce4e9f4afbfde9b2f53c4c5eace1a216782a90422aaf8a82'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.0.1/electron-v41.0.1-win32-x64.zip'
$checksum64 = '693d488121f34c7b0e04b1fdd415aeff35cd58782f00aab535dc5de09723ff75'
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
