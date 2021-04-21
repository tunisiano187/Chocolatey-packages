$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.5/electron-v12.0.5-win32-ia32.zip'
$checksum = '48b9d453dbd232992c7425055a7877c3d604ef8c20b4a96327de6b5b4fb73fea'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.5/electron-v12.0.5-win32-x64.zip'
$checksum64 = '78f69628bce1efe79da254f2027495492c93bf4ea0d5ceeba5b758958ab60f7c'
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
