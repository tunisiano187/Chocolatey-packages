$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.1.3/electron-v20.1.3-win32-ia32.zip'
$checksum = 'c7e25c2be8705fed7628e5d7f33a14957bbcb3c01829791fbd352b0848130325'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.1.3/electron-v20.1.3-win32-x64.zip'
$checksum64 = '4bcd4a58efd584a5a6d61ca824fa56ce2fca20c42bc5b685ad8d32643d96ceb5'
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
