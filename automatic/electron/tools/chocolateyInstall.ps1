$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.3.1/electron-v24.3.1-win32-ia32.zip'
$checksum = '74d6b9db34d8ce70f0f6f9cbff158f7384cc822b43aea054568613220df3c1a0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.3.1/electron-v24.3.1-win32-x64.zip'
$checksum64 = '82d392bbe407d6590b13f50f61038f926a2e0195bf05a3b7fde67adbf614c574'
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
