$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.6.0/electron-v40.6.0-win32-ia32.zip'
$checksum = 'c8c939132af5a5ae45de3c2a3fa25a31d30a2c22828ae7491e71f4f15c0d2de4'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.6.0/electron-v40.6.0-win32-x64.zip'
$checksum64 = 'f2de288cf1584431f3cf22c11bbb51e55448d4e1c4900a15c04e8420a26fc9cf'
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
