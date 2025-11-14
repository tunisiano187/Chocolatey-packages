$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.0/electron-v39.2.0-win32-ia32.zip'
$checksum = 'ec26e39186d03e21a16067652083db2bbf41d31900a5d6e38f2bbdf9f99f7e5f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.0/electron-v39.2.0-win32-x64.zip'
$checksum64 = '8d483a77100dda798af0becdda1a037e4079ad9ec1e49d768bfb671f95122ce2'
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
