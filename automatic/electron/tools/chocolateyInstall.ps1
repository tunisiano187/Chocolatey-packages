$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.7/electron-v19.0.7-win32-ia32.zip'
$checksum = '570207e794d8fe338cb9b8d463e20daebd487af1580f80a6ccb94769db42f0fa'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.7/electron-v19.0.7-win32-x64.zip'
$checksum64 = '5437295cb3b7d2c55aef7e1f1dbdb3918eb25d01c43561cd9f62c63d1d542673'
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
