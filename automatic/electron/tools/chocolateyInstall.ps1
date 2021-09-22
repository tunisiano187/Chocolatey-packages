$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v15.0.0/electron-v15.0.0-win32-ia32.zip'
$checksum = '5b69112b91010d78abf6012f387ea3fe5c0e36657c5f386a4c2bb42138aa1a8e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v15.0.0/electron-v15.0.0-win32-x64.zip'
$checksum64 = '3d95422d9f2fccb07b745b31007548231d80ff63e3640f49a5f8591498a3afa2'
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
