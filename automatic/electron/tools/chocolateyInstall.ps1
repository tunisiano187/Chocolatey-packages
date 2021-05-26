$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.0.1/electron-v13.0.1-win32-ia32.zip'
$checksum = 'e031e2b2ac7f1a4b9d0026648f57897543f24106e333aa83c25911e88cbc38e8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.0.1/electron-v13.0.1-win32-x64.zip'
$checksum64 = 'e97a7ed8d07a42c0f18b35831c82932143c4d2bf2cc19ed90a2eefabd6bebfad'
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
