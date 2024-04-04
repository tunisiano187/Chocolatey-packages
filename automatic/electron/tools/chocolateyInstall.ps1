$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v29.2.0/electron-v29.2.0-win32-ia32.zip'
$checksum = '9c3da4ef3842c1c25791e45269c5a8f916ac37dc4f4a8c339fa7250a75277ee9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v29.2.0/electron-v29.2.0-win32-x64.zip'
$checksum64 = '71f7180a0b8edec289fe31fda631d91d1cebfe2c382f424a75aa60c9b33b90b6'
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
