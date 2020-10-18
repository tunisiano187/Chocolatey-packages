$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.3_rc3/unison-v2.51.3_rc3+ocaml-4.05.0+x86_64.windows.zip'
$checksum       = '7956c4b50006d6555bd1d44a63a27899b375aa09b22a2d40026abe08db3fb94f'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
