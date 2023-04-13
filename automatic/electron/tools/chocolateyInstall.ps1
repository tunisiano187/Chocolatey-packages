$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.1.1/electron-v24.1.1-win32-ia32.zip'
$checksum = '8afab0bc18ed0bb1f3a8860982bf389e66f58e596b5a25c34466c0ac82a2012f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.1.1/electron-v24.1.1-win32-x64.zip'
$checksum64 = 'cddb7a7fc2165b7b5d3435f4a303ad392eaae52c6a8822794669c11c833a74a5'
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
