$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://archive.mozilla.org/pub/opus/win32/opus-tools-0.2-win32.zip'
$checksum = '99a7c07c46c24727d9798adfc53f5d1d82244e3c249476c22ddf0e1d76a7c86c'
$checksumType = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"
