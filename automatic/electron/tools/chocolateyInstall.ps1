$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.0.1/electron-v42.0.1-win32-ia32.zip'
$checksum = 'fe3b56b030436b06c508ad5a390b4f18f9f42c797c06ced3f9c31c93afadd826'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.0.1/electron-v42.0.1-win32-x64.zip'
$checksum64 = '260351302fe1adac1d85a87ac8d7b3d2a3b0e5b95b051dee5ecf5d4555b86c79'
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
