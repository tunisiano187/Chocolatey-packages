$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.7/electron-v22.0.0-alpha.7-win32-ia32.zip'
$checksum = 'b9d85834f276dc0d273d84e9f38cca6158caf8289bd4493c7378393ab4b23ea7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.7/electron-v22.0.0-alpha.7-win32-x64.zip'
$checksum64 = '8fb215f5a11f68d3d802ab16442761e97282466dfaafaae12b2378bcdb498b0c'
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
