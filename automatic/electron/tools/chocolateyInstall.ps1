$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.4.1/electron-v42.4.1-win32-ia32.zip'
$checksum = '7bba1a5ad663d97ba6d5302a8ef3706df9f7f06c049d21b9e664d279c2f9ff11'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.4.1/electron-v42.4.1-win32-x64.zip'
$checksum64 = '7e654383cb5794dada5d590b68016d485342212e6a56bcd66c1fc804c57f9c8b'
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
