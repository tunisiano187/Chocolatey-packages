$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.3.2/electron-v42.3.2-win32-ia32.zip'
$checksum = '4c97b3655947c4cde33c26bdfe7b8c3a1db08ec5a4eb42e11de4868e662c8559'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.3.2/electron-v42.3.2-win32-x64.zip'
$checksum64 = 'e7b9162870a4a35c8377cc459b292c9e10503067132d8399245008110970a8ef'
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
