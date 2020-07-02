$packageName = $env:ChocolateyPackageName
$url = 'https://www.wagnardsoft.com/DDU/download/DDU%20V18.0.2.6.exe'
$checksum = '4ed5dcc5f32385c3245982b9cde98e1d42651c1e6e7d1f566dc13f5212ab7fb4'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

