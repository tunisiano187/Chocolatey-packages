$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.3.0/electron-v31.3.0-win32-ia32.zip'
$checksum = 'ff2f7ef969e08249c28318bf1525dc44b453de4ec4de14ff233c8697d7109050'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.3.0/electron-v31.3.0-win32-x64.zip'
$checksum64 = 'a2cef2b0f9c68480cb59c73a08b83670f587d2c245e73a65b3397cb4836d14d5'
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
