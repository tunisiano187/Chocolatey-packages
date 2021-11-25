$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.2/electron-v16.0.2-win32-ia32.zip'
$checksum = '538ff783d08a17d686907f49e7998cfe875cd33717a22fef1bfa3f798babfb01'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.2/electron-v16.0.2-win32-x64.zip'
$checksum64 = 'c50020c610bdf5a2c0b9baf2a4036d20abd520fee9e7d064aa93971306fa90b8'
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
