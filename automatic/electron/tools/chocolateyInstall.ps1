$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.4.0/electron-v43.4.0-win32-ia32.zip'
$checksum = '3a61c1eb57f78c41528701bb30d96dd06d6be68c14ba9e0d81d654cc8302508e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.4.0/electron-v43.4.0-win32-x64.zip'
$checksum64 = 'ef0709cfa719739acce73de6f9b684304baf38c6454376638a70d34a7cecffe0'
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
