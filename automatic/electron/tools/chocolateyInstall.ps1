$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.6/electron-v16.0.6-win32-ia32.zip'
$checksum = '07208f8a5d83079697d39126759fba8b0621866c02c032675058ce519c4284c3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.6/electron-v16.0.6-win32-x64.zip'
$checksum64 = '081fb2a23b10e09dfda1bfc0103ed1956b07370772cc097a073d833f83c43159'
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
