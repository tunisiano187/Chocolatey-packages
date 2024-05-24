$packageName = 'install4j.portable'
$url = 'https://download.ej-technologies.com/install4j/install4j_windows-x64_10_0_8.zip'
$checksum = '1cdad35bd773a75c1cae2b0488f6b1d11207e8b73216b23f32409805437530ce'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
