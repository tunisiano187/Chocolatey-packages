$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.0.0/electron-v35.0.0-win32-ia32.zip'
$checksum = 'e3d0b52a689082d79d826419649d27106f5b69686267a05498fa27a4fbd56839'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.0.0/electron-v35.0.0-win32-x64.zip'
$checksum64 = '21a8bb4770247234c82df934a90f9913d558fae0539a3217896ccfd4f316c2ed'
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
