$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v33.0.0/electron-v33.0.0-win32-ia32.zip'
$checksum = 'd737b3c630b10bc93c69203d108749bfde76b4420ee161c2562de660ca212005'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v33.0.0/electron-v33.0.0-win32-x64.zip'
$checksum64 = '52bbe826b5e9d0dc779321866043d310aa8072d44ef3c05d7cdd3c4a69228fa0'
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
