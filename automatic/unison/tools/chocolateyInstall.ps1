$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.52.0/unison-v2.52.0+ocaml-4.01.0+x86_64.windows.zip'
$checksum       = '5cef0cb2e6e948065d976f4fec54d42f46bfc8939e7ca2b0e2fcffd4c2848756'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
