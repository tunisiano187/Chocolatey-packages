$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.1.1/electron-v34.1.1-win32-ia32.zip'
$checksum = 'df0706231ea7d7e969199191c79cba16cba37e6dd7031b99db76a79274f89b2c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.1.1/electron-v34.1.1-win32-x64.zip'
$checksum64 = 'fb0891efa9d892cdba1604e922724c801dc758c744b037fcffb95b60d5171231'
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
