$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.1.4/electron-v28.1.4-win32-ia32.zip'
$checksum = '143179e253b84c62b388bf7eb8ccfaa98841a5e847e374aae8997d306db5e72d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.1.4/electron-v28.1.4-win32-x64.zip'
$checksum64 = '24816e2d023c49ce1776ea6002c90f8831db9db147b2f5814c9781d20cd114bf'
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
