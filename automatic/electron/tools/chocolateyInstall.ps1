$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.0.0/electron-v17.0.0-win32-ia32.zip'
$checksum = '76337a227840e043c482da1d2ca2f63f616c041a95d5413be2c363ede38a115c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.0.0/electron-v17.0.0-win32-x64.zip'
$checksum64 = '70b0836276331c5c646c857bbd5133006ca0fa04b6c33b9c20af0889e7f95d2c'
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
