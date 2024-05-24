$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.8/electron-v30.0.8-win32-ia32.zip'
$checksum = '0227ecdc127cef47dfc404f8ed8b58991be992d5f1565a81b908f568c8fce69b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.8/electron-v30.0.8-win32-x64.zip'
$checksum64 = '17ac9e15a75370e2a031f877e44a5b38311085953e6b1c3048fecb44c1fff8fe'
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
