$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.0.2/electron-v34.0.2-win32-ia32.zip'
$checksum = '3e7a547f788debfac68e60ace4c0ffb62b48550db7f1182ea404b549ff48fdf8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.0.2/electron-v34.0.2-win32-x64.zip'
$checksum64 = 'cc0a4fb7b25fe2c41a78e07e799fc0a20f222622911b9db52b46eb1028834280'
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
