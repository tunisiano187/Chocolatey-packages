$packageName = 'monero'
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.16.0.0.zip'
$checksum = 'b1fc293dd9c12f90c7c343777298e86a22f25788561629b92ec0b23eb6cfb42c'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.16.0.0.zip'
$checksum64 = 'f2750efb65b70ae9cad64d977cb0bfbe4dc6d014fe0b7fd565002282d67d469d'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
