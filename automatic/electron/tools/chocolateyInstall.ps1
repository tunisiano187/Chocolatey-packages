$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.0.1/electron-v20.0.1-win32-ia32.zip'
$checksum = 'c88bca7e2cf508ccb799031ccaa8389a7c1abe5b1800212f4f91631a12dd7abc'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.0.1/electron-v20.0.1-win32-x64.zip'
$checksum64 = 'da7898424c772a360cdd7248b98ef0c71f5ec0427ef6c48414e4388ac9214a56'
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
