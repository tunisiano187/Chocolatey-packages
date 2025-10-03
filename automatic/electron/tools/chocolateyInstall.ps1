$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v38.2.1/electron-v38.2.1-win32-ia32.zip'
$checksum = '86e2b1e76801b4ce0388467189593bcc58a75ad2ed436810c0e604f9ecfb2df6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v38.2.1/electron-v38.2.1-win32-x64.zip'
$checksum64 = 'e3831387518acc8430fa674e585d24833aabb994dae43bcca0257302c0816967'
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
