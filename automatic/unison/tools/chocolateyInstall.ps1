$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.5/unison-v2.51.5+ocaml-4.01.0+i386.windows.zip'
$checksum       = '1d25270107cf3de3c015882fbc583573f606a228099b1d5b2b2be3226f838cd7'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
