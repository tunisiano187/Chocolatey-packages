$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.71/unison-v2.51.71+ocaml-4.08.1+x86_64.windows.zip'
$checksum       = '540b33b450067e7f07baeb8087a8278d0b1e5aea047fc4f40a80e8a6a1a91945'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
