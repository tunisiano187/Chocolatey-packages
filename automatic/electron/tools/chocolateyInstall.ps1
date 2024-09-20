$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.1.2/electron-v32.1.2-win32-ia32.zip'
$checksum = '72cf49d2d54c474df4322c37ac2c1cee05db8e2cfd5066735bb9395271a05b6b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.1.2/electron-v32.1.2-win32-x64.zip'
$checksum64 = '02dadb152d508ba7ac4371ac84d9e1166cc96a63567022df155b4f1859707b8e'
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
