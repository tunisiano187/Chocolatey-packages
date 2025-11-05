$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.1.0/electron-v39.1.0-win32-ia32.zip'
$checksum = '9a3ca1b42a1378a1552b2aafc3743531c4aa019173d0c07894447dd03250cb9d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.1.0/electron-v39.1.0-win32-x64.zip'
$checksum64 = '1548e683164967d21a75e393d13669377e5bea5e05c08c98fabba4053d09cfaa'
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
