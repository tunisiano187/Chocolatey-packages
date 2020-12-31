$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.17.1.8.zip'
$checksum = '4bd0c594c59de2815e91e7560be5b52370abb351f425c2ea1434a0ae4205c30a'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.17.1.8.zip'
$checksum64 = '55bafa33142b2aa979e5f6b4a6ddb60584bc9e9434e3a8c0a7fd8c9852bbcd7e'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
