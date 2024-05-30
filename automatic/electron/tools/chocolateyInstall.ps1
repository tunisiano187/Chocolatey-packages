$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.9/electron-v30.0.9-win32-ia32.zip'
$checksum = '98f5e84a2f2d60d00cffd337fb5cceb90be3bbe005127cf900207e0a27a5ae5c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.9/electron-v30.0.9-win32-x64.zip'
$checksum64 = 'c7af68cc73d4a3d5d706f014146d64c80a5928ed9b9e6b2ee2a683c7627c3548'
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
