$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.2.0/electron-v34.2.0-win32-ia32.zip'
$checksum = '96396712a0240f04471f71246b3885a513b08e3f2d40154272d34e59419db7e6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.2.0/electron-v34.2.0-win32-x64.zip'
$checksum64 = 'a4fdf617dca787b7f1c6f8d0d1cb69c8adb37ee23f9553fe69803f9cad713360'
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
