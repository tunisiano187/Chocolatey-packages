$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://archive.mozilla.org/pub/opus/win32/opus-tools-0.2-win32.zip'
$checksum = '99a7c07c46c24727d9798adfc53f5d1d82244e3c249476c22ddf0e1d76a7c86c'
$checksumType = 'sha256'
$url64 = 'https://archive.mozilla.org/pub/opus/win64/opus-tools-0.2-win64.zip'
$checksum64 = '84e643f1cc3fd26fc743ea7830392de765507f72846e24719804d3d07f1ad96f'
$checksumType64 = 'sha256'

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -url64bit "$url64" `
                             -checksum64 "$checksum64" ´
                             -checksum64 "$checksumType64"
