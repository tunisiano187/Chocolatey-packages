$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.1.0/electron-v25.1.0-win32-ia32.zip'
$checksum = 'afddaca61f3774e00cd1b67cbee462128ef0412cc30f8237c6886a005595d888'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.1.0/electron-v25.1.0-win32-x64.zip'
$checksum64 = '96b309e1711745da1405e6ebc584d647761e9ff6013dfbd93d639af671632df7'
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
