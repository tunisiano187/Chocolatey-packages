$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.3.1/electron-v25.3.1-win32-ia32.zip'
$checksum = 'c377d1fe50de0e49f937f9bf2db92750340565e306cfd895bc8ab1422fc5d1e3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.3.1/electron-v25.3.1-win32-x64.zip'
$checksum64 = 'f94b0099c2d81c914a65ba7b6c0d776f68cfee7d5438d57b3911497ca4ca37bf'
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
