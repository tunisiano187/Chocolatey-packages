$ErrorActionPreference = 'Stop'
$packageName = '$env:ChocolateyPackageName'
$url = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.7/dogecoin-1.14.7-win32.zip'
$checksum = 'd870d08ea59a6f40b3f2a03048bcdcfc4150896430ffade1bc466925dda93737'
$checksumType = 'sha256'
$url64 = 'https://github.com/dogecoin/dogecoin/releases/download/v1.14.7/dogecoin-1.14.7-win64.zip'
$checksum64 = '8475ba266761e830f2a270c542b5513a3e33892951e8d31318ca3b48cf5465f1'
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
