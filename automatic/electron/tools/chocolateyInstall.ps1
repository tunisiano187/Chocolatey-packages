$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.1.1/electron-v28.1.1-win32-ia32.zip'
$checksum = '30be42688368f4edde4728ac6227fb5c916c0fac7f4413d02407e020510dffc6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.1.1/electron-v28.1.1-win32-x64.zip'
$checksum64 = '3e087d90898946ca79d6c969d6940e518661aa6e33ea2cf641bd0fc4c0c9e238'
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
