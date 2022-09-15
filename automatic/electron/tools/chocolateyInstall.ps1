$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.1.4/electron-v20.1.4-win32-ia32.zip'
$checksum = 'ef103a91d583e21785c5f2a4e4aeaf303fb075ece07e6bb8650a68d32ae9cf07'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.1.4/electron-v20.1.4-win32-x64.zip'
$checksum64 = '8f0ff9de87a2e87a21a3b0180e4f416543a934687eea65a14935de44865900a3'
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
