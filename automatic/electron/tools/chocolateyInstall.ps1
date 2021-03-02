$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.0/electron-v12.0.0-win32-ia32.zip'
$checksum = 'd21e49e02f4709388a7fc4a195716eae451e8cd50ac8f840adea505ed98cae5d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.0/electron-v12.0.0-win32-x64.zip'
$checksum64 = '52b1d6947e7afc3643ea8ed49a6767318eb58184e736220e68d8b4f345dd9077'
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
