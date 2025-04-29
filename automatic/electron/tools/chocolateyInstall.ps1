$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.0.0/electron-v36.0.0-win32-ia32.zip'
$checksum = '819b39226ea7219203cb1803f7574cb2a99fc30ef6978348be4390fde0c19775'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.0.0/electron-v36.0.0-win32-x64.zip'
$checksum64 = '3690467f4cb67752cdad90962bb3bee252dafcbfb12834d853e36d97117cd5b2'
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
