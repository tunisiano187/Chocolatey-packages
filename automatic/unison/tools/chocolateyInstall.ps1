$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.4_rc2/unison-v2.51.4_rc2+ocaml-4.05.0+x86_64.windows.zip'
$checksum       = 'c652cdad093a4c476ea1ec54491ac1f9e7e8037ee0b6a434469c1853fde2b2d3'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
