$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/bcpierce00/unison/releases/download/v2.51.4_rc1/unison-v2.51.4_rc1+ocaml-4.05.0+x86_64.windows.zip'
$checksum       = 'b0ef33c232ef31d39bd8729d79efd28d5712411c28a424a94d82ae1887ecfc3e'
$checksumType   = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
