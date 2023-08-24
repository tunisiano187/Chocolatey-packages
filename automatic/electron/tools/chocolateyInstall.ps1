$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v26.1.0/electron-v26.1.0-win32-ia32.zip'
$checksum = '00ab472aa95fc40a80f5bdea4006363c2996e2cc537f66dcffec1667b93529db'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v26.1.0/electron-v26.1.0-win32-x64.zip'
$checksum64 = '7cbbe8673f184bf3c718194c83189b23d50d268abe9b7a96af4093fb2856252b'
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
