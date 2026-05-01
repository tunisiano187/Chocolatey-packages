$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.54.0/unison-2.54.0-windows-x86_64.zip'
$checksum       = '8e0c9070824dc7e3f207d54c8afdec1af55ac26af2740d0d5d7b6e00c44d5fab'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
