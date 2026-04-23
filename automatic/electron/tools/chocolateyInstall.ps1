$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.3.0/electron-v41.3.0-win32-ia32.zip'
$checksum = '8a52d3e670b6b481dbbf4c4a012a70365f76f9c9f3197896683208169804f36c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.3.0/electron-v41.3.0-win32-x64.zip'
$checksum64 = '08b60e4af9f39809b8e99f14036a5d150871f5e8e25e02c957c2a0f54eccd10d'
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
