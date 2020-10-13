$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.3_rc2/unison-v2.51.3_rc2+ocaml-4.05.0.windows.zip'
$checksum       = 'e95ef9bf69fe33819e2e01caa8bf07b3563834dac18e32a5072d4f5d367f9308'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
