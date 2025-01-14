$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.0.0/electron-v34.0.0-win32-ia32.zip'
$checksum = '82b6f03aad1d80aa5635487539d427eaeff89c6d61499f8f1724d430d91f60a1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.0.0/electron-v34.0.0-win32-x64.zip'
$checksum64 = 'b99423f1fbf4a447303f8bcb35b64d28fd33034663ca8a3770838360eb6bd450'
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
