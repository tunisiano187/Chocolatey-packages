$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v15.3.1/electron-v15.3.1-win32-ia32.zip'
$checksum = 'c1e8a5569ec090ecef7049381756ad2f2faa0c812b16f58e90f6c9fb3982e1b0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v15.3.1/electron-v15.3.1-win32-x64.zip'
$checksum64 = 'd93ec2e8029ad05ceaf5de01c0891aa272d8a77d473aeda701bef0b34b15886e'
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
