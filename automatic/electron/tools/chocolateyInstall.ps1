$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.2.0/electron-v31.2.0-win32-ia32.zip'
$checksum = 'ff8a16bf76e9627fd7bc75a3093148e1d3e80f6f6f7e4f0eebc0b3190d37e3e9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.2.0/electron-v31.2.0-win32-x64.zip'
$checksum64 = '148f4afbbe4007a6915018aa792cf6d787277ac52cb8b828a2559efe51baee2c'
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
