$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.7.0/electron-v40.7.0-win32-ia32.zip'
$checksum = 'a4394e1148f61234245aa04ce8aee94dc9739f5d51f7338ac35d01c39f50c56b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.7.0/electron-v40.7.0-win32-x64.zip'
$checksum64 = '4639e33056d65ab4cd205032455e4efd6f9ef0d12b6b2a11f149ddb2584bb7ec'
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
