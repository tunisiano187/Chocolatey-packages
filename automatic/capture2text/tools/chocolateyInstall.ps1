$packageName = 'capture2text'
$urlArray = @('https://sourceforge.net/projects/capture2text/files/Capture2Text/Capture2Text_v4.6.1/Capture2Text_v4.6.1_32bit.zip/download', 'https://sourceforge.net/projects/capture2text/files/Capture2Text/Capture2Text_v4.6.1/Capture2Text_v4.6.1_64bit.zip/download')
$url = $urlArray[0]
$checksum = '20b8713a452c2e974d0851fd9934da99a072b051dd157932698d739d85bb0268'
$checksumType = 'sha256'
$url64 = $urlArray[1]
$checksum64 = 'ac0d3ca8ac1bff23875f9752c13787eae0fda5c60828ef420eee1c500119d65a'
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