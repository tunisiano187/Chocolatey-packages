$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v38.4.0/electron-v38.4.0-win32-ia32.zip'
$checksum = '0c795af59adbcc8ed9cc321f0a3d717ee2ee65a57a60dc4fb6907d514acfa8cc'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v38.4.0/electron-v38.4.0-win32-x64.zip'
$checksum64 = '148390b877a8dc820628e387c94222898a2fa1e874819ff8250beafa4bd3b4a8'
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
