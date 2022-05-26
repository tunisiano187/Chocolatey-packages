$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.1/electron-v19.0.1-win32-ia32.zip'
$checksum = 'dcc44b32bdf5a58f3ae3520003a6202e2204fd3efe5f2754cfc2eef18862d1c3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.1/electron-v19.0.1-win32-x64.zip'
$checksum64 = '3d6bab34a05e95d0e3836391f5f745d95776b0add1fda20803ad82a89f6d922d'
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
