$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.6.1/electron-v40.6.1-win32-ia32.zip'
$checksum = 'a37a6041977b43d095eed202fd8be98732713154904de3fd532ab4789df579ac'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.6.1/electron-v40.6.1-win32-x64.zip'
$checksum64 = '236d75251b430ee7a56e8d85ffd6c343e6c7f3db217c3fbd86e6a773e24e78fa'
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
