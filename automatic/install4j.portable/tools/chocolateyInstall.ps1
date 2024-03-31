$packageName = 'install4j.portable'
$url = 'https://download-gcdn.ej-technologies.com/install4j/install4j_windows_7_0_11.zip'
$checksum = 'b41dd595f5d38b625dc05424cb842f4a26160cbeab5d2052c1538f7630838fd4'
$checksumType = 'sha256'
$url64 = 'https://download-gcdn.ej-technologies.com/install4j/install4j_windows-x64_7_0_11.zip'
$checksum64 = '075656a84a4c32fc583886db9786c9117001b51ae4c138543f7333a5f37cbdcc'
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