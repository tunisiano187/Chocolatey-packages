$packageName = 'install4j.portable'
$url = 'https://download-gcdn.ej-technologies.com/install4j/install4j_windows_7_0_11.zip'
$checksum = 'b41dd595f5d38b625dc05424cb842f4a26160cbeab5d2052c1538f7630838fd4'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"