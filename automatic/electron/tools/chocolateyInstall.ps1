$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.0.3/electron-v35.0.3-win32-ia32.zip'
$checksum = '99ff893b16c2e86f352ca1f7d4134a801c4619f899b0e8d017579f8e9a669c58'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.0.3/electron-v35.0.3-win32-x64.zip'
$checksum64 = '9e2abe0f0bed57d03dd0ec55bad93a351025ce36aa2e7c376a8c4ae03553c3e4'
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
