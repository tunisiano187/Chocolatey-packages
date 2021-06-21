$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.4_rc3/unison-v2.51.4_rc3+ocaml-4.05.0+x86_64.windows.zip'
$checksum       = '8409fee696191fc89169279ee828847c3ee6e0a33eb495595ffa0911127eefbb'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
