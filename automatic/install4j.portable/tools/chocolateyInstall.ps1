$packageName = 'install4j.portable'
$url = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_10_0_7.zip'
$checksum = 'd8b0f2053ddd4a4add918ffd19192fa8eb92d2379d4a3309d7b1b223f5adbeb0'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
