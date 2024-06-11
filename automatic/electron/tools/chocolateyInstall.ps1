$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.0.0/electron-v31.0.0-win32-ia32.zip'
$checksum = 'a4f94dbf262a63d2f750ec76ef0ae6210be4d3175db105ada422d757c3d1b447'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.0.0/electron-v31.0.0-win32-x64.zip'
$checksum64 = 'bfec79789a18c2794ff77c04db287dcc04b2bc913c694297b38dc4202eaa9206'
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
