$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.0.4/electron-v18.0.4-win32-ia32.zip'
$checksum = '1f81ebf840de0a6cf492144274a67f5ef54779273444fa46097f8671a10d1d07'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.0.4/electron-v18.0.4-win32-x64.zip'
$checksum64 = 'f3d39a8be8d33a6f973d078551bdc86fc7f81970c882050892966c6c128efa99'
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
