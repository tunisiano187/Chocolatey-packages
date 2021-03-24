$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.2/electron-v12.0.2-win32-ia32.zip'
$checksum = 'f7ed2e1e13b78d0ea8c806992a4d844740e54854d835fb42ac105376bf1fdcea'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.2/electron-v12.0.2-win32-x64.zip'
$checksum64 = '234bf89cf5a1763ead9ca5eb397426e2ccb080232d96353985db72cfefba1557'
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
