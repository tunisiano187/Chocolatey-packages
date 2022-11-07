$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.53.0/unison-v2.53.0%2Bocaml-4.14.0%2Bx86_64.windows.zip'
$checksum       = '499b797d11b1b029db1761db819a85c4274be982fb8edddd2289f5fd630402de'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
