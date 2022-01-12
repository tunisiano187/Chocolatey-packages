$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.7/electron-v16.0.7-win32-ia32.zip'
$checksum = '431415d2cccb26044858ba4114cdd31a208ec84c27ac74071cac4cdd2ac192ba'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.7/electron-v16.0.7-win32-x64.zip'
$checksum64 = '444e97576f2f9497da0f49c571938ac03fab3b335591cb313a1e210d71b0a9af'
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
