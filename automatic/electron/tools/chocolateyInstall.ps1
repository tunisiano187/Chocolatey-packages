$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.0.4/electron-v41.0.4-win32-ia32.zip'
$checksum = '8c3a7ac4d0e889b9b46c32b22825dbd8b5bcfda7098abcf01097a05533e880a3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.0.4/electron-v41.0.4-win32-x64.zip'
$checksum64 = 'e9e63b7bea7b13ede837de250084ee63c52ce36dfd72426cdf8e2280941c46a4'
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
