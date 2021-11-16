$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.0/electron-v16.0.0-win32-ia32.zip'
$checksum = 'f43b39fd1f1f5122a309c224ed708b782c83f19e51cf7f69f64cc6061a84aa3c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.0/electron-v16.0.0-win32-x64.zip'
$checksum64 = 'd4f18892a00ecd3996611afeb8766d860e4983af5fcb214f481c0be802be54ca'
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
