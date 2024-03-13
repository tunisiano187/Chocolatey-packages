$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.1.2/electron-v29.1.2-win32-ia32.zip'
$checksum = 'bcc0f6789ea2d8f0f9c516b4aa8789a9b9ac1793ea1d19583785fc306bbb406e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.1.2/electron-v29.1.2-win32-x64.zip'
$checksum64 = '89d753e8134774f7caa35886d461ee58aee05ac8a58609c827e4eb471b71270f'
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
