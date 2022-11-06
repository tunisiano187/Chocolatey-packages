$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.52.1/unison-v2.52.1+ocaml-4.01.0+x86_64.windows.zip'
$checksum       = 'c758219dea87448dd88a56046bbfcf4d47404d481bd4c66e9ae829a31e428409'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
