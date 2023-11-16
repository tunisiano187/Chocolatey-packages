$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.1.0/electron-v27.1.0-win32-ia32.zip'
$checksum = '0e37ed303733cf433530afe767fafecfe04beb9599d1ae71a2ac4afa5692f936'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.1.0/electron-v27.1.0-win32-x64.zip'
$checksum64 = 'badd91e153fbf1491104551c8645db209f5870cc5e99ec141e3de47c26d244b6'
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
