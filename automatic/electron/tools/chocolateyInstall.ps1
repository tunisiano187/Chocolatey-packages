$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.3.3/electron-v42.3.3-win32-ia32.zip'
$checksum = '00bf2518345e71e009a54af6aa1bd510956e1486adbb296b4ba7bb9b3938b169'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.3.3/electron-v42.3.3-win32-x64.zip'
$checksum64 = 'd204d1aaf76e80db6102c482a2f7cc6d20c6c570e9ac6ac5bfee61155467e6a0'
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
