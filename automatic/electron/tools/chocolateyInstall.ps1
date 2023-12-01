$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.1.3/electron-v27.1.3-win32-ia32.zip'
$checksum = 'c06c9ee185276e56dfb62ca7ea742f8442b8d573b430bb9d6ce03024fe4be670'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.1.3/electron-v27.1.3-win32-x64.zip'
$checksum64 = 'ed04476baf0d1c363f91c6cc457e448eaee2efd2464449f5bd1b3ec94f5a6b81'
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
