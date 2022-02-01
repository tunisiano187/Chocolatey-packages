$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.5/dogecoin-1.14.5-win32.zip'
$checksum = 'f83994d7d68cc86d728f8aa021a221e6f71a5134ee0619db549ef6d9c13f18b7'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.5/dogecoin-1.14.5-win64.zip'
$checksum64 = 'd66906cb5c5b132ca7e126734c074345f1655a4f72205ed7c0bf028dbff41120'
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
