$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.0.0/electron-v37.0.0-win32-ia32.zip'
$checksum = '7e4798bf737187ef08c9db12ba3f0a27977cf2a65e791600a541c825a7df63cf'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.0.0/electron-v37.0.0-win32-x64.zip'
$checksum64 = 'bc5247b07c94362fc99a51d14cebb9f2d30dda962e2b7591ec58e633ddd5f484'
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
