$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.3/dogecoin-1.14.3-win32.zip'
$checksum = '06eef064cfe136afda87d452aa40742c8eb36f88d2e52872f186232c974b9c90'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.3/dogecoin-1.14.3-win64.zip'
$checksum64 = '55cad1ec60a594aa9e448047de87a2b39ef415dc2f0a635b34a352351e656316'
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
