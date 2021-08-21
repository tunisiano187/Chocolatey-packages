$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.4/dogecoin-1.14.4-win32.zip'
$checksum = '0648c5f89bc078ae6b5191156434cb6be7b9b42fee3d42b6e14f8323e17acc93'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.4/dogecoin-1.14.4-win64.zip'
$checksum64 = '499d93f8b97189721981557394f63aafc5ccdc90d51ed4dbd9fa7de7c22e7050'
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
