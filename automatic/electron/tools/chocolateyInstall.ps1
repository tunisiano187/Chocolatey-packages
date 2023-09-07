$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.2.0/electron-v26.2.0-win32-ia32.zip'
$checksum = '9022c589d05e1431ca1727a73bdab450e9071d5e933dbd86106c5c9ffa9acb6d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.2.0/electron-v26.2.0-win32-x64.zip'
$checksum64 = 'bee71e4fe599db6f7400f33d3d1b60123ee808867e32dee2134fefd32e135fbf'
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
