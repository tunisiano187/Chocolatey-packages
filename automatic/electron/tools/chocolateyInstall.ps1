$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.2.3/electron-v11.2.3-win32-ia32.zip'
$checksum = '56e661d709c1594dd5cf428c423f5072f8ea9bb233310e2649f52e744373d9c6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.2.3/electron-v11.2.3-win32-x64.zip'
$checksum64 = 'a1d81eff6456d6c0a8ef672ab0ce48127757417e0a33b2646d848812b1c6aa1e'
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
