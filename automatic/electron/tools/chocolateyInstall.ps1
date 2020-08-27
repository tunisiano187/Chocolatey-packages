$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.0.1/electron-v10.0.1-win32-ia32.zip'
$checksum = '3f4fc519836adb624226a4f139ca06fb061ff5c8913b07fd3823a5c88d8b25d2'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.0.1/electron-v10.0.1-win32-x64.zip'
$checksum64 = '1651c59a980e140bc73dceeb0859b6b595e2d62d40a58bb58a3d3032aa4cfd90'
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
