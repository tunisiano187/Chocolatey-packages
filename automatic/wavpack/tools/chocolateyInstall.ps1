$packageName    = 'wavpack'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/dbry/WavPack/releases/download/5.8.1/wavpack-5.8.0-x86.zip'
$checksum       = 'e78588e3f49a7b619bf1bc6cb86efd58094398614c707f82102b76c5c21d8cb6'
$checksumType   = 'sha256'
$url64          = 'https://github.com/dbry/WavPack/releases/download/5.8.1/wavpack-5.8.0-x64.zip'
$checksum64     = 'bbb29d1478dfaab80a6ea868deb575a82414c5d79cbec91cdc1044c358945168'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Url64bit "$url64" `
                             -Checksum64 "$checksum64"`
                             -ChecksumType64 "$checksumType"
