$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.1.2/electron-v23.1.2-win32-ia32.zip'
$checksum = '9ec63511754780b9fff80be27e01980b43a08bda7721abbdbcf2a96a945afb57'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.1.2/electron-v23.1.2-win32-x64.zip'
$checksum64 = 'fc5bab259eabb3548e02ffc64d5d6228f31fb628a2a422a8dcb4ded19e6bd30e'
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
