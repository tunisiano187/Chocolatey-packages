$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-win32.zip'
$checksum = 'c919fdc966764ec554273791699426448eedd8d305e76284e4f1cd1d5f0b5a7a'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.6/dogecoin-1.14.6-win64.zip'
$checksum64 = '709490ac8464b015266884831a2b5b594efc8b2c17a7e6b85255058cbee049de'
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
