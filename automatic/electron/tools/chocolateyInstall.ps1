$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v17.2.0/electron-v17.2.0-win32-ia32.zip'
$checksum = '7216d0ae35c95fcdd488c720909d2320480288ef02d3f95bcb574c9ef38169b8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v17.2.0/electron-v17.2.0-win32-x64.zip'
$checksum64 = '64451d98e574d8f78754aeb73258814b4fd1a9ef4266bae5e53cdd09273a0b23'
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
