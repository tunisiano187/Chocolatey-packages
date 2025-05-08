$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.2.0/electron-v36.2.0-win32-ia32.zip'
$checksum = 'c2f1e68e1875cc08b0bcc97725690de82e4f6afcd9acce413f9c79012df584ac'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.2.0/electron-v36.2.0-win32-x64.zip'
$checksum64 = '999560f9b4f9607b1060412550d327638fe0e6a480827f3dc046129e8ec62b9f'
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
