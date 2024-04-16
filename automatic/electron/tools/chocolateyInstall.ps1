$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v30.0.0/electron-v30.0.0-win32-ia32.zip'
$checksum = '17ad6e44b9c44f6cc51db623c19dea888051ee9b5b1de3dbb79199d5a2e0cca6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v30.0.0/electron-v30.0.0-win32-x64.zip'
$checksum64 = '13a51d6a9f023937208334a76ec1888c6ea208925f8404f468acafd50c8ce178'
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
