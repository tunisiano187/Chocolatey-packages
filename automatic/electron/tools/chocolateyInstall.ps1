$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.2/electron-v22.0.2-win32-ia32.zip'
$checksum = 'd8273b88ac65059fb259dcc8295f4cf4568726fb6d6f0a4030e1203fdc21992b'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.2/electron-v22.0.2-win32-x64.zip'
$checksum64 = 'a1e5c47bf58ab502d06b87dbd534f97b03552652e8f67c6effada7fef8102804'
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
