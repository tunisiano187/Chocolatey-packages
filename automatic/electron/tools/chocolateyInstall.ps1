$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.0.0/electron-v24.0.0-win32-ia32.zip'
$checksum = 'b4c563b7bceeed5c90e1abc06352c83577078e47d896933888ea4bb25c809853'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.0.0/electron-v24.0.0-win32-x64.zip'
$checksum64 = 'b1ee3d543f4a643ebf525980567edfd39655dff5fd7e08b2c6aeeb216438aa60'
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
