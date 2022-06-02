$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.2/electron-v19.0.2-win32-ia32.zip'
$checksum = '2cb32ec1745ecebf9cbc105dc0945478a973262548e376695b0ee0d78c51a771'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.2/electron-v19.0.2-win32-x64.zip'
$checksum64 = '062bc3d9002f431a3bcd898191e4bf647dd03373f327d0eb93437961d8d898f1'
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
