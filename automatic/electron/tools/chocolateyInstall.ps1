$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.1.1/electron-v39.1.1-win32-ia32.zip'
$checksum = '7fd9cd118a4b9af2639cdb61d88680bfca167928b8f351900810bb9f44164c85'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.1.1/electron-v39.1.1-win32-x64.zip'
$checksum64 = '31fe123b0d34c95a9c4b309835997e97d1e71272eb17c20676e19720c6530aea'
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
