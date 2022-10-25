$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.8/electron-v22.0.0-alpha.8-win32-ia32.zip'
$checksum = 'e6ef39cc4104ca9d64155868eeeb2342d11166d49987366ea72ded91bce3d9d6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v22.0.0-alpha.8/electron-v22.0.0-alpha.8-win32-x64.zip'
$checksum64 = '1f1ac20d42578ad1a325a7b7cc162c4f57b5abba84b07ceb798450a1f2312dd7'
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
