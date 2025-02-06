$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.1.0/electron-v34.1.0-win32-ia32.zip'
$checksum = '5e5a4a87623920e03ac62b60f6a6cdbb146265437ae1deb20903f40b151eb3f0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.1.0/electron-v34.1.0-win32-x64.zip'
$checksum64 = '059e628cb591a8eac961b255aa81d64d2b414295ff6984efd2b8fdf3dce9f40a'
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
