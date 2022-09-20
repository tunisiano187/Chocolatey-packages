$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://downloads.getmonero.org/cli/monero-win-x86-v0.18.1.1.zip'
$checksum = 'bae1688502882cdfc293cff55460b38a1906ce41416628c6d9b6a38120de6fb4'
$checksumType = 'sha256'
$url64 = 'https://downloads.getmonero.org/cli/monero-win-x64-v0.18.1.1.zip'
$checksum64 = '14eb0d7111b478a0adcde2254dabb8612a8f0b21f0dc3d5d673d851fd7039094'
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
