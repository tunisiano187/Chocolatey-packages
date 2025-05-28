$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.18.4.0.zip'
$checksum = '249a4247688c30ce95e8fb04ff656e97a4f8de83c31c58e7debb28dbcc2d2867'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.18.4.0.zip'
$checksum64 = '00151a96e96ef69eedf117c4900e6d0717ca074a61918cd94a55ed587544406b'
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
