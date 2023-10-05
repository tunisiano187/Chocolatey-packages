$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.3.0/electron-v26.3.0-win32-ia32.zip'
$checksum = 'bea06b40937cace5ce5c11158ba4701fb656bd04aa007ccc4b8714f1dd124bd6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.3.0/electron-v26.3.0-win32-x64.zip'
$checksum64 = 'e9b25f0a08b30601edbb8f4db1b441707bbf53490ab068729ba0a46c260c78c6'
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
