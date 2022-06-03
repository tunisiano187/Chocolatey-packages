$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.3/electron-v19.0.3-win32-ia32.zip'
$checksum = 'fd911160b135edf1244b36b24508cc6ee7da28d1d1c25bbbe23ea4c4f633b733'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.3/electron-v19.0.3-win32-x64.zip'
$checksum64 = '3fa92bc715c7376a39f207bd1c4ac9e3e13491c40dbf6ca34d817581b84c3812'
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
