$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.0.3/electron-v11.0.3-win32-ia32.zip'
$checksum = '363deb5a3af12580018ffcf8d3ad13d4fb746a6df40275cd5ae3bbf7c8bf4fc0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.0.3/electron-v11.0.3-win32-x64.zip'
$checksum64 = '1dae1e0609bd489ff9a2f90f8d3f32ec970ebd784998d04061abea04223ce6cb'
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
