$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.4/electron-v39.2.4-win32-ia32.zip'
$checksum = 'e5fe372ac82bdabbf6f12139e4fd47da50202e144ca7b5784ef8714ccab2660e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.4/electron-v39.2.4-win32-x64.zip'
$checksum64 = '07a68ab7d18f4367c627aac22a8d436ed92fa9491ebe26d3d71a1bbdfb67473a'
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
