$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.1.1/electron-v23.1.1-win32-ia32.zip'
$checksum = '2dd921d340e8fa3b2d494c05988f8db657212d8f08cf7e71124a8ffbec4f3e6e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.1.1/electron-v23.1.1-win32-x64.zip'
$checksum64 = '18fce453ad305440a70bba5adf4cc608675fbbaab1f1180f83aac2f249591b04'
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
