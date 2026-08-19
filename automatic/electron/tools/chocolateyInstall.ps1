$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.4.1/electron-v43.4.1-win32-ia32.zip'
$checksum = '22cc6a2ff1dc7dd1693227e9ca9845c8ec6700a6c93309575810fa839bc822c0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.4.1/electron-v43.4.1-win32-x64.zip'
$checksum64 = 'c2ef9a5f65472c34d14bd3e67b7d14e66b0c01f124aba45263d6a4232160e13a'
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
