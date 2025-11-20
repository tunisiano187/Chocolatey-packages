$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.3/electron-v39.2.3-win32-ia32.zip'
$checksum = '6668fadbdd0283225f4bc60c711f8cd8ac316f43f486cd8a1f62a6a35f89cf7a'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.3/electron-v39.2.3-win32-x64.zip'
$checksum64 = 'd4365ad128bbdcb3df99dc4a0ad9de85c5e920903070a473b55377253b6c3fdd'
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
