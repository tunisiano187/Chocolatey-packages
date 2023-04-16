$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.1.2/electron-v24.1.2-win32-ia32.zip'
$checksum = 'bdd78e0ed4c4e06de022e4837bfeff41dd6b59b176592f6fa70974ef72967ac3'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.1.2/electron-v24.1.2-win32-x64.zip'
$checksum64 = 'd1e83b41d41fe34bfe8ef472510a3c16f63b560783f8daeae4ab5b791b18e6e4'
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
