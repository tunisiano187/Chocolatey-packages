$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.1.3/electron-v23.1.3-win32-ia32.zip'
$checksum = 'cc30372f94594718fb03042972c2cd6925a397053956e6dd88a682472a8a5798'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.1.3/electron-v23.1.3-win32-x64.zip'
$checksum64 = '384b908353715674058b7f25a24f942a7ecf7e651ab4c1ca45376e75f5b1e0ea'
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
