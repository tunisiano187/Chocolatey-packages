$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v14.0.0/electron-v14.0.0-win32-ia32.zip'
$checksum = 'e2a5f203ca7a3155824891c4d93bcc09621269c62338d561d0fb678b91e7c237'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v14.0.0/electron-v14.0.0-win32-x64.zip'
$checksum64 = 'b558ddb2d9423f1fe5efee58a4a7b32954a71a53462d26e4f4c9e2b115c243bb'
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
