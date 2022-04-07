$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.0.3/electron-v18.0.3-win32-ia32.zip'
$checksum = '16cbde3d28526a3f339e55edaddccf67e4cb104edd47d625c27a78027059dbca'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.0.3/electron-v18.0.3-win32-x64.zip'
$checksum64 = '215db27a83dcb0340dd22c124aa3ed3bfd76fdcba931950699a4dfb3242ef9b7'
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
