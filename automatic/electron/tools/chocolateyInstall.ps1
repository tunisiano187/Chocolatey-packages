$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v19.0.10/electron-v19.0.10-win32-ia32.zip'
$checksum = '1af970bdd08e82a65a458f2d94df9e4745c6c1bc968f97b2499a61302aae7ec2'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v19.0.10/electron-v19.0.10-win32-x64.zip'
$checksum64 = '443d45e91eadef89f7f1a30d70a05a7d6befcaba6c522df56a8db55fdc085c8c'
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
