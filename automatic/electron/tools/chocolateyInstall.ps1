$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v40.4.1/electron-v40.4.1-win32-ia32.zip'
$checksum = 'f71303567f6ceb1e5bac051660c32c12475b5452de7088cf7b0332449415acec'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v40.4.1/electron-v40.4.1-win32-x64.zip'
$checksum64 = '19ecb4cbfad11276ca65fe6a5d911d2d5f9fadc29608af015c164ead13380354'
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
