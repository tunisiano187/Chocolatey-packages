$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.0/electron-v19.0.0-win32-ia32.zip'
$checksum = 'd3b6f51219c14d63447e6b15b9756a68457d39a5965223a547508314c468c938'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.0/electron-v19.0.0-win32-x64.zip'
$checksum64 = '27822fe24be76a7d35343758e75452321f28db836015214c5c0974afa36ea108'
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
