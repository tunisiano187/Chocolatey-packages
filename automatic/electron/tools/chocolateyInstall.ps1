$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.0.0/electron-v41.0.0-win32-ia32.zip'
$checksum = 'abb76fb78bfac2579f104e39f53a965134714be327f058e2a9c2e44e0adac3d0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.0.0/electron-v41.0.0-win32-x64.zip'
$checksum64 = '2e69a07219b05b625b3a2631a3e025f2f7b9ddb7419c49f1a5623d04c0d74d91'
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
