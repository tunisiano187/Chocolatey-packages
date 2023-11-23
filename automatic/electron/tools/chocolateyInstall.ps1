$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.1.2/electron-v27.1.2-win32-ia32.zip'
$checksum = 'b4ba9608247b28d6ac83ae2a70237554ccf0b7649bd21cfade9e17c63164c652'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.1.2/electron-v27.1.2-win32-x64.zip'
$checksum64 = '57b40918a81bc13da9c622d562be25075d76f345aa124938c912653a62797da6'
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
