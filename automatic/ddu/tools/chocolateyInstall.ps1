$packageName = 'ddu'
$url = 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.0.2.5.exe'
$checksum = 'd99148f66e5ab91c3cabcde6d8468d9a29cd6ef5f66fd5aaa307e036d9a51567'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

