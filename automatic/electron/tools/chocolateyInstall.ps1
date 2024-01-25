$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.2.0/electron-v28.2.0-win32-ia32.zip'
$checksum = 'dfb8c84a3ab23769b61ff7bda1e9d27406dde999b7527b4e40f63f81d7032a59'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.2.0/electron-v28.2.0-win32-x64.zip'
$checksum64 = '8aae0a7e587d27d9a14a649d99292654e1c47e4ea73779a6ab1e72de9ccf581d'
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
