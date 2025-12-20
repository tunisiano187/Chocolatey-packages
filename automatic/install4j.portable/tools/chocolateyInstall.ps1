$packageName = 'install4j.portable'
$url = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_12_0_2.zip'
$checksum = 'e0833cfb4a71d1cda1c56b237b2ff1b59237557805019eb97d8f9b5aa820dedd'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
