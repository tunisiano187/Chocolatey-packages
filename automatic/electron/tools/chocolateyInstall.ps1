$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.0.0/electron-v25.0.0-win32-ia32.zip'
$checksum = '5c012c5dd2da1835bb39a173db88848908a38e4cf8e15c166a03055166a0f77e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.0.0/electron-v25.0.0-win32-x64.zip'
$checksum64 = '1db2ef619d9480579aa200447a6d70640b15d59a93a180922a4f35d1e2615a2c'
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
