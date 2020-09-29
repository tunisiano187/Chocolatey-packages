$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.1.3/electron-v10.1.3-win32-ia32.zip'
$checksum = 'c83fbcd49f640eff82628e4d021f8e3def169b0be0db76398295157651598dde'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.1.3/electron-v10.1.3-win32-x64.zip'
$checksum64 = '1c31101ac9aa0130ba2f248953258e6f40343df6748fb880c8d1a79adfcb3811'
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
