$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.8/electron-v16.0.8-win32-ia32.zip'
$checksum = 'f0e44c66024e423e4171492dc37c2c5b1e22f1a07b6f1588941c82de762e4d47'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.8/electron-v16.0.8-win32-x64.zip'
$checksum64 = '53297203f5d831b649865307b4387e9977fae45c511e2ef40039bb7968b6d24e'
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
