$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.90/unison-v2.51.90+ocaml-4.01.0+x86_64.windows.zip'
$checksum       = '57ad538bd41f52b5e4cefabcb4ade46ef924eab04c447b8d77984955ca43f44f'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
