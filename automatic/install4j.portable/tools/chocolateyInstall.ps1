$packageName = 'install4j.portable'
$url = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_12_0_1.zip'
$checksum = '2d8abda60e4c8803a6c1bdc1a7837e24b4db2e9b218c1e2ebf27450f9f519b03'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
