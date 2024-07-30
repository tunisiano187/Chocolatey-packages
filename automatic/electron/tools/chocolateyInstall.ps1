$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.3.1/electron-v31.3.1-win32-ia32.zip'
$checksum = '3842f05363ef64351f2d5d45843152dcc256535e2adfb02337cbb2013786f32c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.3.1/electron-v31.3.1-win32-x64.zip'
$checksum64 = '1fd8cce5617b96f8fa1bbf180e17f4ee54cafe45a9c6188795c2b2c7413b6c9a'
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
