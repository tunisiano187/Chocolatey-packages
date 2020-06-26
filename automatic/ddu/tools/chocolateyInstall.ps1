$packageName = 'ddu'
$url = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.2.5.exe'
$checksum = ''
$checksumType = ''
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

