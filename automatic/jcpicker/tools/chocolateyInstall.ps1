$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$url            = 'https://annystudio.com/jcpicker.zip'
$checksum       = '550c423d8deaf4b64f41485a2d5cd26b293b78a330fd830974aaf7f5b66e27b1'
$checksumType   = 'sha256'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

