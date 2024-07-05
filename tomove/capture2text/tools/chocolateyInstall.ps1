$packageName    = $env:ChocolateyPackageName
$url            = 'https://sourceforge.net/projects/capture2text/files/Capture2Text/Capture2Text_v4.6.3/Capture2Text_v4.6.3_32bit.zip/download'
$checksum       = '789f2d29f855cfc4533fea71c8dc5ce7dfd58c26e16b83159f77385b8d8f8afe'
$checksumType   = 'sha256'
$url64          = 'https://sourceforge.net/projects/capture2text/files/Capture2Text/Capture2Text_v4.6.3/Capture2Text_v4.6.3_64bit.zip/download'
$checksum64     = 'd33847064c4edf726c61b35f3b753470546be671561cdb35fba85dfd1ad170fa'
$checksumType64 = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
