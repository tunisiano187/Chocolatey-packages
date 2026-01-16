$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.0.0/electron-v40.0.0-win32-ia32.zip'
$checksum = '0b822fc166f3b16746e7202d6d9ee7ec3b75344ed715ca8932a694efc6452ba2'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.0.0/electron-v40.0.0-win32-x64.zip'
$checksum64 = '6665772ce7a3cec17925f6a8fbdb5f678d758fcbe7b86dca818d12832e084771'
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
