$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.1/electron-v30.0.1-win32-ia32.zip'
$checksum = '4430530331cbfd52632ece0cd2b55fe24a73cbe9c37833cfa8692234724dddf1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.1/electron-v30.0.1-win32-x64.zip'
$checksum64 = 'ca6801afcaa80e16420d5b3a637d5f468ae439c681f3221a1bf6d20ffcc00110'
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
