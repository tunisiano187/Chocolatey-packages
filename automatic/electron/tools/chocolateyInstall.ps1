$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.8.0/electron-v40.8.0-win32-ia32.zip'
$checksum = '37264626708fbcdc443e5f6afb15ef6bcb0df1175796314472bda0e27591461f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.8.0/electron-v40.8.0-win32-x64.zip'
$checksum64 = '1a4e17a87e04bdd21c327f187556cb8d0cd33c499aefc174256f826a1849cfb6'
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
