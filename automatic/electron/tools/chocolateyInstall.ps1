$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.6/electron-v12.0.6-win32-ia32.zip'
$checksum = 'c4822adc99e62cd85d5da5c9c40e68f9b25bad6f367886913977f3f5ac35a8e3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.6/electron-v12.0.6-win32-x64.zip'
$checksum64 = 'd7535e599c98ab429f1da11014a5b7952ed88fb2239f840083ca3526b1b04e1e'
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
