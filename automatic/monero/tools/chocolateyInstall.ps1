$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.18.2.0.zip'
$checksum = 'dac24fa46581987041ea3e9d89d745c643afab23a6d74385cdddd1231fe92514'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.18.2.0.zip'
$checksum64 = '112c0647baaa5c7e42f8b121ad633222f608200f9a402dbf2b5cd6b95ee555cd'
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
