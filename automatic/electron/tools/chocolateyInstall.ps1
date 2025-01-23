$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.0.1/electron-v34.0.1-win32-ia32.zip'
$checksum = 'e6a8e9e5a726febdf22a3bff594aea68bf3644fe5d8d20965f8c8a25a44963ab'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.0.1/electron-v34.0.1-win32-x64.zip'
$checksum64 = '12a428d144546053725d810e96a15bb3ddeae4580cd1919d9b3a149afefdaa03'
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
