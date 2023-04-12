$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.1.0/electron-v24.1.0-win32-ia32.zip'
$checksum = 'f2722551acdc337cb12acd1b0fa1b1df492766f77863a94cc161aed36a01321c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.1.0/electron-v24.1.0-win32-x64.zip'
$checksum64 = '2fb60f93b4df941819b966d84863439e301ab51dca0994c02879d49044565a16'
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
