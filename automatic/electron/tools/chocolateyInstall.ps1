$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.2.1/electron-v41.2.1-win32-ia32.zip'
$checksum = '3aad0f1c27a45a63b8724f6f9f5865bde25aa949414a18a35e50d5dfca153cc9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.2.1/electron-v41.2.1-win32-x64.zip'
$checksum64 = 'b44d951f36dfc785cd04bf7bbb342672df365a62ef3c966073eb46e5838c13dd'
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
