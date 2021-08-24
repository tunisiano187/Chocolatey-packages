$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.2.2/electron-v13.2.2-win32-ia32.zip'
$checksum = 'a34e8e58f4085d23a2772a3451e8edf6b4291dc275d7c090de5abeb300c2ec72'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.2.2/electron-v13.2.2-win32-x64.zip'
$checksum64 = '4a8e25b66390e9314930bcbeff2045af49aef7bfd6da6700b1165b4c2b3e62d4'
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
