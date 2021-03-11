$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.1/electron-v12.0.1-win32-ia32.zip'
$checksum = 'f8079c52456edc68226a741be8115a9bc670716a2a89d06c11bdb78085df9abb'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.1/electron-v12.0.1-win32-x64.zip'
$checksum64 = 'a4db9a7402672954fde07dee11cb0fd0609ff238fe671620f45d7b875ea436b5'
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
