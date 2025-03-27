$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.2/electron-v35.1.2-win32-ia32.zip'
$checksum = '8b44907f72014eb77256af0a1f35c4b9ad7e2a2897d87aaf4eee1c5e9e6885a6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.2/electron-v35.1.2-win32-x64.zip'
$checksum64 = 'bb2099e637276645014c57cfb8762b058fc571cfd5e7ee6ce8ea5121a4ac9300'
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
