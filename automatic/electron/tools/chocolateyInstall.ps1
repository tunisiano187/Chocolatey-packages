$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.1.1/electron-v17.1.1-win32-ia32.zip'
$checksum = '33cf2ff7e265e1a56a8b91ab65732249478e7bfb8c3572f1486795295557a6d0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.1.1/electron-v17.1.1-win32-x64.zip'
$checksum64 = '34222fd200a604c5e284928f61385b8d4a2b9accd17c067aede2a0d6176551be'
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
