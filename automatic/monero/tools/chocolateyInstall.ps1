$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.17.2.0.zip'
$checksum = 'c772070ebdfe9e0d6abda5073808e648e69f8c35f8010e66b80f45a6bdb01792'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.17.2.0.zip'
$checksum64 = '71e531a0f799c80e3f6319888bd5b85a737091b9bd5d66366cae036163857caf'
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
