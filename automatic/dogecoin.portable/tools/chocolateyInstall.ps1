$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.2/dogecoin-1.14.2-win32.zip'
$checksum = '4851613ca6677030acd1a85afce5c7544f3fdc000fd4be219afc570de1e32bc6'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.2/dogecoin-1.14.2-win64.zip'
$checksum64 = '24a901bfb3a0f479dfc94e98dd8d30603c7b8300a46488f9bfcbc1370af6beda'
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
