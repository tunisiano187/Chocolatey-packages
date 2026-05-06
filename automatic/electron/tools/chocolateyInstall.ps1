$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.0.0/electron-v42.0.0-win32-ia32.zip'
$checksum = '8644188454e4bfc8ef5b0881ada6819ede01d3596f941e5dcade7da76d116626'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.0.0/electron-v42.0.0-win32-x64.zip'
$checksum64 = '2707fbf25e0e18211a00f90b97e0fb2a00cf10a17ef0fa9d873e177e1d3286bc'
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
