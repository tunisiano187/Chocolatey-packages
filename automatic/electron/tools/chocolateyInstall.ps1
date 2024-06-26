$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v31.1.0/electron-v31.1.0-win32-ia32.zip'
$checksum = '9ddc3b9bcc9d16ed801ffe38b1201cf4010ff242ce613ded75f59bf1e9e6fefd'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v31.1.0/electron-v31.1.0-win32-x64.zip'
$checksum64 = '6b232d8cd2997812b17ee9cf8d962d10347e3b7be95bc669ec16ea06b44aaf47'
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
