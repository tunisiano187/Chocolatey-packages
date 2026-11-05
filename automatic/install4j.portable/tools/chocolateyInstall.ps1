$packageName = 'install4j.portable'
$url = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_13_1_2.zip'
$checksum = 'b2409eb6f60c12b1aeeae6f7b2bec7f12cb756f6ba913413e302d04170ed1c9d'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
