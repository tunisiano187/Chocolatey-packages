$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.7/electron-v30.0.7-win32-ia32.zip'
$checksum = '7813cd2c8bdc93df46ca955ca5099346404b8db73c56b83a08117a195e7ebc5c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.7/electron-v30.0.7-win32-x64.zip'
$checksum64 = '7233ddc5e5e3f182d5b66dc4096ced8092bfdefe2a5f6e2d3f59dea15fc81711'
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
