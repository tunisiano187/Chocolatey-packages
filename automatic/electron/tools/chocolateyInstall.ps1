$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v9.2.1/electron-v9.2.1-win32-ia32.zip'
$checksum = 'c2818856c9ba5a50d52aaa0387ca68582aa0d074b991f069e077a7c4342ffeaf'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v9.2.1/electron-v9.2.1-win32-x64.zip'
$checksum64 = '28323b46eb97e4ea090b28fb1a4095abeaa5f6066f471be8d8ffa10dd39d46ac'
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
