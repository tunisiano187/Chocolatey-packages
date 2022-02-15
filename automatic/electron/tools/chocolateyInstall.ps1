$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.0.1/electron-v17.0.1-win32-ia32.zip'
$checksum = '5d01dfa99297329af0b3e4f6a48f4d7c0173f361ec159afac294a167570996d7'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.0.1/electron-v17.0.1-win32-x64.zip'
$checksum64 = '90773bf57922fbb2a2d5b9e0c8d6088c9447ac870967120c288b846ed1d8e403'
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
